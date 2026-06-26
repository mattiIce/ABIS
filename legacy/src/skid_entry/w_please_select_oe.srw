$PBExportHeader$w_please_select_oe.srw
forward
global type w_please_select_oe from window
end type
type st_3 from statictext within w_please_select_oe
end type
type dw_shifts_4job from datawindow within w_please_select_oe
end type
type cb_cancel from commandbutton within w_please_select_oe
end type
type st_2 from statictext within w_please_select_oe
end type
type cb_print from commandbutton within w_please_select_oe
end type
type st_1 from statictext within w_please_select_oe
end type
type sle_skid_seq_for_job from singlelineedit within w_please_select_oe
end type
type st_4 from statictext within w_please_select_oe
end type
type dw_shift_desc from datawindow within w_please_select_oe
end type
end forward

global type w_please_select_oe from window
string tag = "Please select"
integer width = 1691
integer height = 976
boolean titlebar = true
string title = "Please select"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
dw_shifts_4job dw_shifts_4job
cb_cancel cb_cancel
st_2 st_2
cb_print cb_print
st_1 st_1
sle_skid_seq_for_job sle_skid_seq_for_job
st_4 st_4
dw_shift_desc dw_shift_desc
end type
global w_please_select_oe w_please_select_oe

type variables
//Integer	ii_error_selection	//1 = Both, shift and skid_seq_for_job are blank
//										//2 = Only shift is blank
//										//3 = Only skid_seq_for_job is blank
//										
//String	is_sheet_type
//Long		il_sheet_skid_num, il_scrap_skid_num

String	is_skid_type //Alex Gerlants. 04/11/2024
end variables
forward prototypes
public function integer wf_get_shifts_4job (long al_ab_job_num)
public function long wf_get_scrap_skid_shift_num (long al_ab_job_num, long al_scrap_skid_num)
public function long wf_get_sheet_skid_shift_num (long al_ab_job_num, long al_sheet_skid_num)
end prototypes

public function integer wf_get_shifts_4job (long al_ab_job_num);//Alex Gerlants. 12/02/2023. 2045_Add_Reprint_Skid_Tag_To_Office_Skid_Entry. Begin
/*
Function:	wf_get_shifts_4job
Return:		integer
Arguments:	value	long	al_ab_job_num
*/

Integer		li_rtn = 1, li_job_status, li_rows, li_row, li_line_num, li_row_inserted
DateTime		ldt_time_date_started, ldt_time_date_finished

select	job_status, time_date_started, time_date_finished, line_num
into		:li_job_status, :ldt_time_date_started, :ldt_time_date_finished, :li_line_num
from		ab_job
where		ab_job_num = :al_ab_job_num
using		sqlca;

Choose Case sqlca.sqlcode
	Case 0
		//
	Case 100
		SetNull(li_job_status)
		SetNull(ldt_time_date_started)
		SetNull(ldt_time_date_finished)
		SetNull(li_line_num)
	Case Else
		li_rtn = -1 
		MessageBox("DB error", "Database error in wf_get_shifts_4job for w_please_select_oe" + &
											"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
End Choose

If li_rtn = 1 Then //OK so far
	sle_skid_seq_for_job.SetFocus()
	
	dw_shifts_4job.SetTransObject(sqlca)
	li_rows = dw_shifts_4job.Retrieve(ldt_time_date_started, ldt_time_date_finished, li_line_num)
	
	If li_rows > 0 Then
		If li_rows = 1 Then
			dw_shifts_4job.SelectRow(1, True)
		End If
	End If
End If

Return li_rtn
//Alex Gerlants. 12/02/2023. 2045_Add_Reprint_Skid_Tag_To_Office_Skid_Entry. End
end function

public function long wf_get_scrap_skid_shift_num (long al_ab_job_num, long al_scrap_skid_num);/*
Function:	wf_get_scrap_skid_shift_num
Returns:		long
Arguments:	value	long	al_ab_job_num
				value	long	al_scrap_skid_num
*/

Integer	li_rtn = 1
Long		ll_shift_num

select   return_scrap_item.shift_num
into		:ll_shift_num
from     scrap_skid
         join scrap_skid_detail on scrap_skid.scrap_skid_num = scrap_skid_detail.scrap_skid_num
         join return_scrap_item on scrap_skid_detail.return_scrap_item_num = return_scrap_item.return_scrap_item_num
where    shift_num is not null
and      return_scrap_item.ab_job_num = :al_ab_job_num
and      scrap_skid.scrap_skid_num = :al_scrap_skid_num
and      rownum = 1
using		sqlca;

Choose Case sqlca.sqlcode
	Case 0 //OK
		//
	Case 100
		SetNull(ll_shift_num)
	Case Else //DB error
		ll_shift_num = -1
		MessageBox("DB error", "Database error in wf_get_scrap_skid_shift_num for w_please_select_oe" + &
										"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
End Choose

Return ll_shift_num
end function

public function long wf_get_sheet_skid_shift_num (long al_ab_job_num, long al_sheet_skid_num);/*
Function:	wf_get_sheet_skid_shift_num
Returns:		long
Arguments:	value	long	al_ab_job_num
				value	long	al_sheet_skid_num
*/

Integer	li_rtn = 1
Long		ll_shift_num

select   distinct production_sheet_item.shift_num
into		:ll_shift_num
from     production_sheet_item
         join sheet_skid_detail on production_sheet_item.prod_item_num = sheet_skid_detail.prod_item_num
         join sheet_skid on production_sheet_item.ab_job_num = sheet_skid.ab_job_num
where    shift_num is not null
and      production_sheet_item.ab_job_num = :al_ab_job_num
and      sheet_skid.sheet_skid_num = :al_sheet_skid_num
and      rownum = 1
using		sqlca;

Choose Case sqlca.sqlcode
	Case 0 //OK
		//
	Case 100
		SetNull(ll_shift_num)
	Case Else //DB error
		ll_shift_num = -1
		MessageBox("DB error", "Database error in wf_get_sheet_skid_shift_num for w_please_select_oe" + &
										"~n~r~n~rError:~n~r" + sqlca.SqlErrText)
End Choose

Return ll_shift_num
end function

on w_please_select_oe.create
this.st_3=create st_3
this.dw_shifts_4job=create dw_shifts_4job
this.cb_cancel=create cb_cancel
this.st_2=create st_2
this.cb_print=create cb_print
this.st_1=create st_1
this.sle_skid_seq_for_job=create sle_skid_seq_for_job
this.st_4=create st_4
this.dw_shift_desc=create dw_shift_desc
this.Control[]={this.st_3,&
this.dw_shifts_4job,&
this.cb_cancel,&
this.st_2,&
this.cb_print,&
this.st_1,&
this.sle_skid_seq_for_job,&
this.st_4,&
this.dw_shift_desc}
end on

on w_please_select_oe.destroy
destroy(this.st_3)
destroy(this.dw_shifts_4job)
destroy(this.cb_cancel)
destroy(this.st_2)
destroy(this.cb_print)
destroy(this.st_1)
destroy(this.sle_skid_seq_for_job)
destroy(this.st_4)
destroy(this.dw_shift_desc)
end on

event open;Integer					li_rtn, li_rows, li_skid_seq_for_job
Long						ll_ab_job_num, ll_sheet_skid_num, ll_scrap_skid_num, ll_shift_num
String					ls_sheet_type
DataWindowChild		ldwc
str_all_data_types	lstr_all_data_types

/*
ii_error_selection	//1 = Both, shift and skid_seq_for_job are blank
							//2 = Only shift is blank
							//3 = Only skid_seq_for_job is blank
*/

dw_shift_desc.Visible = False
st_4.Visible = False

lstr_all_data_types = Message.PowerObjectParm
ll_ab_job_num = lstr_all_data_types.long_var[1]

li_rtn = wf_get_shifts_4job(ll_ab_job_num)

ls_sheet_type = lstr_all_data_types.string_var[1]

If ls_sheet_type = "scrap_skid" Then
	ll_scrap_skid_num = lstr_all_data_types.long_var[2]
	ll_shift_num = wf_get_scrap_skid_shift_num(ll_ab_job_num, ll_scrap_skid_num)
	
	st_1.Visible = False
	st_2.Visible = False
	sle_skid_seq_for_job.Visible = False
Else //"sheet_skid"
	ll_sheet_skid_num = lstr_all_data_types.long_var[2]
	wf_get_sheet_skid_shift_num(ll_ab_job_num, ll_sheet_skid_num)
End If

is_skid_type = ls_sheet_type //Alex Gerlants. 04/11/2024

//ii_error_selection = lstr_all_data_types.integer_var[1]
//li_skid_seq_for_job = lstr_all_data_types.integer_var[2]

////Shift
//st_4.Visible = False
//dw_shift_desc.Visible = False
//
////skid_seq_for_job
//st_1.Visible = False
//st_2.Visible = False
//sle_skid_seq_for_job.Visible = False
//
//If ii_error_selection = 1 Then //Both, shift and skid_seq_for_job are blank
//	//Shift
//	st_4.Visible = True
//	dw_shift_desc.Visible = True
//	
//	//skid_seq_for_job
//	st_1.Visible = True
//	st_2.Visible = True
//	sle_skid_seq_for_job.Visible = True
//	
//	//SetFocus(dw_shift_desc)
//	SetFocus(sle_skid_seq_for_job)
//ElseIf ii_error_selection = 2 Then //Only shift is blank
//	//Shift
//	st_4.Visible = True
//	dw_shift_desc.Visible = True
//	SetFocus(dw_shift_desc)
//ElseIf ii_error_selection = 3 Then //Only skid_seq_for_job is blank
//	//skid_seq_for_job
//	st_1.Visible = True
//	st_2.Visible = True
//	sle_skid_seq_for_job.Visible = True
//	SetFocus(sle_skid_seq_for_job)
//Else //ii_error_selection = 4. skid_seq_for_job is valid. Populate sle_skid_seq_for_job.Text with li_skid_seq_for_job
//	sle_skid_seq_for_job.Text = String(li_skid_seq_for_job)
//	
//	//Shift
//	st_4.Visible = True
//	dw_shift_desc.Visible = True
//	
//	//skid_seq_for_job
//	st_1.Visible = True
//	st_2.Visible = True
//	sle_skid_seq_for_job.Visible = True
//	
//	SetFocus(dw_shift_desc)
//	//SetFocus(sle_skid_seq_for_job)
//End If
//	
//
//dw_shift_desc.InsertRow(0)
//
//li_rtn = dw_shift_desc.GetChild("shift_desc", ldwc)
//	
//If li_rtn = 1 Then
//	ldwc.SetTransObject(sqlca)
//	li_rows = ldwc.Retrieve()
//End If
end event

type st_3 from statictext within w_please_select_oe
integer x = 110
integer y = 280
integer width = 315
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Shift"
boolean focusrectangle = false
end type

type dw_shifts_4job from datawindow within w_please_select_oe
integer x = 110
integer y = 352
integer width = 1463
integer height = 288
integer taborder = 20
string title = "none"
string dataobject = "d_shifts_4job"
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

type cb_cancel from commandbutton within w_please_select_oe
integer x = 1061
integer y = 736
integer width = 329
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;str_all_data_types	lstr_all_data_types

lstr_all_data_types.string_var[1] = "Cancel"
lstr_all_data_types.integer_var[][1] = 0

CloseWithReturn(Parent, lstr_all_data_types)
end event

type st_2 from statictext within w_please_select_oe
integer x = 110
integer y = 96
integer width = 466
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sequence For Job"
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_please_select_oe
integer x = 256
integer y = 736
integer width = 329
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
boolean default = true
end type

event clicked;str_all_data_types	lstr_all_data_types
String					ls_shift, ls_skid_seq_for_job
Integer					li_skid_seq_for_job, li_row_selected
Long						ll_shift_num
DateTime					ldt_shift_start, ldt_shift_end

//ls_shift = dw_shift_desc.Object.shift_desc[1]
//If IsNull(ls_shift) Then ls_shift = ""

If is_skid_type <> "scrap_skid" Then //Alex Gerlants. 04/11/2024
	ls_skid_seq_for_job = sle_skid_seq_for_job.Text
	
	If Not IsNumber(ls_skid_seq_for_job) Then
		MessageBox("Data error", "Skid Sequance For Job not a number~n~rPlease re-enter")
		Return
	End If
	
	If IsNull(ls_skid_seq_for_job) Then ls_skid_seq_for_job = ""
End If //Alex Gerlants. 04/11/2024

li_row_selected = dw_shifts_4job.GetSelectedRow(0)

If li_row_selected > 0 Then
	ll_shift_num = dw_shifts_4job.Object.shift_num[li_row_selected]
	ls_shift = dw_shifts_4job.Object.shift_desc[li_row_selected]
	ldt_shift_start = dw_shifts_4job.Object.start_time[li_row_selected]
	ldt_shift_end = dw_shifts_4job.Object.end_time[li_row_selected]
Else
	SetNull(ll_shift_num)
	SetNull(ls_shift)
	SetNull(ldt_shift_start)
	SetNull(ldt_shift_end)
End If



////Validate user input
//Choose Case ii_error_selection
//	Case 1 //Both, shift and skid_seq_for_job are blank
//		If ls_shift = "" And ls_skid_seq_for_job = "" Then
//			MessageBox("Shift and Skid Sequence for job not selected", "Please select", StopSign!)
//			Return
//		End If
//	Case 2 //Shift is blank
//		If ls_shift = "" Then
//			MessageBox("Shift not selected", "Please select", StopSign!)
//			Return
//		End If
//	Case 3 //skid_seq_for_job is blank
//		If ls_skid_seq_for_job = "" Then
//			MessageBox("Skid Sequence for job not selected", "Please select", StopSign!)
//			Return
//		End If
//End Choose

lstr_all_data_types.string_var[1] = ls_shift
lstr_all_data_types.integer_var[1] = Integer(ls_skid_seq_for_job)
lstr_all_data_types.long_var[1] = ll_shift_num
lstr_all_data_types.datetime_var[1] = ldt_shift_start
lstr_all_data_types.datetime_var[2] = ldt_shift_end

CloseWithReturn(Parent, lstr_all_data_types)
end event

type st_1 from statictext within w_please_select_oe
integer x = 110
integer y = 48
integer width = 315
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Skid"
boolean focusrectangle = false
end type

type sle_skid_seq_for_job from singlelineedit within w_please_select_oe
integer x = 110
integer y = 160
integer width = 183
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_please_select_oe
integer x = 951
integer width = 434
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Original Shift"
boolean focusrectangle = false
end type

type dw_shift_desc from datawindow within w_please_select_oe
integer x = 951
integer y = 64
integer width = 366
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_shift_desc_oe"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

