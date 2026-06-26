$PBExportHeader$w_coil_receiving.srw
$PBExportComments$<Sheet> receive coil and print out barcode_abc_coil_form inherited froam pfemain/w_sheet
forward
global type w_coil_receiving from w_sheet
end type
type dw_selected_rows from datawindow within w_coil_receiving
end type
type cb_change_cust from commandbutton within w_coil_receiving
end type
type cb_resend_861 from commandbutton within w_coil_receiving
end type
type dw_inbound_coil_status from datawindow within w_coil_receiving
end type
type dw_inbound_shipment_status from datawindow within w_coil_receiving
end type
type dw_data_861 from datawindow within w_coil_receiving
end type
type cb_1 from commandbutton within w_coil_receiving
end type
type dw_alloy_heat_treatment from datawindow within w_coil_receiving
end type
type dw_coil_quality_flaw_mapping from datawindow within w_coil_receiving
end type
type dw_coil_quality from datawindow within w_coil_receiving
end type
type dw_general_customer from datawindow within w_coil_receiving
end type
type cb_delete from u_cb within w_coil_receiving
end type
type cb_send861 from u_cb within w_coil_receiving
end type
type cb_newcoilnum from u_cb within w_coil_receiving
end type
type em_receiveddate from u_em within w_coil_receiving
end type
type st_6 from statictext within w_coil_receiving
end type
type dw_searchincomingedi from u_dw within w_coil_receiving
end type
type dw_searchbol from u_dw within w_coil_receiving
end type
type dw_coil_list_edi from u_dw within w_coil_receiving
end type
type cb_newbol from u_cb within w_coil_receiving
end type
type st_enter from statictext within w_coil_receiving
end type
type sle_searchbol from singlelineedit within w_coil_receiving
end type
type cb_search from u_cb within w_coil_receiving
end type
type cb_print from u_cb within w_coil_receiving
end type
type st_4 from statictext within w_coil_receiving
end type
type dw_incomingedi from u_dw within w_coil_receiving
end type
type cb_savebol from u_cb within w_coil_receiving
end type
type cb_deletecoil from u_cb within w_coil_receiving
end type
type cb_addcoil from u_cb within w_coil_receiving
end type
type sle_bol from singlelineedit within w_coil_receiving
end type
type dw_customer from u_dw within w_coil_receiving
end type
type st_3 from statictext within w_coil_receiving
end type
type st_2 from statictext within w_coil_receiving
end type
type dw_bol from u_dw within w_coil_receiving
end type
type dw_coil_list from u_dw within w_coil_receiving
end type
type cb_create from u_cb within w_coil_receiving
end type
type cb_close from u_cb within w_coil_receiving
end type
type ddlb_customer from dropdownlistbox within w_coil_receiving
end type
type st_1 from statictext within w_coil_receiving
end type
type gb_1 from groupbox within w_coil_receiving
end type
end forward

global type w_coil_receiving from w_sheet
string tag = "Receive coils from customer"
integer x = 5
integer y = 4
integer width = 4027
integer height = 2032
string title = "Coil Receiving"
string menuname = "m_receive_coil"
boolean maxbox = false
boolean resizable = false
long backcolor = 67108864
event type string ue_whoami ( )
event ue_read_only ( )
event type integer ue_create_coil ( )
event type integer ue_savebol ( )
event type integer ue_newbol ( )
event type integer ue_addcoil ( )
event type integer ue_print ( )
event type integer ue_deletecoil ( )
event type integer ue_searchbol ( )
event type integer ue_newcoilnum ( )
event type long ue_print_label_to_handheld ( long al_coil_abc_num )
event type integer ue_send861 ( )
event type integer ue_delete ( )
event type integer ue_deleteedi ( )
dw_selected_rows dw_selected_rows
cb_change_cust cb_change_cust
cb_resend_861 cb_resend_861
dw_inbound_coil_status dw_inbound_coil_status
dw_inbound_shipment_status dw_inbound_shipment_status
dw_data_861 dw_data_861
cb_1 cb_1
dw_alloy_heat_treatment dw_alloy_heat_treatment
dw_coil_quality_flaw_mapping dw_coil_quality_flaw_mapping
dw_coil_quality dw_coil_quality
dw_general_customer dw_general_customer
cb_delete cb_delete
cb_send861 cb_send861
cb_newcoilnum cb_newcoilnum
em_receiveddate em_receiveddate
st_6 st_6
dw_searchincomingedi dw_searchincomingedi
dw_searchbol dw_searchbol
dw_coil_list_edi dw_coil_list_edi
cb_newbol cb_newbol
st_enter st_enter
sle_searchbol sle_searchbol
cb_search cb_search
cb_print cb_print
st_4 st_4
dw_incomingedi dw_incomingedi
cb_savebol cb_savebol
cb_deletecoil cb_deletecoil
cb_addcoil cb_addcoil
sle_bol sle_bol
dw_customer dw_customer
st_3 st_3
st_2 st_2
dw_bol dw_bol
dw_coil_list dw_coil_list
cb_create cb_create
cb_close cb_close
ddlb_customer ddlb_customer
st_1 st_1
gb_1 gb_1
end type
global w_coil_receiving w_coil_receiving

type variables
//datastore ids_datastore
//String is_select
//s_coil_info ids_coil
//s_dw_db  istr_dwdb[]
//s_search_condition istr_search[]
//Boolean ib_new
//Boolean ib_modify
Long il_cust//, il_cur_coil
//

String	is_sqlerrtext, is_qr_code_req //Alex Gerlants. Coil Quality
Boolean	ib_cash_date_required //Alex Gerlants. 08/22/2018. Force Cash Date

String	is_bol, is_customer_name, is_create_861_at_receiving //Alex Gerlants. 05/30/2019. Arconic 861
//Boolean	ib_861_create_success //Alex Gerlants. 05/30/2019. Arconic 861

Long	il_receiving_bol_id, il_row_orig //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen

end variables

forward prototypes
public function integer of_bollist ()
public function integer of_incomingedi ()
public function integer of_newbol ()
public function integer of_check_updatespending ()
public subroutine wf_retrieve_mill_source_dddw ()
public subroutine wf_get_mill_source_from_coil (ref datawindow adw)
public subroutine wf_populate_dw_coil_list (string as_bol)
public subroutine wf_highlight_incoming_edi (string as_bol)
public function boolean wf_coil_abc_num_exists_on_db (long al_coil_abc_num)
public function boolean wf_coil_abc_num_duplicate (long al_coil_abc_num)
public function boolean wf_ff_data_exists (string as_bol)
public function integer wf_coil_quality (long al_edi_file_id[], string as_bol_edi, long al_coil_abc_number[], string as_coil_org_num[])
public function integer wf_coil_quality_00 (string as_barcode_string, long al_coil_abc_num)
public function integer wf_coil_quality_03 (string as_barcode_string, long al_coil_abc_num)
public subroutine wf_delete_error_rows (long al_coil_abc_num)
public function boolean wf_validate_cash_date (string as_cash_date)
public function boolean wf_all_alloys_exist ()
public function boolean wf_validate_cash_date_all ()
public function boolean wf_validate_cash_date_not_all ()
public function boolean wf_validate_cash_date ()
public subroutine wf_update_cash_date (string as_alloy, string as_cash_date)
public function integer wf_insert_coil_track (long al_coil_abc_num, long al_coil_weight, string as_coil_location)
public function integer wf_validate_cash_date_2 ()
public function integer wf_861_created (string as_bol)
public function integer wf_create_861_4arconic ()
public function integer wf_populate_data_861 (long al_customer_id, string as_bol, transaction atr_dbo_861)
protected function integer wf_create_861_4customer (long al_customer_id, string as_bol)
public function string wf_get_create_861_at_receiving (long al_customer_id)
public function integer wf_856_received ()
public subroutine wf_change_alloy_temper ()
public function boolean wf_856_received_4bol (string as_bol)
public subroutine wf_add_remove_selected_row (long al_selected_row, string as_add_delete)
end prototypes

event type string ue_whoami();RETURN "w_coil_receiving"
end event

event type integer ue_create_coil();//Int li_rc, li_row, li_rc_checked, i, li_checked
//datastore lds_coil_to_be_created
//
//Long ll_damage_fault, ll_damage_code, ll_net_wt, ll_gross_wt
//Long ll_edi_file_id
//Real lr_lineal_feed, lr_width, lr_gauge, lr_density
//Int li_coil_incoming_status, li_item_num
//String ls_coil_orig_num, ls_alloy, ls_temper, ls_lot, ls_pack_id, ls_bol
//
//dw_coil_list.AcceptText()
//
////get total number of coil shown
//li_rc = dw_coil_list.RowCount()
//if li_rc < 1 then
//	MessageBox("No coil available.", "Please select coil to be created.")
//	return 0
//end if
//
////data store to hold the selected coil's data
//lds_coil_to_be_created = CREATE datastore  
//lds_coil_to_be_created.DataObject = "d_coil_list_by_bol_created"
//lds_coil_to_be_created.SetTransObject(SQLCA)
//
////get total number of coil selected
//li_rc_checked = 0
//dw_coil_list.AcceptText()
//for i = 1 to li_rc
//	li_checked = dw_coil_list.GetItemNumber(i, "selected")
//	li_coil_incoming_status = dw_coil_list.GetItemNumber(i, "inbound_coil_status_status")
//	if (li_checked = 1) and (li_coil_incoming_status = 0) then	//coil_incoming_status:0, coil not created yet
//		li_rc_checked = li_rc_checked + 1
//		//get each coil data from dw_coil_list
//		ll_damage_fault = dw_coil_list.GetItemNumber(i, "inbound_coil_status_damaged_fault")
//		ll_damage_code = dw_coil_list.GetItemNumber(i, "inbound_coil_status_damaged_code")
//		ll_net_wt = dw_coil_list.GetItemNumber(i, "net_weight")
//		ll_gross_wt = dw_coil_list.GetItemNumber(i, "gross_weight")
//		ll_edi_file_id = dw_coil_list.GetItemNumber(i, "inbound_coil_edi_file_id")
//		lr_lineal_feed = dw_coil_list.GetItemNumber(i, "lineal_feed")
//		lr_width = dw_coil_list.GetItemNumber(i, "coil_width")
//		lr_gauge = dw_coil_list.GetItemNumber(i, "coil_gauge")
//		lr_density = dw_coil_list.GetItemNumber(i, "density")
//		li_item_num = dw_coil_list.GetItemNumber(i, "item_num")
//		ls_coil_orig_num = dw_coil_list.GetItemString(i, "coil_number")
//		ls_alloy = dw_coil_list.GetItemString(i, "alloy")
//		ls_temper = dw_coil_list.GetItemString(i, "temper")
//		ls_lot = dw_coil_list.GetItemString(i, "lot")
//		ls_pack_id = dw_coil_list.GetItemString(i, "pack_id")
//		ls_bol = dw_coil_list.GetItemString(i, "inbound_coil_bol")
//				
//		//insert it into lds_coil_to_be_created
//		li_row = lds_coil_to_be_created.InsertRow(0)
//		lds_coil_to_be_created.Setitem(li_row, "customer_id", il_cust)
//		lds_coil_to_be_created.SetItem(li_row, "coil_orig_num", ls_coil_orig_num)
//		lds_coil_to_be_created.Setitem(li_row, "inbound_coil_status", li_coil_incoming_status)
//		lds_coil_to_be_created.Setitem(li_row, "damage_fault", ll_damage_fault)
//		lds_coil_to_be_created.Setitem(li_row, "damage_code", ll_damage_code)
//		lds_coil_to_be_created.SetItem(li_row, "alloy", ls_alloy)
//		lds_coil_to_be_created.Setitem(li_row, "temper", ls_temper)
//		lds_coil_to_be_created.Setitem(li_row, "net_wt", ll_net_wt)
//		lds_coil_to_be_created.Setitem(li_row, "gross_wt", ll_gross_wt)
//		lds_coil_to_be_created.Setitem(li_row, "lineal_feed", lr_lineal_feed)
//		lds_coil_to_be_created.Setitem(li_row, "width", lr_width)
//		lds_coil_to_be_created.Setitem(li_row, "gauge", lr_gauge)
//		lds_coil_to_be_created.Setitem(li_row, "density", lr_density)
//		lds_coil_to_be_created.SetItem(li_row, "lot", ls_lot)
//		lds_coil_to_be_created.SetItem(li_row, "pack_id", ls_pack_id)
//		lds_coil_to_be_created.Setitem(li_row, "item_num", li_item_num)
//		lds_coil_to_be_created.Setitem(li_row, "edi_file_id", ll_edi_file_id)
//		lds_coil_to_be_created.Setitem(li_row, "bol", ls_bol)
//	else
//		
//	end if
//next
//
//if li_rc_checked <= 0 then
//	Messagebox("No coil selected", "Please select coil to be created.")
//	return 0
//end if
//
////open coil label printing window by passing lds_coil_to_be_created
//OpenWithParm(w_coil_receiving_barcode_printing, lds_coil_to_be_created)
//
//dw_bol.Retrieve(il_cust)
//dw_bol.ScrollToRow(0)
//dw_bol.SelectRow(0, False)
//
//dw_coil_list.reset()
//
//
//
//
return 1
end event

event type integer ue_savebol();String ls_bol
int li_rc, li_coil_count, i, li_row_add
Int li_coil_status
Long ll_receiving_bol_id, ll_coil_abc_num[], ll_row_bol, ll_j
String ls_user
DateTime ld_d
Date ld_received_date
DataStore lds_coil_abc_list_by_bol
s_bol_cust lst_bol_cust

Long  ll_damage_fault[], ll_damage_code[], ll_net_wt, ll_gross_wt
String ls_coil_orig_num[], ls_consumed_coil[], ls_material_num[],ls_cash_date[], ls_alloy, ls_temper, ls_lot, ls_pack_id, ls_part_num, ls_supplier_sales_num, ls_po
Real lr_lineal_feed, lr_width, lr_gauge, lr_density

Long	ll_coil_from_cust_id //Alex Gerlants. 02/09/2017

Long		ll_coil_abc, ll_pos //Alex Gerlants. 08/08/2017
String	ls_coil_abc_num_exists_on_db, ls_coil_abc_num_duplicate //Alex Gerlants. 08/08/2017
Boolean	lb_coil_abc_num_exists_on_db, lb_coil_abc_num_duplicate //Alex Gerlants. 08/08/2017

String	ls_coil_org_num[], ls_bol_edi //Alex Gerlants. Coil Quality
Integer	li_rtn //Alex Gerlants. Coil Quality
Long		ll_coil_abc_number[], ll_edi_file_id[] //Alex Gerlants. Coil Quality

String	ls_coil_location = "" //Alex Gerlants. Coil_Inventory_Report_863
String	ls_create_861_at_receiving //Alex Gerlants. 05/30/2019. Arconic 861

String	ls_vo //Alex Gerlants. Constellium inbound 856
String	ls_cntry_of_cast //Alex Gerlants. 09/07/2021. 1281_Add_Country_Of_Cast_2Coil_and_BOL
String	ls_coil_loc[] //Alex Gerlants. 03/24/2022. 1492_Add_Coil_Location_To_Coil_Receiving
Long		ll_lfeed //Alex Gerlants. 07/26/2023. 1241_Constellium-BG_870

dw_coil_list.AcceptText()

ld_d = DateTime(Today(), Now())
ll_receiving_bol_id = f_get_next_value("receiving_bol_id_seq")
ls_user = gnv_app.of_GetUserId()

//if BOL valid
ls_bol = Trim(sle_bol.text)
if len(ls_bol) < 1 then
	MessageBOx("Invalid BOL", "Please enter a valid BOL number")
	return 0
end if

ls_bol_edi = ls_bol //Alex Gerlants. Coil Quality

//check received_date
ld_received_date = Date(em_receiveddate.text)
if (ld_received_date > Today()) or ld_received_date <= RelativeDate(Today(), -7) then		//received date is older then a week, or after today
	li_rc  = MessageBox("Warning", "Is received date: " + String(ld_received_date) + " correct?", Question!, YesNo!)
	if li_rc = 2 then
		return 0
	end if
end if


//if there is coil
li_coil_count = dw_coil_list.RowCount()
if li_coil_count < 1 then
	MessageBox("No coil data", "Please enter coil information before saving a BOL.")
	return 0
else
for i = 1 to li_coil_count
	dw_coil_list.SetItem(i, "receiving_bol_id", ll_receiving_bol_id)
	dw_coil_list.SetItem(i, "coil_id", i)
next
end if

//Step 1: Create ABC coil(s)
lds_coil_abc_list_by_bol = Create DataStore	//datastore used to create ABC coil(s)
lds_coil_abc_list_by_bol.DataObject  = "d_coil_abc_list_by_bol"
lds_coil_abc_list_by_bol.SetTransObject(SQLCA)

for i = 1 to li_coil_count
		//get data from dw_coil_list
		ll_edi_file_id[i] = dw_coil_list.GetItemNumber(i, "inbound_coil_edi_file_id")
		ll_coil_abc_num[i] = dw_coil_list.GetItemNumber(i, "coil_abc_num")
		ll_coil_abc = ll_coil_abc_num[i]
	
		//Alex Gerlants. 08/08/2017. Begin
		lb_coil_abc_num_duplicate = wf_coil_abc_num_duplicate(ll_coil_abc)
	
		If lb_coil_abc_num_duplicate Then
			ll_pos = Pos(ls_coil_abc_num_duplicate, String(ll_coil_abc), 1)
			
			If ll_pos <= 0 Then //ll_coil_abc is not in ls_coil_abc_num_duplicate
			 	//Insert ll_coil_abc
				ls_coil_abc_num_duplicate = ls_coil_abc_num_duplicate + String(ll_coil_abc) + ", "
			End If
		End If
	
		lb_coil_abc_num_exists_on_db = wf_coil_abc_num_exists_on_db(ll_coil_abc)
		
		If lb_coil_abc_num_exists_on_db Then
			ll_pos = Pos(ls_coil_abc_num_exists_on_db, String(ll_coil_abc), 1)
			
			If ll_pos <= 0 Then //ll_coil_abc is not in ls_coil_abc_num_exists_on_db
				//Insert ll_coil_abc
				ls_coil_abc_num_exists_on_db = ls_coil_abc_num_exists_on_db + String(ll_coil_abc) + ", "
			End If
		End If
		//Alex Gerlants. 08/08/2017. End
		
		ls_coil_orig_num[i] = dw_coil_list.GetItemString(i, "coil_org_num")
		
		ls_coil_org_num[UpperBound(ls_coil_org_num[]) + 1] = ls_coil_orig_num[i] //Alex Gerlants. Coil Quality
		
		ll_damage_fault[i] = dw_coil_list.GetItemNumber(i, "damaged_fault")
		ll_damage_code[i] = dw_coil_list.GetItemNumber(i, "damaged_code")
		ls_alloy = dw_coil_list.GetItemString(i, "alloy")
		ls_temper = dw_coil_list.GetItemString(i, "temper")
		ll_net_wt = dw_coil_list.GetItemNumber(i, "net_weight")
		ll_gross_wt = dw_coil_list.GetItemNumber(i, "gross_weight")
		lr_lineal_feed = dw_coil_list.GetItemNumber(i, "lineal_feed")
		lr_width = dw_coil_list.GetItemNumber(i, "coil_width")
		lr_gauge = dw_coil_list.GetItemNumber(i, "coil_gauge")
		lr_density = dw_coil_list.GetItemNumber(i, "density")
		ls_lot = dw_coil_list.GetItemString(i, "lot")
		ls_pack_id = dw_coil_list.GetItemString(i, "pack_id")
		ls_part_num = dw_coil_list.GetItemString(i, "part_num")
		ls_supplier_sales_num = dw_coil_list.GetItemString(i, "supplier_sales_num")
		ls_po = dw_coil_list.GetItemString(i, "purchase_order_num")
		ls_consumed_coil[i] = dw_coil_list.GetItemString(i, "consumed_coil_num")
		ls_material_num[i] = dw_coil_list.GetItemString(i, "material_num")
		ls_cash_date[i] = dw_coil_list.GetItemString(i, "cash_date")
		ls_coil_loc[i] = dw_coil_list.Object.coil_location[i] //Alex Gerlants. 03/24/2022. 1492_Add_Coil_Location_To_Coil_Receiving
		
		//Alex Gerlants. 05/25/2018. Begin
		//Cash Date looks like "mmddyyyy" at this point. I format it as "mm/dd/yyyy"
		
		//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. Begin
		//Added condition to add "/" only if cash date populated
		If IsNull(ls_cash_date[i]) Then ls_cash_date[i] = ""

		If ls_cash_date[i] <> "" Then //Cash date populated
			//Insert "/" only if cash date entered by the user
			ls_cash_date[i] = Left(ls_cash_date[i], 2) + "/" + Mid(ls_cash_date[i], 3, 2) + "/" + Right(ls_cash_date[i], 4)
		Else //Cash date not populated
			SetNull(ls_cash_date[i])
		End If
		//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. End
		
		ll_coil_from_cust_id = dw_coil_list.GetItemNumber(i, "coil_from_cust_id") //Alex Gerlants. 02/09/2017
		
		//insert data in lds_coil_abc_list_by_bol
		li_row_add = lds_coil_abc_list_by_bol.InsertRow(0)
		//ll_coil_abc_num = f_get_next_value("coil_abc_num_seq")
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_ABC_NUM", ll_coil_abc_num[i] )
		
		ll_coil_abc_number[UpperBound(ll_coil_abc_number[]) + 1] = ll_coil_abc_num[i] //Alex Gerlants. Coil Quality 
		
		//dw_coil_list.SetItem(i, "coil_abc_num", ll_coil_abc_num[i])		//Set ABC Coil# in dw_coil_list for updating later
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_ORG_NUM",  ls_coil_orig_num[i]) 
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "CONSUMED_COIL_NUM", ls_consumed_coil[i])	
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "MATERIAL_NUM", ls_material_num[i])	
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "CASH_DATE", ls_cash_date[i])	
		lds_coil_abc_list_by_bol.Object.coil_location[li_row_add] = ls_coil_loc[i] //Alex Gerlants. 03/24/2022. 1492_Add_Coil_Location_To_Coil_Receiving
      
		if (ll_damage_fault[i]=0) and (ll_damage_code[i]=0) then
			lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_STATUS", 2)	//coil_status: new
		else
			lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_STATUS", 11)	//coil_status: qa_onhold
			
			//For updating coil_track_qa
//			li_row_3 = dw_coil_qa_create.InsertRow(0)
//			dw_coil_qa_create.SetItem(li_row_3, "COIL_ABC_NUM", ll_coil_abc_num)
//			dw_coil_qa_create.SetItem(li_row_3, "COIL_TRACK_DATE", Today()) 
//         dw_coil_qa_create.SetItem(li_row_3, "COIL_CUR_STATUS", 11)	//status : 11 qa_onhold  
//         ls_user = gnv_app.of_GetUserId() 
//			dw_coil_qa_create.SetItem(li_row_3, "COIL_MODIFIED_BY", ls_user) 			
		end if

		lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_NET_WT", ll_net_wt)  
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_ALLOY2", ls_alloy) 
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_TEMPER", ls_temper)   
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_GAUGE",  lr_gauge) 
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_WIDTH",  lr_width)
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_DATE_RECEIVED", Today())
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_NET_WT_BALANCE", ll_net_wt) 
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_LOT_NUM", ls_lot)  
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_CUSTOMER_ID", il_cust)  
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_ENTRY_DATE",  Today()) 
     	lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_MID_NUM", ls_pack_id)	
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "PART_NUM", ls_part_num)	
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "SUPPLIER_SALES_NUM", ls_supplier_sales_num)	
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "PURCHASE_ORDER_NUM", ls_po)	
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "coil_from_cust_id", ll_coil_from_cust_id) //Alex Gerlants. 02/09/2017

		li_rtn = wf_insert_coil_track(ll_coil_abc_num[i], ll_net_wt, "") //Alex Gerlants. Coil_Inventory_Report_863
		
		//Alex Gerlants. Constellium inbound 856. Begin
		//Alex Gerlants. 09/07/2021. 1281_Add_Country_Of_Cast_2Coil_and_BOL. Added cntry_of_cast
		//Alex Gerlants. 07/26/2023. 1241_Constellium-BG_870. Added lfeed
		select distinct vo, cntry_of_cast, lfeed
		into		:ls_vo, :ls_cntry_of_cast, :ll_lfeed
		from		inbound_coil
		where 	edi_file_id =
		(
			select max(edi_file_id) from inbound_coil where coil_number = :ls_coil_orig_num[i]
		)
		and		coil_number = :ls_coil_orig_num[i]
		using		sqlca;
		
		If sqlca.sqlcode <> 0 Then ls_vo = ""
		If sqlca.sqlcode <> 0 Then ls_cntry_of_cast = "" //Alex Gerlants. 09/07/2021. 1281_Add_Country_Of_Cast_2Coil_and_BOL
		If sqlca.sqlcode <> 0 Then ll_lfeed = -99 //Alex Gerlants. 07/26/2023. 1241_Constellium-BG_870
		
		li_rc = lds_coil_abc_list_by_bol.SetItem(li_row_add, "vo", ls_vo)
		//Alex Gerlants. Constellium inbound 856. End
		
		li_rc = lds_coil_abc_list_by_bol.SetItem(li_row_add, "cntry_of_cast", ls_cntry_of_cast) //Alex Gerlants. 09/07/2021. 1281_Add_Country_Of_Cast_2Coil_and_BOL
		li_rc = lds_coil_abc_list_by_bol.SetItem(li_row_add, "lfeed", ll_lfeed) //Alex Gerlants. 07/26/2023. 1241_Constellium-BG_870

		//We are doing nothing in case of DB error in wf_insert_coil_track because we don't want to hold the coil receiving
		//wf_insert_coil_track will display an information message in case of DB error
		If li_rtn = 1 Then //OK
			//
		Else //DB error in wf_insert_coil_track
			//
		End if
next

//Alex Gerlants. 08/08/2017. Begin
If ls_coil_abc_num_duplicate <> "" Or ls_coil_abc_num_exists_on_db <> "" Then
	If ls_coil_abc_num_duplicate <> "" Then
		//Remove the last comma
		ls_coil_abc_num_duplicate = Left(ls_coil_abc_num_duplicate, Len(ls_coil_abc_num_duplicate) - 2)
		
		ls_coil_abc_num_duplicate = "The following Coil ABC Numbers are duplicate on the screen: " + ls_coil_abc_num_duplicate
	End If
	
	If ls_coil_abc_num_exists_on_db <> "" Then
		//Remove the last comma
		ls_coil_abc_num_exists_on_db = Left(ls_coil_abc_num_exists_on_db, Len(ls_coil_abc_num_exists_on_db) - 2)
		
		ls_coil_abc_num_exists_on_db = "The following Coil ABC Number(s) already exist on database: " + ls_coil_abc_num_exists_on_db
	End if
	
	If ls_coil_abc_num_duplicate <> "" And ls_coil_abc_num_exists_on_db <> "" Then
		MessageBox("Error", ls_coil_abc_num_duplicate + "~n~r~n~r" + ls_coil_abc_num_exists_on_db + &
				"~n~r~n~rCannot save" + &
				"~n~rPlease review the newly created Coil ABC Number(s)", StopSign!)
	ElseIf ls_coil_abc_num_duplicate <> "" Then
		MessageBox("Error", ls_coil_abc_num_duplicate + &
				"~n~r~n~rCannot save" + &
				"~n~rPlease review the newly created Coil ABC Number(s)", StopSign!)
	Else //ls_coil_abc_num_exists_on_db <> ""
		MessageBox("Error", ls_coil_abc_num_exists_on_db + &
				"~n~r~n~rCannot save" + &
				"~n~rPlease review the newly created Coil ABC Number(s)", StopSign!)
	End If
		
	Return 1
End If
//Alex Gerlants. 08/08/2017. End

//check if coil conflicts with existing coils?

//lds_coil_abc_list_by_bol.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

li_rc = lds_coil_abc_list_by_bol.Update()
IF li_rc <> 1 THEN
	ROLLBACK USING SQLCA;
	MessageBox("Error", "Error in dw_coil_list.Update().")
	RETURN -1
//else
//	commit using sqlca;
END IF

//Step2: Save BOl data
//update receiving_bol
INSERT INTO receiving_bol (RECEIVING_BOL_ID, BOL, CUSTOMER_ID, CREATED_BY, CREATED_DATE, RECEIVED_DATE)
VALUES (:ll_receiving_bol_id, :ls_bol, :il_cust, :ls_user,  :ld_d, :ld_received_date) 
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN 
   MessageBox("SQL error", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	MessageBox("Error", "Cannot save into receiving_bol.", StopSign!)
	
	Return -1 //Alex Gerlants. Coil Quality
END IF

//update receiving_bol_coil
dw_coil_list.Update()
IF SQLCA.SQLCode = -1 THEN 
   MessageBox("SQL error", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	MessageBox("Error", "Cannot save into receiving_bol_coil.", StopSign!)
	
	Return -1 //Alex Gerlants. Coil Quality
END IF

////if damaged, create record in coil_track_qa
//li_rc = dw_coil_qa_create.Update()
//IF li_rc <> 1 THEN
//	ROLLBACK USING SQLCA;
//	MessageBox("Error", "Error in dw_coil_qa_creat.Update().")
//	RETURN -1
//ELSE
//	COMMIT USING SQLCA;
//END IF
//

//Step 3: Update inbound_shipment_status and inbound_coil_status
UPDATE INBOUND_SHIPMENT_STATUS  
SET STATUS = 3, RECEIVED_TIME = :ld_received_date 
WHERE INBOUND_SHIPMENT_STATUS.BOL = :ls_bol
USING SQLCA;

IF SQLCA.SQLCode = -1 THEN 
   MessageBox("SQL error", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	MessageBox("Error", "Cannot update inbound_shipment_status.", StopSign!)	
	
	Return -1 //Alex Gerlants. Coil Quality
END IF

for i = 1 to li_coil_count
	UPDATE INBOUND_COIL_STATUS
	SET DAMAGED_CODE = :ll_damage_code[i], DAMAGED_FAULT = :ll_damage_fault[i], STATUS = 1
	WHERE INBOUND_COIL_STATUS.BOL = :ls_bol and INBOUND_COIL_STATUS.COIL_NUMBER = :ls_coil_orig_num[i]
	USING SQLCA;

	IF SQLCA.SQLCode = -1 THEN 
		MessageBox("SQL error", SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;
		MessageBox("Error", "Cannot update inbound_coil_status.", StopSign!)	
		
		Return -1 //Alex Gerlants. Coil Quality
	END IF
next

//Alex Gerlants. 08/22/2018. Force Cash Date. Begin
li_rtn = dw_alloy_heat_treatment.Update()

If li_rtn <> 1 Then //Update error
	Return -1
End If
//Alex Gerlants. 08/22/2018. Force Cash Date. End

COMMIT USING SQLCA;

Long	ll_rows //Alex Gerlants. 03/09/2021
ll_rows = dw_bol.Retrieve(il_cust) //Alex Gerlants. 03/09/2021

//Alex Gerlants. Coil Quality. Begin
//I am commiting in a separate session to separate the 2 processes: Main coil processing and Coil Quality processing
If is_qr_code_req = "Y" Then //This is customer.qr_code_req
	//Update QR code parsing tables: coil_quality and coil_quality_flaw_mapping
	li_rtn = wf_coil_quality(ll_edi_file_id[], ls_bol_edi, ll_coil_abc_number[], ls_coil_org_num[])
	
	If li_rtn = 1 Then //OK in wf_coil_quality()
		//Commit using sqlca; //I am cimmiting in  wf_coil_quality()
	Else //Error in wf_coil_quality
		//All error messages are in wf_coil_quality
		//I am not stopping the main coil processing if errors in wf_coil_quality.
		//Incoming coils have to be in inventory regardless.
		
		//To run wf_coil_quality() for a coil, there is button "QR Code" on w_coil_detail_2 in silverdome1.pbl
		
		//rollback using sqlca; //I am rolling back in  wf_coil_quality()
	End If
End If
//Alex Gerlants. Coil Quality. End

//Alex Gerlants. 05/30/2019. Arconic 861. Begin
ls_create_861_at_receiving = wf_get_create_861_at_receiving(il_cust)

If ls_create_861_at_receiving = "Y" Then
	wf_create_861_4customer(il_cust, ls_bol)	//customer_id IF statement is in wf_create_861_4customer()
End If
//Alex Gerlants. 05/30/2019. Arconic 861. End

////Step 4: If all coil have been created, call F_CREATE_EDI_861_BY_BOL() to send 861 and update inbound_shipment_status
//SELECT count("INBOUND_COIL_STATUS"."ITEM_NUM") INTO :li_rc
//FROM "INBOUND_COIL_STATUS" 
//WHERE "EDI_FILE_ID" = :ll_edi_file_id AND
//	   "BOL" =  :ls_bol AND
//		"STATUS" = 0		
//USING SQLCA;
//
//if li_rc = 0 then
//	ls_received_time = String(Today(), "mm/dd/yyyy hh:mm")
//
//	transaction dboconnect
//	dboconnect = create transaction
//	dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
//	dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
//	dboconnect.LogID = gs_LogID
//	dboconnect.LogPass = gs_LogPass
//	connect using dboconnect;
//	if dboconnect.SQLCode<0 then 
//		MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
//		return -1
//	end if
//	
//	DECLARE p_edi procedure for F_CREATE_EDI_861_BY_BOL(:ls_bol, :ll_edi_file_id, :ls_received_time)  using dboconnect;
//	execute p_edi;
//	if dboconnect.SQLCode <> 0 then 
//		MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
//		return -1
//	end if
//	fetch p_edi INTO :li_return; 
//	close p_edi;
//	
////	CHOOSE CASE li_return
////   CASE 1
////    messagebox("EDI_861 Generation","EDI 861 generated successfully")
////	CASE -1
////		MessageBox("Info","System error!" )
////	CASE -2
////		MessageBox("Error","EDI failed, Errors with UTL_FILE!", StopSign!)
////	END CHOOSE
//
//	disconnect using dboconnect;
//	destroy dboconnect;
//	
//end if
//

li_rc = MessageBox("BOL Saved", "The BOL has been saved and ABC Coil(s) have already been created. Do you want to print coil barcode?", Question!, YesNo!)
if li_rc = 1 then
	lst_bol_cust.bol = ls_bol
	lst_bol_cust.cust = il_cust
	OpenWithParm(w_coil_receiving_barcode_printing, lst_bol_cust)
end if

dw_bol.Retrieve(il_cust)
dw_incomingedi.Retrieve(il_cust)
of_bollist()
			
ll_row_bol = dw_bol.RowCount()
FOR ll_j = 1 TO ll_row_bol
				IF dw_bol.GetItemString(ll_j, "bol") = ls_bol THEN
					dw_bol.Event RowFocusChanged(ll_j)
					dw_bol.SelectRow(0, False)
					dw_bol.SelectRow(ll_j, True)
					dw_bol.ScrollToRow(ll_j)
					dw_coil_list.Retrieve(ll_receiving_bol_id)
					wf_get_mill_source_from_coil(dw_coil_list) //Alex Gerlants. 02/09/2017
				END IF
NEXT	

return 1



end event

event type integer ue_newbol();Int li_rc

if il_cust = 0 or isnull(il_cust) then
	MessageBox("Select Customer", "Please select customer for the BOL.")
	return 0
end if

li_rc = MessageBox("Create New BOL", "Do you want to create a new BOL?", Question!, YesNo!) 

if li_rc = 1 then
	of_newbol()
	
else
	return 0
end if

return 1

end event

event type integer ue_addcoil();dw_coil_list.InsertRow(0)

return 1
end event

event type integer ue_print();Int li_rc
String ls_bol
s_bol_cust lst_bol_cust

//Give warning if there is data not saved yet.
li_rc = dw_coil_list.of_UpdatesPending()
if li_rc = 1 then
	li_rc = MessageBox("Warning", "Do you want to save the BOL and its coil data first?", Question!, YesNoCancel!)
	choose case li_rc
	case 1
		this.event ue_savebol()		
	case 2
	case 3
		return 0	
	end choose
end if

ls_bol = Trim(sle_bol.text)
lst_bol_cust.bol = ls_bol
lst_bol_cust.cust = il_cust

OpenWithParm(w_coil_receiving_barcode_printing, lst_bol_cust)

return 1
end event

event type integer ue_deletecoil();Int li_row, li_rc

li_row = dw_coil_list.GetRow()
if li_row < 1 then
	MessageBox("Select Row Error", "Please select a coil to be deleted.")
	return 0
else
	li_rc = MessageBox("Confirmation", "Are you sure you want to remove the selectd coil from this BOL?", Question!, YesNo!)
	if li_rc = 1 then
		dw_coil_list.DeleteRow(li_row)
	else
		return 0
	end if
end if

return 1
end event

event type integer ue_searchbol();String ls_bol, ls_customer_short_name
Int li_rc, ll_i, ll_j, i, li_index, li_row, li_rowcount
Long ll_cust_id, ll_row, ll_row_bol, ll_row_incomingedi, ll_receiving_bol_id, ll_edi_file_id

String	ls_cash_date //Alex Gerlants. 05/30/2018
Integer	li_rtn //Alex Gerlants. Arconic 861

If st_enter.Text = "Enter BOL# here to find it." Then //Alex Gerlants. 03/27/2017
	//if the entered BOL valid
	ls_bol = Trim(sle_searchbol.text)
	if len(ls_bol) < 1 then
		MessageBOx("Invalid BOL Entered", "Please enter a valid BOL number.")
		return 0
	end if
//Alex Gerlants. 03/27/2017. Begin
Else
	//Check if user entered valid Date From and Date To
	
End If
//Alex Gerlants. 03/27/2017. End

//search in BOL List
dw_searchbol.Retrieve(ls_bol)
li_rc = dw_searchbol.RowCount()
if li_rc < 1 then
	//MessageBox("Search Result", "No BOL matched found in BOL List.")
else
	if of_bollist() = 0 then
		return 0
	end if
	
	sle_bol.text = ls_bol
	ll_cust_id = dw_searchbol.GetItemNumber(1, "customer_id")		//pick the first matched one
	ll_receiving_bol_id = dw_searchbol.GetItemNumber(1, "receiving_bol_id")
	il_cust = ll_cust_id
	
	dw_general_customer.Object.customer_id[1] = ll_cust_id //Alex Gerlants. 03/27/2017
	
	ll_row = dw_customer.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemNumber(ll_i, "customer_id") = ll_cust_id THEN
			dw_customer.Event RowFocusChanged(ll_i)
			dw_customer.SelectRow(0, False)
			dw_customer.SelectRow(ll_i, True)
			ls_customer_short_name = dw_customer.GetItemString(ll_i, "customer_short_name")
			li_index = ddlb_customer.SelectItem(ls_customer_short_name, 1)

			dw_bol.Retrieve(il_cust)
			dw_incomingedi.Retrieve(il_cust)
			dw_coil_list.reset()
			
			ll_row_bol = dw_bol.RowCount()
			FOR ll_j = 1 TO ll_row_bol
				IF dw_bol.GetItemString(ll_j, "bol") = ls_bol THEN
					dw_bol.Event RowFocusChanged(ll_j)
					dw_bol.SelectRow(0, False)
					dw_bol.SelectRow(ll_j, True)
					dw_bol.ScrollToRow(ll_j)
					dw_coil_list.Retrieve(ll_receiving_bol_id)
					
					is_bol = ls_bol //Alex Gerlants. Arconic 861
					//li_rtn = wf_create_861_4customer(ll_cust_id, ls_bol) //Alex Gerlants. Arconic 861

				END IF
			NEXT			
		END IF
	NEXT	
	
	cb_resend_861.Visible = True //Alex Gerlants. 05/30/2019. Arconic 861
	
	cb_change_cust.Enabled = True //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen
	
	MessageBox("Search Result", "BOL matched found in BOL list.")

	return 1
end if

//search in Incoming EDI
dw_searchincomingedi.Retrieve(ls_bol)
li_rc = dw_searchincomingedi.RowCount()
if li_rc < 1 then
	cb_resend_861.Visible = False //Alex Gerlants. 05/30/2019. Arconic 861
	MessageBox("Search Result", "No BOL matched found.")
else
	if of_incomingedi() = 0 then
		return 0
	end if
	
	sle_bol.text = ls_bol
	ll_cust_id = dw_searchincomingedi.GetItemNumber(1, "customer_id")		//pick the first matched one
	ll_edi_file_id = dw_searchincomingedi.GetItemNumber(1, "edi_file_id")
	il_cust = ll_cust_id
	
	dw_general_customer.Object.customer_id[1] = ll_cust_id //Alex Gerlants. 03/27/2017
	
	ll_row = dw_customer.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemNumber(ll_i, "customer_id") = ll_cust_id THEN
			dw_customer.Event RowFocusChanged(ll_i)
			dw_customer.SelectRow(0, False)
			dw_customer.SelectRow(ll_i, True)
			ls_customer_short_name = dw_customer.GetItemString(ll_i, "customer_short_name")
			li_index = ddlb_customer.SelectItem(ls_customer_short_name, 1)
			
			dw_bol.Retrieve(il_cust)
			dw_incomingedi.Retrieve(il_cust)
			dw_coil_list.reset()
			
			ll_row_incomingedi = dw_incomingedi.RowCount()
			FOR ll_j = 1 TO ll_row_incomingedi
				IF dw_incomingedi.GetItemString(ll_j, "bol") = ls_bol THEN
					dw_incomingedi.Event RowFocusChanged(ll_j)
					dw_incomingedi.SelectRow(0, False)
					dw_incomingedi.SelectRow(ll_j, True)
					dw_incomingedi.ScrollToRow(ll_j)
					dw_coil_list_edi.Retrieve(ls_bol, ll_edi_file_id)
		
				//populate dw_coil_list
				li_rowcount = dw_coil_list_edi.RowCount()
				if li_rowcount > 0 then
						for i = 1 to li_rowcount
							li_row = dw_coil_list.InsertRow(0)					
							dw_coil_list.SetItem(li_row, "COIL_ORG_NUM", dw_coil_list_edi.GetItemString(i, "COIL_NUMBER") )
							dw_coil_list.SetItem(li_row, "DAMAGED_FAULT", 0)	//0: "No Damaged"
							dw_coil_list.SetItem(li_row, "DAMAGED_CODE", 0)	//0: "No Damaged"
							dw_coil_list.SetItem(li_row, "TEMPER", dw_coil_list_edi.GetItemString(i, "TEMPER"))
							dw_coil_list.SetItem(li_row, "NET_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "NET_WEIGHT"))
							dw_coil_list.SetItem(li_row, "GROSS_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "GROSS_WEIGHT"))
							dw_coil_list.SetItem(li_row, "COIL_GAUGE", dw_coil_list_edi.GetItemNumber(i, "COIL_GAUGE"))
							dw_coil_list.SetItem(li_row, "DENSITY", dw_coil_list_edi.GetItemNumber(i, "DENSITY"))
							dw_coil_list.SetItem(li_row, "LOT", dw_coil_list_edi.GetItemString(i, "LOT"))
							dw_coil_list.SetItem(li_row, "PACK_ID", dw_coil_list_edi.GetItemString(i, "PACK_ID"))
							dw_coil_list.SetItem(li_row, "ALLOY", dw_coil_list_edi.GetItemString(i, "ALLOY"))
							dw_coil_list.SetItem(li_row, "LINEAL_FEED", dw_coil_list_edi.GetItemNumber(i, "LINEAL_FEED"))
							dw_coil_list.SetItem(li_row, "COIL_WIDTH", dw_coil_list_edi.GetItemNumber(i, "COIL_WIDTH"))
							dw_coil_list.SetItem(li_row, "CONSUMED_COIL_NUM", dw_coil_list_edi.GetItemString(i, "INBOUND_COIL_CONSUMED_COIL_NUM"))
							dw_coil_list.SetItem(li_row, "MATERIAL_NUM", dw_coil_list_edi.GetItemString(i, "INBOUND_COIL_MATERIAL_NUM"))

							ls_cash_date = dw_coil_list_edi.GetItemString(i, "inbound_coil_cash_date") //Alex Gerlants. 05/30/2018
							If IsNull(ls_cash_date) Then ls_cash_date = "" //Alex Gerlants. 05/30/2018
							ls_cash_date = f_format_date(ls_cash_date, "mmddyyyy") //Alex Gerlants. 05/30/2018
							
							//dw_coil_list.SetItem(li_row, "CASH_DATE", dw_coil_list_edi.GetItemString(i, "INBOUND_COIL_CASH_DATE"))
							dw_coil_list.SetItem(li_row, "CASH_DATE", ls_cash_date) //Alex Gerlants. 05/30/2018
						next
				end if						
				END IF
			NEXT			
		END IF
	NEXT	
	
	MessageBox("Search Result", "BOL matched found in BOL list.")
	return 1
end if
return 1
end event

event type integer ue_newcoilnum();Long ll_coil_abc_num
Int li_rc, li_cur_row

li_rc = MessageBox("Confirmation", "Do you want to get a new COIL ABC NUMBER for this coil?", Question!, YesNo!)
if li_rc = 1 then
	ll_coil_abc_num = f_get_next_value("coil_abc_num_seq")
	
	//li_cur_row = dw_coil_list.GetRow() //Alex Gerlants. Coil Quality. Comment out
	li_cur_row = dw_coil_list.GetSelectedRow(0) //Alex Gerlants. Coil Quality
	
	dw_coil_list.SetItem(li_cur_row, "COIL_ABC_NUM", ll_coil_abc_num )
	dw_coil_list.AcceptText()
end if

return 1
end event

event type long ue_print_label_to_handheld(long al_coil_abc_num);string httprequest,ls_header
String ls_url,ls_headers
long ll_rc
long ll_length
Blob lblb_args
inet linet
n_ir lir_data	//n_ir  internet request object


linet = CREATE inet

lir_data = CREATE n_ir

ls_url = "http://db02new.albl.com/cgi-bin/coil_receiving.pl?"
lblb_args = blob("print_label_for_coil_abc_num=" + string(al_coil_abc_num))
ll_length = Len(lblb_args)
ls_headers = "Content-Type: " + &
       "application/x-www-form-urlencoded~n" + &
       "Content-Length: " + String( ll_length ) + "~n~n"
ll_rc = linet.PostURL(ls_url,lblb_args,ls_headers,80,lir_data)

return ll_rc
end event

event type integer ue_send861();Int li_rc,li_row, li_coil_count, li_i, li_j
Long ll_edi_file_id, ll_row_bol
String ls_bol, ls_coil_orig_num
Date ld_received_date

//Alex Gerlants. 07/26/2017. Begin
Long			ll_customer_id, ll_coil_count
Long			ll_selected_row, ll_rows, ll_row, ll_found_row, ll_damage_code, ll_damage_fault
String		ls_coil_number, ls_coil_numbers_string, ls_empty[], ls_coil_numbers[]
String		ls_find_string

String		ls_customer_short_name

ll_selected_row = dw_coil_list.GetSelectedRow(0)

If ll_selected_row > 0 Then
	li_row = dw_incomingedi.GetRow()

	If li_row > 0 Then
		ll_edi_file_id = dw_coil_list.Object.inbound_coil_edi_file_id[ll_selected_row]
		ls_bol = dw_incomingedi.Object.bol[li_row]
		
		//Count and collect all coil_number's in dw_coil_list for this ll_edi_file_id
		ll_coil_count = 0
		ls_coil_numbers[] = ls_empty[]
		ls_coil_numbers_string = ""
		
		For ll_row = 1 To dw_coil_list.RowCount()
			If dw_coil_list.Object.inbound_coil_edi_file_id[ll_row] = ll_edi_file_id Then
				ls_coil_number = dw_coil_list.Object.coil_org_num[ll_row]
				ll_coil_count++
				ls_coil_numbers[UpperBound(ls_coil_numbers[]) + 1] = ls_coil_number
				ls_coil_numbers_string = ls_coil_numbers_string + ls_coil_number + ", "
			End If
		Next
		
		If ls_coil_numbers_string <> "" Then
			//Remove the last comma
			ls_coil_numbers_string = Left(ls_coil_numbers_string, Len(ls_coil_numbers_string) - 2)
			
			li_rc = MessageBox("Confirmation", "Are you sure you want to send 861 and remove EDI " + String(ll_edi_file_id) + &
								". BOL: " + ls_bol + &
								" (Coils: " + ls_coil_numbers_string + ")" + " without importing data?", Question!, YesNo!)

			if li_rc = 2 then
				RETURN 0
			end if
		End If
	Else
		Return 0
	End If
Else //No row selected
	MessageBox("Nothing selected", "Please select a coil from edi you want to archive", Information!)
	Return 0
End If
//Alex Gerlants. 07/26/2017. End

li_row = dw_incomingedi.GetRow()

if li_row > 0 then
	//ll_edi_file_id = dw_incomingedi.GetItemNumber(li_row, "edi_file_id")//Alex Gerlants. 07/26/2017. Comment out
	ls_bol = dw_incomingedi.GetItemString(li_row, "bol")
		
	//check received_date
   ld_received_date = Date(em_receiveddate.text)
		
	UPDATE INBOUND_SHIPMENT_STATUS  
	SET STATUS = 3, RECEIVED_TIME = :ld_received_date
	WHERE INBOUND_SHIPMENT_STATUS.BOL = :ls_bol and INBOUND_SHIPMENT_STATUS.EDI_FILE_ID = :ll_edi_file_id
	USING SQLCA;

	IF SQLCA.SQLCode = -1 THEN 
		//MessageBox("SQL error", SQLCA.SQLErrText) //Alex Gerlants. 07/26/2017. Comment out
		//ROLLBACK USING SQLCA; //Alex Gerlants. 07/26/2017. Comment out
		MessageBox("Error", "Cannot update inbound_shipment_status." + &
									"~n~r~n~rSQL error:~n~r" + SQLCA.SQLErrText, StopSign!)
		li_rc = -1
		GoTo CONT
	END IF
		
	//li_coil_count = dw_coil_list.RowCount() //Alex Gerlants. 07/26/2017. Comment out
	li_coil_count = UpperBound(ls_coil_numbers[]) //Alex Gerlants. 07/26/2017
	
	IF li_coil_count > 0 THEN
		li_rc = 1
		
	  for li_i = 1 to li_coil_count
			//ls_coil_orig_num = dw_coil_list.GetItemString(li_i, "coil_org_num") //Alex Gerlants. 07/26/2017. Comment out
			ls_coil_orig_num = ls_coil_numbers[li_i] //Alex Gerlants. 07/26/2017
			
			ls_find_string = "inbound_coil_edi_file_id = " + String(ll_edi_file_id) + " and coil_org_num = '" + ls_coil_orig_num + "'"
			ll_found_row = dw_coil_list.Find(ls_find_string, 1, dw_coil_list.RowCount())
			
			If ll_found_row > 0 Then
				ll_damage_code = dw_coil_list.GetItemNumber(ll_found_row, "damaged_code")
				ll_damage_fault = dw_coil_list.GetItemNumber(ll_found_row, "damaged_fault")
				
				UPDATE INBOUND_COIL_STATUS
				SET DAMAGED_CODE = :ll_damage_code, DAMAGED_FAULT = :ll_damage_fault, STATUS = 1
				WHERE INBOUND_COIL_STATUS.BOL = :ls_bol and INBOUND_COIL_STATUS.COIL_NUMBER = :ls_coil_orig_num and INBOUND_COIL_STATUS.EDI_FILE_ID = :ll_edi_file_id
				USING SQLCA;
			
				IF SQLCA.SQLCode = -1 THEN 
					//MessageBox("SQL error", SQLCA.SQLErrText) //Alex Gerlants. 07/26/2017. Comment out
					//ROLLBACK USING SQLCA; //Alex Gerlants. 07/26/2017. Comment out
					MessageBox("Error", "Cannot update inbound_coil_status." + &
												"~n~r~n~rSQL error:~n~r" + SQLCA.SQLErrText, StopSign!)
					li_rc = -1
					GoTo CONT
				END IF
			End If
	  next
	END IF
	
	CONT: //Alex Gerlants. 07/26/2017
	
	If li_rc = 1 Then //OK. //Alex Gerlants. 07/26/2017
	//Alex Gerlants. 07/26/2017. End
		commit using SQLCA;
		
		ls_customer_short_name = f_get_customer_name(il_cust, sqlca)
		
		//If Pos(Lower(ls_customer_short_name), "novelis") > 0 Then
		//If il_cust <> 2784 Then //Alex Gerlants. 05/30/2019. Arconic 861. All customers except for Arconic-TN
			transaction dboconnect
			dboconnect = create transaction
			dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
			dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
			dboconnect.LogID = gs_LogID
			dboconnect.LogPass = gs_LogPass
			connect using dboconnect;
			if dboconnect.SQLCode<0 then 
				MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
			 return -1
			end if
	
			DECLARE p_edi procedure for f_edi_861_for_all using dboconnect;
			execute p_edi;
			if dboconnect.SQLCode <> 0 then 
				MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
			else
				Messagebox("Templar EDI 861","EDI 861 generated successfully")
			end if
	
	
			disconnect using dboconnect;
	
			destroy dboconnect;
		//Else //Alex Gerlants. 05/30/2019. Arconic 861. All customers except for Novelis
			//wf_create_861_4arconic() //Alex Gerlants. 05/30/2019. Arconic 861
			wf_create_861_4customer(il_cust, ls_bol)	//Alex Gerlants. 05/30/2019. Arconic 861. 
														//customer_id IF statement is in wf_create_861_4customer()
		//End If //Alex Gerlants. 05/30/2019. Arconic 861
		
		//	ls_sql = "dbo.p_create_edi_861_for_all"
		//	EXECUTE IMMEDIATE :ls_sql USING SQLCA;
		
		wf_populate_dw_coil_list(ls_bol)
	Else //Alex Gerlants. 07/26/2017
		rollback using sqlca; //Alex Gerlants. 07/26/2017
	End If //Alex Gerlants. 07/26/2017
	
	//dw_coil_list.ResetUpdate() //Alex Gerlants. 08/08/2017. Comment out
	dw_bol.Retrieve(il_cust)
	dw_incomingedi.Retrieve(il_cust)
	//of_bollist //Alex Gerlants. 07/26/2017. Comment out)
	
	If dw_coil_list.RowCount() > 0 Then //Alex Gerlants. 07/26/2017
		wf_highlight_incoming_edi(ls_bol) //Alex Gerlants. 07/26/2017
	End If //Alex Gerlants. 07/26/2017
end if

RETURN 1
end event

event type integer ue_delete();RETURN 1
end event

event type integer ue_deleteedi();Int li_rc,li_row, li_coil_count, li_i, li_j
Long ll_edi_file_id, ll_row_bol
String ls_bol, ls_coil_orig_num

//Alex Gerlants. 07/26/2017. Begin
Long			ll_customer_id, ll_coil_count
Long			ll_selected_row, ll_rows, ll_row
String		ls_coil_number, ls_coil_numbers_string, ls_empty[], ls_coil_numbers[]

ll_selected_row = dw_coil_list.GetSelectedRow(0)

If ll_selected_row > 0 Then
	li_row = dw_incomingedi.GetRow()

	If li_row > 0 Then
		ll_edi_file_id = dw_coil_list.Object.inbound_coil_edi_file_id[ll_selected_row]
		ls_bol = dw_incomingedi.Object.bol[li_row]
		
		//Count and collect all coil_number's in dw_coil_list for this ll_edi_file_id
		ll_coil_count = 0
		ls_coil_numbers[] = ls_empty[]
		ls_coil_numbers_string = ""
		
		For ll_row = 1 To dw_coil_list.RowCount()
			If dw_coil_list.Object.inbound_coil_edi_file_id[ll_row] = ll_edi_file_id Then
				ls_coil_number = dw_coil_list.Object.coil_org_num[ll_row]
				ll_coil_count++
				ls_coil_numbers[UpperBound(ls_coil_numbers[]) + 1] = ls_coil_number
				ls_coil_numbers_string = ls_coil_numbers_string + ls_coil_number + ", "
			End If
		Next
		
		If ls_coil_numbers_string <> "" Then
			//Remove the last comma
			ls_coil_numbers_string = Left(ls_coil_numbers_string, Len(ls_coil_numbers_string) - 2)
			
			li_rc = MessageBox("Confirmation", "Are you sure you want to remove EDI " + String(ll_edi_file_id) + &
								". BOL: " + ls_bol + &
								" (Coils: " + ls_coil_numbers_string + ")" + " without importing data?", Question!, YesNo!)

			if li_rc = 2 then
				RETURN 0
			end if
		End If
	Else
		Return 0
	End If
Else //No row selected
	MessageBox("Nothing selected", "Please select a coil from edi you want to archive", Information!)
	Return 0
End If
//Alex Gerlants. 07/26/2017. End

li_row = dw_incomingedi.GetRow()

if li_row > 0 then
	//ll_edi_file_id = dw_incomingedi.GetItemNumber(li_row, "edi_file_id")//Alex Gerlants. 07/26/2017. Comment out
	ls_bol = dw_incomingedi.GetItemString(li_row, "bol")
		
	UPDATE INBOUND_SHIPMENT_STATUS  
	SET STATUS = 1 
	WHERE INBOUND_SHIPMENT_STATUS.BOL = :ls_bol and INBOUND_SHIPMENT_STATUS.EDI_FILE_ID = :ll_edi_file_id
	USING SQLCA;

	IF SQLCA.SQLCode = -1 THEN 
		//MessageBox("SQL error", SQLCA.SQLErrText) //Alex Gerlants. 07/26/2017. Comment out
		//ROLLBACK USING SQLCA; //Alex Gerlants. 07/26/2017. Comment out
		MessageBox("Error", "Cannot update inbound_shipment_status." + &
									"~n~r~n~rSQL error:~n~r" + SQLCA.SQLErrText, StopSign!)
		li_rc = -1
		GoTo CONT
	END IF
		
	//li_coil_count = dw_coil_list.RowCount() //Alex Gerlants. 07/26/2017. Comment out
	li_coil_count = UpperBound(ls_coil_numbers[]) //Alex Gerlants. 07/26/2017
	
	IF li_coil_count > 0 THEN
		li_rc = 1
		
	  for li_i = 1 to li_coil_count
			//ls_coil_orig_num = dw_coil_list.GetItemString(li_i, "coil_org_num") //Alex Gerlants. 07/26/2017. Comment out
			ls_coil_orig_num = ls_coil_numbers[li_i] //Alex Gerlants. 07/26/2017
			
			UPDATE INBOUND_COIL_STATUS
			SET STATUS = 1
			WHERE INBOUND_COIL_STATUS.BOL = :ls_bol and INBOUND_COIL_STATUS.COIL_NUMBER = :ls_coil_orig_num and INBOUND_COIL_STATUS.EDI_FILE_ID = :ll_edi_file_id
			USING SQLCA;
		
			IF SQLCA.SQLCode = -1 THEN 
				//MessageBox("SQL error", SQLCA.SQLErrText) //Alex Gerlants. 07/26/2017. Comment out
				//ROLLBACK USING SQLCA; //Alex Gerlants. 07/26/2017. Comment out
				MessageBox("Error", "Cannot update inbound_coil_status." + &
											"~n~r~n~rSQL error:~n~r" + SQLCA.SQLErrText, StopSign!)
				li_rc = -1
				GoTo CONT
			END IF
	  next
	END IF
	
	CONT: //Alex Gerlants. 07/26/2017
	
	If li_rc = 1 Then //OK. //Alex Gerlants. 07/26/2017
	//Alex Gerlants. 07/26/2017. End
		commit using SQLCA;
		wf_populate_dw_coil_list(ls_bol)
	Else //Alex Gerlants. 07/26/2017
		rollback using sqlca; //Alex Gerlants. 07/26/2017
	End If //Alex Gerlants. 07/26/2017
	
	//dw_coil_list.ResetUpdate() //Alex Gerlants. 08/08/2017. Comment out
	dw_bol.Retrieve(il_cust)
	dw_incomingedi.Retrieve(il_cust)
	//of_bollist //Alex Gerlants. 07/26/2017. Comment out)
	
	If dw_coil_list.RowCount() > 0 Then //Alex Gerlants. 07/26/2017
		wf_highlight_incoming_edi(ls_bol) //Alex Gerlants. 07/26/2017
	End If //Alex Gerlants. 07/26/2017
end if //if li_row > 0 then (li_row = dw_incomingedi.GetRow())

RETURN 1
end event

public function integer of_bollist ();//Give warning if there is data not saved yet.
Int li_rc
li_rc = of_check_updatespending()
if li_rc = 0 then
	return 0	
end if

sle_bol.event ue_closetoinput()
em_receiveddate.event closetoinput()
dw_incomingedi.SelectRow(0, false)
dw_coil_list.DataObject = 'd_coil_list_by_bol_archived'
dw_coil_list.SetTransObject(SQLCA)
//cb_create.Enabled = false
cb_savebol.Enabled = false
cb_send861.Enabled = false
cb_delete.Enabled = false
cb_print.Enabled = true
cb_addcoil.Enabled = false
cb_deletecoil.Enabled = false
dw_bol.event GetFocus()

return 1
end function

public function integer of_incomingedi ();//Give warning if there is data not saved yet.
Int li_rc
li_rc = of_check_updatespending()
if li_rc = 0 then
	return 0	
end if

sle_bol.event ue_closetoinput()
em_receiveddate.event opentoinput()
dw_bol.SelectRow(0, false)
dw_coil_list.DataObject = 'd_coil_list_by_bol_add'
dw_coil_list.SetTransObject(SQLCA)
//cb_create.Enabled = true
cb_savebol.Enabled = true
cb_send861.Enabled = true
cb_delete.Enabled = true
cb_print.Enabled = false
cb_addcoil.Enabled = true
cb_deletecoil.Enabled = true
dw_incomingedi.event GetFocus()

return 1
end function

public function integer of_newbol ();//Give warning if there is data not saved yet.
Int li_rc
li_rc = of_check_updatespending()
if li_rc = 0 then
	return 0	
end if

sle_bol.event ue_opentoinput()
em_receiveddate.event opentoinput()
sle_bol.text = ""
em_receiveddate.text = String(Today())
dw_incomingedi.SelectRow(0, false)
dw_bol.SelectRow(0, false)
dw_coil_list.DataObject = 'd_coil_list_by_bol_add'
dw_coil_list.SetTransObject(SQLCA)
//cb_create.Enabled = true
cb_savebol.Enabled = true
cb_send861.Enabled = FALSE
cb_delete.Enabled = FALSE
cb_print.Enabled = false
cb_addcoil.Enabled = true
cb_deletecoil.Enabled = true
sle_bol.SetFocus() //Alex Gerlants. 02/09/2017
//sle_bol.event GetFocus() //Alex Gerlants. 02/09/2017

return 1
end function

public function integer of_check_updatespending ();//check if there is updates pending in dw_coil_list, then give warning message
//if return 0, cancel the next step

Int li_rc, li_answer

dw_coil_list.AcceptText()
li_rc = dw_coil_list.of_UpdatesPending()
if li_rc = 1 then
	li_answer = MessageBox("Data Modified", "Do you want to save the current BOL and its coil data?", Question!, YesNoCancel!)
	choose case li_answer
	case 1
		//this.event ue_savebol()
		
		//Alex Gerlants. 03/27/2017 Begin
		li_rc = cb_savebol.Event Clicked()
		
		If li_rc = -1 Then
			Return 0 //Don't close this window
		Else
			Return 1 //Close this window
		End If
		//Alex Gerlants. 03/27/2017. End
		//return 1
	case 2
		return 1
	case 3
		return 0	
	end choose

end if

return 1

end function

public subroutine wf_retrieve_mill_source_dddw ();//Alex Gerlants. 02/09/2017. Begin
/*
Function:	wf_retrieve_mill_source_dddw
Returns:		none
Arguments:	none
*/

DataWindowChild 	ldwc
Integer				li_rtn
Long					ll_rows, ll_inserted_row, ll_null
String				ls_null

li_rtn = dw_coil_list.GetChild("coil_from_cust_id", ldwc)

If li_rtn = 1 Then
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
	
	ll_inserted_row = ldwc.InsertRow(1)

	If ll_inserted_row > 0 Then
		SetNull(ll_null)
		SetNull(ls_null)
		
		ldwc.SetItem(ll_inserted_row, "customer_id", ll_null)
		ldwc.SetItem(ll_inserted_row, "customer_short_name", ls_null)
	End If
End If
//Alex Gerlants. 02/09/2017. End
end subroutine

public subroutine wf_get_mill_source_from_coil (ref datawindow adw);//Alex Gerlants. 02/09/2017. Begin
/*
Function:	wf_get_mill_source_from_coil
Returns:		none
Arguments:	reference	datawindow	adw
*/

Long	ll_rows, ll_row
Long	ll_coil_abc_num, ll_coil_from_cust_id

ll_rows = adw.RowCount()

For ll_row = 1 To ll_rows
	ll_coil_abc_num = adw.Object.coil_abc_num[ll_row]
	
	select	coil_from_cust_id
	into		:ll_coil_from_cust_id
	from		coil
	where		coil_abc_num = :ll_coil_abc_num
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then //OK
		adw.Object.coil_from_cust_id[ll_row] = ll_coil_from_cust_id
		adw.SetItemStatus(ll_row, 0, Primary!, NotModified!) //So it will not ask to save again
	End if
Next
//Alex Gerlants. 02/09/2017. End
end subroutine

public subroutine wf_populate_dw_coil_list (string as_bol);//Alex Gerlants. 07/26/2017. Begin
/*
Function:	wf_populate_dw_coil_list
Returns:		none
Arguments:	value	string	as_bol
*/

Long		li_rowcount, i, ll_edi_file_id, ll_found_row
Integer	li_row
String	ls_find_string

//populate dw_coil_list
dw_coil_list.Reset()
dw_coil_list_edi.SetTransObject(sqlca)
li_rowcount = dw_coil_list_edi.Retrieve(as_bol)
//li_rowcount = dw_coil_list_edi.RowCount()

if li_rowcount > 0 then
		for i = 1 to li_rowcount
			ll_edi_file_id = dw_coil_list_edi.Object.inbound_coil_edi_file_id[i] //Alex Gerlants. 07/26/2017
			
			li_row = dw_coil_list.InsertRow(0)
			
			If li_row > 0 Then //Alex Gerlants. 07/26/2017
				dw_coil_list.Object.inbound_coil_edi_file_id[li_row] = dw_coil_list_edi.Object.inbound_coil_edi_file_id[i] //Alex Gerlants. 07/26/2017
				dw_coil_list.SetItem(li_row, "COIL_ABC_NUM", dw_coil_list_edi.GetItemNumber(i, "INBOUND_COIL_STATUS_COIL_ABC_NUM") )
				dw_coil_list.SetItem(li_row, "COIL_ORG_NUM", dw_coil_list_edi.GetItemString(i, "COIL_NUMBER") )
				dw_coil_list.SetItem(li_row, "DAMAGED_FAULT", 0)	//0: "No Damaged"
				dw_coil_list.SetItem(li_row, "DAMAGED_CODE", 0)	//0: "No Damaged"
				dw_coil_list.SetItem(li_row, "TEMPER", dw_coil_list_edi.GetItemString(i, "TEMPER"))
				dw_coil_list.SetItem(li_row, "NET_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "NET_WEIGHT"))
				dw_coil_list.SetItem(li_row, "GROSS_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "GROSS_WEIGHT"))
				dw_coil_list.SetItem(li_row, "COIL_GAUGE", dw_coil_list_edi.GetItemNumber(i, "COIL_GAUGE"))
				dw_coil_list.SetItem(li_row, "DENSITY", dw_coil_list_edi.GetItemNumber(i, "DENSITY"))
				dw_coil_list.SetItem(li_row, "LOT", dw_coil_list_edi.GetItemString(i, "LOT"))
				dw_coil_list.SetItem(li_row, "PACK_ID", dw_coil_list_edi.GetItemString(i, "PACK_ID"))
				dw_coil_list.SetItem(li_row, "ALLOY", dw_coil_list_edi.GetItemString(i, "ALLOY"))
				dw_coil_list.SetItem(li_row, "LINEAL_FEED", dw_coil_list_edi.GetItemNumber(i, "LINEAL_FEED"))
				dw_coil_list.SetItem(li_row, "COIL_WIDTH", dw_coil_list_edi.GetItemNumber(i, "COIL_WIDTH"))
				dw_coil_list.SetItem(li_row, "PART_NUM", dw_coil_list_edi.GetItemString(i, "inbound_shipment_part_number"))
				dw_coil_list.SetItem(li_row, "SUPPLIER_SALES_NUM", dw_coil_list_edi.GetItemString(i, "inbound_shipment_vo"))
				dw_coil_list.SetItem(li_row, "PURCHASE_ORDER_NUM", dw_coil_list_edi.GetItemString(i, "inbound_shipment_po"))
				dw_coil_list.SetItem(li_row, "consumed_coil_num", dw_coil_list_edi.GetItemString(i, "inbound_coil_consumed_coil_num"))
				dw_coil_list.SetItem(li_row, "material_num", dw_coil_list_edi.GetItemString(i, "inbound_coil_material_num"))
				dw_coil_list.SetItem(li_row, "cash_date", dw_coil_list_edi.GetItemString(i, "inbound_coil_cash_date"))
			End if //Alex Gerlants. 07/26/2017		
	next
end if
//Alex Gerlants. 07/26/2017. End		
end subroutine

public subroutine wf_highlight_incoming_edi (string as_bol);//Alex Gerlants. 07/26/2017. Begin
/*
Function:	wf_highlight_incoming_edi
Returns:		none
Arguments:	value	string as_bol
*/

String	ls_find_string
long		ll_found_row

//HighLight bol in dw_incomingedi
dw_incomingedi.SelectRow(0, False) //Unselect all rows
ls_find_string = "bol = '" + as_bol + "'"

ll_found_row = dw_incomingedi.Find(ls_find_string, 1, dw_incomingedi.RowCount())

If ll_found_row > 0 Then
	dw_incomingedi.SelectRow(ll_found_row, True)
End If


//Alex Gerlants. 07/26/2017. End
end subroutine

public function boolean wf_coil_abc_num_exists_on_db (long al_coil_abc_num);//Alex Gerlants. 08/08/2017. Begin
/*
Function:	wf_coil_abc_num_exists_on_db
Returns:		boolean	<== True	 if al_coil_abc_num exists on database
								 False if al_coil_abc_num does not exist on database
Arguments:	value	long	al_coil_abc_num								 
*/
Boolean	lb_coil_abc_num_exists_on_db = False
Long		ll_count

select	count(*)
into		:ll_count
from		coil
where		coil_abc_num = :al_coil_abc_num
using		sqlca;

If sqlca.sqlcode <> 0 Then //DB error
	ll_count = 0
End If

If ll_count > 0 Then lb_coil_abc_num_exists_on_db = True

Return lb_coil_abc_num_exists_on_db
//Alex Gerlants. 08/08/2017. End
end function

public function boolean wf_coil_abc_num_duplicate (long al_coil_abc_num);//Alex Gerlants. 08/08/2017. Begin
/*
Function:	wf_coil_abc_num_duplicate
Returns:		boolean	<== True	 if al_coil_abc_num exists on database
								 False if al_coil_abc_num does not exist on database
Arguments:	value	long	al_coil_abc_num								 
*/
Boolean	lb_coil_abc_num__duplicate = False
String	ls_find_string
Long		ll_start_row, ll_found_row, ll_count

//
ls_find_string = "coil_abc_num = " + String(al_coil_abc_num)
ll_start_row = 1
ll_found_row = dw_coil_list.Find(ls_find_string, ll_start_row, dw_coil_list.RowCount())

If ll_found_row > 0 Then ll_count = 1

Do While ll_found_row > 0
	ll_start_row = ll_found_row + 1
	
	If ll_start_row <= dw_coil_list.RowCount() Then
		ll_found_row = dw_coil_list.Find(ls_find_string, ll_start_row, dw_coil_list.RowCount())
		
		If ll_found_row > 0 Then ll_count++
	Else
		ll_found_row = 0 //Quit the loop
	End If
Loop

If ll_count > 1 Then lb_coil_abc_num__duplicate = True

Return lb_coil_abc_num__duplicate
//Alex Gerlants. 08/08/2017. End
end function

public function boolean wf_ff_data_exists (string as_bol);//Alex Gerlants. Coil Quality. Begin
/*
Function:	wf_ff_data_exists
Returns:		boolean	<==	True  if FF data exist in table inbound_coil_status
									False if FF data do not exist in table inbound_coil_status
Arguments:	value	string	as_bol
*/

Integer	ll_ff_count
Boolean	lb_rtn

select   count(*)
into   	:ll_ff_count
from     inbound_coil_status
where    bol = :as_bol
and		length(nvl(barcode_string, '')) > 0
using		sqlca;

If sqlca.sqlcode <> 0 Then
	ll_ff_count = 0
End If

If ll_ff_count > 0 Then
	lb_rtn = True
Else
	lb_rtn = False
End If

Return lb_rtn
//Alex Gerlants. Coil Quality. End
end function

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
String	ls_less_than_required_error, ls_good_coil_string

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
Integer	li_rtn = 1
Blob		lbl_barcode_string
String	ls_revision_level, ls_length_less_than_required, ls_unknown_revision_level, ls_start_end_pos_error
String	ls_error_message
Long		ll_unknown_revision_level, ll_start_end_pos_error


dw_coil_quality.SetTransObject(sqlca)
dw_coil_quality_flaw_mapping.SetTransObject(sqlca)

For ll_i = 1 To UpperBound(al_coil_abc_number[])
	lb_error = False //Fix 03/12/2018
	
	ll_edi_file_id = al_edi_file_id[ll_i]
	ll_coil_abc_num = al_coil_abc_number[ll_i]
	ls_coil_org_number_arg = Trim(as_coil_org_num[ll_i])
		
	select	count(*) 
	into		:li_coil_processed_count
	from 		dbo.coil_quality
	where 	coil_abc_num = :ll_coil_abc_num
	using		sqlca;
	
	If sqlca.sqlcode = 0 Then //OK
		If li_coil_processed_count > 0 Then Continue //This coil's QR code has already been processed
	Else //Db error
		li_rtn = -1
		
		MessageBox("Database Error", "Database Error occurred in wf_coil_quality for w_coil_receiving while getting data from table coil_quality" + &
										"~n~rError:~n~r" + sqlca.sqlerrtext + &
										"~n~r~n~rHowever, the main coil processing will continue.", Exclamation!)
		
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
		
		If ls_barcode_string = "" Then //Row not found. EDI data are not available; or EDI data are available, but barcode_string is not there
			//Try to get it from table barcode_string
			select	barcode_string
			into	 	:ls_barcode_string
			from		dbo.barcode_string
			where		coil_org_num = :ls_coil_org_number_arg
			using		sqlca;
			
			Choose Case sqlca.sqlcode
				Case 0
					If IsNull(ls_barcode_string) Then ls_barcode_string = ""
					
					If ls_barcode_string = "" Then
						ls_less_than_required_error = ls_less_than_required_error + String( ll_coil_abc_num) + ", "
						ll_less_than_required_count++
						lb_error = True //Fix 03/12/2018
						Continue //Go to the next coil
					End If
				Case 100
					ls_less_than_required_error = ls_less_than_required_error + String( ll_coil_abc_num) + ", "
					ll_less_than_required_count++
					lb_error = True //Fix 03/12/2018
					Continue //Go to the next coil
				Case Else //DB error
					li_rtn = -1
		
					MessageBox("Database Error", "Database Error occurred in wf_coil_quality for w_coil_receiving while getting data from table barcode_string" + &
													"~n~rError:~n~r" + sqlca.sqlerrtext + &
													"~n~r~n~rHowever, the main coil processing will continue.", Exclamation!)
					
					Exit
			End Choose
		End If
	Else
		li_rtn = -1
		
		MessageBox("Database Error", "Database Error occurred in wf_coil_quality for w_coil_receiving while getting data from table inbound_coil_status" + &
										"~n~rError:~n~r" + sqlca.sqlerrtext + &
										"~n~r~n~rHowever, the main coil processing will continue.", Exclamation!)
		
		Exit
	End if
	
	//----------------------------------------------------------------------------------------------------------
	
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
					li_rtn = f_coil_quality_03(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping, ls_start_end_pos_error)
					
					If li_rtn = 1 Then //OK. No errors
						ls_good_coil_string = ls_good_coil_string + String(ll_coil_abc_num) + ", "
						ll_good_coil_count++
					Else //Starting, ending position error
						ll_start_end_pos_error++
						
						//Delete all rows for this coil from dw_coil_quality and dw_coil_quality_flaw_mapping
						wf_delete_error_rows(ll_coil_abc_num)
					End If
				Else //Barcode string should not be shorter than 72 characters
					ls_less_than_required_error = ls_less_than_required_error + String( ll_coil_abc_num) + ", "
					ll_less_than_required_count++
					Continue //Go to the next coil
				End If
			Case "04"
				If ll_length >= 72 Then //Good
					li_rtn = f_coil_quality_04(ls_barcode_string, ll_coil_abc_num, dw_coil_quality, dw_coil_quality_flaw_mapping, ls_start_end_pos_error)
					
					If li_rtn = 1 Then //OK. No errors
						ls_good_coil_string = ls_good_coil_string + String(ll_coil_abc_num) + ", "
						ll_good_coil_count++
					Else //Starting, ending position error
						ll_start_end_pos_error++
						
						//Delete all rows for this coil from dw_coil_quality and dw_coil_quality_flaw_mapping
						wf_delete_error_rows(ll_coil_abc_num)
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
	
	//Fix 03/12/2018. Begin
	If Not lb_error Then
		//For each coil in BOL, update and commit if update OK
		is_sqlerrtext = ""

		li_rtn = dw_coil_quality.Update()
		
		If li_rtn = 1 Then //OK
			li_rtn = dw_coil_quality_flaw_mapping.Update()
		
			If li_rtn = 1 Then //OK
				commit using sqlca;
			Else //DB Error
				li_rtn = -1
				rollback using sqlca;
				
				MessageBox("DB Error", "Coil: " + ls_coil_org_number_arg + &
										"~n~r~n~rDatabase error occurred in wf_coil_quality for w_coil_receiving " + &
										"while saving QR barcode data to table coil_quality_flaw_mapping." + &
										"~n~rError:~n~r" + is_sqlerrtext + &
										"~n~r~n~rExiting quality barcode processing" + &
										"~n~rHowever, the main coil processing will continue.", Exclamation!)
			End If
		Else //DB Error
			li_rtn = -1
			rollback using sqlca;
			
			MessageBox("DB Error", "Coil: " + ls_coil_org_number_arg + &
									"~n~r~n~rDatabase error occurred in wf_coil_quality for w_coil_receiving " + &
									"while saving QR barcode data to table coil_quality." + &
									"~n~rError:~n~r" + is_sqlerrtext + &
									"~n~r~n~rExiting quality barcode processing" + &
									"~n~rHowever, the main coil processing will continue.", Exclamation!)
									
			is_sqlerrtext = ""
		End If
	End If
	
	dw_coil_quality.Reset()
	dw_coil_quality_flaw_mapping.Reset()
	//Fix 03/12/2018. End
Next

If ll_less_than_required_count > 0 Then //Some barcode strings have less than required. This is invalid
	//Remove the last comma
	ls_less_than_required_error = Left(ls_less_than_required_error, Len(ls_less_than_required_error) - 2)

	If ll_less_than_required_count = UpperBound(as_coil_org_num[]) Then //All coils have barcode strings that are less than required or not available
		ls_error_message = "Error in wf_coil_quality for w_coil_receiving.~n~rAll coils have Quality barcode string lengths that are less than required or not available.~n~rNo quality barcode will be processed."
	Else
		ls_error_message = "Error in wf_coil_quality for w_coil_receiving.~n~rThe following coils have Quality barcode string lengths that are less than required or not available:~n~r" + ls_less_than_required_error
	End If
End If

If ll_unknown_revision_level > 0 Then
	//Remove the last comma
	ls_unknown_revision_level = Left(ls_unknown_revision_level, Len(ls_unknown_revision_level) - 2)
	
	If ll_unknown_revision_level = UpperBound(as_coil_org_num[]) Then //All coils have barcode strings that have unknown revision level
		ls_error_message = ls_error_message + "~n~rError in wf_coil_quality for w_coil_receiving.~n~rAll coils Quality barcode strings that have unknown revision level."
	Else
		ls_error_message = ls_error_message + "~n~rError in wf_coil_quality for w_coil_receiving.~n~rThe following coils have Quality barcode strings that have unknown revision level:~n~r" + ls_unknown_revision_level
	End If
End If

If ll_start_end_pos_error > 0 Then
	If ll_start_end_pos_error = UpperBound(as_coil_org_num[]) Then //All coils have barcode strings that have starting, ending position errors
		ls_error_message = ls_error_message + "~n~rError in wf_coil_quality for w_coil_receiving.~n~rAll coils Quality barcode strings that have starting, ending position error.~n~r" + ls_start_end_pos_error
	Else
		ls_error_message = ls_error_message + "~n~rError in wf_coil_quality for w_coil_receiving.~n~rThe following coils have Quality barcode strings that have have starting, ending position error:~n~r" + ls_start_end_pos_error
	End If
End If

If ll_less_than_required_count > 0 Or ll_unknown_revision_level > 0 Or ll_start_end_pos_error > 0 Then
	If ll_less_than_required_count = UpperBound(al_coil_abc_number[]) Or ll_unknown_revision_level = UpperBound(al_coil_abc_number[]) Then
		//All coils in al_coil_abc_number[] have problems. Do not save QR data.
		li_rtn = -1
	End If
	
	If ll_good_coil_count > 0 Then
		ls_error_message = ls_error_message + "~n~rThe following coils have valid Quality barcode strings:~n~r" + ls_good_coil_string
	End If
	
	ls_error_message = ls_error_message + "~n~r~n~rHowever, the main coil processing will continue."
		
	MessageBox("Data Error", ls_error_message)
End If

//Fix 03/12/2018. Begin
//I am updating and commiting for each coil above, inside For-Next loop.

//dw_coil_quality.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
//dw_coil_quality_flaw_mapping.Print() //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

//If li_rtn = 1 Then //OK above
//	is_sqlerrtext = ""
//
//	li_rtn = dw_coil_quality.Update()
//	
//	If li_rtn = 1 Then //OK
//		li_rtn = dw_coil_quality_flaw_mapping.Update()
//	
//		If li_rtn = 1 Then //OK
//			commit using sqlca;
//		Else //DB Error
//			li_rtn = -1
//			rollback using sqlca;
//			
//			MessageBox("DB Error", "Database error occurred in wf_coil_quality for w_coil_receiving while saving QR barcode data to table coil_quality_flaw_mapping." + &
//									"~n~rError:~n~r" + is_sqlerrtext + &
//									"~n~r~n~rExiting quality barcode processing" + &
//									"r~n~rHowever, the main coil processing will not stop.", Exclamation!)
//		End If
//	Else //DB Error
//		li_rtn = -1
//		rollback using sqlca;
//		
//		MessageBox("DB Error", "Database error occurred in wf_coil_quality for w_coil_receiving while saving QR barcode data to table coil_quality." + &
//								"~n~rError:~n~r" + is_sqlerrtext + &
//								"~n~r~n~rExiting quality barcode processing" + &
//								"~n~rHowever, the main coil processing will not stop.", Exclamation!)
//								
//		is_sqlerrtext = ""
//	End If
//End If

//Empty the 2 work datawindows
dw_coil_quality.Reset()
dw_coil_quality_flaw_mapping.Reset()

//Fix 03/12/2018. End

Return li_rtn
//Alex Gerlants. Coil Quality. End
end function

public function integer wf_coil_quality_00 (string as_barcode_string, long al_coil_abc_num);/***************************************************************************************************************************

                                     This function is NOT used
						    It is replaced with external function f_coil_quality_00

***************************************************************************************************************************/

Integer	li_rtn = 1

////Alex Gerlants. Coil Quality. 02/06/2018.Begin
///*
//Function:	wf_coil_quality_00
//Returns;		integer	 1 if OK
//							-1 if DB error
//Arguments:	value			string	as_barcode_string
//				value			long		al_coil_abc_num
//*/
//
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

public subroutine wf_delete_error_rows (long al_coil_abc_num);//Alex Gerlants. Coil Quality. 02/06/2018. Begin
/*
Function:	wf_delete_error_rows
				Delete error rows from dw_coil_quality and dw_coil_quality_flaw_mapping with al_coil_abc_num
Returns:		none
Arguments:	value	long	al_coil_abc_num
*/

Long		ll_rows, ll_row, ll_found_row
String	ls_find_string

ll_rows = dw_coil_quality_flaw_mapping.RowCount()
ls_find_string = "coil_abc_num = " + String(al_coil_abc_num)

For ll_row = ll_rows To 1 Step -1
	ll_found_row = dw_coil_quality_flaw_mapping.Find(ls_find_string, 1, ll_rows)
	
	If ll_found_row > 0 Then
		dw_coil_quality_flaw_mapping.DeleteRow(ll_found_row)
	End If
Next

ll_rows = dw_coil_quality.RowCount()

For ll_row = ll_rows To 1 Step -1
	ll_found_row = dw_coil_quality.Find(ls_find_string, 1, ll_rows)
	
	If ll_found_row > 0 Then
		dw_coil_quality.DeleteRow(ll_found_row)
	End If
Next
//Alex Gerlants. Coil Quality. 02/06/2018. End
end subroutine

public function boolean wf_validate_cash_date (string as_cash_date);//Alex Gerlants. 08/22/2018. Force Cash Date. Begin
/*
Function:	wf_validate_cash_date
Returns:		boolean	True  if as_cash_date is a valid date
							False if as_cash_date is not a valid date
*/

String	ls_cash_date
Integer	li_month, li_day, li_year
Long		ll_cash_date
Boolean	lb_cash_date_valid = True

If IsNumber(as_cash_date) Then
	ll_cash_date = Long(as_cash_date)
	
	If ll_cash_date > 0 Then
		li_month = Integer(Left(as_cash_date, 2))
		li_day = Integer(Mid(as_cash_date, 3, 2))
		li_year = Integer(Right(as_cash_date, 4))
		
		If 	(li_month < 1 Or li_month > 12) &
			Or	(li_day < 1 Or li_day > 31) &
			Or	(li_year < 2000) Then
				lb_cash_date_valid = False
		End If
	Else //ll_cash_date <= 0
		lb_cash_date_valid = False
	End If
Else //as_cash_date is not a number
	lb_cash_date_valid = False
End if

If Not lb_cash_date_valid Then
	MessageBox("Cash Date invalid", "Valid cash dates required for all coils from this customer." + &
													"~n~rPlease enter valid cash dates (MM/DD/YYYY).", StopSign!)
End If													

Return lb_cash_date_valid
//Alex Gerlants. 08/22/2018. Force Cash Date. End
end function

public function boolean wf_all_alloys_exist ();//Alex Gerlants. 08/22/2018. Force Cash Date. Begin
/*
Function:	wf_all_alloys_exist
Returns:		boolean		True if all alloys from dw_coil_list exist in dw_alloy_heat_treatment
Arguments:	none
*/
Boolean	lb_all_alloys_exist = True
String	ls_find_string, ls_alloy
Long		ll_rows, ll_row, ll_found_row, ll_inserted_row

ll_rows = dw_coil_list.RowCount()

For ll_row = 1 To ll_rows
	ls_alloy = dw_coil_list.Object.alloy[ll_row]
	ls_find_string = "alloy = '" + ls_alloy + "'"
	ll_found_row = dw_alloy_heat_treatment.Find(ls_find_string, 1, dw_alloy_heat_treatment.RowCount())
	
	If ll_found_row <= 0 Then
		lb_all_alloys_exist = False
	End If
Next

Return lb_all_alloys_exist
//Alex Gerlants. 08/22/2018. Force Cash Date. End
end function

public function boolean wf_validate_cash_date_all ();//Alex Gerlants. 08/22/2018. Force Cash Date. Begin
/*
Function:	wf_validate_cash_date_all
Returns:		boolean		True if all cash_dates in dw_coil_list are populated with valid dates
Arguments:	none
*/
Boolean	lb_all_cash_dates_ok = True, lb_valid_temp
String	ll_find_string, ls_cash_date, ls_current_date, ls_month, ls_day, ls_year
String	ls_coil_org_num, ls_error_string, ls_find_string, ls_alloy, ls_heat_treated, ls_null
Integer	li_month, li_day, li_year, li_current_year
Long		ll_rows, ll_row, ll_found_row

ls_current_date = String(Today())
li_current_year = Integer(Right(ls_current_date, 4))
SetNull(ls_null)

ll_rows = dw_coil_list.RowCount()

For ll_row = 1 To ll_rows
	ls_coil_org_num = dw_coil_list.Object.coil_org_num[ll_row]
	ls_cash_date = dw_coil_list.Object.cash_date[ll_row]
	ls_alloy = dw_coil_list.Object.alloy[ll_row]
	
	ls_find_string = "alloy = '" + ls_alloy + "'"
	ll_found_row = dw_alloy_heat_treatment.Find(ls_find_string, 1, dw_alloy_heat_treatment.RowCount())
	
	If ll_found_row > 0 Then
		ls_heat_treated = Upper(dw_alloy_heat_treatment.Object.heat_treated[ll_found_row])
		If IsNull(ls_heat_treated) Then ls_heat_treated = "N"
		
		If ls_heat_treated <> "Y" Then //Cash date not required. Do not validate cash date
			dw_coil_list.Object.cash_date[ll_row] = ls_null
			Continue
		End If
	Else //ll_found_row is always > 0 because wf_all_alloys_exist() checks for this in wf_validate_cash_date()
		//
	End If
	
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
		lb_all_cash_dates_ok = False
		ls_error_string = ls_error_string + "Coil Org Num: " + ls_coil_org_num + "~n~r"
	End If
Next

If Not lb_all_cash_dates_ok Then
	MessageBox("Data input error", "Cash dates for the following coils are invalid. Please correct~n~r" + ls_error_string, StopSign!)
End If

Return lb_all_cash_dates_ok
//Alex Gerlants. 08/22/2018. Force Cash Date. End
end function

public function boolean wf_validate_cash_date_not_all ();//Alex Gerlants. 08/22/2018. Force Cash Date. Begin
/*
Function:	wf_validate_cash_date_not_all
Returns:		boolean		True if all cash_dates in dw_coil_list are populated with valid dates
Arguments:	none
*/
Boolean	lb_valid = True
String	ll_find_string, ls_cash_date, ls_current_date, ls_month, ls_day, ls_year
String	ls_coil_org_num, ls_find_string, ls_alloy, ls_null, ls_heat_treated
Integer	li_month, li_day, li_year, li_current_year, li_answer
Long		ll_rows, ll_row, ll_found_row, ll_inserted_row

SetNull(ls_null)
ls_current_date = String(Today())
li_current_year = Integer(Right(ls_current_date, 4))

ll_rows = dw_coil_list.RowCount()

For ll_row = 1 To ll_rows
	ls_coil_org_num = dw_coil_list.Object.coil_org_num[ll_row]
	ls_cash_date = dw_coil_list.Object.cash_date[ll_row]
	ls_alloy = dw_coil_list.Object.alloy[ll_row]
	
	ls_find_string = "alloy = '" + ls_alloy + "'"
	ll_found_row = dw_alloy_heat_treatment.Find(ls_find_string, 1, dw_alloy_heat_treatment.RowCount())
	
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
	
	If li_month < 1 Or li_month > 12 Then
		lb_valid = False
	End If
	
	If li_day < 1 Or li_day > 31 Then
		lb_valid = False
	End If
	
	If li_year < li_current_year - 2 Or li_year > li_current_year Then
		lb_valid = False
	End If
	
	If Not lb_valid Then
		If ll_found_row > 0 Then //Alloy is on the list
			ls_heat_treated = Upper(dw_alloy_heat_treatment.Object.heat_treated[ll_found_row])
			If IsNull(ls_heat_treated) Then ls_heat_treated = "N"
			
			If ls_heat_treated = "Y" Then //Cash date required
				MessageBox("Data input error", "Cash date for coil " + ls_coil_org_num + " invalid. Please correct~n~r", StopSign!)
				Exit
			Else //Cash date not required
				lb_valid = True
				dw_coil_list.Object.cash_date[ll_row] = ls_null
			End If
		Else  //Alloy is new; not on the list
			li_answer = MessageBox("Cash date required?", "Alloy " + ls_alloy + " for coil " + ls_coil_org_num + " is new." + &
					"~n~rDoes it require cash date?" + &
					"~n~r~n~rIf you answer 'Yes', you have to enter valid (mm/dd/yyyy) cash date for coil " + ls_coil_org_num, &
					Question!, YesNo!, 1)
			
			ll_inserted_row = dw_alloy_heat_treatment.InsertRow(0)
			
			If ll_inserted_row > 0 Then
				dw_alloy_heat_treatment.Object.alloy[ll_inserted_row] = ls_alloy
				
				If li_answer = 1 Then //Yes. This alloy requires cash date
					dw_alloy_heat_treatment.Object.heat_treated[ll_inserted_row] = "Y"
					Exit //Allow user to enter a valid cahs date
				Else //No. This alloy does not require cash date
					dw_alloy_heat_treatment.Object.heat_treated[ll_inserted_row] = ls_null
					lb_valid = True
					dw_coil_list.Object.cash_date[ll_row] = ls_null
				End If
			End If
		End If
	End If
Next

Return lb_valid
//Alex Gerlants. 08/22/2018. Force Cash Date. End
end function

public function boolean wf_validate_cash_date ();//Alex Gerlants. 08/22/2018. Force Cash Date. Begin
/*
Function:	wf_validate_cash_date
Returns:		boolean		True if all cash_dates in dw_coil_list are populated with valid dates
Arguments:	none
*/
Boolean	lb_all_alloys_exist = True, lb_valid

dw_coil_list.AcceptText()

lb_all_alloys_exist = wf_all_alloys_exist()

If lb_all_alloys_exist Then
	lb_valid = wf_validate_cash_date_all()
Else
	lb_valid = wf_validate_cash_date_not_all()
End If

Return lb_valid
//Alex Gerlants. 08/22/2018. Force Cash Date. End
end function

public subroutine wf_update_cash_date (string as_alloy, string as_cash_date);//Alex Gerlants. 08/22/2018. Force Cash Date. Begin
/*
Function:	wf_update_cash_date
				Update cash_date in dw_coil_list for all rows that have as_alloy
Returns:		none
Arguments:	value	string	as_alloy
				value	string	as_cash_date
*/
Long		ll_rows, ll_row, ll_found_row
String	ls_find_string

ls_find_string = "alloy = '" + as_alloy + "'"
ll_found_row = dw_coil_list.Find(ls_find_string, 1, dw_coil_list.RowCount())

Do While ll_found_row > 0
	dw_coil_list.Object.cash_date[ll_found_row] = as_cash_date
	ll_found_row = dw_coil_list.Find(ls_find_string, 1, dw_coil_list.RowCount())
Loop
//Alex Gerlants. 08/22/2018. Force Cash Date. End
end subroutine

public function integer wf_insert_coil_track (long al_coil_abc_num, long al_coil_weight, string as_coil_location);//Alex Gerlants. 12/07/2018. Coil_Inventory_Report_863. Begin
/*
Function:	wf_insert_coil_track
				Call global function f_insert_coil_track to insert into table coil_track for newly created coils
Returns:		integer
Arguments:	value		long		al_coil_abc_num
				value		long		al_coil_weight
				value		string	as_coil_location	
*/
str_all_data_types	lstr_all_data_types
Integer					li_rtn = 1
DateTime					ldt_null
Long						ll_coil_abc_num, ll_coil_pre_weight, ll_coil_cur_weight

lstr_all_data_types.long_var[1] = al_coil_abc_num
lstr_all_data_types.long_var[2] = al_coil_weight
lstr_all_data_types.long_var[3] = al_coil_weight

lstr_all_data_types.integer_var[1] = 2
lstr_all_data_types.integer_var[2] = 2

lstr_all_data_types.string_var[1] = Upper(sqlca.logid)
lstr_all_data_types.string_var[2] = as_coil_location
lstr_all_data_types.string_var[3] = as_coil_location

lstr_all_data_types.datetime_var[1] = DateTime(Today(), Now())
SetNull(ldt_null)
lstr_all_data_types.datetime_var[2] = DateTime(Date("01/01/1980"), Time("00:00:00"))

li_rtn = f_insert_coil_track(lstr_all_data_types, sqlca)

If li_rtn = -1 Then //DB error in f_insert_coil_track
	MessageBox("Database error", &
			"The following error message if for information only. It will not stop coil receving.~n~r~n~r" + &
			"Database error occurred in wf_insert_coil_track while calling global function f_insert_coil_track " + &
			"to insert a row into table coil_track for newly created coil ABC number " + String(al_coil_abc_num) + "~n~r~n~r" + &
			"Error:~n~r" + sqlca.sqlerrtext, Information!)
End If

Return li_rtn
//Alex Gerlants. 12/07/2018. Coil_Inventory_Report_863. End
end function

public function integer wf_validate_cash_date_2 ();//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. Begin
/*
Function:	wf_validate_cash_date_2
Returns:		integer	 1 if ok to save
							-1 if not ok to save
Arguments:	none
*/
Boolean	lb_all_cash_dates_ok = True, lb_valid_temp
String	ll_find_string, ls_cash_date, ls_cash_date_formatted, ls_current_date, ls_month, ls_day, ls_year
String	ls_coil_org_num, ls_invalid_cash_date_string, ls_find_string, ls_alloy, ls_heat_treated, ls_null
String	ls_customer_short_name, ls_missing_cash_date_string
Integer	li_rtn = 1, li_month, li_day, li_year, li_current_year, li_answer
Long		ll_rows, ll_row, ll_found_row, ll_customer_id

ls_current_date = String(Today())
li_current_year = Integer(Right(ls_current_date, 4))
SetNull(ls_null)

ll_rows = dw_coil_list.RowCount()

For ll_row = 1 To ll_rows
	ls_coil_org_num = dw_coil_list.Object.coil_org_num[ll_row]
	ls_cash_date = Trim(dw_coil_list.Object.cash_date[ll_row])
	If IsNull(ls_cash_date) Then ls_cash_date = ""
	
	If ls_cash_date <> "" Then
		ls_month = Left(ls_cash_date, 2)
		ls_day = Mid(ls_cash_date, 3, 2)
		ls_year = Right(ls_cash_date, 4)
		ls_cash_date_formatted = ls_month + "/" + ls_day + "/" + ls_year
	
		If IsDate(ls_cash_date_formatted) Then
			If Date(ls_cash_date_formatted) > Today() Then
				li_rtn = -1
				MessageBox("Data input error", 	"Error: Cash Date for Coil Org Num " + ls_coil_org_num + &
															" is in the future.~n~rPlease correct", StopSign!)
				GoTo CONT
			End If
		End If
		
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
	ll_customer_id = dw_general_customer.Object.customer_id[1]
	ls_customer_short_name = f_get_customer_name(ll_customer_id, sqlca)

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
			MessageBox("Data input error", "Error: Cash date invalid for the following coils.~n~r" + ls_invalid_cash_date_string + &
					"~n~rPlease correct.", StopSign!)
		End If
	ElseIf ls_invalid_cash_date_string <> "" Then
		li_rtn = -1
		
		MessageBox("Data input error", "Error: Cash date invalid for the following coils.~n~r" + ls_invalid_cash_date_string + &
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

CONT:
Return li_rtn
//Alex Gerlants. 12/28/2018. Cash_Date_not_Saved_at_Receiving. End
end function

public function integer wf_861_created (string as_bol);//Alex Gerlants. 05/28/2019. 861_At_Receiving. Begin
/*
Function:	wf_861_created
Returns:		integer	<==  1 if 861 already sent
								  0 if 861 has not been sent
								 -1 if DB error
								 -2 if bold does not exist in table inbound_shipment_status. Should not happen though
Arguments:	value	string	as_bol
				value	long		al_edi_file_id
*/

Integer	li_861_alrady_sent = 0 //Initialize to "Not Sent"
Integer	li_inbound_shipment_status
String	ls_filename_861
DateTime	ldt_created_861_date_time
Long		ll_edi_file_id

select	filename_861, edi_file_id
into		:ls_filename_861, :ll_edi_file_id
from		inbound_shipment_status
where		bol = :as_bol
and 		edi_file_id = 
         (
           select    max(edi_file_id)
           from      inbound_shipment_status
           where     bol = :as_bol
           and       status = 3
         )
using		sqlca;

Choose Case sqlca.sqlcode
	Case 0 //OK
		If Not IsNull(ls_filename_861) Then //861 already created
			li_861_alrady_sent = 1
			MessageBox("DB error", 	"Receiving Advice/Acceptance Certificate document (861) has already been created " + &
											"for bol " + as_bol + &
											"~n~r~n~rPlease contact abis support")
		End If;
	Case 100 //BOL not found. . Should not happen
		li_861_alrady_sent = -2
		MessageBox("DB error", 	"BOL " + as_bol + " not found in table inbound_shipment_status." + &
											"~n~r~n~rPlease contact abis support")
	Case Else //DB error
		li_861_alrady_sent = -1
			MessageBox("DB error", 	"Database error occurred wf_861_alrady_sent for w_coil_receiving while trying to retrieve " + &
											"status from table inbound_shipment_status for BOL " + as_bol + " and edi_file_id " + String(ll_edi_file_id) + &
											"~n~r~n~rPlease contact abis support" + &
											"~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
End Choose

Return li_861_alrady_sent
//Alex Gerlants. 05/28/2019. 861_At_Receiving. End
end function

public function integer wf_create_861_4arconic ();//Alex Gerlants. 05/30/2019. Arconic 861. Begin
/*
Function:	wf_create_861_4arconic
Returns:		integer	<==  1 if OK
								 -1 if error
Arguments:	none
*/				
Integer	li_rtn = 1
Integer	li_861_created
Long		ll_i, ll_coil_count, ll_edi_file_id
String	ls_bol

Transaction transaction_861

If IsValid(transaction_861) Then Destroy transaction_861

transaction_861 = Create Transaction
transaction_861.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
transaction_861.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
transaction_861.LogID = gs_LogID
transaction_861.LogPass = gs_LogPass

connect using transaction_861;

If transaction_861.SQLCode < 0 Then 
	MessageBox ("Connection Failed!!!!", transaction_861.sqlerrtext, Exclamation!)
	Return -1
End If

ll_coil_count = dw_coil_list.RowCount()
ls_bol = Trim(sle_bol.text)

li_861_created = wf_861_created(ls_bol)

If li_861_created = 0 Then //861 not created
	
	//****************************************************************************************************
	
	String	ls_name = "f_edi_arconic_861_test"

	declare p_edi procedure for f_edi_arconic_861(:ls_bol) using transaction_861;
	execute p_edi;
	
	if transaction_861.sqlCode <> 0 then 
		MessageBox (	"Stored Procedure f_edi_arconic_861_test failed to create " + &
							"861 - Receiving Advice/Acceptance Certificate document for Arconic.", &
							transaction_861.sqlerrtext, Exclamation!)
		li_rtn = -1
	end if
	
	If li_rtn = 1 Then //Ok above
		fetch p_edi into :li_rtn; 
		close p_edi;
	End If

	//****************************************************************************************************
	
	
End If

If IsValid(transaction_861) Then Destroy transaction_861

Return li_rtn
//Alex Gerlants. 05/30/2019. Arconic 861. End
end function

public function integer wf_populate_data_861 (long al_customer_id, string as_bol, transaction atr_dbo_861);//Alex Gerlants. 05/30/2019. Arconic 861. Begin
/*
Function:	wf_populate_data_861
Returns:		integer
Arguments:	value	long			al_customer_id
				value	string		as_bol
				value transaction	atr_dbo_861
*/

Integer		li_rtn = 1, li_status
Long			ll_coil_count, ll_i, ll_receiving_bol_id, ll_customer_id
Long			ll_inserted_row
Long			ll_edi_file_id, ll_coil_abc_num, ll_damage_fault, ll_damage_code, ll_net_wt, ll_gross_wt, ll_coil_from_cust_id
Long			ll_rows, ll_loading_qty, ll_po_line_num
Long			ll_found_row
Real 			lr_lineal_feed, lr_width, lr_gauge, lr_density
String		ls_coil_orig_num, ls_alloy, ls_temper, ls_lot, ls_pack_id, ls_part_num, ls_supplier_sales_num
String		ls_po, ls_consumed_coil, ls_material_num, ls_cash_date
String		ls_mill_duns_num, ls_customer_duns_number_string, ls_packaging_code
String		ls_find_string

//Alex Gerlants. 03/09/2020. Constellium EDI. Begin
Integer	li_856_received
Long		ll_inserted_rows_count = 0

li_856_received = wf_856_received()

If li_856_received = 0 Then Return 1 //We have not received 856. No point to insert into data_861
//Alex Gerlants. 03/09/2020. Constellium EDI. End

dw_data_861.SetTransObject(atr_dbo_861)
	
//Delete from data_861 to make room for the new data
delete
from		dbo.data_861
where		customer_id = :al_customer_id
and		bol = :as_bol
using		atr_dbo_861;

If atr_dbo_861.sqlcode = 0 Then
	commit using atr_dbo_861;
Else
	li_rtn = -1
	rollback using atr_dbo_861;
	MessageBox ("Database error", "Database error in in wf_populate_data_861 for w_coil_receiving " + &
											"while trying to delete data from table data_861" + &
											"~n~rPlease contact abis support"+ &
											"~n~r" + atr_dbo_861.sqlerrtext, StopSign!)
End If

If li_rtn = 1 Then //OK above
	dw_data_861.Retrieve(al_customer_id, as_bol)

	//ll_rows = dw_data_861.RowCount() //Diagnostics

	select	nvl(customer_duns_number_string, 'NOT DEFINED')
	into		:ls_customer_duns_number_string
	from 		customer
	where		customer_id = :al_customer_id
	using		atr_dbo_861;
	
	If atr_dbo_861.sqlcode < 0 Then //DB error
		li_rtn = -1
		MessageBox ("Database error", "Database error occurred in wf_populate_data_861 for w_coil_receiving" + &
												" while trying to retrieve data from table customer for customer id " + String(al_customer_id) + &
												"~n~rPlease contact abis support"+ &
												"~n~r" + atr_dbo_861.sqlerrtext, StopSign!)
	End If
End If

If li_rtn = 1 Then //OK above
	dw_inbound_coil_status.SetTransObject(atr_dbo_861)
	ll_rows = dw_inbound_coil_status.Retrieve(as_bol)
	
	If ll_rows < 0 Then //DB error
		li_rtn = -1
		MessageBox ("Database error", "Database error occurred in wf_populate_data_861 for w_coil_receiving" + &
												" while trying to retrieve data from table inbound_coil_status for bol " + as_bol + &
												"~n~rPlease contact abis support"+ &
												"~n~r" + atr_dbo_861.sqlerrtext, StopSign!)
	End If
	
	If li_rtn = 1 Then //OK above
		ll_coil_count = dw_coil_list.RowCount()
	
		For ll_i = 1 To ll_coil_count
			//Get data from dw_coil_list.
			//When we save new BOL,   dw_coil_list.DataObject = 'd_coil_list_by_bol_add'
			//When we search for BOL, dw_coil_list.DataObject = 'd_coil_list_by_bol_archived'
			
			ll_customer_id = dw_general_customer.Object.customer_id[1]
			ll_coil_abc_num = dw_coil_list.GetItemNumber(ll_i, "coil_abc_num")
			ls_coil_orig_num = dw_coil_list.GetItemString(ll_i, "coil_org_num")
			ll_damage_fault = dw_coil_list.GetItemNumber(ll_i, "damaged_fault")
			ll_damage_code = dw_coil_list.GetItemNumber(ll_i, "damaged_code")
			ls_alloy = dw_coil_list.GetItemString(ll_i, "alloy")
			ls_temper = dw_coil_list.GetItemString(ll_i, "temper")
			ll_net_wt = dw_coil_list.GetItemNumber(ll_i, "net_weight")
			ll_gross_wt = dw_coil_list.GetItemNumber(ll_i, "gross_weight")
			lr_lineal_feed = dw_coil_list.GetItemNumber(ll_i, "lineal_feed")
			lr_width = dw_coil_list.GetItemNumber(ll_i, "coil_width")
			lr_gauge = dw_coil_list.GetItemNumber(ll_i, "coil_gauge")
			lr_density = dw_coil_list.GetItemNumber(ll_i, "density")
			ls_lot = dw_coil_list.GetItemString(ll_i, "lot")
			ls_pack_id = dw_coil_list.GetItemString(ll_i, "pack_id")
			ls_part_num = dw_coil_list.GetItemString(ll_i, "part_num")
			ls_supplier_sales_num = dw_coil_list.GetItemString(ll_i, "supplier_sales_num")
			ls_po = dw_coil_list.Object.purchase_order_num[ll_i]
			ls_consumed_coil = dw_coil_list.GetItemString(ll_i, "consumed_coil_num")
			ls_material_num = dw_coil_list.GetItemString(ll_i, "material_num")
			ls_cash_date = dw_coil_list.GetItemString(ll_i, "cash_date")
			ll_coil_from_cust_id = dw_coil_list.GetItemNumber(ll_i, "coil_from_cust_id")
			
			If dw_coil_list.DataObject = 'd_coil_list_by_bol_add' Then
				ll_edi_file_id = dw_coil_list.GetItemNumber(ll_i, "inbound_coil_edi_file_id")
				li_status = dw_coil_list.Object.status[ll_i]
				ll_receiving_bol_id = dw_bol.GetItemNumber(ll_i, "receiving_bol_id")
			Else //dw_coil_list.DataObject = 'd_coil_list_by_bol_archived'
				ls_find_string = "bol = '" + as_bol + "' and coil_number = '" + ls_coil_orig_num + "'"
				ll_found_row = dw_inbound_coil_status.Find(ls_find_string, 1, dw_inbound_coil_status.RowCount())
				
				If ll_found_row > 0 Then
					ll_edi_file_id = dw_inbound_coil_status.Object.edi_file_id[ll_found_row]
				Else
					ll_edi_file_id = 0
				End If
				li_status = 1
			End If
			
			//Do not insert into dw_data_861 without ll_edi_file_id. It will bomb out anyway.
			If IsNull(ll_edi_file_id) Then ll_edi_file_id = -999 //Alex Gerlants. 03/09/2020. Constellium EDI
			If ll_edi_file_id = -999 Then Continue //Alex Gerlants. 03/09/2020. Constellium EDI
			
			//Insert data into dw_data_861
			ll_inserted_row = dw_data_861.InsertRow(0)
			
			If ll_inserted_row > 0 Then
				ll_inserted_rows_count++ //Alex Gerlants. 03/09/2020. Constellium EDI
				
				//The values in the 4 lines below are key columns in table date_861
				dw_data_861.Object.customer_id[ll_inserted_row] = ll_customer_id
				dw_data_861.Object.bol[ll_inserted_row] = as_bol
				dw_data_861.Object.edi_file_id[ll_inserted_row] = ll_edi_file_id
				dw_data_861.Object.coil_org_num[ll_inserted_row] = ls_coil_orig_num
				
				dw_data_861.Object.receiving_bol_id[ll_inserted_row] = ll_receiving_bol_id
				dw_data_861.Object.coil_abc_num[ll_inserted_row] = ll_coil_abc_num
				dw_data_861.Object.coil_status[ll_inserted_row] = li_status
				dw_data_861.Object.damaged_fault[ll_inserted_row] = ll_damage_fault
				dw_data_861.Object.damaged_code[ll_inserted_row] = ll_damage_code
				dw_data_861.Object.temper[ll_inserted_row] = ls_temper
				dw_data_861.Object.net_weight[ll_inserted_row] = ll_net_wt
				dw_data_861.Object.gross_weight[ll_inserted_row] = ll_gross_wt
				dw_data_861.Object.lineal_feed[ll_inserted_row] = lr_lineal_feed
				dw_data_861.Object.coil_width[ll_inserted_row] = lr_width
				dw_data_861.Object.coil_gauge[ll_inserted_row] = lr_gauge
				dw_data_861.Object.density[ll_inserted_row] = lr_density
				dw_data_861.Object.lot[ll_inserted_row] = ls_lot
				dw_data_861.Object.pack_id[ll_inserted_row] = ls_pack_id
				dw_data_861.Object.alloy[ll_inserted_row] = ls_alloy
				dw_data_861.Object.part_num[ll_inserted_row] = ls_part_num
				dw_data_861.Object.supplier_sales_num[ll_inserted_row] = ls_supplier_sales_num
				dw_data_861.Object.consumed_coil_num[ll_inserted_row] = ls_consumed_coil
				dw_data_861.Object.material_num[ll_inserted_row] = ls_material_num
				dw_data_861.Object.cash_date[ll_inserted_row] = Right(ls_cash_date, 4) + Left(ls_cash_date, 4)
				dw_data_861.Object.bol[ll_inserted_row] = sle_bol.Text
				dw_data_861.Object.coil_from_cust_id [ll_inserted_row] = ll_coil_from_cust_id
				dw_data_861.Object.created_date[ll_inserted_row] = DateTime(Today(), Now())
				dw_data_861.Object.received_date[ll_inserted_row] = DateTime(Today(), Now())
				dw_data_861.Object.po[ll_inserted_row] = ls_po
				dw_data_861.Object.customer_duns_number[ll_inserted_row] = ls_customer_duns_number_string
				dw_data_861.Object.mill_duns_number[ll_inserted_row] = ls_mill_duns_num
				dw_data_861.Object.packaging_code[ll_i] = ls_packaging_code
				dw_data_861.Object.loading_qty[ll_i] = ll_loading_qty
				dw_data_861.Object.po[ll_i] = ls_po
				dw_data_861.Object.po_line_num[ll_i] = ll_po_line_num
			Else
				li_rtn = -1
				Exit
			End If
		Next
	End If
End If	

If li_rtn = 1 Then //OK above
	//ll_rows = dw_data_861.RowCount() //Diagnostics
	
	If ll_inserted_rows_count > 0 Then //Alex Gerlants. 03/09/2020. Constellium EDI
		li_rtn = dw_data_861.Update()
		
		If li_rtn = 1 Then //OK
			commit using atr_dbo_861;
		Else //Error
			rollback using atr_dbo_861; //Error message is in DBError event for dw_data_861
		End If
	End If //Alex Gerlants. 03/09/2020. Constellium EDI
End If

Return li_rtn
//Alex Gerlants. 05/30/2019. Arconic 861. End
end function

protected function integer wf_create_861_4customer (long al_customer_id, string as_bol);//Alex Gerlants. 05/30/2019. Arconic 861. Begin
/*
Function:	wf_create_861_4customer
Returns:		integer	 1 if OK
							 2 if customer_id is not in table edi_customer_objects
							-1 if DB error
Arguments:	value	long		al_customer_id
				value	string	as_bol
*/

Integer		li_rtn = 1, li_count, li_answer
Long			ll_rows, ll_row
Transaction ldbo_861
String		ls_customer_name, ls_filename_861, ls_filename_861_string
String		ls_create_861_at_receiving

select	ltrim(rtrim(customer_short_name))
into		:ls_customer_name
from		customer
where		customer_id = :al_customer_id
using		sqlca;

If sqlca.sqlcode <> 0 Then
	li_rtn = -1
	MessageBox("Database error", 	"Database error occurred in wf_create_861_4customer for w_coil_receiving" + &
											" while trying to retrieve Customer Name from table customer for customer id " + String(al_customer_id) + &
											"~n~rPlease contact abis support"+ &
											"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
End If

If li_rtn = 1 Then //OK above
	is_bol = as_bol
	
	//Check if 861 has already been created
	ll_rows = dw_inbound_shipment_status.Retrieve(as_bol, 1)
	
	Choose Case ll_rows
		Case Is > 0 //861 has already been created for as_bol
			If dw_coil_list.DataObject = 'd_coil_list_by_bol_add' Then //Do this for new BOLs only
				//Collect filename_861's
				For ll_row = 1 To ll_rows
					ls_filename_861 = dw_inbound_shipment_status.Object.filename_861[ll_row]
					ls_filename_861_string = ls_filename_861_string + ls_filename_861 + ", "
				Next
				
				//Remove the last comma
				ls_filename_861_string = Left(ls_filename_861_string, Len(ls_filename_861_string) - 2)
				
				li_answer = MessageBox("861 has already been created", "861 - Receiving Advice/Acceptance Certificate document " + &
													"has already been created for bol " + as_bol + ":~n~r" + ls_filename_861_string + &
													"~n~r~n~rWould you like to recreate this 861?", Question!, YesNo!, 2)
													
				If li_answer = 2 Then //No
					li_rtn = 2 //Nothing to do here
				End If
			End If
		Case 0 //861 has not been created for as_bol.
			//Fall through
		Case Is < 0 //DB error
			li_rtn = -1
			//Error message is in dberror event for dw_inbound_shipment_status
	End Choose
End If

If li_rtn = 1 Then //OK above
	//Using a separate transaction to create an 861 for a customer
	ldbo_861 = create Transaction
	ldbo_861.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	ldbo_861.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	ldbo_861.LogID = gs_LogID
	ldbo_861.LogPass = gs_LogPass
	
	connect using ldbo_861;
	
	If ldbo_861.SQLCode < 0 Then 
		MessageBox("Connection Failed",	"Database connection failed in wf_create_861_4customer for w_coil_receiving" + &
													"~n~rPlease contact abis support"+ &
													"~n~r~n~rError:~n~r" + ldbo_861.sqlerrtext, StopSign!)
		li_rtn = -1
	End If
End If

If li_rtn = 1 Then
	li_rtn = wf_populate_data_861(al_customer_id, as_bol, ldbo_861)
	
	If Not wf_856_received_4bol(as_bol) Then Return 1 	//Alex_861_Without_856. 
																		//856 not received for as_bol. No point to try creating 861.
																		//It is going to bomb out anyways.
	
	Choose Case al_customer_id
		Case 2784 //Arconic-TN
			Declare p_861_arconic procedure for dbo.f_edi_arconic_861(:al_customer_id, :as_bol) using ldbo_861;
			
			execute p_861_arconic;
		
			If ldbo_861.SQLCode = 0 Then //OK
				fetch p_861_arconic into :li_rtn;
				
				Choose Case li_rtn
					Case 1 //OK. I am displaying success message only when we resend 861
						If dw_coil_list.DataObject = 'd_coil_list_by_bol_archived' Then
							MessageBox("861 - Receiving Advice/Acceptance Certificate document created", &
									"861 successfuly re-sent for customer " + ls_customer_name + " and BOL " + as_bol)
						End If
					Case 2 //Should not happen because I check this at the beginning of this function
						MessageBox("861 is not required", "Customer " + ls_customer_name + &
							" does not require 861 - Receiving Advice/Acceptance Certificate document created at receiving.")
					Case 3 //Wrong customer in the function. Should not happen
						Choose Case al_customer_id
							Case 1153, 1459, 2582, 2950
								MessageBox("Wrong customer", "function f_edi_arconic_861 is NOT for Customer " + ls_customer_name + &
									"~n~rPlease contact abis support.")
							End Choose
					Case Else
						li_rtn = -1
						MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
				End Choose
			Else
				li_rtn = -1
				MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
			End If
			
			close p_861_arconic;
		Case 1153, 1459, 2582, 2950 //Novelis
			Declare p_861_novelis procedure for dbo.f_edi_novelis_861(:al_customer_id, :as_bol) using ldbo_861;
			
			execute p_861_novelis;
	
			If ldbo_861.SQLCode = 0 Then //OK
				fetch p_861_novelis into :li_rtn;
				
				Choose Case li_rtn
					Case 1 //OK. I am displaying success message only when we resend 861
						If dw_coil_list.DataObject = 'd_coil_list_by_bol_archived' Then
							MessageBox("861 - Receiving Advice/Acceptance Certificate document created", &
									"861 successfuly re-sent for customer " + ls_customer_name + " and BOL " + as_bol)
						End If
					Case 2 //Should not happen because I check this in Clicked vent for cb_resend_861
						MessageBox("861 is not required", "Customer " + ls_customer_name + &
							" does not require 861 - Receiving Advice/Acceptance Certificate document created at receiving.")
						Return 2
					Case 3 //Wrong customer in the function. Should not happen
						Choose Case al_customer_id
							Case 2784
								MessageBox("Wrong customer", "function f_edi_novelis_861 is NOT for Customer " + ls_customer_name + &
									"~n~rPlease contact abis support.")
							End Choose
					Case Else
						li_rtn = -1
						MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
				End Choose
			Else
				li_rtn = -1
				MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
			End If
			
			close p_861_novelis;
			
		//Alex Gerlants. 08/23/2019. 861 Constellium. Begin
		Case 2776 //CONSTELLIUM- UACJ
			Declare p_861_constellium procedure for dbo.f_edi_constellium_861(:al_customer_id, :as_bol) using ldbo_861;
			
			execute p_861_constellium;
		
			If ldbo_861.SQLCode = 0 Then //OK
				fetch p_861_constellium into :li_rtn;
				
				Choose Case li_rtn
					Case 1 //OK. I am displaying success message only when we resend 861
						If dw_coil_list.DataObject = 'd_coil_list_by_bol_archived' Then
							MessageBox("861 - Receiving Advice/Acceptance Certificate document created", &
									"861 successfuly re-sent for customer " + ls_customer_name + " and BOL " + as_bol)
						End If
					Case 2 //Should not happen because I check this at the beginning of this function
						MessageBox("861 is not required", "Customer " + ls_customer_name + &
							" does not require 861 - Receiving Advice/Acceptance Certificate document created at receiving.")
					Case 3 //Wrong customer in the function. Should not happen
						Choose Case al_customer_id
							Case 1153, 1459, 2582, 2950
								MessageBox("Wrong customer", "function f_edi_constellium_861 is NOT for Customer " + ls_customer_name + &
									"~n~rPlease contact abis support.")
							End Choose
					Case Else
						li_rtn = -1
						MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
				End Choose
			Else
				li_rtn = -1
				MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
			End If
			
			close p_861_constellium;
		//Alex Gerlants. 08/23/2019. 861 Constellium. End
		
		//Alex Gerlants. 10/10/2019. 861 Aleris. Begin
		Case 1980 //Commonwealth formerly Aleris
			//Declare p_861_aleris procedure for dbo.f_edi_aleris_861(:al_customer_id, :as_bol) using ldbo_861;
			//execute p_861_aleris;
			Declare p_861_commonwealth procedure for dbo.f_edi_commonwealth_861(:al_customer_id, :as_bol) using ldbo_861; //Alex Gerlants. 10/28/2024. 2147_Commonwealth_EDI. Replaced "f_edi_aleris_861" with "f_edi_commonwealth_861"
			execute p_861_commonwealth; //Alex Gerlants. 10/28/2024. 2147_Commonwealth_EDI. Replaced "p_861_aleris" with "p_861_commonwealth"
		
			If ldbo_861.SQLCode = 0 Then //OK
				fetch p_861_commonwealth into :li_rtn;
				
				Choose Case li_rtn
					Case 1 //OK. I am displaying success message only when we resend 861
						If dw_coil_list.DataObject = 'd_coil_list_by_bol_archived' Then
							MessageBox("861 - Receiving Advice/Acceptance Certificate document created", &
									"861 successfuly re-sent for customer " + ls_customer_name + " and BOL " + as_bol)
						End If
					Case 2 //Should not happen because I check this at the beginning of this function
						MessageBox("861 is not required", "Customer " + ls_customer_name + &
							" does not require 861 - Receiving Advice/Acceptance Certificate document created at receiving.")
					Case 3 //Wrong customer in the function. Should not happen
						Choose Case al_customer_id
							Case 1980
								MessageBox("Wrong customer", "function f_edi_aleris_861 is NOT for Customer " + ls_customer_name + &
									"~n~rPlease contact abis support.")
							End Choose
					Case Else
						li_rtn = -1
						MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
				End Choose
			Else
				li_rtn = -1
				MessageBox("Failed: 861 - Receiving Advice/Acceptance Certificate document" + &
									"~n~rPlease contact abis support.~n~r~n~rError:~n~r", ldbo_861.sqlerrtext, StopSign!)
			End If
			
			close p_861_commonwealth;
		//Alex Gerlants. 10/10/2019. 861 Aleris. End
		
		Case Else
			GoTo END_FUNCTION
	End Choose
End If

END_FUNCTION:
disconnect using ldbo_861;
If IsValid(ldbo_861) Then Destroy ldbo_861

Return li_rtn
//Alex Gerlants. 05/30/2019. Arconic 861. End
end function

public function string wf_get_create_861_at_receiving (long al_customer_id);//Alex Gerlants. 05/30/2019. Arconic 861. Begin
/*
Function:	wf_get_create_861_at_receiving
Returns:		integer	 1 if OK
							 2 if customer_id is not in table edi_customer_objects
							-1 if DB error
Arguments:	value	long		al_customer_id
*/


String	ls_customer_name, ls_create_861_at_receiving

select	upper(nvl(create_861_at_receiving, 'N'))
into		:ls_create_861_at_receiving
from		customer
where		customer_id = :il_cust
using		sqlca;

If sqlca.sqlcode = 0 Then //OK
	If ls_create_861_at_receiving <> "Y" Then
		ls_create_861_at_receiving = "N"
	End If
Else //DB error
	ls_create_861_at_receiving = "N"
	
	MessageBox("Database error", 	"Database error occurred in wf_get_861_required for w_coil_receiving" + &
											" while trying to retrieve Customer Name and create_861_at_receiving" + &
											"from table customer for customer id " + String(il_cust) + &
											"~n~rPlease contact abis support"+ &
											"~n~r~n~rError:~n~r" + sqlca.sqlerrtext, StopSign!)
End If

Return ls_create_861_at_receiving
//Alex Gerlants. 05/30/2019. Arconic 861. End
end function

public function integer wf_856_received ();//Alex Gerlants. 03/09/2020. Constellium EDI. Begin
/*
Function:	wf_856_received
Returns:		integer	 1 if 856 received for BOL
							 0 if 856 not received for BOL
							-1 if DB error
Arguments:	none

*/

Integer	li_rtn = 0, li_count
Long		ll_rows, ll_row, ll_customer_id, ll_edi_file_id
String	ls_bol, ls_alloy, ls_temper, ls_first_character, ls_fifth_character

ls_bol = sle_bol.Text

select	count(*)
into		:li_count
from		inbound_shipment
where		bol = :ls_bol
using		sqlca;

If sqlca.sqlcode < 0 Then //DB error
	MessageBox("Database error", 	"Database error occurred in wf_change_alloy_temper for w_coil_receiving " + &
											"while retreving data from table inbound_shipment for bol " + ls_bol + &
											"~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
	Return -1
End If

If li_count > 0 Then li_rtn = 1

Return li_rtn
//Alex Gerlants. 03/09/2020. Constellium EDI. End
end function

public subroutine wf_change_alloy_temper ();//Alex Gerlants. 03/09/2020. Constellium EDI. Begin
/*
Function:	wf_change_alloy_temper
Returns:		none
Arguments:	none

*/

Integer	li_count
Long		ll_rows, ll_row, ll_customer_id, ll_edi_file_id
String	ls_bol, ls_alloy, ls_temper, ls_first_character, ls_fifth_character

ll_rows = dw_coil_list.RowCount()

For ll_row = 1 To ll_rows
	ls_alloy = dw_coil_list.Object.alloy[ll_row]
	ls_fifth_character = Mid(ls_alloy, 5, 1)
	
	If ls_fifth_character = "-" Then	//Alloy is not modified by 856_const.pl because there is no 856 EDI. Second check to make sure.
												//Alloy is entered by user
												//For example, this is how it comes from Constellium: "5982-01"
		ls_first_character = Left(ls_alloy, 1)
	
		Choose Case ls_first_character
			Case "5"
				ls_temper = "O"
			Case "6"
				ls_temper = "T4"
			Case Else
				ls_temper = "-"
		End Choose
		
		ls_alloy = Left(ls_alloy, 4)
		
		//Update to the correct values
		dw_coil_list.Object.alloy[ll_row] = ls_alloy
		dw_coil_list.Object.temper[ll_row] = ls_temper
	End If
Next
//Alex Gerlants. 03/09/2020. Constellium EDI. End
end subroutine

public function boolean wf_856_received_4bol (string as_bol);//Alex_861_Without_856. Begin
/*
Function:	wf_856_received_4bol
Returns:		boolean	True  if 856 received for as_bol
							False if 856 not received for as_bol
Arguments:	value	string	as_bol
*/

Integer	li_count
Boolean	lb_856_received_4bol

select   count(*)
into		:li_count
from     inbound_coil
where    bol = :as_bol
using		sqlca;

If sqlca.sqlcode = 0 Then
	If li_count >= 1 Then
		lb_856_received_4bol = True
	Else
		//MessageBox("856 not received", "856 for bol " + as_bol + " not received. Cannot create 861.")
		lb_856_received_4bol = False
	End If
Else
	lb_856_received_4bol = True //If DB error, assume that 856 received for as_bol
End If

Return lb_856_received_4bol
//Alex_861_Without_856. End
end function

public subroutine wf_add_remove_selected_row (long al_selected_row, string as_add_delete);//Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen. Begin
/*
Function:	wf_add_remove_selected_row
Returns:		none
Arguments:	value	long	al_selected_row
				value	sring	as_add_delete
*/
Long		ll_inserted_row, ll_found_row
String	ls_find_string, ls_sort_string

ls_find_string = "number = " + String(al_selected_row)
ll_found_row = dw_selected_rows.Find(ls_find_string, 1, dw_selected_rows.RowCount())

If as_add_delete = "add" Then
	If ll_found_row <= 0 Then
		ll_inserted_row = dw_selected_rows.InsertRow(0)
		
		If ll_inserted_row > 0 Then
			dw_selected_rows.Object.number[ll_inserted_row] = al_selected_row
		End If
	End If
Else //as_add_delete = "delete"
	If ll_found_row > 0 Then
		dw_selected_rows.DeleteRow(ll_found_row)
	End If
End If

If dw_selected_rows.RowCount() > 0 Then
	ls_sort_string = "number"
	dw_selected_rows.SetSort(ls_sort_string)
	dw_selected_rows.Sort()
End If
//Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen. End
end subroutine

on w_coil_receiving.create
int iCurrent
call super::create
if this.MenuName = "m_receive_coil" then this.MenuID = create m_receive_coil
this.dw_selected_rows=create dw_selected_rows
this.cb_change_cust=create cb_change_cust
this.cb_resend_861=create cb_resend_861
this.dw_inbound_coil_status=create dw_inbound_coil_status
this.dw_inbound_shipment_status=create dw_inbound_shipment_status
this.dw_data_861=create dw_data_861
this.cb_1=create cb_1
this.dw_alloy_heat_treatment=create dw_alloy_heat_treatment
this.dw_coil_quality_flaw_mapping=create dw_coil_quality_flaw_mapping
this.dw_coil_quality=create dw_coil_quality
this.dw_general_customer=create dw_general_customer
this.cb_delete=create cb_delete
this.cb_send861=create cb_send861
this.cb_newcoilnum=create cb_newcoilnum
this.em_receiveddate=create em_receiveddate
this.st_6=create st_6
this.dw_searchincomingedi=create dw_searchincomingedi
this.dw_searchbol=create dw_searchbol
this.dw_coil_list_edi=create dw_coil_list_edi
this.cb_newbol=create cb_newbol
this.st_enter=create st_enter
this.sle_searchbol=create sle_searchbol
this.cb_search=create cb_search
this.cb_print=create cb_print
this.st_4=create st_4
this.dw_incomingedi=create dw_incomingedi
this.cb_savebol=create cb_savebol
this.cb_deletecoil=create cb_deletecoil
this.cb_addcoil=create cb_addcoil
this.sle_bol=create sle_bol
this.dw_customer=create dw_customer
this.st_3=create st_3
this.st_2=create st_2
this.dw_bol=create dw_bol
this.dw_coil_list=create dw_coil_list
this.cb_create=create cb_create
this.cb_close=create cb_close
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_selected_rows
this.Control[iCurrent+2]=this.cb_change_cust
this.Control[iCurrent+3]=this.cb_resend_861
this.Control[iCurrent+4]=this.dw_inbound_coil_status
this.Control[iCurrent+5]=this.dw_inbound_shipment_status
this.Control[iCurrent+6]=this.dw_data_861
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_alloy_heat_treatment
this.Control[iCurrent+9]=this.dw_coil_quality_flaw_mapping
this.Control[iCurrent+10]=this.dw_coil_quality
this.Control[iCurrent+11]=this.dw_general_customer
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.cb_send861
this.Control[iCurrent+14]=this.cb_newcoilnum
this.Control[iCurrent+15]=this.em_receiveddate
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.dw_searchincomingedi
this.Control[iCurrent+18]=this.dw_searchbol
this.Control[iCurrent+19]=this.dw_coil_list_edi
this.Control[iCurrent+20]=this.cb_newbol
this.Control[iCurrent+21]=this.st_enter
this.Control[iCurrent+22]=this.sle_searchbol
this.Control[iCurrent+23]=this.cb_search
this.Control[iCurrent+24]=this.cb_print
this.Control[iCurrent+25]=this.st_4
this.Control[iCurrent+26]=this.dw_incomingedi
this.Control[iCurrent+27]=this.cb_savebol
this.Control[iCurrent+28]=this.cb_deletecoil
this.Control[iCurrent+29]=this.cb_addcoil
this.Control[iCurrent+30]=this.sle_bol
this.Control[iCurrent+31]=this.dw_customer
this.Control[iCurrent+32]=this.st_3
this.Control[iCurrent+33]=this.st_2
this.Control[iCurrent+34]=this.dw_bol
this.Control[iCurrent+35]=this.dw_coil_list
this.Control[iCurrent+36]=this.cb_create
this.Control[iCurrent+37]=this.cb_close
this.Control[iCurrent+38]=this.ddlb_customer
this.Control[iCurrent+39]=this.st_1
this.Control[iCurrent+40]=this.gb_1
end on

on w_coil_receiving.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_selected_rows)
destroy(this.cb_change_cust)
destroy(this.cb_resend_861)
destroy(this.dw_inbound_coil_status)
destroy(this.dw_inbound_shipment_status)
destroy(this.dw_data_861)
destroy(this.cb_1)
destroy(this.dw_alloy_heat_treatment)
destroy(this.dw_coil_quality_flaw_mapping)
destroy(this.dw_coil_quality)
destroy(this.dw_general_customer)
destroy(this.cb_delete)
destroy(this.cb_send861)
destroy(this.cb_newcoilnum)
destroy(this.em_receiveddate)
destroy(this.st_6)
destroy(this.dw_searchincomingedi)
destroy(this.dw_searchbol)
destroy(this.dw_coil_list_edi)
destroy(this.cb_newbol)
destroy(this.st_enter)
destroy(this.sle_searchbol)
destroy(this.cb_search)
destroy(this.cb_print)
destroy(this.st_4)
destroy(this.dw_incomingedi)
destroy(this.cb_savebol)
destroy(this.cb_deletecoil)
destroy(this.cb_addcoil)
destroy(this.sle_bol)
destroy(this.dw_customer)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_bol)
destroy(this.dw_coil_list)
destroy(this.cb_create)
destroy(this.cb_close)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;call super::open;Long 					ll_row, ll_i
Integer				li_rtn //Alex Gerlants. 03/27/2017
DataWindowChild	ldwc //Alex Gerlants. 03/27/2017
String				ls_customer_short_name //Alex Gerlants. 03/27/2017

dw_customer.SetTransObject(SQLCA)
dw_bol.SetTransObject(SQLCA)
dw_coil_list.SetTransObject(SQLCA)
dw_incomingedi.SetTransObject(SQLCA)
dw_searchbol.SetTransObject(SQLCA)
dw_coil_list_edi.SetTransObject(SQLCA)
dw_searchincomingedi.SetTransObject(SQLCA)

dw_customer.Visible = FALSE
dw_searchbol.Visible = False
dw_coil_list_edi.Visible = False
dw_searchincomingedi.Visible = False

dw_customer.Retrieve()

ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
//ddlb_customer.SelectItem(1)

//Alex Gerlants. 03/27/2017. Begin
li_rtn = dw_general_customer.GetChild("customer_id", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_row = ldwc.Retrieve()
End If
//Alex Gerlants. 03/27/2017. End

dw_coil_quality.Visible = False //Alex Gerlants. Coil Quality
dw_coil_quality_flaw_mapping.Visible = False //Alex Gerlants. Coil Quality

dw_alloy_heat_treatment.Visible = False //Alex Gerlants. 08/22/2018. Force Cash Date
dw_alloy_heat_treatment.SetTransObject(sqlca) //Alex Gerlants. 08/22/2018. Force Cash Date
dw_alloy_heat_treatment.Retrieve() //Alex Gerlants. 08/22/2018. Force Cash Date

dw_data_861.SetTransObject(sqlca) //Alex Gerlants. 05/30/2019. Arconic 861
dw_data_861.Visible = False //Alex Gerlants. 05/30/2019. Arconic 861
dw_inbound_shipment_status.SetTransObject(sqlca) //Alex Gerlants. 05/30/2019. Arconic 861
dw_inbound_shipment_status.Visible = False //Alex Gerlants. 05/30/2019. Arconic 861
dw_inbound_coil_status.Visible = False //Alex Gerlants. 05/30/2019. Arconic 861
cb_resend_861.Visible = False //Alex Gerlants. 05/30/2019. Arconic 861
cb_1.Visible = False //Alex Gerlants. 05/30/2019. Arconic 861

of_bollist()

cb_change_cust.Enabled = False //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen
dw_selected_rows.Visible = False //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen







end event

event pfc_save;////Alex Gerlants. 03/27/2017. Begin
//Long	ll_i, ll_coil_abc_num_temp //Alex Gerlants. 03/27/2017
//Boolean	lb_coil_abc_num_missing = False //Alex Gerlants. 03/27/2017
//
//For ll_i = 1 To dw_coil_list.RowCount()
//	ll_coil_abc_num_temp = dw_coil_list.Object.coil_abc_num[ll_i]
//	
//	If IsNull(ll_coil_abc_num_temp) Or ll_coil_abc_num_temp < 0 Then
//		lb_coil_abc_num_missing = True
//		Exit
//	End If
//Next
//
//If lb_coil_abc_num_missing Then 
//	MessageBox("Not All Coil ABC Numbers created", "Please create ALL Coil ABC Numbers", StopSign!)
//	Return 1
//End If
////Alex Gerlants. 03/27/2017. end

RETURN 1
end event

event pfc_print;
Return 1

end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Shipment(Receiving)") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event closequery;//Alex Gerlants. 03/27/2017. Begin
Integer	li_answer, li_rtn

li_rtn = dw_coil_list.of_UpdatesPending()

If li_rtn = 1 then
	li_rtn = MessageBox ("Data Modified", &
						"Do you want to save the current BOL and its coil data?", Question!, YesNo!, 1)
	
	If li_rtn = 1 Then
		//This.event ue_savebol()
		li_rtn = cb_savebol.Event Clicked()
		
		If li_rtn = -1 Then
			Return 1 //Prevent the window from closing
		End if
	Else
		Return 0 //Allow window to close
	End If
Else
	Return 0 //Allow window to close
End If
//Alex Gerlants. 03/27/2017. end
end event

type dw_selected_rows from datawindow within w_coil_receiving
integer x = 3735
integer y = 1840
integer width = 270
integer height = 60
integer taborder = 30
string title = "none"
string dataobject = "d_number"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_change_cust from commandbutton within w_coil_receiving
integer x = 3049
integer y = 156
integer width = 366
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Change Cust"
end type

event clicked;//Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen. Begin
Long						ll_rows, ll_selected_row, ll_coil_abc_num


Long 						ll_row, ll_i, ll_found_row, ll_customer_id_from, ll_customer_id_to
Integer					li_rtn
DataWindowChild		ldwc
String					ls_find_string, ls_customer_short_name_from, ls_customer_short_name_to
str_all_data_types	lstr_all_data_types_out, lstr_all_data_types_in

//ll_coil_abc_num = Message.DoubleParm

//li_rtn = dw_general_customer.GetChild("customer_id", ldwc)

//If li_rtn = 1 Then //OK
//	//ldwc.SetTransObject(sqlca)
//	//ll_row = ldwc.Retrieve()
//	
//	lstr_all_data_types_out.long_var[1] = il_cust
//	ls_find_string = "customer_id = " + String(il_cust)
//	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
//	
//	If ll_found_row > 0 Then
//		ls_customer_short_name = ldwc.GetItemString(ll_found_row, "customer_short_name")
//		lstr_all_data_types_out.string_var[1] = ls_customer_short_name
//	End If
//End If






dw_coil_list.AcceptText()
ll_rows = dw_coil_list.RowCount()

If ll_rows > 0 Then
	ll_selected_row = dw_coil_list.GetSelectedRow(0)
	
	If ll_selected_row > 0 Then
		ll_coil_abc_num = dw_coil_list.Object.coil_abc_num[ll_selected_row]
		If IsNull(ll_coil_abc_num) Then ll_coil_abc_num = 0
		
		If ll_coil_abc_num > 0 Then
			
			select	coil.customer_id, customer.customer_short_name
			into		:ll_customer_id_from, :ls_customer_short_name_from
			from		coil
						join customer on customer.customer_id = coil.customer_id
			where		coil.coil_abc_num = :ll_coil_abc_num
			using		sqlca;
			
			lstr_all_data_types_out.long_var[1] = ll_customer_id_from
			lstr_all_data_types_out.string_var[1] = ls_customer_short_name_from
			lstr_all_data_types_out.long_var[2] = ll_coil_abc_num
			//lstr_all_data_types_out.datawindow_var[1] = dw_coil_list
			OpenWithParm(w_change_cust, lstr_all_data_types_out)
			
			lstr_all_data_types_in = Message.powerobjectparm
			
			If lstr_all_data_types_in.string_var[1] = "cancel" Then Return
			
			ll_customer_id_to = lstr_all_data_types_in.long_var[1]
			ls_customer_short_name_to = lstr_all_data_types_in.string_var[1]
			//ls_customer_short_name_from = lstr_all_data_types_out.string_var[1]
			
			update	coil
			set		customer_id = :ll_customer_id_to
			where		coil_abc_num = :ll_coil_abc_num
			using		sqlca;
			
			If sqlca.sqlcode = 0 Then //OK
				commit using sqlca;
				
				MessageBox("Successful update", "Customer for ABC coil " + String(ll_coil_abc_num) + " succesfully updated" + &
				"~n~rFrom customer " + ls_customer_short_name_from + &
				"~n~rTo customer     " + ls_customer_short_name_to)
			Else //DB error
				rollback using sqlca;
				
				MessageBox("Database error", "Database error in Clicked event for cb_change_cust while updating coil table with customer_id " + &
									String(ll_customer_id_to) + &
									" for ABC coil " + String(ll_coil_abc_num) + "~n~r~n~rError:~n~r" + sqlca.sqlerrtext)
			End If
			
			dw_coil_list.Retrieve(il_receiving_bol_id)
		End If
	Else
		MessageBox("Nothing to change", "There are no coils on the screen. Nothing to change")
	End If
Else
	MessageBox("No coil selected", "Please select a coil")
End if
//Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen. End
end event

type cb_resend_861 from commandbutton within w_coil_receiving
integer x = 1586
integer y = 1808
integer width = 471
integer height = 92
integer taborder = 240
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resend 861"
end type

event clicked;//Alex Gerlants. Arconic 861. Begin
Integer	li_answer = 2 //No
String	ls_customer_name, ls_create_861_at_receiving

Long		ll_customer_id //Alex Gerlants. 03/09/2020. Constellium EDI
Integer	li_856_received //Alex Gerlants. 03/09/2020. Constellium EDI
String	ls_bol //Alex Gerlants. 03/09/2020. Constellium EDI

ls_bol = sle_bol.Text //Alex Gerlants. 03/09/2020. Constellium EDI

ls_create_861_at_receiving = wf_get_create_861_at_receiving(il_cust)

If ls_create_861_at_receiving = "Y" Then
	
	//Alex Gerlants. 03/09/2020. Constellium EDI. Begin
	li_856_received = wf_856_received()
	
	If li_856_received = 0 Then //856 has not been received
		MessageBox("Cannot re-send 861", &
										"We have not received EDI 856 for this BOL " + ls_bol + "." + &
										"~n~rTherefore, we cannot re-create 861 for this BOL.", StopSign!)
		Return
	End If
	//Alex Gerlants. 03/09/2020. Constellium EDI. End
	
	li_answer = MessageBox("Are you sure?", &
											"This will re-create 861 - Receiving Advice/Acceptance Certificate document " + &
											"for this BOL " + is_bol + ", and re-send it to the customer." + &
											"~n~rAre you sure?", Question!, YesNo!, 2)
Else //ls_create_861_at_receiving <> "Y"
	li_answer = MessageBox("Are you sure?", &	
											"861 NOT required for this customer.~n~r" + &
											"This will re-create 861 - Receiving Advice/Acceptance Certificate document " + &
											"for this BOL " + is_bol + ", and re-send it to the customer." + &
											"~n~rAre you sure?", Question!, YesNo!, 2)
End If

If li_answer = 1 Then //Yes
	li_answer = wf_create_861_4customer(il_cust, ls_bol)
End If
//Alex Gerlants. Arconic 861. End
end event

type dw_inbound_coil_status from datawindow within w_coil_receiving
integer x = 832
integer y = 1824
integer width = 165
integer height = 72
integer taborder = 260
string title = "none"
string dataobject = "d_inbound_coil_status"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_inbound_shipment_status from datawindow within w_coil_receiving
integer x = 649
integer y = 1824
integer width = 165
integer height = 72
integer taborder = 250
string title = "none"
string dataobject = "d_inbound_shipment_status"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;MessageBox ("Database error", "Database error in wf_create_861_4customer for w_coil_receiving " + &
												"while trying to select data from table inbound_shipment_status" + &
												"~n~r~n~rError:~n~r" + sqlerrtext, Exclamation!)
												
Return 1 //Don't display system error message; just the message above
end event

type dw_data_861 from datawindow within w_coil_receiving
integer x = 466
integer y = 1824
integer width = 169
integer height = 72
integer taborder = 240
string title = "none"
string dataobject = "d_data_861"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;MessageBox ("Database error", "Database error in wf_populate_data_861 for w_coil_receiving " + &
												"while trying to modify data in table data_861" + &
												"~n~r~n~rError:~n~r" + sqlerrtext, Exclamation!)
												
Return 1 //Don't display system error message; just the message above.												
end event

type cb_1 from commandbutton within w_coil_receiving
integer x = 3493
integer y = 60
integer width = 87
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;//wf_create_861_4arconic()
//wf_create_861_4customer(2950, '1052090-1')
end event

type dw_alloy_heat_treatment from datawindow within w_coil_receiving
integer x = 2386
integer y = 1848
integer width = 549
integer height = 320
integer taborder = 230
string title = "none"
string dataobject = "d_alloy_heat_treatment"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_coil_quality_flaw_mapping from datawindow within w_coil_receiving
integer x = 247
integer y = 1824
integer width = 192
integer height = 72
integer taborder = 220
string title = "none"
string dataobject = "d_coil_quality_flaw_mapping"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;is_sqlerrtext = sqlerrtext
Return 1 //Do not display error message. I am displaying an error message in my code
end event

type dw_coil_quality from datawindow within w_coil_receiving
integer x = 18
integer y = 1824
integer width = 215
integer height = 72
integer taborder = 220
string title = "none"
string dataobject = "d_coil_quality"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;is_sqlerrtext = sqlerrtext
Return 1 //Do not display error message. I am displaying an error message in my code 
end event

type dw_general_customer from datawindow within w_coil_receiving
integer x = 23
integer y = 92
integer width = 709
integer height = 84
integer taborder = 120
string title = "none"
string dataobject = "d_general_customer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

event itemchanged;String	ls_text, ls_cust
Long		ll_cust, ll_row, ll_i

dw_bol.SetTransObject(sqlca)
dw_incomingedi.SetTransObject(sqlca)

ls_cust = data

If IsNumber(ls_cust) Then
	ll_cust = Long(ls_cust)
	il_cust = ll_cust
End If

ll_row = dw_bol.Retrieve(ll_cust)
ll_row = dw_incomingedi.Retrieve(ll_cust)
dw_coil_list.reset()
sle_bol.text = ""

//Alex Gerlants. Coil Quality. Begin
//Alex Gerlants. Arconic EDI. Added create_861_at_receiving
select	upper(nvl(qr_code_req, 'N')), upper(nvl(create_861_at_receiving, 'N'))
into		:is_qr_code_req, :is_create_861_at_receiving
from		customer
where		customer_id = :ll_cust
using		sqlca;

If sqlca.sqlcode <> 0 Then //DB error
	is_qr_code_req = "N"
	is_create_861_at_receiving = "N"
End If
//Alex Gerlants. Coil Quality. End

//sle_bol.Visible = false
//
//ls_text = Text(index)
//ll_row = dw_customer.RowCount()
//FOR ll_i = 1 TO ll_row
//	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
//		dw_customer.Event RowFocusChanged(ll_i)
//		dw_customer.SelectRow(0, False)
//		dw_customer.SelectRow(ll_i, True)
//		il_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
//		dw_bol.Retrieve(il_cust)
//		dw_incomingedi.Retrieve(il_cust)
//		dw_coil_list.reset()
//		sle_bol.text = ""
//	END IF
//NEXT

sle_bol.Visible = true

dw_bol.SelectRow(0, false)
dw_incomingedi.SelectRow(0, false)

f_get_cash_date_required(ll_cust, sqlca, ib_cash_date_required) //Alex Gerlants. 08/22/2018. Force Cash Date
dw_alloy_heat_treatment.Retrieve() //Alex Gerlants. 08/22/2018. Force Cash Date
end event

type cb_delete from u_cb within w_coil_receiving
string tag = "Archive this EDI"
integer x = 2098
integer y = 1704
integer width = 471
integer taborder = 210
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Archive EDI"
end type

event clicked;call super::clicked;RETURN parent.event ue_deleteEDI()

end event

type cb_send861 from u_cb within w_coil_receiving
string tag = "Send 861 then archive edi"
integer x = 1586
integer y = 1704
integer width = 471
integer taborder = 200
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "Send&861&&Archive"
end type

event clicked;call super::clicked;RETURN parent.event ue_send861()
end event

type cb_newcoilnum from u_cb within w_coil_receiving
integer x = 1755
integer y = 1536
integer width = 562
integer height = 96
integer taborder = 140
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Coil ABC Num"
end type

event clicked;call super::clicked;parent.event ue_newcoilnum()
end event

type em_receiveddate from u_em within w_coil_receiving
event opentoinput ( )
event closetoinput ( )
integer x = 2354
integer y = 256
integer width = 421
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 700
long backcolor = 67108864
boolean border = false
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
boolean ib_autoselect = true
boolean ib_rmbmenu = false
end type

event opentoinput();of_SetDropDownCalendar(TRUE)
Border = true
DisplayOnly = false
BorderStyle = StyleLowered!
BackColor = 16777215	//White
end event

event closetoinput();of_SetDropDownCalendar(False)
Border = false
DisplayOnly = True
BorderStyle = StyleBox!
BackColor = 79741120	//Button Face
end event

event constructor;call super::constructor;of_SetDropDownCalendar(TRUE)
end event

event getfocus;call super::getfocus;this.event pfc_DDCalendar()
end event

type st_6 from statictext within w_coil_receiving
integer x = 1902
integer y = 256
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Received Date :"
boolean focusrectangle = false
end type

type dw_searchincomingedi from u_dw within w_coil_receiving
integer x = 1216
integer y = 16
integer width = 238
integer height = 124
integer taborder = 40
string dataobject = "d_searchincomingedi"
end type

type dw_searchbol from u_dw within w_coil_receiving
integer x = 946
integer y = 16
integer width = 274
integer height = 124
integer taborder = 90
string dataobject = "d_searchbol"
end type

type dw_coil_list_edi from u_dw within w_coil_receiving
integer x = 1029
integer y = 1824
integer width = 206
integer height = 72
integer taborder = 60
string dataobject = "d_coil_list_by_bol_edi"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

type cb_newbol from u_cb within w_coil_receiving
string tag = "Exit"
integer x = 549
integer y = 1704
integer width = 471
integer taborder = 170
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New BOL"
end type

event clicked;call super::clicked;parent.event ue_newbol()


end event

type st_enter from statictext within w_coil_receiving
integer x = 1723
integer y = 76
integer width = 599
integer height = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Enter BOL# here to find it."
boolean focusrectangle = false
end type

type sle_searchbol from singlelineedit within w_coil_receiving
integer x = 2336
integer y = 56
integer width = 654
integer height = 92
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type cb_search from u_cb within w_coil_receiving
integer x = 3049
integer y = 48
integer width = 366
integer taborder = 100
integer weight = 700
string text = "Search BOL"
end type

event clicked;call super::clicked;parent.event ue_searchbol()
end event

type cb_print from u_cb within w_coil_receiving
integer x = 2610
integer y = 1704
integer width = 471
integer taborder = 220
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print Coil Barcode"
end type

event clicked;call super::clicked;parent.event ue_print()
end event

type st_4 from statictext within w_coil_receiving
integer x = 41
integer y = 1156
integer width = 347
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Incoming EDI"
boolean focusrectangle = false
end type

type dw_incomingedi from u_dw within w_coil_receiving
integer x = 32
integer y = 1228
integer width = 654
integer height = 444
integer taborder = 20
string dataobject = "d_edi_bol"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_SetBase(TRUE)
//of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 ) 
end event

event clicked;call super::clicked;Long ll_edi_file_id
String ls_bol
Int li_rowcount, li_row, i, li_rc
String	ls_cash_date //Alex Gerlants. 05/30/2018

cb_resend_861.Visible = False //Alex Gerlants. 05/30/2019. Arconic 861

if row <= 0 then
	return 0
end if

li_rc = of_incomingedi()
if li_rc = 0 then
	return 0	
end if


dw_incomingedi.Event RowFocusChanged(row)
dw_incomingedi.SelectRow(0, False)
dw_incomingedi.SelectRow(row, True)

li_rowcount = dw_incomingedi.RowCount()
if li_rowcount > 0 then
		//ll_edi_file_id = dw_incomingedi.GetItemNumber(row, "edi_file_id") //Alex Gerlants. 07/26/2017. Comment out
		ls_bol = dw_incomingedi.GetItemString(row, "bol")
		sle_bol.text = ls_bol
		em_receiveddate.text = String(Today())
		//dw_coil_list_edi.Retrieve(ls_bol, ll_edi_file_id) //Alex Gerlants. 07/26/2017. Comment out

		//Alex Gerlants. 07/26/2017. Begin
		dw_coil_list_edi.Retrieve(ls_bol)
		
		dw_coil_list_edi.SetSort("inbound_coil_edi_file_id Asc coil_number Asc")
		dw_coil_list_edi.Sort()
		//Alex Gerlants. 07/26/2017. End
		
		
		//populate dw_coil_list
		li_rowcount = dw_coil_list_edi.RowCount()
		if li_rowcount > 0 then
				for i = 1 to li_rowcount
					ll_edi_file_id = dw_coil_list_edi.Object.inbound_coil_edi_file_id[i] //Alex Gerlants. 07/26/2017
					
					li_row = dw_coil_list.InsertRow(0)
					
					If li_row > 0 Then //Alex Gerlants. 07/26/2017
						dw_coil_list.Object.inbound_coil_edi_file_id[li_row] = dw_coil_list_edi.Object.inbound_coil_edi_file_id[i] //Alex Gerlants. 07/26/2017
						dw_coil_list.SetItem(li_row, "COIL_ABC_NUM", dw_coil_list_edi.GetItemNumber(i, "INBOUND_COIL_STATUS_COIL_ABC_NUM") )
						dw_coil_list.SetItem(li_row, "COIL_ORG_NUM", dw_coil_list_edi.GetItemString(i, "COIL_NUMBER") )
						dw_coil_list.SetItem(li_row, "DAMAGED_FAULT", 0)	//0: "No Damaged"
						dw_coil_list.SetItem(li_row, "DAMAGED_CODE", 0)	//0: "No Damaged"
						dw_coil_list.SetItem(li_row, "TEMPER", dw_coil_list_edi.GetItemString(i, "TEMPER"))
						dw_coil_list.SetItem(li_row, "NET_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "NET_WEIGHT"))
						dw_coil_list.SetItem(li_row, "GROSS_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "GROSS_WEIGHT"))
						dw_coil_list.SetItem(li_row, "COIL_GAUGE", dw_coil_list_edi.GetItemNumber(i, "COIL_GAUGE"))
						dw_coil_list.SetItem(li_row, "DENSITY", dw_coil_list_edi.GetItemNumber(i, "DENSITY"))
						dw_coil_list.SetItem(li_row, "LOT", dw_coil_list_edi.GetItemString(i, "LOT"))
						dw_coil_list.SetItem(li_row, "PACK_ID", dw_coil_list_edi.GetItemString(i, "PACK_ID"))
						dw_coil_list.SetItem(li_row, "ALLOY", dw_coil_list_edi.GetItemString(i, "ALLOY"))
						dw_coil_list.SetItem(li_row, "LINEAL_FEED", dw_coil_list_edi.GetItemNumber(i, "LINEAL_FEED"))
						dw_coil_list.SetItem(li_row, "COIL_WIDTH", dw_coil_list_edi.GetItemNumber(i, "COIL_WIDTH"))
						dw_coil_list.SetItem(li_row, "PART_NUM", dw_coil_list_edi.GetItemString(i, "inbound_shipment_part_number"))
						dw_coil_list.SetItem(li_row, "SUPPLIER_SALES_NUM", dw_coil_list_edi.GetItemString(i, "inbound_shipment_vo"))
						dw_coil_list.SetItem(li_row, "PURCHASE_ORDER_NUM", dw_coil_list_edi.GetItemString(i, "inbound_shipment_po"))
						dw_coil_list.SetItem(li_row, "consumed_coil_num", dw_coil_list_edi.GetItemString(i, "inbound_coil_consumed_coil_num"))
						dw_coil_list.SetItem(li_row, "material_num", dw_coil_list_edi.GetItemString(i, "inbound_coil_material_num"))
						
						ls_cash_date = dw_coil_list_edi.GetItemString(i, "inbound_coil_cash_date") //Alex Gerlants. 05/30/2018
						If IsNull(ls_cash_date) Then ls_cash_date = "" //Alex Gerlants. 05/30/2018
						ls_cash_date = f_format_date(ls_cash_date, "mmddyyyy") //Alex Gerlants. 05/30/2018
						
//						//dw_coil_list.SetItem(li_row, "cash_date", dw_coil_list_edi.GetItemString(i, "inbound_coil_cash_date"))
						dw_coil_list.SetItem(li_row, "cash_date", ls_cash_date) //Alex Gerlants. 05/30/2018
					End if //Alex Gerlants. 07/26/2017		
			next
		end if	
end if

//dw_coil_list.ResetUpdate()

cb_change_cust.Enabled = False //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen

end event

event pfc_rowchanged;call super::pfc_rowchanged;Long ll_edi_file_id
String ls_bol
Int li_row, li_cur_row, li_rowcount, i

if dw_coil_list.Describe("DataObject") = 'd_coil_list_by_bol_add' then

li_row = dw_incomingedi.RowCount()
if li_row > 0 then
	li_cur_row = dw_incomingedi.GetRow()
	if li_cur_row > 0 then
		dw_incomingedi.SelectRow(0, False)
		dw_incomingedi.SelectRow(li_cur_row, True)
		ll_edi_file_id = dw_incomingedi.GetItemNumber(li_cur_row, "edi_file_id")
		ls_bol = dw_incomingedi.GetItemString(li_cur_row, "bol")
		em_receiveddate.text = String(Today())
		dw_coil_list_edi.Retrieve(ls_bol, ll_edi_file_id)			
	end if
	
	//populate dw_coil_list
		li_rowcount = dw_coil_list_edi.RowCount()
		if li_rowcount > 0 then
				for i = 1 to li_rowcount
					li_row = dw_coil_list.InsertRow(0)
					dw_coil_list.SetItem(li_row, "COIL_ORG_NUM", dw_coil_list_edi.GetItemString(i, "COIL_NUM"))
					dw_coil_list.SetItem(li_row, "DAMAGED_FAULT", 0)	//0: "No Damaged"
					dw_coil_list.SetItem(li_row, "DAMAGED_CODE", 0)	//0: "No Damaged"
					dw_coil_list.SetItem(li_row, "TEMPER", dw_coil_list_edi.GetItemString(i, "TEMPER"))
					dw_coil_list.SetItem(li_row, "NET_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "NET_WEIGHT"))
					dw_coil_list.SetItem(li_row, "GROSS_WEIGHT", dw_coil_list_edi.GetItemNumber(i, "GROSS_WEIGHT"))
					dw_coil_list.SetItem(li_row, "COIL_GAUGE", dw_coil_list_edi.GetItemNumber(i, "COIL_GAUGE"))
					dw_coil_list.SetItem(li_row, "DENSITY", dw_coil_list_edi.GetItemNumber(i, "DENSITY"))
					dw_coil_list.SetItem(li_row, "LOT", dw_coil_list_edi.GetItemString(i, "LOT"))
					dw_coil_list.SetItem(li_row, "PACK_ID", dw_coil_list_edi.GetItemString(i, "PACK_ID"))
					dw_coil_list.SetItem(li_row, "ALLOY", dw_coil_list_edi.GetItemString(i, "ALLOY"))
					dw_coil_list.SetItem(li_row, "LINEAL_FEED", dw_coil_list_edi.GetItemNumber(i, "LINEAL_FEED"))
					dw_coil_list.SetItem(li_row, "COIL_WIDTH", dw_coil_list_edi.GetItemNumber(i, "COIL_WIDTH"))
				next
		end if	
	
end if

end if

//dw_coil_list.ResetUpdate()


end event

event rbuttondown;call super::rbuttondown;return 0
end event

event rbuttonup;call super::rbuttonup;return 0
end event

type cb_savebol from u_cb within w_coil_receiving
string tag = "Exit"
integer x = 1070
integer y = 1704
integer width = 471
integer taborder = 190
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Save BOL"
end type

event clicked;call super::clicked;Int li_rc
Boolean	lb_cash_date_valid = True //Alex Gerlants. 08/22/2018. Force Cash Date
String	ls_null //Alex Gerlants. 08/22/2018. Force Cash Date

//Alex Gerlants. 03/27/2017. Begin
Long	ll_i, ll_coil_abc_num_temp //Alex Gerlants. 03/27/2017
Boolean	lb_coil_abc_num_missing = False //Alex Gerlants. 03/27/2017

Long		ll_customer_id //Alex Gerlants. 03/09/2020. Constellium EDI
Integer	li_856_received //Alex Gerlants. 03/09/2020. Constellium EDI

dw_coil_list.AcceptText()

For ll_i = 1 To dw_coil_list.RowCount()
	ll_coil_abc_num_temp = dw_coil_list.Object.coil_abc_num[ll_i]
	
	If IsNull(ll_coil_abc_num_temp) Or ll_coil_abc_num_temp < 0 Then
		lb_coil_abc_num_missing = True
		Exit
	End If
Next

If lb_coil_abc_num_missing Then 
	MessageBox("Not All Coil ABC Numbers created", "Please create ALL Coil ABC Numbers", StopSign!)
	Return -1
End If
//Alex Gerlants. 03/27/2017. End

//Confirmation
li_rc = MessageBox("Confirmation", "Are you sure you want to save the BOL and create ABC coil(s)?", Question!, YesNo!)
if li_rc = 2 then
	return 0
end if

//Alex Gerlants. Cash_Date_not_Saved_at_Receiving. Begin
//12/28/2018. As per Dan Polkinhorne, we should not check ib_cash_date_required.
//Instead, we should validate cash date if it is entered by the user.
//They agree that if cash date is required, and they miss it; this is their fault
li_rc = wf_validate_cash_date_2()

If li_rc = -1 Then //Problem in wf_validate_cash_date_2()
	Return 0
End If

////Alex Gerlants. 08/22/2018. Force Cash Date. Begin
//If ib_cash_date_required Then
//	lb_cash_date_valid = wf_validate_cash_date()
//	
//	If Not lb_cash_date_valid Then 
//		Return -1
//	End If
//Else
//	SetNull(ls_null)
//	
//	//Cash date not required. Set cash date to null
//	For ll_i = 1 To dw_coil_list.RowCount()
//		dw_coil_list.Object.cash_date[ll_i] = ls_null
//	Next
//End If
////Alex Gerlants. 08/22/2018. Force Cash Date. End

//Alex Gerlants. 03/09/2020. Constellium EDI. Begin
//ll_customer_id = dw_general_customer.Object.customer_id[1]

//If ll_customer_id = 2776 Then
	li_856_received = wf_856_received()
	
	If li_856_received = 0 Then //856 has not been received
		wf_change_alloy_temper()
	End If
//End If
//Alex Gerlants. 03/09/2020. Constellium EDI. End

parent.event ue_savebol()
end event

type cb_deletecoil from u_cb within w_coil_receiving
integer x = 2985
integer y = 1536
integer width = 562
integer height = 96
integer taborder = 160
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete Coil from BOL"
end type

event clicked;call super::clicked;parent.event ue_deletecoil()
end event

type cb_addcoil from u_cb within w_coil_receiving
integer x = 2368
integer y = 1536
integer width = 562
integer height = 96
integer taborder = 150
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Add Coil to BOL"
end type

event clicked;call super::clicked;parent.event ue_addcoil()
end event

type sle_bol from singlelineedit within w_coil_receiving
event ue_opentoinput ( )
event ue_closetoinput ( )
integer x = 969
integer y = 256
integer width = 759
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean border = false
boolean displayonly = true
end type

event ue_opentoinput();Border = true
DisplayOnly = false
BorderStyle = StyleLowered!
BackColor = 16777215	//White
end event

event ue_closetoinput();Border = false
DisplayOnly = True
BorderStyle = StyleBox!
BackColor = 79741120	//Button Face
end event

type dw_customer from u_dw within w_coil_receiving
integer x = 535
integer y = 28
integer width = 101
integer height = 36
integer taborder = 50
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
boolean righttoleft = true
end type

event clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 










end event

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//disbaled
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()


end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)
//wf_display_total_info()

Return 

end event

type st_3 from statictext within w_coil_receiving
integer x = 777
integer y = 256
integer width = 197
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "BOL # :"
boolean focusrectangle = false
end type

type st_2 from statictext within w_coil_receiving
integer x = 37
integer y = 316
integer width = 233
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "BOL List"
boolean focusrectangle = false
end type

type dw_bol from u_dw within w_coil_receiving
integer x = 32
integer y = 384
integer width = 654
integer height = 736
integer taborder = 30
string dataobject = "d_bol_archived"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_SetBase(TRUE)
//of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 ) 
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event pfc_rowchanged;call super::pfc_rowchanged;Long ll_receiving_bol_id
String ls_bol, ls_receiveddate
Int li_row, li_cur_row

if dw_coil_list.Describe("DataObject") = 'd_coil_list_by_bol_archived' then
	li_row = dw_bol.RowCount()
	if li_row > 0 then
		li_cur_row = dw_bol.GetRow()
		if li_cur_row > 0 then
			dw_bol.SelectRow(0, False)
			dw_bol.SelectRow(li_cur_row, True)
			ll_receiving_bol_id = dw_bol.GetItemNumber(li_cur_row, "receiving_bol_id")
			ls_bol = dw_bol.GetItemString(li_cur_row, "bol")
			ls_receiveddate = String(Date(dw_bol.GetItemDateTime(li_cur_row, 'received_date')))
			sle_bol.text = ls_bol
			em_receiveddate.text = ls_receiveddate
			dw_coil_list.Retrieve(ll_receiving_bol_id)
		end if
	end if
end if

end event

event rbuttondown;call super::rbuttondown;return 0
end event

event rbuttonup;call super::rbuttonup;return 0
end event

event clicked;call super::clicked;String ls_bol, ls_receiveddate
Int li_row, li_rc
Long ll_receiving_bol_id

cb_resend_861.Visible = False //Alex Gerlants. 03/09/2020. Constellium EDI

if row <= 0 then
	return 0
end if

li_rc = of_bollist()
if li_rc = 0 then
	return 0
end if

dw_bol.Event RowFocusChanged(row)
dw_bol.SelectRow(0, False)
dw_bol.SelectRow(row, True)

li_row = dw_bol.RowCount()
if (li_row > 0) and (row >0) then
		ll_receiving_bol_id = dw_bol.GetItemNumber(row, "receiving_bol_id")
		ls_bol = dw_bol.GetItemString(row, "bol")
		ls_receiveddate = String(Date(dw_bol.GetItemDateTime(row, 'received_date')))
		sle_bol.text = ls_bol
		em_receiveddate.text = ls_receiveddate
		dw_coil_list.Retrieve(ll_receiving_bol_id)
		il_receiving_bol_id = ll_receiving_bol_id //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen
		
		//dw_coil_list.Print() //Alex Gerlants. 05/30/2018. TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY
		
		wf_get_mill_source_from_coil(dw_coil_list) //Alex Gerlants. 02/09/2017
		
		cb_resend_861.Visible = True //Alex Gerlants. 03/09/2021
		cb_change_cust.Enabled = True //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen
end if
	
end event

type dw_coil_list from u_dw within w_coil_receiving
integer x = 754
integer y = 352
integer width = 2807
integer height = 1148
integer taborder = 10
string dataobject = "d_coil_list_by_bol_add"
boolean hscrollbar = true
end type

event constructor;of_SetBase(TRUE)
//of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

event pfc_deleterow;call super::pfc_deleterow;Return 1
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged() //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen. Comment out
end event

event clicked;integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

//Alex Gerlants. 07/26/2017. Comment out Begin
//IF IsValid (inv_RowSelect) THEN
//	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
//END IF
//Alex Gerlants. 07/26/2017. Comment out End

//Alex Gerlants. 07/26/2017. Begin
If This.IsSelected(row) Then
	This.SelectRow(row, False)
Else
	This.SelectRow(0, False)
	This.SelectRow(row, True)
End If
//Alex Gerlants. 07/26/2017. End

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

//IF IsValid (inv_linkage) THEN
//	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
//		inv_linkage.CONTINUE_ACTION Then
//		// The user or a service action prevents from going to the clicked row.
//		Return 1
//	End If
//END IF
//
//

//Alex Gerlants. 02/09/2017. Begin
If This.DataObject = "d_coil_list_by_bol_add" Then
	If dwo.name = "coil_from_cust_id" Then
		wf_retrieve_mill_source_dddw()
	End If
End If
//Alex Gerlants. 02/09/2017. End





////Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen. Begin
//Long	ll_row, ll_row_start, ll_row_end, ll_inserted_row
//
//If Not KeyDown(KeyControl!) And Not KeyDown(KeyShift!) Then
//	il_row_orig = row
//	
//	If IsSelected(row) Then
//		SelectRow(row, False)
//		wf_add_remove_selected_row(row, "delete")
//	Else
//		SelectRow(0, False) //Unselect all rows
//		dw_selected_rows.Reset() //Delete all rows
//		
//		SelectRow(row, True) 
//		//wf_add_remove_selected_row(row, "delete")
//		wf_add_remove_selected_row(row, "add")
//	End If
//End If
//
//If KeyDown(KeyControl!) Then
//	//MessageBox("", "KeyControl pressed")
//	
//	SelectRow(il_row_orig, True)
//	//wf_add_remove_selected_row(il_row_orig, "delete")
//	wf_add_remove_selected_row(il_row_orig, "add")
//	
//	SelectRow(row, True)
//	//wf_add_remove_selected_row(row, "delete")
//	wf_add_remove_selected_row(row, "add")
//	
//	il_row_orig = row
//End If
//
//If KeyDown(KeyShift!) Then
//	//MessageBox("", "KeyShift pressed")
//	//SelectRow(0, False) //Unselect all rows
//	
//	ll_row_start = il_row_orig
//	ll_row_end = row
//	
//	If ll_row_start < ll_row_end Then
//		For ll_row = ll_row_start To ll_row_end
//			SelectRow(ll_row, True)
//			//wf_add_remove_selected_row(ll_row, "delete")
//			wf_add_remove_selected_row(ll_row, "add")
//		Next
//	Else
//		For ll_row = ll_row_end To ll_row_start
//			SelectRow(ll_row, True)
//			//wf_add_remove_selected_row(ll_row, "delete")
//			wf_add_remove_selected_row(ll_row, "add")
//		Next
//	End If
//	
//	il_row_orig = row
//End If
//
////Return
////Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen. End
end event

event editchanged;call super::editchanged;String				ls_column_name, ls_filter_string, ls_rtn, ls_data
DataWindowChild	ldwc
Integer				li_rtn
Long					ll_rows, ll_filteredcount

ls_column_name = dwo.name

If ls_column_name = "coil_from_cust_id" Then

	li_rtn = This.GetChild("coil_from_cust_id", ldwc)
	
	If li_rtn = 1 Then
		ls_data = Upper(data)
		
		f_filter_dddw(ldwc, "customer_short_name", ls_data)
	
//		If Len(ls_data) > 0 Then
//			ls_filter_string = "Upper(" + "customer_short_name" + ") like '" + ls_data + "%'"
//		Else
//			ls_filter_string = ""
//		End If
//		
//		
//		li_rtn = ldwc.SetFilter(ls_filter_string)
//		li_rtn = ldwc.Filter()
//		
//		ll_rows = ldwc.RowCount()
//		ll_filteredcount = ldwc.FilteredCount()
	End If
End If
end event

event dberror;call super::dberror;String	ls_sqlerrtext, ls_sqlsyntax

ls_sqlerrtext = sqlerrtext
ls_sqlsyntax = sqlsyntax
end event

event retrieveend;call super::retrieveend;//Alex Gerlants. 05/30/2018. Begin
/*
	Format cash_date as mmddyyyy.
	It will presented to user as mm/dd/yyyy because column cash_date on d_coil_list_by_bol_add 
	is set up as EditMask ##/##/####
*/
Long		ll_rows, ll_row
String	ls_cash_date

ll_rows = This.RowCount()

For ll_row = 1 To ll_rows
	ls_cash_date = This.GetItemString(ll_row, "cash_date")
	If IsNull(ls_cash_date) Then ls_cash_date = ""
	
	ls_cash_date = f_format_date(ls_cash_date, "mmddyyyy")
	This.Object.cash_date[ll_row] = ls_cash_date
	
	If This.DataObject = 'd_coil_list_by_bol_archived' Then //Alex Gerlants. 05/30/2019. Arconic 861
		This.SetItemStatus(ll_row, 0, Primary!, NotModified!) //Alex Gerlants. 05/30/2019. Arconic 861
	End If //Alex Gerlants. 05/30/2019. Arconic 861
Next
//Alex Gerlants. 05/30/2018. End

end event

type cb_create from u_cb within w_coil_receiving
boolean visible = false
integer x = 27
integer y = 1712
integer width = 128
integer height = 96
integer taborder = 120
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "C&reate ABC Coil"
end type

event clicked;RETURN Parent.Event ue_create_coil()

end event

type cb_close from u_cb within w_coil_receiving
string tag = "Exit"
integer x = 3127
integer y = 1704
integer width = 471
integer taborder = 230
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Int li_rc

li_rc = of_check_updatespending()

if li_rc = 1 then
	dw_coil_list.ResetUpdate()
else
	return 0
end if


Close(Parent)
end event

type ddlb_customer from dropdownlistbox within w_coil_receiving
boolean visible = false
integer x = 23
integer y = 92
integer width = 709
integer height = 908
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_text
Long ll_row, ll_i

sle_bol.Visible = false

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		il_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		dw_bol.Retrieve(il_cust)
		dw_incomingedi.Retrieve(il_cust)
		dw_coil_list.reset()
		sle_bol.text = ""
	END IF
NEXT

sle_bol.Visible = true

dw_bol.SelectRow(0, false)
dw_incomingedi.SelectRow(0, false)


end event

type st_1 from statictext within w_coil_receiving
integer x = 27
integer y = 28
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Customer:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_coil_receiving
integer x = 713
integer y = 220
integer width = 2885
integer height = 1456
integer taborder = 130
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

