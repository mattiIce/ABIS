$PBExportHeader$w_qr_manual.srw
forward
global type w_qr_manual from w_child
end type
type cb_clear from commandbutton within w_qr_manual
end type
type cb_go from commandbutton within w_qr_manual
end type
type cb_close from commandbutton within w_qr_manual
end type
type st_coil_abc_num from statictext within w_qr_manual
end type
type st_coil_org_num from statictext within w_qr_manual
end type
type sle_barcode_string from singlelineedit within w_qr_manual
end type
type dw_coil_quality_flaw_mapping from datawindow within w_qr_manual
end type
type dw_coil_quality from datawindow within w_qr_manual
end type
end forward

global type w_qr_manual from w_child
integer width = 2476
integer height = 602
string title = "Manually Update QR Code Data"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_clear cb_clear
cb_go cb_go
cb_close cb_close
st_coil_abc_num st_coil_abc_num
st_coil_org_num st_coil_org_num
sle_barcode_string sle_barcode_string
dw_coil_quality_flaw_mapping dw_coil_quality_flaw_mapping
dw_coil_quality dw_coil_quality
end type
global w_qr_manual w_qr_manual

type variables
String	is_coil_org_num
String	is_sqlerrtext
Long		il_coil_abc_num
end variables

forward prototypes
public function integer wf_delete_ff_data (long al_coil_abc_num)
public function integer wf_update_barcode_string (string as_coil_org_num, long al_coil_abc_num, string as_barcode_string)
public function integer wf_coil_quality_manual_add (string as_barcode_string, string as_coil_org_num_arg, long al_coil_abc_num)
public function integer wf_coil_quality_00 (string as_barcode_string, long al_coil_abc_num)
public function integer wf_coil_quality_03 (string as_barcode_string, long al_coil_abc_num)
public subroutine wf_reset_coil_quality_dws ()
end prototypes

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

public function integer wf_update_barcode_string (string as_coil_org_num, long al_coil_abc_num, string as_barcode_string);//Alex Gerlants. Coil Quality. Begin
/*
Function:	wf_update_barcode_string
Returns:		integer			 1 if OK
									-1 if DB error
Arguments:	value	string	as_coil_org_num
				value	long		al_coil_abc_num
				value	string	as_barcode_string
*/

Integer	li_rtn = 1, li_count

select	count(*)
into		:li_count
from		dbo.barcode_string
where		coil_org_num = :as_coil_org_num
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	If li_count > 0 Then
		update	dbo.barcode_string
		set		barcode_string = :as_barcode_string
		where		coil_org_num = :as_coil_org_num
		using		sqlca;
		
		If sqlca.sqlcode <> 0 Then //DB error
			li_rtn = -1
			
			MessageBox("DB Error", 	"Database error occurred in wf_update_barcode_string for w_qr_manual " + &
											"while updating data in table barcode_string for Coil Org Number " + as_coil_org_num + "." + &
											"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
		End If
	Else
		insert into dbo.barcode_string values(:as_coil_org_num, :as_barcode_string) using sqlca;
		
		If sqlca.sqlcode <> 0 Then //DB error
			li_rtn = -1
						
			MessageBox("DB Error", 	"Database error occurred in wf_update_barcode_string for w_qr_manual " + &
											"while inserting data into table barcode_string for Coil Org Number " + as_coil_org_num + "." + &
											"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
		End If
	End If
Else //DB error
	li_rtn = -1
				
	MessageBox("DB Error", 	"Database error occurred in wf_update_barcode_string for w_qr_manual " + &
									"while retrieving data from table barcode_string for Coil Org Number " + as_coil_org_num + "." + &
									"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
End If

			
If li_rtn = 1 Then //OK above

	select	count(*)
	into		:li_count
	from		inbound_coil_status
	where		coil_number = :as_coil_org_num
	using		sqlca;	
	
	If sqlca.sqlcode = 0 Then //OK
		If li_count > 0 Then
			update	inbound_coil_status
			set		barcode_string = :as_barcode_string
			where		coil_number = :as_coil_org_num
			using		sqlca;	
			
			If sqlca.sqlcode <> 0 Then //DB error
				li_rtn = -1
				
				MessageBox("DB Error", 	"Database error occurred in wf_update_barcode_string for w_qr_manual " + &
												"while updating barcode_string in table inbound_coil_status for Coil ABC Number " + String(al_coil_abc_num) + "." + &
												"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
			End If
		End If
	Else //DB error
		li_rtn = -1
				
		MessageBox("DB Error", 	"Database error occurred in wf_update_barcode_string for w_qr_manual " + &
										"while retrieving data from table inbound_coil_status for Coil ABC Number " + String(al_coil_abc_num) + "." + &
										"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
	End If
Else  //DB error
	
End If

Return li_rtn
//Alex Gerlants. Coil Quality. End
end function

public function integer wf_coil_quality_manual_add (string as_barcode_string, string as_coil_org_num_arg, long al_coil_abc_num);//Alex Gerlants. Coil Quality. Begin
/*
Function:	wf_coil_quality_manual_add
Returns;		integer	 1 if OK
							-1 if DB error
Arguments:	value		string	as_barcode_string
				value		string	as_coil_org_num_arg
				value		long		al_coil_abc_num
*/

String	ls_barcode_string
String	ls_coil_org_number, ls_part_num, ls_material_grade
String	ls_pre_treatment_flag, ls_cash_date_julian5, ls_mill_id
String	ls_gross_coil_length_dm, ls_net_coil_length_dm, ls_cash_date, ls_cm_date
String	ls_coil_width_mm, ls_coil_weight_kg, ls_material_thikness_mm, ls_cash_line_id, ls_payoff_direction

String	ls_sampling_code, ls_sampling_required, ls_placeholder1, ls_placeholder2
String	ls_starting_pos, ls_ending_pos, ls_flaw_code

DateTime	ldt_date, ldt_cash_date, ldt_cm_date
Long		ll_edi_file_id
Long		ll_net_coil_length_inches, ll_coil_width_inches, ll_coil_weight_lbs, ll_gross_coil_length_inches
Long		ll_length, ll_length_diff_dm
Long		ll_inserted_row

Long		ll_pos, ll_i, ll_count
Long		ll_coil_abc_num

Integer	li_cash_line_id
Decimal	ldc_material_thickness_inches, ldc_starting_pos, ldc_ending_pos, ldc_coil_width_inches
Date		ld_date_out
Boolean	lb_error
Integer	li_year, li_month, li_day
Integer	li_rtn = 1

String	ls_revision_level, ls_start_end_pos_error
Long		ll_start_end_pos_error

//---

as_barcode_string = Trim(as_barcode_string) //Trim extra spaces at both ends if any

//Delete from coil_quality and coil_quality_flaw_mapping for il_coil_abc_num
li_rtn = wf_delete_ff_data(al_coil_abc_num)

If li_rtn = -1 Then //Error in wf_delete_ff_data()
	Return li_rtn
End If

//Update inbound_coil_status with as_barcode_string for il_coil_abc_num
li_rtn = wf_update_barcode_string(as_coil_org_num_arg, al_coil_abc_num, as_barcode_string)

If li_rtn = -1 Then //Error in wf_update_barcode_string(). Error messages are there too.
	Return li_rtn
End If

dw_coil_quality.SetTransObject(sqlca)
dw_coil_quality_flaw_mapping.SetTransObject(sqlca)

ls_barcode_string = as_barcode_string 
ll_coil_abc_num = al_coil_abc_num

If IsNull(ls_barcode_string) Then ls_barcode_string = ""
ll_length = Len(ls_barcode_string)

//------------------------------------------------------------------------------------------

If ll_length >= 2 Then //At least 2 characters. So we can get Revision Level
	ls_revision_level = Left(ls_barcode_string, 2)
	
	Choose Case ls_revision_level
		Case "00"
			If ll_length >= 68 Then //Good
				li_rtn = f_coil_quality_00(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping)
			Else //Barcode string should not be shorter than 68 characters
				li_rtn = -1
				MessageBox("Data Error", "QR Barcode string is less than 68 characters.~n~rPlease correct.", StopSign!)
			End If
		Case "03"
			If ll_length >= 72 Then //Good
				li_rtn = f_coil_quality_03(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping, ls_start_end_pos_error)
				
				If ls_start_end_pos_error <> "" Then
					MessageBox("Data Error", ls_start_end_pos_error, StopSign!)
				End If
			Else //Barcode string should not be shorter than 72 characters
				li_rtn = -1
				MessageBox("Data Error", "QR Barcode string is less than 72 characters.~n~rPlease correct.", StopSign!)
			End If
		Case "04"
			If ll_length >= 72 Then //Good
				li_rtn = f_coil_quality_04(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping, ls_start_end_pos_error)
				
				If ls_start_end_pos_error <> "" Then
					MessageBox("Data Error", ls_start_end_pos_error, StopSign!)
				End If
			Else //Barcode string should not be shorter than 72 characters
				li_rtn = -1
				MessageBox("Data Error", "QR Barcode string is less than 72 characters.~n~rPlease correct.", StopSign!)
			End If			
		Case Else
			li_rtn = -1
			MessageBox("Data Error", "Unknown revision level (first 2 characters).~n~rPlease correct.", StopSign!)
	End Choose
Else //Length of ls_barcode_string is less than 2 characters.
	li_rtn = -1
	MessageBox("Data Error", "QR Barcode string is less than 2 characters.~n~rPlease correct.", StopSign!)
End If

//------------------------------------------------------------------------------------------

//dw_coil_quality.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
//dw_coil_quality_flaw_mapping.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
	
If li_rtn = 1 Then //OK above
	is_sqlerrtext = ""
	li_rtn = dw_coil_quality.Update()
	
	If li_rtn = 1 Then //OK
		li_rtn = dw_coil_quality_flaw_mapping.Update()
	
		If li_rtn = 1 Then //OK
			commit using sqlca;
		Else //DB Error
			li_rtn = -1
			rollback using sqlca;
			
			MessageBox("DB Error", "Database error occurred in wf_coil_quality_manual_add for w_qr_manual while saving QR barcode data to table coil_quality_flaw_mapping." + &
									"~n~rError:~n~r" + is_sqlerrtext, StopSign!)
		End If
	Else //DB Error
		li_rtn = -1
		rollback using sqlca;
		
		MessageBox("DB Error", "Database error occurred in wf_coil_quality_manual_add for w_qr_manual while saving QR barcode data to table coil_quality." + &
								"~n~rError:~n~r" + is_sqlerrtext, StopSign!)
								
		is_sqlerrtext = ""
	End If
Else //Error
	wf_reset_coil_quality_dws() //It will not ask to save
	rollback using sqlca;	
End If

Return li_rtn
//Alex Gerlants. Coil Quality. End
end function

public function integer wf_coil_quality_00 (string as_barcode_string, long al_coil_abc_num);/***************************************************************************************************************************

                                     This function is NOT used
						    It is replaced with external function f_coil_quality_00

***************************************************************************************************************************/

//Alex Gerlants. Coil Quality. 02/06/2018.Begin
/*
Function:	wf_coil_quality_00
Returns;		integer	 1 if OK
							-1 if DB error
Arguments:	value			string	as_barcode_string
				value			long		al_coil_abc_num
*/

Integer	li_rtn = 1

//String	ls_barcode_string
//String	ls_coil_org_number, ls_coil_org_number_arg, ls_part_num, ls_material_grade
//String	ls_pre_treatment_flag, ls_cash_date_julian5, ls_mill_id
//String	ls_gross_coil_length_dm, ls_net_coil_length_dm, ls_cash_date, ls_cm_date
//String	ls_coil_width_mm, ls_coil_weight_kg, ls_material_thikness_mm, ls_cash_line_id, ls_payoff_direction
//
//String	ls_sampling_code, ls_sampling_required, ls_placeholder1, ls_placeholder2
//String	ls_starting_pos, ls_ending_pos, ls_flaw_code
//String	ls_less_than_68_err_string, ls_good_coil_string
//
//DateTime	ldt_date, ldt_cash_date, ldt_cm_date
//Long		ll_edi_file_id
//Long		ll_net_coil_length_inches, ll_coil_width_inches, ll_coil_weight_lbs, ll_gross_coil_length_inches
//Long		ll_length, ll_length_diff_dm
//Long		ll_inserted_row
//
//Long		ll_pos, ll_i, ll_less_than_68_count, ll_good_coil_count
//Long		ll_coil_abc_num
//
//Integer	li_cash_line_id, li_coil_processed_count
//Decimal	ldc_material_thickness_inches, ldc_starting_pos, ldc_ending_pos, ldc_coil_width_inches
//Date		ld_date_out
//Boolean	lb_error
//Integer	li_year, li_month, li_day
//	
////At this point, as_barcode_string is validated in wf_coil_quality
//ls_barcode_string = as_barcode_string
//
//ls_part_num = Trim(Left(ls_barcode_string, 12))
//ls_material_grade = Mid(ls_barcode_string, 13, 4)
//ls_pre_treatment_flag = Mid(ls_barcode_string, 17, 1)
//ls_cash_date_julian5 = Mid(ls_barcode_string, 18, 5)
//ls_mill_id = Mid(ls_barcode_string, 23, 5)
//ls_coil_org_number = Trim(Mid(ls_barcode_string, 28, 10))
//ls_net_coil_length_dm = Mid(ls_barcode_string, 38, 5)
//ls_coil_width_mm = Mid(ls_barcode_string, 43, 4)
//ls_coil_weight_kg = Mid(ls_barcode_string, 47, 6)
//ls_material_thikness_mm = Mid(ls_barcode_string, 53, 3)
////Separator - 1 character: 56
//ls_gross_coil_length_dm = Mid(ls_barcode_string, 57, 5)
//ls_cash_line_id = Mid(ls_barcode_string, 62, 5)
//ls_payoff_direction = Mid(ls_barcode_string, 67, 1)
////Separator - 1 character: 68
//ls_placeholder1 = Mid(ls_barcode_string, 69, 5)
//ls_placeholder1 = Mid(ls_barcode_string, 74, 5)
//ls_sampling_code = Mid(ls_barcode_string, 79, 1)
//If IsNull(ls_sampling_code) Then ls_sampling_code = ""
////Separator - 1 character: 80
//
//If Len(ls_barcode_string) > 68 Then
//	If ls_sampling_code = "7" Then //Sampling section is present in ls_barcode_string
//		ls_sampling_required = "Y"
//		ll_pos = 81 
//	Else //Sampling section is not present (omitted) in ls_barcode_string
//		ls_sampling_required = "N"
//		ll_pos = 69
//	End If
//	
//	//Loop through Flaw Mapping segments. According to spec, one QR barcode can have maximum of 20 flaw notes.
//	//ll_pos controls starting displacement of a field in a Flaw Mapping segment.
//	Do While ll_pos <= Len(ls_barcode_string)
//		ls_starting_pos = Mid(ls_barcode_string, ll_pos, 5)
//		If IsNull(ls_starting_pos) Then ls_starting_pos = ""
//		ll_pos = ll_pos + 5
//		
//		ls_ending_pos = Mid(ls_barcode_string, ll_pos, 5)
//		If IsNull(ls_ending_pos) Then ls_ending_pos = ""
//		ll_pos = ll_pos + 5
//		
//		ls_flaw_code = Mid(ls_barcode_string, ll_pos, 1)
//		If IsNull(ls_flaw_code) Then ls_flaw_code = ""
//		ll_pos = ll_pos + 2 //ls_flaw_code is 1 character + 1 character for separator $
//		
//		ll_inserted_row = dw_coil_quality_flaw_mapping.InsertRow(0)
//		
//		If ll_inserted_row > 0 Then
//			dw_coil_quality_flaw_mapping.Object.coil_abc_num[ll_inserted_row] = al_coil_abc_num
//			dw_coil_quality_flaw_mapping.Object.coil_org_num[ll_inserted_row] = ls_coil_org_number
//			
//			//The data in the QR code is in the order it was ran off the CASH line which is from ID to OD. 
//			//The data must be interpreted and flipped to map the flaws starting from the OD.
//			//Thus starting position from ID becomes ending position from OD;
//			//and ending point from ID becomes starting point from OD.
//			
//			//ll_length_diff_dm is combined cropped length at the beginning and end of coil
//			ll_length_diff_dm = Long(ls_gross_coil_length_dm) - Long(ls_net_coil_length_dm) //I don't need this
//			
//			If Long(ls_ending_pos) >= Long(ls_gross_coil_length_dm) Then
//				ldc_starting_pos = 0
//			Else
//				ldc_starting_pos = Dec(String((Long(ls_gross_coil_length_dm) * 3.93701) - (Long(ls_ending_pos) * 3.93701), "###,##0.0000")) //Convert decimeters into inches, and flip starting and ending positions
//			End If
//			
//			dw_coil_quality_flaw_mapping.Object.starting_position[ll_inserted_row] = ldc_starting_pos
//
//			If Long(ls_starting_pos) >= Long(ls_gross_coil_length_dm) Then
//				ldc_ending_pos = 0
//			Else
//				ldc_ending_pos = Dec(String((Long(ls_gross_coil_length_dm) * 3.93701) - (Long(ls_starting_pos) * 3.93701), "###,##0.0000")) //Convert decimeters into inches, and flip starting and ending positions
//			End If
//			
//			dw_coil_quality_flaw_mapping.Object.ending_position[ll_inserted_row] = ldc_ending_pos
//
//			dw_coil_quality_flaw_mapping.Object.flaw_code[ll_inserted_row] = ls_flaw_code
//			dw_coil_quality_flaw_mapping.Object.starting_position_uom[ll_inserted_row] = "inches"
//			dw_coil_quality_flaw_mapping.Object.ending_position_uom[ll_inserted_row] = "inches"
//		End If
//	Loop
//End If
//
//If IsNumber(ls_cash_date_julian5) Then
//	lb_error = f_convert_julian5_to_mmddyyyy(Long(ls_cash_date_julian5), ld_date_out, li_year, li_month, li_day)
//	
//	If Not lb_error Then //OK
//		If Upper(ls_pre_treatment_flag) = "T" Then
//			ldt_cash_date = DateTime(ld_date_out, Time("00:00:00"))
//			SetNull(ldt_cm_date)
//		Else
//			ldt_cm_date = DateTime(ld_date_out, Time("00:00:00"))
//			SetNull(ldt_cash_date)
//		End If
//	Else //Error
//		SetNull(ldt_cash_date)
//		SetNull(ldt_cm_date)
//	End If
//Else //Error: ls_cash_date_julian5 is not number
//	SetNull(ldt_cash_date)
//	SetNull(ldt_cm_date)
//End If
//
//If IsNumber(ls_net_coil_length_dm) Then
//	ll_net_coil_length_inches = Long(ls_net_coil_length_dm) * 3.93701 //Convert decimeters into inches
//Else //Error: ls_net_coil_length_dm is not number
//	SetNull(ll_net_coil_length_inches)
//End If
//
//If IsNumber(ls_coil_width_mm) Then
//	ldc_coil_width_inches = long(ls_coil_width_mm) / 25.4 //Convert millimeters into inches
//Else //Error: ls_coil_width_mm is not number
//	SetNull(ldc_coil_width_inches)
//End If
//
//If IsNumber(ls_coil_weight_kg) Then
//	ll_coil_weight_lbs = Long(ls_coil_weight_kg) * 2.20462 //Convert kilograms into pounds
//Else //Error: ls_coil_weight_kg is not number
//	SetNull(ll_coil_weight_lbs)
//End If
//
//If IsNumber(ls_material_thikness_mm) Then
//	ldc_material_thickness_inches = Dec(ls_material_thikness_mm) / 25.4 //Convert millimeters into inches
//Else //Error: ls_material_thikness_mm is not number
//	SetNull(ldc_material_thickness_inches)
//End If
//
//If IsNumber(ls_gross_coil_length_dm) Then
//	ll_gross_coil_length_inches = Long(ls_gross_coil_length_dm) * 3.93701 //Convert decimeters into inches
//Else //Error: ls_gross_coil_length_dm is not number
//	SetNull(ll_gross_coil_length_inches)
//End If
//
//If IsNumber(ls_cash_line_id) Then
//	li_cash_line_id = Integer(ls_cash_line_id)
//Else //Error: ls_cash_line_id is not number
//	SetNull(li_cash_line_id)
//End If
//
//ll_inserted_row = dw_coil_quality.InsertRow(0)
//
//If ll_inserted_row > 0 Then
//	dw_coil_quality.Object.coil_abc_num[ll_inserted_row] = al_coil_abc_num
//	dw_coil_quality.Object.coil_org_num[ll_inserted_row] = Trim(ls_coil_org_number)
//	dw_coil_quality.Object.part_num[ll_inserted_row] = ls_part_num
//	dw_coil_quality.Object.material_grade[ll_inserted_row] = ls_material_grade
//	dw_coil_quality.Object.pre_treatment_flag[ll_inserted_row] = ls_pre_treatment_flag
//	dw_coil_quality.Object.cash_date_julian5[ll_inserted_row] = ls_cash_date_julian5
//	dw_coil_quality.Object.cash_date[ll_inserted_row] = ldt_cash_date
//	dw_coil_quality.Object.cm_date[ll_inserted_row] = ldt_cm_date
//	dw_coil_quality.Object.mill_id[ll_inserted_row] = ls_mill_id
//	dw_coil_quality.Object.gross_coil_length[ll_inserted_row] = ll_gross_coil_length_inches
//	dw_coil_quality.Object.gross_coil_length_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.net_coil_length[ll_inserted_row] = ll_net_coil_length_inches
//	dw_coil_quality.Object.net_coil_length_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.coil_width[ll_inserted_row] = ldc_coil_width_inches
//	dw_coil_quality.Object.coil_width_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.coil_weight[ll_inserted_row] = ll_coil_weight_lbs
//	dw_coil_quality.Object.coil_weight_uom[ll_inserted_row] = 'pounds'
//	dw_coil_quality.Object.material_thikness[ll_inserted_row] = ldc_material_thickness_inches
//	dw_coil_quality.Object.material_thikness_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.cash_line_id[ll_inserted_row] = li_cash_line_id
//	dw_coil_quality.Object.payoff_direction[ll_inserted_row] = ls_payoff_direction
//	dw_coil_quality.Object.sampling_required[ll_inserted_row] = ls_sampling_required
//	dw_coil_quality.Object.revision_level[ll_inserted_row] = "00"
//End If
//
Return li_rtn
////Alex Gerlants. Coil Quality. 02/06/2018.End
end function

public function integer wf_coil_quality_03 (string as_barcode_string, long al_coil_abc_num);/***************************************************************************************************************************

                                     This function is NOT used
						    It is replaced with external function f_coil_quality_03

***************************************************************************************************************************/

Integer	li_rtn = 1

////Alex Gerlants. Coil Quality. 02/06/2018.Begin
///*
//Function:	wf_coil_quality_03
//Returns;		integer	 1 if OK
//							-1 if DB error
//Arguments:	value		string	as_barcode_string
//				value		long		al_coil_abc_num
//*/
//
//String	ls_barcode_string
//String	ls_coil_org_number, ls_coil_org_number_arg, ls_part_num = "", ls_material_grade
//String	ls_pre_treatment_flag, ls_cash_date_julian5, ls_mill_id
//String	ls_gross_coil_length_dm, ls_net_coil_length_dm, ls_cash_date, ls_cm_date
//String	ls_coil_width_mm, ls_coil_weight_kg, ls_material_thikness_mm, ls_cash_line_id, ls_payoff_direction
//
//String	ls_sampling_code, ls_sampling_required, ls_placeholder1, ls_placeholder2
//String	ls_starting_pos, ls_ending_pos, ls_flaw_code
//String	ls_less_than_68_err_string, ls_good_coil_string
//
//DateTime	ldt_date, ldt_cash_date, ldt_cm_date
//Long		ll_edi_file_id
//Long		ll_net_coil_length_inches, ll_coil_width_inches, ll_coil_weight_lbs, ll_gross_coil_length_inches
//Long		ll_length, ll_length_diff_dm
//Long		ll_inserted_row
//
//Long		ll_pos, ll_i, ll_less_than_68_count, ll_good_coil_count
//Long		ll_coil_abc_num
//
//Integer	li_cash_line_id, li_coil_processed_count
//Decimal	ldc_material_thickness_inches, ldc_starting_pos, ldc_ending_pos, ldc_coil_width_inches
//Date		ld_date_out
//Boolean	lb_error
//Integer	li_year, li_month, li_day
//Blob		lbl_barcode_string
//String	ls_revision_level, ls_pcc_number
//
////At this point, as_barcode_string is validated in wf_coil_quality
//ls_barcode_string = as_barcode_string
//
//ls_revision_level = Trim(Left(ls_barcode_string, 2))
//ls_pcc_number = Trim(Mid(ls_barcode_string, 3, 12))
//ls_material_grade = Trim(Mid(ls_barcode_string, 15, 5))
//ls_pre_treatment_flag = Mid(ls_barcode_string, 20, 1)
//ls_cash_date_julian5 = Mid(ls_barcode_string, 21, 5)
//ls_mill_id = Trim(Mid(ls_barcode_string, 26, 5))
//ls_coil_org_number = Trim(Mid(ls_barcode_string, 31, 10))
//ls_gross_coil_length_dm = Trim(Mid(ls_barcode_string, 41, 6))
//ls_net_coil_length_dm = Trim(Mid(ls_barcode_string, 47, 6))
//ls_coil_width_mm = Trim(Mid(ls_barcode_string, 53, 4))
//ls_coil_weight_kg = Trim(Mid(ls_barcode_string, 57, 5))
//ls_material_thikness_mm =Trim( Mid(ls_barcode_string, 62, 5))
//ls_cash_line_id = Trim(Mid(ls_barcode_string, 67, 3))
//ls_sampling_code = Mid(ls_barcode_string, 70, 1)
//
//ls_payoff_direction = Mid(ls_barcode_string, 71, 1)
//
////Convert the new code to the original code. Thus it can be correctly translated on d_ff_data_4coil
//Choose Case Upper(ls_payoff_direction)
//	Case "O"
//		ls_payoff_direction = "8"
//	Case "U"
//		ls_payoff_direction = "9"
//	Case Else
//		ls_payoff_direction = ""
//End Choose
//
////Separator - 1 character: 72
//
//If Len(ls_barcode_string) > 72 Then
//	ll_pos = 73
//	
//	Do While ll_pos <= Len(ls_barcode_string)
//		
//		ls_starting_pos = Mid(ls_barcode_string, ll_pos, 6)
//		If IsNull(ls_starting_pos) Then ls_starting_pos = ""
//		ll_pos = ll_pos + 6
//		
//		ls_ending_pos = Mid(ls_barcode_string, ll_pos, 6)
//		If IsNull(ls_ending_pos) Then ls_ending_pos = ""
//		ll_pos = ll_pos + 6
//		
//		ls_flaw_code = Mid(ls_barcode_string, ll_pos, 1)
//		If IsNull(ls_flaw_code) Then ls_flaw_code = ""
//		ll_pos = ll_pos + 2 //ls_flaw_code is 1 character + 1 character for separator $
//		
//		ll_inserted_row = dw_coil_quality_flaw_mapping.InsertRow(0)
//		
//		If ll_inserted_row > 0 Then
//			dw_coil_quality_flaw_mapping.Object.coil_abc_num[ll_inserted_row] = al_coil_abc_num
//			dw_coil_quality_flaw_mapping.Object.coil_org_num[ll_inserted_row] = ls_coil_org_number
//			
//			//The data in the QR code is in the order it was ran off the CASH line which is from ID to OD. 
//			//The data must be interpreted and flipped to map the flaws starting from the OD.
//			//Thus starting position from ID becomes ending position from OD;
//			//and ending point from ID becomes starting point from OD.
//			
//			//ll_length_diff_dm is combined cropped length at the beginning and end of coil
//			ll_length_diff_dm = Long(ls_gross_coil_length_dm) - Long(ls_net_coil_length_dm) //I don't need this
//			
//			If Long(ls_ending_pos) >= Long(ls_gross_coil_length_dm) Then
//				ldc_starting_pos = 0
//			Else
//				ldc_starting_pos = Dec(String((Long(ls_gross_coil_length_dm) * 3.93701) - (Long(ls_ending_pos) * 3.93701), "###,##0.0000")) //Convert decimeters into inches, and flip starting and ending positions
//			End If
//			
//			dw_coil_quality_flaw_mapping.Object.starting_position[ll_inserted_row] = ldc_starting_pos
//
//			If Long(ls_starting_pos) >= Long(ls_gross_coil_length_dm) Then
//				ldc_ending_pos = 0
//			Else
//				ldc_ending_pos = Dec(String((Long(ls_gross_coil_length_dm) * 3.93701) - (Long(ls_starting_pos) * 3.93701), "###,##0.0000")) //Convert decimeters into inches, and flip starting and ending positions
//			End If
//			
//			dw_coil_quality_flaw_mapping.Object.ending_position[ll_inserted_row] = ldc_ending_pos
//
//			dw_coil_quality_flaw_mapping.Object.flaw_code[ll_inserted_row] = ls_flaw_code
//			dw_coil_quality_flaw_mapping.Object.starting_position_uom[ll_inserted_row] = "inches"
//			dw_coil_quality_flaw_mapping.Object.ending_position_uom[ll_inserted_row] = "inches"
//		End If
//	Loop
//End If
//
//If IsNumber(ls_cash_date_julian5) Then
//	lb_error = f_convert_julian5_to_mmddyyyy(Long(ls_cash_date_julian5), ld_date_out, li_year, li_month, li_day)
//	
//	If Not lb_error Then //OK
//		If Upper(ls_pre_treatment_flag) = "T" Then
//			ldt_cash_date = DateTime(ld_date_out, Time("00:00:00"))
//			SetNull(ldt_cm_date)
//		Else
//			ldt_cm_date = DateTime(ld_date_out, Time("00:00:00"))
//			SetNull(ldt_cash_date)
//		End If
//	Else //Error
//		SetNull(ldt_cash_date)
//		SetNull(ldt_cm_date)
//	End If
//Else //Error: ls_cash_date_julian5 is not number
//	SetNull(ldt_cash_date)
//	SetNull(ldt_cm_date)
//End If
//
//If IsNumber(ls_net_coil_length_dm) Then
//	ll_net_coil_length_inches = Long(ls_net_coil_length_dm) * 3.93701 //Convert decimeters into inches
//Else //Error: ls_net_coil_length_dm is not number
//	SetNull(ll_net_coil_length_inches)
//End If
//
//If IsNumber(ls_coil_width_mm) Then
//	ldc_coil_width_inches = long(ls_coil_width_mm) / 25.4 //Convert millimeters into inches
//Else //Error: ls_coil_width_mm is not number
//	SetNull(ldc_coil_width_inches)
//End If
//
//If IsNumber(ls_coil_weight_kg) Then
//	ll_coil_weight_lbs = Long(ls_coil_weight_kg) * 2.20462 //Convert kilograms into pounds
//Else //Error: ls_coil_weight_kg is not number
//	SetNull(ll_coil_weight_lbs)
//End If
//
//If IsNumber(ls_material_thikness_mm) Then
//	ldc_material_thickness_inches = Dec(ls_material_thikness_mm) / 25.4 //Convert millimeters into inches
//Else //Error: ls_material_thikness_mm is not number
//	SetNull(ldc_material_thickness_inches)
//End If
//
//If IsNumber(ls_gross_coil_length_dm) Then
//	ll_gross_coil_length_inches = Long(ls_gross_coil_length_dm) * 3.93701 //Convert decimeters into inches
//Else //Error: ls_gross_coil_length_dm is not number
//	SetNull(ll_gross_coil_length_inches)
//End If
//
//If IsNumber(ls_cash_line_id) Then
//	li_cash_line_id = Integer(ls_cash_line_id)
//Else //Error: ls_cash_line_id is not number
//	SetNull(li_cash_line_id)
//End If
//
//ll_inserted_row = dw_coil_quality.InsertRow(0)
//
//If ll_inserted_row > 0 Then
//	dw_coil_quality.Object.coil_abc_num[ll_inserted_row] = al_coil_abc_num
//	dw_coil_quality.Object.coil_org_num[ll_inserted_row] = Trim(ls_coil_org_number)
//	dw_coil_quality.Object.part_num[ll_inserted_row] = ls_part_num
//	dw_coil_quality.Object.material_grade[ll_inserted_row] = ls_material_grade
//	dw_coil_quality.Object.pre_treatment_flag[ll_inserted_row] = ls_pre_treatment_flag
//	dw_coil_quality.Object.cash_date_julian5[ll_inserted_row] = ls_cash_date_julian5
//	dw_coil_quality.Object.cash_date[ll_inserted_row] = ldt_cash_date
//	dw_coil_quality.Object.cm_date[ll_inserted_row] = ldt_cm_date
//	dw_coil_quality.Object.mill_id[ll_inserted_row] = ls_mill_id
//	dw_coil_quality.Object.gross_coil_length[ll_inserted_row] = ll_gross_coil_length_inches
//	dw_coil_quality.Object.gross_coil_length_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.net_coil_length[ll_inserted_row] = ll_net_coil_length_inches
//	dw_coil_quality.Object.net_coil_length_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.coil_width[ll_inserted_row] = ldc_coil_width_inches
//	dw_coil_quality.Object.coil_width_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.coil_weight[ll_inserted_row] = ll_coil_weight_lbs
//	dw_coil_quality.Object.coil_weight_uom[ll_inserted_row] = 'pounds'
//	dw_coil_quality.Object.material_thikness[ll_inserted_row] = ldc_material_thickness_inches
//	dw_coil_quality.Object.material_thikness_uom[ll_inserted_row] = 'inches'
//	dw_coil_quality.Object.cash_line_id[ll_inserted_row] = li_cash_line_id
//	dw_coil_quality.Object.payoff_direction[ll_inserted_row] = ls_payoff_direction
//	dw_coil_quality.Object.sampling_required[ll_inserted_row] = ls_sampling_code
//
//	dw_coil_quality.Object.revision_level[ll_inserted_row] = ls_revision_level
//	dw_coil_quality.Object.pcc_number[ll_inserted_row] = ls_pcc_number
//End If
//
Return li_rtn
////Alex Gerlants. Coil Quality. 02/06/2018.End
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

on w_qr_manual.create
int iCurrent
call super::create
this.cb_clear=create cb_clear
this.cb_go=create cb_go
this.cb_close=create cb_close
this.st_coil_abc_num=create st_coil_abc_num
this.st_coil_org_num=create st_coil_org_num
this.sle_barcode_string=create sle_barcode_string
this.dw_coil_quality_flaw_mapping=create dw_coil_quality_flaw_mapping
this.dw_coil_quality=create dw_coil_quality
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_clear
this.Control[iCurrent+2]=this.cb_go
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.st_coil_abc_num
this.Control[iCurrent+5]=this.st_coil_org_num
this.Control[iCurrent+6]=this.sle_barcode_string
this.Control[iCurrent+7]=this.dw_coil_quality_flaw_mapping
this.Control[iCurrent+8]=this.dw_coil_quality
end on

on w_qr_manual.destroy
call super::destroy
destroy(this.cb_clear)
destroy(this.cb_go)
destroy(this.cb_close)
destroy(this.st_coil_abc_num)
destroy(this.st_coil_org_num)
destroy(this.sle_barcode_string)
destroy(this.dw_coil_quality_flaw_mapping)
destroy(this.dw_coil_quality)
end on

event open;call super::open;str_all_data_types	lstr_all_data_types

dw_coil_quality.Visible = False
dw_coil_quality_flaw_mapping.Visible = False

lstr_all_data_types = Message.PowerObjectParm

is_coil_org_num = lstr_all_data_types.string_var[1]
il_coil_abc_num = lstr_all_data_types.long_var[1]

st_coil_org_num.Text = "Coil Original Number " + is_coil_org_num
st_coil_abc_num.Text = "Coil ABC Number " + String(il_coil_abc_num)
end event

type cb_clear from commandbutton within w_qr_manual
integer x = 1108
integer y = 416
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear"
end type

event clicked;sle_barcode_string.Text = ""
sle_barcode_string.SetFocus()
end event

type cb_go from commandbutton within w_qr_manual
integer x = 453
integer y = 416
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "QR Manual"
end type

event clicked;//Alex Gerlants. Coil Quality. Begin
String	ls_barcode_string
Integer	li_rtn

Integer	li_ff_count, li_answer //Alex Gerlants. Coil Quality

select	count(*)
into		:li_ff_count
from		dbo.coil_quality
where		coil_abc_num = :il_coil_abc_num
using		sqlca;

If sqlca.sqlcode = 0 Then
	ls_barcode_string = sle_barcode_string.Text
	
	If li_ff_count <= 0 Then
		
		li_rtn = wf_coil_quality_manual_add(ls_barcode_string, is_coil_org_num, il_coil_abc_num)
			
		If li_rtn = 1 Then //OK in wf_coil_quality_manual_add()
			MessageBox("Success", "QR barcode for Originl Coil " + is_coil_org_num + " and ABC Coil " + String(il_coil_abc_num) + " successfully processed", Information!)
		End If
	Else //QR barcode for this coil has already been processed
		li_answer = MessageBox("Are you sure?",	&
				"QR barcode for this ABC coil " + String(il_coil_abc_num) + " has already been processed" + &
				"~n~rWould you like to replace data?", Question!, YesNo!, 2)
		
		If li_answer = 1 Then //Yes
			
			li_rtn = wf_coil_quality_manual_add(ls_barcode_string, is_coil_org_num, il_coil_abc_num)
			
			If li_rtn = 1 Then //OK in wf_coil_quality_manual_add()
				MessageBox("Success", "QR barcode for Originl Coil " + is_coil_org_num + " and ABC Coil " + String(il_coil_abc_num) + " successfully processed", Information!)
			Else //Error in wf_coil_quality(). Error message is also there.
				//Don't clear the QR Code fields. Let user to see, and re-enter.
			End If
		Else
			MessageBox("Cancelled", "Cancelled by user")
		End If
	End If
End If
//Alex Gerlants. Coil Quality. End
end event

type cb_close from commandbutton within w_qr_manual
integer x = 1701
integer y = 416
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

type st_coil_abc_num from statictext within w_qr_manual
integer x = 282
integer width = 1938
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_coil_org_num from statictext within w_qr_manual
integer x = 282
integer y = 74
integer width = 1938
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_barcode_string from singlelineedit within w_qr_manual
integer x = 59
integer y = 307
integer width = 2359
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "IBeam!"
long textcolor = 33554432
long backcolor = 12639424
borderstyle borderstyle = stylelowered!
end type

type dw_coil_quality_flaw_mapping from datawindow within w_qr_manual
integer x = 69
integer y = 218
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

type dw_coil_quality from datawindow within w_qr_manual
integer x = 289
integer y = 224
integer width = 161
integer height = 64
integer taborder = 10
string title = "none"
string dataobject = "d_coil_quality"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;is_sqlerrtext = sqlerrtext
Return 1 //Do not display error message. I am displaying an error message in my code 
end event

