$PBExportHeader$w_die_new.srw
forward
global type w_die_new from w_child
end type
type dw_line_die_4sheet_type from datawindow within w_die_new
end type
type st_lines from statictext within w_die_new
end type
type st_shapes from statictext within w_die_new
end type
type dw_line_lookup from datawindow within w_die_new
end type
type cb_cancel from commandbutton within w_die_new
end type
type dw_shapes_4die_id from datawindow within w_die_new
end type
type dw_shapes from datawindow within w_die_new
end type
type dw_die_new from u_dw within w_die_new
end type
type cb_close from u_cb within w_die_new
end type
type cb_save from u_cb within w_die_new
end type
end forward

global type w_die_new from w_child
integer x = 214
integer y = 221
integer width = 3579
integer height = 1228
string title = "Die Information"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_safe ( )
event ue_save ( )
dw_line_die_4sheet_type dw_line_die_4sheet_type
st_lines st_lines
st_shapes st_shapes
dw_line_lookup dw_line_lookup
cb_cancel cb_cancel
dw_shapes_4die_id dw_shapes_4die_id
dw_shapes dw_shapes
dw_die_new dw_die_new
cb_close cb_close
cb_save cb_save
end type
global w_die_new w_die_new

type variables
Long		il_die_id_new //Alex Gerlants. 03/23/2017
String	is_selected_shapes_db[] //Alex Gerlants. 03/23/2017
Boolean	ib_data_modified //Alex Gerlants. 03/23/2017
Boolean	ib_cancel
end variables

forward prototypes
public function boolean wf_data_modified (long al_die_id)
public function boolean wf_sheet_type_modified (long al_die_id)
public function integer wf_select_shapes ()
public function integer wf_insert_update_shape_die (long al_die_id)
public function integer wf_get_selected_shapes ()
public function integer wf_validate_input ()
public function boolean wf_die_shape_line_modified ()
public subroutine wf_select_lines_4die_shape (long al_die_id)
public function integer wf_update_line_die_4sheet_type ()
end prototypes

event ue_save();Long ll_row
String ls_string
String	ls_err_string //Alex Gerlants. 12/19/2017. Die_2_New_Columns

dw_die_new.AcceptText()
ll_row = dw_die_new.GetRow()

ls_string = dw_die_new.GetItemString(ll_row, "die_name")

if (  ls_string = ""  or isnull (ls_string) )then
	ls_err_string = "Please enter DIE NAME."
end if

//Alex Gerlants. 12/19/2017. Die_2_New_Columns. Begin
ls_string = dw_die_new.Object.engineered_scrap_y_n[ll_row]

If (ls_string = "" Or IsNull(ls_string) ) Then
	If ls_err_string = "" Then
		ls_err_string = "Please enter Engineered Scrap (Y/N)."
	Else
		ls_err_string = ls_err_string + "~n~rPlease enter Engineered Scrap (Y/N)."
	End If
End If

ls_string = dw_die_new.Object.num_of_parts_per_hit[ll_row]

If (ls_string = "" Or IsNull(ls_string) ) Then
	If ls_err_string = "" Then
		ls_err_string = "Please enter Number Of Parts Per Hit."
	Else
		ls_err_string = ls_err_string + "~n~rPlease enter Number Of Parts Per Hit."
	End If
End If

If ls_err_string = "" Then
	CloseWithReturn(This,1)
Else
	MessageBox("Error", ls_err_string, StopSign!)
	Return
End If
//Alex Gerlants. 12/19/2017. Die_2_New_Columns. End

end event

public function boolean wf_data_modified (long al_die_id);//Alex Gerlants. 12/19/2017. Die_2_New_Columns. Begin
/*
Function:	wf_data_modified
Returns:		boolean	<== True   If data modified
								 False  If data NOT modified
Arguments:	value	long	 al_die_id
*/

Boolean	lb_sheet_type_modified, lb_data_modified = False
String	ls_sheet_type, ls_sheet_type_db, ls_location
Long		li_rtn = 1
Integer	li_modified_count_die, li_modified_count_shapes, li_count, li_row

dw_die_new.AcceptText()
dw_shapes.AcceptText()

lb_sheet_type_modified = wf_sheet_type_modified(al_die_id)

li_modified_count_die = dw_die_new.ModifiedCount()

If li_modified_count_die > 0 Or lb_sheet_type_modified Then
	lb_data_modified = True
Else
	lb_data_modified = False
End If

ib_data_modified = lb_data_modified
Return lb_data_modified

//li_row = dw_die_new.GetRow()
//
//ls_location = dw_die_new.GetItemString(li_row, "location", Primary!, True)
//ls_location = dw_die_new.GetItemString(li_row, "location", Primary!, False)
//
//li_modified_count_die = dw_die_new.ModifiedCount()
//
//li_modified_count_die = dw_die_new.GetNextModified(0, Primary!)
//
//If li_modified_count_die > 0 Then Return True
//
////---
//
//lb_sheet_type_modified = wf_sheet_type_modified(al_die_id)
//
//If lb_sheet_type_modified Then
//	Return True
//Else
//	Return False
//End If
//Alex Gerlants. 12/19/2017. Die_2_New_Columns. End
end function

public function boolean wf_sheet_type_modified (long al_die_id);//Alex Gerlants. 03/23/2017. Begin
/*
Function:	wf_sheet_type_modified
Returns:		boolean	<== True   If shape modified
								 False  If shape NOT modified
Arguments:	value	long		al_die_id
*/


Long		ll_row, ll_rows, ll_found_row
String	ls_shape, ls_find_string
Boolean	lb_sheet_type_modified = False

ll_rows = dw_shapes.RowCount()

For ll_row = 1 To ll_rows
	ls_shape = dw_shapes.Object.shape[ll_row]
	If IsNull(ls_shape) Then ls_shape = ""
	
	ls_find_string = "sheet_type = '" + ls_shape + "'"
	ll_found_row = dw_shapes_4die_id.Find(ls_find_string, 1, dw_shapes_4die_id.RowCount())
	
	If ll_found_row > 0 Then
		If dw_shapes.IsSelected(ll_row) Then
			//Do nothing
		Else
			lb_sheet_type_modified =  True
		End If
	Else
		If dw_shapes.IsSelected(ll_row) Then
			lb_sheet_type_modified = True
		Else
			//Do nothing
		End If
	End If
Next

Return lb_sheet_type_modified
end function

public function integer wf_select_shapes ();//Alex Gerlants. 03/23/2017. Begin
/*
Function:	wf_select_shapes
Returns:		integer	 1 if OK
							-1 of Db error
Arguments:	none						
*/

Integer		li_rtn = 1
Long			ll_rows, ll_row, ll_found_row
String		ls_sheet_type, ls_find_string, ls_shape

ll_rows = dw_shapes_4die_id.RowCount()

If ll_rows > 0 Then
	For ll_row = 1 To ll_rows
		ls_sheet_type = Trim(dw_shapes_4die_id.Object.sheet_type[ll_row])
		If IsNull(ls_sheet_type) Then ls_sheet_type = ""
		
		ls_find_string = "shape = '" + ls_sheet_type + "'"
		ll_found_row = dw_shapes.Find(ls_find_string, 1, dw_shapes.RowCount())
		
		If ll_found_row > 0 Then
			dw_shapes.SelectRow(ll_found_row, True)
			is_selected_shapes_db[UpperBound(is_selected_shapes_db[]) + 1] = ls_sheet_type
		End If
	Next
ElseIf ll_rows = -1 Then //DB Error
	//
End If

Return li_rtn
//Alex Gerlants. 03/23/2017. End
end function

public function integer wf_insert_update_shape_die (long al_die_id);//Alex Gerlants. 03/23/2017. Begin
/*
Function:	wf_insert_update_shape_die
				Insert into table shape_die if row for the al_die_id does not exist there
				Update table shape_die if row for the al_die_id exists there
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	long	al_die_id								 
*/

/*
Datawindow dw_shapes_4die_id has rows from table shape_die for die_id
Datawindow dw_shapes has the same rows from the beginning. But user can select and de-select its rows

Thus:
	If dw_shapes is selected and it does exist in dw_shapes_4die_id, do nothing
	If dw_shapes is not selected and it does exist in dw_shapes_4die_id, delete from dw_shapes_4die_id
	
	If dw_shapes is selected and it does not exist in dw_shapes_4die_id, insert shape into dw_shapes_4die_id
	If dw_shapes is not selected and it does not exist in dw_shapes_4die_id, do nothing
*/
Long		li_rtn = 1, ll_row, ll_rows, ll_found_row, ll_inserted_row
String	ls_shape, ls_find_string
Boolean	lb_data_changed = False

ll_rows = dw_shapes.RowCount()

For ll_row = 1 To ll_rows
	ls_shape = dw_shapes.Object.shape[ll_row]
	If IsNull(ls_shape) Then ls_shape = ""
	
	ls_find_string = "sheet_type = '" + ls_shape + "'"
	ll_found_row = dw_shapes_4die_id.Find(ls_find_string, 1, dw_shapes_4die_id.RowCount())
	
	If ll_found_row > 0 Then
		If dw_shapes.IsSelected(ll_row) Then
			//Do nothing
		Else
			lb_data_changed =  True
			dw_shapes_4die_id.DeleteRow(ll_found_row) //Delete existing association
		End If
	Else
		If dw_shapes.IsSelected(ll_row) Then
			lb_data_changed = True
			ll_inserted_row = dw_shapes_4die_id.InsertRow(0) //User selected new shape to associate
			
			If ll_inserted_row > 0 Then
				dw_shapes_4die_id.Object.sheet_type[ll_inserted_row] = ls_shape
				dw_shapes_4die_id.Object.die_id[ll_inserted_row] = al_die_id
			End If
		Else
			//Do nothing
		End If
	End If
Next

If lb_data_changed Then
	li_rtn = dw_shapes_4die_id.Update()
End If

//String	ls_sql
//Long		li_rtn = 1
//Integer	li_count
//
//select	count(*)
//into		:li_count
//from		shape_die
//where		die_id = :al_die_id
//using		sqlca;
//
//If sqlca.sqlcode = 0 Then //OK
//	If li_count = 0 Then //Row doesn't exist
//		//Insert the row
//		ls_sql = "insert into shape_die values ('" + as_sheet_type + "', " + String(al_die_id) + ")"
//		execute immediate :ls_sql using sqlca;
//		
//		If sqlca.sqlcode < 0 Then //DB error
//			li_rtn = -1 
//		End If
//	Else //Row exists
//		//Update the row
//		update	shape_die
//		set		sheet_type = :as_sheet_type
//		where		die_id = :al_die_id
//		using		sqlca;
//		
//		If sqlca.sqlcode < 0 Then //DB error
//			li_rtn = -1
//		End If
//	End If
//Else //DB error
//	li_rtn = -1
//End If
//
//If li_rtn = -1 Then
//	MessageBox("Database Error", &
//								"Database error in wf_insert_update_shape_die for w_die_new" + &
//								"while trying to update table shape_die." + &
//								"~n~rSaving aborted." + &
//								"~n~rDatabase Error:~n~r" + sqlca.sqlerrtext)
//End If
		
Return li_rtn		
//Alex Gerlants. 03/23/2017. End
end function

public function integer wf_get_selected_shapes ();//Alex Gerlants. 03/23/2017. Begin
/*
Function;	wf_get_selected_shapes
Returns:		integer <== Number of selected rows in dw_shapes
Arguments:	none
*/

Integer	li_rows, li_row, li_count

li_rows = dw_shapes.RowCount()

For li_row = 1 To li_rows
	If dw_shapes.IsSelected(li_row) Then
		li_count++
	End If
Next

Return li_count
//Alex Gerlants. 03/23/2017. End
end function

public function integer wf_validate_input ();//Alex Gerlants. 12/19/2017. Die_2_New_Columns. Begin
/*
Function:	wf_validate_input
Returns:		integer	 1 If ok
							-1 If error
Arguments:	none							
*/

Integer	li_rtn = 1
Long 		ll_row
String 	ls_string
String	ls_err_string //Alex Gerlants. 12/19/2017. Die_2_New_Columns
//Integer	li_selected_row_shape, li_selected_row_line //Alex Gerlants. 08/12/2024. 9999_Work_Center

dw_die_new.AcceptText()
ll_row = dw_die_new.GetRow()

ls_string = dw_die_new.GetItemString(ll_row, "die_name")

If ( ls_string = "" or isnull(ls_string)) Then
	ls_err_string = "Please enter DIE NAME."
End If

ls_string = dw_die_new.Object.engineered_scrap_y_n[ll_row]

If (ls_string = "" Or IsNull(ls_string) ) Then
	If ls_err_string = "" Then
		ls_err_string = "Please enter Engineered Scrap (Y/N)."
	Else
		ls_err_string = ls_err_string + "~n~rPlease enter Engineered Scrap (Y/N)."
	End If
End If

ls_string = String(dw_die_new.Object.num_of_parts_per_hit[ll_row])

If (ls_string = "" Or IsNull(ls_string) ) Then
	If ls_err_string = "" Then
		ls_err_string = "Please enter Number Of Parts Per Hit."
	Else
		ls_err_string = ls_err_string + "~n~rPlease enter Number Of Parts Per Hit."
	End If
End If

////Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
//dw_shapes.AcceptText()
//dw_line_lookup.AcceptText()
//
//li_selected_row_shape = dw_shapes.GetSelectedRow(0)
//li_selected_row_line = dw_line_lookup.GetSelectedRow(0)
//
//If li_selected_row_shape <= 0 And li_selected_row_line <= 0 Then
//	ls_err_string = ls_err_string + "~n~rPlease select shapes and blanking lines."
//ElseIf li_selected_row_shape <= 0 Then
//	ls_err_string = ls_err_string + "~n~rPlease select shape(s)."
//ElseIf li_selected_row_line <= 0 Then
//	ls_err_string = ls_err_string + "~n~rPlease select  blanking line(s)."
//End If
////Alex Gerlants. 08/12/2024. 9999_Work_Center. End

If ls_err_string <> "" Then
	MessageBox("Error", ls_err_string, StopSign!)
	li_rtn = -1
End If

Return li_rtn
//Alex Gerlants. 12/19/2017. Die_2_New_Columns. End
end function

public function boolean wf_die_shape_line_modified ();//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
/*
Function:	wf_die_shape_line_modified
Returns:		boolean	<== True   If shape modified
								 False  If shape NOT modified
Arguments:	value	long		al_die_id
*/


Long		ll_row, ll_rows, ll_found_row, ll_line_num
Integer	li_selected_row
String	ls_shape, ls_find_string
Boolean	lb_sheet_type_modified = False

li_selected_row = dw_line_lookup.GetSelectedRow(0)

ll_rows = dw_line_lookup.RowCount()

For ll_row = 1 To ll_rows
	ls_shape = dw_shapes.Object.shape[ll_row]
	If IsNull(ls_shape) Then ls_shape = ""
	
	ls_find_string = "sheet_type = '" + ls_shape + "'"
	ll_found_row = dw_shapes_4die_id.Find(ls_find_string, 1, dw_shapes_4die_id.RowCount())
	
	If ll_found_row > 0 Then
		If dw_shapes.IsSelected(ll_row) Then
			//Do nothing
		Else
			lb_sheet_type_modified =  True
		End If
	Else
		If dw_shapes.IsSelected(ll_row) Then
			lb_sheet_type_modified = True
		Else
			//Do nothing
		End If
	End If
Next

Return lb_sheet_type_modified
//Alex Gerlants. 08/12/2024. 9999_Work_Center. End
end function

public subroutine wf_select_lines_4die_shape (long al_die_id);//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
/*
Function:	wf_select_lines_4die_shape
Returns:		none
Arguments:	value	long	al_die_id
*/

Integer	li_rows, li_row, li_selected_row, li_start, li_line_num
Long		ll_found_row
String	ls_shape, ls_find_string
DataStore	lds_line_4die_sheet_type

lds_line_4die_sheet_type = Create DataStore
lds_line_4die_sheet_type.DataObject = "d_line_4die_sheet_type"
lds_line_4die_sheet_type.SetTransObject(sqlca)

//li_rows = dw_shapes.Retrieve()

//If li_rows > 0 Then
li_start = 0

li_selected_row = dw_shapes.getSelectedRow(li_start)

If li_selected_row > 0 Then
	//ls_shape = dw_shapes.Object.shape[li_selected_row]
	
	Do While li_selected_row > 0
		//If li_selected_row > 0 Then
			ls_shape = dw_shapes.Object.shape[li_selected_row]
			li_rows = lds_line_4die_sheet_type.Retrieve(ls_shape, al_die_id)
			
			For li_row = 1 To li_rows
				li_line_num = lds_line_4die_sheet_type.Object.line_num[li_row]
				ls_find_string = "line_num = " + String(li_line_num)
				ll_found_row = dw_line_lookup.Find(ls_find_string, 1, dw_line_lookup.RowCount())
				
				If ll_found_row > 0 Then
					dw_line_lookup.SelectRow(ll_found_row, True)
				End If
			Next
			
//			ls_find_string = "sheet_type = '" + ls_shape + "' and die_id = " + String(al_die_id)
//			ll_found_row = dw_lines_4die_id.Find(ls_find_string, 1, dw_lines_4die_id.RowCount())
//			
//			If ll_found_row > 0 Then
//				li_line_num = dw_lines_4die_id.Object.line_num[ll_found_row]
//				ls_find_string = "line_num = " + String(li_line_num)
//				ll_found_row = dw_line_lookup.Find(ls_find_string, 1, dw_line_lookup.RowCount())
//				
//				If ll_found_row > 0 Then
//					dw_line_lookup.SelectRow(ll_found_row, True)
//				End If
//			End If
		//End If
		
		li_start = li_selected_row
		li_selected_row = dw_shapes.getSelectedRow(li_start)
	Loop
End If
//End If

//Alex Gerlants. 08/12/2024. 9999_Work_Center. End
end subroutine

public function integer wf_update_line_die_4sheet_type ();//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
/*
Function:	wf_update_line_die_4sheet_type
Returns:		integer
Arguments:	none
*/

Integer	li_rtn = 1
Boolean	lb_ok_2update = False
Integer	li_selected_row_shape, li_selected_row_line, li_line_num, li_inserted_row, li_rows, li_row, li_count, li_found_row
Long		ll_die_id
String	ls_shape, ls_find_string

li_row = dw_die_new.GetRow()

If li_row > 0 Then
	ll_die_id = dw_die_new.Object.die_id[li_row]
Else
	Return li_rtn
End If

delete from line_die_4sheet_type
where		die_id = :ll_die_id
using		sqlca;

If sqlca.sqlcode < 0 Then
	MessageBox("DB error", "Database error in wf_update_d_line_die_4sheet_type for w_die_new while initial deleting a row.~n~rError:~n~r" + sqlca.SqlErrText, StopSign!)
	Return -1
End If

If li_rtn = 1 Then
	dw_line_die_4sheet_type.Reset()
	
	li_selected_row_shape = dw_shapes.GetSelectedRow(0)
	
	If li_selected_row_shape > 0 Then
		Do While li_selected_row_shape > 0 
			ls_shape = dw_shapes.Object.shape[li_selected_row_shape]
			
			li_selected_row_line = dw_line_lookup.GetSelectedRow(0)
			
			If li_selected_row_line > 0 Then
				lb_ok_2update = True
				
				Do While li_selected_row_line > 0
					li_line_num = dw_line_lookup.Object.line_num[li_selected_row_line]
					li_inserted_row = dw_line_die_4sheet_type.InsertRow(0)
					
					If li_inserted_row > 0 Then
						dw_line_die_4sheet_type.Object.sheet_type[li_inserted_row] = ls_shape
						dw_line_die_4sheet_type.Object.line_num[li_inserted_row] = li_line_num
						dw_line_die_4sheet_type.Object.die_id[li_inserted_row] = ll_die_id
					End If
					
					li_selected_row_line = dw_line_lookup.GetSelectedRow(li_selected_row_line)
				Loop
			End If
			
			li_selected_row_shape = dw_shapes.GetSelectedRow(li_selected_row_shape)
		Loop
	End If
	
	If lb_ok_2update Then
		dw_line_die_4sheet_type.SetTransObject(sqlca)
		li_rtn = dw_line_die_4sheet_type.Update()
	End If
End If

Return li_rtn
//Alex Gerlants. 08/12/2024. 9999_Work_Center. End
end function

on w_die_new.create
int iCurrent
call super::create
this.dw_line_die_4sheet_type=create dw_line_die_4sheet_type
this.st_lines=create st_lines
this.st_shapes=create st_shapes
this.dw_line_lookup=create dw_line_lookup
this.cb_cancel=create cb_cancel
this.dw_shapes_4die_id=create dw_shapes_4die_id
this.dw_shapes=create dw_shapes
this.dw_die_new=create dw_die_new
this.cb_close=create cb_close
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_line_die_4sheet_type
this.Control[iCurrent+2]=this.st_lines
this.Control[iCurrent+3]=this.st_shapes
this.Control[iCurrent+4]=this.dw_line_lookup
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.dw_shapes_4die_id
this.Control[iCurrent+7]=this.dw_shapes
this.Control[iCurrent+8]=this.dw_die_new
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_save
end on

on w_die_new.destroy
call super::destroy
destroy(this.dw_line_die_4sheet_type)
destroy(this.st_lines)
destroy(this.st_shapes)
destroy(this.dw_line_lookup)
destroy(this.cb_cancel)
destroy(this.dw_shapes_4die_id)
destroy(this.dw_shapes)
destroy(this.dw_die_new)
destroy(this.cb_close)
destroy(this.cb_save)
end on

event open;call super::open;Long 		ll_id, ll_row
Long		ll_rows //Alex Gerlants. 03/23/2017
String	ls_die_name

dw_die_new.SetTransObject(SQLCA)
dw_shapes.SetTransObject(sqlca) //Alex Gerlants. 03/23/2017
dw_shapes_4die_id.SetTransObject(sqlca) //Alex Gerlants. 03/23/2017

dw_shapes.Retrieve() //Alex Gerlants. 03/23/2017

//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
dw_line_lookup.SetTransObject(sqlca)
ll_rows = dw_line_lookup.Retrieve()
//Alex Gerlants. 08/12/2024. 9999_Work_Center. End

ll_id = Message.DoubleParm

If ll_id = 0 Then //New
	ll_id = f_get_next_value("die_id_seq")
	
	il_die_id_new = ll_id //Alex Gerlants. 03/23/2017
	
	ll_row = dw_die_new.InsertRow(0)
	
	dw_die_new.SetItem(ll_row, "die_id", ll_id)
Elseif ll_id >0 Then //Modify
	ll_rows = dw_die_new.Retrieve(ll_id)
	
	If ll_rows > 0 Then
		ls_die_name = dw_die_new.Object.die_name[1]
		This.Title = This.Title + ". " + "Die: " + String(ll_id) + "-" + ls_die_name
	End If
	
	ll_rows = dw_shapes_4die_id.Retrieve(ll_id) //Alex Gerlants. 03/23/2017
	wf_select_shapes() //Alex Gerlants. 03/23/2017
	
	//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
	//dw_lines_4die_id.SetTransObject(sqlca)
	//ll_rows = dw_lines_4die_id.Retrieve(ll_id) 
	
	dw_line_die_4sheet_type.SetTransObject(sqlca)
	wf_select_lines_4die_shape(ll_id)
	//Alex Gerlants. 08/12/2024. 9999_Work_Center. End
End If


end event

event close;String	ls_test

ls_test = ls_test
end event

event closequery;//Alex Gerlants. 03/23/2017. Begin
Long		ll_die_id, ll_rtn
Integer	li_answer, li_rtn
Boolean	lb_data_modified

If ib_cancel Then Return 0 //Close window

dw_die_new.AcceptText()
ll_die_id = dw_die_new.Object.die_id[dw_die_new.GetRow()]
lb_data_modified = wf_data_modified(ll_die_id)

If lb_data_modified Then //It is set in Clicked event for cb_close
	li_answer = MessageBox("Data Modified", "Do you want to save data?", Question!, YesNo!, 1)
	
	If li_answer = 1 Then //Yes
		ll_rtn = cb_save.Event Clicked()
		
		If ll_rtn = 1 Then //Ok in cb_save.Event Clicked()
			Return 0 //Close window
		Else
			Return 1 //Do not close window
		End If
	Else //No
		Return 0 //Close window
	End If
Else //Data not modified
	Return 0 //Close window
End If
//Alex Gerlants. 03/23/2017. End

end event

type dw_line_die_4sheet_type from datawindow within w_die_new
integer x = 3584
integer width = 1134
integer height = 1088
integer taborder = 30
string title = "none"
string dataobject = "d_line_die_4sheet_type"
boolean resizable = true
boolean livescroll = true
end type

type st_lines from statictext within w_die_new
integer x = 3109
integer y = 36
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

type st_shapes from statictext within w_die_new
integer x = 2560
integer y = 32
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

type dw_line_lookup from datawindow within w_die_new
integer x = 3109
integer y = 128
integer width = 329
integer height = 832
integer taborder = 20
string title = "none"
string dataobject = "d_dddw_line_lookup2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Alex Gerlants. 07/26/2023. Work_Center. Begin
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
//Alex Gerlants. 07/26/2023. Work_Center. End
end event

type cb_cancel from commandbutton within w_die_new
integer x = 1829
integer y = 1036
integer width = 366
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;ib_cancel = True

//Close(Parent) //Alex Gerlants. 08/12/2024. 9999_Work_Center. Comment out

//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
Long		ll_die_id
Integer	li_answer, li_rtn
Boolean	lb_data_modified

dw_die_new.AcceptText()

//Alex Gerlants. 03/23/2017. Begin
If il_die_id_new > 0 Then //Create a new die
	CloseWithReturn(Parent, il_die_id_new)
Else //Modify existing die
	CloseWithReturn(Parent, 1)
End If
//Alex Gerlants. 08/12/2024. 9999_Work_Center. End
end event

type dw_shapes_4die_id from datawindow within w_die_new
boolean visible = false
integer x = 2633
integer y = 972
integer width = 549
integer height = 320
integer taborder = 30
string title = "none"
string dataobject = "d_shapes_4die_id"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;MessageBox("Database error", 	"Database error has ocurred while trying to update table shape_die." + &
										"in function wf_insert_update_shape_die()" + &
										"~n~rError:~n~rsqlerrtext")
end event

type dw_shapes from datawindow within w_die_new
integer x = 2501
integer y = 128
integer width = 526
integer height = 844
integer taborder = 10
string title = "none"
string dataobject = "d_shapes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row <= 0 Then Return

If IsSelected(row) Then
	SelectRow(row, False)
Else
	SelectRow(row, True)
End If
end event

type dw_die_new from u_dw within w_die_new
integer x = 91
integer y = 128
integer width = 2359
integer height = 844
integer taborder = 10
string dataobject = "d_die_new"
end type

type cb_close from u_cb within w_die_new
integer x = 1006
integer y = 1036
integer taborder = 20
string text = "&Close"
end type

event clicked;call super::clicked;//Alex Gerlants. 03/23/2017. Begin
Long		ll_die_id
Integer	li_answer, li_rtn
Boolean	lb_data_modified

dw_die_new.AcceptText()

//Alex Gerlants. 03/23/2017. Begin
If il_die_id_new > 0 Then //Create a new die
	CloseWithReturn(Parent, il_die_id_new)
Else //Modify existing die
	CloseWithReturn(Parent, 1)
End If
//Alex Gerlants. 03/23/2017. End
end event

type cb_save from u_cb within w_die_new
integer x = 233
integer y = 1036
integer taborder = 10
string text = "&Save"
end type

event clicked;//parent.event ue_save()//Alex Gerlants. 03/23/2017. Commented out. this would not commit.
										//Also, removed check mark from "Extend Ancestor Script".


//Alex Gerlants. 03/23/2017. Begin
Integer		li_rtn = 1, li_answer
Long			ll_row, ll_die_id, li_shape_count
String		ls_sheet_type
Boolean		lb_sheet_type_modified

Integer		li_selected_row_shape, li_selected_row_line //Alex Gerlants. 08/12/2024. 9999_Work_Center
String		ls_die_name //Alex Gerlants. 08/12/2024. 9999_Work_Center

li_rtn = wf_validate_input() //Alex Gerlants. 12/19/2017. Die_2_New_Columns
If li_rtn = -1 Then Return li_rtn //Alex Gerlants. 12/19/2017. Die_2_New_Columns

dw_die_new.AcceptText()

ll_row = dw_die_new.GetRow()

ll_die_id = dw_die_new.Object.die_id[ll_row]
If ll_die_id <= 0 Then Return

//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
dw_shapes.AcceptText()
dw_line_lookup.AcceptText()
ls_die_name = dw_die_new.Object.die_name[ll_row]

li_selected_row_shape = dw_shapes.GetSelectedRow(0)
li_selected_row_line = dw_line_lookup.GetSelectedRow(0)

If li_selected_row_shape <= 0 Or li_selected_row_line <= 0 Then
	li_answer = MessageBox("Are you sure?", "Are you sure you do not want to associate die " + ls_die_name + " with shape(s) and blanking line(s)?", Question!, YesNo!, 2)
	
	If li_answer = 2 Then //No
		Return
	End If
End If
//Alex Gerlants. 08/12/2024. 9999_Work_Center. End

li_shape_count = wf_get_selected_shapes()

li_rtn = dw_die_new.Update()

If li_rtn = 1 Then //OK above
	//If ls_sheet_type <> "" Then
		//Check if sheet type modified or new
		lb_sheet_type_modified = wf_sheet_type_modified(ll_die_id)
		
		If lb_sheet_type_modified Then
			//Update/Insert table shape_die
			li_rtn = wf_insert_update_shape_die(ll_die_id)
		End if
	//End If

	If li_rtn = 1 Then //OK above
	
		//Alex Gerlants. 08/12/2024. 9999_Work_Center. Begin
		li_rtn = wf_update_line_die_4sheet_type()
	
		If li_rtn = 1 Then //OK above
		//Alex Gerlants. 08/12/2024. 9999_Work_Center. End
			commit using sqlca;
			ib_data_modified = False
			
			cb_cancel.Visible = False //Alex Gerlants. 08/12/2024. 9999_Work_Center
		End If //Alex Gerlants. 08/12/2024. 9999_Work_Center
	Else
		rollback using sqlca;
	End If
Else //Error in dw_die_new.Update()
	rollback using sqlca;
End If

dw_die_new.Retrieve(ll_die_id)

Return li_rtn
//Alex Gerlants. 03/23/2017. End

end event

