$PBExportHeader$w_coil_list_select.srw
$PBExportComments$<Sheet> List all ab jobs and all information about each job, inherited from pfemain\w_sheet
forward
global type w_coil_list_select from w_sheet
end type
type st_2 from statictext within w_coil_list_select
end type
type cb_cancel from commandbutton within w_coil_list_select
end type
type cb_select from commandbutton within w_coil_list_select
end type
type dw_coil_list from u_dw within w_coil_list_select
end type
type dw_customer from u_dw within w_coil_list_select
end type
type ddlb_customer from dropdownlistbox within w_coil_list_select
end type
type st_1 from statictext within w_coil_list_select
end type
end forward

global type w_coil_list_select from w_sheet
integer x = 4
integer y = 3
integer width = 2929
integer height = 1603
string title = "Select Coil ABC Number"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type string ue_whoami ( )
event ue_read_only ( )
st_2 st_2
cb_cancel cb_cancel
cb_select cb_select
dw_coil_list dw_coil_list
dw_customer dw_customer
ddlb_customer ddlb_customer
st_1 st_1
end type
global w_coil_list_select w_coil_list_select

type variables
Long il_old_job
String is_select
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]

end variables

forward prototypes
public function string wf_search_terms ()
public subroutine wf_reset_condition ()
end prototypes

event type string ue_whoami();RETURN "w_coil_list_select"
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

on w_coil_list_select.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_coil_list=create dw_coil_list
this.dw_customer=create dw_customer
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.dw_coil_list
this.Control[iCurrent+5]=this.dw_customer
this.Control[iCurrent+6]=this.ddlb_customer
this.Control[iCurrent+7]=this.st_1
end on

on w_coil_list_select.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_coil_list)
destroy(this.dw_customer)
destroy(this.ddlb_customer)
destroy(this.st_1)
end on

event open;call super::open;dw_customer.Visible = FALSE

dw_customer.of_SetLinkage(TRUE)
dw_customer.inv_linkage.of_SetStyle(2)
dw_customer.inv_linkage.of_SetUpdateOnRowChange (True)
dw_customer.inv_linkage.of_SetConfirmOnRowChange (True)

dw_coil_list.of_SetLinkage( TRUE ) 
dw_coil_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_coil_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & coil in win w_coil_list_select!" )
ELSE
	dw_coil_list.inv_Linkage.of_Register( "customer_id", "customer_order_orig_customer_id" ) 
	dw_coil_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_ab_job_list::open function" )
ELSE
	SQLCA.of_Commit()
	dw_customer.SelectRow(1,TRUE)
	dw_customer.SetFocus()
End IF

//is_select =  "SELECT  ~~~"AB_JOB~~~".~~~"AB_JOB_NUM~~~" , ~~~"AB_JOB~~~".~~~"LINE_NUM~~~" , ~~~"AB_JOB~~~".~~~"ORDER_ITEM_NUM~~~" , ~~~"AB_JOB~~~".~~~"MATERIAL_YIELD~~~" , ~~~"AB_JOB~~~".~~~"TIME_DATE_STARTED~~~" , ~~~"AB_JOB~~~".~~~"TIME_DATE_FINISHED~~~" , ~~~"AB_JOB~~~".~~~"NUMBER_OF_MEN_USED~~~" , ~~~"AB_JOB~~~".~~~"DUE_DATE~~~" ,~~~"AB_JOB~~~".~~~"JOB_STATUS~~~" , ~~~"AB_JOB~~~".~~~"JOB_NOTES~~~" ,~~~"AB_JOB~~~".~~~"ORDER_ABC_NUM~~~" , ~~~"AB_JOB~~~".~~~"CREATE_DATE~~~" ,~~~"CUSTOMER_ORDER~~~".~~~"ORIG_CUSTOMER_ID~~~" ,~~~"AB_JOB~~~".~~~"SKETCH_ID~~~" ,   ~~~"AB_JOB~~~".~~~"SKETCH_JOB_NOTE~~~"  FROM ~~~"AB_JOB~~~" , ~~~"CUSTOMER_ORDER~~~"    " 
SetNULL(gl_message)

//wf_init_dwdb()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)
dw_coil_list.SetFocus()


end event

event pfc_save;dw_coil_list.Update(TRUE, TRUE)
Return 1
end event

event pfc_new;//IF MessageBox("Question", "Create a new production order?", Question!, YesNO!, 1 ) = 2 THEN RETURN
//
//gl_message = 0
//
//SetPointer(HourGlass!)
//Message.StringParm = "w_production" 
//gnv_app.of_getFrame().Event pfc_open()
//Close(this)
end event

event close;call super::close;//f_display_app()
end event

event activate;call super::activate;IF f_security_door("Production Control") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type st_2 from statictext within w_coil_list_select
integer x = 702
integer y = 26
integer width = 424
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Coil List:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_coil_list_select
integer x = 1785
integer y = 1331
integer width = 369
integer height = 99
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;close(parent)
end event

type cb_select from commandbutton within w_coil_list_select
integer x = 936
integer y = 1331
integer width = 369
integer height = 99
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Select"
end type

event clicked;SetPointer(HourGlass!)

Int li_rc
Long ll_row

ll_row = dw_coil_list.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an order first!", StopSign! )
	RETURN
END IF

Long ll_return 
ll_return = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num" )
ClosewithReturn(Parent, ll_return)
end event

type dw_coil_list from u_dw within w_coil_list_select
integer x = 702
integer y = 102
integer width = 2136
integer height = 1178
integer taborder = 10
string dataobject = "d_coil_list_select"
boolean hscrollbar = true
end type

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

type dw_customer from u_dw within w_coil_list_select
boolean visible = false
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

//wf_display_total_info()

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type ddlb_customer from dropdownlistbox within w_coil_list_select
integer x = 29
integer y = 102
integer width = 614
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
Long ll_row, ll_i, ll_cust

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")	
		dw_coil_list.Retrieve(ll_cust)
	END IF
NEXT

end event

type st_1 from statictext within w_coil_list_select
integer x = 29
integer y = 22
integer width = 424
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Customer:"
boolean focusrectangle = false
end type

