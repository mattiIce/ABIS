$PBExportHeader$w_add_defect.srw
forward
global type w_add_defect from w_sheet
end type
type cb_delete from commandbutton within w_add_defect
end type
type st_1 from statictext within w_add_defect
end type
type cb_add_defect from commandbutton within w_add_defect
end type
type dw_add_defect_save from datawindow within w_add_defect
end type
type cb_save from commandbutton within w_add_defect
end type
type cb_cancel from commandbutton within w_add_defect
end type
type cb_close from commandbutton within w_add_defect
end type
type dw_add_defect from u_dw within w_add_defect
end type
type st_customer from statictext within w_add_defect
end type
type st_ab_job_num from statictext within w_add_defect
end type
type st_coil_org_num from statictext within w_add_defect
end type
type st_sheet_skid_num from statictext within w_add_defect
end type
end forward

global type w_add_defect from w_sheet
integer width = 3807
integer height = 1456
string title = "Add Defect"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean clientedge = true
cb_delete cb_delete
st_1 st_1
cb_add_defect cb_add_defect
dw_add_defect_save dw_add_defect_save
cb_save cb_save
cb_cancel cb_cancel
cb_close cb_close
dw_add_defect dw_add_defect
st_customer st_customer
st_ab_job_num st_ab_job_num
st_coil_org_num st_coil_org_num
st_sheet_skid_num st_sheet_skid_num
end type
global w_add_defect w_add_defect

type variables
Long		il_customer_id, il_ab_job_num, il_coil_abc_num, il_sheet_skid_num[]
Integer	ii_rtn
String	is_sql_orig, is_user_id
end variables

forward prototypes
public function integer wf_save_qa_customer_quality_many_skids (long al_customer_id, long al_ab_job_num, long al_coil_abc_num, long al_skids[], str_all_data_types astr_all_data_types[])
public subroutine wf_insert_qa_customer_quality_skid ()
public function long wf_check_if_exists (long al_sheet_skid_num, integer ai_defect_code)
public function integer wf_validate_before_save ()
end prototypes

public function integer wf_save_qa_customer_quality_many_skids (long al_customer_id, long al_ab_job_num, long al_coil_abc_num, long al_skids[], str_all_data_types astr_all_data_types[]);//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_save_qa_customer_quality_many_skids
Returns:		integer
Arguments:	value	long						al_customer_id
				value	long						al_ab_job_num
				value	long						al_coil_abc_num
				value	long						al_skids[]		         <== sheet_skid_num to save information for
				value	str_all_data_types	astr_all_data_types[]	<== One or more defects to save for each skid in al_sheet_skid_num[]
*/

Long						ll_customer_id, ll_sheet_skid_num, ll_rows
Integer					li_defect_code, li_albl_disp_code, li_cust_disp_code, li_number_of_skids, li_i
Integer					li_row_inserted, li_rtn = 1, li_j, li_number_of_defects
DateTime					ldt_qa_record_date
String					ls_note, ls_user_id, ls_skid_string
DataStore				lds_qa_customer_quality_skid

lds_qa_customer_quality_skid = Create DataStore
lds_qa_customer_quality_skid.DataObject = "d_qa_customer_quality_skid_2"
lds_qa_customer_quality_skid.SetTransObject(sqlca)

ldt_qa_record_date = DateTime(Today(), Now())
li_number_of_skids = UpperBound(al_skids[])

For li_i = 1 To li_number_of_skids
	ll_sheet_skid_num = al_skids[][li_i]
	ls_skid_string = ls_skid_string + String(ll_sheet_skid_num) + ", "
	li_number_of_defects = UpperBound(astr_all_data_types[])
	
	For li_j = 1 To li_number_of_defects
		li_defect_code = astr_all_data_types[li_j].integer_var[1]
		li_albl_disp_code = astr_all_data_types[li_j].integer_var[2]
		li_cust_disp_code = astr_all_data_types[li_j].integer_var[3]
		ls_note = astr_all_data_types[li_j].string_var[1]
		ls_user_id = astr_all_data_types[li_j].string_var[2]
		
		ll_rows = lds_qa_customer_quality_skid.Retrieve(al_customer_id, al_coil_abc_num, ll_sheet_skid_num, li_defect_code)
		
		li_rtn = 1 //Initialize before Case
		
		Choose Case ll_rows
			Case 0 //Row does not exist
				li_row_inserted = lds_qa_customer_quality_skid.InsertRow(0)
				
				If li_row_inserted > 0 Then
					lds_qa_customer_quality_skid.Object.customer_id[li_row_inserted] = al_customer_id
					lds_qa_customer_quality_skid.Object.ab_job_num[li_row_inserted] = al_ab_job_num
					lds_qa_customer_quality_skid.Object.coil_abc_num[li_row_inserted] = al_coil_abc_num
					lds_qa_customer_quality_skid.Object.sheet_skid_num[li_row_inserted] = ll_sheet_skid_num
					lds_qa_customer_quality_skid.Object.defect_code[li_row_inserted] = li_defect_code
					lds_qa_customer_quality_skid.Object.albl_disp_code[li_row_inserted] = li_albl_disp_code
					lds_qa_customer_quality_skid.Object.cust_disp_code[li_row_inserted] = li_cust_disp_code
					lds_qa_customer_quality_skid.Object.qa_record_date[li_row_inserted] = ldt_qa_record_date
					lds_qa_customer_quality_skid.Object.note[li_row_inserted] = ls_note
					lds_qa_customer_quality_skid.Object.user_id[li_row_inserted] = ls_user_id
				End If
			Case 1 //Row exists for key columns ll_customer_id, ll_sheet_skid_num, li_defect_code
				lds_qa_customer_quality_skid.Object.albl_disp_code[1] = li_albl_disp_code
				lds_qa_customer_quality_skid.Object.cust_disp_code[1] = li_cust_disp_code
				lds_qa_customer_quality_skid.Object.qa_record_date[1] = ldt_qa_record_date
				lds_qa_customer_quality_skid.Object.note[1] = ls_note
				lds_qa_customer_quality_skid.Object.user_id[1] = ls_user_id
			Case Else //DB error
				li_rtn = -1
		End Choose
		
		If li_rtn = 1 Then //OK
			li_rtn = lds_qa_customer_quality_skid.Update()
					
			//If li_rtn = 1 Then //OK
			//	commit using sqlca;
			//Else
			//	rollback using sqlca;
			//End If
		End If
	Next
Next //For li_i = 1 To li_number_of_skids

//Remove the last comma
ls_skid_string = Left(ls_skid_string, Len(ls_skid_string) - 2)

If li_rtn = 1 Then //OK
	commit using sqlca;
	MessageBox("Success", "QA update successful for skids " + ls_skid_string)
Else	//Error
	rollback using sqlca;
	MessageBox("Failure", "QA update failed for skids " + ls_skid_string)
End If

Return li_rtn
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end function

public subroutine wf_insert_qa_customer_quality_skid ();//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
/*
Function:	wf_insert_qa_customer_quality_skid
Returns:		none
Arguments:	none
*/

DataWindowChild 	ldwc
Integer				li_row_inserted, li_rtn, li_rows, li_defect_code, li_null, li_disp_code
Long					ll_row_inserted, ll_rows, ll_null
String				ls_filter_string, ls_null, ls_disp_code, ls_defect_desc

li_row_inserted = dw_add_defect.InsertRow(0)

SetNull(li_null)
SetNull(ll_null)
SetNull(ls_null)

If li_row_inserted > 0 Then
	li_rtn = dw_add_defect.GetChild("defect_code", ldwc)

	If li_rtn = 1 Then
		ldwc.SetTransObject(sqlca)
		ll_rows = ldwc.Retrieve()
		
		If ll_rows > 0 Then
			////Filter cust_disp_code for il_customer_id
			//ls_filter_string = "customer_id = " + String(il_customer_id)
			//li_rtn = ldwc.SetFilter(ls_filter_string)
			//li_rtn = ldwc.Filter()
			//ll_rows = ldwc.RowCount() //Recount after Filter
			//
			//If ll_rows > 0 Then
			
			//li_defect_code = ldwc.GetItemNumber(1, "defect_code")
			
			//If Not IsNull(li_defect_code) Then
				//ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
				
				//If ll_row_inserted > 0 Then
				//	ldwc.SetItem(ll_row_inserted, "defect_code", ll_null)
				//	ldwc.SetItem(ll_row_inserted, "defect_desc", ll_null)
				//End If
			//End If
			//End If
		End If
	End If
	
	//---
	
	li_rtn = dw_add_defect.GetChild("cust_disp_code", ldwc)

	If li_rtn = 1 Then
		ldwc.SetTransObject(sqlca)
		ll_rows = ldwc.Retrieve()
		
		If ll_rows > 0 Then
			//Filter cust_disp_code for il_customer_id
			ls_filter_string = "customer_id = " + String(il_customer_id)
			li_rtn = ldwc.SetFilter(ls_filter_string)
			li_rtn = ldwc.Filter()
			ll_rows = ldwc.RowCount() //Recount after Filter
			
			If ll_rows > 0 Then
			
				li_disp_code = ldwc.GetItemNumber(1, "disp_code")
				
				If Not IsNull(li_disp_code) Then
					ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
					
					If ll_row_inserted > 0 Then
						ldwc.SetItem(ll_row_inserted, "customer_id", ll_null)
						ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
						ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
					End If
				End If
			End If
		End If
	End If
	
	li_rtn = dw_add_defect.GetChild("albl_disp_code", ldwc)

	If li_rtn = 1 Then
		ldwc.SetTransObject(sqlca)
		ll_rows = ldwc.Retrieve()
		
		If ll_rows > 0 Then
			ls_disp_code = ldwc.GetItemString(1, "disp_code")
			
			If Not IsNull(li_disp_code) Then
				ll_row_inserted = ldwc.InsertRow(1) //Insert before first row
				
				If ll_row_inserted > 0 Then
					ldwc.SetItem(ll_row_inserted, "disp_code", li_null)
					ldwc.SetItem(ll_row_inserted, "disp_desc", ls_null)
				End If
			End If
		End If
	End If
	
	//---
	
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end subroutine

public function long wf_check_if_exists (long al_sheet_skid_num, integer ai_defect_code);/*
Function:	wf_check_if_exists
				Check if the newly entered defects in dw_add_defect already exist in table qa_customer_quality_skid for customer_id, ab_job_num, coil_abc_num, sheet_skid_num, defect_code
Returns 		long	<== row number in dw_add_defect_save if found
							 0 if not found
*/

Boolean	lb_exists = False
Integer	li_i, li_count, li_defect_code
Long		ll_rows, ll_row, ll_sheet_skid_num, ll_found_row = 0
String	ls_qa_defect_desc, ls_error_string, ls_find_string

dw_add_defect.AcceptText()
ll_rows = dw_add_defect.RowCount()

//For ll_row = 1 To ll_rows
	//li_defect_code = dw_add_defect.Object.defect_code[ll_row]
	//ll_sheet_skid_num = il_sheet_skid_num[1] //Take first skid. All defects are the same for all akids in il_sheet_skid_num[]

	ls_find_string = 	"customer_id = " + String(il_customer_id) + &
							" and ab_job_num = "+ String(il_ab_job_num) + &
							" and coil_abc_num = " + String(il_coil_abc_num) + &
							" and sheet_skid_num = " + String(al_sheet_skid_num) + &
							" and defect_code = " + String(ai_defect_code)
							
	ll_found_row = dw_add_defect_save.Find(ls_find_string, 1, dw_add_defect_save.RowCount())
	
	//If ll_found_row > 0 Then
	//	lb_exists =  True
	//End If
//Next

//If lb_exists Then
//	MessageBox("Defects exist", "The following defects exist. Please correct.~n~r" + ls_error_string, StopSign!)
//End If

Return ll_found_row
end function

public function integer wf_validate_before_save ();/*
Function:	wf_validate_before_save
Returns:		integer	 1 if OK
							-1 if not OK
Arguments:	none
*/

Integer	li_rtn = 1, li_defect_code, li_rows, li_row

li_rows = dw_add_defect.RowCount()

For li_row = 1 To li_rows
	li_defect_code = dw_add_defect.Object.defect_code[li_row]
	
	If IsNull(li_defect_code) Then
		li_rtn = -1
		//ai_error_row = li_row
		MessageBox("Data entry not complete", "Please enter defect code on line " + String(li_row) + " before saving")
		Exit //There can only one row with defect_code = Null because I am checking for missing defect_code in Clicked event for cb_add_defect
	End If
Next

Return li_rtn
end function

on w_add_defect.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.st_1=create st_1
this.cb_add_defect=create cb_add_defect
this.dw_add_defect_save=create dw_add_defect_save
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
this.cb_close=create cb_close
this.dw_add_defect=create dw_add_defect
this.st_customer=create st_customer
this.st_ab_job_num=create st_ab_job_num
this.st_coil_org_num=create st_coil_org_num
this.st_sheet_skid_num=create st_sheet_skid_num
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_add_defect
this.Control[iCurrent+4]=this.dw_add_defect_save
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.dw_add_defect
this.Control[iCurrent+9]=this.st_customer
this.Control[iCurrent+10]=this.st_ab_job_num
this.Control[iCurrent+11]=this.st_coil_org_num
this.Control[iCurrent+12]=this.st_sheet_skid_num
end on

on w_add_defect.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.st_1)
destroy(this.cb_add_defect)
destroy(this.dw_add_defect_save)
destroy(this.cb_save)
destroy(this.cb_cancel)
destroy(this.cb_close)
destroy(this.dw_add_defect)
destroy(this.st_customer)
destroy(this.st_ab_job_num)
destroy(this.st_coil_org_num)
destroy(this.st_sheet_skid_num)
end on

event open;call super::open;DataStore	lds_add_defect
Long			ll_rows, ll_row, ll_customer_id, ll_ab_job_num, ll_coil_abc_num, ll_sheet_skid_num
String		ls_sql_orig, ls_sql_add, ls_sql_new, ls_customer_short_name, la_coil_org_num, ls_skid_string

dw_add_defect.SetTransObject(sqlca)
is_sql_orig = dw_add_defect.GetSqlSelect()
dw_add_defect_save.Visible = False
cb_cancel.Visible = False
ii_rtn = 1
ls_sql_orig = dw_add_defect_save.GetSqlSelect()

lds_add_defect = Message.PowerObjectParm
ll_rows = lds_add_defect.RowCount()

If ll_rows > 0 Then
	il_customer_id = lds_add_defect.Object.customer_id[1]
	
	select	customer_short_name
	into		:ls_customer_short_name
	from		customer
	where		customer_id = :il_customer_id
	using		sqlca;
	
	st_customer.Text = "Customer: " + ls_customer_short_name
	
	il_ab_job_num = lds_add_defect.Object.ab_job_num[1]
	
	st_ab_job_num.Text = "Job: " + String(il_ab_job_num)
	
	il_coil_abc_num = lds_add_defect.Object.coil_abc_num[1]
	
	select	coil_org_num
	into		:la_coil_org_num
	from		coil
	where		coil_abc_num = :il_coil_abc_num
	using		sqlca;
	
	st_coil_org_num.Text = "Customer Coil: " + la_coil_org_num
	
	ls_sql_add = "~n~rwhere customer_id = " + String(il_customer_id) + "~n~rand ab_job_num = " + String(il_ab_job_num) + "~n~rand coil_abc_num = " + String(il_coil_abc_num)
	
	For ll_row = 1 To ll_rows
		ll_sheet_skid_num = lds_add_defect.Object.sheet_skid_num[ll_row]
		il_sheet_skid_num[UpperBound(il_sheet_skid_num[]) + 1] = ll_sheet_skid_num
		
		ls_skid_string = ls_skid_string + String(ll_sheet_skid_num) + ","
		
		If ll_row = 1 Then
			ls_sql_add = ls_sql_add + "~n~rand (sheet_skid_num = " + String(ll_sheet_skid_num)
		Else
			ls_sql_add = ls_sql_add + "~n~ror sheet_skid_num = " + String(ll_sheet_skid_num)
		End If
	Next
	
	//Remove the last comma
	ls_skid_string = Left(ls_skid_string, Len(ls_skid_string) - 1)
	st_sheet_skid_num.Text = "Skids: " + ls_skid_string
	
	ls_sql_add = ls_sql_add + ")"
	
	ls_sql_new = ls_sql_orig + ls_sql_add
	dw_add_defect_save.SetTransObject(sqlca)
	dw_add_defect_save.SetSqlSelect(ls_sql_new)
	ll_rows = dw_add_defect_save.Retrieve()
	
	wf_insert_qa_customer_quality_skid()
End If



end event

event closequery;Integer li_rtn

// Accept the last data entered into the datawindow
dw_add_defect.AcceptText()

//Check to see if any data has changed
If dw_add_defect.DeletedCount() + dw_add_defect.ModifiedCount() > 0 Then //User made changes
   li_rtn = MessageBox("", "Do you want to save changes?", Exclamation!, YesNoCancel!, 3)

   //User chose to save data and close window
   If li_rtn = 1 Then //Yes
		li_rtn = cb_save.Event Clicked()
		
		If li_rtn = 1 Then //OK
      	Return 0 //Close window
		Else //li_rtn = -1 - Error
			Return 1 //Do not close window
		End If

   //User chose to close window without saving
	ElseIf li_rtn = 2 Then //No
      Return 0

   //User canceled
   Else //Cancel
      Return 1
   End If

Else //User made no changes
   Return 0 //Just close the window
End If











//If dw_add_defect.DeletedCount() + dw_add_defect.ModifiedCount() > 0 Then //User made changes
//   If ancestorreturnvalue = 1 Then //User clicked on "Yes" on ancestor generated "Do you want to save your changes?" message
//		cb_save.Event Clicked()
//      Return 0 //Close the window
//	Else //ancestorreturnvalue = 0. User clicked on "No" on ancestor generated "Do you want to save your changes?" message
//		Return 0 //Close the window
//	End If
//Else //User made no changes
//   // No changes to the data. Close the window
//   Return 0
//End If
end event

type cb_delete from commandbutton within w_add_defect
integer x = 750
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
Long 		ll_selected_row
Integer	li_defect_code, li_found_row
String	ls_find_string

dw_add_defect.AcceptText()
ll_selected_row = dw_add_defect.GetSelectedRow(0)

If ll_selected_row > 0 Then
	li_defect_code = dw_add_defect.Object.defect_code[ll_selected_row]
	ls_find_string = "defect_code = " + String(li_defect_code)
	li_found_row = dw_add_defect_save.Find(ls_find_string, 1, dw_add_defect_save.Rowcount())
	
	If li_found_row > 0 Then
		//Do While li_found_row > 0
			dw_add_defect_save.DeleteRow(li_found_row)
			//li_found_row = dw_add_defect_save.Find(ls_find_string, li_found_row, dw_add_defect_save.Rowcount()) //Start from li_found_row
		//Loop
	End If
	
	dw_add_defect.DeleteRow(ll_selected_row)
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

type st_1 from statictext within w_add_defect
integer x = 22
integer y = 6
integer width = 571
integer height = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "You are adding defects for:"
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_add_defect from commandbutton within w_add_defect
integer x = 194
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add Defect"
end type

event clicked;/*
dw_add_defect.GetChild("defect_code"
dw_add_defect.GetChild("cust_disp_code"
dw_add_defect.GetChild("albl_disp_code"
*/
Integer	li_defect_code, li_albl_disp_code, li_cust_disp_code
Long		ll_rows

SetNull(li_defect_code)

ll_rows = dw_add_defect.RowCount()

If ll_rows > 0 Then
	If ll_rows = 1 Then //First row is inserted in Open event for w_add_defect
		li_defect_code = dw_add_defect.Object.defect_code[1]
		li_albl_disp_code = dw_add_defect.Object.albl_disp_code[1]
		li_cust_disp_code = dw_add_defect.Object.cust_disp_code[1]
	Else
		li_defect_code = dw_add_defect.Object.defect_code[ll_rows]
		li_albl_disp_code = dw_add_defect.Object.albl_disp_code[ll_rows]
		li_cust_disp_code = dw_add_defect.Object.cust_disp_code[ll_rows]
	End If
	
	//If Not (IsNull(li_defect_code) Or IsNull(li_albl_disp_code) Or IsNull(li_cust_disp_code)) Then
	If Not IsNull(li_defect_code) Then
		wf_insert_qa_customer_quality_skid()
	Else
		MessageBox("Data entry not complete", "Please enter Defect before adding another defect.", StopSign!)
	End If
Else //ll_rows = 0
	wf_insert_qa_customer_quality_skid()
End If


	
end event

type dw_add_defect_save from datawindow within w_add_defect
integer x = 3675
integer y = 1210
integer width = 84
integer height = 128
integer taborder = 20
string title = "none"
string dataobject = "d_add_defect"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_save from commandbutton within w_add_defect
integer x = 1306
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;Long						ll_customer_id, ll_coil_abc_num, ll_sheet_skid_num, ll_skids[], ll_rows, ll_row, ll_selected_row
Long						ll_row_inserted, ll_found_row
Integer					li_defect_code, li_albl_disp_code, li_cust_disp_code, li_number_of_skids, li_i, li_rtn = 1
//Integer					li_row_inserted, li_rtn
DateTime					ldt_qa_record_date
String					ls_note, ls_user_id, ls_record_date, ls_find_string
str_all_data_types	lstr_all_data_types[]
Boolean					lb_exists

li_rtn = wf_validate_before_save()

If li_rtn = -1 Then Return -1

dw_add_defect.AcceptText()
//dw_skids_4job.AcceptText()
ls_user_id = gnv_app.of_GetUserId()
ldt_qa_record_date = DateTime(Today(), Now())
ll_rows = dw_add_defect.RowCount()

//If ll_rows > 0 Then
//	//Check if the newly entered defects already exist in table qa_customer_quality_skid for customer_id, ab_job_num, coil_abc_num, sheet_skid_num
//	lb_exists = wf_check_if_exists()
//	//If lb_exists Then Return //If exists, error message is in wf_check_if_exists()
//End If

For li_i = 1 To UpperBound(il_sheet_skid_num[])
	ll_sheet_skid_num = il_sheet_skid_num[li_i]
	
	//Populate all defect data for ll_sheet_skid_num
	For ll_row = 1 To ll_rows
		li_defect_code = dw_add_defect.Object.defect_code[ll_row]
		li_albl_disp_code = dw_add_defect.Object.albl_disp_code[ll_row]
		li_cust_disp_code = dw_add_defect.Object.cust_disp_code[ll_row]
		ls_note = dw_add_defect.Object.note[ll_row]
		
		ll_found_row = wf_check_if_exists(ll_sheet_skid_num, li_defect_code)

		If ll_found_row > 0 Then //Defect exists. Update albl_disp_code, cust_disp_code, qa_record_date, note, user_id
			dw_add_defect_save.Object.albl_disp_code[ll_found_row] = li_albl_disp_code
			dw_add_defect_save.Object.cust_disp_code[ll_found_row] = li_cust_disp_code
			dw_add_defect_save.Object.qa_record_date[ll_found_row] = ldt_qa_record_date
			dw_add_defect_save.Object.note[ll_found_row] = ls_note
			dw_add_defect_save.Object.user_id[ll_found_row] = ls_user_id
		Else //Defect does not ezist. Insert
			ll_row_inserted = dw_add_defect_save.InsertRow(0)
				
			If ll_row_inserted > 0 Then
				dw_add_defect_save.Object.customer_id[ll_row_inserted] = il_customer_id
				dw_add_defect_save.Object.ab_job_num[ll_row_inserted] = il_ab_job_num
				dw_add_defect_save.Object.coil_abc_num[ll_row_inserted] = il_coil_abc_num
				dw_add_defect_save.Object.sheet_skid_num[ll_row_inserted] = ll_sheet_skid_num
				
				dw_add_defect_save.Object.defect_code[ll_row_inserted] = li_defect_code
				dw_add_defect_save.Object.albl_disp_code[ll_row_inserted] = li_albl_disp_code
				dw_add_defect_save.Object.cust_disp_code[ll_row_inserted] = li_cust_disp_code
				dw_add_defect_save.Object.qa_record_date[ll_row_inserted] = ldt_qa_record_date
				dw_add_defect_save.Object.note[ll_row_inserted] = ls_note
				dw_add_defect_save.Object.user_id[ll_row_inserted] = ls_user_id
			End If
		End If
	Next
Next

li_rtn = dw_add_defect_save.Update()

If li_rtn = 1 Then //OK
	commit using sqlca;
	MessageBox("Success", "QA update successful")
Else
	rollback using sqlca;
	MessageBox("Failure", "QA update failed")
End If

ll_rows = dw_add_defect_save.Retrieve()
dw_add_defect_save.ResetUpdate()
dw_add_defect.ResetUpdate()

Return li_rtn

//ii_rtn = wf_save_qa_customer_quality_many_skids(il_customer_id, il_ab_job_num, il_coil_abc_num, il_sheet_skid_num[], lstr_all_data_types[])

 
//dw_add_defect.ResetUpdate()
end event

type cb_cancel from commandbutton within w_add_defect
integer x = 2944
integer y = 1229
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;CloseWithReturn(Parent, -99)
end event

type cb_close from commandbutton within w_add_defect
integer x = 3335
integer y = 1229
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

event clicked;CloseWithReturn(Parent, ii_rtn)
end event

type dw_add_defect from u_dw within w_add_defect
integer x = 33
integer y = 387
integer width = 3675
integer height = 749
integer taborder = 10
string dataobject = "d_add_defect"
end type

event itemerror;call super::itemerror;Return 1 //Reject the data value with no message box
end event

event clicked;call super::clicked;//Alex_Gerlants. 1260_Incoming_Customer_Quality. Begin
If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		//This.SelectRow(0, False)
		This.SelectRow(row, True)
	End If
End If
//Alex_Gerlants. 1260_Incoming_Customer_Quality. End
end event

event itemchanged;call super::itemchanged;//String	ls_column_name, ls_skid_string, ls_sql_orig, ls_sql_add, ls_sql_new
//Long		ll_sheet_skid_num
//Integer	li_defect_code, li_i, li_count, li_rows
//
//ls_column_name = dwo.name
//
//IF ls_column_name = "defect_code" Then
//	If li_rows <= 0 Then
//		cb_add_defect.Event Clicked()
//	End If
//		
//	li_defect_code = Integer(data)
//	
//	For li_i = 1 To UpperBound(il_sheet_skid_num[])
//		ll_sheet_skid_num = il_sheet_skid_num[li_i]
//		ls_skid_string = ls_skid_string + String(ll_sheet_skid_num) + ","
//	Next
//	
//	//Remove the last comma
//	ls_skid_string = Left(ls_skid_string, Len(ls_skid_string) - 1)
//	
//	//select	count(*)
//	//into		:li_count
//	//from		qa_customer_quality_skid
//	//where		customer_id = :il_customer_id
//	//and		ab_job_num = :il_ab_job_num
//	//and		coil_abc_num = :il_coil_abc_num
//	//using		sqlca;
//	
//	//If li_count > 0 Then
//		ls_sql_orig = This.GetSqlSelect()
//		ls_sql_add = "~n~rwhere customer_id = " +	String(il_customer_id) + &
//								" and ab_job_num = " + String(il_ab_job_num) + &
//								" and coil_abc_num = " + String(il_coil_abc_num) + &
//								" and defect_code = " + String(li_defect_code) + &
//								" and sheet_skid_num in (" + ls_skid_string + ")"
//								
//		ls_sql_new = ls_sql_orig + ls_sql_add
//		dw_add_defect.SetSqlSelect(ls_sql_new)
//		dw_add_defect.SetTransObject(sqlca)
//		li_rows = dw_add_defect.Retrieve()
//		
//		//If li_rows <= 0 Then
//		//	cb_add_defect.Event Clicked()
//		//End If
//		
//		//Restore the original SQL
//		dw_add_defect.SetSqlSelect(is_sql_orig)
//	//End If
//End If
end event

type st_customer from statictext within w_add_defect
integer x = 658
integer y = 10
integer width = 2999
integer height = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_ab_job_num from statictext within w_add_defect
integer x = 658
integer y = 90
integer width = 2999
integer height = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_coil_org_num from statictext within w_add_defect
integer x = 658
integer y = 170
integer width = 2999
integer height = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_sheet_skid_num from statictext within w_add_defect
integer x = 658
integer y = 250
integer width = 2999
integer height = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

