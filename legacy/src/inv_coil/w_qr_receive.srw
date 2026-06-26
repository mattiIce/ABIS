$PBExportHeader$w_qr_receive.srw
forward
global type w_qr_receive from w_child
end type
type cb_qr_receive from commandbutton within w_qr_receive
end type
type cb_close from commandbutton within w_qr_receive
end type
type cb_retrieve from commandbutton within w_qr_receive
end type
type st_1 from statictext within w_qr_receive
end type
type sle_bol from singlelineedit within w_qr_receive
end type
type dw_qr_receive from datawindow within w_qr_receive
end type
type dw_coil_quality from datawindow within w_qr_receive
end type
type dw_coil_quality_flaw_mapping from datawindow within w_qr_receive
end type
end forward

global type w_qr_receive from w_child
integer width = 3354
integer height = 864
string title = "Update QR Code Data"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_qr_receive cb_qr_receive
cb_close cb_close
cb_retrieve cb_retrieve
st_1 st_1
sle_bol sle_bol
dw_qr_receive dw_qr_receive
dw_coil_quality dw_coil_quality
dw_coil_quality_flaw_mapping dw_coil_quality_flaw_mapping
end type
global w_qr_receive w_qr_receive

type variables
String	is_sqlerrtext, is_coil_org_num
Long		il_customer_id, il_coil_abc_num
end variables

forward prototypes
public function integer wf_coil_quality (long al_edi_file_id[], string as_bol_edi, long al_coil_abc_number[], string as_coil_org_num[])
public function integer wf_delete_ff_data (long al_coil_abc_num)
public subroutine wf_reset_coil_quality_dws ()
end prototypes

public function integer wf_coil_quality (long al_edi_file_id[], string as_bol_edi, long al_coil_abc_number[], string as_coil_org_num[]);//Alex Gerlants. Coil Quality. Begin
/*
Function:	wf_coil_quality
Returns;		integer	 1 if OK
							-1 if DB error
Arguments:	value		long		al_edi_file_id[]
				value		string	as_bol_edi
				value		long		al_coil_abc_number[]
				value		string	as_coil_org_num[]
*/

String	ls_barcode_string
String	ls_coil_org_number, ls_coil_org_number_arg, ls_part_num, ls_material_grade
String	ls_pre_treatment_flag, ls_cash_date_julian5, ls_mill_id
String	ls_gross_coil_length_dm, ls_net_coil_length_dm, ls_cash_date, ls_cm_date
String	ls_coil_width_mm, ls_coil_weight_kg, ls_material_thikness_mm, ls_cash_line_id, ls_payoff_direction

String	ls_sampling_code, ls_sampling_required, ls_placeholder1, ls_placeholder2
String	ls_starting_pos, ls_ending_pos, ls_flaw_code
String	ls_less_than_required_err_string, ls_good_coil_string

DateTime	ldt_date, ldt_cash_date, ldt_cm_date
Long		ll_edi_file_id
Long		ll_net_coil_length_inches, ll_coil_width_inches, ll_coil_weight_lbs, ll_gross_coil_length_inches
Long		ll_length, ll_length_diff_dm
Long		ll_inserted_row

Long		ll_pos, ll_i, ll_less_than_required_count, ll_good_coil_count
Long		ll_coil_abc_num

Integer	li_cash_line_id, li_coil_processed_count
Decimal	ldc_material_thickness_inches, ldc_starting_pos, ldc_ending_pos, ldc_coil_width_inches
Date		ld_date_out
Boolean	lb_error
Integer	li_year, li_month, li_day
Integer	li_rtn = 1, li_answer
Blob		lbl_barcode_string

//DataStore	lds_coil_quality
String	ls_revision_level, ls_less_than_required_error, ls_unknown_revision_level, ls_error_message
String	ls_start_end_pos_error, ls_start_end_pos_msg
Long		ll_unknown_revision_level, ll_start_end_pos_error

dw_coil_quality.SetTransObject(sqlca)
dw_coil_quality_flaw_mapping.SetTransObject(sqlca)

For ll_i = 1 To UpperBound(al_coil_abc_number[])
	ll_edi_file_id = al_edi_file_id[ll_i]
	ll_coil_abc_num = al_coil_abc_number[ll_i]
	ls_coil_org_number_arg = Trim(as_coil_org_num[ll_i])
		
	select	count(*) 
	into		:li_coil_processed_count
	from 		dbo.coil_quality
	where 	coil_abc_num = :ll_coil_abc_num
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then //OK
		If li_coil_processed_count > 0 Then
			li_answer = MessageBox("Are you sure?",	&
				"QR barcode for this ABC coil " + String(ll_coil_abc_num) + " has already been processed" + &
				"~n~rWould you like to replace data?", Question!, YesNo!, 2)
		
			If li_answer = 1 Then //Yes
				wf_delete_ff_data(ll_coil_abc_num)
			Else //No
				Continue
			End If
		End If
	Else //Db error
		li_rtn = -1
		
		MessageBox("Database Error", "Database Error occurred in wf_coil_quality for w_qr_receive while getting data from table coil_quality" + &
										"~n~rError:~n~r" + sqlca.sqlerrtext + &
										"~n~r~n~rHowever, the main coil processing will not stop.", Exclamation!)
		
		Exit
	End If

	select	distinct barcode_string
	into	 	:ls_barcode_string
	from		inbound_coil_status
	where		edi_file_id = :ll_edi_file_id
	and		bol = :as_bol_edi
	and		coil_number = :ls_coil_org_number_arg
	using		sqlca;
	
	If sqlca.sqlcode = 0 Or sqlca.sqlcode = 100 Then //OK or row not found
		If sqlca.sqlcode = 0 Then
			If IsNull(ls_barcode_string) Then ls_barcode_string = ""
		Else //sqlca.sqlcode = 100
			ls_barcode_string = ""
		End If
		
		If ls_barcode_string = "" Then
			//Try to get it from table barcode_string
			select	barcode_string
			into	 	:ls_barcode_string
			from		dbo.barcode_string
			where		coil_org_num = :ls_coil_org_number_arg
			using		sqlca;
			
			Choose Case sqlca.sqlcode
				Case 0
					If IsNull(ls_barcode_string) Then ls_barcode_string = ""
					If ls_barcode_string = "" Then Continue
				Case 100
					Continue
				Case Else
					li_rtn = -1
		
					MessageBox("Database Error", "Database Error occurred in wf_coil_quality for w_qr_receive while getting data from table barcode_string" + &
													"~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
					
					Exit
			End Choose
		End If
	Else //DB error
		li_rtn = -1
	
		MessageBox("Database Error", "Database Error occurred in wf_coil_quality for w_qr_receive while getting data from table inbound_coil_status" + &
										"~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
		
		Exit
	End If

	If IsNull(ls_barcode_string) Then ls_barcode_string = ""
	ll_length = Len(ls_barcode_string)
	
	If ll_length >= 2 Then //At least 2 characters. So we can get Revision Level
		ls_revision_level = Left(ls_barcode_string, 2)
		
		Choose Case ls_revision_level
			Case "00"
				If ll_length >= 68 Then //Good
					ls_good_coil_string = ls_good_coil_string + String(ll_coil_abc_num) + ", "
					ll_good_coil_count++
					li_rtn = f_coil_quality_00(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping)
				Else //Barcode string should not be shorter than 68 characters
					ls_less_than_required_error = ls_less_than_required_error + String( ll_coil_abc_num) + ", "
					ll_less_than_required_count++
					Continue //Go to the next coil
				End If
			Case "03"
				If ll_length >= 72 Then //Good
					ls_good_coil_string = ls_good_coil_string + String(ll_coil_abc_num) + ", "
					ll_good_coil_count++
					li_rtn = f_coil_quality_03(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping, ls_start_end_pos_error)
					
					If ls_start_end_pos_error <> "" Then
						ll_start_end_pos_error++
					End If
						
				Else //Barcode string should not be shorter than 72 characters
					ls_less_than_required_error = ls_less_than_required_error + String( ll_coil_abc_num) + ", "
					ll_less_than_required_count++
					Continue //Go to the next coil
				End If
			Case "04"
				If ll_length >= 72 Then //Good
					ls_good_coil_string = ls_good_coil_string + String(ll_coil_abc_num) + ", "
					ll_good_coil_count++
					li_rtn = f_coil_quality_04(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping, ls_start_end_pos_error)
					
					If ls_start_end_pos_error <> "" Then
						ll_start_end_pos_error++
					End If
				Else //Barcode string should not be shorter than 72 characters
					ls_less_than_required_error = ls_less_than_required_error + String( ll_coil_abc_num) + ", "
					ll_less_than_required_count++
					Continue //Go to the next coil
				End If				
			Case Else
				ls_unknown_revision_level = String(ll_coil_abc_num) + ", "
				ll_unknown_revision_level++
				Continue //Go to the next coil
		End Choose
	Else //Length of ls_barcode_string is less than 2 characters.
		ls_less_than_required_error = ls_less_than_required_error + String( ll_coil_abc_num) + ", "
		ll_less_than_required_count++
		Continue //Go to the next coil
	End If
Next
	
If ll_less_than_required_count > 0 Then //Some barcode strings have less than required. This is invalid
	//Remove the last comma
	ls_less_than_required_error = Left(ls_less_than_required_error, Len(ls_less_than_required_error) - 2)

	If ll_less_than_required_count = UpperBound(as_coil_org_num[]) Then //All coils have barcode strings that are less than required or not available
		
		
		ls_error_message = "Error in wf_coil_quality for w_qr_receive.~n~rAll coils have Quality barcode string lengths that are less than required or not available.~n~rNo quality barcode will be processed."
	Else
		ls_error_message = "Error in wf_coil_quality for w_qr_receive.~n~rThe following coils have Quality barcode string lengths that are less than required or not available:~n~r" + ls_less_than_required_error + &
												"~n~rThe following coils have valid Quality barcode strings:~n~r" + ls_good_coil_string
	End If
	
	GoTo END_OF_FUNCTION
End If

If ll_unknown_revision_level > 0 Then
	//Remove the last comma
	ls_unknown_revision_level = Left(ls_unknown_revision_level, Len(ls_unknown_revision_level) - 2)
	
	If ll_unknown_revision_level = UpperBound(as_coil_org_num[]) Then //All coils have barcode strings that have unknown revision level
		ls_error_message = "~n~rError in wf_coil_quality for w_qr_receive.~n~rAll coils Quality barcode strings that have unknown revision level." + &
									"~n~r~n~rHowever, the main coil processing will not stop."
	Else
		ls_error_message = "~n~rError in wf_coil_quality for w_qr_receive.~n~rThe following coils have Quality barcode strings that have unknown revision level:~n~r" + ls_less_than_required_error + &
												"~n~rThe following coils have valid Quality barcode strings:~n~r" + ls_good_coil_string
	End If
	
	GoTo END_OF_FUNCTION
End If

If ll_start_end_pos_error > 0 Then
	ls_error_message = ls_start_end_pos_error
End If

If ll_less_than_required_count > 0 Or ll_unknown_revision_level > 0 Or ll_start_end_pos_error > 0 Then
	li_rtn = -1
	MessageBox("Data Error", ls_error_message, StopSign!)
End If

//---------------------------------------------------------------------------------------------------------------

If li_rtn = 1 Then //OK above
	If ll_good_coil_count > 0 Then //Barcode string exists
		is_sqlerrtext = ""
		li_rtn = dw_coil_quality.Update()
		
		If li_rtn = 1 Then //OK
			li_rtn = dw_coil_quality_flaw_mapping.Update()
		
			If li_rtn = 1 Then //OK
				commit using sqlca;
			Else //DB Error
				li_rtn = -1
				rollback using sqlca;
				
				MessageBox("DB Error", "Database error occurred in wf_coil_quality for w_qr_receive while saving QR barcode data to table coil_quality_flaw_mapping." + &
										"~n~rError:~n~r" + is_sqlerrtext + &
										"~n~r~n~rExiting quality barcode processing", StopSign!)
			End If
		Else //DB Error
			li_rtn = -1
			rollback using sqlca;
			
			MessageBox("DB Error", "Database error occurred in wf_coil_quality for w_qr_receive while saving QR barcode data to table coil_quality." + &
									"~n~rError:~n~r" + is_sqlerrtext + &
									"~n~r~n~rExiting quality barcode processing", StopSign!)
									
			is_sqlerrtext = ""
		End If
	Else //ll_good_coil_count = 0. Barcode string does not exist or invalid or problem with start and/or end position
		li_rtn = 2
	End If
End If
//End If

END_OF_FUNCTION:

If li_rtn <> 1 Then //Problem
	wf_reset_coil_quality_dws() //It will not ask to save
End If

Return li_rtn
//Alex Gerlants. Coil Quality. End
end function

public function integer wf_delete_ff_data (long al_coil_abc_num);//Alex Gerlants. Coil Quality. Begin
/*
Function:	wf_delete_ff_data
Returns:		integer	 1 if OK
							-1 if DB error
Arguments:	value	long	al_coil_abc_num								
*/

Integer	li_rtn = 1, li_count

select	count(*)
into		:li_count
from		dbo.coil_quality
where		coil_abc_num = :al_coil_abc_num
using		sqlca;	

If sqlca.sqlcode = 0 Then //OK
	If li_count > 0 Then
		delete from dbo.coil_quality
		where	coil_abc_num = :al_coil_abc_num
		using	sqlca;	
		
		If sqlca.sqlcode = 0 Then //OK
			select	count(*)
			into		:li_count
			from		dbo.coil_quality_flaw_mapping
			where		coil_abc_num = :al_coil_abc_num
			using		sqlca;
			
			If sqlca.sqlcode = 0 Then //OK
				If li_count > 0 Then
					delete from dbo.coil_quality_flaw_mapping
					where	coil_abc_num = :al_coil_abc_num
					using	sqlca;
				
					If sqlca.sqlcode <> 0 Then //DB error
						li_rtn = -1
						
						MessageBox("DB Error",	&
									"Database error occurred in wf_coil_quality for w_coil_detail_2 " + &
									"while deleting data for Coil ABC Number " + String(al_coil_abc_num) + " from table coil_quality_flaw_mapping.", &
									StopSign!)
					End If
				End If
			Else
				MessageBox("DB Error",	&
								"Database error occurred in wf_coil_quality for w_coil_detail_2 " + &
								"while retrieving data for Coil ABC Number " + String(al_coil_abc_num) + " from table coil_quality_flaw_mapping.", &
								StopSign!)
			End if
		Else //DB error
			li_rtn = -1
			
			MessageBox("DB Error",	&
						"Database error occurred in wf_coil_quality for w_coil_detail_2 " + &
						"while deleting data for Coil ABC Number " + String(al_coil_abc_num) + " from table coil_quality.", &
						StopSign!)
		End If
	End If
Else //DB error
	li_rtn = -1
	
	MessageBox("DB Error",	&
						"Database error occurred in wf_coil_quality for w_coil_detail_2 " + &
						"while retrieving data for Coil ABC Number " + String(al_coil_abc_num) + " from table coil_quality.", &
						StopSign!)
End If

Return li_rtn
//Alex Gerlants. Coil Quality. End
end function

public subroutine wf_reset_coil_quality_dws ();/*
Functions:	wf_reset_coil_quality_dws
Returns:		none
Arguments:	none
*/

Long	ll_rows, ll_row

ll_rows = dw_coil_quality.RowCount()

For ll_row = 1 To ll_rows
	dw_coil_quality.SetItemStatus(ll_row, 0, Primary!, NotModified!)
Next

ll_rows = dw_coil_quality_flaw_mapping.RowCount()

For ll_row = 1 To ll_rows
	dw_coil_quality_flaw_mapping.SetItemStatus(ll_row, 0, Primary!, NotModified!)
Next
end subroutine

on w_qr_receive.create
int iCurrent
call super::create
this.cb_qr_receive=create cb_qr_receive
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
this.st_1=create st_1
this.sle_bol=create sle_bol
this.dw_qr_receive=create dw_qr_receive
this.dw_coil_quality=create dw_coil_quality
this.dw_coil_quality_flaw_mapping=create dw_coil_quality_flaw_mapping
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_qr_receive
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_retrieve
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_bol
this.Control[iCurrent+6]=this.dw_qr_receive
this.Control[iCurrent+7]=this.dw_coil_quality
this.Control[iCurrent+8]=this.dw_coil_quality_flaw_mapping
end on

on w_qr_receive.destroy
call super::destroy
destroy(this.cb_qr_receive)
destroy(this.cb_close)
destroy(this.cb_retrieve)
destroy(this.st_1)
destroy(this.sle_bol)
destroy(this.dw_qr_receive)
destroy(this.dw_coil_quality)
destroy(this.dw_coil_quality_flaw_mapping)
end on

event open;call super::open;str_all_data_types	lstr_all_data_types

dw_coil_quality.Visible = False
dw_coil_quality_flaw_mapping.Visible = False

lstr_all_data_types = Message.PowerObjectParm

il_customer_id = lstr_all_data_types.long_var[1]
is_coil_org_num = lstr_all_data_types.string_var[1]
il_coil_abc_num = lstr_all_data_types.long_var[2]

end event

type cb_qr_receive from commandbutton within w_qr_receive
integer x = 991
integer y = 659
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "QR Receive"
end type

event clicked;Long		ll_selected_row, ll_edi_file_id[], ll_coil_abc_num[]
String	ls_bol, ls_coil_org_num[]
Integer	li_rtn

ll_selected_row = dw_qr_receive.GetSelectedRow(0)

If ll_selected_row > 0 Then
	ll_edi_file_id[1] = dw_qr_receive.Object.edi_file_id[ll_selected_row]
	ls_bol = dw_qr_receive.Object.bol[ll_selected_row]
	ls_coil_org_num[1] = dw_qr_receive.Object.coil_number[ll_selected_row]
	ll_coil_abc_num[1] = dw_qr_receive.Object.coil_abc_num[ll_selected_row]	
	
	//Update QR code parsing tables: coil_quality and coil_quality_flaw_mapping
	li_rtn = wf_coil_quality(ll_edi_file_id[], ls_bol, ll_coil_abc_num[], ls_coil_org_num[])
	
	Choose Case li_rtn
		Case 0 //User didn't want to replace existing QR code data
			MessageBox("Cancelled", "Cancelled by user")
		Case 1
			MessageBox("Success", "QR barcode for Originl Coil " + ls_coil_org_num[1] + " and ABC Coil " + String(ll_coil_abc_num[1]) + " successfully processed", Information!)
		Case 2
			MessageBox("Nothing processed", "QR barcode for Originl Coil " + ls_coil_org_num[1] + " and ABC Coil " + String(ll_coil_abc_num[1]) + " invalid", Information!)
		Case Else //Error in wf_coil_quality()
			//All error messages are in wf_coil_quality()
	End Choose
End If
end event

type cb_close from commandbutton within w_qr_receive
integer x = 1847
integer y = 659
integer width = 322
integer height = 90
integer taborder = 20
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

type cb_retrieve from commandbutton within w_qr_receive
integer x = 691
integer y = 58
integer width = 267
integer height = 86
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;String	ls_bol
Long		ll_rows, ll_selected_row

ls_bol = sle_bol.Text
If IsNull(ls_bol) Then ls_bol = ""

If ls_bol <> "" Then
	dw_qr_receive.SetTransObject(sqlca)
	dw_qr_receive.Retrieve(il_customer_id, ls_bol, is_coil_org_num, il_coil_abc_num)
End If
end event

type st_1 from statictext within w_qr_receive
integer x = 59
integer y = 10
integer width = 388
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please enter BOL"
boolean focusrectangle = false
end type

type sle_bol from singlelineedit within w_qr_receive
integer x = 55
integer y = 74
integer width = 625
integer height = 61
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_qr_receive from datawindow within w_qr_receive
integer x = 59
integer y = 208
integer width = 3229
integer height = 416
integer taborder = 10
string title = "none"
string dataobject = "d_qr_receive"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

ls_name = dwo.Name

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		  
		This.SetSort(ls_column + " " + lc_sort)
	Else
		This.SetSort(ls_column + " A")
	End If

	This.Sort()
End If


If row > 0 Then
	If IsSelected(row) Then
		This.SelectRow(0, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
end event

type dw_coil_quality from datawindow within w_qr_receive
integer x = 219
integer y = 717
integer width = 161
integer height = 64
integer taborder = 20
string title = "none"
string dataobject = "d_coil_quality"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;is_sqlerrtext = sqlerrtext
Return 1 //Do not display error message. I am displaying an error message in my code 
end event

type dw_coil_quality_flaw_mapping from datawindow within w_qr_receive
integer y = 720
integer width = 183
integer height = 67
integer taborder = 10
string title = "none"
string dataobject = "d_coil_quality_flaw_mapping"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;is_sqlerrtext = sqlerrtext
Return 1 //Do not display error message. I am displaying an error message in my code
end event

