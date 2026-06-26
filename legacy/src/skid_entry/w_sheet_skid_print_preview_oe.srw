$PBExportHeader$w_sheet_skid_print_preview_oe.srw
forward
global type w_sheet_skid_print_preview_oe from w_popup
end type
type cb_get_size from commandbutton within w_sheet_skid_print_preview_oe
end type
type cb_cancel from commandbutton within w_sheet_skid_print_preview_oe
end type
type cb_print from commandbutton within w_sheet_skid_print_preview_oe
end type
type dw_skid_ticket_non_bl110 from datawindow within w_sheet_skid_print_preview_oe
end type
end forward

global type w_sheet_skid_print_preview_oe from w_popup
integer width = 2459
integer height = 2456
string title = "Sheet Skid Print Preview"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_get_size cb_get_size
cb_cancel cb_cancel
cb_print cb_print
dw_skid_ticket_non_bl110 dw_skid_ticket_non_bl110
end type
global w_sheet_skid_print_preview_oe w_sheet_skid_print_preview_oe

type variables
//w_reprint_skid_tag	iw_reprint_skid_tag
end variables

forward prototypes
public subroutine of_print_skid_ticket_non_110 (long al_skid_num, long al_job, long al_selected_row)
public subroutine wf_print_skid_ticket_non_110 (long al_job, long al_skid_num)
public function long wf_get_skid_seq_for_job (long al_skid_num)
end prototypes

public subroutine of_print_skid_ticket_non_110 (long al_skid_num, long al_job, long al_selected_row);//Alex Gerlants. 08/13/2021. 1251_Print_Skid_Tags_BL78_BL84. Begin
/*
Function:	of_print_skid_ticket_non_110
Returns		none
Arguments:	value	long	al_skid_num
				value	long	al_job
				value	long	al_selected_row
*/

String lstr_customer_name, lstr_end_user, lstr_alloy, lstr_temper,lstr_sheet_type, ls_shift
double ld_gauge, ld_length, ld_width
long ll_order_num, ll_shift
int li_order_item_num, li_skid_seq
DateTime ldt_t
Long		ll_shift_num, ll_rows, ll_row, ll_skid_pieces, ll_selected_row
u_coil	lu_coil
Integer	li_rtn, li_seq_job, li_schedule_type, li_skid_sheet_status, li_answer, li_count
Datastore 	lds_production_sheet_item_4job_skid, lds_skid
String		ls_non_110, ls_modstring

select   count(*)
into		:li_count
from     sheet_skid
where    sheet_skid_num = :al_skid_num
using		sqlca;

If li_count <= 0 Then
	MessageBox("Skid not saved", "Please save skid before printing.", StopSign!)
	Return
End If

//Alex Gerlants. 06/14/2022. Moved the question from of_save
li_answer = MessageBox("Skid Piece Count question", "Is skid piece count correct?", Question!, YesNo!, 1)

If li_answer = 2 Then //No
	Return
End If

//Open(w_skid_status_non_110)
//li_skid_sheet_status = Message.doubleparm

li_answer = MessageBox("Finishing skid question", "Is this skid a finished skid? Answer No will save as unfinished skid.", Question!, YesNoCancel!, 1)

Choose Case li_answer
	Case 1
		//dw_skid_list.object.sheet_skid_skid_sheet_status[al_selected_row] = 5
		
		update	sheet_skid
		set		skid_sheet_status = 5
		where		shet_skid_num = :al_skid_num
		using		sqlca;
	Case 2
		//dw_skid_list.object.sheet_skid_skid_sheet_status[al_selected_row] = 14
		
		update	sheet_skid
		set		skid_sheet_status = 14
		where		shet_skid_num = :al_skid_num
		using		sqlca;
	Case Else
		Return
End Choose

//update	shet_skid
//set		skid_sheet_status = li_skid_sheet_status
//where		shet_skid_num = :al_skid_num
//using		sqlca;

select	nvl(skid_seq_for_job, 0)
into		:li_seq_job
from		sheet_skid
where		sheet_skid_num = :al_skid_num
using		sqlca;

//MessageBox("of_print_skid_ticket_non_110 for u_da_skid_tabpg", "li_seq_job = " + String(li_seq_job)) //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

If li_seq_job <= 0 Then
	select nvl(max(sheet_skid.skid_seq_for_job),0)
	into :li_seq_job
	from sheet_skid
	where sheet_skid.ab_job_num = :al_job
	using	sqlca;
		 
	li_seq_job = li_seq_job + 1
	
	update	sheet_skid  
	set 		skid_seq_for_job = :li_seq_job 
	where 	sheet_skid.sheet_skid_num = :al_skid_num 
	using		sqlca;
	
	//MessageBox("of_print_skid_ticket_non_110 for u_da_skid_tabpg", "Inside IF. After 'update	sheet_skid' ~n~rli_seq_job = " + String(li_seq_job) + "~n~rsqlca.sqlcode = " + String(sqlca.sqlcode)) //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	
	If sqlca.sqlcode = 0 Then //OK
		//commit using sqlca;
	Else
		rollback using sqlca;
	End If
End If

lds_production_sheet_item_4job_skid = Create DataStore
lds_production_sheet_item_4job_skid.Dataobject = "d_production_sheet_item_4job_skid"
lds_production_sheet_item_4job_skid.SetTransObject(sqlca)
ll_rows = lds_production_sheet_item_4job_skid.retrieve (al_job, al_skid_num)

If ll_rows > 0 Then
	For ll_row = 1 To ll_rows
		lds_production_sheet_item_4job_skid.Object.shift_num[ll_row] = ll_shift_num
	Next
	
	li_rtn = lds_production_sheet_item_4job_skid.Update()
	
	If li_rtn = 1 Then //OK
		//commit using sqlca;
	Else
		rollback using sqlca;
	End If
End If

lds_skid = Create DataStore
lds_skid.Dataobject = "d_skid_ticket_non_bl110"
lds_skid.SetTransObject(sqlca)
ll_rows = lds_skid.Retrieve( al_skid_num)
		
ldt_t = DateTime(Today(),Now())	

//MessageBox("of_print_skid_ticket_non_110 for u_da_skid_tabpg", "Before lds_skid.object.t_net.Text = String(al_net)") //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//dw_skid_list.AcceptText()
//ll_selected_row = dw_skid_list.GetRow()

//If ll_selected_row > 0 Then
//	ll_skid_pieces = dw_skid_list.Object.production_sheet_item_prod_item_pieces[ll_selected_row]
//	//lds_skid.object.t_skid_pieces.Text = String(ll_skid_pieces)
//End If

//lds_skid.object.t_net.Text = ""
ls_modstring = "t_net.Text = ~"" + "" + "~""	
lds_skid.Modify(ls_modstring)


//lds_skid.object.t_tare.Text = ""
ls_modstring = "t_tare.Text = ~"" + "" + "~""	
lds_skid.Modify(ls_modstring)

//lds_skid.object.t_gross_wt.Text = ""
ls_modstring = "t_gross_wt.Text = ~"" + "" + "~""	
lds_skid.Modify(ls_modstring)

//lds_skid.object.t_skid_pieces.Text = String(al_skid_pieces)
//ls_modstring = "t_skid_pieces.Text = ~"" + String(al_skid_pieces) + "~""	
//lds_skid.Modify(ls_modstring)

////lds_skid.object.t_skid_seq.text = String(li_seq_job)
//ls_modstring = "t_skid_seq.Text = ~"" + String(li_seq_job) + "~""	
//lds_skid.Modify(ls_modstring)

//lds_skid.object.t_job.text = String(al_job )
//ls_modstring = "t_job.Text = ~"" + String(al_job) + "~""	
//lds_skid.Modify(ls_modstring)

////lds_skid.object.t_shift.text = ls_shift
//ls_modstring = "t_shift.Text = ~"" + ls_shift + "~""	
//lds_skid.Modify(ls_modstring)

//MessageBox("of_print_skid_ticket_non_110", "Before lds_skid.print( )") //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

lds_skid.print( )
lds_skid.print( )

////Alex Gerlants. 06/14/2022
//if dw_skid_list.of_update( true, true) = 1 then
//	sqlca.of_commit( )
//else
//	sqlca.of_rollback( )
//	//MessageBox("Done skid", "Save failed!")
//	//return 1
//end if
////Alex Gerlants. 08/13/2021. 1251_Print_Skid_Tags_BL78_BL84. End
end subroutine

public subroutine wf_print_skid_ticket_non_110 (long al_job, long al_skid_num);//Alex Gerlants. 08/13/2021. 1251_Print_Skid_Tags_BL78_BL84. Begin
/*
Function:	wf_print_skid_ticket_non_110
Returns		none
Arguments:	value	long	al_skid_num
				value	long	al_job
				value	long	al_selected_row
*/

String lstr_customer_name, lstr_end_user, lstr_alloy, lstr_temper,lstr_sheet_type, ls_shift
double ld_gauge, ld_length, ld_width
long ll_order_num, ll_shift
int li_order_item_num, li_skid_seq
DateTime ldt_t
Long		ll_shift_num, ll_rows, ll_row, ll_skid_pieces, ll_selected_row
u_coil	lu_coil
Integer	li_rtn, li_seq_job, li_schedule_type, li_skid_sheet_status, li_answer, li_count
Datastore 	lds_production_sheet_item_4job_skid, lds_skid
String		ls_non_110, ls_modstring

select   count(*)
into		:li_count
from     sheet_skid
where    sheet_skid_num = :al_skid_num
using		sqlca;

If li_count <= 0 Then
	MessageBox("Skid not saved", "Please save skid before printing.", StopSign!)
	Return
End If

//Alex Gerlants. 06/14/2022. Moved the question from of_save
li_answer = MessageBox("Skid Piece Count question", "Is skid piece count correct?", Question!, YesNo!, 1)

If li_answer = 2 Then //No
	Return
End If

//Open(w_skid_status_non_110)
//li_skid_sheet_status = Message.doubleparm

//li_answer = MessageBox("Finishing skid question", "Is this skid a finished skid? Answer No will save as unfinished skid.", Question!, YesNoCancel!, 1)
//
//Choose Case li_answer
//	Case 1
//		//dw_current_edit.object.sheet_skid_skid_sheet_status[ll_row] = 5
//		dw_skid_list.object.sheet_skid_skid_sheet_status[al_selected_row] = 5
//		
//		//update	sheet_skid
//		//set		skid_sheet_status = 5
//		//where		shet_skid_num = :al_skid_num
//		//using		sqlca;
//	Case 2
//		//dw_current_edit.object.sheet_skid_skid_sheet_status[ll_row] = 14
//		dw_skid_list.object.sheet_skid_skid_sheet_status[al_selected_row] = 14
//		
//		//update	sheet_skid
//		//set		skid_sheet_status = 14
//		//where		shet_skid_num = :al_skid_num
//		//using		sqlca;
//	Case Else
//		Return
//End Choose

//update	shet_skid
//set		skid_sheet_status = li_skid_sheet_status
//where		shet_skid_num = :al_skid_num
//using		sqlca;

select	nvl(skid_seq_for_job, 0)
into		:li_seq_job
from		sheet_skid
where		sheet_skid_num = :al_skid_num
using		sqlca;

//MessageBox("of_print_skid_ticket_non_110 for u_da_skid_tabpg", "li_seq_job = " + String(li_seq_job)) //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

If li_seq_job <= 0 Then
	select nvl(max(sheet_skid.skid_seq_for_job),0)
	into :li_seq_job
	from sheet_skid
	where sheet_skid.ab_job_num = :al_job
	using	sqlca;
		 
	li_seq_job = li_seq_job + 1
	
	update	sheet_skid  
	set 		skid_seq_for_job = :li_seq_job 
	where 	sheet_skid.sheet_skid_num = :al_skid_num 
	using		sqlca;
	
	//MessageBox("of_print_skid_ticket_non_110 for u_da_skid_tabpg", "Inside IF. After 'update	sheet_skid' ~n~rli_seq_job = " + String(li_seq_job) + "~n~rsqlca.sqlcode = " + String(sqlca.sqlcode)) //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	
	If sqlca.sqlcode = 0 Then //OK
		//commit using sqlca;
	Else
		rollback using sqlca;
	End If
End If

lds_production_sheet_item_4job_skid = Create DataStore
lds_production_sheet_item_4job_skid.Dataobject = "d_production_sheet_item_4job_skid"
lds_production_sheet_item_4job_skid.SetTransObject(sqlca)
ll_rows = lds_production_sheet_item_4job_skid.retrieve (al_job, al_skid_num)

If ll_rows > 0 Then
	For ll_row = 1 To ll_rows
		lds_production_sheet_item_4job_skid.Object.shift_num[ll_row] = ll_shift_num
	Next
	
	li_rtn = lds_production_sheet_item_4job_skid.Update()
	
	If li_rtn = 1 Then //OK
		//commit using sqlca;
	Else
		rollback using sqlca;
	End If
End If

lds_skid = Create DataStore
lds_skid.Dataobject = "d_skid_ticket_non_bl110"
lds_skid.SetTransObject(sqlca)
ll_rows = lds_skid.Retrieve( al_skid_num)
		
ldt_t = DateTime(Today(),Now())	

//MessageBox("of_print_skid_ticket_non_110 for u_da_skid_tabpg", "Before lds_skid.object.t_net.Text = String(al_net)") //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//dw_skid_list.AcceptText()
//ll_selected_row = dw_skid_list.GetRow()
//
//If ll_selected_row > 0 Then
//	ll_skid_pieces = dw_skid_list.Object.production_sheet_item_prod_item_pieces[ll_selected_row]
//	//lds_skid.object.t_skid_pieces.Text = String(ll_skid_pieces)
//End If

//lds_skid.object.t_net.Text = ""
ls_modstring = "t_net.Text = ~"" + "" + "~""	
lds_skid.Modify(ls_modstring)


//lds_skid.object.t_tare.Text = ""
ls_modstring = "t_tare.Text = ~"" + "" + "~""	
lds_skid.Modify(ls_modstring)

//lds_skid.object.t_gross_wt.Text = ""
ls_modstring = "t_gross_wt.Text = ~"" + "" + "~""	
lds_skid.Modify(ls_modstring)

//lds_skid.object.t_skid_pieces.Text = String(al_skid_pieces)
//ls_modstring = "t_skid_pieces.Text = ~"" + String(al_skid_pieces) + "~""	
//lds_skid.Modify(ls_modstring)

////lds_skid.object.t_skid_seq.text = String(li_seq_job)
//ls_modstring = "t_skid_seq.Text = ~"" + String(li_seq_job) + "~""	
//lds_skid.Modify(ls_modstring)

//lds_skid.object.t_job.text = String(al_job )
//ls_modstring = "t_job.Text = ~"" + String(al_job) + "~""	
//lds_skid.Modify(ls_modstring)

////lds_skid.object.t_shift.text = ls_shift
//ls_modstring = "t_shift.Text = ~"" + ls_shift + "~""	
//lds_skid.Modify(ls_modstring)

//MessageBox("of_print_skid_ticket_non_110", "Before lds_skid.print( )") //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

lds_skid.print( )
lds_skid.print( )

//Alex Gerlants. 06/14/2022
//if dw_skid_list.of_update( true, true) = 1 then
//	sqlca.of_commit( )
//else
//	sqlca.of_rollback( )
//	//MessageBox("Done skid", "Save failed!")
//	//return 1
//end if
//Alex Gerlants. 08/13/2021. 1251_Print_Skid_Tags_BL78_BL84. End
end subroutine

public function long wf_get_skid_seq_for_job (long al_skid_num);//Alex Gerlants. 06/29/2022. 1251_Print_Skid_Tags_BL78_BL84. Begin
/*
Function:	wf_get_skid_seq_for_job
Returns		long	<== li_seq_job or li_rtn = -1 if DB error
Arguments:	value	long	al_skid_num
*/

Integer		li_seq_job, li_rtn = 1
Long			ll_selected_row

//ll_selected_row = dw_skid_list.GetRow()

//If ll_selected_row > 0 Then
	
	select nvl(sheet_skid.skid_seq_for_job, 0)
	into 	:li_seq_job
	from 	sheet_skid
	where	sheet_skid.sheet_skid_num = :al_skid_num
	using	sqlca;
	
	If li_seq_job <= 0 Then
		select nvl(sheet_skid.skid_seq_for_job,0)
		into :li_seq_job
		from sheet_skid
		where sheet_skid.sheet_skid_num = :al_skid_num
		using	sqlca;

		//MessageBox("of_get_update_skid_seq_for_job for u_office_recap_tabpg_bl110_das", "Inside IF. After 'update	sheet_skid' ~n~rli_seq_job = " + String(li_seq_job) + "~n~rsqlca.sqlcode = " + String(sqlca.sqlcode)) //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
		
		If sqlca.sqlcode = 0 Then //OK
			Return li_seq_job
		Else
			li_rtn = -1
			rollback using sqlca;
			MessageBox("Database error", "Database error in wf_get_skid_seq_for_job for w_sheet_skid_print_preview_das2 " + &
							"while retrieving skid_seq_for_job in table sheet_skid" + &
							"~n~rError: " + sqlca.SqlErrText)
		End If
	End If
//End If

Return li_rtn
//Alex Gerlants. 06/29/2022. 1251_Print_Skid_Tags_BL78_BL84. End
end function

on w_sheet_skid_print_preview_oe.create
int iCurrent
call super::create
this.cb_get_size=create cb_get_size
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.dw_skid_ticket_non_bl110=create dw_skid_ticket_non_bl110
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_get_size
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.dw_skid_ticket_non_bl110
end on

on w_sheet_skid_print_preview_oe.destroy
call super::destroy
destroy(this.cb_get_size)
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.dw_skid_ticket_non_bl110)
end on

event open;call super::open;Long						ll_ab_job_num, ll_sheet_skid_num, ll_selected_row, ll_shift_num, ll_null
Integer					li_rows, li_rtn, li_seq_job, li_job_status
String					ls_shift_desc, ls_modstring, ls_rtn
str_all_data_types	lstr_all_data_types


lstr_all_data_types = Message.PowerObjectParm

ll_ab_job_num = lstr_all_data_types.long_var[1]
ll_sheet_skid_num = lstr_all_data_types.long_var[2]
li_job_status = lstr_all_data_types.integer_var[1]
li_seq_job = lstr_all_data_types.integer_var[2]
If li_seq_job = 0 Then SetNull(li_seq_job)
ls_shift_desc = lstr_all_data_types.string_var[1]

If li_job_status = 0 Then //Job Done
	dw_skid_ticket_non_bl110.Dataobject = "d_skid_ticket_non_bl110_2_oe" //This datawindow retrieves skid weights
Else
	dw_skid_ticket_non_bl110.Dataobject = "d_skid_ticket_non_bl110_oe" //This datawindow does not retrieve skid weights
End If

dw_skid_ticket_non_bl110.SetTransObject(sqlca)
li_rows = dw_skid_ticket_non_bl110.Retrieve(ll_sheet_skid_num)

If li_rows > 0 Then
	dw_skid_ticket_non_bl110.Object.shift[1] = ls_shift_desc
	dw_skid_ticket_non_bl110.Object.skid_seq_for_job[1] = li_seq_job
	
	If li_job_status <> 0 Then //Job not Done
		SetNull(ll_null)
		
		ls_modstring = "t_tare.Text = ~"" + "" + "~""	
		ls_rtn = dw_skid_ticket_non_bl110.Modify(ls_modstring)
		
		ls_modstring = "t_net.Text = ~"" + "" + "~""	
		ls_rtn = dw_skid_ticket_non_bl110.Modify(ls_modstring)
		
		ls_modstring = "t_gross_wt.Text = ~"" + "" + "~""	
		ls_rtn = dw_skid_ticket_non_bl110.Modify(ls_modstring)
		
		//dw_skid_ticket_non_bl110.Object.t_tare = ""
		//dw_skid_ticket_non_bl110.Object.t_net = ""
		//dw_skid_ticket_non_bl110.Object.t_gross_wt = ""
	End If
End If

cb_get_size.Visible = False


end event

event pfc_postopen;call super::pfc_postopen;//This.Width = 5336
//This.Height = 2077
This.X = 534
This.Y = 99
end event

type cb_get_size from commandbutton within w_sheet_skid_print_preview_oe
integer x = 1865
integer y = 2252
integer width = 247
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Get Size"
end type

event clicked;MessageBox("", "Window Width: " + String(Parent.Width) + &
					"~n~rWindow Height: " + String(Parent.Height) + &
					"~n~rWindow X: " + String(Parent.X) + &
					"~n~rWindow Y: " + String(Parent.Y))
					
					
end event

type cb_cancel from commandbutton within w_sheet_skid_print_preview_oe
integer x = 1266
integer y = 2244
integer width = 325
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel/Close"
end type

event clicked;Close(Parent)
end event

type cb_print from commandbutton within w_sheet_skid_print_preview_oe
integer x = 704
integer y = 2244
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
boolean default = true
end type

event clicked;Integer	li_rtn, li_rows

//li_rows = dw_skid_ticket_non_bl110.RowCount()
//dw_skid_ticket_non_bl110.Print()

li_rtn = PrintSetup()
		
If li_rtn = -1 Then //Error in PrintSetup() or user clicked on "Cancel"
	Return 1
End If

dw_skid_ticket_non_bl110.Print()

end event

type dw_skid_ticket_non_bl110 from datawindow within w_sheet_skid_print_preview_oe
integer x = 283
integer y = 176
integer width = 1970
integer height = 2012
integer taborder = 10
boolean enabled = false
string title = "none"
string dataobject = "d_skid_ticket_non_bl110_2_oe"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

