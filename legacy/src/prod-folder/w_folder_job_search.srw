$PBExportHeader$w_folder_job_search.srw
$PBExportComments$<Response> List all ab jobs and all information about each job,
forward
global type w_folder_job_search from w_sheet
end type
type ddlb_status from dropdownlistbox within w_folder_job_search
end type
type cb_reset from u_cb within w_folder_job_search
end type
type st_21 from statictext within w_folder_job_search
end type
type st_20 from statictext within w_folder_job_search
end type
type em_4 from editmask within w_folder_job_search
end type
type em_3 from editmask within w_folder_job_search
end type
type em_2 from editmask within w_folder_job_search
end type
type st_19 from statictext within w_folder_job_search
end type
type em_1 from editmask within w_folder_job_search
end type
type st_18 from statictext within w_folder_job_search
end type
type st_17 from statictext within w_folder_job_search
end type
type em_temper from editmask within w_folder_job_search
end type
type em_alloy from editmask within w_folder_job_search
end type
type st_16 from statictext within w_folder_job_search
end type
type st_15 from statictext within w_folder_job_search
end type
type em_desc from editmask within w_folder_job_search
end type
type st_14 from statictext within w_folder_job_search
end type
type em_line from editmask within w_folder_job_search
end type
type st_13 from statictext within w_folder_job_search
end type
type em_after from editmask within w_folder_job_search
end type
type st_12 from statictext within w_folder_job_search
end type
type em_before from editmask within w_folder_job_search
end type
type st_11 from statictext within w_folder_job_search
end type
type em_id from editmask within w_folder_job_search
end type
type st_10 from statictext within w_folder_job_search
end type
type st_9 from statictext within w_folder_job_search
end type
type st_8 from statictext within w_folder_job_search
end type
type dw_job_list from u_dw within w_folder_job_search
end type
type dw_customer from u_dw within w_folder_job_search
end type
type cb_close from u_cb within w_folder_job_search
end type
type cb_open from u_cb within w_folder_job_search
end type
type gb_1 from groupbox within w_folder_job_search
end type
type ddlb_customer from dropdownlistbox within w_folder_job_search
end type
type st_1 from statictext within w_folder_job_search
end type
type cb_search from u_cb within w_folder_job_search
end type
type st_2 from statictext within w_folder_job_search
end type
type st_3 from statictext within w_folder_job_search
end type
type st_4 from statictext within w_folder_job_search
end type
type st_5 from statictext within w_folder_job_search
end type
type st_6 from statictext within w_folder_job_search
end type
type st_7 from statictext within w_folder_job_search
end type
end forward

global type w_folder_job_search from w_sheet
integer x = 4
integer y = 3
integer width = 2820
integer height = 2051
string title = "ABCO production order selection"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
ddlb_status ddlb_status
cb_reset cb_reset
st_21 st_21
st_20 st_20
em_4 em_4
em_3 em_3
em_2 em_2
st_19 st_19
em_1 em_1
st_18 st_18
st_17 st_17
em_temper em_temper
em_alloy em_alloy
st_16 st_16
st_15 st_15
em_desc em_desc
st_14 st_14
em_line em_line
st_13 st_13
em_after em_after
st_12 st_12
em_before em_before
st_11 st_11
em_id em_id
st_10 st_10
st_9 st_9
st_8 st_8
dw_job_list dw_job_list
dw_customer dw_customer
cb_close cb_close
cb_open cb_open
gb_1 gb_1
ddlb_customer ddlb_customer
st_1 st_1
cb_search cb_search
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
end type
global w_folder_job_search w_folder_job_search

type variables
Long il_old_job
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]

end variables

forward prototypes
public function string wf_search_terms ()
public function string wf_display_total_terms ()
public function integer wf_display_total_info ()
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
end prototypes

event ue_get_header;Int li_i
s_dw_header_type lstr_ht

lstr_ht.dw_header = "NULL"
lstr_ht.col_type = "NULL"

li_i = 1
DO WHILE li_i <= UpperBound(istr_dwdb)
	IF istr_dwdb[li_i].dw_column = as_id THEN
		 lstr_ht.dw_header = istr_dwdb[li_i].dw_header
		 lstr_ht.col_type = istr_dwdb[li_i].col_type
	END IF
	li_i++
LOOP

RETURN lstr_ht
end event

public function string wf_search_terms ();String ls_terms
integer li_i

ls_terms = "  WHERE ( ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ) AND ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = :al_custome_id )  "
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "line"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "status"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
			CASE "date"
				ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
			CASE "string"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public function string wf_display_total_terms ();String ls_terms
String ls_date, ls_op
integer li_rc
Long ll_row, ll_cust
Int li_i

SetNULL(ls_terms)
ll_row = dw_customer.GetRow()
IF ll_row <= 0 THEN RETURN ls_terms
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")

ls_terms = "  WHERE (AB_JOB.ORDER_ABC_NUM = CUSTOMER_ORDER.ORDER_ABC_NUM ) AND ( CUSTOMER_ORDER.ORIG_CUSTOMER_ID = " + String(ll_cust) + " )  "
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].operator <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "line"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "status"
				ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value + " )"
			CASE "date"
				ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + ", 'DD-MON-YYYY'), 'DD-MON-YYYY') " + istr_search[li_i].operator + " TO_DATE('" + istr_search[li_i].value + "','mm/dd/yyyy' )" + " )"
			CASE "string"
				ls_terms = ls_terms + " AND ( " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " ~'" + istr_search[li_i].value + "~' )"
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public function integer wf_display_total_info ();//String ls_where, ls_select
//Long ll_item
//
//ls_where = wf_display_total_terms()
//IF IsNULL(ls_where) THEN RETURN 0
//
//CONNECT USING SQLCA;
//
//ls_select = "SELECT COUNT(ab_job.ab_job_num) FROM ab_job, customer_order "
//
//DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
//String ls_Mysql
//ls_Mysql = ls_select + ls_where
//PREPARE SQLSA FROM :ls_Mysql;
//OPEN DYNAMIC my_cursor;
//FETCH my_cursor INTO :ll_item;
//CLOSE my_cursor ;
//
//IF IsNULL(ll_item) THEN ll_item = 0
//
//IF ll_item < 2 THEN
//	dw_job_list.Object.item_t.Text = String(ll_item, "#,###,###") 
//	dw_job_list.Object.order_t.Text = "Prod. order"
//ELSE
//	dw_job_list.Object.item_t.Text = String(ll_item, "#,###,###")
//	dw_job_list.Object.order_t.Text = "Prod orders" 
//END IF	
//
RETURN 1

end function

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "AB_JOB"
istr_dwdb[1].db_field = "AB_JOB_NUM"
istr_dwdb[1].dw_column = "ab_job_num"
istr_dwdb[1].col_type = "number"
istr_dwdb[1].dw_header = "ABC Job"

istr_dwdb[2].db_name = "AB_JOB"
istr_dwdb[2].db_field = "LINE_NUM"
istr_dwdb[2].dw_column = "line_num"
istr_dwdb[2].col_type = "line"
istr_dwdb[2].dw_header = "Line"

istr_dwdb[3].db_name = "AB_JOB"
istr_dwdb[3].db_field = "MATERIAL_YIELD"
istr_dwdb[3].dw_column = "material_yield"
istr_dwdb[3].col_type = "number"
istr_dwdb[3].dw_header = "M.Yield"

istr_dwdb[4].db_name = "AB_JOB"
istr_dwdb[4].db_field = "TIME_DATE_STARTED"
istr_dwdb[4].dw_column = "time_date_started"
istr_dwdb[4].col_type = "date"
istr_dwdb[4].dw_header = "Time Started"

istr_dwdb[5].db_name = "AB_JOB"
istr_dwdb[5].db_field = "TIME_DATE_FINISHED"
istr_dwdb[5].dw_column = "time_date_finished"
istr_dwdb[5].col_type = "date"
istr_dwdb[5].dw_header = "Time Finished"

istr_dwdb[6].db_name = "AB_JOB"
istr_dwdb[6].db_field = "NUMBER_OF_MEN_USED"
istr_dwdb[6].dw_column = "number_of_men_used"
istr_dwdb[6].col_type = "number"
istr_dwdb[6].dw_header = "Men#"

istr_dwdb[7].db_name = "AB_JOB"
istr_dwdb[7].db_field = "DUE_DATE"
istr_dwdb[7].dw_column = "due_date"
istr_dwdb[7].col_type = "date"
istr_dwdb[7].dw_header = "Due Date"

istr_dwdb[8].db_name = "AB_JOB"
istr_dwdb[8].db_field = "JOB_STATUS"
istr_dwdb[8].dw_column = "job_status"
istr_dwdb[8].col_type = "status"
istr_dwdb[8].dw_header = "Status"

istr_dwdb[9].db_name = "AB_JOB"
istr_dwdb[9].db_field = "ORDER_ABC_NUM"
istr_dwdb[9].dw_column = "order_abc_num"
istr_dwdb[9].col_type = "number"
istr_dwdb[9].dw_header = "ABCO Order"

istr_dwdb[10].db_name = "AB_JOB"
istr_dwdb[10].db_field = "CREATE_DATE"
istr_dwdb[10].dw_column = "create_date"
istr_dwdb[10].col_type = "date"
istr_dwdb[10].dw_header = "Created Date"


end subroutine

public subroutine wf_reset_condition ();Int li_i
li_i = 1
DO WHILE li_i <= Upperbound(istr_search)
	istr_search[li_i].db_name = ""
	istr_search[li_i].db_field = ""
	istr_search[li_i].operator = ""
	istr_search[li_i].value = ""
	istr_search[li_i].col_type = ""
	li_i++
LOOP

end subroutine

on w_folder_job_search.create
int iCurrent
call super::create
this.ddlb_status=create ddlb_status
this.cb_reset=create cb_reset
this.st_21=create st_21
this.st_20=create st_20
this.em_4=create em_4
this.em_3=create em_3
this.em_2=create em_2
this.st_19=create st_19
this.em_1=create em_1
this.st_18=create st_18
this.st_17=create st_17
this.em_temper=create em_temper
this.em_alloy=create em_alloy
this.st_16=create st_16
this.st_15=create st_15
this.em_desc=create em_desc
this.st_14=create st_14
this.em_line=create em_line
this.st_13=create st_13
this.em_after=create em_after
this.st_12=create st_12
this.em_before=create em_before
this.st_11=create st_11
this.em_id=create em_id
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.dw_job_list=create dw_job_list
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_open=create cb_open
this.gb_1=create gb_1
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.cb_search=create cb_search
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_status
this.Control[iCurrent+2]=this.cb_reset
this.Control[iCurrent+3]=this.st_21
this.Control[iCurrent+4]=this.st_20
this.Control[iCurrent+5]=this.em_4
this.Control[iCurrent+6]=this.em_3
this.Control[iCurrent+7]=this.em_2
this.Control[iCurrent+8]=this.st_19
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.st_18
this.Control[iCurrent+11]=this.st_17
this.Control[iCurrent+12]=this.em_temper
this.Control[iCurrent+13]=this.em_alloy
this.Control[iCurrent+14]=this.st_16
this.Control[iCurrent+15]=this.st_15
this.Control[iCurrent+16]=this.em_desc
this.Control[iCurrent+17]=this.st_14
this.Control[iCurrent+18]=this.em_line
this.Control[iCurrent+19]=this.st_13
this.Control[iCurrent+20]=this.em_after
this.Control[iCurrent+21]=this.st_12
this.Control[iCurrent+22]=this.em_before
this.Control[iCurrent+23]=this.st_11
this.Control[iCurrent+24]=this.em_id
this.Control[iCurrent+25]=this.st_10
this.Control[iCurrent+26]=this.st_9
this.Control[iCurrent+27]=this.st_8
this.Control[iCurrent+28]=this.dw_job_list
this.Control[iCurrent+29]=this.dw_customer
this.Control[iCurrent+30]=this.cb_close
this.Control[iCurrent+31]=this.cb_open
this.Control[iCurrent+32]=this.gb_1
this.Control[iCurrent+33]=this.ddlb_customer
this.Control[iCurrent+34]=this.st_1
this.Control[iCurrent+35]=this.cb_search
this.Control[iCurrent+36]=this.st_2
this.Control[iCurrent+37]=this.st_3
this.Control[iCurrent+38]=this.st_4
this.Control[iCurrent+39]=this.st_5
this.Control[iCurrent+40]=this.st_6
this.Control[iCurrent+41]=this.st_7
end on

on w_folder_job_search.destroy
call super::destroy
destroy(this.ddlb_status)
destroy(this.cb_reset)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.em_4)
destroy(this.em_3)
destroy(this.em_2)
destroy(this.st_19)
destroy(this.em_1)
destroy(this.st_18)
destroy(this.st_17)
destroy(this.em_temper)
destroy(this.em_alloy)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.em_desc)
destroy(this.st_14)
destroy(this.em_line)
destroy(this.st_13)
destroy(this.em_after)
destroy(this.st_12)
destroy(this.em_before)
destroy(this.st_11)
destroy(this.em_id)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.dw_job_list)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_open)
destroy(this.gb_1)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.cb_search)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
end on

event open;call super::open;dw_customer.Visible = FALSE

dw_customer.of_SetLinkage(TRUE)
dw_customer.inv_linkage.of_SetStyle(2)
dw_customer.inv_linkage.of_SetUpdateOnRowChange (True)
dw_customer.inv_linkage.of_SetConfirmOnRowChange (True)

dw_job_list.of_SetLinkage( TRUE ) 
dw_job_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_job_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & skid in win w_inv_skid!" )
ELSE
	dw_job_list.inv_Linkage.of_Register( "customer_id", "customer_order_orig_customer_id" ) 
	dw_job_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_ab_job_list::open function" )
ELSE
	SQLCA.of_Commit()
	dw_customer.SelectRow(1,TRUE)
	wf_display_total_info()
	dw_customer.SetFocus()
End IF

is_select =  "SELECT  ~~~"AB_JOB~~~".~~~"AB_JOB_NUM~~~" , ~~~"AB_JOB~~~".~~~"LINE_NUM~~~" , ~~~"AB_JOB~~~".~~~"ORDER_ITEM_NUM~~~" , ~~~"AB_JOB~~~".~~~"MATERIAL_YIELD~~~" , ~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~" , ~~~"AB_JOB~~~".~~~"TIME_DATE_FINISHED~~~" , ~~~"AB_JOB~~~".~~~"NUMBER_OF_MEN_USED~~~" , ~~~"AB_JOB~~~".~~~"DUE_DATE~~~" ,~~~"AB_JOB~~~".~~~"JOB_STATUS~~~" , ~~~"AB_JOB~~~".~~~"JOB_NOTES~~~" ,~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" , ~~~"AB_JOB~~~".~~~"CREATE_DATE~~~" ,~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" ,~~~"AB_JOB~~~".~~~"SKETCH_ID~~~" ,   ~~~"AB_JOB~~~".~~~"SKETCH_JOB_NOTE~~~"  FROM ~~~"AB_JOB~~~" , ~~~"CUSTOMER_ORDER~~~"    " 
SetNULL(gl_message)

wf_init_dwdb()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)
dw_job_list.SetFocus()


end event

type ddlb_status from dropdownlistbox within w_folder_job_search
integer x = 395
integer y = 736
integer width = 439
integer height = 339
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
string item[] = {"Done","New"}
borderstyle borderstyle = stylelowered!
end type

type cb_reset from u_cb within w_folder_job_search
integer x = 2414
integer y = 717
integer width = 307
integer height = 77
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

type st_21 from statictext within w_folder_job_search
integer x = 1858
integer y = 557
integer width = 69
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "X"
boolean focusrectangle = false
end type

type st_20 from statictext within w_folder_job_search
integer x = 2271
integer y = 557
integer width = 55
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "X"
boolean focusrectangle = false
end type

type em_4 from editmask within w_folder_job_search
integer x = 2337
integer y = 550
integer width = 322
integer height = 74
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "19.685"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type em_3 from editmask within w_folder_job_search
integer x = 1935
integer y = 550
integer width = 322
integer height = 74
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "44.4882"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type em_2 from editmask within w_folder_job_search
integer x = 1525
integer y = 550
integer width = 322
integer height = 74
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = ".29527"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_19 from statictext within w_folder_job_search
integer x = 1211
integer y = 557
integer width = 256
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job Spec:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_folder_job_search
integer x = 1430
integer y = 144
integer width = 1236
integer height = 74
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_18 from statictext within w_folder_job_search
integer x = 1028
integer y = 150
integer width = 384
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Customer PO:"
boolean focusrectangle = false
end type

type st_17 from statictext within w_folder_job_search
integer x = 1872
integer y = 464
integer width = 219
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Temper:"
boolean focusrectangle = false
end type

type em_temper from editmask within w_folder_job_search
integer x = 2099
integer y = 458
integer width = 322
integer height = 74
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "H32"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type em_alloy from editmask within w_folder_job_search
integer x = 1525
integer y = 458
integer width = 322
integer height = 74
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "5052"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_16 from statictext within w_folder_job_search
integer x = 1211
integer y = 464
integer width = 256
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job alloy:"
boolean focusrectangle = false
end type

type st_15 from statictext within w_folder_job_search
integer x = 110
integer y = 742
integer width = 300
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job status:"
boolean focusrectangle = false
end type

type em_desc from editmask within w_folder_job_search
integer x = 1605
integer y = 365
integer width = 1053
integer height = 74
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Apple 7.5 (L-19.685) / 422723"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_14 from statictext within w_folder_job_search
integer x = 1211
integer y = 371
integer width = 384
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job description:"
boolean focusrectangle = false
end type

type em_line from editmask within w_folder_job_search
integer x = 457
integer y = 634
integer width = 322
integer height = 74
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "BL 110"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_13 from statictext within w_folder_job_search
integer x = 110
integer y = 557
integer width = 472
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job finished after:"
boolean focusrectangle = false
end type

type em_after from editmask within w_folder_job_search
integer x = 603
integer y = 550
integer width = 421
integer height = 74
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2010/01/21"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY/MM/DD"
end type

type st_12 from statictext within w_folder_job_search
integer x = 110
integer y = 650
integer width = 472
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job from line:"
boolean focusrectangle = false
end type

type em_before from editmask within w_folder_job_search
integer x = 603
integer y = 458
integer width = 421
integer height = 74
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2010/01/21"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY/MM/DD"
end type

type st_11 from statictext within w_folder_job_search
integer x = 110
integer y = 464
integer width = 472
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job finished before:"
boolean focusrectangle = false
end type

type em_id from editmask within w_folder_job_search
integer x = 315
integer y = 365
integer width = 322
integer height = 74
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "64331"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#########"
end type

type st_10 from statictext within w_folder_job_search
integer x = 110
integer y = 371
integer width = 201
integer height = 61
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Job ID:"
boolean focusrectangle = false
end type

type st_9 from statictext within w_folder_job_search
integer x = 37
integer y = 291
integer width = 453
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "By job information:"
boolean focusrectangle = false
end type

type st_8 from statictext within w_folder_job_search
integer x = 512
integer y = 250
integer width = 1799
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "-------------------------------  AND / OR  ------------------------------------------"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_job_list from u_dw within w_folder_job_search
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 4
integer y = 842
integer width = 2783
integer height = 918
integer taborder = 10
string dataobject = "d_job_list_per_cust_folder"
end type

event type integer ue_search_retrieve();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//integer ls_net
//
//ls_where = wf_search_terms()
//
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
//END IF
//
Return 1
end event

event ue_resume_where();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//
//wf_reset_condition()
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_where = "  WHERE (( ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ) and ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = :al_custome_id ))  "
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to resume datawindow!", StopSign!)
//END IF
//st_cond.Text = "All"
//
end event

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event clicked;//Override pfc's clicked because it is running on wrong sequence
integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

event doubleclicked;IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

SelectRow(row, TRUE)
cb_open.TriggerEvent (clicked!)

end event

type dw_customer from u_dw within w_folder_job_search
integer x = 2666
integer y = 1789
integer width = 95
integer height = 35
integer taborder = 0
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 











end event

event constructor;SetRowFocusIndicator(Hand!) 
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 


end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)
this.ScrollToRow(li_Row)

wf_display_total_info()

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type cb_close from u_cb within w_folder_job_search
string tag = "Exit"
integer x = 1518
integer y = 1850
integer width = 472
integer height = 80
integer taborder = 80
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_open from u_cb within w_folder_job_search
string tag = "Open an order"
integer x = 622
integer y = 1850
integer width = 472
integer height = 80
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Open"
end type

type gb_1 from groupbox within w_folder_job_search
integer x = 4
integer width = 2779
integer height = 835
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Advanced Search Options"
end type

type ddlb_customer from dropdownlistbox within w_folder_job_search
integer x = 33
integer y = 147
integer width = 863
integer height = 995
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		dw_job_list.Event ue_search_retrieve()
		wf_display_total_info()
	END IF
NEXT

end event

type st_1 from statictext within w_folder_job_search
integer x = 37
integer y = 77
integer width = 424
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "By customer:"
boolean focusrectangle = false
end type

type cb_search from u_cb within w_folder_job_search
integer x = 2052
integer y = 717
integer width = 307
integer height = 77
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Search"
end type

event clicked;//OpenWithParm(w_buildfilter, dw_job_list.DataObject)

end event

type st_2 from statictext within w_folder_job_search
integer x = 384
integer y = 1779
integer width = 154
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 79741120
boolean enabled = false
string text = "Done"
boolean focusrectangle = false
end type

type st_3 from statictext within w_folder_job_search
integer x = 549
integer y = 1779
integer width = 252
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_4 from statictext within w_folder_job_search
integer x = 812
integer y = 1779
integer width = 168
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "New"
boolean focusrectangle = false
end type

type st_5 from statictext within w_folder_job_search
integer x = 991
integer y = 1776
integer width = 252
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Canceled"
boolean focusrectangle = false
end type

type st_6 from statictext within w_folder_job_search
integer x = 1254
integer y = 1779
integer width = 252
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_7 from statictext within w_folder_job_search
integer x = 22
integer y = 1779
integer width = 340
integer height = 54
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Color indication:"
boolean focusrectangle = false
end type

