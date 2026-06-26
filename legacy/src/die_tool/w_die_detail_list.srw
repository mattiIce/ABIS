$PBExportHeader$w_die_detail_list.srw
forward
global type w_die_detail_list from w_sheet
end type
type st_lines from statictext within w_die_detail_list
end type
type st_shapes from statictext within w_die_detail_list
end type
type dw_line_4die_sheet_types from datawindow within w_die_detail_list
end type
type cb_getgize from commandbutton within w_die_detail_list
end type
type dw_shapes_4die_id from datawindow within w_die_detail_list
end type
type dw_shapes from datawindow within w_die_detail_list
end type
type dw_die_display from u_dw within w_die_detail_list
end type
type cb_close from u_cb within w_die_detail_list
end type
type cb_print from u_cb within w_die_detail_list
end type
type cb_modify from u_cb within w_die_detail_list
end type
type cb_new from u_cb within w_die_detail_list
end type
type dw_die_detail_list from u_dw within w_die_detail_list
end type
end forward

global type w_die_detail_list from w_sheet
integer width = 5019
integer height = 2132
string title = "Die Information"
boolean resizable = false
event ue_new ( )
event ue_modify ( )
event ue_print ( )
event type string ue_whoami ( )
st_lines st_lines
st_shapes st_shapes
dw_line_4die_sheet_types dw_line_4die_sheet_types
cb_getgize cb_getgize
dw_shapes_4die_id dw_shapes_4die_id
dw_shapes dw_shapes
dw_die_display dw_die_display
cb_close cb_close
cb_print cb_print
cb_modify cb_modify
cb_new cb_new
dw_die_detail_list dw_die_detail_list
end type
global w_die_detail_list w_die_detail_list

type variables
//Boolean	ib_chevron_or_trapezois_selected = False //Alex Gerlants. 07/26/2023. Work_Center
String	is_sql_orig_line_4die_sheet_types, is_shape_list //Alex Gerlants. 07/26/2023. Work_Center
end variables

forward prototypes
public function integer wf_select_shapes ()
public subroutine wf_update_shapes ()
public subroutine wf_retrieve_lines_4die_sheet_types (string as_shape_list)
end prototypes

event ue_new();Long		ll_die_id_new //Alex Gerlants. 03/23/2017
Long		ll_found_row //Alex Gerlants. 03/23/2017
String	ls_find_string //Alex Gerlants. 03/23/2017

openwithparm(w_die_new, 0)		//parm = 0, new
//If Message.DoubleParm = 1 Then dw_die_detail_list.Retrieve()

//Alex Gerlants. 03/23/2017. Begin
ll_die_id_new = Message.DoubleParm

dw_die_detail_list.Retrieve()

If ll_die_id_new > 0 Then
	ls_find_string = "die_id = " + String(ll_die_id_new)
	ll_found_row = dw_die_detail_list.Find(ls_find_string, 1, dw_die_detail_list.RowCount())
	
	If ll_found_row > 0 Then
		dw_die_detail_list.ScrollToRow(ll_found_row)
		dw_die_detail_list.SelectRow(ll_found_row, True)
	End If
	
	dw_die_display.Retrieve(ll_die_id_new)
Else
	
End If
//Alex Gerlants. 03/23/2017. End
end event

event ue_modify();Long		ll_row, ll_id
Long		ll_found_row //Alex Gerlants. 03/23/2017
String	ls_find_string //Alex Gerlants. 03/23/2017

ll_row = dw_die_detail_list.getrow()
if ll_row <= 0 then return

//IF f_security_door("Inventory(Coil)") = 0 THEN RETURN 

ll_id = dw_die_detail_list.GetItemNumber(ll_row, "die_id", Primary!, FALSE)

IF ll_id > 0 THEN OpenWithParm(w_die_new, ll_id)

If Message.DoubleParm = 1 Then 
	dw_die_detail_list.Retrieve()
	
	//Alex Gerlants. 03/23/2017. Begin
	ls_find_string = "die_id = " + String(ll_id)
	ll_found_row = dw_die_detail_list.Find(ls_find_string, 1, dw_die_detail_list.RowCount())
	
	If ll_found_row > 0 Then
		dw_die_detail_list.ScrollToRow(ll_found_row)
		dw_die_detail_list.SelectRow(ll_found_row, True)
	End If
	
	dw_die_display.Retrieve(ll_id)
	//Alex Gerlants. 03/23/2017. End
End If

dw_die_detail_list.SetFocus() //Alex Gerlants. 03/23/2017
	


end event

event ue_print();Printsetup()

datastore lds_print
lds_print = Create datastore

lds_print.dataobject = "d_die_print"
lds_print.SetTransObject(SQLCA)
lds_print.Retrieve()
lds_print.print()
end event

event type string ue_whoami();RETURN "w_die_detail_list"
end event

public function integer wf_select_shapes ();//Alex Gerlants. 03/23/2017. Begin
/*
Function:	wf_select_shapes
Returns:		integer	 1 if OK
							-1 of Db error
Arguments:	none						
*/

Integer		li_rtn = 1, li_row
Long			ll_rows, ll_row, ll_found_row
String		ls_sheet_type, ls_find_string, ls_shape

Integer		li_row_die_detail, li_row_die_display //Alex Gerlants. 07/26/2023. Work_Center
Long			ll_die_id //Alex Gerlants. 07/26/2023. Work_Center
//String		ls_shape_list //Alex Gerlants. 07/26/2023. Work_Center

ll_rows = dw_shapes_4die_id.RowCount()
li_row_die_detail = dw_die_detail_list.GetSelectedRow(0)

If li_row_die_detail > 0 Then
	ll_die_id = dw_die_detail_list.Object.die_id[li_row_die_detail]
	
	ls_find_string = "die_id = " + String(ll_die_id)
	li_row_die_display = dw_die_display.Find(ls_find_string, 1, dw_die_display.RowCount())
	
	If li_row_die_display > 0 Then
		dw_die_display.Object.ind[li_row_die_display] = 0 //Hide Angle Change Minutes
		dw_die_display.SetItemStatus( li_row_die_display, 0, Primary!, NotModified!)
	End If
End If

li_row = dw_die_display.GetRow() //Alex Gerlants. 07/26/2023. Work_Center

If ll_rows > 0 Then
	//is_shape_list = "" //Alex Gerlants. 07/26/2023. Work_Center
	
	For ll_row = 1 To ll_rows
		ls_sheet_type = Trim(dw_shapes_4die_id.Object.sheet_type[ll_row])
		If IsNull(ls_sheet_type) Then ls_sheet_type = ""
		
		ls_find_string = "shape = '" + ls_sheet_type + "'"
		ll_found_row = dw_shapes.Find(ls_find_string, 1, dw_shapes.RowCount())
		
		If ll_found_row > 0 Then
			dw_shapes.SelectRow(ll_found_row, True)
			//is_selected_shapes_db[UpperBound(is_selected_shapes_db[]) + 1] = ls_sheet_type
			is_shape_list = is_shape_list + "'" + ls_sheet_type + "'" + ","
			
			//Alex Gerlants. 07/26/2023. Work_Center. Begin
			//dw_die_display.Object.ind[ll_row] = 0 //Hide Angle Change Minutes
			
			If ls_sheet_type = "Chevron" Or ls_sheet_type = "Trapezoid" Then
				//ib_chevron_or_trapezois_selected = True
				
				If li_row_die_display > 0 Then
					dw_die_display.Object.ind[li_row_die_display] = 1 //Unhide Angle Change Minutes
					dw_die_display.SetItemStatus( li_row_die_display, 0, Primary!, NotModified!)
				End If
			End If
		//Else
		//	dw_die_display.Object.ind[ll_row] = 0 //Hide Angle Change Minutes
		//Alex Gerlants. 07/26/2023. Work_Center. End
		End If
		
		//dw_die_display.SetItemStatus( ll_row, 0, Primary!, NotModified!) //Alex Gerlants. 07/26/2023. Work_Center
	Next
	
	//Alex Gerlants. 07/26/2023. Work_Center. Begin
	If Len(is_shape_list) > 0 Then
		//Remove the last comma
		is_shape_list = Left(is_shape_list, Len(is_shape_list) - 1)
		//is_shape_list = ls_shape_list
	End If
	//Alex Gerlants. 07/26/2023. Work_Center. End
ElseIf ll_rows = 0 Then
	If li_row_die_display > 0 Then
		dw_die_display.Object.ind[li_row_die_display] = 0 //Hide Angle Change Minutes
		dw_die_display.SetItemStatus( li_row_die_display, 0, Primary!, NotModified!)
	End If
Else //ll_rows = -1. DB Error
	//
End If

Return li_rtn
//Alex Gerlants. 03/23/2017. End
end function

public subroutine wf_update_shapes ();//Alex Gerlants. 03/23/2017. Begin
/*
Function:	wf_update_shapes
Returns:		none
Arguments:	none
*/

Long	ll_row, ll_rows, ll_id

is_shape_list = "" //Alex Gerlants. 07/26/2023. Work_Center
dw_line_4die_sheet_types.Reset() //Alex Gerlants. 07/26/2023. Work_Center

ll_row = dw_die_detail_list.GetRow()

If ll_row > 0 Then
	dw_shapes.SetTransObject(sqlca)
	dw_shapes_4die_id.SetTransObject(sqlca)

	ll_id = dw_die_detail_list.Object.die_id[ll_row]
	dw_shapes.Retrieve()
	ll_rows = dw_shapes_4die_id.Retrieve(ll_id)
	//wf_select_shapes()
	
	wf_select_shapes()
	wf_retrieve_lines_4die_sheet_types(is_shape_list) //Alex Gerlants. 08/12/2024. 9999_Work_Center

End If
//Alex Gerlants. 03/23/2017. End
end subroutine

public subroutine wf_retrieve_lines_4die_sheet_types (string as_shape_list);//Alex Gerlants. 07/26/2023. Work_Center. Begin
/*
Function:	wf_retrieve_lines_4die_sheet_types
Returns:		none
Arguments:	value	string	as_shape_list
*/

Integer	li_row_die_detail, li_rows, li_selected_row
Long		ll_die_id
String	ls_sheet_type_list, ls_add_2sql, ls_sql_new

If Len(as_shape_list) <= 0 Then Return

dw_line_4die_sheet_types.SetSqlSelect(is_sql_orig_line_4die_sheet_types)
li_row_die_detail = dw_die_detail_list.GetSelectedRow(0)

If li_row_die_detail > 0 Then
	ll_die_id = dw_die_detail_list.Object.die_id[li_row_die_detail]
	
	ls_add_2sql = "~n~rwhere line_die_4sheet_type.sheet_type in (" + is_shape_list + ")"
	ls_add_2sql = ls_add_2sql + "~n~rand  line_die_4sheet_type.die_id = " + String(ll_die_id)
	ls_add_2sql = ls_add_2sql + "~n~rorder by	to_number(substr(ltrim(rtrim(line_desc)), instr(ltrim(rtrim(line_desc)),' ', 1, 1) + 1, length(ltrim(rtrim(line_desc))) - instr(ltrim(rtrim(line_desc)),' ', 1, 1)))"
	ls_sql_new = is_sql_orig_line_4die_sheet_types + ls_add_2sql

	dw_line_4die_sheet_types.SetSqlSelect(ls_sql_new)
	dw_line_4die_sheet_types.SetTransObject(sqlca)
	li_rows = dw_line_4die_sheet_types.Retrieve()
End If
//Alex Gerlants. 07/26/2023. Work_Center. End
end subroutine

on w_die_detail_list.create
int iCurrent
call super::create
this.st_lines=create st_lines
this.st_shapes=create st_shapes
this.dw_line_4die_sheet_types=create dw_line_4die_sheet_types
this.cb_getgize=create cb_getgize
this.dw_shapes_4die_id=create dw_shapes_4die_id
this.dw_shapes=create dw_shapes
this.dw_die_display=create dw_die_display
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_modify=create cb_modify
this.cb_new=create cb_new
this.dw_die_detail_list=create dw_die_detail_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_lines
this.Control[iCurrent+2]=this.st_shapes
this.Control[iCurrent+3]=this.dw_line_4die_sheet_types
this.Control[iCurrent+4]=this.cb_getgize
this.Control[iCurrent+5]=this.dw_shapes_4die_id
this.Control[iCurrent+6]=this.dw_shapes
this.Control[iCurrent+7]=this.dw_die_display
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_print
this.Control[iCurrent+10]=this.cb_modify
this.Control[iCurrent+11]=this.cb_new
this.Control[iCurrent+12]=this.dw_die_detail_list
end on

on w_die_detail_list.destroy
call super::destroy
destroy(this.st_lines)
destroy(this.st_shapes)
destroy(this.dw_line_4die_sheet_types)
destroy(this.cb_getgize)
destroy(this.dw_shapes_4die_id)
destroy(this.dw_shapes)
destroy(this.dw_die_display)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_modify)
destroy(this.cb_new)
destroy(this.dw_die_detail_list)
end on

event open;call super::open;dw_die_detail_list.SetTransObject(SQLCA)
dw_die_display.SetTransObject(SQLCA)
dw_die_detail_list.Retrieve()

Long ll_row_id, ll_die_id
Integer	li_row //Alex Gerlants. 07/26/2023. Work_Center

//is_sql_orig = dw_line_die_4sheet_type.GetSqlSelect() //Alex Gerlants. 07/26/2023. Work_Center
is_sql_orig_line_4die_sheet_types = dw_line_4die_sheet_types.GetSqlSelect() //Alex Gerlants. 07/26/2023. Work_Center
dw_line_4die_sheet_types.SetTransObject(sqlca) //Alex Gerlants. 07/26/2023. Work_Center

ll_row_id = dw_die_detail_list.GetRow()
ll_die_id = dw_die_detail_list.GetItemNumber(ll_row_id, "die_id")
dw_die_display.Retrieve(ll_die_id)


dw_die_detail_list.of_SetLinkage(TRUE)
dw_die_detail_list.inv_Linkage.of_SetStyle(2)
dw_die_detail_list.inv_linkage.of_SetConfirmOnRowChange (True)
dw_die_detail_list.inv_linkage.of_setUpdateOnRowChange (TRUE)
//dw_die_detail_list.inv_linkage.of_SetTransObject(SQLCA)

dw_die_display.of_SetLinkage( TRUE ) 
dw_die_display.inv_Linkage.of_SetMaster(dw_die_detail_list)
IF NOT dw_die_display.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link die_detail_list & die_display in win w_die_detail_list" )
ELSE
	dw_die_display.inv_Linkage.of_Register( "die_id", "die_id" ) 
	dw_die_display.inv_Linkage.of_SetStyle( dw_die_display.inv_linkage.RETRIEVE ) 
END IF

String	ls_modstring, ls_rtn

ls_modstring = "datawindow.Color='16777215'"
ls_rtn = dw_shapes.Modify (ls_modstring) //Alex Gerlants. 03/23/2017

//Alex Gerlants. 07/26/2023. Work_Center. Begin
li_row = dw_die_display.GetRow()

If li_row > 0 Then
	dw_die_display.Object.ind[li_row] = 0 //Hide Angle Change Minutes
	dw_die_display.SetItemStatus( li_row, 0, Primary!, NotModified!)
End If
//Alex Gerlants. 07/26/2023. Work_Center. End

//wf_update_shapes() //Alex Gerlants. 03/23/2017 ##################################
end event

event pfc_print;call super::pfc_print;Printsetup()

datastore lds_print
lds_print = Create datastore

lds_print.dataobject = "d_die_print"
lds_print.SetTransObject(SQLCA)
lds_print.Retrieve()
lds_print.print()

IF IsValid(lds_print) THEN DESTROY lds_print
return 1
end event

type st_lines from statictext within w_die_detail_list
integer x = 3648
integer y = 1128
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Blanking Lines"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_shapes from statictext within w_die_detail_list
integer x = 3067
integer y = 1128
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shapes"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_line_4die_sheet_types from datawindow within w_die_detail_list
integer x = 3657
integer y = 1184
integer width = 329
integer height = 832
integer taborder = 40
string title = "none"
string dataobject = "d_line_4die_sheet_types"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//is_shape_list = "" //Alex Gerlants. 07/26/2023. Work_Center
end event

type cb_getgize from commandbutton within w_die_detail_list
integer x = 256
integer y = 1920
integer width = 320
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GetSize"
end type

event clicked;MessageBox("", "Window~n~r" + &
					"Parent.X = " + String(Parent.X) + "~n~r" + &
					"Parent.Y = " + String(Parent.Y) + "~n~r" + &
					"Parent.Width = " + String(Parent.Width) + "~n~r" + &
					"Parent.Height = " + String(Parent.Height) + "~n~r~n~r" + &
					"DataWindow~n~r" + &
					"dw_die_detail_list.X = " + String(dw_die_detail_list.X) + "~n~r" + &
					"dw_die_detail_list.Y = " + String(dw_die_detail_list.Y) + "~n~r" + &
					"dw_die_detail_list.Width = " + String(dw_die_detail_list.Width) + "~n~r" + &
					"dw_die_detail_list.Height = " + String(dw_die_detail_list.Height))
end event

type dw_shapes_4die_id from datawindow within w_die_detail_list
boolean visible = false
integer x = 3278
integer y = 1356
integer width = 549
integer height = 320
integer taborder = 40
string title = "none"
string dataobject = "d_shapes_4die_id"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_shapes from datawindow within w_die_detail_list
integer x = 3003
integer y = 1192
integer width = 526
integer height = 844
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "d_shapes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;Long		ll_die_id //Alex Gerlants. 08/12/2024. 9999_Work_Center
String	ls_sheet_type //Alex Gerlants. 08/12/2024. 9999_Work_Center

If row <= 0 Then Return

If IsSelected(row) Then
	SelectRow(row, False)
Else
	SelectRow(row, True)
End If
end event

type dw_die_display from u_dw within w_die_detail_list
integer x = 677
integer y = 1128
integer width = 2331
integer height = 692
integer taborder = 20
string dataobject = "d_die_display"
boolean vscrollbar = false
end type

event retrieveend;call super::retrieveend;wf_update_shapes() //Alex Gerlants. 03/23/2017
end event

type cb_close from u_cb within w_die_detail_list
integer x = 2528
integer y = 1932
integer taborder = 30
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_die_detail_list
integer x = 1906
integer y = 1932
integer taborder = 30
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_modify from u_cb within w_die_detail_list
integer x = 1280
integer y = 1932
integer taborder = 30
string text = "&Modify"
end type

event clicked;call super::clicked;parent.event ue_modify()
end event

type cb_new from u_cb within w_die_detail_list
integer x = 686
integer y = 1932
integer taborder = 20
string text = "&New"
end type

event clicked;call super::clicked;parent.event ue_new()
end event

type dw_die_detail_list from u_dw within w_die_detail_list
integer x = 14
integer y = 124
integer width = 4937
integer height = 1004
integer taborder = 10
string dataobject = "d_die_detail_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event clicked;//Override pfc_clicked

integer 	li_rc
Long		ll_selected_row, ll_die_id_selected, ll_found_row, ll_id, ll_rows //Alex Gerlants. 03/23/2017
String	ls_find_string //Alex Gerlants. 03/23/2017
Integer	li_row //Alex Gerlants. 07/26/2023. Work_Center

is_shape_list = "" //Alex Gerlants. 07/26/2023. Work_Center

//Alex Gerlants. 03/23/2017. Begin
If row <= 0 Then
	ll_selected_row = This.GetSelectedRow(0)
	
	If ll_selected_row > 0 Then
		ll_die_id_selected = This.Object.die_id[ll_selected_row]
	End If
End If
//Alex Gerlants. 03/23/2017. End

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

//Alex Gerlants. 03/23/2017. Begin
//Keep selected row selected, and visible to user after he/she clicks on column header to sort
If row <= 0 Then
	If ll_die_id_selected > 0 Then
		ls_find_string = "die_id = " + String(ll_die_id_selected)
		ll_found_row = This.Find(ls_find_string, 1, This.RowCount())
		
		//MessageBox("Clicked event for dw_die_detail_list", "ll_selected_row = " + String(ll_selected_row) + "~n~rll_die_id_selected = " + String(ll_die_id_selected) + "~n~rls_find_string = " + ls_find_string + "~n~rll_found_row = " + String(ll_found_row))
		
		If ll_found_row > 0 Then
			This.ScrollToRow(ll_found_row)
			This.SelectRow(ll_found_row, True)
		End If
	End If
Else //row > 0
	//Alex Gerlants. 07/26/2023. Work_Center. Begin
	li_row = dw_die_display.GetRow()
	
	If li_row > 0 Then
		dw_die_display.Object.ind[li_row] = 1 //Unhide Angle Change Minutes
	End If
	//Alex Gerlants. 07/26/2023. Work_Center. End

	wf_update_shapes()
End If
//Alex Gerlants. 03/23/2017. End

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF




end event

event doubleclicked;Long		ll_found_row //Alex Gerlants. 03/23/2017
String	ls_find_string //Alex Gerlants. 03/23/2017

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
long ll_id

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

//IF f_security_door("Inventory(Coil)") = 0 THEN RETURN 

ll_id = this.GetItemNumber(row, "die_id", Primary!, FALSE)

IF ll_id > 0 THEN OpenWithParm(w_die_new, ll_id)

If Message.DoubleParm = 1 Then 
	dw_die_detail_list.Retrieve()
	
	//Alex Gerlants. 03/23/2017. Begin
	ls_find_string = "die_id = " + String(ll_id)
	ll_found_row = dw_die_detail_list.Find(ls_find_string, 1, dw_die_detail_list.RowCount())
	
	If ll_found_row > 0 Then
		dw_die_detail_list.ScrollToRow(ll_found_row)
		dw_die_detail_list.SelectRow(ll_found_row, True)
	End If
	
	dw_die_display.Retrieve(ll_id)
	//Alex Gerlants. 03/23/2017. End
End If

This.SetFocus() //Alex Gerlants. 03/23/2017
end event

event retrieveend;call super::retrieveend;////Alex Gerlants. 03/23/2017. Begin
//String	ls_sort, ls_column
//Char 		lc_sort
//
//ls_sort = This.Describe("Datawindow.Table.sort")
//
//If ls_column = Left(ls_sort, Len(ls_sort) - 2) Then 
//	lc_sort = Right(ls_sort, 1)
//
//	If lc_sort = 'A' Then
//		lc_sort = 'D'
//	Else
//		lc_sort = 'A'
//	End If
//	  
//	This.SetSort(ls_column + " " + lc_sort)
//Else
//	This.SetSort(ls_column + " A")
//End If
//
//This.Sort()
////Alex Gerlants. 03/23/2017. End
end event

