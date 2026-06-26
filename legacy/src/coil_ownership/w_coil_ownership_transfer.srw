$PBExportHeader$w_coil_ownership_transfer.srw
$PBExportComments$<Sheet>w_shipping version 2 inherited from pfemain\w_sheet
forward
global type w_coil_ownership_transfer from w_sheet
end type
type dw_coil_ownership_transfer_new from u_dw within w_coil_ownership_transfer
end type
type dw_coil_ownership_transfer_item from u_dw within w_coil_ownership_transfer
end type
type dw_coil_ownership_transfer from datawindow within w_coil_ownership_transfer
end type
type cb_reprint from commandbutton within w_coil_ownership_transfer
end type
type st_height from statictext within w_coil_ownership_transfer
end type
type st_4 from statictext within w_coil_ownership_transfer
end type
type st_3 from statictext within w_coil_ownership_transfer
end type
type st_width from statictext within w_coil_ownership_transfer
end type
type cb_3 from u_cb within w_coil_ownership_transfer
end type
type st_2 from statictext within w_coil_ownership_transfer
end type
type st_1 from statictext within w_coil_ownership_transfer
end type
type cb_barcode from commandbutton within w_coil_ownership_transfer
end type
type cb_2 from u_cb within w_coil_ownership_transfer
end type
type cb_close from commandbutton within w_coil_ownership_transfer
end type
type cb_1 from commandbutton within w_coil_ownership_transfer
end type
type dw_coil_ownership_transfer_detail from datawindow within w_coil_ownership_transfer
end type
end forward

global type w_coil_ownership_transfer from w_sheet
integer x = 214
integer width = 3749
integer height = 2157
string title = "Coil Ownership Transfer"
event type string ue_whoami ( )
event ue_add_coil ( long al_coil_abc_num )
event ue_retrieve_coils_2transfer ( string as_coil_list )
event type string ue_collect_coils ( )
dw_coil_ownership_transfer_new dw_coil_ownership_transfer_new
dw_coil_ownership_transfer_item dw_coil_ownership_transfer_item
dw_coil_ownership_transfer dw_coil_ownership_transfer
cb_reprint cb_reprint
st_height st_height
st_4 st_4
st_3 st_3
st_width st_width
cb_3 cb_3
st_2 st_2
st_1 st_1
cb_barcode cb_barcode
cb_2 cb_2
cb_close cb_close
cb_1 cb_1
dw_coil_ownership_transfer_detail dw_coil_ownership_transfer_detail
end type
global w_coil_ownership_transfer w_coil_ownership_transfer

type variables
String	is_coil_abc_num_list, is_coil_abc_num_new_list, is_sql_curr
Boolean	ib_shift_pressed_item, ib_control_pressed_item
Boolean	ib_shift_pressed_new, ib_control_pressed_new
end variables

forward prototypes
public subroutine wf_retrieve_coils_2transfer (string as_coil_list)
public function integer wf_coil_ownership_transfer ()
public function long wf_populate_new_coil (long al_row, long al_customer_id_previous, long al_coil_abc_num_previous, long al_customer_id_new)
public function long wf_get_next_certificate_num ()
public subroutine wf_insert_coil_ownership_transfer (long al_certificate_num, long al_coil_abc_num_orig, long al_customer_id_orig, long al_customer_id_new, string as_coil_org_num, long al_coil_abc_num_new, datetime adt_transfer_datetime, string as_transfer_performed_by, string as_authorization_note, string as_notes)
end prototypes

event type string ue_whoami();/*
Event:		ue_whoami
Returns:		String
Arguments:	none
*/

Return "w_coil_ownership_transfer"
end event

event ue_add_coil(long al_coil_abc_num);/*
Event:		ue_add_coil
				This event is called from Clicked event for cb_select of w_coil_ownership_transfer_select
Returns:		none
Arguments:	value		long	al_coil_abc_num
*/

is_coil_abc_num_list = is_coil_abc_num_list + String(al_coil_abc_num) + ","
end event

event ue_retrieve_coils_2transfer(string as_coil_list);/*
Event:		ue_retrieve_coils_2transfer
				This event is called from Clicked event for cb_close of w_coil_ownership_transfer_select
Returns:		none
Arguments:	value		string	as_coil_list
*/

String	ls_sql_new, ls_sql_curr, ls_where
Integer	li_rtn
Long		ll_rows, ll_row


If as_coil_list <> "" Then
	//ls_sql_curr = dw_coil_ownership_transfer_item.GetSqlSelect()
	
	If Right(as_coil_list, 1) = "," Then
		as_coil_list = Left(as_coil_list, Len(as_coil_list) - 1)
	End If
	
	//If is_sql_curr <> "" Then
		ls_where = " where coil_abc_num in (" + as_coil_list + ")"
		ls_sql_new = is_sql_curr + ls_where //is_sql_curr is saved in Open event for this window
		
		li_rtn = dw_coil_ownership_transfer_item.SetSqlSelect(ls_sql_new)
		
		If li_rtn = 1 Then
			ll_rows = dw_coil_ownership_transfer_item.Retrieve()
			
			//Copy coils data into dw_coil_owneship_transfer_new for later change and update to database
			li_rtn = dw_coil_ownership_transfer_item.RowsCopy(1, dw_coil_ownership_transfer_item.RowCount(), Primary!, &
								dw_coil_ownership_transfer_new, 1, Primary!)
								
			If li_rtn = 1 Then
				For ll_row = 1 To dw_coil_ownership_transfer_item.RowCount()
					dw_coil_ownership_transfer_item.SetItemStatus(ll_row, 0, Primary!, NotModified!)
				Next
				
				For ll_row = 1 To dw_coil_ownership_transfer_new.RowCount()
					dw_coil_ownership_transfer_new.SetItemStatus(ll_row, 0, Primary!, NotModified!)
				Next
			End If
		End If
	//End If
End If
end event

event type string ue_collect_coils();/*
Event:		ue_collect_coils
				This event is called from Clicked event for cb_select of w_coil_ownership_transfer_select
Returns:		none
Arguments:	value		long	al_coil_abc_num
*/

String	ls_coil_abc_num_list
Long		ll_rows, ll_row, ll_coil_abc_num

For ll_row = 1 To dw_coil_ownership_transfer_item.RowCount()
	ll_coil_abc_num = dw_coil_ownership_transfer_item.Object.coil_abc_num[ll_row]
	ls_coil_abc_num_list = ls_coil_abc_num_list + String(ll_coil_abc_num) + ","
Next

If ls_coil_abc_num_list <> "" Then
	//Remove the last comma
	ls_coil_abc_num_list = Left(ls_coil_abc_num_list, Len(ls_coil_abc_num_list) -1)
End If

Return ls_coil_abc_num_list
end event

public subroutine wf_retrieve_coils_2transfer (string as_coil_list);/*
Function:	wf_retrieve_coils_2transfer
Returns:		none
Arguments:	value		string	as_coil_list
*/

String	ls_sql_new, ls_sql_curr, ls_where
Integer	li_rtn
Long		ll_rows


If as_coil_list <> "" Then
	//ls_sql_curr = dw_coil_ownership_transfer_item.GetSqlSelect()
	
	If is_sql_curr <> "" Then
		ls_where = " where coil_abc_num in (" + as_coil_list + ")"
		ls_sql_new = is_sql_curr + ls_where //is_sql_curr is saved in Open event for this window
		
		li_rtn = dw_coil_ownership_transfer_item.SetSqlSelect(ls_sql_new)
		
		If li_rtn = 1 Then
			ll_rows = dw_coil_ownership_transfer_item.Retrieve()
			
			//Copy coils data into dw_coil_owneship_transfer_new for later change and update to database
			li_rtn = dw_coil_ownership_transfer_item.RowsCopy(1, dw_coil_ownership_transfer_item.RowCount(), Primary!, &
								dw_coil_ownership_transfer_new, 1, Primary!)
		End If
	End If
End If
end subroutine

public function integer wf_coil_ownership_transfer ();/*
Function:	wf_coil_ownership_transfer
Returns:		integer
Arguments:	none
*/

Integer		li_rtn = 1, li_coil_status_new
Long			ll_rows, ll_row, ll_coil_abc_num_temp, ll_coil_abc_num_previous, ll_coil_abc_num_new
Long			ll_rows_coil_owneship_transfer, ll_row_coil_owneship_transfer
Long			ll_customer_id_previous, ll_customer_id_new
Long			ll_coil_netwt, ll_i, ll_coil_status, ll_coils_2transfer = 0
Long			ll_certificate_num, ll_selected, ll_selected_row
String		ls_coil_abc_num_list, ls_coil_abc_num_new_list, ls_where, ls_sql_new
String		ls_coil_notes, ls_coil_org_num, ls_transfer_performed_by, ls_authorization_note
s_coil_owneship_transfer	lstr_coil_owneship_transfer

dw_coil_ownership_transfer.Reset()

ll_selected = &
  long(dw_coil_ownership_transfer_item.describe("evaluate('sum( if(isselected(), 1, 0) for all)',1)"))
  
If ll_selected <= 0 Then //Nothing to do
	MessageBox("Nothing selected", "Please select coils to transfer", StopSign!)
	Return li_rtn
End If

//dw_coil_ownership_transfer_new.Reset()
dw_coil_ownership_transfer_detail.AcceptText()
dw_coil_ownership_transfer_item.AcceptText()

li_coil_status_new = 2 //New
ls_transfer_performed_by = gnv_app.of_getuserid()

ll_customer_id_new = dw_coil_ownership_transfer_detail.Object.customer_to[dw_coil_ownership_transfer_detail.GetRow()] //New customer

If IsNull(ll_customer_id_new) Or ll_customer_id_new <= 0 Then
	MessageBox("New Customer Missing", "Please select new customer", StopSign!)
	Return 1
End If

ls_coil_notes = dw_coil_ownership_transfer_detail.Object.notes[dw_coil_ownership_transfer_detail.GetRow()]
ls_authorization_note = dw_coil_ownership_transfer_detail.Object.authorization_note[dw_coil_ownership_transfer_detail.GetRow()]

ll_rows = dw_coil_ownership_transfer_item.RowCount()

If ll_rows > 0 Then
	If is_sql_curr <> "" Then //Populated in Open event for this window
		
		ll_certificate_num = wf_get_next_certificate_num()
		
		ll_selected_row = dw_coil_ownership_transfer_item.GetSelectedRow(0)
		
		Do While ll_selected_row > 0
			ll_coil_status = dw_coil_ownership_transfer_item.Object.coil_status[ll_selected_row]
			
			If ll_coil_status = 12 Then //Coil ready for ownership transfer
				ll_coils_2transfer++
				
				ll_customer_id_previous = dw_coil_ownership_transfer_item.Object.customer_id[ll_selected_row] //: original coil customer_id
				ll_coil_abc_num_previous = dw_coil_ownership_transfer_item.Object.coil_abc_num[ll_selected_row] //original coil coil_abc_num
				
				ll_coil_abc_num_new = wf_populate_new_coil(ll_selected_row, ll_customer_id_previous, ll_coil_abc_num_previous, ll_customer_id_new)
				
				//Build a list of new coil_abc_num's
				ls_coil_abc_num_new_list = ls_coil_abc_num_new_list + String(ll_coil_abc_num_new) + ","

				ls_coil_org_num = dw_coil_ownership_transfer_item.Object.coil_org_num[ll_selected_row]
				
				wf_insert_coil_ownership_transfer	(	ll_certificate_num, &
																	ll_coil_abc_num_previous, &
																	ll_customer_id_previous, &
																	ll_customer_id_new, &
																	ls_coil_org_num, &
																	ll_coil_abc_num_new, &
																	DateTime(Today(), Now()), &
																	ls_transfer_performed_by, &
																	ls_authorization_note, &
																	ls_coil_notes &
																)
																
				//Update old coil
				dw_coil_ownership_transfer_item.Object.coil_status[ll_selected_row] = 13
				//dw_coil_ownership_transfer_item.Object.coil_notes[ll_selected_row] = ls_coil_notes
				dw_coil_ownership_transfer_item.Object.coil_abc_num_new[ll_selected_row] = ll_coil_abc_num_new
				dw_coil_ownership_transfer_item.Object.customer_id_new[ll_selected_row] = ll_customer_id_new
			End If
									
			ll_selected_row = dw_coil_ownership_transfer_item.GetSelectedRow(ll_selected_row)
		Loop
		
		If ls_coil_abc_num_new_list <> "" Then
			If Right(ls_coil_abc_num_new_list, 1) = "," Then
				//remove the last comma
				ls_coil_abc_num_new_list = Left(ls_coil_abc_num_new_list, Len(ls_coil_abc_num_new_list) - 1)
			End If
		End If
		
		If ll_coils_2transfer > 0 Then //One or more coils transferred
			//Update the new coil_abc_num's with coil_status = new to database
			li_rtn = dw_coil_ownership_transfer_item.Update()
			
			If li_rtn = 1 Then //OK
				//Update the new coil_abc_num's with coil_status = 2 - New and new customer to database
				li_rtn = dw_coil_ownership_transfer_new.Update()
			
				If li_rtn = 1 Then //OK
					//Update dw_coil_ownership_transfer to database
					li_rtn = dw_coil_ownership_transfer.Update()
					
					If li_rtn = 1 Then //OK
						commit using sqlca;
						
						dw_coil_ownership_transfer_item.Retrieve()
						
						//Open certificate window
						li_rtn = OpenSheetWithParm(w_coil_ownership_transfer_certificate, ll_certificate_num, &
																								gnv_app.of_getframe(), 0, Original!)						
					End If
				Else
					li_rtn = -1
					rollback using sqlca;
				End If
			Else
				li_rtn = -1
				rollback using sqlca;
			End If
		End If
	End If
End If

Return li_rtn
end function

public function long wf_populate_new_coil (long al_row, long al_customer_id_previous, long al_coil_abc_num_previous, long al_customer_id_new);/*
Function:	wf_populate_new_coil
				1. Get all column values from dw_coil_ownership_transfer_item
				2. Update: 	customer_id_previous to al_customer_id_previous
								coil_abc_num_previous to al_coil_abc_num_previous
								customer_id_ to al_customer_id_new
								coil_status to 2 - New
				3. Insert those values into dw_coil_ownership_transfer_new for later .Update()
				
Returns:		long	<== coil_abc_num_new
Arguments:	value		long	al_row
				value		long	al_customer_id_previous
				value		long	al_coil_abc_num_previous
				value		long	al_customer_id_new
*/

Integer	li_rtn = 1, ll_coil_status_new = 2
Long		ll_inserted_row

Long		ll_coil_abc_num
String	ls_coil_org_num
Long		ll_customer_id
String	ls_icra
Long		ll_material_type
String	ls_coil_mid_num
Integer	li_coil_status
Long		ll_coil_alloy
String	ls_coil_temper
String	ls_lot_num
Real		lr_coil_gauge
Real		lr_coil_width
DateTime	ldt_date_received
DateTime	ldt_coil_entry_date
Long		ll_net_wt
Long		ll_pieces_per_case
String	ls_coil_location
Long		ll_net_wt_balance
String	ls_coil_notes
Integer	li_coil_line_num
Integer	li_coil_edi856_status
Long		ll_coil_from_cust_id
String	ls_coil_alloy2
Long		ll_reband_wt
Long		ll_reject_wt
Real		lr_recovery_rate
Long		ll_net_wt_balance_from_line
Integer	li_coil_status_from_line
String	ls_part_num
String	ls_supplier_sales_num
String	ls_purchase_order_num
Long		ll_abco_coil_net_wt
String	ls_consumed_coil_num
String	ls_material_num
String	ls_cash_date
DateTime	ldt_scrap_870_date
Long		ll_coil_abc_num_previous
Long		ll_customer_id_previous
Long		ll_coil_abc_num_new

//---

ll_coil_abc_num_new = f_get_next_value("coil_abc_num_seq") //Get a new coil_abc_num

ll_coil_abc_num = ll_coil_abc_num_new
ls_coil_org_num = dw_coil_ownership_transfer_item.Object.coil_org_num[al_row]
ll_customer_id = al_customer_id_new
ls_icra = dw_coil_ownership_transfer_item.Object.icra[al_row]
ll_material_type = dw_coil_ownership_transfer_item.Object.material_type[al_row]
ls_coil_mid_num = dw_coil_ownership_transfer_item.Object.coil_mid_num[al_row]
li_coil_status = ll_coil_status_new 
ll_coil_alloy = dw_coil_ownership_transfer_item.Object.coil_alloy[al_row]
ls_coil_temper = dw_coil_ownership_transfer_item.Object.coil_temper[al_row]
ls_lot_num = dw_coil_ownership_transfer_item.Object.lot_num[al_row]
lr_coil_gauge = dw_coil_ownership_transfer_item.Object.coil_gauge[al_row]
lr_coil_width = dw_coil_ownership_transfer_item.Object.coil_width[al_row]
ldt_date_received = dw_coil_ownership_transfer_item.Object.date_received[al_row]
ldt_coil_entry_date = dw_coil_ownership_transfer_item.Object.coil_entry_date[al_row]
ll_net_wt = dw_coil_ownership_transfer_item.Object.net_wt[al_row]
ll_pieces_per_case = dw_coil_ownership_transfer_item.Object.pieces_per_case[al_row]
ls_coil_location = dw_coil_ownership_transfer_item.Object.coil_location[al_row]
ll_net_wt_balance = dw_coil_ownership_transfer_item.Object.net_wt_balance[al_row]
ls_coil_notes = dw_coil_ownership_transfer_detail.Object.notes[dw_coil_ownership_transfer_detail.GetRow()]
li_coil_line_num = dw_coil_ownership_transfer_item.Object.coil_line_num[al_row]
li_coil_edi856_status = dw_coil_ownership_transfer_item.Object.coil_edi856_status[al_row]
ll_coil_from_cust_id = dw_coil_ownership_transfer_item.Object.coil_from_cust_id[al_row]
ls_coil_alloy2 = dw_coil_ownership_transfer_item.Object.coil_alloy2[al_row]
ll_reband_wt = dw_coil_ownership_transfer_item.Object.reband_wt[al_row]
ll_reject_wt = dw_coil_ownership_transfer_item.Object.reject_wt[al_row]
lr_recovery_rate = dw_coil_ownership_transfer_item.Object.recovery_rate[al_row]
ll_net_wt_balance_from_line = dw_coil_ownership_transfer_item.Object.net_wt_balance_from_line[al_row]
li_coil_status_from_line = dw_coil_ownership_transfer_item.Object.coil_status_from_line[al_row]
ls_part_num = dw_coil_ownership_transfer_item.Object.part_num[al_row]
ls_supplier_sales_num = dw_coil_ownership_transfer_item.Object.supplier_sales_num[al_row]
ls_purchase_order_num = dw_coil_ownership_transfer_item.Object.purchase_order_num[al_row]
ll_abco_coil_net_wt = dw_coil_ownership_transfer_item.Object.abco_coil_net_wt[al_row]
ls_consumed_coil_num = dw_coil_ownership_transfer_item.Object.consumed_coil_num[al_row]
ls_material_num = dw_coil_ownership_transfer_item.Object.material_num[al_row]
ls_cash_date = dw_coil_ownership_transfer_item.Object.cash_date[al_row]
ldt_scrap_870_date = dw_coil_ownership_transfer_item.Object.scrap_870_date[al_row]
ll_coil_abc_num_previous = al_coil_abc_num_previous
ll_customer_id_previous = al_customer_id_previous

//---

ll_inserted_row = dw_coil_ownership_transfer_new.InsertRow(0)

If ll_inserted_row > 0 Then

	dw_coil_ownership_transfer_new.Object.coil_abc_num[ll_inserted_row] = ll_coil_abc_num
	dw_coil_ownership_transfer_new.Object.coil_org_num[ll_inserted_row] = ls_coil_org_num
	dw_coil_ownership_transfer_new.Object.customer_id[ll_inserted_row] = ll_customer_id
	dw_coil_ownership_transfer_new.Object.icra[ll_inserted_row] = ls_icra
	dw_coil_ownership_transfer_new.Object.material_type[ll_inserted_row] = ll_material_type
	dw_coil_ownership_transfer_new.Object.coil_mid_num[ll_inserted_row] = ls_coil_mid_num
	dw_coil_ownership_transfer_new.Object.coil_status[ll_inserted_row] = li_coil_status
	dw_coil_ownership_transfer_new.Object.coil_alloy[ll_inserted_row] = ll_coil_alloy
	dw_coil_ownership_transfer_new.Object.coil_temper[ll_inserted_row] = ls_coil_temper
	dw_coil_ownership_transfer_new.Object.lot_num[ll_inserted_row] = ls_lot_num
	dw_coil_ownership_transfer_new.Object.coil_gauge[ll_inserted_row] = lr_coil_gauge
	dw_coil_ownership_transfer_new.Object.coil_width[ll_inserted_row] = lr_coil_width
	dw_coil_ownership_transfer_new.Object.date_received[ll_inserted_row] = ldt_date_received
	dw_coil_ownership_transfer_new.Object.coil_entry_date[ll_inserted_row] = ldt_coil_entry_date
	dw_coil_ownership_transfer_new.Object.net_wt[ll_inserted_row] = ll_net_wt
	dw_coil_ownership_transfer_new.Object.pieces_per_case[ll_inserted_row] = ll_pieces_per_case
	dw_coil_ownership_transfer_new.Object.coil_location[ll_inserted_row] = ls_coil_location
	dw_coil_ownership_transfer_new.Object.net_wt_balance[ll_inserted_row] = ll_net_wt_balance
	dw_coil_ownership_transfer_new.Object.coil_notes[ll_inserted_row] = ls_coil_notes
	dw_coil_ownership_transfer_new.Object.coil_line_num[ll_inserted_row] = li_coil_line_num
	dw_coil_ownership_transfer_new.Object.coil_edi856_status[ll_inserted_row] = li_coil_edi856_status
	dw_coil_ownership_transfer_new.Object.coil_from_cust_id[ll_inserted_row] = ll_coil_from_cust_id
	dw_coil_ownership_transfer_new.Object.coil_alloy2[ll_inserted_row] = ls_coil_alloy2
	dw_coil_ownership_transfer_new.Object.reband_wt[ll_inserted_row] = ll_reband_wt
	dw_coil_ownership_transfer_new.Object.reject_wt[ll_inserted_row] = ll_reject_wt
	dw_coil_ownership_transfer_new.Object.recovery_rate[ll_inserted_row] = lr_recovery_rate
	dw_coil_ownership_transfer_new.Object.net_wt_balance_from_line[ll_inserted_row] = ll_net_wt_balance_from_line
	dw_coil_ownership_transfer_new.Object.coil_status_from_line[ll_inserted_row] = li_coil_status_from_line
	dw_coil_ownership_transfer_new.Object.part_num[ll_inserted_row] = ls_part_num
	dw_coil_ownership_transfer_new.Object.supplier_sales_num[ll_inserted_row] = ls_supplier_sales_num
	dw_coil_ownership_transfer_new.Object.purchase_order_num[ll_inserted_row] = ls_purchase_order_num
	dw_coil_ownership_transfer_new.Object.abco_coil_net_wt[ll_inserted_row] = ll_abco_coil_net_wt
	dw_coil_ownership_transfer_new.Object.consumed_coil_num[ll_inserted_row] = ls_consumed_coil_num
	dw_coil_ownership_transfer_new.Object.material_num[ll_inserted_row] = ls_material_num
	dw_coil_ownership_transfer_new.Object.cash_date[ll_inserted_row] = ls_cash_date
	dw_coil_ownership_transfer_new.Object.scrap_870_date[ll_inserted_row] = ldt_scrap_870_date
	dw_coil_ownership_transfer_new.Object.coil_abc_num_previous[ll_inserted_row] = ll_coil_abc_num_previous
	dw_coil_ownership_transfer_new.Object.customer_id_previous[ll_inserted_row] = ll_customer_id_previous

End if


Return ll_coil_abc_num_new
end function

public function long wf_get_next_certificate_num ();/*
Function:	wf_get_next_certificate_num
Returns:		long
Arguments:	none
*/

Long	ll_certificate_num

select 	dbo.coil_owner_transfer_certif_seq.nextval 
into		:ll_certificate_num
from 		dual
using		sqlca;

Return ll_certificate_num
end function

public subroutine wf_insert_coil_ownership_transfer (long al_certificate_num, long al_coil_abc_num_orig, long al_customer_id_orig, long al_customer_id_new, string as_coil_org_num, long al_coil_abc_num_new, datetime adt_transfer_datetime, string as_transfer_performed_by, string as_authorization_note, string as_notes);/*
Function:	wf_insert_coil_ownership_transfer
Returns:		none
Arguments:	value		long		al_certificate_num
				value		long		al_coil_abc_num_orig
				value		long		al_customer_id_orig
				value		long		al_customer_id_new
				value		string	as_coil_org_num
				value		long		al_coil_abc_num_new
				value		datetime	adt_transfer_datetime
				value		string	as_transfer_performed_by
				value		string	as_authorization_note
				value		string	as_notes
*/

Long	ll_inserted_row

ll_inserted_row = dw_coil_ownership_transfer.InsertRow(0)

If ll_inserted_row > 0 Then
	dw_coil_ownership_transfer.Object.certificate_num[ll_inserted_row] = al_certificate_num
	dw_coil_ownership_transfer.Object.coil_abc_num_orig[ll_inserted_row] = al_coil_abc_num_orig
	dw_coil_ownership_transfer.Object.customer_id_orig[ll_inserted_row] = al_customer_id_orig
	dw_coil_ownership_transfer.Object.customer_id_new[ll_inserted_row] = al_customer_id_new
	dw_coil_ownership_transfer.Object.coil_org_num[ll_inserted_row] = as_coil_org_num
	dw_coil_ownership_transfer.Object.coil_abc_num_new[ll_inserted_row] = al_coil_abc_num_new
	dw_coil_ownership_transfer.Object.transfer_datetime[ll_inserted_row] = adt_transfer_datetime
	dw_coil_ownership_transfer.Object.transfer_performed_by[ll_inserted_row] = as_transfer_performed_by
	dw_coil_ownership_transfer.Object.authorization_note[ll_inserted_row] = as_authorization_note
	dw_coil_ownership_transfer.Object.notes[ll_inserted_row] = as_notes
End If
end subroutine

on w_coil_ownership_transfer.create
int iCurrent
call super::create
this.dw_coil_ownership_transfer_new=create dw_coil_ownership_transfer_new
this.dw_coil_ownership_transfer_item=create dw_coil_ownership_transfer_item
this.dw_coil_ownership_transfer=create dw_coil_ownership_transfer
this.cb_reprint=create cb_reprint
this.st_height=create st_height
this.st_4=create st_4
this.st_3=create st_3
this.st_width=create st_width
this.cb_3=create cb_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_barcode=create cb_barcode
this.cb_2=create cb_2
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_coil_ownership_transfer_detail=create dw_coil_ownership_transfer_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_ownership_transfer_new
this.Control[iCurrent+2]=this.dw_coil_ownership_transfer_item
this.Control[iCurrent+3]=this.dw_coil_ownership_transfer
this.Control[iCurrent+4]=this.cb_reprint
this.Control[iCurrent+5]=this.st_height
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_width
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.cb_barcode
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.dw_coil_ownership_transfer_detail
end on

on w_coil_ownership_transfer.destroy
call super::destroy
destroy(this.dw_coil_ownership_transfer_new)
destroy(this.dw_coil_ownership_transfer_item)
destroy(this.dw_coil_ownership_transfer)
destroy(this.cb_reprint)
destroy(this.st_height)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_width)
destroy(this.cb_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_barcode)
destroy(this.cb_2)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_coil_ownership_transfer_detail)
end on

event open;call super::open;DataWindowChild	ldwc_customer_from, ldwc_customer_to, ldwc
Integer				li_rtn

dw_coil_ownership_transfer_item.SetTransObject(sqlca)
dw_coil_ownership_transfer_new.SetTransObject(sqlca)
dw_coil_ownership_transfer.SetTransObject(sqlca)

is_sql_curr = dw_coil_ownership_transfer_item.GetSqlSelect() //Save the current SQL

li_rtn = dw_coil_ownership_transfer_detail.GetChild("customer_from", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ldwc.Retrieve()
End If

li_rtn = dw_coil_ownership_transfer_detail.GetChild("customer_to", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ldwc.Retrieve()
End If

//li_rtn = dw_coil_owner_transf_certificate_num.GetChild("certificate_num", ldwc)
//
//If li_rtn = 1 Then //OK
//	ldwc.SetTransObject(sqlca)
//	ldwc.Retrieve()
//End If

//li_rtn = dw_coil_ownership_transfer_detail.GetChild("customer_from", ldwc_customer_from)
//
//If li_rtn = 1 Then //OK
//	ldwc_customer_from.SetTransObject(sqlca)
//	ldwc_customer_from.Retrieve()
//End If
//
//li_rtn = dw_coil_ownership_transfer_detail.GetChild("customer_to", ldwc_customer_to)
//
//If li_rtn = 1 Then //OK
//	ldwc_customer_to.SetTransObject(sqlca)
//	ldwc_customer_to.Retrieve()
//End If
end event

event pfc_postopen;call super::pfc_postopen;This.Width = 3749
This.Height = 2214
end event

type dw_coil_ownership_transfer_new from u_dw within w_coil_ownership_transfer
event keydown pbm_dwnkey
integer x = 29
integer y = 1178
integer width = 3657
integer height = 742
integer taborder = 40
string dataobject = "d_coil_ownership_transfer_item"
end type

event keydown;/*
Event:		keydown
Event Id:	pbm_dwnkey
Returns:		long
Arguments:	Passed By	Type				Name
				---------	-----------		-------
				value			keycode			key
				value			unsignedlong	keyflags
*/

ib_shift_pressed_new = False
ib_control_pressed_new = False

Choose Case key
	Case 	KeyShift!
		ib_shift_pressed_new = True
	Case 	KeyControl!
		ib_control_pressed_new = True
	Case Else
		ib_shift_pressed_new = False
		ib_control_pressed_new = False
End Choose

//MessageBox("keydown event for dw_coil_ownership_transfer_new", &
//			"ib_shift_pressed = " + String(ib_shift_pressed_new) + &
//			"~n~rib_control_pressed = " + String(ib_control_pressed_new))
end event

event constructor;call super::constructor;//SetRowFocusIndicator(Hand!)
//of_SetBase(TRUE)
//of_SetRowManager(TRUE)
//of_SetRowSelect(TRUE)
//inv_RowSelect.of_SetStyle ( 2 ) 
end event

event clicked;call super::clicked;//SelectRow(0, FALSE)
//
//// Check arguments
//IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
//	Return
//END IF
//
//// Notify the RowSelect service that the row has been clicked.
//IF IsValid (inv_RowSelect) THEN
//	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
//END IF
//SelectRow(row, TRUE)
//
//// Sort services.
//IF IsValid (inv_Sort) THEN 
//	// Notify the Sort service, since it may have have a request
//	// to sort on colum header.
//	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
//END IF

Long	ll_selectedrow, ll_rc

ll_selectedrow = getselectedrow(0)  

//IF KeyDown(KeyEnter!) THEN

//MessageBox("Clicked event for dw_coil_ownership_transfer_new", &
//			"ib_shift_pressed = " + String(ib_shift_pressed_new) + &
//			"~n~rib_control_pressed = " + String(ib_control_pressed_new) + &
//			"~n~rll_selectedrow = " + String(ll_selectedrow))

If row <= 0 Then Return

// select range  
//IF KeyDown(KeyShift!) THEN  
If ib_shift_pressed_new Then
   IF ll_selectedrow = 0 THEN  
      This.SelectRow(row, True)  
   ELSE  
      This.SelectRow(0, False)  
      IF row > ll_selectedrow THEN  
         FOR ll_rc = ll_selectedrow TO row  
           This.SelectRow(ll_rc, True)  
         NEXT  
      ELSE  
         FOR ll_rc = row TO ll_selectedrow  
            This.SelectRow(ll_rc, True)  
         NEXT  
      END IF  
   END IF  
// multi select  
//ELSEIF KeyDown(KeyControl!) THEN  
ElseIf ib_control_pressed_new Then
   IF This.IsSelected(row) THEN  
      This.SelectRow(row, False)  
   ELSE  
      This.SelectRow(row, True)  
   END IF  
// single select  
ELSE  
   IF This.IsSelected(row) THEN  
      This.SelectRow(0, False)  
      This.SelectRow(row, True)  
   ELSE  
      This.SelectRow(0, False)  
      This.SelectRow(row, True)  
   END IF  
END IF

//ib_shift_pressed_new = False
//ib_control_pressed_new = False
end event

type dw_coil_ownership_transfer_item from u_dw within w_coil_ownership_transfer
event keydown pbm_dwnkey
integer x = 29
integer y = 358
integer width = 3657
integer height = 768
integer taborder = 20
string dataobject = "d_coil_ownership_transfer_item"
end type

event keydown;/*
Event:		keydown
Event Id:	pbm_dwnkey
Returns:		long
Arguments:	Passed By	Type				Name
				---------	-----------		-------
				value			keycode			key
				value			unsignedlong	keyflags
*/

ib_shift_pressed_item = False
ib_control_pressed_item = False

Choose Case key
	Case 	KeyShift!
		ib_shift_pressed_item = True
	Case 	KeyControl!
		ib_control_pressed_item = True
	Case Else
		ib_shift_pressed_item = False
		ib_control_pressed_item = False
End Choose

//MessageBox("keydown event for dw_coil_ownership_transfer_item", &
//			"ib_shift_pressed = " + String(ib_shift_pressed_item) + &
//			"~n~rib_control_pressed = " + String(ib_control_pressed_item))
end event

event constructor;call super::constructor;//SetRowFocusIndicator(Hand!)
//of_SetBase(TRUE)
//of_SetRowManager(TRUE)
//of_SetRowSelect(TRUE)
//inv_RowSelect.of_SetStyle ( 2 ) 
end event

event clicked;//SelectRow(0, FALSE)
//
//// Check arguments
//IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
//	Return
//END IF
//
//// Notify the RowSelect service that the row has been clicked.
//IF IsValid (inv_RowSelect) THEN
//	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
//END IF
//SelectRow(row, TRUE)
//
//// Sort services.
//IF IsValid (inv_Sort) THEN 
//	// Notify the Sort service, since it may have have a request
//	// to sort on colum header.
//	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
//END IF

Long	ll_selectedrow, ll_rc

If row <= 0 Then Return

ll_selectedrow = getselectedrow(0)  

//IF KeyDown(KeyEnter!) THEN

//MessageBox("Clicked event for dw_coil_ownership_transfer_item", &
//			"ib_shift_pressed = " + String(ib_shift_pressed_item) + &
//			"~n~rib_control_pressed = " + String(ib_control_pressed_item) + &
//			"~n~rll_selectedrow = " + String(ll_selectedrow))

// select range  
//IF KeyDown(KeyShift!) THEN  
If ib_shift_pressed_item Then
   IF ll_selectedrow = 0 THEN  
      This.SelectRow(row, True)  
   ELSE  
      This.SelectRow(0, False)  
      IF row > ll_selectedrow THEN  
         FOR ll_rc = ll_selectedrow TO row  
           This.SelectRow(ll_rc, True)  
         NEXT  
      ELSE  
         FOR ll_rc = row TO ll_selectedrow  
            This.SelectRow(ll_rc, True)  
         NEXT  
      END IF  
   END IF  
// multi select  
//ELSEIF KeyDown(KeyControl!) THEN  
ElseIf ib_control_pressed_item Then
   IF This.IsSelected(row) THEN  
      This.SelectRow(row, False)  
   ELSE  
      This.SelectRow(row, True)  
   END IF  
// single select  
ELSE  
   IF This.IsSelected(row) THEN  
      This.SelectRow(0, False)  
      This.SelectRow(row, True)  
   ELSE  
      This.SelectRow(0, False)  
      This.SelectRow(row, True)  
   END IF  
END IF
end event

type dw_coil_ownership_transfer from datawindow within w_coil_ownership_transfer
boolean visible = false
integer x = 59
integer y = 717
integer width = 3540
integer height = 307
integer taborder = 30
string title = "none"
string dataobject = "d_coil_ownership_transfer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_reprint from commandbutton within w_coil_ownership_transfer
integer x = 1463
integer y = 1946
integer width = 432
integer height = 90
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reprint Certificate"
end type

event clicked;Integer	li_rtn
Long		ll_certificate_num

//ll_certificate_num = dw_coil_owner_transf_certificate_num.Object.certificate_num[dw_coil_owner_transf_certificate_num.GetRow()]
//If IsNull(ll_certificate_num) Then ll_certificate_num = 0

//If ll_certificate_num > 0 Then
	//Open certificate window
	li_rtn = OpenSheet(w_reprint_coil_transfer_certificate, gnv_app.of_getframe(), 0, Original!)
//End If
end event

type st_height from statictext within w_coil_ownership_transfer
boolean visible = false
integer x = 1287
integer y = 2010
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
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;This.Text = String(Parent.Height)
end event

type st_4 from statictext within w_coil_ownership_transfer
boolean visible = false
integer x = 1083
integer y = 2010
integer width = 176
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Height"
boolean focusrectangle = false
end type

type st_3 from statictext within w_coil_ownership_transfer
boolean visible = false
integer x = 1083
integer y = 1946
integer width = 176
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Width"
boolean focusrectangle = false
end type

type st_width from statictext within w_coil_ownership_transfer
boolean visible = false
integer x = 1287
integer y = 1946
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
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;This.Text = String(Parent.Width)
end event

type cb_3 from u_cb within w_coil_ownership_transfer
integer x = 2311
integer y = 1946
integer width = 432
integer height = 90
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
string text = "Select All New"
end type

event clicked;call super::clicked;If dw_coil_ownership_transfer_new.RowCount() <= 0 Then Return 0

If This.Text = "Select All New" Then
	dw_coil_ownership_transfer_new.SelectRow(0, True)
	This.Text = "Unselect All New"
Else
	dw_coil_ownership_transfer_new.SelectRow(0, False)
	This.Text = "Select All New"
End if
end event

type st_2 from statictext within w_coil_ownership_transfer
integer x = 29
integer y = 1123
integer width = 1258
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "New Coils"
boolean focusrectangle = false
end type

type st_1 from statictext within w_coil_ownership_transfer
integer x = 29
integer y = 307
integer width = 1258
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Original Coils"
boolean focusrectangle = false
end type

type cb_barcode from commandbutton within w_coil_ownership_transfer
integer x = 2779
integer y = 1946
integer width = 432
integer height = 90
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print B~'codes New"
end type

event clicked;String							ls_coil_abs_num
Long								ll_rows, ll_row, ll_selected_count
Integer							li_rtn, li_coil_status
s_coil_owneship_transfer	lstr_coil_owneship_transfer

ll_rows = dw_coil_ownership_transfer_new.RowCount()

If ll_rows > 0 Then
	//	//Check if the selected coils are in status 13 - Ownership Transferred
	//	For ll_row = 1 To ll_rows
	//		li_coil_status = dw_coil_ownership_transfer_new.Object.coil_status[ll_row]
	//		
	//		If li_coil_status <> 13 Then
	//			dw_coil_ownership_transfer_new.SelectRow(ll_row, False) //Unselect
	//		End If
	//	Next
	//	
	//	//Count selected rows
	//	ll_selected_count = Long(dw_coil_ownership_transfer_new.describe("evaluate('sum( if(isselected(), 1, 0) for all)',1)"))
	
	
	
//	//Select all rows because w_coil_barcode_ownership_transfer prints barcodes for selected rows only
//	For ll_row = 1 To ll_rows
//		dw_coil_ownership_transfer_new.SelectRow(ll_row, True)
//	Next
	
	lstr_coil_owneship_transfer.coil_owneship_transfer = dw_coil_ownership_transfer_new
	
	//Open barcode window
	li_rtn = OpenSheetWithParm(w_coil_barcode_ownership_transfer, lstr_coil_owneship_transfer, &
				 																gnv_app.of_getframe(), 0, Original!)
																				 
Else
	MessageBox("Nothing to print", "There are no coils to print barcode for")																				
End If

end event

type cb_2 from u_cb within w_coil_ownership_transfer
integer x = 497
integer y = 1946
integer width = 432
integer height = 90
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
string text = "Select All Orig."
end type

event clicked;call super::clicked;If dw_coil_ownership_transfer_item.RowCount() <= 0 Then Return 0

If This.Text = "Select All Orig." Then
	dw_coil_ownership_transfer_item.SelectRow(0, True)
	This.Text = "Unselect All Orig."
Else
	dw_coil_ownership_transfer_item.SelectRow(0, False)
	This.Text = "Select All Orig."
End if
end event

type cb_close from commandbutton within w_coil_ownership_transfer
integer x = 3251
integer y = 1946
integer width = 432
integer height = 90
integer taborder = 50
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

type cb_1 from commandbutton within w_coil_ownership_transfer
integer x = 29
integer y = 1946
integer width = 432
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Transfer"
end type

event clicked;wf_coil_ownership_transfer()
end event

type dw_coil_ownership_transfer_detail from datawindow within w_coil_ownership_transfer
integer x = 29
integer width = 3653
integer height = 333
integer taborder = 10
string title = "none"
string dataobject = "d_coil_ownership_transfer_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

event itemchanged;String	ls_name, ls_customer_id, ls_sql_curr, ls_sql_new
Long		ll_customer_id, ll_rows
Integer	li_rtn

dw_coil_ownership_transfer_new.Reset()

ls_name = dwo.name

If ls_name = "customer_from" Then
	ll_customer_id = Long(data)
	
	If ll_customer_id > 0 Then
		li_rtn = dw_coil_ownership_transfer_item.SetSqlSelect(is_sql_curr)
		
		If li_rtn = 1 Then //OK
			ls_sql_curr = dw_coil_ownership_transfer_item.GetSqlSelect()
			
			If ls_sql_curr <> "" Then
				ls_sql_new = ls_sql_curr + "  where coil.coil_status = 12 and coil.customer_id = " + String(ll_customer_id)
				
				li_rtn = dw_coil_ownership_transfer_item.SetSqlSelect(ls_sql_new)
				
				If li_rtn = 1 Then //OK
					ll_rows = dw_coil_ownership_transfer_item.Retrieve()
				End If
			End If
		End If
	End If
End If
end event

