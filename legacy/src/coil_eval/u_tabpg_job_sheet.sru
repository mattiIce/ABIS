$PBExportHeader$u_tabpg_job_sheet.sru
forward
global type u_tabpg_job_sheet from u_tabpg
end type
type cb_print from u_cb within u_tabpg_job_sheet
end type
type dw_job_sheet from u_dw within u_tabpg_job_sheet
end type
end forward

global type u_tabpg_job_sheet from u_tabpg
integer width = 3650
integer height = 1949
long backcolor = 134217752
cb_print cb_print
dw_job_sheet dw_job_sheet
end type
global u_tabpg_job_sheet u_tabpg_job_sheet

type variables
w_operation_panel iw_operation_panel
long il_job
end variables

forward prototypes
public subroutine of_show_job_sheet ()
public function string of_get_partial_wh (long al_job)
end prototypes

public subroutine of_show_job_sheet ();int li_sheettype, li_pic_id
long ll_job_num
string ls_customer
w_please_wait lw_wait
Blob lb_pic
String ls_cust, ls_shape, ls_tcust
Long ll_order, ll_cust
Real lr_l, lr_s, lr_w, lr_l_p, lr_l_m, lr_s_p, lr_s_m, lr_w_p, lr_w_m
Int li_item
Long ll_coil_wt, ll_row, ll_i, ll_skids, ll_max_skid_wt
Real lr_yield, lr_pcwt
String ls_modstring
Int li_skid_num
String	ls_modstr, ls_rtn //Alex Gerlants. 07/20/2016

//if il_job = il_abjob or il_abjob = 0 or isNull(il_abjob) then
//	return
//end if
ll_job_num = iw_operation_panel.iw_da_sheet.il_abjob

if ll_job_num < 1000 then
	return
end if

open(lw_wait)

//il_job = Long(Mid(this.text(index), 1, 5))

//  il_abjob


SELECT CUSTOMER_ORDER.SHEET_HANDLING_TYPE INTO :li_sheettype
FROM AB_JOB, CUSTOMER_ORDER 
WHERE (AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM) AND (AB_JOB.AB_JOB_NUM = :ll_job_num)   
USING SQLCA;


SELECT sketch_id //, sketch_job_note
INTO :li_pic_id //,:mle_desc.Text 
FROM ab_job
WHERE ab_job_num = :ll_job_num
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	Return
END IF

//Alex Gerlants. 07/20/2016. Bug fix. 
//Changed from "FROM sketch" to "FROM sketch_jpg"
SELECTBLOB sketch_view 
INTO :lb_pic
FROM sketch_jpg
WHERE sketch_id = :li_pic_id
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	Return
END IF

int li_FileNum, li_loops, li_i
Long ll_flen, ll_new_pos
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

ll_new_pos = 1
//li_filenum = FileOpen(gs_Sketch_bmp_file, StreamMode!, Write!, LockReadWrite!, Replace!)
li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockReadWrite!, Replace!) //Alex Gerlants. 07/20/2016. Bug fix
																										//Because p_1 on d_report_prod_order_by_lot and d_report_prod_order point to Sketch.jpg and not to Sketch_bmp
FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
FileClose(li_FileNum)

FOR li_i = 1 TO li_loops
	//li_filenum = FileOpen(gs_Sketch_bmp_file, StreamMode!, Write!, LockreadWrite!,Append!)
	li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockreadWrite!,Append!) //Alex Gerlants. 07/20/2016. Bug fix
																										//Because p_1 on d_report_prod_order_by_lot and d_report_prod_order point to Sketch.jpg and not to Sketch_bmp
	FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
	FileClose(li_FileNum)
NEXT

//p_1.SetPicture(lb_pic)
//p_1.show( )
//p_1.

CHOOSE CASE li_sheettype
	CASE 1
		//new interface
		dw_job_sheet.DataObject = "d_report_prod_order_by_lot"
	CASE ELSE
		//new interface
		dw_job_sheet.DataObject = "d_report_prod_order"
END CHOOSE




//dw_1.object.p_1.SetPicture(lb_pic)
//dw_1.object.p_1.show()
//p_1.SetPicture(lb_pic)

//p_1.show( )
//CONNECT USING SQLCA;

SELECT order_abc_num, order_item_num, material_yield 
INTO :ll_order, :li_item, :lr_yield
FROM ab_job 
WHERE ab_job_num = :ll_job_num
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
	//new interface
	dw_job_sheet.Modify(ls_modstring) 
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
//new interface
dw_job_sheet.Modify(ls_modstring)
IF IsNULL(lr_w_p) OR lr_w_p = 0 THEN
	ls_modstring = "w_p_t.Text = ~"+ 0.000~""
ELSE	
	ls_modstring = "w_p_t.Text = ~"+" + String(lr_w_p, "###.###") + "~""
END IF
//new interface
dw_job_sheet.Modify(ls_modstring) 
IF IsNULL(lr_w_m) OR lr_w_m = 0 THEN 
	ls_modstring = "w_m_t.Text = ~"- 0.000~""
ELSE	
	ls_modstring = "w_m_t.Text = ~"-" + String(lr_w_m, "##.###") + "~""
END IF
//new interface
dw_job_sheet.Modify(ls_modstring) 

ls_modstring = "l_t.Text = ~"" + String(lr_l, "###,###.###") + "~""
//new interface
dw_job_sheet.Modify(ls_modstring) 
IF NOT(IsNULL(lr_l) OR (lr_l = 0)) THEN
	IF IsNULL(lr_l_p) OR lr_l_p = 0 THEN
		ls_modstring = "l_p_t.Text = ~"+ 0.000~""
	ELSE		
		ls_modstring = "l_p_t.Text = ~"+" + String(lr_l_p, "##.###") + "~""
	END IF
	//new interface
	dw_job_sheet.Modify(ls_modstring)
	IF IsNULL(lr_l_m) OR lr_l_m = 0 THEN 
		ls_modstring = "l_m_t.Text = ~"- 0.000~""
	ELSE	
		ls_modstring = "l_m_t.Text = ~"-" + String(lr_l_m, "##.###") + "~""
	END IF
	//new interface
	dw_job_sheet.Modify(ls_modstring) 
END IF

DataStore lds_coil
lds_coil = CREATE datastore  
lds_coil.DataObject = "d_report_ab_job_coil"  
lds_coil.SetTransObject (SQLCA)  
lds_coil.Retrieve(ll_job_num)

ll_row = lds_coil.rowCount()
ll_coil_wt = 0
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coil_wt = ll_coil_wt + lds_coil.GetItemNumber(ll_i, "process_coil_process_quantity")
	NEXT
END IF
DESTROY lds_coil

ls_modstring = "total_coil_t.Text = ~"" + String(ll_coil_wt, "###,###,###") + "~""
//new interface
dw_job_sheet.Modify(ls_modstring) 

ls_modstring = "partial_t.Text = ~"" + of_get_partial_wh(ll_job_num) + "~""
///*------------ Need changes new interface	
	dw_job_sheet.Modify(ls_modstring) 
	dw_job_sheet.SetTransObject(sqlca)
	
	//Alex Gerlants. 07/20/2016. Begin
	//.\sketch.jpg
	////Change file sketch.jpg location from ".\sketch.jpg" (as on d_report_prod_order_by_lot and d_report_prod_order)
	//to gs_sketch_file
	ls_modstr = "p_1.filename = '" + gs_sketch_file + "'"
	ls_rtn = dw_job_sheet.Modify(ls_modstr)
	//Alex Gerlants. 07/20/2016. End
	
	dw_job_sheet.Retrieve(ll_job_num)
	il_job = ll_job_num
//*/ //new interface
close(lw_wait)
end subroutine

public function string of_get_partial_wh (long al_job);String ls_s
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

on u_tabpg_job_sheet.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.dw_job_sheet=create dw_job_sheet
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.dw_job_sheet
end on

on u_tabpg_job_sheet.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.dw_job_sheet)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
//em_password.of_setdropdowncalculator( true)
//em_password.iuo_calculator.of_setcloseonclick( true)
//em_password.iuo_calculator.of_setinitialvalue( true)
end event

type cb_print from u_cb within u_tabpg_job_sheet
integer x = 3178
integer y = 22
integer width = 351
integer height = 93
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Print"
end type

event clicked;call super::clicked;dw_job_sheet.print()
end event

type dw_job_sheet from u_dw within u_tabpg_job_sheet
integer width = 3643
integer height = 1942
integer taborder = 10
string dataobject = "d_report_prod_order"
boolean resizable = true
end type

