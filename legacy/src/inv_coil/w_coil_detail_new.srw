$PBExportHeader$w_coil_detail_new.srw
$PBExportComments$<Child> list new coil detail used in the w_inv_coil, just like w_coil_detail
forward
global type w_coil_detail_new from w_child
end type
type dw_coil_detail from u_dw within w_coil_detail_new
end type
type cb_coil_cancel from u_cb within w_coil_detail_new
end type
type cb_ok from u_cb within w_coil_detail_new
end type
end forward

global type w_coil_detail_new from w_child
string tag = "detail information of an new coil"
integer x = 878
integer y = 486
integer width = 1854
integer height = 1142
string title = " New Coil Information"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_coil_detail dw_coil_detail
cb_coil_cancel cb_coil_cancel
cb_ok cb_ok
end type
global w_coil_detail_new w_coil_detail_new

type variables
Boolean	ib_cash_date_required //Alex Gerlants. novelis testing
Long		il_customer_id //Alex Gerlants. novelis testing
end variables

forward prototypes
public function integer wf_validate_cash_date_2 ()
public function string wf_format_cash_date (string as_cash_date)
end prototypes

public function integer wf_validate_cash_date_2 ();//Alex Gerlants. novelis testing. Begin
/*
Function:	wf_validate_cash_date_2
Returns:		integer	 1 if ok to save
							-1 if not ok to save
Arguments:	none
*/
Boolean	lb_all_cash_dates_ok = True, lb_valid_temp
String	ll_find_string, ls_cash_date, ls_current_date, ls_month, ls_day, ls_year
String	ls_coil_org_num, ls_invalid_cash_date_string, ls_find_string, ls_alloy, ls_heat_treated, ls_null
String	ls_customer_short_name, ls_missing_cash_date_string
Integer	li_rtn = 1, li_month, li_day, li_year, li_current_year, li_answer
Long		ll_rows, ll_row, ll_found_row, ll_customer_id

ls_current_date = String(Today())
li_current_year = Integer(Right(ls_current_date, 4))
SetNull(ls_null)

ll_rows = dw_coil_detail.RowCount()

For ll_row = 1 To ll_rows
	ls_coil_org_num = dw_coil_detail.Object.coil_org_num[ll_row]
	ls_cash_date = Trim(dw_coil_detail.Object.cash_date[ll_row])
	If IsNull(ls_cash_date) Then ls_cash_date = ""
	//lb_all_cash_dates_ok = True
	
	If ls_cash_date <> "" Then
		ls_month = Left(ls_cash_date, 2)
		ls_day = Mid(ls_cash_date, 3, 2)
		ls_year = Right(ls_cash_date, 4)
		
		If IsNumber(ls_month) Then
			li_month = Integer(ls_month)
		Else
			li_month = 0
		End If
		
		If IsNumber(ls_day) Then
			li_day = Integer(ls_day)
		Else
			li_day = 0
		End If
		
		If IsNumber(ls_year) Then
			li_year = Integer(ls_year)
		Else
			li_year = 0
		End If
		
		lb_valid_temp = True
		
		If li_month < 1 Or li_month > 12 Then
			lb_valid_temp = False
		End If
		
		If li_day < 1 Or li_day > 31 Then
			lb_valid_temp = False
		End If
		
		If li_year < li_current_year - 2 Or li_year > li_current_year Then
			lb_valid_temp = False
		End If
		
		If Not lb_valid_temp Then
			//lb_all_cash_dates_ok = False
			ls_invalid_cash_date_string = ls_invalid_cash_date_string + ls_coil_org_num + ", "
		End If
	Else //Cash date missing
		If ib_cash_date_required Then
			ls_missing_cash_date_string = ls_missing_cash_date_string + ls_coil_org_num + ", "
		End If
	End If
Next

If ls_invalid_cash_date_string <> "" Or ls_missing_cash_date_string <> "" Then
	//ll_customer_id = dw_general_customer.Object.customer_id[1]
	//ls_find_string = "customer_id = " + String(ll_customer_id)
	//ll_found_row = dw_customer.Find(ls_find_string, 1, dw_customer.RowCount())
	//
	//If ll_found_row > 0 Then
	//	ls_customer_short_name = dw_customer.Object.customer_short_name[ll_found_row]
	//Else
	//	ls_customer_short_name = ""
	//End If
	
	//ll_customer_id = dw_general_customer.Object.customer_id[1]
	ls_customer_short_name = f_get_customer_name(il_customer_id, sqlca)

	If ls_invalid_cash_date_string <> "" Then
		//Remove the last comma
		ls_invalid_cash_date_string = Left(ls_invalid_cash_date_string, Len(ls_invalid_cash_date_string) - 2)
		ls_invalid_cash_date_string = "Coil Org Num: " + ls_invalid_cash_date_string
	End If
	
	If ls_missing_cash_date_string <> "" Then
		//Remove the last comma
		ls_missing_cash_date_string = Left(ls_missing_cash_date_string, Len(ls_missing_cash_date_string) - 2)
		ls_missing_cash_date_string = "Coil Org Num: " + ls_missing_cash_date_string
	End If
	
	If ls_invalid_cash_date_string <> "" And ls_missing_cash_date_string <> "" Then
		li_rtn = -1
		
		If ib_cash_date_required Then //Cash date required
			//I don't populate ls_missing_cash_date_string if cash date not required.
			//Thus, it is always for customer that requires cash date: ls_invalid_cash_date_string <> "" And ls_missing_cash_date_string <> "" 
			MessageBox("Data input error/warning", "Cash Date required for " + ls_customer_short_name + &
					"~n~rHowever..." + &
					"~n~r~n~rError:~n~rCash date invalid for the following coils. Please correct~n~r" + ls_invalid_cash_date_string + &
					"~n~r~n~rWarning:~n~rCash date missing for the following coils. " + &
					"~n~rOK to save after invalid cash dates for the coils above corrected~n~r" + ls_missing_cash_date_string, &
					StopSign!)
		Else //Cash date not required
			//If user entered cash date, and it is invalid; it has to be corrected
			MessageBox("Data input error", "Error: Cash date invalid for the following coils. Please correct~n~r" + ls_invalid_cash_date_string + &
					"~n~rPlease correct.", StopSign!)
		End If
	ElseIf ls_invalid_cash_date_string <> "" Then
		li_rtn = -1
		
		MessageBox("Data input error", "Error: Cash date invalid for the following coils. Please correct~n~r" + ls_invalid_cash_date_string + &
				"~n~rPlease correct.", StopSign!)
	Else //ls_missing_cash_date_string <> ""
		If ib_cash_date_required Then //Cash date required
			li_answer = MessageBox("Data input warning", "Cash Date required for " + ls_customer_short_name + &
					"~n~rHowever," + &
					"~n~rCash date missing for the following coils.~n~r" + ls_missing_cash_date_string + &
					"~n~r~n~rAre you sure you want to save?", &
					Question!, YesNo!, 2)
					
			If li_answer = 2 Then //User is not OK with missing cash date, and wants to correct
				li_rtn = -1
			End If
		Else //If cash date not reuired for the customer, this is not an error.
			//li_rtn = 1 at this point...OK to save
		End If
	End If
End If

//If Not lb_all_cash_dates_ok Then
//	If ib_cash_date_required Then
//		ll_customer_id = dw_general_customer.Object.customer_id[1]
//		ls_find_string = "customer_id = " + String(ll_customer_id)
//		ll_found_row = dw_customer.Find(ls_find_string, 1, dw_customer.RowCount())
//		
//		If ll_found_row > 0 Then
//			ls_customer_short_name = dw_customer.Object.customer_short_name[ll_found_row]
//			
//			li_answer = MessageBox("Data input warning", "Cash Date required for customer " + ls_customer_short_name + &
//							"However, cash date invalid for the following coils. Please correct~n~r" + ls_invalid_cash_date_string, &
//							Information!, OKCancel!, 2)
//		Else
//			ls_customer_short_name = ""
//			
//			li_answer = MessageBox("Data input warning", "Cash Date required for this customer " + &
//							"However," + &
//							"~n~rCash date invalid for the following coils. Please correct~n~r" + ls_invalid_cash_date_string + &
//							"~n~rCash date missing for the following coils. Please correct~n~r" + ls_missing_cash_date_string, &
//							Information!, OKCancel!, 2)
//		End If
//		
//	End If
//End If

Return li_rtn
//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. End
end function

public function string wf_format_cash_date (string as_cash_date);//Alex Gerlants. novelis testing
/*
Function:	wf_format_cash_date
Returns:		string <== Formatted cash_date
Arguments:	value	string	as_cash_date <== Unformatted cash_date
*/

If IsNull(as_cash_date) Then as_cash_date = ""

If as_cash_date <> "" Then //Cash date populated
	//Insert "/" only if cash date entered by the user
	as_cash_date = Left(as_cash_date, 2) + "/" + Mid(as_cash_date, 3, 2) + "/" + Right(as_cash_date, 4)
Else //Cash date not populated
	SetNull(as_cash_date)
End If

Return as_cash_date
//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. End
end function

on w_coil_detail_new.create
int iCurrent
call super::create
this.dw_coil_detail=create dw_coil_detail
this.cb_coil_cancel=create cb_coil_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_detail
this.Control[iCurrent+2]=this.cb_coil_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_coil_detail_new.destroy
call super::destroy
destroy(this.dw_coil_detail)
destroy(this.cb_coil_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;s_coil_info lds_data
Long ll_row

DataWindowChild	ldwc //Alex Gerlants. novelis testing
Integer				li_rtn, li_rows, li_coil_status //Alex Gerlants. novelis testing

dw_coil_detail.SetTransObject(sqlca)

lds_data = message.PowerObjectParm
this.title = "New coil"
ll_row = dw_coil_detail.InsertRow(0)

dw_coil_detail.SetItem(ll_row, "customer_id",lds_data.customer_id)
dw_coil_detail.SetItem(ll_row, "coil_abc_num",lds_data.ab_coil_num)
dw_coil_detail.SetItem(ll_row, "coil_status",lds_data.status )
dw_coil_detail.SetItem(ll_row, "coil_from_cust_id", lds_data.customer_id)
dw_coil_detail.SetItem(ll_row, "date_received", Today())

dw_coil_detail.ResetUpdate()

//Alex Gerlants. novelis testing. Begin
li_rtn = dw_coil_detail.GetChild("coil_status", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	li_rows = ldwc.Retrieve() //Table: coil_status_desc
	
	If li_rows > 0 Then
		dw_coil_detail.Object.coil_status[1] = 2 //New
	End If
End If

f_get_cash_date_required(lds_data.customer_id, sqlca, ib_cash_date_required)
il_customer_id = lds_data.customer_id //Alex Gerlants. novelis testing
//Alex Gerlants. novelis testing. End

dw_coil_detail.SetFocus()
end event

type dw_coil_detail from u_dw within w_coil_detail_new
string tag = "Detail information of an  new coil"
integer x = 40
integer y = 22
integer width = 1755
integer height = 906
integer taborder = 20
string dataobject = "d_coil_detail_new"
boolean vscrollbar = false
boolean livescroll = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event itemchanged;call super::itemchanged;this.ResetUpdate()
end event

type cb_coil_cancel from u_cb within w_coil_detail_new
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 1123
integer y = 954
integer width = 351
integer height = 93
integer taborder = 10
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;s_coil_info lds_data
long ll_row

ll_row = dw_coil_detail.GetRow()
IF ll_row < 1 THEN RETURN
lds_data.customer_id = -1

dw_coil_detail.Reset()
CloseWithReturn(parent, lds_data)
end event

type cb_ok from u_cb within w_coil_detail_new
string tag = "Close this window and pass the information"
integer x = 366
integer y = 954
integer width = 351
integer height = 93
integer taborder = 11
string facename = "Arial"
string text = "&OK"
end type

event clicked;s_coil_info lds_data
long ll_row

Integer	li_rtn //Alex Gerlants. novelis testing
String	ls_cash_date //Alex Gerlants. novelis testing
Long		ll_coil_abc_num //Alex Gerlants. novelis testing

dw_coil_detail.AcceptText()
dw_coil_detail.ResetUpdate()

ll_row = dw_coil_detail.GetRow()
IF ll_row < 1 THEN RETURN
lds_data.customer_id = dw_coil_detail.GetItemNumber(ll_row, "customer_id",Primary!, FALSE)
lds_data.ab_coil_num = dw_coil_detail.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = dw_coil_detail.GetItemString(ll_row, "coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = dw_coil_detail.GetItemString(ll_row, "coil_mid_num", Primary!, FALSE)
lds_data.lot_num = dw_coil_detail.GetItemString(ll_row, "lot_num",Primary!, FALSE)
lds_data.pieces = dw_coil_detail.GetItemNumber(ll_row, "pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = dw_coil_detail.GetItemNumber(ll_row, "coil_line_num", Primary!, FALSE)
lds_data.icra = dw_coil_detail.GetItemString(ll_row, "icra", Primary!, FALSE)
lds_data.alloy = dw_coil_detail.GetItemString(ll_row, "coil_alloy2",Primary!, FALSE)
lds_data.gauge = dw_coil_detail.GetItemNumber(ll_row, "coil_gauge", Primary!, FALSE)
lds_data.Temper = dw_coil_detail.GetItemString(ll_row, "coil_temper", Primary!, FALSE)
lds_data.net_wt = dw_coil_detail.GetItemNumber(ll_row, "net_wt", Primary!, FALSE)
lds_data.net_balance = dw_coil_detail.GetItemNumber(ll_row, "net_wt_balance", Primary!, FALSE)
lds_data.width = dw_coil_detail.GetItemNumber(ll_row, "coil_width", Primary!, FALSE)
lds_data.date_received = dw_coil_detail.GetItemDateTime(ll_row, "date_received", Primary!, FALSE)
lds_data.location = dw_coil_detail.GetItemString(ll_row, "coil_location", Primary!, FALSE)
lds_data.status = dw_coil_detail.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)
lds_data.notes = dw_coil_detail.GetItemString(ll_row, "coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = dw_coil_detail.GetItemNumber(ll_row, "coil_from_cust_id", Primary!, FALSE)
lds_data.abco_coil_net_wt = dw_coil_detail.GetItemNumber(ll_row, "abco_coil_net_wt", Primary!, FALSE)
lds_data.consumed_coil_num = dw_coil_detail.GetItemString(ll_row, "consumed_coil_num", Primary!, FALSE)
lds_data.material_num = dw_coil_detail.GetItemString(ll_row, "material_num", Primary!, FALSE)
lds_data.cash_date = dw_coil_detail.GetItemString(ll_row, "cash_date", Primary!, FALSE)

IF IsNULL(lds_data.net_wt) THEN
	MessageBox("Error", "Invalid coil net weight.", StopSign!)
	RETURN -1
END IF
IF IsNULL(lds_data.net_balance) THEN
	MessageBox("Error", "Invalid coil current weight.", StopSign!)
	RETURN -2
END IF
IF IsNULL(lds_data.width) THEN
	MessageBox("Error", "Invalid coil coil width.", StopSign!)
	RETURN -3
END IF
IF (lds_data.net_balance / lds_data.width <= 100.0) AND (lds_data.gauge >= 0.1) THEN
	MessageBox("Warning", "Heavy gauge, small OD coil!")
	RETURN -4 //Alex Gerlants. novelis testing. This was missing
END IF

//Alex Gerlants. novelis testing. Begin
ll_coil_abc_num = lds_data.ab_coil_num
ls_cash_date = lds_data.cash_date
If IsNull(ls_cash_date) Then ls_cash_date = ""

li_rtn = f_validate_cash_date(il_customer_id, ll_coil_abc_num, ls_cash_date, ib_cash_date_required)

If  li_rtn = 1 Then //OK
	ls_cash_date = wf_format_cash_date(ls_cash_date)
	lds_data.cash_date = ls_cash_date
Else //Problem in f_validate_cash_date(). Error message is in f_validate_cash_date()
	dw_coil_detail.SetFocus()
	dw_coil_detail.SetRow(1)
	dw_coil_detail.SetColumn("cash_date")
	Return
End If
//Alex Gerlants. novelis testing. End

dw_coil_detail.Reset()
CloseWithReturn(parent, lds_data)
end event

