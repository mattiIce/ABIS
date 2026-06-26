$PBExportHeader$w_qa_email_group.srw
forward
global type w_qa_email_group from window
end type
type dw_dddw_qa_email_group from datawindow within w_qa_email_group
end type
type cb_save_new_group from commandbutton within w_qa_email_group
end type
type st_add_email_group from statictext within w_qa_email_group
end type
type sle_group_name from singlelineedit within w_qa_email_group
end type
type cb_delete_email from commandbutton within w_qa_email_group
end type
type cb_delete_group from commandbutton within w_qa_email_group
end type
type cb_close from commandbutton within w_qa_email_group
end type
type cb_add_email from commandbutton within w_qa_email_group
end type
type st_2 from statictext within w_qa_email_group
end type
type st_enter_new_group_name from statictext within w_qa_email_group
end type
type dw_qa_email_group_detail from datawindow within w_qa_email_group
end type
end forward

global type w_qa_email_group from window
integer width = 2926
integer height = 1181
boolean titlebar = true
string title = "Create/Modify Email Groups"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_dddw_qa_email_group dw_dddw_qa_email_group
cb_save_new_group cb_save_new_group
st_add_email_group st_add_email_group
sle_group_name sle_group_name
cb_delete_email cb_delete_email
cb_delete_group cb_delete_group
cb_close cb_close
cb_add_email cb_add_email
st_2 st_2
st_enter_new_group_name st_enter_new_group_name
dw_qa_email_group_detail dw_qa_email_group_detail
end type
global w_qa_email_group w_qa_email_group

type variables
Integer	ii_qa_email_group_row, ii_qa_email_group_id
Boolean	ib_user_wants_2save = True
end variables

forward prototypes
public function integer wf_datamodified ()
public subroutine wf_retrieve_group_dropdown ()
public function boolean wf_validate_group_name (string as_group_name)
end prototypes

public function integer wf_datamodified ();/*
Function:	wf_datamodified
Returns:		integer	<==	0 if data not modified
									1 if data modified
Arguments:	none
*/

Integer			li_rows, li_row, li_datamodified = 0
dwItemStatus	l_dwItemStatus 

dw_qa_email_group_detail.AcceptText()

//li_rows = dw_qa_email_group.RowCount()
//
//For li_row = 1 To li_rows
//	l_dwItemStatus = dw_qa_email_group.GetItemStatus(li_row, "qa_email_group_name", Primary!)
//	
//	If l_dwItemStatus = DataModified! Or l_dwItemStatus = NewModified! Then
//		li_datamodified = 1
//		Exit
//	End If
//Next

If li_datamodified = 0 Then
	li_rows = dw_qa_email_group_detail.RowCount()

	For li_row = 1 To li_rows
		l_dwItemStatus = dw_qa_email_group_detail.GetItemStatus(li_row, "qa_email_group_detail_address", Primary!)
		
		If l_dwItemStatus = DataModified! Or l_dwItemStatus = NewModified! Then
			li_datamodified = 1
			Exit
		End If
	Next
End If

Return li_datamodified
end function

public subroutine wf_retrieve_group_dropdown ();/*
Function:	wf_retrieve_group_dropdown
Returns:		none
Arguments:	none
*/

Integer				li_insertedrow, li_rtn, li_rows
String				ls_login_id
DataWindowChild	ldwc

li_rtn = dw_dddw_qa_email_group.GetChild("qa_email_group_name", ldwc)
	
If li_rtn = 1 Then
	ldwc.SetTransObject(sqlca)
	ls_login_id = sqlca.logid
	li_rows = ldwc.Retrieve(ls_login_id)
	
	li_insertedrow = ldwc.InsertRow(0)
	
	If li_insertedrow > 0 Then
		ldwc.SetItem(li_insertedrow, "qa_email_group_id", 0)
		ldwc.SetItem(li_insertedrow, "qa_email_group_name", "New")
	End If
	
	dw_dddw_qa_email_group.Object.qa_email_group_id[1] = 0
	//dw_dddw_qa_email_group.Object.qa_email_group_name[1] = "New"
	
End If
end subroutine

public function boolean wf_validate_group_name (string as_group_name);/*
Function:	wf_validate_group_name
Returns:		Boolean	<==	True  if group name exists in group name drop-down
									False if group name does not exist in group name drop-down
Arguments:	value	string	as_group_name
*/

Integer				li_rtn, li_rows, li_row
String				ls_temp
DataWindowChild	ldwc
Boolean				lb_group_name_exists = False

li_rtn = dw_dddw_qa_email_group.GetChild("qa_email_group_name", ldwc)
	
If li_rtn = 1 Then
	li_rows = ldwc.RowCount()
	
	If li_rows > 0 Then
		For li_row = 1 To li_rows
			ls_temp = ldwc.GetItemString(li_row, "qa_email_group_name")
			
			If Trim(ls_temp) = Trim(as_group_name) Then
				lb_group_name_exists = True
			End If
		Next
	End If
End If

Return lb_group_name_exists
end function

on w_qa_email_group.create
this.dw_dddw_qa_email_group=create dw_dddw_qa_email_group
this.cb_save_new_group=create cb_save_new_group
this.st_add_email_group=create st_add_email_group
this.sle_group_name=create sle_group_name
this.cb_delete_email=create cb_delete_email
this.cb_delete_group=create cb_delete_group
this.cb_close=create cb_close
this.cb_add_email=create cb_add_email
this.st_2=create st_2
this.st_enter_new_group_name=create st_enter_new_group_name
this.dw_qa_email_group_detail=create dw_qa_email_group_detail
this.Control[]={this.dw_dddw_qa_email_group,&
this.cb_save_new_group,&
this.st_add_email_group,&
this.sle_group_name,&
this.cb_delete_email,&
this.cb_delete_group,&
this.cb_close,&
this.cb_add_email,&
this.st_2,&
this.st_enter_new_group_name,&
this.dw_qa_email_group_detail}
end on

on w_qa_email_group.destroy
destroy(this.dw_dddw_qa_email_group)
destroy(this.cb_save_new_group)
destroy(this.st_add_email_group)
destroy(this.sle_group_name)
destroy(this.cb_delete_email)
destroy(this.cb_delete_group)
destroy(this.cb_close)
destroy(this.cb_add_email)
destroy(this.st_2)
destroy(this.st_enter_new_group_name)
destroy(this.dw_qa_email_group_detail)
end on

event open;Integer				li_rows, li_rtn, li_insertedrow
DataWindowChild	ldwc

sle_group_name.Visible = False
st_add_email_group.Visible = False
st_enter_new_group_name.Visible = False

//dw_qa_email_group.SetTransObject(sqlca)
dw_qa_email_group_detail.SetTransObject(sqlca)
dw_dddw_qa_email_group.InsertRow(0)

wf_retrieve_group_dropdown() //Retrieve group drop-down
cb_delete_group.Visible = False

//li_rtn = dw_dddw_qa_email_group.GetChild("qa_email_group_name", ldwc)
//	
//If li_rtn = 1 Then
//	ldwc.SetTransObject(sqlca)
//	li_rows = ldwc.Retrieve()
//	
//	li_insertedrow = ldwc.InsertRow(0)
//	
//	If li_insertedrow > 0 Then
//		ldwc.SetItem(li_insertedrow, "qa_email_group_id", 0)
//		ldwc.SetItem(li_insertedrow, "qa_email_group_name", "New")
//	End If
//End If

//li_rows = dw_qa_email_group.Retrieve()
//
//If li_rows > 0 Then
//	dw_qa_email_group.SelectRow(1, True)
//	ii_qa_email_group_row = 1
//	li_rows = dw_qa_email_group_detail.Retrieve(ii_qa_email_group_row)
//End If
end event

event closequery;If Not ib_user_wants_2save Then
	Return 0 //Close window
End If
end event

type dw_dddw_qa_email_group from datawindow within w_qa_email_group
integer x = 135
integer y = 64
integer width = 1353
integer height = 93
integer taborder = 40
string title = "none"
string dataobject = "dddw_qa_email_group"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String	ls_group_name
Integer	li_qa_email_group_id

li_qa_email_group_id = Integer(data)
This.Object.qa_email_group_id[1] = li_qa_email_group_id
dw_qa_email_group_detail.Retrieve(li_qa_email_group_id)

If li_qa_email_group_id > 0 Then
	sle_group_name.Visible = False
	st_add_email_group.Visible = False
	st_enter_new_group_name.Visible = False
	cb_delete_group.Visible = True
Else
	sle_group_name.Visible = True
	st_add_email_group.Visible = True
	st_enter_new_group_name.Visible = True
	cb_delete_group.Visible = False
	dw_qa_email_group_detail.Reset()
	sle_group_name.SetFocus()
End If

//ls_group_name = This.Object.qa_email_group_name[1]
//
//If IsNull(ls_group_name) Then ls_group_name = ""
//
//If Len(ls_group_name) > 0 Then
//	select	qa_email_group_id
//	into		:ii_qa_email_group_id
//	from		qa_email_group
//	where		qa_email_group_name = :ls_group_name
//	using		sqlca;
//	
//	If sqlca.sqlcode = 0 Then //Group found
//		dw_qa_email_group_detail.Retrieve(ii_qa_email_group_id)
//	Else
//		If sqlca.sqlcode = 100 Then //Group not found
//			//ii_qa_email_group_id = -99
//			dw_qa_email_group_detail.Reset()
//		Else //DB error
//			MessageBox("DB error", "Database error in Clicked event for cb_retrieve of w_qa_email_group while retrieving Group Id from table qa_email_group." + &
//											"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
//		End If
//	End If
//End If
end event

type cb_save_new_group from commandbutton within w_qa_email_group
integer x = 2414
integer y = 819
integer width = 322
integer height = 90
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;String	ls_group_name, ls_email_address, ls_qa_email_group_name, ls_login_id, ls_address, ls_address_prev
Integer	li_qa_email_group_id, li_rows, li_row, li_rtn, li_count

Integer				li_insertedrow
DataWindowChild	ldwc
String				ls_null

If dw_qa_email_group_detail.RowCount() <= 0 Then Return

dw_dddw_qa_email_group.AcceptText()
dw_qa_email_group_detail.AcceptText()
li_rows = dw_qa_email_group_detail.RowCount()

//Check for duplicate email adresses
dw_qa_email_group_detail.SetSort("qa_email_group_detail_address A")
dw_qa_email_group_detail.Sort()
ls_address_prev = ""

For li_row = li_rows To 1 Step -1
	ls_address = dw_qa_email_group_detail.Object.qa_email_group_detail_address[li_row]
	
	If ls_address = ls_address_prev Then
		dw_qa_email_group_detail.DeleteRow(li_row)
	End If
	
	ls_address_prev = ls_address
Next


//ls_qa_email_group_name = dw_dddw_qa_email_group.Object.qa_email_group_name[1]
li_qa_email_group_id = dw_dddw_qa_email_group.Object.qa_email_group_id[1]

//IF IsNull(li_qa_email_group_id) And IsNumber(ls_qa_email_group_name) Then
//	li_qa_email_group_id = Integer(ls_qa_email_group_name)
//End If

//If ls_qa_email_group_name = "0" Then //New
If li_qa_email_group_id = 0 Then //New
	ls_group_name = sle_group_name.Text
	
	select	nvl(max(qa_email_group_id), 0)
	into		:li_qa_email_group_id
	from		qa_email_group
	using		sqlca;
	
	li_qa_email_group_id++
Else
	//li_qa_email_group_id = Integer(ls_qa_email_group_name)
End If

For li_row = 1 To dw_qa_email_group_detail.RowCount()
	dw_qa_email_group_detail.Object.qa_email_group_id[li_row] = li_qa_email_group_id
Next

li_rtn = dw_qa_email_group_detail.Update()

//li_rows = dw_qa_email_group_detail.RowCount()
//
//For li_row = 1 To li_rows
//	//dw_qa_email_group_detail.Object.qa_email_group_id[li_row] = li_qa_email_group_id
//	
//	ls_email_address = dw_qa_email_group_detail.Object.qa_email_group_detail_address[li_row]
//	
//	insert into qa_email_group_detail
//	values (:li_qa_email_group_id, :ls_email_address)
//	using sqlca;
//Next

If li_rtn = 1 Then //OK
	select	count(*)
	into		:li_count
	from		qa_email_group
	where		qa_email_group_id = :li_qa_email_group_id
	using		sqlca;

	If li_count = 0 Then //Group does not exist
		ls_login_id = sqlca.logid
	
		insert into qa_email_group
		values (:ls_login_id, :li_qa_email_group_id, :ls_group_name)
		using	sqlca;
		
		If sqlca.sqlcode = 0 Then
			commit using sqlca;
			MessageBox("Data saved", "Data saved successfully")
		Else
			rollback using sqlca;
			MessageBox("Data save failed", "Data save failed~n~r~n~rError~n~r" + sqlca.sqlerrtext)
		End If
	Else //Group exists
		commit using sqlca;
		MessageBox("Data saved", "Data saved successfully")
		//ls_group_name = dw_dddw_qa_email_group.Object.qa_email_group_name[1]
	End If
Else //li_rtn <> 1
	rollback using sqlca;
	MessageBox("Data save failed", "Data save failed~n~r~n~rError~n~r" + sqlca.sqlerrtext)
End If

wf_retrieve_group_dropdown() //Re-retrieve drop-down

select	qa_email_group_name
into		:ls_group_name
from		qa_email_group
where		qa_email_group_id = :li_qa_email_group_id
using		sqlca;

li_qa_email_group_id = dw_qa_email_group_detail.Object.qa_email_group_id[1]
dw_dddw_qa_email_group.Object.qa_email_group_id[1] = li_qa_email_group_id
dw_dddw_qa_email_group.Object.qa_email_group_name[1] = ls_group_name
//dw_qa_email_group_detail.Reset() //Clear detail window

sle_group_name.Visible = False
st_add_email_group.Visible = False
st_enter_new_group_name.Visible = False
sle_group_name.Text = ""
cb_delete_group.Visible = True
//SetNull(ls_null)
//dw_dddw_qa_email_group.Object.qa_email_group_name[1] = ls_null















//dw_qa_email_group.AcceptText()
//dw_qa_email_group_detail.AcceptText()
//
//ls_qa_email_group_name = dw_qa_email_group.Object.qa_email_group_name[ii_qa_email_group_row]
//
//If IsNull(ls_qa_email_group_name) Then ls_qa_email_group_name = ""
//
//If ls_qa_email_group_name = "" Then
//	//MessageBox("Data error", "Please enter group name", StopSign!)
//	//Return
//	dw_qa_email_group.DeleteRow(ii_qa_email_group_row)
//End If
//
//li_last_row = dw_qa_email_group_detail.RowCount()
//
//If li_last_row > 0 Then
//	ls_qa_email_group_detail_address = dw_qa_email_group_detail.Object.qa_email_group_detail_address[li_last_row]
//	
//	If IsNull(ls_qa_email_group_detail_address) Then
//		//MessageBox("Data error", "Please enter email address", StopSign!)
//		//Return
//		dw_qa_email_group_detail.DeleteRow(li_last_row)
//	End If
//End If
//
//li_rows = dw_qa_email_group_detail.RowCount()
//
//For li_row = 1 To li_rows
//	dw_qa_email_group_detail.Object.qa_email_group_id[li_row] = ii_qa_email_group_id
//Next
//
//li_rtn = dw_qa_email_group.Update()
//
//If li_rtn = 1 Then //OK
//	li_rtn = dw_qa_email_group_detail.Update()
//	
//	If li_rtn = 1 Then //OK
//		commit using sqlca;
//		
//		li_rows = dw_qa_email_group.Retrieve()
//		li_rows = dw_qa_email_group_detail.Retrieve(ii_qa_email_group_row)
//	Else
//		rollBack Using sqlca;
//		//Error message is in dberror event
//	End If
//Else
//	rollBack Using sqlca;
//	//Error message is in dberror event
//End If
//
end event

type st_add_email_group from statictext within w_qa_email_group
integer x = 146
integer y = 413
integer width = 702
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Add Email Group"
boolean focusrectangle = false
end type

type sle_group_name from singlelineedit within w_qa_email_group
integer x = 150
integer y = 544
integer width = 1284
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;//Integer				li_rtn, li_rows, li_row
//String				ls_group_name, ls_temp
//DataWindowChild	ldwc
//
//ls_group_name = This.Text
//
//li_rtn = dw_dddw_qa_email_group.GetChild("qa_email_group_name", ldwc)
//	
//If li_rtn = 1 Then
//	li_rows = ldwc.RowCount()
//	
//	If li_rows > 0 Then
//		For li_row = 1 To li_rows
//			ls_temp = ldwc.GetItemString(li_row, "qa_email_group_name")
//			
//			If Trim(ls_temp) = Trim(ls_group_name) Then
//				MessageBox("Data error", "Group name " + Trim(ls_group_name) + " already exists.~n~rPlease enter another group name.", StopSign!)
//				//This.Text = ""
//			End If
//		Next
//	End If
//End If
end event

event losefocus;Integer	li_rtn
String	ls_group_name
Boolean	lb_group_name_exists

ls_group_name = This.Text

lb_group_name_exists = wf_validate_group_name(ls_group_name)

If lb_group_name_exists Then
	//ib_group_name_exists = True
	MessageBox("Data error", "Group name " + Trim(ls_group_name) + " already exists.~n~rPlease enter another group name.", StopSign!)
//Else
//	ib_group_name_exists = False
End If
end event

type cb_delete_email from commandbutton within w_qa_email_group
integer x = 2041
integer y = 819
integer width = 322
integer height = 90
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete Email"
end type

event clicked;Integer	li_selected_row, li_answer
String	ls_email_address

li_selected_row = dw_qa_email_group_detail.GetSelectedRow(0)

If li_selected_row > 0 Then
	ls_email_address = dw_qa_email_group_detail.Object.qa_email_group_detail_address[li_selected_row]
	li_answer = MessageBox("Are you sure?", "Do you really want to delete email address " + ls_email_address + "?", Question!, YesNo!, 2)
	
	If li_answer = 1 Then
		dw_qa_email_group_detail.DeleteRow(li_selected_row)
	End If
Else
	MessageBox("No selected row", "Please select an email address to delete")
End If
end event

type cb_delete_group from commandbutton within w_qa_email_group
integer x = 135
integer y = 170
integer width = 322
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete Group"
end type

event clicked;Integer		li_selected_row, li_answer, li_qa_email_group_id, li_rows, li_row, li_rtn
String		ls_qa_email_group_name, ls_null
DataStore	lds_qa_email_group_detail

li_qa_email_group_id = Integer(dw_dddw_qa_email_group.Object.qa_email_group_name[1])

select	qa_email_group_name
into		:ls_qa_email_group_name
from		qa_email_group
where		qa_email_group_id = :li_qa_email_group_id
using		sqlca;

li_answer = MessageBox("Are you sure?", "Do you really want to delete group " + ls_qa_email_group_name + & 
													", and all email addresses associated with this group?", Question!, YesNo!, 2)

If li_answer = 1 Then
	lds_qa_email_group_detail = Create DataStore
	lds_qa_email_group_detail.DataObject = "d_qa_email_group_detail"
	lds_qa_email_group_detail.SetTransObject(sqlca)
	li_rows = lds_qa_email_group_detail.Retrieve(li_qa_email_group_id)
	
	For li_row = li_rows To 1 Step -1
		lds_qa_email_group_detail.DeleteRow(li_row)
	Next
	
	li_rtn = lds_qa_email_group_detail.Update()
	
	If li_rtn = 1 Then //OK
		delete from qa_email_group where qa_email_group_id = :li_qa_email_group_id using sqlca;
		
		If sqlca.sqlcode = 0 Then //OK
			commit using sqlca;
			MessageBox("Group delete successful", "Email group " + ls_qa_email_group_name + " deleted successfuly")
		Else //DB error
			rollback using sqlca;
			MessageBox("Group delete failed", "Email group " + ls_qa_email_group_name + " failed to be deleted~n~r~n~rError:~n~r" + sqlca.SqlErrText)
		End If
	End If
	
	wf_retrieve_group_dropdown() //Re-retrieve group drop-down
	SetNull(ls_null)
	dw_dddw_qa_email_group.Object.qa_email_group_name[1] = ls_null
End If

end event

type cb_close from commandbutton within w_qa_email_group
integer x = 2534
integer y = 982
integer width = 322
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Integer					li_datamodified,li_answer, li_rows, li_row
String					ls_email_address
str_all_data_types	lstr_all_data_types

//dw_qa_email_group.AcceptText()
dw_qa_email_group_detail.AcceptText()

li_datamodified = wf_datamodified()

If li_datamodified = 1 Then //Data modified
	li_answer = MessageBox("Data Modified", "Data Modified. Would you like to save?", Question!, YesNo!, 1)
	
	If li_answer = 1 Then
		cb_save_new_group.Event Clicked()
	Else
		ib_user_wants_2save = False
	End IF
End If

li_rows = dw_qa_email_group_detail.RowCount()

For li_row = 1 To li_rows
	ls_email_address = dw_qa_email_group_detail.Object.qa_email_group_detail_address[li_row]
	lstr_all_data_types.string_var[li_row] = ls_email_address
Next

//Close(Parent)
CloseWithReturn(Parent, lstr_all_data_types)
end event

type cb_add_email from commandbutton within w_qa_email_group
integer x = 1682
integer y = 819
integer width = 322
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add Email"
end type

event clicked;Integer	li_row_inserted, li_group_selected_row, li_qa_email_group_id, li_last_row
String	ls_qa_email_group_detail_address, ls_group_name, ls_qa_email_group_name
Boolean	lb_group_name_exists

//Check if group name exists in group name drop-down
ls_group_name = sle_group_name.Text
lb_group_name_exists = wf_validate_group_name(ls_group_name)

If lb_group_name_exists Then
	MessageBox("Data error", "Group name " + Trim(ls_group_name) + " already exists.~n~rPlease enter another group name.", StopSign!)
	//sle_group_name.SetFocus()
	Return
End If

ls_qa_email_group_name = dw_dddw_qa_email_group.Object.qa_email_group_name[1]

//MessageBox("Clicked event for cb_add_email", "ls_qa_email_group_name = " + ls_qa_email_group_name)

If ls_qa_email_group_name = "0" Then //New
	If sle_group_name.Text = "" Then
		MessageBox("Data error", "Please enter group name", StopSign!)
		Return
	End If
End If


dw_qa_email_group_detail.AcceptText()

li_last_row = dw_qa_email_group_detail.RowCount()

If li_last_row > 0 Then
	ls_qa_email_group_detail_address = dw_qa_email_group_detail.Object.qa_email_group_detail_address[li_last_row]
	
	If IsNull(ls_qa_email_group_detail_address) Then ls_qa_email_group_detail_address = ""
	
	If ls_qa_email_group_detail_address = "" Then
		MessageBox("Data error", "Please enter email address", StopSign!)
		Return
	End If
End If

li_row_inserted = dw_qa_email_group_detail.InsertRow(0)

//li_group_selected_row = dw_qa_email_group.GetSelectedRow(0)
//
//If li_group_selected_row > 0 Then
//	ii_qa_email_group_id = dw_qa_email_group.Object.qa_email_group_id[li_group_selected_row]
//End If

dw_qa_email_group_detail.SetFocus()
dw_qa_email_group_detail.SetRow(li_row_inserted)
dw_qa_email_group_detail.ScrollToRow(li_row_inserted)
dw_qa_email_group_detail.SetColumn("qa_email_group_detail_address")

end event

type st_2 from statictext within w_qa_email_group
integer x = 1693
integer y = 10
integer width = 322
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Email Address"
boolean focusrectangle = false
end type

type st_enter_new_group_name from statictext within w_qa_email_group
integer x = 150
integer y = 477
integer width = 519
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Email New Group Name"
boolean focusrectangle = false
end type

type dw_qa_email_group_detail from datawindow within w_qa_email_group
integer x = 1690
integer y = 64
integer width = 1053
integer height = 733
integer taborder = 20
string title = "none"
string dataobject = "d_qa_email_group_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
end event

