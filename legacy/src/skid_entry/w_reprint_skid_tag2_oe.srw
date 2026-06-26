$PBExportHeader$w_reprint_skid_tag2_oe.srw
forward
global type w_reprint_skid_tag2_oe from w_popup
end type
type dw_scrap_skid_ticket_non_bl110 from datawindow within w_reprint_skid_tag2_oe
end type
type dw_skid_ticket_non_bl110 from datawindow within w_reprint_skid_tag2_oe
end type
type dw_reprint_sheet_skid_tags from datawindow within w_reprint_skid_tag2_oe
end type
type dw_reprint_scrap_skid_tags from datawindow within w_reprint_skid_tag2_oe
end type
type st_1 from statictext within w_reprint_skid_tag2_oe
end type
type st_2 from statictext within w_reprint_skid_tag2_oe
end type
type cb_retrieve from commandbutton within w_reprint_skid_tag2_oe
end type
type cb_close from commandbutton within w_reprint_skid_tag2_oe
end type
type cb_print_sheet_skid from commandbutton within w_reprint_skid_tag2_oe
end type
type sle_ab_job_num from singlelineedit within w_reprint_skid_tag2_oe
end type
type st_ab_job_num from statictext within w_reprint_skid_tag2_oe
end type
type cb_print_scrap_skid from commandbutton within w_reprint_skid_tag2_oe
end type
type cbx_show_print_preview from checkbox within w_reprint_skid_tag2_oe
end type
end forward

global type w_reprint_skid_tag2_oe from w_popup
integer x = 0
integer y = 0
integer width = 1998
integer height = 1440
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_scrap_skid_ticket_non_bl110 dw_scrap_skid_ticket_non_bl110
dw_skid_ticket_non_bl110 dw_skid_ticket_non_bl110
dw_reprint_sheet_skid_tags dw_reprint_sheet_skid_tags
dw_reprint_scrap_skid_tags dw_reprint_scrap_skid_tags
st_1 st_1
st_2 st_2
cb_retrieve cb_retrieve
cb_close cb_close
cb_print_sheet_skid cb_print_sheet_skid
sle_ab_job_num sle_ab_job_num
st_ab_job_num st_ab_job_num
cb_print_scrap_skid cb_print_scrap_skid
cbx_show_print_preview cbx_show_print_preview
end type
global w_reprint_skid_tag2_oe w_reprint_skid_tag2_oe

type variables
Long	il_ab_job_num
end variables

forward prototypes
public subroutine wf_print_sheet_skid_ticket (long al_skid_num)
public function integer wf_validate_sheeet_skid (long al_sheet_skid_num, ref string as_shift, ref integer ai_skid_seq_for_job, ref boolean ab_shift_valid, ref boolean ab_seq_4job_valid)
public function integer wf_validate_scrap_skid (long al_scrap_skid_num, ref string as_shift, ref boolean ab_shift_valid)
public function integer wf_update_production_sheet_item (long al_ab_job_num, long al_sheet_skid_num, datetime adt_shift_start, datetime adt_shift_end, long al_shift_num)
public function integer wf_update_return_scrap_item (long al_ab_job_num, long al_scrap_skid_num, datetime adt_shift_start, datetime adt_shift_end, long al_shift_num)
end prototypes

public subroutine wf_print_sheet_skid_ticket (long al_skid_num);/*
Function:	wf_print_sheet_skid_ticket
Returns:		none
Arguments	value	ling	al_skid_num
*/

Datastore 	lds_skid
Long			ll_rows
//DateTime		ldt_t

lds_skid = Create DataStore
lds_skid.Dataobject = "d_skid_ticket_non_bl110"
lds_skid.SetTransObject(sqlca)
ll_rows = lds_skid.Retrieve( al_skid_num)

If ll_rows > 0 Then
	//If is_shift <> "" Then
	//	lds_skid.Object.shift[1] = is_shift
	//End If
	
	lds_skid.print( )
	//lds_skid.print( )
End If

end subroutine

public function integer wf_validate_sheeet_skid (long al_sheet_skid_num, ref string as_shift, ref integer ai_skid_seq_for_job, ref boolean ab_shift_valid, ref boolean ab_seq_4job_valid);/*
Function:	wf_validate_sheeet_skid
Returns:		integer	li_rtn
Arguments:	value			long		al_sheet_skid_num
				reference	string	as_shift
				reference	integer	ai_skid_seq_for_job
				reference	boolean	ab_shift_valid
				reference	boolean	ab_seq_4job_valid
*/


Integer	li_rtn = 1, li_rows
//Integer	li_skid_seq_for_job
//String	ls_shift

dw_skid_ticket_non_bl110.SetTransObject(sqlca)
li_rows = dw_skid_ticket_non_bl110.Retrieve(al_sheet_skid_num)

If li_rows < 0 Then
	li_rtn = -1
End If

ab_shift_valid = True
ab_seq_4job_valid = True

as_shift = dw_skid_ticket_non_bl110.Object.shift[1]

If IsNull(as_shift) Then
	ab_shift_valid = False
	as_shift = ""
End If

ai_skid_seq_for_job = dw_skid_ticket_non_bl110.Object.skid_seq_for_job[1]

If IsNull(ai_skid_seq_for_job) Then
	ab_seq_4job_valid = False
	ai_skid_seq_for_job = -99
End If

//ab_shift_valid = False //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY 
//as_shift = "" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY 
//
//ab_seq_4job_valid = False //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY 
//ai_skid_seq_for_job = -99 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	
Return li_rtn


end function

public function integer wf_validate_scrap_skid (long al_scrap_skid_num, ref string as_shift, ref boolean ab_shift_valid);/*
Function:	wf_validate_scrap_skid
Returns:		integer	li_rtn
Arguments:	value			long		al_scrap_skid_num
				reference	string	as_shift
				reference	boolean	ab_shift_valid
*/


Integer	li_rtn = 1, li_rows, li_skid_seq_for_job
//String	ls_shift

dw_scrap_skid_ticket_non_bl110.SetTransObject(sqlca)
li_rows = dw_scrap_skid_ticket_non_bl110.Retrieve(al_scrap_skid_num)

If li_rows < 0 Then
	li_rtn = -1
End If

ab_shift_valid = True

as_shift = dw_scrap_skid_ticket_non_bl110.Object.shift[1]

If IsNull(as_shift) Then
	ab_shift_valid = False
	as_shift = ""
End If

//as_shift = "" //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY 
//ab_shift_valid = False //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	
Return li_rtn
end function

public function integer wf_update_production_sheet_item (long al_ab_job_num, long al_sheet_skid_num, datetime adt_shift_start, datetime adt_shift_end, long al_shift_num);/*
Function:	wf_update_production_sheet_item
Returns:		str_all_data_types
Arguments:	value	long			al_ab_job_num
				value	long			al_sheet_skid_num
				value	datetime		adt_shift_start
				value	datetime		adt_shift_end
				value	long			al_shift_num
*/

DataStore				lds_prod_item_date_4skid, lds_shifts_4job
Integer					li_rtn = 1, li_row, li_rows, li_found_row, li_row_shift, li_rows_shift, li_line_num
DateTime					adt_time_date_started, adt_time_date_finished
DateTime					ldt_prod_item_date
//DateTime					ldt_shift_start, ldt_shift_end
DateTime					ldt_time_date_started, ldt_time_date_finished
String					ls_find_string
Boolean					lb_shift_found = False
Long						ll_shift_num, ll_prod_item_num
str_all_data_types	lstr_all_data_types

If IsNull(al_shift_num) Then //User did not select shift on w_please_select_oe
	Return 1
End If

lds_shifts_4job = Create DataStore
lds_shifts_4job.DataObject = "d_shifts_4job"
lds_shifts_4job.SetTransObject(sqlca)

lds_prod_item_date_4skid = Create DataStore
lds_prod_item_date_4skid.DataObject = "d_prod_item_date_4skid"
lds_prod_item_date_4skid.SetTransObject(sqlca)

li_rows = lds_prod_item_date_4skid.Retrieve(al_ab_job_num, al_sheet_skid_num)

//select	time_date_started, time_date_finished, line_num
//into		:ldt_time_date_started, :ldt_time_date_finished, :li_line_num
//from		ab_job
//where		ab_job_num = :al_ab_job_num
//using		sqlca;
//
//If sqlca.sqlcode <> 0 Then
//	li_rtn = -1
//	MessageBox("DB error", "Database error in wf_find_shift_4prod_item_date for w_reprint_skid_tag2_oe while retrieving from ab_job" + &
//										"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
//End If

//If li_rtn = 1 Then //OK above
	//li_rows_shift = lds_shifts_4job.Retrieve(ldt_time_date_started, ldt_time_date_finished, li_line_num)
	
	For li_row = 1 To li_rows
		ldt_prod_item_date = lds_prod_item_date_4skid.Object.prod_item_date[li_row]
		ll_prod_item_num = lds_prod_item_date_4skid.Object.prod_item_num[li_row]
		
		If ldt_prod_item_date >= adt_shift_start And ldt_prod_item_date <= adt_shift_end Then
			lb_shift_found = True
			
			//lstr_all_data_types.long_var[1] = ll_shift_num
			//lstr_all_data_types.long_var[2] = ll_prod_item_num
							
			update	production_sheet_item
			set		shift_num = :al_shift_num
			where		prod_item_num = :ll_prod_item_num
			using		sqlca;
			
			If sqlca.sqlcode = 0 Then //OK
				commit using sqlca;
			Else
				rollback using sqlca;
				
				li_rtn = -1
				MessageBox("DB error", "Database error in wf_update_production_sheet_item for w_reprint_skid_tag2_oe while updating production_sheet_item" + &
													"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
			End If
		End If
		
		//For li_row_shift = 1 To li_rows_shift
		//	ldt_shift_start = lds_shifts_4job.Object.start_time[li_row_shift]
		//	ldt_shift_end = lds_shifts_4job.Object.end_time[li_row_shift]
		//	ll_shift_num = lds_shifts_4job.Object.shift_num[li_row_shift]
		//	
		//	If ldt_prod_item_date >= ldt_shift_start And ldt_prod_item_date <= ldt_shift_end Then
		//		lb_shift_found = True
		//		
		//		lstr_all_data_types.long_var[1] = ll_shift_num
		//		lstr_all_data_types.long_var[2] = ll_prod_item_num
		//						
		//		Exit
		//	End If
		//Next
	Next
//End If

Return li_rtn
end function

public function integer wf_update_return_scrap_item (long al_ab_job_num, long al_scrap_skid_num, datetime adt_shift_start, datetime adt_shift_end, long al_shift_num);/*
Function:	wf_update_return_scrap_item
Returns:		integer
Arguments:	value	long			al_ab_job_num
				value	long			al_scrap_skid_num
				value	datetime		adt_shift_start
				value	datetime		adt_shift_end
				value	long			al_shift_num
*/

DataStore				lds_return_item_date_4skid, lds_shifts_4job
Integer					li_rtn = 1, li_row, li_rows, li_found_row, li_row_shift, li_rows_shift, li_line_num
DateTime					adt_time_date_started, adt_time_date_finished
DateTime					ldt_return_item_date
//DateTime					ldt_shift_start, ldt_shift_end
DateTime					ldt_time_date_started, ldt_time_date_finished
String					ls_find_string
Boolean					lb_shift_found = False
Long						ll_shift_num, ll_return_scrap_item_num
str_all_data_types	lstr_all_data_types

If IsNull(al_shift_num) Then //User did not select shift on w_please_select_oe
	Return 1
End If

lds_shifts_4job = Create DataStore
lds_shifts_4job.DataObject = "d_shifts_4job"
lds_shifts_4job.SetTransObject(sqlca)

lds_return_item_date_4skid = Create DataStore
lds_return_item_date_4skid.DataObject = "d_scrap_item_date_4skid"
lds_return_item_date_4skid.SetTransObject(sqlca)

li_rows = lds_return_item_date_4skid.Retrieve(al_ab_job_num, al_scrap_skid_num)

//select	time_date_started, time_date_finished, line_num
//into		:ldt_time_date_started, :ldt_time_date_finished, :li_line_num
//from		ab_job
//where		ab_job_num = :al_ab_job_num
//using		sqlca;
//
//If sqlca.sqlcode <> 0 Then
//	li_rtn = -1
//	MessageBox("DB error", "Database error in wf_find_shift_4return_item_date for w_reprint_skid_tag2_oe while retrieving from ab_job" + &
//										"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
//End If

//If li_rtn = 1 Then //OK above
	//li_rows_shift = lds_shifts_4job.Retrieve(ldt_time_date_started, ldt_time_date_finished, li_line_num)
	
	For li_row = 1 To li_rows
		ldt_return_item_date = lds_return_item_date_4skid.Object.return_item_date[li_row]
		ll_return_scrap_item_num = lds_return_item_date_4skid.Object.return_scrap_item_num[li_row]
		
		If ldt_return_item_date >= adt_shift_start And ldt_return_item_date <= adt_shift_end Then
			lb_shift_found = True
			
			//lstr_all_data_types.long_var[1] = ll_shift_num
			//lstr_all_data_types.long_var[2] = ll_return_scrap_item_num
							
			update	return_scrap_item
			set		shift_num = :al_shift_num
			where		return_scrap_item_num = :ll_return_scrap_item_num
			using		sqlca;
			
			If sqlca.sqlcode = 0 Then //OK
				commit using sqlca;
			Else
				rollback using sqlca;
				
				li_rtn = -1
				MessageBox("DB error", "Database error in wf_update_return_scrap_item for w_reprint_skid_tag2_oe while updating return_scrap_item" + &
													"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
			End If
		End If
		
		//For li_row_shift = 1 To li_rows_shift
		//	ldt_shift_start = lds_shifts_4job.Object.start_time[li_row_shift]
		//	ldt_shift_end = lds_shifts_4job.Object.end_time[li_row_shift]
		//	ll_shift_num = lds_shifts_4job.Object.shift_num[li_row_shift]
		//	
		//	If ldt_return_item_date >= ldt_shift_start And ldt_return_item_date <= ldt_shift_end Then
		//		lb_shift_found = True
		//		
		//		lstr_all_data_types.long_var[1] = ll_shift_num
		//		lstr_all_data_types.long_var[2] = ll_return_scrap_item_num
		//						
		//		Exit
		//	End If
		//Next
	Next
//End If

Return li_rtn
end function

on w_reprint_skid_tag2_oe.create
int iCurrent
call super::create
this.dw_scrap_skid_ticket_non_bl110=create dw_scrap_skid_ticket_non_bl110
this.dw_skid_ticket_non_bl110=create dw_skid_ticket_non_bl110
this.dw_reprint_sheet_skid_tags=create dw_reprint_sheet_skid_tags
this.dw_reprint_scrap_skid_tags=create dw_reprint_scrap_skid_tags
this.st_1=create st_1
this.st_2=create st_2
this.cb_retrieve=create cb_retrieve
this.cb_close=create cb_close
this.cb_print_sheet_skid=create cb_print_sheet_skid
this.sle_ab_job_num=create sle_ab_job_num
this.st_ab_job_num=create st_ab_job_num
this.cb_print_scrap_skid=create cb_print_scrap_skid
this.cbx_show_print_preview=create cbx_show_print_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_scrap_skid_ticket_non_bl110
this.Control[iCurrent+2]=this.dw_skid_ticket_non_bl110
this.Control[iCurrent+3]=this.dw_reprint_sheet_skid_tags
this.Control[iCurrent+4]=this.dw_reprint_scrap_skid_tags
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_retrieve
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_print_sheet_skid
this.Control[iCurrent+10]=this.sle_ab_job_num
this.Control[iCurrent+11]=this.st_ab_job_num
this.Control[iCurrent+12]=this.cb_print_scrap_skid
this.Control[iCurrent+13]=this.cbx_show_print_preview
end on

on w_reprint_skid_tag2_oe.destroy
call super::destroy
destroy(this.dw_scrap_skid_ticket_non_bl110)
destroy(this.dw_skid_ticket_non_bl110)
destroy(this.dw_reprint_sheet_skid_tags)
destroy(this.dw_reprint_scrap_skid_tags)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_retrieve)
destroy(this.cb_close)
destroy(this.cb_print_sheet_skid)
destroy(this.sle_ab_job_num)
destroy(this.st_ab_job_num)
destroy(this.cb_print_scrap_skid)
destroy(this.cbx_show_print_preview)
end on

event pfc_postopen;call super::pfc_postopen;//This.Width = 5336
//This.Height = 2077
This.X = 3510
This.Y = 620
end event

event open;call super::open;Integer				li_rtn, li_rows
Long					ll_ab_job_num
DataWindowChild	ldwc

cb_retrieve.SetFocus()
ll_ab_job_num = Message.DoubleParm //In w_office_skid_entry, in Clicked event for button "Reprint Skid Tag": OpenWithParm(w_reprint_skid_tag2_skid_entry, il_current_job_num)
sle_ab_job_num.Text = String(ll_ab_job_num)
il_ab_job_num = ll_ab_job_num //I miight not need this

cbx_show_print_preview.Checked = True
dw_skid_ticket_non_bl110.Visible = False
dw_scrap_skid_ticket_non_bl110.Visible = False
//cb_retrieve.Visible = False

cb_retrieve.Event Clicked()
end event

type dw_scrap_skid_ticket_non_bl110 from datawindow within w_reprint_skid_tag2_oe
integer y = 928
integer width = 585
integer height = 352
integer taborder = 40
string title = "none"
string dataobject = "d_scrap_skid_ticket_non_bl110_oe"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_skid_ticket_non_bl110 from datawindow within w_reprint_skid_tag2_oe
integer x = 37
integer y = 736
integer width = 549
integer height = 160
integer taborder = 30
string dataobject = "d_skid_ticket_non_bl110_oe"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_reprint_sheet_skid_tags from datawindow within w_reprint_skid_tag2_oe
integer x = 690
integer y = 68
integer width = 549
integer height = 988
integer taborder = 20
string title = "none"
string dataobject = "d_reprint_sheet_skid_tags_oe"
boolean vscrollbar = true
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

type dw_reprint_scrap_skid_tags from datawindow within w_reprint_skid_tag2_oe
integer x = 1376
integer y = 68
integer width = 549
integer height = 976
integer taborder = 20
string title = "none"
string dataobject = "d_reprint_scrap_skid_tags_oe"
boolean vscrollbar = true
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

type st_1 from statictext within w_reprint_skid_tag2_oe
integer x = 690
integer y = 12
integer width = 320
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sheet Skids"
boolean focusrectangle = false
end type

type st_2 from statictext within w_reprint_skid_tag2_oe
integer x = 1381
integer y = 12
integer width = 320
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scrap Skids"
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_reprint_skid_tag2_oe
integer x = 50
integer y = 236
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
boolean default = true
end type

event clicked;String	ls_ab_job_num
Long		ll_ab_job_num
Boolean	lb_isnumber

String	ls_shift_desc

//ls_shift_desc = dw_shift_desc.Object.shift_desc[1]

//If IsNull(ls_shift_desc) Then ls_shift_desc = ""
//
//If ls_shift_desc = "" Then
//	MessageBox("Shift not selected", "Please select shift", StopSign!)
//	Return
//End If

ls_ab_job_num = sle_ab_job_num.Text
lb_isnumber = IsNumber(ls_ab_job_num)

//If Not lb_isnumber Then
//	MessageBox("Job number not numeric", "Job '" + ls_ab_job_num + "' is not a number.~n~rPlease reenter", StopSign!)
//	Return
//End If
	
ll_ab_job_num = Long(ls_ab_job_num)

dw_reprint_sheet_skid_tags.SetTransObject(sqlca)
dw_reprint_scrap_skid_tags.SetTransObject(sqlca)

dw_reprint_sheet_skid_tags.Retrieve(ll_ab_job_num)
dw_reprint_scrap_skid_tags.Retrieve(ll_ab_job_num)


end event

type cb_close from commandbutton within w_reprint_skid_tag2_oe
integer x = 1637
integer y = 1244
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type cb_print_sheet_skid from commandbutton within w_reprint_skid_tag2_oe
integer x = 800
integer y = 1108
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;Datastore 				lds_skid, lds_prod_item_date_4skid
Long						ll_rows, ll_row, ll_ab_job_num, ll_sheet_skid_num, ll_skid_num, ll_selected_row, ll_shift_num
Integer					li_job_status, li_rtn, li_selected_row
String					ls_error_string
str_all_data_types	lstr_all_data_types
Long						ll_null
String					ls_modstring, ls_rtn
Boolean					lb_shift_valid, lb_seq_4job_valid

String					ls_shift, ls_sql
Integer					li_skid_seq_for_job, li_null
DataWindow				ldw_shifts_4job
Long						ll_prod_item_num
DateTime					ldt_shift_start, ldt_shift_end

SetNull(li_null)

If Not IsNumber(sle_ab_job_num.Text) Then
	MessageBox("Job number not numeric", "Job '" + sle_ab_job_num.Text + "' is not a number.~n~rPlease reenter", StopSign!)
	Return
End If

li_selected_row = dw_reprint_sheet_skid_tags.GetSelectedRow(0)

If li_selected_row > 0 Then
	ll_sheet_skid_num = dw_reprint_sheet_skid_tags.Object.sheet_skid_num[li_selected_row]
	
	select	sheet_skid.ab_job_num, ab_job.job_status
	into		:ll_ab_job_num,        :li_job_status
	from		sheet_skid
				join ab_job on ab_job.ab_job_num = sheet_skid.ab_job_num
	where		sheet_skid.sheet_skid_num = :ll_sheet_skid_num
	using		sqlca;
	
	lstr_all_data_types.long_var[1] = ll_ab_job_num	
	lstr_all_data_types.long_var[2] = ll_sheet_skid_num
	lstr_all_data_types.string_var[1] = "sheet_skid"
	
	OpenWithParm(w_please_select_oe, lstr_all_data_types)
	
	lstr_all_data_types = Message.PowerObjectParm
	
	If lstr_all_data_types.string_var[1] = "Cancel" Then
		Return
	End If
	
	ls_shift = lstr_all_data_types.string_var[1] 
	li_skid_seq_for_job = lstr_all_data_types.integer_var[1]
	ll_shift_num = lstr_all_data_types.long_var[1]
	ldt_shift_start = lstr_all_data_types.datetime_var[1]
	ldt_shift_end = lstr_all_data_types.datetime_var[2]
	
	//---
	

	//---
	
Else
	Return
End If


lds_skid = Create DataStore

//If li_job_status = 0 Then //Job Done
	lds_skid.Dataobject = "d_skid_ticket_non_bl110_2_oe" //This datawindow retrieves skid weights
//Else
//	lds_skid.Dataobject = "d_skid_ticket_non_bl110_oe" //This datawindow does not retrieve skid weights
//End If

lds_skid.SetTransObject(sqlca)
ls_sql = lds_skid.GetSqlSelect()
ll_rows = lds_skid.Retrieve(ll_sheet_skid_num)

If ll_rows > 0 Then
	lds_skid.Object.shift[1] = ls_shift
	lds_skid.Object.skid_seq_for_job[1] = li_skid_seq_for_job
	
	lstr_all_data_types.long_var[1] = ll_ab_job_num
	lstr_all_data_types.long_var[2] = ll_sheet_skid_num
	lstr_all_data_types.integer_var[1] = li_job_status
	lstr_all_data_types.integer_var[2] = li_skid_seq_for_job
	lstr_all_data_types.string_var[1] = ls_shift
	
	//If li_job_status <> 0 Then //Job NOT Done. Blank out weights
	//	SetNull(ll_null)
	//
	//	ls_modstring = "t_tare.Text = ~"" + "" + "~""	
	//	ls_rtn = lds_skid.Modify(ls_modstring)
	//	
	//	ls_modstring = "t_net.Text = ~"" + "" + "~""	
	//	ls_rtn = lds_skid.Modify(ls_modstring)
	//	
	//	ls_modstring = "t_gross_wt.Text = ~"" + "" + "~""	
	//	ls_rtn = lds_skid.Modify(ls_modstring)
	//End If
		
	If li_skid_seq_for_job = 0 Then SetNull(li_skid_seq_for_job)
	
	update	sheet_skid
	set		skid_seq_for_job = :li_skid_seq_for_job
	where		sheet_skid_num = :ll_sheet_skid_num
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then //OK
		li_rtn = wf_update_production_sheet_item(ll_ab_job_num, ll_sheet_skid_num, ldt_shift_start, ldt_shift_end, ll_shift_num)
		
		If li_rtn = 1 Then //OK in wf_update_production_sheet_item
			commit using sqlca;
		Else
			rollback using sqlca;
		End If
	Else
		rollback using sqlca;
	End If
		
	If cbx_show_print_preview.Checked Then
		OpenWithParm(w_sheet_skid_print_preview_oe, lstr_all_data_types[])
	Else
		li_rtn = PrintSetup()

		If li_rtn = -1 Then //Error in PrintSetup() or user clicked on "Cancel"
			Return 1
		End If
	
		lds_skid.print( )
	End If
End If

end event

type sle_ab_job_num from singlelineedit within w_reprint_skid_tag2_oe
integer x = 50
integer y = 68
integer width = 421
integer height = 92
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;String	ls_null

SetNull(ls_null)

//dw_shift_desc.Object.shift_desc[1] = ls_null
dw_reprint_sheet_skid_tags.Reset()
dw_reprint_scrap_skid_tags.Reset()
end event

event getfocus;String	ls_null

SetNull(ls_null)

//dw_shift_desc.Object.shift_desc[1] = ls_null
dw_reprint_sheet_skid_tags.Reset()
dw_reprint_scrap_skid_tags.Reset()
end event

type st_ab_job_num from statictext within w_reprint_skid_tag2_oe
integer x = 50
integer y = 12
integer width = 393
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Job Number"
boolean focusrectangle = false
end type

type cb_print_scrap_skid from commandbutton within w_reprint_skid_tag2_oe
integer x = 1495
integer y = 1108
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;Datastore 				lds_skid
Long						ll_rows, ll_ab_job_num, ll_skid_num, ll_selected_row, ll_null, ll_shift_num
Integer					li_job_status, li_rtn, li_null, li_skid_seq_for_job
String					ls_shift
str_all_data_types	lstr_all_data_types
Boolean					lb_shift_valid
DateTime					ldt_shift_start, ldt_shift_end

SetNull(li_null)

If Not IsNumber(sle_ab_job_num.Text) Then
	MessageBox("Job number not numeric", "Job '" + sle_ab_job_num.Text + "' is not a number.~n~rPlease reenter", StopSign!)
	Return
End If

ll_ab_job_num = Long(sle_ab_job_num.Text)

select	job_status
into		:li_job_status
from		ab_job
where		ab_job_num = :ll_ab_job_num
using		sqlca;

ll_selected_row = dw_reprint_scrap_skid_tags.GetSelectedRow(0)

If ll_selected_row > 0 Then
	ll_skid_num = dw_reprint_scrap_skid_tags.Object.scrap_skid_num[ll_selected_row]
		
	lstr_all_data_types.long_var[1] = ll_ab_job_num	
	lstr_all_data_types.long_var[2] = ll_skid_num
	lstr_all_data_types.string_var[1] = "scrap_skid"
	
	OpenWithParm(w_please_select_oe, lstr_all_data_types)
	
	lstr_all_data_types = Message.PowerObjectParm
	
	If lstr_all_data_types.string_var[1] = "Cancel" Then
		Return
	End If
	
	ls_shift = lstr_all_data_types.string_var[1] 
	li_skid_seq_for_job = lstr_all_data_types.integer_var[1]
	ll_shift_num = lstr_all_data_types.long_var[1]
	ldt_shift_start = lstr_all_data_types.datetime_var[1]
	ldt_shift_end = lstr_all_data_types.datetime_var[2]
		
	li_rtn = wf_update_return_scrap_item(ll_ab_job_num, ll_skid_num, ldt_shift_start, ldt_shift_end, ll_shift_num)

	lds_skid = Create DataStore
	lds_skid.Dataobject = "d_scrap_skid_ticket_non_bl110_oe"
	lds_skid.SetTransObject(sqlca)
	ll_rows = lds_skid.Retrieve( ll_skid_num)
	
	If ll_rows > 0 Then
		lds_skid.Object.shift[1] = ls_shift
		
		If cbx_show_print_preview.Checked Then
			lstr_all_data_types.long_var[1] = ll_ab_job_num
			lstr_all_data_types.long_var[2] = ll_skid_num
			lstr_all_data_types.integer_var[1] = li_job_status
			lstr_all_data_types.string_var[1] = ls_shift
			
			OpenWithParm(w_scrap_skid_print_preview_oe, lstr_all_data_types[])
			Return
		End If
		
		//If li_job_status <> 0 Then //Job not Done
		//	SetNull(ll_null)
		//	lds_skid.Object.scrap_skid_scrap_net_wt[1] = ll_null
		//	lds_skid.Object.scrap_skid_scrap_tare_wt[1] = ll_null
		//	lds_skid.Object.gross_wt[1] = ll_null
		//End If
		
		PrintSetup()
		lds_skid.print( )
	End If
End If
end event

type cbx_show_print_preview from checkbox within w_reprint_skid_tag2_oe
integer x = 27
integer y = 412
integer width = 654
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show Skid Print Preview"
end type

