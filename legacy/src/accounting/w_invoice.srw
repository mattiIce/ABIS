$PBExportHeader$w_invoice.srw
$PBExportComments$input invoice number
forward
global type w_invoice from w_sheet
end type
type em_date from editmask within w_invoice
end type
type st_2 from statictext within w_invoice
end type
type cb_save from u_cb within w_invoice
end type
type st_1 from statictext within w_invoice
end type
type sle_invoice from singlelineedit within w_invoice
end type
type cb_print from u_cb within w_invoice
end type
type cb_open from u_cb within w_invoice
end type
type em_job from editmask within w_invoice
end type
type cb_close from u_cb within w_invoice
end type
type dw_report from u_dw within w_invoice
end type
type gb_job from groupbox within w_invoice
end type
type gb_i from groupbox within w_invoice
end type
end forward

global type w_invoice from w_sheet
string tag = "ABCO Invoice input screen"
integer x = 4
integer y = 3
integer width = 3152
integer height = 2058
string title = "Accounting - Invoice"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type long ue_open ( )
event type long ue_display_doc_info ( long al_job )
em_date em_date
st_2 st_2
cb_save cb_save
st_1 st_1
sle_invoice sle_invoice
cb_print cb_print
cb_open cb_open
em_job em_job
cb_close cb_close
dw_report dw_report
gb_job gb_job
gb_i gb_i
end type
global w_invoice w_invoice

type variables
Long il_job
Long il_user
end variables

forward prototypes
public function string wf_get_partial_and_wh (long al_job)
public subroutine wf_set_values (long al_job)
public function long wf_rejected_coil_wt (long al_coil_num)
end prototypes

event type string ue_whoami();RETURN "w_invoice"
end event

event type long ue_open();Long ll_job, ll_exist
String ls_login

ll_job = Long(em_job.Text)
ll_exist = 0

CONNECT USING SQLCA;
SELECT Count(ab_job_num) INTO :ll_exist
FROM ab_job
WHERE ab_job_num = :ll_job
USING SQLCA;
IF ll_exist = 0 OR IsNULL(ll_exist) THEN
	il_job = 0
	MessageBox("Warning", "Job " + em_job.Text + " does not exist.", StopSign!)
	RETURN 0
ELSE
	ls_login = gnv_app.of_GetUserId()
	il_user = 0

	CONNECT USING SQLCA;
	SELECT user_id INTO :il_user
	FROM security_user
	WHERE login_id = :ls_login
	USING SQLCA;

	IF il_user < 1 THEN 
		MessageBox("Warning", "Invalid user account", StopSign!)
		RETURN -2
	END IF
	
	il_job = ll_job
	this.Event ue_display_doc_info(il_job)
END IF
RETURN 1
end event

event type long ue_display_doc_info(long al_job);SetPointer(HourGlass!)

String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper, ls_po
Long ll_cust, ll_order, ll_enduser, ll_skid, ll_coil, ll_row
Int li_item, li_status, li_s_status
String ls_alloy, ls_s_status
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#
DataStore lds_s

dw_report.Retrieve(il_job)
ll_row = dw_report.GetRow()
IF ll_row <= 0 THEN 
	MessageBox("Warning", "Error retrieving job details.")
	RETURN ll_row
END IF

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num, job_status INTO :ll_order, :li_item, :li_status
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

SELECT orig_customer_id, enduser_id, orig_customer_po INTO :ll_cust, :ll_enduser, :ls_po
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
SELECT customer_short_name INTO :ls_cust
FROM customer
WHERE customer_id = :ll_cust
USING SQLCA;
IF ll_enduser > 0 THEN
	SELECT customer_short_name INTO :ls_enduser
	FROM customer
	WHERE customer_id = :ll_enduser
	USING SQLCA;
	ls_cust = Upper(ls_cust) + " (End user: " + Trim(ls_enduser) + " )"
END IF
dw_report.SetItem(ll_row, "Enduser", ls_enduser)

SELECT sheet_type, alloy2, temper, order_item_desc, gauge, enduser_part_num  
INTO :ls_shape, :ls_alloy, :ls_temper, :ls_desc, :lr_gauge, :ls_part#
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

IF IsNULL(ls_desc) THEN 
	ls_desc = "  "
ELSE
	ls_desc = Trim(ls_desc)
END IF
IF IsNULL(ls_part#) THEN 
	ls_part# = "  "
ELSE
	ls_part# = Trim(ls_part#)
END IF

//part dimensions should be Width x Length 
dw_report.SetItem(ll_row, "alloy", ls_alloy )
dw_report.SetItem(ll_row, "temper", ls_temper) 
dw_report.SetItem(ll_row, "Gauge", String(lr_gauge, "##.######")) 

ls_spec = ""
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec +  String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
	CASE ELSE
		ls_spec = " "
END CHOOSE	
dw_report.SetItem(ll_row, "sheettype", ls_shape) 
dw_report.SetItem(ll_row, "WidthLength", ls_spec) 

Long ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_t, ll_rejnet, ll_rebandnet, ll_l1, ll_l2, ll_unprocessed_num, ll_unprocessednet

SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
//dw_report.SetItem(ll_row, "coil number", String(ll_l)) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_coilnet
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
dw_report.SetItem(ll_row, "net_wt", ll_coilnet) 

SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;
//dw_report.SetItem(ll_row, "unapplied coil", ll_unprocessed_num) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;
dw_report.SetItem(ll_row, "unapply_wt", ll_unprocessednet) 


DataStore lds_c
lds_c = CREATE datastore  
lds_c.DataObject = "d_rej_reband_coil_list_for_invoice"  
lds_c.SetTransObject (SQLCA)  
lds_c.Retrieve(al_job)

ll_l1 = 0
ll_l2 = 0
ll_rejnet = 0
ll_rebandnet = 0
ll_l = lds_c.RowCount()
IF ll_l > 0 THEN
	FOR ll_t = 1 TO ll_l
		IF lds_c.GetItemNumber(ll_t, "process_coil_process_coil_status") = 3 THEN //rejected
			ll_l1 = ll_l1 + 1
			ll_rejnet = ll_rejnet + wf_rejected_coil_wt(lds_c.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
		ELSE  //reband
			ll_l2 = ll_l2 + 1
			ll_rebandnet = ll_rebandnet + wf_rejected_coil_wt(lds_c.GetItemNumber(ll_t, "process_coil_coil_abc_num"))			
		END IF
	NEXT
END IF

DESTROY lds_c
//dw_report.SetItem(ll_row, "number of rejected coil", String(ll_l1)) 
dw_report.SetItem(ll_row, "rej_wt", ll_rejnet) 
//dw_report.SetItem(ll_row, "number of rebanded coil", String(ll_l2)) 
dw_report.SetItem(ll_row, "reband_wt", ll_rebandnet) 

SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
dw_report.SetItem(ll_row, "skid_num", ll_l) 

SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_sheetnet
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
dw_report.SetItem(ll_row, "processed_wt", ll_sheetnet) 

SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
//dw_report.SetItem(ll_row, "total pieces", String(ll_l)) 


SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
//dw_report.SetItem(ll_row, "number of scrap skid", String(ll_l)) 


SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_scrapnet
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
dw_report.SetItem(ll_row, "total_scrap_wt", ll_scrapnet) 

lds_s = CREATE datastore  
lds_s.DataObject = "d_report_new_skid_num"  
lds_s.SetTransObject (SQLCA)  
lds_s.Retrieve(al_job)
IF lds_s.RowCount() <= 1 THEN
	dw_report.Object.dw_scrap.Visible = FALSE
	IF lds_s.RowCount() = 1 THEN
		li_s_status = lds_s.GetItemNumber(1, "scrap_skid_scrap_type")
		CHOOSE CASE li_s_status
			CASE 1
				ls_s_status = "Rej. Sheet-Mill"
			CASE 2
				ls_s_status = "Accu. Scrap"			
			CASE 3
				ls_s_status = "Others"			
			CASE 4
				ls_s_status = "Trailer"			
			CASE 5
				ls_s_status = "Rej. Sheet-Process"
			CASE 6
				ls_s_status = "Sample"			
			CASE 7
				ls_s_status = "Tote"
			CASE 8
				ls_s_status = "Edge Trim"
		END CHOOSE
		dw_report.SetItem(ll_row, "scrap_status", ls_s_status) 
	END IF	
ELSE
	dw_report.Object.dw_scrap.Visible = TRUE
	dw_report.SetItem(ll_row, "scrap_status", "Multiple") 
END IF

DESTROY lds_s

dw_report.ResetUpdate()

RETURN 1
end event

public function string wf_get_partial_and_wh (long al_job);String ls_s
DataStore lds_p
Long ll_row, ll_i

ls_s = ""

lds_p = CREATE DataStore
lds_p.DataObject = "d_ab_job_process_partial"
lds_p.SetTransObject(SQLCA)
lds_p.Retrieve(al_job)
ll_row = lds_p.RowCount()
IF ll_row > 0 THEN 
	ls_s = "use partial skid "
	FOR ll_i = 1 TO ll_row 
		ls_s = ls_s + " " + String(lds_p.GetItemNumber(ll_i,"sheet_skid_num"))
	NEXT
END IF
DESTROY lds_p

RETURN ls_s
end function

public subroutine wf_set_values (long al_job);String ls_modstring
Long ll_l, ll_coilnet, ll_sheetnet, ll_scrapnet, ll_t, ll_rejnet, ll_l1, ll_l2, ll_unprocessed_num, ll_unprocessednet

CONNECT USING SQLCA;

SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/05
SELECT NVL(COUNT(coil_abc_num),0) INTO :ll_unprocessed_num
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessed_num
ls_modstring = "unproccoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_unprocessednet
FROM process_coil
WHERE ab_job_num = :al_job AND process_coil_status = 2	//for those coil applied but never used in this ab_job
USING SQLCA;

ll_l = ll_unprocessednet
ls_modstring = "unproccoil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
//END Modified by Victor Huang in 04/05

//ll_l1 = tab_production.tabpage_rejcoil.dw_rejcoil_list.RowCount()
//ll_l2 = tab_production.tabpage_reband.dw_rebanded_list.RowCount()
ll_l = ll_l1 + ll_l2
ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		//ll_rejnet = ll_rejnet + wf_rejected_coil_wt(tab_production.tabpage_rejcoil.dw_rejcoil_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		//ll_rejnet = ll_rejnet + wf_rejected_coil_wt(tab_production.tabpage_reband.dw_rebanded_list.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(COUNT(sheet_skid_num),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(COUNT(return_scrap_item_num),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(process_quantity),0) INTO :ll_l
FROM process_coil
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "coil_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_coilnet = ll_l

SELECT NVL(SUM(prod_item_net_wt),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_sheetnet = ll_l

SELECT NVL(SUM(return_item_net_wt),0) INTO :ll_l
FROM return_scrap_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "scrap_net_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_scrapnet = ll_l

SELECT NVL(SUM(prod_item_pieces),0) INTO :ll_l
FROM production_sheet_item
WHERE ab_job_num = :al_job
USING SQLCA;
ls_modstring = "sheet_pc_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(sheet_tare_wt),0) INTO :ll_l
FROM sheet_skid
WHERE ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_sheetnet
ls_modstring = "sheet_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

SELECT NVL(SUM(scrap_tare_wt),0) INTO :ll_l
FROM scrap_skid
WHERE scrap_ab_job_num = :al_job
USING SQLCA;
ll_l = ll_l + ll_scrapnet
ls_modstring = "scrap_tare_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

ll_l = ll_sheetnet + ll_scrapnet + ll_rejnet + ll_unprocessednet - ll_coilnet
ls_modstring = "off_t.Text = ~"" + String(ll_l, "###,###,##0") + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "off_per_t.Text = ~"( " + String((ll_l/ll_coilnet)*100, "#0.###") + "% )~""
dw_report.Modify(ls_modstring) 

//BEGIN Modified by Victor Huang in 04/06
ls_modstring = "processed_t.Text = ~"" + String((ll_coilnet - ll_unprocessednet - ll_rejnet), "###,###,###") + "~""
dw_report.Modify(ls_modstring)
//END Modified by Victor Huang in 04/06
end subroutine

public function long wf_rejected_coil_wt (long al_coil_num);Long ll_wt1, ll_wt2, ll_wt, ll_shift_end_wt

CONNECT USING SQLCA;

SELECT process_quantity, process_end_wt INTO :ll_wt, :ll_shift_end_wt
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (ab_job_num = :il_job)
USING SQLCA;
IF IsNULL(ll_wt) THEN ll_wt = 0

IF IsNULL(ll_shift_end_wt) THEN
	SELECT net_wt_balance INTO :ll_wt1
	FROM coil
	WHERE coil_abc_num = :al_coil_num
	USING SQLCA;
	IF ISNULL(ll_wt1) THEN ll_wt1 = 0
ELSE
	ll_wt1 = ll_shift_end_wt
END IF

SELECT MAX(process_quantity) INTO :ll_wt2
FROM process_coil
WHERE (coil_abc_num = :al_coil_num) AND (process_quantity < :ll_wt)
USING SQLCA;
IF IsNULL(ll_wt2) THEN ll_wt2 = 0

RETURN MAX(ll_wt1, ll_wt2)
end function

on w_invoice.create
int iCurrent
call super::create
this.em_date=create em_date
this.st_2=create st_2
this.cb_save=create cb_save
this.st_1=create st_1
this.sle_invoice=create sle_invoice
this.cb_print=create cb_print
this.cb_open=create cb_open
this.em_job=create em_job
this.cb_close=create cb_close
this.dw_report=create dw_report
this.gb_job=create gb_job
this.gb_i=create gb_i
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_invoice
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_open
this.Control[iCurrent+8]=this.em_job
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_report
this.Control[iCurrent+11]=this.gb_job
this.Control[iCurrent+12]=this.gb_i
end on

on w_invoice.destroy
call super::destroy
destroy(this.em_date)
destroy(this.st_2)
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.sle_invoice)
destroy(this.cb_print)
destroy(this.cb_open)
destroy(this.em_job)
destroy(this.cb_close)
destroy(this.dw_report)
destroy(this.gb_job)
destroy(this.gb_i)
end on

event close;call super::close;f_display_app()
end event

event pfc_print;call super::pfc_print;PrintSetup()

dw_report.print()

return 1

end event

event open;call super::open;il_job = 0
il_user = 0
end event

type em_date from editmask within w_invoice
integer x = 1701
integer y = 150
integer width = 413
integer height = 86
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "MM/DD/YYYY"
end type

event constructor;this.Text = String(Today(),'MM/DD/YYYY')
end event

type st_2 from statictext within w_invoice
integer x = 1126
integer y = 163
integer width = 475
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "DATE:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_save from u_cb within w_invoice
integer x = 2589
integer y = 86
integer width = 453
integer height = 93
integer taborder = 70
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "&Save"
end type

type st_1 from statictext within w_invoice
integer x = 1053
integer y = 74
integer width = 622
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "INVOICE NUMBER:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_invoice from singlelineedit within w_invoice
integer x = 1701
integer y = 58
integer width = 841
integer height = 90
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_print from u_cb within w_invoice
string tag = "Print"
integer x = 1112
integer y = 1862
integer width = 322
integer height = 99
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;RETURN Parent.Event pfc_print()

end event

type cb_open from u_cb within w_invoice
integer x = 574
integer y = 86
integer width = 351
integer height = 93
integer taborder = 20
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "&Open"
end type

event clicked;call super::clicked;il_job = 0
dw_report.Reset()
Parent.Event ue_open()
end event

type em_job from editmask within w_invoice
integer x = 37
integer y = 90
integer width = 530
integer height = 83
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "########"
end type

type cb_close from u_cb within w_invoice
string tag = "Exit"
integer x = 1657
integer y = 1862
integer width = 322
integer height = 99
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type dw_report from u_dw within w_invoice
integer y = 256
integer width = 3116
integer height = 1594
integer taborder = 80
string dataobject = "d_report_invoice_data"
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(sqlca)

end event

event rbuttondown;//override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type gb_job from groupbox within w_invoice
integer width = 969
integer height = 246
integer taborder = 30
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select a job"
end type

type gb_i from groupbox within w_invoice
integer x = 976
integer width = 2139
integer height = 250
integer taborder = 40
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Invoice Information"
end type

