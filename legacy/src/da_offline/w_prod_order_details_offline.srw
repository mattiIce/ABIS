$PBExportHeader$w_prod_order_details_offline.srw
$PBExportComments$<Response> show production order report with a preview, inherited from pfemain/w_sheet
forward
global type w_prod_order_details_offline from w_sheet
end type
type dw_report from u_dw within w_prod_order_details_offline
end type
type cb_print from u_cb within w_prod_order_details_offline
end type
type cb_close from u_cb within w_prod_order_details_offline
end type
end forward

global type w_prod_order_details_offline from w_sheet
integer x = 318
integer y = 144
integer width = 3079
integer height = 1770
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_report dw_report
cb_print cb_print
cb_close cb_close
end type
global w_prod_order_details_offline w_prod_order_details_offline

type variables
Int ii_sheettype
end variables

forward prototypes
public subroutine wf_set_w_l (long al_job)
public function integer wf_get_split_coil_skid# (long al_job)
public function string wf_get_partial_and_wh (long al_job)
end prototypes

public subroutine wf_set_w_l (long al_job);String ls_cust, ls_shape, ls_tcust
Long ll_order, ll_cust
Real lr_l, lr_s, lr_w, lr_l_p, lr_l_m, lr_s_p, lr_s_m, lr_w_p, lr_w_m
Int li_item
Long ll_coil_wt, ll_row, ll_i, ll_skids, ll_max_skid_wt
Real lr_yield, lr_pcwt
String ls_modstring
Int li_skid_num

CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num, material_yield 
INTO :ll_order, :li_item, :lr_yield
FROM ab_job 
WHERE ab_job_num = :al_job
USING SQLCA;

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
lds_coil.Retrieve(al_job)

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

 ls_modstring = "partial_t.Text = ~"" + wf_get_partial_and_wh(al_job) + "~""
dw_report.Modify(ls_modstring) 





end subroutine

public function integer wf_get_split_coil_skid# (long al_job);Int ll_row, ll_i, ll_skid
DataStore lds_s

ll_skid = 0
lds_s = CREATE DataStore
lds_s.dataobject = "d_report_ab_job_coil_by_lot"
lds_s.SetTransObject(SQLCA)
lds_s.Retrieve(al_job)
ll_row = lds_s.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_skid = ll_skid + lds_s.GetItemNumber(ll_i, "skid_t", Primary!, FALSE)
	NEXT
END IF

RETURN ll_skid
end function

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

on w_prod_order_details_offline.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
end on

on w_prod_order_details_offline.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_job 

ll_job = message.DoubleParm

CONNECT USING SQLCA;
SELECT CUSTOMER_ORDER.SHEET_HANDLING_TYPE INTO :ii_sheettype
FROM AB_JOB, CUSTOMER_ORDER 
WHERE (AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM) AND (AB_JOB.AB_JOB_NUM = :ll_job)   
USING SQLCA;

CHOOSE CASE ii_sheettype
	CASE 1
		dw_report.DataObject = "d_report_prod_order_by_lot"
	CASE ELSE
		dw_report.DataObject = "d_report_prod_order"
END CHOOSE

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ll_job)
wf_set_w_l(ll_job)
this.title = "Printing production order # :  " + String(ll_job)
dw_report.SetFocus()


end event

type dw_report from u_dw within w_prod_order_details_offline
integer x = 22
integer y = 13
integer width = 3013
integer height = 1546
integer taborder = 30
string dataobject = "d_report_prod_order"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

type cb_print from u_cb within w_prod_order_details_offline
integer x = 951
integer y = 1568
integer width = 351
integer height = 102
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Window lw_parent

PrintSetup()

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()

IF IsValid(lw_parent) THEN
	IF lw_Parent.Dynamic wf_set_sketch_file() < 0 THEN RETURN 0
END IF	

dw_report.print()
end event

type cb_close from u_cb within w_prod_order_details_offline
string tag = "Close without printing"
integer x = 1679
integer y = 1568
integer width = 351
integer height = 102
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

