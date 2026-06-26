$PBExportHeader$w_ab_job_list_scan.srw
$PBExportComments$<Sheet> List all ab jobs and all information about each job, inherited from pfemain\w_sheet
forward
global type w_ab_job_list_scan from w_sheet
end type
type st_8 from statictext within w_ab_job_list_scan
end type
type cb_cancel from commandbutton within w_ab_job_list_scan
end type
type cb_select from commandbutton within w_ab_job_list_scan
end type
type dw_job_list from u_dw within w_ab_job_list_scan
end type
type cb_report from u_cb within w_ab_job_list_scan
end type
type dw_customer from u_dw within w_ab_job_list_scan
end type
type cb_close from u_cb within w_ab_job_list_scan
end type
type cb_sort from u_cb within w_ab_job_list_scan
end type
type cb_open from u_cb within w_ab_job_list_scan
end type
type gb_1 from groupbox within w_ab_job_list_scan
end type
type ddlb_customer from dropdownlistbox within w_ab_job_list_scan
end type
type st_1 from statictext within w_ab_job_list_scan
end type
type st_cond from statictext within w_ab_job_list_scan
end type
type cb_search from u_cb within w_ab_job_list_scan
end type
type cb_reset from u_cb within w_ab_job_list_scan
end type
type st_2 from statictext within w_ab_job_list_scan
end type
type st_3 from statictext within w_ab_job_list_scan
end type
type st_4 from statictext within w_ab_job_list_scan
end type
type st_5 from statictext within w_ab_job_list_scan
end type
type st_6 from statictext within w_ab_job_list_scan
end type
type st_7 from statictext within w_ab_job_list_scan
end type
end forward

global type w_ab_job_list_scan from w_sheet
integer x = 4
integer y = 3
integer width = 2798
integer height = 1661
string title = "AB Job List"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_sort ( )
event ue_openorder ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
st_8 st_8
cb_cancel cb_cancel
cb_select cb_select
dw_job_list dw_job_list
cb_report cb_report
dw_customer dw_customer
cb_close cb_close
cb_sort cb_sort
cb_open cb_open
gb_1 gb_1
ddlb_customer ddlb_customer
st_1 st_1
st_cond st_cond
cb_search cb_search
cb_reset cb_reset
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
end type
global w_ab_job_list_scan w_ab_job_list_scan

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

event ue_sort;call super::ue_sort;String ls_null

SetNULL(ls_null)
dw_job_list.inv_sort.of_SetSort(ls_null)
dw_job_list.inv_sort.of_Sort()
end event

event ue_openorder();SetPointer(HourGlass!)

Int li_rc
Long ll_row

ll_row = dw_job_list.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an order first!", StopSign! )
	RETURN
END IF

Long ll_return 
ll_return = dw_job_list.GetItemNumber(ll_row, "ab_job_num" )
ClosewithReturn(this, ll_return)

//SetPointer(HourGlass!)
//Message.StringParm = "w_production" 
//gnv_app.of_getFrame().Event pfc_open()

end event

event type string ue_whoami();RETURN "w_ab_job_list_scan"
end event

event ue_set_search;Long ll_row, ll_l
String ls_s
Int li_i, li_s

ll_row = adw_d.RowCount()
IF ll_row < 1 THEN RETURN
FOR ll_l = 1 TO ll_row
	IF Len(ls_s) > 1 THEN ls_s = ls_s + ', '
	ls_s = ls_s + adw_d.getItemString(ll_l, "column_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
NEXT
st_cond.Text = ls_s

wf_reset_condition()

li_s = 1
FOR ll_l = 1 TO ll_row
	li_i = 1
	DO WHILE li_i <= Upperbound(istr_dwdb)
		IF istr_dwdb[li_i].dw_header = adw_d.getItemString(ll_l, "column_t", Primary!, FALSE) THEN
			istr_search[li_s].db_name = istr_dwdb[li_i].db_name
			istr_search[li_s].db_field = istr_dwdb[li_i].db_field
			istr_search[li_s].col_type = istr_dwdb[li_i].col_type
			istr_search[li_s].operator = adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
			istr_search[li_s].value = adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
			IF istr_search[li_s].col_type = "status" THEN
					CHOOSE CASE Upper(Trim(istr_search[li_s].value))
					CASE "DONE"
						istr_search[li_s].value = "0"
					CASE "INPROCESS"
						istr_search[li_s].value = "1"					
					CASE "NEW"
						istr_search[li_s].value = "2"					
					CASE "CANCELED"
						istr_search[li_s].value = "3"					
					CASE "ONHOLD"
						istr_search[li_s].value = "4"					
					CASE ELSE
						istr_search[li_s].value = "9999"
				END CHOOSE
			END IF
			IF istr_search[li_s].col_type = "line" THEN
					CHOOSE CASE Upper(Trim(istr_search[li_s].value))
					CASE "BL 24"
						istr_search[li_s].value = "1"
					CASE "BL 36"
						istr_search[li_s].value = "2"					
					CASE "BL 60"
						istr_search[li_s].value = "3"					
					CASE "BL 78"
						istr_search[li_s].value = "4"					
					CASE "BL 108"
						istr_search[li_s].value = "5"					
					CASE "BL 110"
						istr_search[li_s].value = "6"
					CASE "BL 84"
						istr_search[li_s].value = "7"		
				END CHOOSE
			END IF
			li_s++
		END IF
	li_i++
	LOOP
NEXT

dw_job_list.Event ue_search_retrieve()

end event

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

public function integer wf_display_total_info ();String ls_where, ls_select
Long ll_item

ls_where = wf_display_total_terms()
IF IsNULL(ls_where) THEN RETURN 0

CONNECT USING SQLCA;

ls_select = "SELECT COUNT(ab_job.ab_job_num) FROM ab_job, customer_order "

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
String ls_Mysql
ls_Mysql = ls_select + ls_where
PREPARE SQLSA FROM :ls_Mysql;
OPEN DYNAMIC my_cursor;
FETCH my_cursor INTO :ll_item;
CLOSE my_cursor ;

IF IsNULL(ll_item) THEN ll_item = 0

IF ll_item < 2 THEN
	dw_job_list.Object.item_t.Text = String(ll_item, "#,###,###") 
	dw_job_list.Object.order_t.Text = "Prod. order"
ELSE
	dw_job_list.Object.item_t.Text = String(ll_item, "#,###,###")
	dw_job_list.Object.order_t.Text = "Prod orders" 
END IF	

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

on w_ab_job_list_scan.create
int iCurrent
call super::create
this.st_8=create st_8
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_job_list=create dw_job_list
this.cb_report=create cb_report
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_sort=create cb_sort
this.cb_open=create cb_open
this.gb_1=create gb_1
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.st_cond=create st_cond
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_8
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.dw_job_list
this.Control[iCurrent+5]=this.cb_report
this.Control[iCurrent+6]=this.dw_customer
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_sort
this.Control[iCurrent+9]=this.cb_open
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.ddlb_customer
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_cond
this.Control[iCurrent+14]=this.cb_search
this.Control[iCurrent+15]=this.cb_reset
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.st_5
this.Control[iCurrent+20]=this.st_6
this.Control[iCurrent+21]=this.st_7
end on

on w_ab_job_list_scan.destroy
call super::destroy
destroy(this.st_8)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_job_list)
destroy(this.cb_report)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_sort)
destroy(this.cb_open)
destroy(this.gb_1)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.st_cond)
destroy(this.cb_search)
destroy(this.cb_reset)
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

event pfc_print;IF MessageBox("Question", "Print out current job list?", Question!, OKCancel!, 1) = 1 THEN
	Return dw_job_list.Event pfc_print()
END IF

RETURN 0

end event

event pfc_save;dw_job_list.Update(TRUE, TRUE)
Return 1
end event

event pfc_new;IF MessageBox("Question", "Create a new production order?", Question!, YesNO!, 1 ) = 2 THEN RETURN

gl_message = 0

SetPointer(HourGlass!)
Message.StringParm = "w_production" 
gnv_app.of_getFrame().Event pfc_open()
Close(this)
end event

event close;call super::close;//f_display_app()
end event

event activate;call super::activate;IF f_security_door("Production Control") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type st_8 from statictext within w_ab_job_list_scan
integer x = 790
integer y = 22
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
string text = "AB Job List:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_ab_job_list_scan
integer x = 1989
integer y = 1434
integer width = 380
integer height = 77
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;close(parent)
end event

type cb_select from commandbutton within w_ab_job_list_scan
integer x = 1229
integer y = 1434
integer width = 380
integer height = 77
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Select"
end type

event clicked;Parent.Event ue_openorder()
end event

type dw_job_list from u_dw within w_ab_job_list_scan
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 790
integer y = 102
integer width = 1989
integer height = 1178
integer taborder = 10
string dataobject = "d_ab_job_list_per_cust"
boolean hscrollbar = true
end type

event ue_search_retrieve;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

ls_where = wf_search_terms()

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

Return 1
end event

event ue_resume_where;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_where = "  WHERE (( ~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" = ~~~"CUSTOMER_ORDER~~~".~~~"ORDER_ABC_NUM~~~" ) and ( ~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" = :al_custome_id ))  "
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

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

type cb_report from u_cb within w_ab_job_list_scan
boolean visible = false
integer x = 380
integer y = 1843
integer width = 146
integer height = 77
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Print"
end type

event clicked;SetPointer(HourGlass!)
Parent.Event pfc_print()
end event

type dw_customer from u_dw within w_ab_job_list_scan
integer x = 2458
integer y = 26
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

type cb_close from u_cb within w_ab_job_list_scan
string tag = "Exit"
boolean visible = false
integer x = 2370
integer y = 1434
integer width = 380
integer height = 77
integer taborder = 80
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_sort from u_cb within w_ab_job_list_scan
event clicked pbm_bnclicked
string tag = "sort the list"
boolean visible = false
integer x = 205
integer y = 1843
integer width = 146
integer height = 77
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
boolean enabled = false
string text = "&Sort"
end type

event clicked;SetPointer(HourGlass!)
Parent.Event ue_sort()

end event

type cb_open from u_cb within w_ab_job_list_scan
string tag = "Open an order"
boolean visible = false
integer x = 29
integer y = 1843
integer width = 146
integer height = 77
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Open"
end type

event clicked;parent.Event ue_openorder()
end event

type gb_1 from groupbox within w_ab_job_list_scan
boolean visible = false
integer x = 768
integer width = 2015
integer height = 198
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Search"
end type

type ddlb_customer from dropdownlistbox within w_ab_job_list_scan
integer x = 29
integer y = 102
integer width = 702
integer height = 1178
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

type st_1 from statictext within w_ab_job_list_scan
integer x = 29
integer y = 22
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
string text = "Customer List:"
boolean focusrectangle = false
end type

type st_cond from statictext within w_ab_job_list_scan
boolean visible = false
integer x = 823
integer y = 54
integer width = 1682
integer height = 131
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
string text = "All"
boolean focusrectangle = false
end type

type cb_search from u_cb within w_ab_job_list_scan
boolean visible = false
integer x = 2527
integer y = 42
integer width = 230
integer height = 67
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Search"
end type

event clicked;OpenWithParm(w_buildfilter, dw_job_list.DataObject)

end event

type cb_reset from u_cb within w_ab_job_list_scan
boolean visible = false
integer x = 2527
integer y = 118
integer width = 230
integer height = 67
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;dw_job_list.Event ue_resume_where()
end event

type st_2 from statictext within w_ab_job_list_scan
integer x = 1141
integer y = 1306
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

type st_3 from statictext within w_ab_job_list_scan
integer x = 1287
integer y = 1306
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

type st_4 from statictext within w_ab_job_list_scan
integer x = 1551
integer y = 1306
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

type st_5 from statictext within w_ab_job_list_scan
integer x = 1726
integer y = 1306
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

type st_6 from statictext within w_ab_job_list_scan
integer x = 1989
integer y = 1306
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

type st_7 from statictext within w_ab_job_list_scan
integer x = 761
integer y = 1306
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

