$PBExportHeader$w_production_folder.srw
$PBExportComments$documents for current job
forward
global type w_production_folder from w_sheet
end type
type cb_print from u_cb within w_production_folder
end type
type st_title3 from statictext within w_production_folder
end type
type st_title2 from statictext within w_production_folder
end type
type cb_as from u_cb within w_production_folder
end type
type cb_open from u_cb within w_production_folder
end type
type em_job from editmask within w_production_folder
end type
type st_title1 from statictext within w_production_folder
end type
type tab_doc from tab within w_production_folder
end type
type tabpage_prod from userobject within tab_doc
end type
type lv_prod from u_lvs within tabpage_prod
end type
type tabpage_prod from userobject within tab_doc
lv_prod lv_prod
end type
type tabpage_notes from userobject within tab_doc
end type
type cb_save from u_cb within tabpage_notes
end type
type cb_delete from u_cb within tabpage_notes
end type
type dw_notes from u_dw within tabpage_notes
end type
type cb_add from u_cb within tabpage_notes
end type
type tabpage_notes from userobject within tab_doc
cb_save cb_save
cb_delete cb_delete
dw_notes dw_notes
cb_add cb_add
end type
type tabpage_files from u_tabpg_fileview within tab_doc
end type
type tabpage_files from u_tabpg_fileview within tab_doc
end type
type tabpage_sales from userobject within tab_doc
end type
type lv_sales from u_lvs within tabpage_sales
end type
type st_2 from statictext within tabpage_sales
end type
type st_110_2 from u_st within tabpage_sales
end type
type tabpage_sales from userobject within tab_doc
lv_sales lv_sales
st_2 st_2
st_110_2 st_110_2
end type
type tabpage_material from userobject within tab_doc
end type
type lv_matrial from u_lvs within tabpage_material
end type
type st_1 from statictext within tabpage_material
end type
type tabpage_material from userobject within tab_doc
lv_matrial lv_matrial
st_1 st_1
end type
type tabpage_invoice from userobject within tab_doc
end type
type lv_invoicing from u_lvs within tabpage_invoice
end type
type st_6 from statictext within tabpage_invoice
end type
type tabpage_invoice from userobject within tab_doc
lv_invoicing lv_invoicing
st_6 st_6
end type
type tabpage_ship from userobject within tab_doc
end type
type lv_shipment from u_lvs within tabpage_ship
end type
type st_7 from statictext within tabpage_ship
end type
type tabpage_ship from userobject within tab_doc
lv_shipment lv_shipment
st_7 st_7
end type
type tabpage_template from userobject within tab_doc
end type
type lv_templates from u_lvs within tabpage_template
end type
type st_10 from statictext within tabpage_template
end type
type tabpage_template from userobject within tab_doc
lv_templates lv_templates
st_10 st_10
end type
type tab_doc from tab within w_production_folder
tabpage_prod tabpage_prod
tabpage_notes tabpage_notes
tabpage_files tabpage_files
tabpage_sales tabpage_sales
tabpage_material tabpage_material
tabpage_invoice tabpage_invoice
tabpage_ship tabpage_ship
tabpage_template tabpage_template
end type
type cb_close from u_cb within w_production_folder
end type
type dw_report from u_dw within w_production_folder
end type
type gb_job from groupbox within w_production_folder
end type
end forward

global type w_production_folder from w_sheet
string tag = "ABCO production document management"
integer x = 4
integer y = 3
integer width = 4619
integer height = 2096
string title = "Production E-Job Folder "
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type long ue_production_production_order ( )
event type long ue_production_production_summary ( )
event type long ue_open ( )
event type long ue_display_doc_info ( long al_job )
event type long ue_template_first_piece ( )
event type long ue_matrial_sheet_tickets ( )
event type long ue_matrial_scrap_tickets ( )
event type long ue_matrial_coil_tickets ( )
event type long ue_matrial_sample_tickets ( )
event type long ue_material_sheet_skid_list ( )
event type long ue_material_scrap_skid_list ( )
event type long ue_sales_customer_order ( )
event type long ue_template_skid_ticket ( )
event type long ue_template_scrap_ticket ( )
event type long ue_template_sample_ticket ( )
event type long ue_template_coil_eval_1 ( )
event type long ue_template_coil_eval_2 ( )
event type long ue_template_coil_eval_for_all ( )
cb_print cb_print
st_title3 st_title3
st_title2 st_title2
cb_as cb_as
cb_open cb_open
em_job em_job
st_title1 st_title1
tab_doc tab_doc
cb_close cb_close
dw_report dw_report
gb_job gb_job
end type
global w_production_folder w_production_folder

type variables
Long il_job
Long il_user
end variables

forward prototypes
public function string wf_get_partial_and_wh (long al_job)
public subroutine wf_set_values (long al_job)
public function long wf_rejected_coil_wt (long al_coil_num)
end prototypes

event type string ue_whoami();RETURN "w_production_folder"
end event

event type long ue_production_production_order();Int li_sheettype
Int li_filenum
Long ll_flen
Long ll_pic_id
Long ll_new_pos
Int li_loops, li_i
Blob lb_pic
String	ls_modstr, ls_rtn //Alex Gerlants. 07/20/2016

SetPointer(HourGlass!)

dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

CONNECT USING SQLCA;
SELECT CUSTOMER_ORDER.SHEET_HANDLING_TYPE INTO :li_sheettype
FROM AB_JOB, CUSTOMER_ORDER 
WHERE (AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM) AND (AB_JOB.AB_JOB_NUM = :il_job)   
USING SQLCA;

CHOOSE CASE li_sheettype
	CASE 1
		dw_report.DataObject = "d_report_prod_order_by_lot_folder"
	CASE ELSE
		dw_report.DataObject = "d_report_prod_order_folder"
END CHOOSE

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

String ls_cust, ls_shape, ls_tcust
Long ll_order, ll_cust
Real lr_l, lr_s, lr_w, lr_l_p, lr_l_m, lr_s_p, lr_s_m, lr_w_p, lr_w_m
Int li_item
Long ll_coil_wt, ll_row, ll_i, ll_skids, ll_max_skid_wt
Real lr_yield, lr_pcwt
String ls_modstring
Int li_skid_num

SELECT order_abc_num, order_item_num, material_yield, sketch_id 
INTO :ll_order, :li_item, :lr_yield, :ll_pic_id
FROM ab_job 
WHERE ab_job_num = :il_job
USING SQLCA;

IF IsNULL(ll_pic_id)  THEN ll_pic_id = 0

	SELECTBLOB sketch_view 
	INTO :lb_pic
	FROM sketch_jpg
	WHERE sketch_id = :ll_pic_id
	USING SQLCA;
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
		Return -1
	END IF

	ll_flen = Len(lb_pic)
	IF ll_flen > 32765 THEN
		IF Mod(ll_flen, 32765) = 0 THEN
			li_loops = ll_flen / 32765
		ELSE
			li_loops = (ll_flen / 32765) + 1
		END IF
	ELSE
		li_loops = 1
	END IF
	
	Integer	li_rtn

	ll_new_pos = 1
	li_filenum = FileOpen(gs_efSketch_file, StreamMode!, Write!, LockReadWrite!, Replace!)
	li_rtn = FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
	FileClose(li_FileNum)

	FOR li_i = 1 TO li_loops
		li_filenum = FileOpen(gs_efSketch_file, StreamMode!, Write!, LockreadWrite!,Append!)
		FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
		FileClose(li_FileNum)
	NEXT
	
//Alex Gerlants. 07/20/2016. Begin
//.\efsketch.jpg
//Change file efsketch.jpg location from ".\efsketch.jpg" (as on d_report_prod_order_folder and d_report_prod_order_by_lot_folder)
//to gs_efsketch_file
ls_modstr = "p_1.filename = '" + gs_efsketch_file + "'"
ls_rtn = dw_report.Modify(ls_modstr)
//Alex Gerlants. 07/20/2016. End	

SELECT orig_customer_id INTO :ll_cust
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;
IF ll_cust > 0 THEN
	SELECT customer_short_name INTO :ls_tcust
	FROM customer
	WHERE customer_id = :ll_cust
	USING SQLCA;
	ls_cust =  Upper(Trim(ls_tcust))
	ls_modstring = "cust_t.Text = ~"" + ls_cust + "~""
	dw_report.Modify(ls_modstring) 
END IF

SELECT sheet_type, max_skid_wt, theoretical_unit_wt INTO :ls_shape, :ll_max_skid_wt, :lr_pcwt
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

//part dimensions should be Width x Length 
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_length_plus, rt_length_minus, rt_width,  rt_width_plus, rt_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "PARALLELOGRAM"
		SELECT p_length, p_length_plus,p_length_minus, p_width,  p_width_plus,  p_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "FENDER"
		SELECT fe_side, fe_side_plus, fe_side_minus INTO :lr_w, :lr_w_p, :lr_w_m
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "CHEVRON"
		SELECT ch_length, ch_length_plus, ch_length_minus, ch_width, ch_width_plus, ch_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "CIRCLE"
		SELECT c_diameter, c_diameter_plus, c_diameter_minus INTO :lr_w, :lr_w_p, :lr_w_m
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_long_plus, tr_long_minus, tr_width, tr_width_plus , tr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_long_plus, ltr_long_minus, ltr_width, ltr_width_plus, ltr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_long_plus, rtr_long_minus, rtr_width, rtr_width_plus, rtr_width_minus  
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "REINFORCEMENT"
		SELECT re_length, re_length_plus, re_length_minus, re_width,  re_width_plus, re_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM reinforcement
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "LIFTGATE"
		SELECT li_length, li_length_plus, li_length_minus, li_width,  li_width_plus, li_width_minus
		INTO :lr_l, :lr_l_p, :lr_l_m, :lr_w, :lr_w_p, :lr_w_m
		FROM liftgate_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
	CASE "OTHER"
		SELECT x_1, x_2 
		INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
END CHOOSE		

ls_modstring = "w_t.Text = ~"" + String(lr_w, "###,###.###") + "~""
dw_report.Modify(ls_modstring)
IF IsNULL(lr_w_p) OR lr_w_p = 0 THEN
	ls_modstring = "w_p_t.Text = ~"+ 0.000~""
ELSE	
	ls_modstring = "w_p_t.Text = ~"+" + String(lr_w_p, "###.###") + "~""
END IF
dw_report.Modify(ls_modstring) 
IF IsNULL(lr_w_m) OR lr_w_m = 0 THEN 
	ls_modstring = "w_m_t.Text = ~"- 0.000~""
ELSE	
	ls_modstring = "w_m_t.Text = ~"-" + String(lr_w_m, "##.###") + "~""
END IF
dw_report.Modify(ls_modstring) 

ls_modstring = "l_t.Text = ~"" + String(lr_l, "###,###.###") + "~""
dw_report.Modify(ls_modstring) 
IF NOT(IsNULL(lr_l) OR (lr_l = 0)) THEN
	IF IsNULL(lr_l_p) OR lr_l_p = 0 THEN
		ls_modstring = "l_p_t.Text = ~"+ 0.000~""
	ELSE		
		ls_modstring = "l_p_t.Text = ~"+" + String(lr_l_p, "##.###") + "~""
	END IF
	dw_report.Modify(ls_modstring)
	IF IsNULL(lr_l_m) OR lr_l_m = 0 THEN 
		ls_modstring = "l_m_t.Text = ~"- 0.000~""
	ELSE	
		ls_modstring = "l_m_t.Text = ~"-" + String(lr_l_m, "##.###") + "~""
	END IF
	dw_report.Modify(ls_modstring) 
END IF

DataStore lds_coil
lds_coil = CREATE datastore  
lds_coil.DataObject = "d_report_ab_job_coil"  
lds_coil.SetTransObject (SQLCA)  
lds_coil.Retrieve(il_job)

ll_row = lds_coil.rowCount()
ll_coil_wt = 0
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coil_wt = ll_coil_wt + lds_coil.GetItemNumber(ll_i, "process_coil_process_quantity")
	NEXT
END IF
DESTROY lds_coil

ls_modstring = "total_coil_t.Text = ~"" + String(ll_coil_wt, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

ls_modstring = "partial_t.Text = ~"" + wf_get_partial_and_wh(il_job) + "~""
dw_report.Modify(ls_modstring) 



RETURN 1

end event

event type long ue_production_production_summary();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_report_prod_order_summary_folder"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)
wf_set_values(il_job)

String ls_modstring
SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :il_job
USING SQLCA;

SELECT orig_customer_id, enduser_id INTO :ll_cust, :ll_enduser
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
	ls_cust = ls_cust + " ( " + Trim(ls_enduser) + " )"
END IF

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
ls_spec = ls_alloy + " - " + ls_temper + "    " + String(lr_gauge, "##.######") + " X "
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
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part#


ls_modstring = "customer_t.Text = ~"" + ls_cust + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "material_t.Text = ~"" + ls_spec + "~""
dw_report.Modify(ls_modstring) 

RETURN 1
end event

event type long ue_open();Long ll_job, ll_exist
String ls_login

ll_job = Long(em_job.Text)
ll_exist = 0
tab_doc.tabpage_notes.dw_notes.Reset()
st_title1.Text = ""
st_title2.Text = ""
st_title3.Text = ""

CONNECT USING SQLCA;
SELECT Count(ab_job_num) INTO :ll_exist
FROM ab_job
WHERE ab_job_num = :ll_job
USING SQLCA;
IF ll_exist = 0 OR IsNULL(ll_exist) THEN
	il_job = 0
	MessageBox("Warning", "Job " + em_job.Text + " does not exist.", StopSign!)
	this.Title = "Production E-Job Folder"
	tab_doc.tabpage_files.of_init(il_job)
	RETURN 0
ELSE
	ls_login = gnv_app.of_GetUserId()
	il_user = 0

	CONNECT USING SQLCA;
	SELECT user_id INTO :il_user
	FROM security_user
	WHERE lower(login_id) = lower(:ls_login) //Alex Gerlants. 06/03/2016. Fixed a problem when Scott Scholtz logged in as "SSchultz", and he was getting the "Invalid user account" error below.
	USING SQLCA;

	IF il_user < 1 THEN 
		MessageBox("Warning", "Invalid user account", StopSign!)
		RETURN -2
	END IF
	
	il_job = ll_job
	this.Event ue_display_doc_info(il_job)
	tab_doc.tabpage_notes.dw_notes.settransobject( sqlca)
	tab_doc.tabpage_notes.dw_notes.Retrieve(il_job, il_user)
	tab_doc.tabpage_files.of_init(il_job)
	this.Title = "Production E-Job Folder  - Job# " + String(ll_job)
END IF
tab_doc.SelectedTab = 1
tab_doc.Width = 973

RETURN this.Event ue_production_production_order()
end event

event type long ue_display_doc_info(long al_job);SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper, ls_po, ls_status
Long ll_cust, ll_order, ll_enduser, ll_skid, ll_coil
Int li_item, li_status
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#

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
st_title1.Text = "Job# " + String(al_job) + "   " + ls_cust + "   Customer PO# " + ls_po + "   ABCO Order# " + String(ll_order)

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
ls_spec = ls_alloy + " - " + ls_temper + "    " + String(lr_gauge, "##.######") + " X "
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
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part#
st_title2.Text = ls_spec

CHOOSE CASE li_status
	CASE 0
		ls_status = "Done"
	CASE 2
		ls_status = "New"
	CASE 1
		ls_status = "InProcess"
	CASE 4
		ls_status = "Canceled"
	CASE 5
		ls_status = "OnHold"
	CASE ELSE
		ls_status = "Unknown"
END CHOOSE

SELECT Count(SHEET_SKID_NUM) INTO :ll_skid   
FROM SHEET_SKID 
WHERE ( AB_JOB_NUM = :al_job ) AND  ( SKID_SHEET_STATUS <> 6 )
USING SQLCA;

SELECT Count(COIL_ABC_NUM) INTO :ll_coil  
FROM process_coil 
WHERE AB_JOB_NUM = :al_job 
USING SQLCA;

st_title3.Text = "Type: " + Upper(Trim(ls_shape)) + "   Number of coils: " + String(ll_coil) + "   Number of sheet skids: " + String(ll_skid) + "   Job status: " + ls_status


RETURN 1
end event

event type long ue_template_first_piece();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_first_piece_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_matrial_sheet_tickets();RETURN 1
end event

event type long ue_matrial_scrap_tickets();RETURN 1
end event

event type long ue_matrial_coil_tickets();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_report_matrial_coil_barcode"

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)
dw_report.ResetUpdate()

RETURN 1
end event

event type long ue_matrial_sample_tickets();RETURN 1
end event

event type long ue_material_sheet_skid_list();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_report_shopfloor_skid"

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

SetPointer(HourGlass!)
String ls_cust, ls_shape, ls_enduser, ls_spec, ls_temper, ls_sle_1, ls_sle_2
Long ll_cust, ll_order, ll_enduser
Int li_item
String ls_alloy
Real lr_l, lr_s, lr_w, lr_gauge
String ls_desc, ls_part#, ls_po

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num INTO :ll_order, :li_item
FROM ab_job 
WHERE ab_job_num = :il_job
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
	ls_cust = ls_cust + " ( " + Trim(ls_enduser) + " )"
END IF
ls_cust = ls_cust + "          Cust.P.O.# " + ls_po
ls_sle_1 = Upper(ls_cust)

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
ls_spec = ls_alloy + " - " + ls_temper + "    " + String(lr_gauge, "##.######") + " X "
CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		SELECT rt_length, rt_width INTO :lr_l, :lr_w
		FROM rectangle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "PARALLELOGRAM"
		SELECT p_length, p_width INTO :lr_l, :lr_w
		FROM parallelogram
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "FENDER"
		SELECT fe_side INTO :lr_l
		FROM fender
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "CHEVRON"
		SELECT ch_length, ch_width INTO :lr_l, :lr_w
		FROM chevron
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "CIRCLE"
		SELECT c_diameter INTO :lr_l
		FROM circle
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_l, "#####.#####") 
		ls_spec = ls_spec + " (" + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "TRAPEZOID"
		SELECT tr_long_length, tr_short_length, tr_width INTO :lr_l, :lr_s, :lr_w
		FROM trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "L.TRAPEZOID"
		SELECT ltr_long_length, ltr_short_length, ltr_width INTO :lr_l, :lr_s, :lr_w
		FROM left_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "R.TRAPEZOID"
		SELECT rtr_long_length, rtr_short_length, rtr_width INTO :lr_l, :lr_s, :lr_w
		FROM right_trapezoid
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_s, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_s * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE "OTHER"
		SELECT x_1, x_2 INTO :lr_w, :lr_l
		FROM x1_shape
		WHERE order_abc_num = :ll_order AND order_item_num = :li_item
		USING SQLCA;
		ls_spec = ls_spec + String(lr_w, "#####.#####") + " X " + String(lr_l, "#####.#####")
		ls_spec = ls_spec + " ("  + String(lr_gauge * 25.4, "#####.##") + " X " + String(lr_w * 25.4, "#####.##") + " X " + String(lr_l * 25.4, "#####.##") + ")"
	CASE ELSE
		ls_spec = ls_spec + " "
END CHOOSE	
ls_spec = ls_spec + "    " + ls_desc + " / " + ls_part#
ls_sle_2 = ls_spec


String ls_modstring
ls_modstring = "customer_t.Text = ~"" + ls_sle_1 + "~""
dw_report.Modify(ls_modstring) 
ls_modstring = "material_t.Text = ~"" + ls_sle_2 + "~""
dw_report.Modify(ls_modstring) 

Long ll_net, ll_tare
CONNECT USING SQLCA;
SELECT SUM(sheet_net_wt), SUM(sheet_tare_wt) INTO :ll_net, :ll_tare
FROM sheet_skid
WHERE ab_job_num = :il_job
USING SQLCA;
	
ls_modstring = "gross_t.Text = ~"" + String((ll_net + ll_tare), "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

//sync skid wt
Long ll_totalrow, ll_row, ll_i
Long ll_nwt, ll_inwt
Long ll_skid, ll_skid_netwt, ll_lastitem, ll_lastitem_netwt

dw_report.AcceptText()
ll_totalrow = dw_report.RowCount()
IF ll_totalrow < 1 THEN RETURN 0
FOR ll_row = 1 TO ll_totalrow
	ll_nwt = dw_report.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt")
	dw_report.SetItem(ll_row, "citem_net_kg", Int(ll_nwt  * 0.45359 + 0.5 ))
NEXT
dw_report.AcceptText()

FOR ll_row = 1 TO ll_totalrow
	ll_skid = dw_report.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num")
	ll_skid_netwt = dw_report.GetItemNumber(ll_row, "net_wt_kg", Primary!, FALSE)
	ll_nwt = 0
	ll_lastitem = 0
	FOR ll_i = 1 TO ll_totalrow
		IF dw_report.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num") = ll_skid THEN
			ll_inwt = dw_report.GetItemNumber(ll_i, "citem_net_kg", Primary!, FALSE)
			IF ISNULL(ll_inwt) THEN ll_inwt = 0
			ll_nwt = ll_nwt + ll_inwt
			ll_lastitem_netwt = ll_inwt
			ll_lastitem = ll_i
		END IF
	NEXT
	IF ll_nwt <> ll_skid_netwt THEN
		dw_report.SetItem(ll_lastitem, "citem_net_kg", ll_lastitem_netwt + (ll_skid_netwt - ll_nwt))
	END IF
NEXT 


dw_report.ResetUpdate()

RETURN 1

end event

event type long ue_material_scrap_skid_list();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_office_entry_report_scrap_list"

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

SetPointer(HourGlass!)

String ls_cust_name, ls_mod

select customer_short_name into :ls_cust_name
from customer_order, customer, ab_job
where (customer.customer_id = customer_order.orig_customer_id) and (ab_job.order_abc_num = customer_order.order_abc_num) and (ab_job.ab_job_num = :il_job)
using SQLCA;

ls_cust_name = Upper(ls_cust_name)
ls_cust_name = Trim(ls_cust_name)

ls_mod = "cust_t.Text = ~"" + ls_cust_name + "~""
dw_report.Modify(ls_mod) 

dw_report.ResetUpdate()

RETURN 1
end event

event type long ue_sales_customer_order();dw_report.Reset()
IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.DataObject = "d_report_order_entry"

SetPointer(HourGlass!)

Long ll_order

select order_abc_num into :ll_order
from ab_job
where ab_job_num = :il_job
using SQLCA;

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ll_order)

dw_report.ResetUpdate()

RETURN 1
end event

event type long ue_template_skid_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_skid_ticket_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_scrap_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_scrap_skid_ticket_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_sample_ticket();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_report_sample_ticket_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_coil_eval_1();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_coil_evaluation_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_coil_eval_2();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_coil_evaluation_template_page_2"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

RETURN 1
end event

event type long ue_template_coil_eval_for_all();IF il_job = 0 THEN 
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF

dw_report.Reset()

dw_report.DataObject = "d_coil_evaluation_per_job_template"
dw_report.SetTransObject(sqlca)
dw_report.Retrieve(il_job)

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
DataStore lds_rej, lds_reb

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

lds_rej = CREATE DataStore
lds_rej.DataObject = "d_ab_job_rej_coil_list"
lds_rej.SetTransObject(SQLCA)
lds_rej.Retrieve(al_job)
ll_l1 = lds_rej.RowCount()

lds_reb = CREATE DataStore
lds_reb.DataObject = "d_ab_job_reband_coil_list"
lds_reb.SetTransObject(SQLCA)
lds_reb.Retrieve(al_job)
ll_l2 = lds_reb.RowCount()

ll_l = ll_l1 + ll_l2
ls_modstring = "rejcoil_no_t.Text = ~"" + String(ll_l, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 
ll_rejnet = 0

IF ll_l1 > 0 THEN
	FOR ll_t = 1 TO ll_l1
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(lds_rej.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
IF ll_l2 > 0 THEN
	FOR ll_t = 1 TO ll_l2
		ll_rejnet = ll_rejnet + wf_rejected_coil_wt(lds_reb.GetItemNumber(ll_t, "process_coil_coil_abc_num"))
	NEXT
END IF
ls_modstring = "rejcoil_net_t.Text = ~"" + String(ll_rejnet, "###,###,###") + "~""
dw_report.Modify(ls_modstring) 

DESTROY lds_rej
DESTROY lds_reb

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

on w_production_folder.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.st_title3=create st_title3
this.st_title2=create st_title2
this.cb_as=create cb_as
this.cb_open=create cb_open
this.em_job=create em_job
this.st_title1=create st_title1
this.tab_doc=create tab_doc
this.cb_close=create cb_close
this.dw_report=create dw_report
this.gb_job=create gb_job
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.st_title3
this.Control[iCurrent+3]=this.st_title2
this.Control[iCurrent+4]=this.cb_as
this.Control[iCurrent+5]=this.cb_open
this.Control[iCurrent+6]=this.em_job
this.Control[iCurrent+7]=this.st_title1
this.Control[iCurrent+8]=this.tab_doc
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_report
this.Control[iCurrent+11]=this.gb_job
end on

on w_production_folder.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.st_title3)
destroy(this.st_title2)
destroy(this.cb_as)
destroy(this.cb_open)
destroy(this.em_job)
destroy(this.st_title1)
destroy(this.tab_doc)
destroy(this.cb_close)
destroy(this.dw_report)
destroy(this.gb_job)
end on

event close;call super::close;f_display_app()
end event

event pfc_print;call super::pfc_print;PrintSetup()

dw_report.print()

return 1

end event

event open;call super::open;il_job = 0
il_user = 0

em_job.SetFocus() //Alex Gerlants. Also, made cb_open default
end event

type cb_print from u_cb within w_production_folder
string tag = "Print"
integer x = 3899
integer y = 1910
integer width = 322
integer height = 99
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;RETURN Parent.Event pfc_print()
end event

type st_title3 from statictext within w_production_folder
integer x = 984
integer y = 163
integer width = 3606
integer height = 54
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_title2 from statictext within w_production_folder
integer x = 984
integer y = 93
integer width = 3599
integer height = 54
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_as from u_cb within w_production_folder
boolean visible = false
integer x = 234
integer y = 144
integer width = 461
integer height = 93
integer taborder = 40
integer textsize = -7
integer weight = 700
string facename = "Arial"
boolean enabled = false
string text = "Advanced Search"
end type

event clicked;call super::clicked;Open(w_folder_job_search)
end event

type cb_open from u_cb within w_production_folder
integer x = 567
integer y = 45
integer width = 351
integer height = 93
integer taborder = 30
integer textsize = -7
integer weight = 700
string facename = "Arial"
string text = "Open"
boolean default = true
end type

event clicked;call super::clicked;dw_report.DataObject = ""
st_title1.Text = ""
st_title2.Text = ""
st_title3.Text = ""
il_job = 0
dw_report.Reset()
Parent.Event ue_open()
end event

type em_job from editmask within w_production_folder
integer x = 29
integer y = 51
integer width = 530
integer height = 83
integer taborder = 20
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

type st_title1 from statictext within w_production_folder
integer x = 984
integer y = 22
integer width = 3588
integer height = 54
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type tab_doc from tab within w_production_folder
integer x = 4
integer y = 253
integer width = 973
integer height = 1651
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean fixedwidth = true
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
integer selectedtab = 1
tabpage_prod tabpage_prod
tabpage_notes tabpage_notes
tabpage_files tabpage_files
tabpage_sales tabpage_sales
tabpage_material tabpage_material
tabpage_invoice tabpage_invoice
tabpage_ship tabpage_ship
tabpage_template tabpage_template
end type

on tab_doc.create
this.tabpage_prod=create tabpage_prod
this.tabpage_notes=create tabpage_notes
this.tabpage_files=create tabpage_files
this.tabpage_sales=create tabpage_sales
this.tabpage_material=create tabpage_material
this.tabpage_invoice=create tabpage_invoice
this.tabpage_ship=create tabpage_ship
this.tabpage_template=create tabpage_template
this.Control[]={this.tabpage_prod,&
this.tabpage_notes,&
this.tabpage_files,&
this.tabpage_sales,&
this.tabpage_material,&
this.tabpage_invoice,&
this.tabpage_ship,&
this.tabpage_template}
end on

on tab_doc.destroy
destroy(this.tabpage_prod)
destroy(this.tabpage_notes)
destroy(this.tabpage_files)
destroy(this.tabpage_sales)
destroy(this.tabpage_material)
destroy(this.tabpage_invoice)
destroy(this.tabpage_ship)
destroy(this.tabpage_template)
end on

event clicked;CHOOSE CASE this.SelectedTab
	CASE 2  //notes
		this.Width = 4582
		cb_print.Enabled = FALSE
		tab_doc.tabpage_notes.dw_notes.Width = 4160
	CASE 3 //file
		this.Width = 4582
		tabpage_files.of_init(il_job)
		cb_print.Enabled = FALSE
	CASE ELSE  //other
		this.Width = 973
		cb_print.Enabled = TRUE
END CHOOSE
RETURN 1
end event

event selectionchanged;dw_report.DataObject = ""
dw_report.Reset()
end event

event constructor;this.Width = 973
end event

type tabpage_prod from userobject within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 134217729
string text = "Production"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
long picturemaskcolor = 536870912
lv_prod lv_prod
end type

on tabpage_prod.create
this.lv_prod=create lv_prod
this.Control[]={this.lv_prod}
end on

on tabpage_prod.destroy
destroy(this.lv_prod)
end on

type lv_prod from u_lvs within tabpage_prod
integer x = 4
integer y = 10
integer width = 611
integer height = 1606
integer taborder = 50
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {"Production Order","Production Summary"}
integer itempictureindex[] = {2,2}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event rbuttonup;//override
RETURN 1
end event

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

type tabpage_notes from userobject within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 65535
string text = "Notes"
long tabtextcolor = 33554432
long tabbackcolor = 65535
long picturemaskcolor = 536870912
cb_save cb_save
cb_delete cb_delete
dw_notes dw_notes
cb_add cb_add
end type

on tabpage_notes.create
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.dw_notes=create dw_notes
this.cb_add=create cb_add
this.Control[]={this.cb_save,&
this.cb_delete,&
this.dw_notes,&
this.cb_add}
end on

on tabpage_notes.destroy
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.dw_notes)
destroy(this.cb_add)
end on

type cb_save from u_cb within tabpage_notes
integer x = 2432
integer y = 1504
integer width = 351
integer height = 93
integer taborder = 31
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;IF il_job = 0 OR il_user = 0 THEN
	MessageBox("Warning", "Please select a job first.")
	RETURN -1
END IF

Int li_return

tab_doc.tabpage_notes.dw_notes.AcceptText()

li_return = tab_doc.tabpage_notes.dw_notes.of_UpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 0 THEN
	//No Change
	Return 0
END IF

li_return = tab_doc.tabpage_notes.dw_notes.Update()
IF li_return <> 1 THEN
	ROLLBACK using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN 
		MessageBox("Rollback Error", SQLCA.SQLErrText )
	ELSE
		MessageBox("Update Failed", "But Rollback succeeded" )
	END IF
ELSE
	COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText )
		Return -2
	END IF
END IF

Return 1
end event

type cb_delete from u_cb within tabpage_notes
integer x = 1865
integer y = 1504
integer width = 351
integer height = 93
integer taborder = 21
string facename = "Arial"
string text = "&Delete"
end type

event clicked;call super::clicked;SetPointer(HourGlass!)
IF il_job = 0 OR il_user = 0 THEN
	MessageBox("Warning", "Please select a job first.")
	RETURN -1
END IF

integer li_rc
Long ll_row, ll_user
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = tab_doc.tabpage_notes.dw_notes.GetRow()
	If ll_row < 1 THEN RETURN
	ll_user = tab_doc.tabpage_notes.dw_notes.GetItemNumber(ll_row, "job_efolder_notes_user_id", Primary!, FALSE)
	IF ll_user <> il_user THEN
		MessageBox("Warning", "You may delete your own notes.", StopSign!)
		RETURN
	END IF
	tab_doc.tabpage_notes.dw_notes.Deleterow(0)
END IF
RETURN

end event

type dw_notes from u_dw within tabpage_notes
integer x = 26
integer y = 10
integer width = 589
integer height = 1485
integer taborder = 11
string dataobject = "d_efolder_notes"
end type

event constructor;call super::constructor;SetRowFocusIndicator(Hand!)

of_SetBase(TRUE)
//of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)


end event

event pfc_addrow;call super::pfc_addrow;long ll_row
DateTime ldt_t
String ls_f, ls_l

ll_row = this.GetRow()
ldt_t = DateTime(Today(), Now())

SELECT user_first_name, user_last_name INTO :ls_f, :ls_l
FROM security_user
WHERE user_id = :il_user
USING SQLCA;

SetItem(ll_row, "job_efolder_notes_timestamp", ldt_t)
SetItem(ll_row, "job_efolder_notes_user_id", il_user)
SetItem(ll_row, "job_efolder_notes_ab_job_num", il_job)
SetItem(ll_row, "security_user_user_first_name", ls_f)
SetItem(ll_row, "security_user_user_last_name", ls_l)

Return ll_row
end event

event rbuttondown;//override
RETURN 0
end event

event rbuttonup;//override
RETURN 0
end event

type cb_add from u_cb within tabpage_notes
integer x = 1298
integer y = 1504
integer width = 351
integer height = 93
integer taborder = 11
string facename = "Arial"
string text = "&Add"
end type

event clicked;call super::clicked;IF il_job = 0 OR il_user = 0 THEN
	MessageBox("Warning", "Please select a job first.")
	RETURN -1
END IF
RETURN tab_doc.tabpage_notes.dw_notes.event pfc_addrow()
end event

type tabpage_files from u_tabpg_fileview within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 15793151
string text = "Files"
long tabbackcolor = 15793151
end type

type tabpage_sales from userobject within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 16776960
string text = "Sales"
long tabtextcolor = 33554432
long tabbackcolor = 16776960
long picturemaskcolor = 536870912
lv_sales lv_sales
st_2 st_2
st_110_2 st_110_2
end type

on tabpage_sales.create
this.lv_sales=create lv_sales
this.st_2=create st_2
this.st_110_2=create st_110_2
this.Control[]={this.lv_sales,&
this.st_2,&
this.st_110_2}
end on

on tabpage_sales.destroy
destroy(this.lv_sales)
destroy(this.st_2)
destroy(this.st_110_2)
end on

type lv_sales from u_lvs within tabpage_sales
integer x = 11
integer y = 67
integer width = 592
integer height = 1552
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {"Customer Order"}
integer itempictureindex[] = {2}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "CUSTOMER ORDER"
		a_w.Dynamic Event ue_sales_customer_order()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_2 from statictext within tabpage_sales
integer x = 29
integer width = 351
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "Sales:"
boolean focusrectangle = false
end type

type st_110_2 from u_st within tabpage_sales
integer x = 15
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type tabpage_material from userobject within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 134217750
string text = "Inventory"
long tabtextcolor = 33554432
long tabbackcolor = 134217750
long picturemaskcolor = 536870912
lv_matrial lv_matrial
st_1 st_1
end type

on tabpage_material.create
this.lv_matrial=create lv_matrial
this.st_1=create st_1
this.Control[]={this.lv_matrial,&
this.st_1}
end on

on tabpage_material.destroy
destroy(this.lv_matrial)
destroy(this.st_1)
end on

type lv_matrial from u_lvs within tabpage_material
integer x = 18
integer y = 80
integer width = 585
integer height = 1514
integer taborder = 60
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {"Sheet Skid List","Scrap Skid List","Coil Barcode Tickets"}
integer itempictureindex[] = {2,2,2}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "SKID BARCODE TICKETS"
		a_w.Dynamic Event ue_matrial_skid_tickets()
	CASE "SCRAP BARCODE TICKETS"
		a_w.Dynamic Event ue_matrial_scrap_tickets()
	CASE "COIL BARCODE TICKETS"
		a_w.Dynamic Event ue_matrial_coil_tickets()
	CASE "SAMPLE TICKETS"
		a_w.Dynamic Event ue_material_sample_tickets()
	CASE "SHEET SKID LIST"
		a_w.Dynamic Event ue_material_sheet_skid_list()
	CASE "SCRAP SKID LIST"
		a_w.Dynamic Event ue_material_scrap_skid_list()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_1 from statictext within tabpage_material
integer x = 22
integer y = 6
integer width = 589
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217750
string text = "Inventory:"
boolean focusrectangle = false
end type

type tabpage_invoice from userobject within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 15780518
string text = "Invoicing"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
long picturemaskcolor = 536870912
lv_invoicing lv_invoicing
st_6 st_6
end type

on tabpage_invoice.create
this.lv_invoicing=create lv_invoicing
this.st_6=create st_6
this.Control[]={this.lv_invoicing,&
this.st_6}
end on

on tabpage_invoice.destroy
destroy(this.lv_invoicing)
destroy(this.st_6)
end on

type lv_invoicing from u_lvs within tabpage_invoice
integer x = 11
integer y = 70
integer width = 592
integer height = 1546
integer taborder = 60
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_6 from statictext within tabpage_invoice
integer x = 29
integer y = 6
integer width = 516
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "Invoicing:"
boolean focusrectangle = false
end type

type tabpage_ship from userobject within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 65280
string text = "Shipment"
long tabtextcolor = 33554432
long tabbackcolor = 65280
long picturemaskcolor = 536870912
lv_shipment lv_shipment
st_7 st_7
end type

on tabpage_ship.create
this.lv_shipment=create lv_shipment
this.st_7=create st_7
this.Control[]={this.lv_shipment,&
this.st_7}
end on

on tabpage_ship.destroy
destroy(this.lv_shipment)
destroy(this.st_7)
end on

type lv_shipment from u_lvs within tabpage_ship
integer x = 7
integer y = 74
integer width = 589
integer height = 1536
integer taborder = 70
integer textsize = -9
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
string item[] = {""}
integer itempictureindex[] = {0}
string largepicturename[] = {"Custom050!","ScriptYes!"}
string smallpicturename[] = {"Custom050!","ScriptYes!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page

IF index = -1 THEN RETURN 0

a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

this.GetItem(index, llvi_current)

llvi_current.Label = Upper(llvi_current.Label)

CHOOSE CASE llvi_current.Label
	CASE "PRODUCTION ORDER"
		a_w.Dynamic Event ue_production_production_order()
	CASE "PRODUCTION SUMMARY"
		a_w.Dynamic Event ue_production_production_summary()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_7 from statictext within tabpage_ship
integer x = 33
integer width = 549
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65280
string text = "Shipment:"
boolean focusrectangle = false
end type

type tabpage_template from userobject within tab_doc
integer x = 344
integer y = 13
integer width = 614
integer height = 1626
long backcolor = 134217729
string text = "Templates"
long tabtextcolor = 33554432
long tabbackcolor = 65535
long picturemaskcolor = 536870912
lv_templates lv_templates
st_10 st_10
end type

on tabpage_template.create
this.lv_templates=create lv_templates
this.st_10=create st_10
this.Control[]={this.lv_templates,&
this.st_10}
end on

on tabpage_template.destroy
destroy(this.lv_templates)
destroy(this.st_10)
end on

type lv_templates from u_lvs within tabpage_template
integer x = 11
integer y = 74
integer width = 592
integer height = 1536
integer taborder = 60
string facename = "Arial"
boolean autoarrange = true
boolean buttonheader = false
boolean fixedlocations = true
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
boolean fullrowselect = true
boolean underlinehot = true
string item[] = {"First Piece Verification","Skid Ticket  ","Scrap Ticket  ","Sample Ticket","Coil Eval for current coil","Coil Eval Page 2","Coil Eval for all coils"}
integer itempictureindex[] = {2,2,2,2,2,2,2}
string largepicturename[] = {"Custom050!","Custom070!"}
string smallpicturename[] = {"Custom050!","Custom070!"}
boolean righttoleft = true
end type

event clicked;call super::clicked;ListViewItem llvi_current
tab a_tab
Window a_w
userobject a_tab_page
Int ii_c

IF index = -1 THEN RETURN 0


a_tab_page = this.GetParent()
a_tab = a_tab_page.GetParent()
a_w = a_tab.GetParent()

ii_c = 0
SELECT COUNT(*) INTO :ii_c
FROM line_current_status
WHERE ab_job_num = :il_job
USING SQLCA;
	
this.GetItem(index, llvi_current)

llvi_current.Label = Upper(TRIM(llvi_current.Label))

CHOOSE CASE llvi_current.Label
	CASE "FIRST PIECE VERIFICATION"
		a_w.Dynamic Event ue_template_first_piece()
	CASE "SKID TICKET"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			MessageBox("Warning", "Templates can only be printed while job is being processing.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_skid_ticket()
	CASE "SCRAP TICKET"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			MessageBox("Warning", "Templates can only be printed while job is being processing.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_scrap_ticket()
	CASE "SAMPLE TICKET"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			MessageBox("Warning", "Templates can only be printed while job is being processing.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_sample_ticket()
	CASE "COIL EVAL FOR CURRENT COIL"
		IF IsNULL(ii_c) OR ii_c = 0 THEN 
			MessageBox("Warning", "Templates can only be printed while job is being processing.")
			dw_report.DataObject = ""
			dw_report.Reset()
			RETURN 0
		END IF	
		a_w.Dynamic Event ue_template_coil_eval_1()
	CASE "COIL EVAL PAGE 2"
		a_w.Dynamic Event ue_template_coil_eval_2()
	CASE "COIL EVAL FOR ALL COILS"
		a_w.Dynamic Event ue_template_coil_eval_for_all()
	CASE ELSE
		//
END CHOOSE

RETURN 0
end event

event rbuttonup;//override
RETURN 1
end event

type st_10 from statictext within tabpage_template
integer x = 15
integer width = 505
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Templates:"
boolean focusrectangle = false
end type

type cb_close from u_cb within w_production_folder
string tag = "Exit"
integer x = 4264
integer y = 1910
integer width = 322
integer height = 99
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type dw_report from u_dw within w_production_folder
integer x = 980
integer y = 253
integer width = 3606
integer height = 1651
integer taborder = 60
boolean hsplitscroll = true
end type

event constructor;call super::constructor;of_setPrintPreview(FALSE)
SetTransObject(sqlca)
end event

event rbuttondown;//override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type gb_job from groupbox within w_production_folder
integer width = 969
integer height = 246
integer taborder = 10
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

