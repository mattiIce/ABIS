$PBExportHeader$w_coil_receiving_bk.srw
$PBExportComments$<Sheet> receive coil and print out barcode_abc_coil_form inherited froam pfemain/w_sheet
forward
global type w_coil_receiving_bk from w_sheet
end type
type em_receiveddate from u_em within w_coil_receiving_bk
end type
type st_6 from statictext within w_coil_receiving_bk
end type
type dw_searchincomingedi from u_dw within w_coil_receiving_bk
end type
type dw_searchbol from u_dw within w_coil_receiving_bk
end type
type dw_coil_list_edi from u_dw within w_coil_receiving_bk
end type
type cb_newbol from u_cb within w_coil_receiving_bk
end type
type st_5 from statictext within w_coil_receiving_bk
end type
type sle_searchbol from singlelineedit within w_coil_receiving_bk
end type
type cb_search from u_cb within w_coil_receiving_bk
end type
type cb_print from u_cb within w_coil_receiving_bk
end type
type st_4 from statictext within w_coil_receiving_bk
end type
type dw_incomingedi from u_dw within w_coil_receiving_bk
end type
type cb_savebol from u_cb within w_coil_receiving_bk
end type
type cb_deletecoil from u_cb within w_coil_receiving_bk
end type
type cb_addcoil from u_cb within w_coil_receiving_bk
end type
type sle_bol from singlelineedit within w_coil_receiving_bk
end type
type dw_customer from u_dw within w_coil_receiving_bk
end type
type st_3 from statictext within w_coil_receiving_bk
end type
type st_2 from statictext within w_coil_receiving_bk
end type
type dw_bol from u_dw within w_coil_receiving_bk
end type
type dw_coil_list from u_dw within w_coil_receiving_bk
end type
type cb_create from u_cb within w_coil_receiving_bk
end type
type cb_close from u_cb within w_coil_receiving_bk
end type
type ddlb_customer from dropdownlistbox within w_coil_receiving_bk
end type
type st_1 from statictext within w_coil_receiving_bk
end type
type gb_1 from groupbox within w_coil_receiving_bk
end type
end forward

global type w_coil_receiving_bk from w_sheet
string tag = "Receive coils from customer"
integer x = 4
integer y = 3
integer width = 3635
integer height = 2026
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
em_receiveddate em_receiveddate
st_6 st_6
dw_searchincomingedi dw_searchincomingedi
dw_searchbol dw_searchbol
dw_coil_list_edi dw_coil_list_edi
cb_newbol cb_newbol
st_5 st_5
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
global w_coil_receiving_bk w_coil_receiving_bk

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
end variables

forward prototypes
public function integer of_bollist ()
public function integer of_incomingedi ()
public function integer of_newbol ()
public function integer of_check_updatespending ()
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
Long ll_receiving_bol_id, ll_coil_abc_num, ll_row_bol, ll_j
String ls_user
DateTime ld_d
Date ld_received_date
DataStore lds_coil_abc_list_by_bol
s_bol_cust lst_bol_cust

Long  ll_damage_fault[], ll_damage_code[], ll_net_wt, ll_gross_wt
String ls_coil_orig_num[], ls_alloy, ls_temper, ls_lot, ls_pack_id 
Real lr_lineal_feed, lr_width, lr_gauge, lr_density


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
		ls_coil_orig_num[i] = dw_coil_list.GetItemString(i, "coil_org_num")
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
		
		//insert data in lds_coil_abc_list_by_bol
		li_row_add = lds_coil_abc_list_by_bol.InsertRow(0)
		ll_coil_abc_num = f_get_next_value("coil_abc_num_seq")
		lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_ABC_NUM", ll_coil_abc_num )
		dw_coil_list.SetItem(i, "coil_abc_num", ll_coil_abc_num)		//Set ABC Coil# in dw_coil_list for updating later
      lds_coil_abc_list_by_bol.SetItem(li_row_add, "COIL_COIL_ORG_NUM",  ls_coil_orig_num[i]) 
      
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
next

//check if coil conflicts with existing coils?

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
END IF

//update receiving_bol_coil
dw_coil_list.Update()
IF SQLCA.SQLCode = -1 THEN 
   MessageBox("SQL error", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	MessageBox("Error", "Cannot save into receiving_bol_coil.", StopSign!)
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
	END IF
next

COMMIT USING SQLCA;


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
				END IF
NEXT	

return 1
end event

event type integer ue_newbol();Int li_rc

if il_cust = 0 then
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

//if the entered BOL valid
ls_bol = Trim(sle_searchbol.text)
if len(ls_bol) < 1 then
	MessageBOx("Invalid BOL Entered", "Please enter a valid BOL number")
	return 0
end if

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
				END IF
			NEXT			
		END IF
	NEXT	
	
	MessageBox("Search Result", "BOL matched found in BOL list.")
	return 1
end if

//search in Incoming EDI
dw_searchincomingedi.Retrieve(ls_bol)
li_rc = dw_searchincomingedi.RowCount()
if li_rc < 1 then
	MessageBox("Search Result", "No BOL matched found.")
else
	if of_incomingedi() = 0 then
		return 0
	end if
	
	sle_bol.text = ls_bol
	ll_cust_id = dw_searchincomingedi.GetItemNumber(1, "customer_id")		//pick the first matched one
	ll_edi_file_id = dw_searchincomingedi.GetItemNumber(1, "edi_file_id")
	il_cust = ll_cust_id
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
cb_print.Enabled = false
cb_addcoil.Enabled = true
cb_deletecoil.Enabled = true
sle_bol.event GetFocus()

return 1
end function

public function integer of_check_updatespending ();//check if there is updates pending in dw_coil_list, then give warning message
//if return 0, cancel the next step

Int li_rc, li_answer

dw_coil_list.AcceptText()
li_rc = dw_coil_list.of_UpdatesPending()
if li_rc = 1 then
	li_answer = MessageBox("Warning", "Do you want to save the current BOL and its coil data?", Question!, YesNoCancel!)
	choose case li_answer
	case 1
		this.event ue_savebol()
		return 1
	case 2
		return 1
	case 3
		return 0	
	end choose

end if

return 1

end function

on w_coil_receiving_bk.create
int iCurrent
call super::create
if this.MenuName = "m_receive_coil" then this.MenuID = create m_receive_coil
this.em_receiveddate=create em_receiveddate
this.st_6=create st_6
this.dw_searchincomingedi=create dw_searchincomingedi
this.dw_searchbol=create dw_searchbol
this.dw_coil_list_edi=create dw_coil_list_edi
this.cb_newbol=create cb_newbol
this.st_5=create st_5
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
this.Control[iCurrent+1]=this.em_receiveddate
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.dw_searchincomingedi
this.Control[iCurrent+4]=this.dw_searchbol
this.Control[iCurrent+5]=this.dw_coil_list_edi
this.Control[iCurrent+6]=this.cb_newbol
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.sle_searchbol
this.Control[iCurrent+9]=this.cb_search
this.Control[iCurrent+10]=this.cb_print
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.dw_incomingedi
this.Control[iCurrent+13]=this.cb_savebol
this.Control[iCurrent+14]=this.cb_deletecoil
this.Control[iCurrent+15]=this.cb_addcoil
this.Control[iCurrent+16]=this.sle_bol
this.Control[iCurrent+17]=this.dw_customer
this.Control[iCurrent+18]=this.st_3
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.dw_bol
this.Control[iCurrent+21]=this.dw_coil_list
this.Control[iCurrent+22]=this.cb_create
this.Control[iCurrent+23]=this.cb_close
this.Control[iCurrent+24]=this.ddlb_customer
this.Control[iCurrent+25]=this.st_1
this.Control[iCurrent+26]=this.gb_1
end on

on w_coil_receiving_bk.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_receiveddate)
destroy(this.st_6)
destroy(this.dw_searchincomingedi)
destroy(this.dw_searchbol)
destroy(this.dw_coil_list_edi)
destroy(this.cb_newbol)
destroy(this.st_5)
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

event open;call super::open;Long ll_row, ll_i

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

of_bollist()







end event

event pfc_save;call super::pfc_save;

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

type em_receiveddate from u_em within w_coil_receiving_bk
event opentoinput ( )
event closetoinput ( )
integer x = 2352
integer y = 256
integer width = 421
integer height = 90
integer taborder = 50
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

type st_6 from statictext within w_coil_receiving_bk
integer x = 1935
integer y = 256
integer width = 410
integer height = 83
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

type dw_searchincomingedi from u_dw within w_coil_receiving_bk
integer x = 1218
integer y = 16
integer width = 238
integer height = 122
integer taborder = 30
string dataobject = "d_searchincomingedi"
end type

type dw_searchbol from u_dw within w_coil_receiving_bk
integer x = 947
integer y = 16
integer width = 274
integer height = 122
integer taborder = 50
string dataobject = "d_searchbol"
end type

type dw_coil_list_edi from u_dw within w_coil_receiving_bk
integer x = 3346
integer y = 1674
integer width = 278
integer height = 138
integer taborder = 40
string dataobject = "d_coil_list_by_bol_edi"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

type cb_newbol from u_cb within w_coil_receiving_bk
string tag = "Exit"
integer x = 402
integer y = 1715
integer width = 560
integer height = 96
integer taborder = 100
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New BOL"
end type

event clicked;call super::clicked;parent.event ue_newbol()


end event

type st_5 from statictext within w_coil_receiving_bk
integer x = 1723
integer y = 93
integer width = 600
integer height = 58
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

type sle_searchbol from singlelineedit within w_coil_receiving_bk
integer x = 2337
integer y = 74
integer width = 655
integer height = 90
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type cb_search from u_cb within w_coil_receiving_bk
integer x = 3050
integer y = 67
integer width = 366
integer height = 93
integer taborder = 50
integer weight = 700
string text = "Search BOL"
end type

event clicked;call super::clicked;parent.event ue_searchbol()
end event

type cb_print from u_cb within w_coil_receiving_bk
integer x = 1902
integer y = 1715
integer width = 560
integer height = 96
integer taborder = 100
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print Coil Barcode"
end type

event clicked;call super::clicked;parent.event ue_print()
end event

type st_4 from statictext within w_coil_receiving_bk
integer x = 40
integer y = 1165
integer width = 347
integer height = 58
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

type dw_incomingedi from u_dw within w_coil_receiving_bk
integer x = 33
integer y = 1229
integer width = 655
integer height = 445
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
		ll_edi_file_id = dw_incomingedi.GetItemNumber(row, "edi_file_id")
		ls_bol = dw_incomingedi.GetItemString(row, "bol")
		sle_bol.text = ls_bol
		em_receiveddate.text = String(Today())
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
				next
		end if	
end if

//dw_coil_list.ResetUpdate()
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

type cb_savebol from u_cb within w_coil_receiving_bk
string tag = "Exit"
integer x = 1152
integer y = 1715
integer width = 560
integer height = 96
integer taborder = 90
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Save BOL"
end type

event clicked;call super::clicked;Int li_rc

//Confirmation
li_rc = MessageBox("Confirmation", "Are you sure you want to save the BOL and create ABC coils(s)?", Question!, YesNo!)
if li_rc = 2 then
	return 0
end if

parent.event ue_savebol()
end event

type cb_deletecoil from u_cb within w_coil_receiving_bk
integer x = 2864
integer y = 1536
integer width = 560
integer height = 96
integer taborder = 100
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete Coil from BOL"
end type

event clicked;call super::clicked;parent.event ue_deletecoil()
end event

type cb_addcoil from u_cb within w_coil_receiving_bk
integer x = 2172
integer y = 1536
integer width = 560
integer height = 96
integer taborder = 90
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Add Coil to BOL"
end type

event clicked;call super::clicked;parent.event ue_addcoil()
end event

type sle_bol from singlelineedit within w_coil_receiving_bk
event ue_opentoinput ( )
event ue_closetoinput ( )
integer x = 969
integer y = 256
integer width = 761
integer height = 90
integer taborder = 40
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

type dw_customer from u_dw within w_coil_receiving_bk
integer x = 534
integer y = 26
integer width = 102
integer height = 35
integer taborder = 30
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

type st_3 from statictext within w_coil_receiving_bk
integer x = 775
integer y = 256
integer width = 197
integer height = 83
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

type st_2 from statictext within w_coil_receiving_bk
integer x = 37
integer y = 330
integer width = 234
integer height = 58
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

type dw_bol from u_dw within w_coil_receiving_bk
integer x = 33
integer y = 384
integer width = 655
integer height = 736
integer taborder = 20
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
end if
	
end event

type dw_coil_list from u_dw within w_coil_receiving_bk
integer x = 753
integer y = 352
integer width = 2809
integer height = 1149
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

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event clicked;integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

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
end event

type cb_create from u_cb within w_coil_receiving_bk
boolean visible = false
integer x = 26
integer y = 1712
integer width = 128
integer height = 96
integer taborder = 80
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "C&reate ABC Coil"
end type

event clicked;RETURN Parent.Event ue_create_coil()

end event

type cb_close from u_cb within w_coil_receiving_bk
string tag = "Exit"
integer x = 2651
integer y = 1715
integer width = 560
integer height = 96
integer taborder = 120
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

type ddlb_customer from dropdownlistbox within w_coil_receiving_bk
integer x = 22
integer y = 90
integer width = 709
integer height = 557
integer taborder = 70
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

type st_1 from statictext within w_coil_receiving_bk
integer x = 26
integer y = 26
integer width = 435
integer height = 58
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

type gb_1 from groupbox within w_coil_receiving_bk
integer x = 713
integer y = 218
integer width = 2885
integer height = 1456
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

