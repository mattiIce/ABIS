$PBExportHeader$w_inv_coil.srw
$PBExportComments$<Sheet> List all coils and all information about each coil, inherited from pfemain\w_sheet
forward
global type w_inv_coil from w_sheet
end type
type st_rows from statictext within w_inv_coil
end type
type ddlb_prior from dropdownlistbox within w_inv_coil
end type
type st_prior from statictext within w_inv_coil
end type
type rb_prior from u_rb within w_inv_coil
end type
type cb_qr_receive from commandbutton within w_inv_coil
end type
type cb_qr_manual from commandbutton within w_inv_coil
end type
type cb_qr_data from commandbutton within w_inv_coil
end type
type cbx_transfer_ready from checkbox within w_inv_coil
end type
type cb_change_status from commandbutton within w_inv_coil
end type
type rb_all from u_rb within w_inv_coil
end type
type rb_default from u_rb within w_inv_coil
end type
type dw_coil_list from u_dw within w_inv_coil
end type
type cb_new from u_cb within w_inv_coil
end type
type cb_report from u_cb within w_inv_coil
end type
type cb_delete from u_cb within w_inv_coil
end type
type dw_customer from u_dw within w_inv_coil
end type
type cb_close from u_cb within w_inv_coil
end type
type cb_sendedi from u_cb within w_inv_coil
end type
type cb_sort from u_cb within w_inv_coil
end type
type dw_rejected from u_dw within w_inv_coil
end type
type cb_modify from u_cb within w_inv_coil
end type
type cb_reference from u_cb within w_inv_coil
end type
type st_1 from statictext within w_inv_coil
end type
type st_cond from statictext within w_inv_coil
end type
type cb_search from commandbutton within w_inv_coil
end type
type cb_reset from commandbutton within w_inv_coil
end type
type gb_search from u_gb within w_inv_coil
end type
type st_2 from statictext within w_inv_coil
end type
type st_3 from statictext within w_inv_coil
end type
type st_4 from statictext within w_inv_coil
end type
type st_5 from statictext within w_inv_coil
end type
type st_6 from statictext within w_inv_coil
end type
type st_7 from statictext within w_inv_coil
end type
type st_8 from statictext within w_inv_coil
end type
type cb_save from u_cb within w_inv_coil
end type
type dw_editor from u_dw within w_inv_coil
end type
type cb_cancel from u_cb within w_inv_coil
end type
type gb_1 from u_gb within w_inv_coil
end type
type st_9 from statictext within w_inv_coil
end type
type st_10 from statictext within w_inv_coil
end type
type st_11 from statictext within w_inv_coil
end type
type st_12 from statictext within w_inv_coil
end type
type st_13 from statictext within w_inv_coil
end type
type dw_coil_history from u_dw within w_inv_coil
end type
type cb_import from u_cb within w_inv_coil
end type
type cb_archived_bol from u_cb within w_inv_coil
end type
type cb_barcode from u_cb within w_inv_coil
end type
type gb_2 from u_gb within w_inv_coil
end type
type r_1 from rectangle within w_inv_coil
end type
type ddlb_customer from dropdownlistbox within w_inv_coil
end type
end forward

global type w_inv_coil from w_sheet
string tag = "Customer Coils"
integer x = 4
integer y = 3
integer width = 3946
integer height = 2234
string title = "Coil Inventory"
string menuname = "m_coil_main"
boolean maxbox = false
boolean resizable = false
event type integer ue_printreport ( string titlestr )
event ue_menu_new ( )
event ue_menu_del ( )
event ue_sort ( )
event type string ue_whoami ( )
event ue_read_only ( )
event type any ue_get_header ( string as_id )
event ue_set_search ( datawindow adw_d )
event type integer ue_new ( )
event type integer ue_modify ( )
event type integer ue_delete ( )
event type integer ue_refer ( )
event type integer ue_report ( )
event type integer ue_import ( )
event type integer ue_show_archived ( )
event type long ue_barcode ( )
st_rows st_rows
ddlb_prior ddlb_prior
st_prior st_prior
rb_prior rb_prior
cb_qr_receive cb_qr_receive
cb_qr_manual cb_qr_manual
cb_qr_data cb_qr_data
cbx_transfer_ready cbx_transfer_ready
cb_change_status cb_change_status
rb_all rb_all
rb_default rb_default
dw_coil_list dw_coil_list
cb_new cb_new
cb_report cb_report
cb_delete cb_delete
dw_customer dw_customer
cb_close cb_close
cb_sendedi cb_sendedi
cb_sort cb_sort
dw_rejected dw_rejected
cb_modify cb_modify
cb_reference cb_reference
st_1 st_1
st_cond st_cond
cb_search cb_search
cb_reset cb_reset
gb_search gb_search
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
cb_save cb_save
dw_editor dw_editor
cb_cancel cb_cancel
gb_1 gb_1
st_9 st_9
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
dw_coil_history dw_coil_history
cb_import cb_import
cb_archived_bol cb_archived_bol
cb_barcode cb_barcode
gb_2 gb_2
r_1 r_1
ddlb_customer ddlb_customer
end type
global w_inv_coil w_inv_coil

type variables
String is_select
String is_where
s_coil_info ids_coil
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_delete
Boolean ib_new
Boolean ib_modify
Long il_cur_coil
Boolean ib_readonly
Boolean ib_allcust
Int ii_showall
Long il_index

Boolean	ib_shift_pressed_coil_list, ib_control_pressed_coil_list

Integer	ii_show_default, ii_show_prior //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
Long		il_index_prior //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
DateTime	idt_prior //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
String	is_prior //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
String	is_sql_orig_all_customers //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097
end variables

forward prototypes
public function string wf_search_terms ()
public function datawindow wf_return_dw_coil_list ()
public function integer wf_duplicated_coil ()
public function integer wf_display_total_info ()
public function string wf_display_total_terms ()
public subroutine wf_reset_condition ()
public subroutine wf_init_dwdb ()
public function long wf_get_userid (string as_name)
public function boolean wf_coil_used (long al_coil)
public subroutine wf_editing_mode ()
public subroutine wf_normal_mode ()
end prototypes

event ue_printreport;call super::ue_printreport;
Return 1
end event

event ue_menu_new;cb_new.Event Clicked()
end event

event ue_menu_del;cb_delete.Event Clicked()
end event

event ue_sort;SetPointer(HourGlass!)

String ls_null

SetNULL(ls_null)
dw_coil_list.inv_sort.of_SetSort(ls_null)
dw_coil_list.inv_sort.of_Sort()
end event

event ue_whoami;RETURN "w_inv_coil"
end event

event ue_read_only;dw_coil_list.Object.DataWindow.ReadOnly = "YES"
cb_new.Enabled = FALSE
cb_save.Enabled = FALSE
cb_delete.Enabled = FALSE
cb_modify.Enabled = FALSE
m_coil_main.m_file.m_new.Disable()
m_coil_main.m_file.m_save.Disable()
m_coil_main.m_file.m_delete.Disable()
end event

event ue_get_header;Int li_i
s_dw_header_type lstr_ht

lstr_ht.dw_header = "NULL"
lstr_ht.col_type = "NULL"

li_i = 1
DO WHILE li_i <= UpperBound(istr_dwdb)
	IF istr_dwdb[li_i].dw_column = as_id THEN
		 lstr_ht.dw_header = istr_dwdb[li_i].dw_header
		 lstr_ht.col_type = istr_dwdb[li_i].col_type
	END IF
	li_i++
LOOP

RETURN lstr_ht
end event

event ue_set_search(datawindow adw_d);Long ll_row, ll_l
String ls_s
Int li_i, li_s

ll_row = adw_d.RowCount()
IF ll_row < 1 THEN RETURN
FOR ll_l = 1 TO ll_row
	IF Len(ls_s) > 1 THEN ls_s = ls_s + ', '
	ls_s = ls_s + adw_d.getItemString(ll_l, "column_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
NEXT
st_cond.Text = ls_s

wf_reset_condition()

li_s = 1
FOR ll_l = 1 TO ll_row
	li_i = 1
	DO WHILE li_i <= Upperbound(istr_dwdb)
		IF istr_dwdb[li_i].dw_header = adw_d.getItemString(ll_l, "column_t", Primary!, FALSE) THEN
			istr_search[li_s].db_name = istr_dwdb[li_i].db_name
			istr_search[li_s].db_field = istr_dwdb[li_i].db_field
			istr_search[li_s].col_type = istr_dwdb[li_i].col_type
			istr_search[li_s].operator = adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
			istr_search[li_s].value = adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
			IF istr_search[li_s].col_type = "status" THEN
					CHOOSE CASE Upper(Trim(istr_search[li_s].value))
					CASE "DONE"
						istr_search[li_s].value = "0"
					CASE "INPROCESS"
						istr_search[li_s].value = "1"					
					CASE "NEW"
						istr_search[li_s].value = "2"					
					CASE "REJECTED"
						istr_search[li_s].value = "3"					
					CASE "ONHOLD"
						istr_search[li_s].value = "4"					
					CASE "INTRANSIT"
						istr_search[li_s].value = "5"
					CASE "RETURN"
						istr_search[li_s].value = "6"
					CASE "REBANDED"
						istr_search[li_s].value = "7"
					CASE "RETRY"
						istr_search[li_s].value = "8"
					CASE "GONE"
						istr_search[li_s].value = "10"
						
					//Alex Gerlants. 03/18/2019. Add_Scrap_Status_To_Coil_Search. Begin
					CASE "SCRAP"
						istr_search[li_s].value = "14"
					//Alex Gerlants. 03/18/2019. Add_Scrap_Status_To_Coil_Search. End	
					
					//Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Begin
					Case "OWNERSHIP TRANSFERRED"
						istr_search[li_s].value = "13"
					Case "COIL FOR WH ITEMS"
						istr_search[li_s].value = "20"
					//Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. End
					
					CASE ELSE
						istr_search[li_s].value = "9999"
				END CHOOSE
			END IF
			IF istr_search[li_s].col_type = "customer" THEN
					istr_search[li_s].value = String(wf_get_userid(istr_search[li_s].value))
			END IF
			
			////Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Begin
			//If istr_search[li_s].col_type = "string" Then
			//		istr_search[li_s].value = Upper(istr_search[li_s].value)
			//End If
			////Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. End
			
			li_s++
		END IF
	li_i++
	LOOP
NEXT

dw_coil_list.Event ue_search_retrieve()

end event

event ue_new;SetPointer(HourGlass!)

Long ll_row, ll_c_id
s_coil_info lds_coil

ll_row = dw_customer.GetRow()
ll_c_id = dw_customer.GetItemNumber(ll_row, "customer_id", Primary!, FALSE)
lds_coil.customer_id = ll_c_id
lds_coil.status = 2 //new

OpenWithParm(w_coil_detail_new, lds_coil)
ids_coil = Message.PowerObjectParm

IF ids_coil.customer_id > 0 THEN
	dw_editor.Event pfc_addRow()
	wf_editing_mode()
END IF

RETURN 1

end event

event type integer ue_modify();SetPointer(HourGlass!)

Long ll_row, ll_coil
Int li_status

ll_row = dw_coil_list.GetRow()
IF ll_row < 1 THEN RETURN -1
li_status = dw_coil_list.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)

IF li_status = 0 THEN
	MessageBox("Warning","Failed to modify this coil because it is done!", StopSign!)
	RETURN 0
END IF
IF li_status = 10 THEN
	MessageBox("Warning","Failed to modify this coil because it has been shipped!", StopSign!)
	RETURN 0
END IF

//Alex Gerlants. 02/09/2017. Begin
If li_status = 13 Then //Transferred coil
	MessageBox("Error","Failed to modify this coil because it has been transferred to another customer!", StopSign!)
	Return 0
End If
//Alex Gerlants. 02/09/2017. End

ll_coil = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)

IF ll_coil > 0 THEN
	dw_editor.Retrieve(ll_coil)
	ll_row = dw_editor.GetRow()
	IF ll_row > 0 THEN 
		dw_editor.Event ue_display_popup(ll_row)
	END IF
END IF

RETURN -1
end event

event ue_delete;SetPointer(HourGlass!)

integer li_rc, li_status
Long ll_row, ll_i, ll_coil
String ls_msg

li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	ll_row = dw_coil_list.GetRow()
	li_status = dw_coil_list.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)
	ll_coil = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
	IF li_status <> 5 THEN  //used 
		MessageBox("Error", "Only intransit coils can be deleted from inventory.", StopSign!)
		RETURN 0
	END IF
	IF wf_coil_used(ll_coil) THEN RETURN 0
	
	IF li_status = 5 THEN  //intransit
		dw_editor.Retrieve(ll_coil)
		dw_editor.inv_rowmanager.of_DeleteRow(0)
		ib_delete = TRUE
		li_rc = dw_editor.Update()
		IF li_rc = 1 THEN
			COMMIT USING SQLCA;
			il_cur_coil = dw_coil_list.GetItemNumber(dw_coil_list.Getrow(), "coil_abc_num", Primary!, FALSE)			
			dw_coil_list.Event ue_display_changing(3)
			ls_msg = "Coil# " + String(ll_coil, "########") + " was deleted by " + gnv_app.of_GetUserId() + " @" + String(Today(), "mm-dd-yyyy HH:MM.")
			f_add_system_log(ls_msg)
			wf_normal_mode()
		ELSE
			ROLLBACK USING SQLCA;
			RETURN -2
		END IF
	END IF
END IF

RETURN 1


end event

event ue_refer;SetPointer(HourGlass!)

Long ll_row, ll_coil

ll_row = dw_coil_list.GetRow()
IF ll_row < 1 THEN RETURN -1
ll_coil = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
IF ll_coil > 0 THEN
	OpenWithParm(w_coil_detail_info, ll_coil)
END IF

RETURN 1
end event

event type integer ue_report();SetPointer(HourGlass!)

long ll_row_cut
String ls_cust_name

ll_row_cut = dw_customer.GetRow()
ls_cust_name = dw_customer.GetItemString(ll_row_cut, "customer_short_name", Primary!, TRUE)
ls_cust_name = Upper(ls_cust_name)
ls_cust_name = Trim(ls_cust_name)
ls_cust_name = ls_cust_name + " INVENTORY "

OpenWithParm(w_report_inv_coil, dw_coil_list )

RETURN 1

end event

event type integer ue_import();Int li_rc
Long ll_i, ll_row, ll_cust
String ls_text

SetPointer(HourGlass!)

ls_text = ddlb_customer.text
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
			dw_customer.Event RowFocusChanged(ll_i)
			dw_customer.SelectRow(0, False)
			dw_customer.SelectRow(ll_i, True)
			ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		END IF
NEXT

Int rc
SELECT COUNT("INBOUND_SHIPMENT_CUSTOMER"."CUSTOMER_ID")  
INTO :RC  
FROM "INBOUND_SHIPMENT_CUSTOMER"  
WHERE "INBOUND_SHIPMENT_CUSTOMER"."CUSTOMER_ID" = :LL_CUST   
USING SQLCA;

IF rc > 0 THEN
	OpenWithParm(w_bol,ll_cust)
ELSE
	MessageBox("Error", "No coil available to import for this customer.", Information!, OK!)
END IF

dw_coil_list.Retrieve(ll_cust)
wf_display_total_info()

RETURN 1
end event

event type integer ue_show_archived();Int li_rc
Long ll_i, ll_row, ll_cust
String ls_text

SetPointer(HourGlass!)

ls_text = ddlb_customer.text
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
		IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
			dw_customer.Event RowFocusChanged(ll_i)
			dw_customer.SelectRow(0, False)
			dw_customer.SelectRow(ll_i, True)
			ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		END IF
NEXT

Int rc
SELECT COUNT("INBOUND_SHIPMENT_CUSTOMER"."CUSTOMER_ID")  
INTO :RC  
FROM "INBOUND_SHIPMENT_CUSTOMER"  
WHERE "INBOUND_SHIPMENT_CUSTOMER"."CUSTOMER_ID" = :LL_CUST   
USING SQLCA;

IF rc > 0 THEN
	OpenWithParm(w_archived_bol,ll_cust)
ELSE
	MessageBox("Error", "No archived BOL for this customer.", Information!, OK!)
END IF

RETURN 1


end event

event ue_barcode;SetPointer(HourGlass!)

long ll_coil, ll_row

ll_row = dw_coil_list.GetRow()
ll_coil = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num", Primary!, TRUE)
IF ll_coil > 0 THEN OpenWithParm(w_report_coil_barcode_new, ll_coil )

RETURN 1

end event

public function string wf_search_terms ();String ls_terms
integer li_i

Long		ll_pos, ll_where_length //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
String	ls_text, ls_left_part, ls_right_part //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error

Integer	li_k //Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items
String	ls_col_type, la_left_part, la_right_part //Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items

ls_terms = is_where

If dw_coil_list.DataObject = "d_coil_list_allcust_2" Then //ALL CUSTOMERS
	//Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Begin
	For li_k = 1 To UpperBound(istr_search[])
		ls_col_type = istr_search[li_k].col_type
		If ls_col_type = "status" Then
			ls_terms = ""
			Exit
		End If
	Next
Else
	For li_k = 1 To UpperBound(istr_search[])
		ls_col_type = istr_search[li_k].col_type
		If ls_col_type = "status" Then
			ll_pos = Pos(ls_terms, "NOT IN (0, 10, 13, 20)", 1)
			
			If ll_pos > 0 Then
				ll_pos = ll_pos - 31
				la_left_part = Left(ls_terms, ll_pos - 1)
				ls_right_part = Right(ls_terms, Len(ls_terms) - ll_pos - 53)
				ls_terms = la_left_part + ls_right_part
			End If
			Exit
		End If
	Next
End If
//Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. End

li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		
		//Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097. Begin
		If dw_coil_list.DataObject = "d_coil_list_allcust_2" Then //ALL CUSTOMERS
			CHOOSE CASE istr_search[li_i].col_type
				CASE "number"
					If Len(ls_terms) >= 2 Then
						ls_terms = ls_terms + " AND " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value
					Else
						ls_terms = " WHERE " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value
					End If
				CASE "customer"
					If Len(ls_terms) >= 2 Then
						ls_terms = ls_terms + " AND " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value
					Else
						ls_terms = " WHERE " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value
					End If
				CASE "status"
					If Len(ls_terms) >= 2 Then
						ls_terms = ls_terms + " AND " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value
					Else
						ls_terms = " WHERE " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value
					End If
				CASE "date"
					If Len(ls_terms) >= 2 Then
						ls_terms = ls_terms + " AND " + "TO_DATE(TO_CHAR(" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + ", 'DD-MON-YYYY'), 'DD-MON-YYYY')" + " " + istr_search[li_i].operator + " TO_DATE('" + istr_search[li_i].value + "','mm/dd/yyyy')"
					Else
						ls_terms = " WHERE " + "TO_DATE(TO_CHAR(" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + ", 'DD-MON-YYYY'), 'DD-MON-YYYY')" + " " + istr_search[li_i].operator + " TO_DATE('" + istr_search[li_i].value + "','mm/dd/yyyy')"
					End If
				CASE "string"
					If Len(ls_terms) >= 2 Then
						ls_terms = ls_terms + " AND " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + "'" + istr_search[li_i].value + "'"
					Else
						ls_terms = " WHERE " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + "'" + istr_search[li_i].value + "'"
					End If
			END CHOOSE
		Else
		//Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097. End
		
			CHOOSE CASE istr_search[li_i].col_type
				CASE "number"
					IF Len(ls_terms) < 2 THEN 
						ls_terms = " WHERE " + " ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
					ELSE
						ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
					END IF
				CASE "customer"
					IF Len(ls_terms) < 2 THEN 
						ls_terms = " WHERE ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
					ELSE
						ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
					END IF
				CASE "status"
					IF Len(ls_terms) < 2 THEN 
						ls_terms = " WHERE ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
					ELSE
						ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
					END IF
				CASE "date"
					IF Len(ls_terms) < 2 THEN 
						ls_terms =" WHERE (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
					ELSE
						ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
					END IF
				CASE "string"
					IF Len(ls_terms) < 2 THEN 
						ls_terms = " WHERE ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
					ELSE
						ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
					END IF
			END CHOOSE
		End If //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097
	END IF
	li_i++
LOOP

Return ls_terms
end function

public function datawindow wf_return_dw_coil_list ();Return dw_coil_list
end function

public function integer wf_duplicated_coil ();//If there are duplcated coil_orig_num then return 1 else return 0
Long ll_row
Long ll_new
Long ll_id, ll_old_id
String ls_num
Int li_rc

ll_row = dw_coil_list.RowCount()
IF ll_row <= 0 THEN Return 1
ll_new = dw_editor.GetRow()
IF ll_new < 1 THEN RETURN 2
ll_id = dw_editor.GetItemNumber(ll_new, "coil_abc_num" )
ls_num = dw_editor.GetItemString(ll_new, "coil_org_num")

ll_old_id = 0
IF Len(ls_num) > 1 THEN
	CONNECT USING SQLCA;
	SELECT coil_abc_num INTO :ll_old_id
	FROM coil
	WHERE coil_org_num = :ls_num
	USING SQLCA;
	IF (ll_id <> ll_old_id) AND (ll_old_id > 1) THEN
		li_rc = MessageBox("Warning","Coil #" + String(ll_id) + " and coil #" + String(ll_old_id) +" have duplicated coil original numbers, Continue?", Question!,YesNo!, 2)
		IF li_rc = 2 THEN Return -1
	END IF
END IF

ls_num = dw_editor.GetItemString(ll_new, "coil_mid_num")
ll_old_id = 0
IF Len(ls_num) > 1 THEN
	CONNECT USING SQLCA;
	SELECT coil_abc_num INTO :ll_old_id
	FROM coil
	WHERE coil_org_num = :ls_num
	USING SQLCA;
	IF (ll_id <> ll_old_id) AND (ll_old_id > 1) THEN
		li_rc = MessageBox("Warning","Coil #" + String(ll_id) + " and coil #" + String(ll_old_id) +" have duplicated Alt. Coil Numbers, Continue?", Question!,YesNo!, 2)
		IF li_rc = 2 THEN Return -2
	END IF
END IF

Return 1
end function

public function integer wf_display_total_info ();String ls_where, ls_select
Long ll_item, ll_row, ll_cust, ll_rc

ls_where = wf_display_total_terms()
IF IsNULL(ls_where) THEN RETURN 0

CONNECT USING SQLCA;

ls_select = "SELECT COUNT(coil_abc_num) FROM coil "

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
String ls_Mysql
ls_Mysql = ls_select + ls_where
PREPARE SQLSA FROM :ls_Mysql;
OPEN DYNAMIC my_cursor;
FETCH my_cursor INTO :ll_item;
CLOSE my_cursor ;

IF IsNULL(ll_item) THEN ll_item = 0

IF ll_item = 0 THEN
	dw_coil_list.Object.item_t.Text = ""
ELSE
	dw_coil_list.Object.item_t.Text = String(ll_item, "#,###,###") + "  coil(s)"
END IF

RETURN 1

end function

public function string wf_display_total_terms ();String ls_terms
String ls_date, ls_op
integer li_rc
Long ll_row, ll_cust
Int li_i

SetNULL(ls_terms)
IF LEN(is_where) < 2 THEN
	ls_terms = " "
ELSE
	ll_row = dw_customer.GetRow()
	IF ll_row <= 0 THEN RETURN ls_terms
	ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
	if ii_showall = 1 then
	ls_terms = "  WHERE (CUSTOMER_ID  =" + String(ll_cust) + " )"
	else
	ls_terms = "  WHERE ( CUSTOMER_ID =" + String(ll_cust) + "and COIL_STATUS NOT IN (0, 10) )"
	end if
END IF

li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].operator <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				IF Len(ls_terms) < 2 THEN
					ls_terms = " WHERE (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				ELSE	
					ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				END IF
			CASE "customer"
				IF Len(ls_terms) < 2 THEN
					ls_terms = " WHERE (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				ELSE	
					ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				END IF
			CASE "status"
				IF Len(ls_terms) < 2 THEN
					ls_terms = " WHERE (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value + " )"
				ELSE	
					ls_terms = ls_terms + " AND (" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " " + istr_search[li_i].value + " )"
				END IF
			CASE "date"
				IF Len(ls_terms) < 2 THEN
					ls_terms = " WHERE (TO_DATE(TO_CHAR(" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + ", 'DD-MON-YYYY'), 'DD-MON-YYYY') " + istr_search[li_i].operator + " TO_DATE('" + istr_search[li_i].value + "','mm/dd/yyyy' )" + " )"
				ELSE	
					ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(" + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + ", 'DD-MON-YYYY'), 'DD-MON-YYYY') " + istr_search[li_i].operator + " TO_DATE('" + istr_search[li_i].value + "','mm/dd/yyyy' )" + " )"
				END IF
			CASE "string"
				IF Len(ls_terms) < 2 THEN
					ls_terms = " WHERE ( " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " ~'" + istr_search[li_i].value + "~' )"
				ELSE	
					ls_terms = ls_terms + " AND ( " + istr_search[li_i].db_name + "." + istr_search[li_i].db_field + " " + istr_search[li_i].operator + " ~'" + istr_search[li_i].value + "~' )"
				END IF
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public subroutine wf_reset_condition ();Int li_i
li_i = 1
DO WHILE li_i <= Upperbound(istr_search)
	istr_search[li_i].db_name = ""
	istr_search[li_i].db_field = ""
	istr_search[li_i].operator = ""
	istr_search[li_i].value = ""
	istr_search[li_i].col_type = ""
	li_i++
LOOP

end subroutine

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "COIL"
istr_dwdb[1].db_field = "COIL_ABC_NUM"
istr_dwdb[1].dw_column = "coil_abc_num"
istr_dwdb[1].col_type = "number"
istr_dwdb[1].dw_header = "Coil ABC No."

istr_dwdb[2].db_name = "COIL"
istr_dwdb[2].db_field = "COIL_ORG_NUM"
istr_dwdb[2].dw_column = "coil_org_num"
istr_dwdb[2].col_type = "string"
istr_dwdb[2].dw_header = "Coil Original No."

istr_dwdb[3].db_name = "COIL"
istr_dwdb[3].db_field = "ICRA"
istr_dwdb[3].dw_column = "icra"
istr_dwdb[3].col_type = "string"
istr_dwdb[3].dw_header = "Icra"

istr_dwdb[4].db_name = "COIL"
istr_dwdb[4].db_field = "COIL_MID_NUM"
istr_dwdb[4].dw_column = "coil_mid_num"
istr_dwdb[4].col_type = "string"
istr_dwdb[4].dw_header = "Coil Alt. No."

istr_dwdb[5].db_name = "COIL"
istr_dwdb[5].db_field = "COIL_STATUS"
istr_dwdb[5].dw_column = "coil_status"
istr_dwdb[5].col_type = "status"
istr_dwdb[5].dw_header = "Status"

istr_dwdb[6].db_name = "COIL"
istr_dwdb[6].db_field = "COIL_ALLOY2"
istr_dwdb[6].dw_column = "coil_alloy2"
istr_dwdb[6].col_type = "string"
istr_dwdb[6].dw_header = "Alloy"

istr_dwdb[7].db_name = "COIL"
istr_dwdb[7].db_field = "COIL_TEMPER"
istr_dwdb[7].dw_column = "coil_temper"
istr_dwdb[7].col_type = "string"
istr_dwdb[7].dw_header = "Temp"

istr_dwdb[8].db_name = "COIL"
istr_dwdb[8].db_field = "LOT_NUM"
istr_dwdb[8].dw_column = "lot_num"
istr_dwdb[8].col_type = "string"
istr_dwdb[8].dw_header = "Lot No."

istr_dwdb[9].db_name = "COIL"
istr_dwdb[9].db_field = "COIL_GAUGE"
istr_dwdb[9].dw_column = "coil_gauge"
istr_dwdb[9].col_type = "number"
istr_dwdb[9].dw_header = "Gauge"

istr_dwdb[10].db_name = "COIL"
istr_dwdb[10].db_field = "COIL_WIDTH"
istr_dwdb[10].dw_column = "coil_width"
istr_dwdb[10].col_type = "number"
istr_dwdb[10].dw_header = "Width"

istr_dwdb[11].db_name = "COIL"
istr_dwdb[11].db_field = "DATE_RECEIVED"
istr_dwdb[11].dw_column = "date_received"
istr_dwdb[11].col_type = "date"
istr_dwdb[11].dw_header = "Date Received"

istr_dwdb[12].db_name = "COIL"
istr_dwdb[12].db_field = "COIL_ENTRY_DATE"
istr_dwdb[12].dw_column = "coil_entry_date"
istr_dwdb[12].col_type = "date"
istr_dwdb[12].dw_header = "Coil Entry Date"

istr_dwdb[13].db_name = "COIL"
istr_dwdb[13].db_field = "NET_WT"
istr_dwdb[13].dw_column = "net_wt"
istr_dwdb[13].col_type = "number"
istr_dwdb[13].dw_header = "Net WT"

istr_dwdb[14].db_name = "COIL"
istr_dwdb[14].db_field = "PIECES_PER_CASE"
istr_dwdb[14].dw_column = "pieces_per_case"
istr_dwdb[14].col_type = "number"
istr_dwdb[14].dw_header = "Pieces/Case"

istr_dwdb[15].db_name = "COIL"
istr_dwdb[15].db_field = "COIL_LOCATION"
istr_dwdb[15].dw_column = "coil_location"
istr_dwdb[15].col_type = "string"
istr_dwdb[15].dw_header = "Location"

istr_dwdb[16].db_name = "COIL"
istr_dwdb[16].db_field = "NET_WT_BALANCE"
istr_dwdb[16].dw_column = "net_wt_balance"
istr_dwdb[16].col_type = "number"
istr_dwdb[16].dw_header = "Net Wt Balance"

istr_dwdb[17].db_name = "COIL"
istr_dwdb[17].db_field = "COIL_NOTES"
istr_dwdb[17].dw_column = "coil_notes"
istr_dwdb[17].col_type = "string"
istr_dwdb[17].dw_header = "Notes"

istr_dwdb[18].db_name = "COIL"
istr_dwdb[18].db_field = "COIL_LINE_NUM"
istr_dwdb[18].dw_column = "coil_line_num"
istr_dwdb[18].col_type = "number"
istr_dwdb[18].dw_header = "Coil Line No."

istr_dwdb[19].db_name = "COIL"
istr_dwdb[19].db_field = "COIL_FROM_CUST_ID"
istr_dwdb[19].dw_column = "coil_from_cust_id"
istr_dwdb[19].col_type = "customer"
istr_dwdb[19].dw_header = "Coil From"

istr_dwdb[20].db_name = "COIL"
istr_dwdb[20].db_field = "MATERIAL_NUM"
istr_dwdb[20].dw_column = "material_num"
istr_dwdb[20].col_type = "string"
istr_dwdb[20].dw_header = "Material Num"

istr_dwdb[21].db_name = "COIL"
istr_dwdb[21].db_field = "CONSUMED_COIL_NUM"
istr_dwdb[21].dw_column = "consumed_coil_num"
istr_dwdb[21].col_type = "string"
istr_dwdb[21].dw_header = "Consumed Coil ID"

end subroutine

public function long wf_get_userid (string as_name);Long ll_id, ll_row, ll_i
DataStore lds_u

ll_id = 0

lds_u = CREATE DataStore
lds_u.DataObject = "d_dddw_id_short"
lds_u.SetTransObject(SQLCA)
lds_u.Retrieve()

ll_row = lds_u.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF Upper(Trim(lds_u.GetItemString(ll_i, "customer_short_name"))) = Upper(Trim(as_name)) THEN
			ll_id = lds_u.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
END IF

DESTROY lds_u

RETURN ll_id
end function

public function boolean wf_coil_used (long al_coil);Boolean lb_rc
Long ll_job

lb_rc = FALSE

CONNECT USING SQLCA;
SELECT ab_job_num INTO :ll_job
FROM process_coil
WHERE coil_abc_num = :al_coil
USING SQLCA;

IF ll_job > 0 THEN
	lb_rc = TRUE
	MessageBox("Warning", "Failed to delete this coil because it has been assigned to production order #" + String(ll_job) + " already.") 
	RETURN lb_rc
END IF

SELECT order_abc_num INTO :ll_job
FROM order_coil
WHERE coil_abc_num = :al_coil
USING SQLCA;

IF ll_job > 0 THEN
	lb_rc = TRUE
	MessageBox("Warning", "Failed to delete this coil because it has been assigned to customer order #" + String(ll_job) + " already.") 
	RETURN lb_rc
END IF

RETURN lb_rc
end function

public subroutine wf_editing_mode ();cb_save.Enabled = TRUE
cb_new.Enabled = FALSE
cb_modify.Enabled = FALSE
cb_delete.Enabled = FALSE
cb_sort.Enabled = FALSE


end subroutine

public subroutine wf_normal_mode ();cb_save.Enabled = FALSE
if NOT(ib_allcust) THEN cb_new.Enabled = TRUE
cb_modify.Enabled = TRUE
cb_delete.Enabled = TRUE
cb_sort.Enabled = TRUE


end subroutine

on w_inv_coil.create
int iCurrent
call super::create
if this.MenuName = "m_coil_main" then this.MenuID = create m_coil_main
this.st_rows=create st_rows
this.ddlb_prior=create ddlb_prior
this.st_prior=create st_prior
this.rb_prior=create rb_prior
this.cb_qr_receive=create cb_qr_receive
this.cb_qr_manual=create cb_qr_manual
this.cb_qr_data=create cb_qr_data
this.cbx_transfer_ready=create cbx_transfer_ready
this.cb_change_status=create cb_change_status
this.rb_all=create rb_all
this.rb_default=create rb_default
this.dw_coil_list=create dw_coil_list
this.cb_new=create cb_new
this.cb_report=create cb_report
this.cb_delete=create cb_delete
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_sendedi=create cb_sendedi
this.cb_sort=create cb_sort
this.dw_rejected=create dw_rejected
this.cb_modify=create cb_modify
this.cb_reference=create cb_reference
this.st_1=create st_1
this.st_cond=create st_cond
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.gb_search=create gb_search
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.cb_save=create cb_save
this.dw_editor=create dw_editor
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
this.st_9=create st_9
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_13=create st_13
this.dw_coil_history=create dw_coil_history
this.cb_import=create cb_import
this.cb_archived_bol=create cb_archived_bol
this.cb_barcode=create cb_barcode
this.gb_2=create gb_2
this.r_1=create r_1
this.ddlb_customer=create ddlb_customer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_rows
this.Control[iCurrent+2]=this.ddlb_prior
this.Control[iCurrent+3]=this.st_prior
this.Control[iCurrent+4]=this.rb_prior
this.Control[iCurrent+5]=this.cb_qr_receive
this.Control[iCurrent+6]=this.cb_qr_manual
this.Control[iCurrent+7]=this.cb_qr_data
this.Control[iCurrent+8]=this.cbx_transfer_ready
this.Control[iCurrent+9]=this.cb_change_status
this.Control[iCurrent+10]=this.rb_all
this.Control[iCurrent+11]=this.rb_default
this.Control[iCurrent+12]=this.dw_coil_list
this.Control[iCurrent+13]=this.cb_new
this.Control[iCurrent+14]=this.cb_report
this.Control[iCurrent+15]=this.cb_delete
this.Control[iCurrent+16]=this.dw_customer
this.Control[iCurrent+17]=this.cb_close
this.Control[iCurrent+18]=this.cb_sendedi
this.Control[iCurrent+19]=this.cb_sort
this.Control[iCurrent+20]=this.dw_rejected
this.Control[iCurrent+21]=this.cb_modify
this.Control[iCurrent+22]=this.cb_reference
this.Control[iCurrent+23]=this.st_1
this.Control[iCurrent+24]=this.st_cond
this.Control[iCurrent+25]=this.cb_search
this.Control[iCurrent+26]=this.cb_reset
this.Control[iCurrent+27]=this.gb_search
this.Control[iCurrent+28]=this.st_2
this.Control[iCurrent+29]=this.st_3
this.Control[iCurrent+30]=this.st_4
this.Control[iCurrent+31]=this.st_5
this.Control[iCurrent+32]=this.st_6
this.Control[iCurrent+33]=this.st_7
this.Control[iCurrent+34]=this.st_8
this.Control[iCurrent+35]=this.cb_save
this.Control[iCurrent+36]=this.dw_editor
this.Control[iCurrent+37]=this.cb_cancel
this.Control[iCurrent+38]=this.gb_1
this.Control[iCurrent+39]=this.st_9
this.Control[iCurrent+40]=this.st_10
this.Control[iCurrent+41]=this.st_11
this.Control[iCurrent+42]=this.st_12
this.Control[iCurrent+43]=this.st_13
this.Control[iCurrent+44]=this.dw_coil_history
this.Control[iCurrent+45]=this.cb_import
this.Control[iCurrent+46]=this.cb_archived_bol
this.Control[iCurrent+47]=this.cb_barcode
this.Control[iCurrent+48]=this.gb_2
this.Control[iCurrent+49]=this.r_1
this.Control[iCurrent+50]=this.ddlb_customer
end on

on w_inv_coil.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_rows)
destroy(this.ddlb_prior)
destroy(this.st_prior)
destroy(this.rb_prior)
destroy(this.cb_qr_receive)
destroy(this.cb_qr_manual)
destroy(this.cb_qr_data)
destroy(this.cbx_transfer_ready)
destroy(this.cb_change_status)
destroy(this.rb_all)
destroy(this.rb_default)
destroy(this.dw_coil_list)
destroy(this.cb_new)
destroy(this.cb_report)
destroy(this.cb_delete)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_sendedi)
destroy(this.cb_sort)
destroy(this.dw_rejected)
destroy(this.cb_modify)
destroy(this.cb_reference)
destroy(this.st_1)
destroy(this.st_cond)
destroy(this.cb_search)
destroy(this.cb_reset)
destroy(this.gb_search)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.cb_save)
destroy(this.dw_editor)
destroy(this.cb_cancel)
destroy(this.gb_1)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.dw_coil_history)
destroy(this.cb_import)
destroy(this.cb_archived_bol)
destroy(this.cb_barcode)
destroy(this.gb_2)
destroy(this.r_1)
destroy(this.ddlb_customer)
end on

event open;call super::open;dw_rejected.Visible = FALSE
dw_customer.Visible = FALSE
dw_customer.SetTransObject(SQLCA)
dw_customer.Retrieve()

ii_showall = 0		//show dault : all coil but done and gone
rb_default.checked = true
rb_all.checked = false

//Alex Gerlants. 01/11/2017. Begin
//Alex Gerlants. 05/01/2019. Added "dbo.f_get_coil_cert_recevd(coil.coil_org_num)"
//Alex Gerlants. 01/20/2022. 1382_Add_QR_Received_To_Coil_and_Prod_Screens. Added "dbo.f_get_coil_qr_recevd(coil.coil_org_num)"
//is_select = "SELECT  ~~~"COIL~~~".~~~"COIL_ABC_NUM~~~" , ~~~"COIL~~~".~~~"COIL_ORG_NUM~~~" ,~~~"COIL~~~".~~~"ICRA~~~" ,~~~"COIL~~~".~~~"COIL_MID_NUM~~~" ,~~~"COIL~~~".~~~"COIL_STATUS~~~" ,~~~"COIL~~~".~~~"COIL_ALLOY2~~~" ,           ~~~"COIL~~~".~~~"COIL_TEMPER~~~" ,~~~"COIL~~~".~~~"COIL_WIDTH~~~" ,~~~"COIL~~~".~~~"LOT_NUM~~~" , ~~~"COIL~~~".~~~"COIL_GAUGE~~~" ,~~~"COIL~~~".~~~"DATE_RECEIVED~~~" , ~~~"COIL~~~".~~~"COIL_ENTRY_DATE~~~" ,~~~"COIL~~~".~~~"NET_WT~~~" ,~~~"COIL~~~".~~~"PIECES_PER_CASE~~~" , ~~~"COIL~~~".~~~"COIL_LOCATION~~~" ,~~~"COIL~~~".~~~"NET_WT_BALANCE~~~" , ~~~"COIL~~~".~~~"COIL_NOTES~~~" , ~~~"COIL~~~".~~~"COIL_LINE_NUM~~~" ,~~~"COIL~~~".~~~"COIL_EDI856_STATUS~~~" ,~~~"COIL~~~".~~~"CUSTOMER_ID~~~", ~~~"COIL~~~".~~~"COIL_FROM_CUST_ID~~~", f_get_coil_duration(coil.coil_abc_num), f_get_rejected_date(coil.coil_abc_num), f_get_onhold_date(coil.coil_abc_num), f_get_rebanded_date(coil.coil_abc_num),~~~"COIL~~~".~~~"ABCO_COIL_NET_WT~~~",~~~"COIL~~~".~~~"CONSUMED_COIL_NUM~~~",~~~"COIL~~~".~~~"MATERIAL_NUM~~~",~~~"COIL~~~".~~~"CASH_DATE~~~"  FROM ~~~"COIL~~~"    "  

//Alex Gerlants. 06/24/2022. 1593_Remove_QR_Recvd_And_863_Recvd_From_Coil_App. Removed "dbo.f_get_coil_cert_recevd(coil.coil_org_num)" and "dbo.f_get_coil_qr_recevd(coil.coil_org_num)"
is_select = "SELECT  ~~~"COIL~~~".~~~"COIL_ABC_NUM~~~" , ~~~"COIL~~~".~~~"COIL_ORG_NUM~~~" ,~~~"COIL~~~".~~~"ICRA~~~" ,~~~"COIL~~~".~~~"COIL_MID_NUM~~~" ,~~~"COIL~~~".~~~"COIL_STATUS~~~" ,~~~"COIL~~~".~~~"COIL_ALLOY2~~~" ,           ~~~"COIL~~~".~~~"COIL_TEMPER~~~" ,~~~"COIL~~~".~~~"COIL_WIDTH~~~" ,~~~"COIL~~~".~~~"LOT_NUM~~~" , ~~~"COIL~~~".~~~"COIL_GAUGE~~~" ,~~~"COIL~~~".~~~"DATE_RECEIVED~~~" , ~~~"COIL~~~".~~~"COIL_ENTRY_DATE~~~" ,~~~"COIL~~~".~~~"NET_WT~~~" ,~~~"COIL~~~".~~~"PIECES_PER_CASE~~~" , ~~~"COIL~~~".~~~"COIL_LOCATION~~~" ,~~~"COIL~~~".~~~"NET_WT_BALANCE~~~" , ~~~"COIL~~~".~~~"COIL_NOTES~~~" , ~~~"COIL~~~".~~~"COIL_LINE_NUM~~~" ,~~~"COIL~~~".~~~"COIL_EDI856_STATUS~~~" ,~~~"COIL~~~".~~~"CUSTOMER_ID~~~", ~~~"COIL~~~".~~~"COIL_FROM_CUST_ID~~~", f_get_coil_duration(coil.coil_abc_num), f_get_rejected_date(coil.coil_abc_num), f_get_onhold_date(coil.coil_abc_num), f_get_rebanded_date(coil.coil_abc_num),~~~"COIL~~~".~~~"ABCO_COIL_NET_WT~~~",~~~"COIL~~~".~~~"CONSUMED_COIL_NUM~~~",~~~"COIL~~~".~~~"MATERIAL_NUM~~~",~~~"COIL~~~".~~~"CASH_DATE~~~",~~~"COIL~~~".~~~"COIL_ABC_NUM_PREVIOUS~~~",~~~"COIL~~~".~~~"CUSTOMER_ID_PREVIOUS~~~",~~~"COIL~~~".~~~"COIL_ABC_NUM_NEW~~~",~~~"COIL~~~".~~~"CUSTOMER_ID_NEW~~~",~~~"COIL~~~".~~~"CNTRY_OF_CAST~~~"  FROM ~~~"COIL~~~"    "  
//Alex Gerlants. 01/11/2017. End

wf_init_dwdb()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.AddItem("ALL CUSTOMERS")
ddlb_customer.SelectItem(1)
ddlb_customer.Event SelectionChanged(1)


dw_coil_list.of_SetLinkage(TRUE)
//dw_coil_list.inv_Linkage.of_SetStyle(2)
dw_coil_list.inv_linkage.of_SetConfirmOnRowChange (True)
dw_coil_list.inv_linkage.of_setUpdateOnRowChange (TRUE)
//dw_coil_list.inv_linkage.of_SetTransObject(SQLCA)

dw_coil_history.of_SetLinkage( TRUE ) 
dw_coil_history.inv_Linkage.of_SetMaster(dw_coil_list)
IF NOT dw_coil_history.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link coil & coil history in win w_inv_coil" )
ELSE
	dw_coil_history.inv_Linkage.of_Register( "coil_abc_num", "coil_abc_num" ) 
	dw_coil_history.inv_Linkage.of_SetStyle( dw_coil_history.inv_linkage.RETRIEVE ) 
END IF

//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. Begin
For ll_i = 1 To 20
	ddlb_prior.AddItem(String(ll_i))
Next

ii_show_default = 1
ii_showall = 0
ii_show_prior = 0

ddlb_prior.SelectItem(3)
il_index_prior = 3
ddlb_prior.Visible = False
st_prior.Visible = False
//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. End




end event

event pfc_save;SetPointer(HourGlass!)
Long ll_rj, ll_rc, ll_i, ll_temp, ll_newrow
Long ll_coil
Int li_rc, li_flag, li_status

dw_editor.AcceptText()
IF dw_editor.RowCount() < 1 THEN RETURN 0

IF wf_duplicated_coil() < 0 THEN Return -1

IF ib_delete THEN
	ll_rc = dw_coil_list.GetRow()
	ll_coil = dw_coil_list.GetItemNumber(ll_rc, "coil_abc_num")
	li_status = 0
ELSE
	ll_rc = dw_editor.GetRow()
	ll_coil = dw_editor.GetItemNumber(ll_rc, "coil_abc_num", Primary!, FALSE) 
	li_status = dw_editor.GetItemNumber(ll_rc, "coil_status", Primary!, FALSE)
END IF

dw_rejected.Retrieve(ll_coil)
ll_rj = dw_rejected.RowCount()

IF ( ll_rj > 0 ) AND (ll_coil > 0) THEN
	ll_temp = 0
	//delete rejected
	FOR ll_i = 1 TO ll_rj
		IF dw_rejected.GetItemNumber(ll_i, "coil_abc_num") = ll_coil THEN
			li_status = dw_editor.GetItemNumber(ll_rc, "coil_status", Primary!, FALSE)
			
			//Alex Gerlants. 02/11/2019. novelis testing. Added "And (li_status <> 14)".
			//li_status = 14 is a new coil status: Scrap
			IF  (li_status > 0) AND (li_status <> 3) AND (li_status <> 6) And (li_status <> 14) THEN
				ll_temp = ll_i
			END IF
		END IF
	NEXT
	IF ll_temp > 0 THEN dw_rejected.DeleteRow(ll_temp)
END IF

//add reject or return coil
ll_rj = dw_rejected.RowCount()
IF li_status = 3 THEN
	li_flag = 0
	IF ll_rj > 0 THEN
		FOR ll_i = 1 TO ll_rj
			IF dw_rejected.GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE) = ll_coil THEN
				IF dw_rejected.GetItemNumber(ll_i, "reject_coil_status", Primary!, FALSE) <> 3 THEN
					dw_rejected.setItem(ll_i, "reject_coil_status", 3 )					
				END IF
				li_flag = 1
			END IF
		NEXT
	END IF
	IF li_flag = 0 THEN
		ll_newrow = dw_rejected.InsertRow(0)
		dw_rejected.setItem(ll_newrow, "coil_abc_num", ll_coil )
		dw_rejected.setItem(ll_newrow, "reject_coil_status", 3 )
	END IF
END IF
IF li_status = 6 THEN
	li_flag = 0
	IF ll_rj > 0 THEN
		FOR ll_i = 1 TO ll_rj
			IF dw_rejected.GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE) = ll_coil THEN
				IF dw_rejected.GetItemNumber(ll_i, "reject_coil_status", Primary!, FALSE) <> 6 THEN
					dw_rejected.setItem(ll_i, "reject_coil_status", 6 )					
				END IF
				li_flag = 1
			END IF
		NEXT
	END IF
	IF li_flag = 0 THEN
		ll_newrow = dw_rejected.InsertRow(0)
		dw_rejected.setItem(ll_newrow, "coil_abc_num", ll_coil )
		dw_rejected.setItem(ll_newrow, "reject_coil_status", 6 )
	END IF
END IF

//Alex Gerlants. 02/11/2019. novelis testing. Begin
//Added code for li_status = 14. It is a new coil status: Scrap
IF li_status = 14 THEN
	li_flag = 0
	IF ll_rj > 0 THEN
		FOR ll_i = 1 TO ll_rj
			IF dw_rejected.GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE) = ll_coil THEN
				IF dw_rejected.GetItemNumber(ll_i, "reject_coil_status", Primary!, FALSE) <> 14 THEN
					dw_rejected.setItem(ll_i, "reject_coil_status", 14 )					
				END IF
				li_flag = 1
			END IF
		NEXT
	END IF
	IF li_flag = 0 THEN
		ll_newrow = dw_rejected.InsertRow(0)
		dw_rejected.setItem(ll_newrow, "coil_abc_num", ll_coil )
		dw_rejected.setItem(ll_newrow, "reject_coil_status", 14 )
	END IF
END IF
//Alex Gerlants. 02/11/2019. novelis testing. End

li_rc = dw_editor.Update()
IF li_rc = 1 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -2
END IF
li_rc = dw_rejected.AcceptText()
li_rc = dw_rejected.Update()
IF (li_rc = 1) OR IsNULL(li_rc) THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF
IF ib_new THEN dw_coil_list.Event ue_display_changing(1)
IF ib_modify THEN dw_coil_list.Event ue_display_changing(2)
IF ib_delete THEN dw_coil_list.Event ue_display_changing(3)

dw_rejected.Reset()
dw_editor.Reset()
wf_normal_mode()

RETURN 1
end event

event close;call super::close;f_display_app()
end event

type st_rows from statictext within w_inv_coil
boolean visible = false
integer x = 2783
integer y = 2010
integer width = 1145
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_prior from dropdownlistbox within w_inv_coil
integer x = 1247
integer y = 131
integer width = 201
integer height = 502
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. Begin
String	ls_text
Integer	li_years_2subtract
Date		ld_prior

dw_coil_history.Reset()
st_rows.Text = ""
ii_showall = 0
ii_show_default = 0
ii_show_prior = 1

il_index_prior = index

ls_text = ddlb_prior.Text(il_index_prior)
li_years_2subtract = Integer(ls_text)
ld_prior = RelativeDate(Today(),  - (li_years_2subtract * 365))
idt_prior = DateTime(ld_prior, Time("00:00:00"))

is_prior = String(ld_prior, "MM/DD/YYYY")

ddlb_customer.SelectItem(il_index)
ddlb_customer.Event SelectionChanged(il_index)
//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. End
end event

type st_prior from statictext within w_inv_coil
integer x = 1463
integer y = 147
integer width = 289
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Years Prior"
boolean focusrectangle = false
end type

type rb_prior from u_rb within w_inv_coil
integer x = 1240
integer y = 64
integer width = 472
integer height = 64
string text = "All Received Prior"
end type

event clicked;call super::clicked;//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. Begin
Date		ld_prior
String	ls_text
Integer	li_years_2subtract

If This.Checked Then
	dw_coil_history.Reset()
	st_rows.Text = ""
	ii_showall = 0
	ii_show_default = 0
	ii_show_prior = 1
	ddlb_prior.Visible = True
	st_prior.Visible = True
	
	ls_text = ddlb_prior.Text(il_index_prior)
	
	li_years_2subtract = Integer(ls_text)
	
	ld_prior = RelativeDate(Today(),  - (li_years_2subtract * 365)) //3 years
	idt_prior = DateTime(ld_prior, Time("00:00:00"))
	
	is_prior = String(ld_prior, "MM/DD/YYYY")
	
	ddlb_customer.SelectItem(il_index)
	ddlb_customer.Event SelectionChanged(il_index)
End If
//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. End

end event

type cb_qr_receive from commandbutton within w_inv_coil
integer x = 684
integer y = 1981
integer width = 315
integer height = 90
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "QR Receive"
boolean default = true
end type

event clicked;//Alex Gerlants. Coil Quality. Begin
str_all_data_types	lstr_all_data_types
Long						ll_row, ll_customer_id, ll_selected_row
Long						ll_coil_abc_num
String					ls_coil_org_num, ls_bol

ll_selected_row = dw_coil_list.GetSelectedRow(0)

If ll_selected_row > 0 Then
	ll_row = dw_customer.GetRow()
	ll_customer_id = dw_customer.GetItemNumber(ll_row, "customer_id")
	ls_coil_org_num = dw_coil_list.Object.coil_org_num[ll_selected_row]
	ll_coil_abc_num = dw_coil_list.Object.coil_abc_num[ll_selected_row]
	
	lstr_all_data_types.long_var[1] = ll_customer_id
	lstr_all_data_types.string_var[1] = ls_coil_org_num
	lstr_all_data_types.long_var[2] = ll_coil_abc_num
	
	OpenWithParm(w_qr_receive, lstr_all_data_types)
End If
//Alex Gerlants. Coil Quality. End
end event

type cb_qr_manual from commandbutton within w_inv_coil
integer x = 366
integer y = 1981
integer width = 315
integer height = 90
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "QR Manual"
end type

event clicked;//Alex Gerlants. Coil Quality. Begin
str_all_data_types	lstr_all_data_types
Long						ll_selectedrow, ll_coil_abc_num
String					ls_coil_org_num

ll_selectedrow = dw_coil_list.GetSelectedRow(0)

If ll_selectedrow > 0 Then
	ls_coil_org_num = dw_coil_list.Object.coil_org_num[ll_selectedrow]
	ll_coil_abc_num = dw_coil_list.Object.coil_abc_num[ll_selectedrow]
	
	lstr_all_data_types.string_var[1] = ls_coil_org_num
	lstr_all_data_types.long_var[1] = ll_coil_abc_num

	//OpenSheetWithParm(w_qr_manual, lstr_all_data_types, gnv_app.of_getFrame(), 7, Original!)
	OpenWithParm(w_qr_manual, lstr_all_data_types)
End If
//Alex Gerlants. Coil Quality. End
end event

type cb_qr_data from commandbutton within w_inv_coil
integer x = 40
integer y = 1981
integer width = 315
integer height = 90
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "QR Data"
end type

event clicked;//Alex Gerlants. Coil Quality. Begin
Long	ll_row, ll_coil_abc_num

ll_row = dw_coil_list.GetRow()
If ll_row < 1 Then Return

ll_coil_abc_num = dw_coil_list.Object.coil_abc_num[ll_row]

OpenWithParm(w_ff_data_4coil, ll_coil_abc_num)
//Alex Gerlants. Coil Quality. End
end event

type cbx_transfer_ready from checkbox within w_inv_coil
integer x = 26
integer y = 1306
integer width = 421
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Transfer Ready"
end type

event clicked;dw_coil_list.SelectRow(0, False) //Unselect all rows Alex Gerlants. 06/07/2017

If This.Checked Then
	cb_save.Enabled = True
Else
	cb_save.Enabled = False
End If
end event

type cb_change_status from commandbutton within w_inv_coil
integer x = 26
integer y = 1411
integer width = 358
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change Status"
end type

event clicked;//Alex Gerlants. 06/07/2017. Begin
Long		ll_rows, ll_row, ll_rows_retrieved, ll_coil_abc_num
Integer	ll_answer

ll_answer = MessageBox("Are you sure?", &
		"Are you sure you want to change status of all highlighted coil(s) to 'Ready for Ownership Transfer'?", &
		Question!, YesNo!, 2)

If ll_answer = 2 Then Return

ll_rows = dw_coil_list.RowCount()

For ll_row = 1 To ll_rows
	If dw_coil_list.IsSelected(ll_row) Then
		ll_coil_abc_num = dw_coil_list.Object.coil_abc_num[ll_row]
		ll_rows_retrieved = dw_editor.Retrieve(ll_coil_abc_num)
		dw_coil_list.Object.coil_status[ll_row] = 12 //Ready for Ownership Transfer
		dw_coil_list.SetItemStatus(ll_row, 0, Primary!, NotModified!)
	End If
Next

ll_rows = dw_editor.RowCount()

For ll_row = 1 To ll_rows
	dw_editor.Object.coil_status[ll_row] = 12 //Ready for Ownership Transfer
Next
//Alex Gerlants. 06/07/2017. End
end event

type rb_all from u_rb within w_inv_coil
integer x = 944
integer y = 138
integer width = 230
integer height = 64
string text = "All"
end type

event clicked;call super::clicked;if This.Checked then
	dw_coil_history.Reset() //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	st_rows.Text = "" //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	ii_show_default = 0 //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	ii_show_prior = 0 //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	ddlb_prior.Visible = False //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	st_prior.Visible = False //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	
	ii_showall = 1
	ddlb_customer.SelectItem(il_index)
	ddlb_customer.Event SelectionChanged(il_index)
end if

end event

type rb_default from u_rb within w_inv_coil
integer x = 944
integer y = 61
integer width = 274
integer height = 64
string text = "Default"
end type

event clicked;call super::clicked;if This.Checked then
	dw_coil_history.Reset() //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	st_rows.Text = "" //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	ii_show_default = 1 //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	ii_show_prior = 0 //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	ddlb_prior.Visible = False //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	st_prior.Visible = False //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	
	ii_showall = 0
	ddlb_customer.SelectItem(il_index)
	ddlb_customer.Event SelectionChanged(il_index)
end if

end event

type dw_coil_list from u_dw within w_inv_coil
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_goto_row ( )
event ue_display_changing ( integer ai_type )
event keydown pbm_dwnkey
integer x = 26
integer y = 224
integer width = 3891
integer height = 1037
integer taborder = 10
string dataobject = "d_coil_list"
boolean hscrollbar = true
end type

event type integer ue_search_retrieve();String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer li_net

Long			ll_rows, ll_rows_cust, ll_coil_abc_num, ll_pos_where, ll_pos_customer_id //Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search
Integer		li_rtn, li_rows //Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search
String		ls_sql, ls_coil_org_num, ls_where_new, ls_sql_get_coil_abc_num_orig, ls_sql_get_coil_abc_num_new //Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search
DataStore	lds_get_coil_abc_num //Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search
String		ls_text //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
String		ls_sql_test //Alex Gerlants.12/14/2022. 1757_Oracle_Message_0097
String		ls_sql_orig, ls_add, ls_sql_new //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097
Long			ll_pos //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097

IF this.Event pfc_UpdatesPending() = 1 THEN
	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
	if li_net = 1 then
		Parent.Event pfc_Save()      
	else
	  	return 0
	end if
END IF

ls_where = wf_search_terms()
ls_text = ddlb_customer.Text(il_index) //Alex Gerlants.12/14/2022. 1757_Oracle_Message_0097. Moved from below

If dw_coil_list.DataObject = "d_coil_list_allcust_2" Then //ALL CUSTOMERS
	ls_rc = ""
Else
	ll_row = dw_customer.GetRow()
	ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
	ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
	ls_rc = this.Modify(ls_modify)
End If

IF ls_rc = "" THEN
	
	ls_sql_test = This.GetSqlSelect()
	
	//Alex Gerlants.12/14/2022. 1757_Oracle_Message_0097. Comment out. Moved above
	//ls_text = ddlb_customer.Text(il_index) //Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior
	
	//IF Len(is_where) < 2 THEN //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error. Comment out
	IF Len(is_where) < 2 Or This.DataObject = "d_coil_list_allcust_2" THEN //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error. Added "Or ls_text = "ALL CUSTOMERS""
	
		//Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097. Begin
		If This.DataObject = "d_coil_list_allcust_2" Then //ALL CUSTOMERS
		
		////Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Begin
		//If ii_show_prior = 1 Then
		//	ls_where = "  where date_received between " + "to_date('" + is_prior + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss') and to_date( '12/31/2099 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )"
		//Else
		//	ls_where = "  where coil.coil_status not in (0, 10, 13, 20)" // Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Added "20". This is coil for wh items
		//End If
		////Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. End
	
			//ls_sql_new = ls_sql_test + ls_add //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097
			ls_sql_new = is_sql_orig_all_customers + ls_where //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097
			
			dw_coil_list.SetSqlSelect(ls_sql_new)
			dw_coil_list.SetTransObject(sqlca)
		End If
		//Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097.. End
	
		ll_rows = dw_coil_list.Retrieve() //Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search. Added "ll_rows = "
	ELSE
		ll_rows_cust = dw_coil_list.Retrieve(ll_cust) //Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search. Added "ll_rows = "
	END IF
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

//Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search. Begin
If ll_rows = 1 Or ll_rows_cust = 1 Then
	//---
	If Upper(istr_search[1].db_field) = "COIL_ORG_NUM" Or Upper(istr_search[1].db_field) = "COIL_ABC_NUM" Then //2 most common searches that return 1 row
		Choose Case Upper(istr_search[1].db_field)
			Case "COIL_ORG_NUM"
				ls_coil_org_num = istr_search[1].value
				
				select	coil_abc_num
				into		:ll_coil_abc_num
				from		coil
				where		coil_org_num = :ls_coil_org_num
				using		sqlca;
				
				ll_rows = dw_coil_history.Retrieve(ll_coil_abc_num)
			Case "COIL_ABC_NUM"
				ll_coil_abc_num = Long(istr_search[1].value)
				ll_rows = dw_coil_history.Retrieve(ll_coil_abc_num)
		End Choose
	//---
	Else
		If IsValid(lds_get_coil_abc_num) Then Destroy lds_get_coil_abc_num
		lds_get_coil_abc_num = Create DataStore
		lds_get_coil_abc_num.DataObject = "d_get_coil_abc_num"
		ls_sql_get_coil_abc_num_orig = lds_get_coil_abc_num.GetSqlSelect()
		
		ls_sql = This.GetSqlSelect()
		ll_pos_where = Pos(ls_sql, "WHERE ", 1)
		
		If ll_pos_where > 0 Then
			ls_where = Right(ls_sql, Len(ls_sql) - ll_pos_where + 1)
		End If
		
		If ll_rows = 1 Then
			ls_sql_get_coil_abc_num_new = ls_sql_get_coil_abc_num_orig + " " + ls_where
			lds_get_coil_abc_num.SetTransObject(sqlca)
			li_rtn = lds_get_coil_abc_num.SetSqlSelect(ls_sql_get_coil_abc_num_new)
			
			If li_rtn = 1 Then //OK
				//lds_get_coil_abc_num.SetTransObject(sqlca)
				li_rows = lds_get_coil_abc_num.Retrieve() //Should be 1 row
				
				If li_rows > 0 Then
					ll_coil_abc_num = lds_get_coil_abc_num.Object.coil_abc_num[1]
					ll_rows = dw_coil_history.Retrieve(ll_coil_abc_num)
				End If
			End If
		ElseIf ll_rows_cust = 1 Then
			If Len(ls_where) > 0 Then
				ll_pos_customer_id = Pos(ls_where, ":Customer_id", 1)
				
				If ll_pos_customer_id > 0 Then
					ls_where_new = Replace(ls_where, ll_pos_customer_id, 12, String(ll_cust))
					ls_sql_get_coil_abc_num_new = ls_sql_get_coil_abc_num_orig + " " + ls_where_new
					lds_get_coil_abc_num.SetTransObject(sqlca)
					li_rtn = lds_get_coil_abc_num.SetSqlSelect(ls_sql_get_coil_abc_num_new)
					
					If li_rtn = 1 Then //OK
						//lds_get_coil_abc_num.SetTransObject(sqlca)
						li_rows = lds_get_coil_abc_num.Retrieve() //Should be 1 row
						
						If li_rows > 0 Then
							ll_coil_abc_num = lds_get_coil_abc_num.Object.coil_abc_num[1]
							ll_rows = dw_coil_history.Retrieve(ll_coil_abc_num)
						End If
					End If
				End If
			End If
		End If
		
		If IsValid(lds_get_coil_abc_num) Then Destroy lds_get_coil_abc_num
	End If //If Upper(istr_search[1].db_field) = "COIL_ORG_NUM" Or Upper(istr_search[1].db_field) = "COIL_ABC_NUM" Then
Else
	dw_coil_history.Reset()
End If //If ll_rows = 1 Or ll_rows_cust = 1 Then
//Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search. End

Return 1
end event

event ue_resume_where();String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
String	ls_sql_new, ls_sql_add
String	ls_text //Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior
Integer	li_rtn

ls_text = ddlb_customer.Text(il_index) //Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior

wf_reset_condition()

st_rows.Text = "" //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior

If ls_text <> "ALL CUSTOMERS" Then //Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior 
	ll_row = dw_customer.GetRow()
	ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
	ls_modify ="DataWindow.Table.Select = '" + is_select + is_where + " '"
	ls_rc = this.Modify(ls_modify)
	IF ls_rc = "" THEN
		
		ls_sql_new = This.GetSqlSelect()
		
		IF Len(is_where) < 2 THEN
			ll_row = this.Retrieve()
		ELSE
			ll_row = this.Retrieve(ll_cust)
		END IF
	
		wf_display_total_info()
	ELSE
		MessageBox("Error","Failure to resume datawindow!", StopSign!)
	END IF

//Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error. Begin
Else //ls_text = "ALL CUSTOMERS"
	Long		ll_pos, ll_where_length
	String	ls_left_part, ls_right_part, ls_sql_test
	
	ls_sql_test = This.GetSqlSelect()

	ls_where = is_where
	ll_where_length = Len(ls_where)
	
	ll_pos = Pos(ls_where, ":Customer_id", 1)
	
	If ll_pos > 0 Then
		ls_left_part = Left(ls_where, ll_pos - 28)
		ls_right_part = Right(ls_where, ll_where_length - ll_pos - 17)
		ls_where = ls_left_part + ls_right_part //Alex Gerlants. 12/13/2022. 1757_Oracle_Message_0097. Added " + " )"". //Alex Gerlants. 01/23/2023. Removed ' + " )"'
		
		ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
		ls_rc = this.Modify(ls_modify)
		
		If ls_rc = "" Then
			ls_sql_test = This.GetSqlSelect()
			ll_row = This.Retrieve()
		End If
	//Alex Gerlants. 02/08/2023. 1757_Oracle_Message_0097. Begin
	Else
		ls_sql_new = is_sql_orig_all_customers + ls_where
		li_rtn = This.SetSqlSelect(ls_sql_new)
		
		If li_rtn = 1 Then //OK
			ll_row = This.Retrieve()
		End If
	//Alex Gerlants. 02/08/2023. 1757_Oracle_Message_0097. End
	End If
//Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error. End

End If //Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior

dw_coil_list.Object.item_t.Text = String(ll_row, "#,###,###") + "  coil(s)" //Alex Gerlants. 12/13/2022. 1757_Oracle_Message_0097.

st_cond.Text = "All"

dw_coil_history.Reset() //Alex Gerlants. 05/11/2022. 1554_Coil_History_Shows_Wrong_Coil_After_Search



end event

event ue_goto_row;Long ll_crow, ll_trow, ll_i

IF il_cur_coil <= 0 THEN RETURN

ll_trow = RowCount()
IF ll_trow > 0 THEN
	ll_crow = 0
	FOR ll_i = 1 TO ll_trow
		IF GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE) = il_cur_coil THEN
			ll_crow = ll_i
		END IF
	NEXT
	IF ll_crow > 0 THEN
		SelectRow(0, False)
		SelectRow(ll_crow, True)
		SetRow(ll_crow)
		ScrollToRow(ll_crow)
	END IF
END IF


end event

event ue_display_changing(integer ai_type);CHOOSE CASE ai_type
	CASE 1	//new
		dw_editor.RowsCopy(dw_editor.GetRow(), dw_editor.RowCount(), Primary!, this, 1, Primary!)
		ib_new = FALSE
		wf_display_total_info()
	CASE 2	//modify
		s_coil_info lds_data
		Long ll_row
		ll_row = dw_editor.GetRow()
		lds_data.customer_id = dw_editor.GetItemNumber(ll_row, "customer_id",Primary!, FALSE)
		lds_data.ab_coil_num = dw_editor.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
		lds_data.coil_orig_num = dw_editor.GetItemString(ll_row, "coil_org_num", Primary!, FALSE)
		lds_data.coil_alt_num = dw_editor.GetItemString(ll_row, "coil_mid_num", Primary!, FALSE)
		lds_data.lot_num = dw_editor.GetItemString(ll_row, "lot_num",Primary!, FALSE)
		lds_data.pieces = dw_editor.GetItemNumber(ll_row, "pieces_per_case", Primary!, FALSE)
		lds_data.coil_line_num = dw_editor.GetItemNumber(ll_row, "coil_line_num", Primary!, FALSE)
		lds_data.icra = dw_editor.GetItemString(ll_row, "icra", Primary!, FALSE)
		lds_data.alloy = dw_editor.GetItemString(ll_row, "coil_alloy2",Primary!, FALSE)
		lds_data.gauge = dw_editor.GetItemNumber(ll_row, "coil_gauge", Primary!, FALSE)
		lds_data.Temper = dw_editor.GetItemString(ll_row, "coil_temper", Primary!, FALSE)
		lds_data.net_wt = dw_editor.GetItemNumber(ll_row, "net_wt", Primary!, FALSE)
		lds_data.net_balance = dw_editor.GetItemNumber(ll_row, "net_wt_balance", Primary!, FALSE)
		lds_data.width = dw_editor.GetItemNumber(ll_row, "coil_width", Primary!, FALSE)
		lds_data.date_received = dw_editor.GetItemDateTime(ll_row, "date_received", Primary!, FALSE)
		lds_data.location = dw_editor.GetItemString(ll_row, "coil_location", Primary!, FALSE)
		lds_data.status = dw_editor.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)
		lds_data.notes = dw_editor.GetItemString(ll_row, "coil_notes", Primary!, FALSE)
		lds_data.coil_from_cust_id = dw_editor.GetItemNumber(ll_row, "coil_from_cust_id", Primary!, FALSE)
		lds_data.consumed_coil_num = dw_editor.GetItemString(ll_row, "consumed_coil_num", Primary!, FALSE)
		lds_data.material_num = dw_editor.GetItemString(ll_row, "material_num", Primary!, FALSE)
		lds_data.cash_date = dw_editor.GetItemString(ll_row, "cash_date", Primary!, FALSE)

		IF lds_data.ab_coil_num > 0 THEN
			ll_row = dw_coil_list.GetRow()
			dw_coil_list.SetItem(ll_row, "coil_org_num",lds_data.coil_orig_num  )
			dw_coil_list.SetItem(ll_row, "coil_mid_num",lds_data.coil_alt_num)
			dw_coil_list.SetItem(ll_row, "lot_num", lds_data.lot_num   )
			dw_coil_list.SetItem(ll_row, "pieces_per_case", lds_data.pieces)
			dw_coil_list.SetItem(ll_row, "coil_line_num", lds_data.coil_line_num)
			dw_coil_list.SetItem(ll_row, "icra", lds_data.icra )
			dw_coil_list.SetItem(ll_row, "coil_alloy2", lds_data.alloy)
			dw_coil_list.SetItem(ll_row, "coil_gauge",lds_data.gauge )
			dw_coil_list.SetItem(ll_row, "coil_temper",lds_data.Temper )
			dw_coil_list.SetItem(ll_row, "net_wt",lds_data.net_wt )
			dw_coil_list.SetItem(ll_row, "net_wt_balance", lds_data.net_balance)
			dw_coil_list.SetItem(ll_row, "coil_width",lds_data.width )
			dw_coil_list.SetItem(ll_row, "date_received", lds_data.date_received)
			dw_coil_list.SetItem(ll_row, "coil_location", lds_data.location )
			dw_coil_list.SetItem(ll_row, "coil_status",lds_data.status )
			dw_coil_list.SetItem(ll_row, "coil_notes", lds_data.notes )
			dw_coil_list.SetItem(ll_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
			dw_coil_list.SetItem(ll_row, "consumed_coil_num",lds_data.consumed_coil_num)
			dw_coil_list.SetItem(ll_row, "material_num",lds_data.material_num)
			dw_coil_list.SetItem(ll_row, "cash_date",lds_data.cash_date)
		END IF
		ib_modify = FALSE
	CASE 3	//delete
		this.inv_rowmanager.of_DeleteRow(0)
		ib_delete = FALSE
		wf_display_total_info()
END CHOOSE
this.ResetUpdate()
this.Event ue_goto_row()

end event

event keydown;/*
Event:		keydown
Event Id:	pbm_dwnkey
Returns:		long
Arguments:	Passed By	Type				Name
				---------	-----------		-------
				value			keycode			key
				value			unsignedlong	keyflags
*/

ib_shift_pressed_coil_list = False
ib_control_pressed_coil_list = False

Choose Case key
	Case 	KeyShift!
		ib_shift_pressed_coil_list = True
	Case 	KeyControl!
		ib_control_pressed_coil_list = True
	Case Else
		ib_shift_pressed_coil_list = False
		ib_control_pressed_coil_list = False
End Choose

//MessageBox("keydown event for dw_coil_ownership_transfer_coil_list", &
//			"ib_shift_pressed = " + String(ib_shift_pressed_coil_list) + &
//			"~n~rib_control_pressed = " + String(ib_control_pressed_coil_list))
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

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

event rowfocuschanged;If Not cbx_transfer_ready.Checked Then //Alex Gerlants. 06/07/2017
	this.Event pfc_rowchanged()
End if //Alex Gerlants. 06/07/2017
end event

event clicked;//Override pfc_clicked

integer li_rc
Long	ll_selectedrow, ll_rc //Alex Gerlants. 06/07/2017

//MessageBox("Clicked event for dw_coil_ownership_transfer_coil_list", &
//			"ib_shift_pressed = " + String(ib_shift_pressed_coil_list) + &
//			"~n~rib_control_pressed = " + String(ib_control_pressed_coil_list) + &
//			"~n~rrow = " + String(row) + &
//			"~n~rll_selectedrow = " + String(ll_selectedrow))

//Alex Gerlants. 06/07/2017. Begin
If cbx_transfer_ready.Checked Then

	If row <= 0 Then Return

	ll_selectedrow = getselectedrow(0)  
	
	//IF KeyDown(KeyEnter!) THEN
	
	//MessageBox("Clicked event for dw_coil_ownership_transfer_coil_list", &
	//			"ib_shift_pressed = " + String(ib_shift_pressed_coil_list) + &
	//			"~n~rib_control_pressed = " + String(ib_control_pressed_coil_list) + &
	//			"~n~rrow = " + String(row) + &
	//			"~n~rll_selectedrow = " + String(ll_selectedrow))
	
	// select range  
	//IF KeyDown(KeyShift!) THEN  
	If ib_shift_pressed_coil_list Then
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
	ElseIf ib_control_pressed_coil_list Then
		IF This.IsSelected(row) THEN  
			This.SelectRow(row, False)  
		ELSE  
			This.SelectRow(row, True)  
		END IF  
	// single select  
	ELSE  
		IF This.IsSelected(row) THEN  
			This.SelectRow(0, False)  
			//This.SelectRow(row, True)  
		ELSE  
			This.SelectRow(0, False)  
			This.SelectRow(row, True)  
		END IF  
	END IF
	
	ib_shift_pressed_coil_list = False
	ib_control_pressed_coil_list = False
Else
//Existing code
//Alex Gerlants. 06/07/2017. End

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
	
	IF IsValid (inv_linkage) THEN
		If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
			inv_linkage.CONTINUE_ACTION Then
			// The user or a service action prevents from going to the clicked row.
			Return 1
		End If
	END IF
End If //Alex Gerlants. 06/07/2017


end event

event doubleclicked;// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
long ll_coil

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

IF f_security_door("Inventory(Coil)") = 0 THEN RETURN 

ll_coil = this.GetItemNumber(row, "coil_abc_num", Primary!, FALSE)

IF ll_coil > 0 THEN OpenWithParm(w_coil_detail_display, ll_coil)


end event

type cb_new from u_cb within w_inv_coil
integer x = 7
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New"
end type

event clicked;RETURN Parent.Event ue_new()

end event

type cb_report from u_cb within w_inv_coil
integer x = 2556
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reports"
end type

event clicked;RETURN Parent.Event ue_report()

end event

type cb_delete from u_cb within w_inv_coil
integer x = 1602
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;RETURN Parent.Event ue_delete()


end event

type dw_customer from u_dw within w_inv_coil
integer x = 3346
integer y = 1805
integer width = 102
integer height = 35
integer taborder = 0
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
boolean righttoleft = true
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

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

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)
wf_display_total_info()

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()


end event

type cb_close from u_cb within w_inv_coil
string tag = "Exit"
integer x = 3606
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 200
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_sendedi from u_cb within w_inv_coil
integer x = 2875
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 190
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&EDI 870"
end type

event clicked;return
/*
SetPointer(HourGlass!)

Int li_rc
li_rc = f_edi_870(40)
CHOOSE CASE li_rc
	CASE 1
		MessageBox("Info", "EDI sent successfully!" )
	CASE -1
		MessageBox("Error","EDI failed, see EDI log file for details!", StopSign!)
	CASE 100
		MessageBox("Info","EDI failed due to one of the following:~r~n 1) EDI had been sent already ~r~n 2) Customer does NOT require EDI transaction ~r~n 3) Shipment contains NO item " )
END CHOOSE
*/
end event

type cb_sort from u_cb within w_inv_coil
event clicked pbm_bnclicked
string tag = "click item then sort"
integer x = 1920
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ort"
end type

event clicked;Parent.Event ue_sort()
end event

type dw_rejected from u_dw within w_inv_coil
integer x = 3226
integer y = 1805
integer width = 80
integer height = 32
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_rejected_coil_list"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
SetTransObject(SQLCA)

end event

type cb_modify from u_cb within w_inv_coil
string tag = "modify coil information"
integer x = 1284
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;RETURN Parent.Event ue_modify()
end event

type cb_reference from u_cb within w_inv_coil
string tag = "coil details"
integer x = 2242
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 170
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Re&fer."
end type

event clicked;RETURN Parent.Event ue_refer()
end event

type st_1 from statictext within w_inv_coil
integer x = 26
integer y = 16
integer width = 538
integer height = 61
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
string text = "Current customer:"
boolean focusrectangle = false
end type

type st_cond from statictext within w_inv_coil
integer x = 1898
integer y = 51
integer width = 1752
integer height = 144
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "All"
boolean focusrectangle = false
end type

type cb_search from commandbutton within w_inv_coil
integer x = 3650
integer y = 58
integer width = 223
integer height = 74
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Search"
end type

event clicked;OpenWithParm(w_buildfilter, dw_coil_list.DataObject)
Return 1
end event

type cb_reset from commandbutton within w_inv_coil
integer x = 3650
integer y = 131
integer width = 223
integer height = 67
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;dw_coil_list.Event ue_resume_where()
end event

type gb_search from u_gb within w_inv_coil
integer x = 1840
integer y = 3
integer width = 2070
integer height = 218
integer taborder = 0
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "Search"
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_inv_coil
integer x = 26
integer y = 1805
integer width = 351
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Color indication:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_inv_coil
integer x = 384
integer y = 1805
integer width = 179
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Done"
boolean focusrectangle = false
end type

type st_4 from statictext within w_inv_coil
integer x = 571
integer y = 1805
integer width = 223
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_5 from statictext within w_inv_coil
integer x = 848
integer y = 1805
integer width = 179
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "New"
boolean focusrectangle = false
end type

type st_6 from statictext within w_inv_coil
integer x = 1028
integer y = 1805
integer width = 216
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Rejected"
boolean focusrectangle = false
end type

type st_7 from statictext within w_inv_coil
integer x = 1273
integer y = 1805
integer width = 238
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_8 from statictext within w_inv_coil
integer x = 1529
integer y = 1805
integer width = 238
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 79741120
boolean enabled = false
string text = "InTransit"
boolean focusrectangle = false
end type

type cb_save from u_cb within w_inv_coil
integer x = 3606
integer y = 1587
integer width = 307
integer height = 77
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;Parent.Event pfc_Save()

end event

type dw_editor from u_dw within w_inv_coil
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_display_popup ( long al_row )
integer x = 40
integer y = 1581
integer width = 3449
integer height = 221
integer taborder = 50
string dataobject = "d_coil_list_editor"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event type integer ue_search_retrieve();String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer li_net
String	ls_text //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error

IF this.Event pfc_UpdatesPending() = 1 THEN
	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
	if li_net = 1 then
		Parent.Event pfc_Save()      
	else
	  	return 0
	end if
END IF

ls_where = wf_search_terms()

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	ls_text = ddlb_customer.Text(il_index) //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
	
	If ls_text <> "ALL CUSTOMERS" Then //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
		this.Retrieve(ll_cust)
	Else //ls_text = "ALL CUSTOMERS" //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
		this.Retrieve() //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
	End If //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
	
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

Return 1
end event

event ue_resume_where;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id ) "
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event ue_display_popup(long al_row);s_coil_info lds_data
int li_status

lds_data.customer_id = this.GetItemNumber(al_row, "customer_id",Primary!, FALSE)
lds_data.ab_coil_num = this.GetItemNumber(al_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = this.GetItemString(al_row, "coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = this.GetItemString(al_row, "coil_mid_num", Primary!, FALSE)
lds_data.lot_num = this.GetItemString(al_row, "lot_num",Primary!, FALSE)
lds_data.pieces = this.GetItemNumber(al_row, "pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = this.GetItemNumber(al_row, "coil_line_num", Primary!, FALSE)
lds_data.icra = this.GetItemString(al_row, "icra", Primary!, FALSE)
lds_data.alloy = this.GetItemString(al_row, "coil_alloy2",Primary!, FALSE)
lds_data.gauge = this.GetItemNumber(al_row, "coil_gauge", Primary!, FALSE)
lds_data.Temper = this.GetItemString(al_row, "coil_temper", Primary!, FALSE)
lds_data.net_wt = this.GetItemNumber(al_row, "net_wt", Primary!, FALSE)
lds_data.net_balance = this.GetItemNumber(al_row, "net_wt_balance", Primary!, FALSE)
lds_data.width = this.GetItemNumber(al_row, "coil_width", Primary!, FALSE)
lds_data.date_received = this.GetItemDateTime(al_row, "date_received", Primary!, FALSE)
lds_data.location = this.GetItemString(al_row, "coil_location", Primary!, FALSE)
lds_data.status = this.GetItemNumber(al_row, "coil_status", Primary!, FALSE)
lds_data.notes = this.GetItemString(al_row, "coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = this.GetItemNumber(al_row, "coil_from_cust_id", Primary!, FALSE)
lds_data.abco_coil_net_wt = this.GetItemNumber(al_row, "abco_coil_net_wt", Primary!, FALSE)
lds_data.consumed_coil_num = this.GetItemString(al_row, "consumed_coil_num", Primary!, FALSE)
lds_data.material_num = this.GetItemString(al_row, "material_num", Primary!, FALSE)
lds_data.cash_date = this.GetItemString(al_row, "cash_date", Primary!, FALSE)

li_status = lds_data.status
OpenWithParm(w_coil_detail_2, lds_data)
IF li_status <> 0 THEN 
	lds_data = message.PowerObjectParm

	IF lds_data.ab_coil_num > 0 THEN
		//this.SetItem(al_row, "customer_id",lds_data.customer_id)
		//this.SetItem(al_row, "coil_abc_num", lds_data.ab_coil_num )
		this.SetItem(al_row, "coil_org_num",lds_data.coil_orig_num  )
		this.SetItem(al_row, "coil_mid_num",lds_data.coil_alt_num)
		this.SetItem(al_row, "lot_num", lds_data.lot_num   )
		this.SetItem(al_row, "pieces_per_case", lds_data.pieces)
		this.SetItem(al_row, "coil_line_num", lds_data.coil_line_num)
		this.SetItem(al_row, "icra", lds_data.icra )
		this.SetItem(al_row, "coil_alloy2", lds_data.alloy)
		this.SetItem(al_row, "coil_gauge",lds_data.gauge )
		this.SetItem(al_row, "coil_temper",lds_data.Temper )
		this.SetItem(al_row, "net_wt",lds_data.net_wt )
		this.SetItem(al_row, "net_wt_balance", lds_data.net_balance)
		this.SetItem(al_row, "coil_width",lds_data.width )
		this.SetItem(al_row, "date_received", lds_data.date_received)
		this.SetItem(al_row, "coil_location", lds_data.location )
		this.SetItem(al_row, "coil_status",lds_data.status )
		this.SetItem(al_row, "coil_notes", lds_data.notes )
		this.SetItem(al_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
		this.SetItem(al_row, "abco_coil_net_wt",lds_data.abco_coil_net_wt)
		this.SetItem(al_row, "consumed_coil_num",lds_data.consumed_coil_num)
		this.SetItem(al_row, "material_num",lds_data.material_num)
		this.SetItem(al_row, "cash_date",lds_data.cash_date)
		il_cur_coil = lds_data.ab_coil_num
		ib_modify = TRUE
		wf_editing_mode()
	ELSE
		this.Reset()
		ib_modify = FALSE
		wf_normal_mode()
	END IF
END IF	
end event

event clicked;//Override pfc_clicked

integer li_rc

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

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)



end event

event doubleclicked;// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
long ll_coil_number, ll_num, ll_coil

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

IF f_security_door("Inventory(Coil)") = 0 THEN RETURN 

ll_coil = this.GetItemNumber(row, "coil_abc_num", Primary!, FALSE)
IF ll_coil > 0 THEN
	this.Event ue_display_popup(row)
END IF

end event

event rbuttondown;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//disable
Return 0
end event

event pfc_deleterow;call super::pfc_deleterow;Return 1
end event

event pfc_addrow;call super::pfc_addrow;long ll_row_coil, ll_row_cut,ll_c_id, ll_new_id

ll_row_coil = this.GetRow()
ll_row_cut = dw_customer.GetRow()
ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
this.SetItem(ll_row_coil, "customer_id", ll_c_id)

Open(w_new_coil_id)
ll_new_id = Message.DoubleParm
IF ll_new_id < 1 OR ll_new_id > 99999999 THEN
	ll_new_id = f_get_next_value("coil_abc_num_seq")
END IF

this.SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
this.setItem(ll_row_coil, "coil_entry_date", Today() )
this.setItem(ll_row_coil, "coil_status", 2 )  //new coil
//dw_coil_list.setItem(ll_row_coil, "material_type", 1 ) //aluminum

this.SetItem(ll_row_coil, "coil_org_num",ids_coil.coil_orig_num  )
this.SetItem(ll_row_coil, "coil_mid_num",ids_coil.coil_alt_num)
this.SetItem(ll_row_coil, "lot_num", ids_coil.lot_num   )
this.SetItem(ll_row_coil, "pieces_per_case", ids_coil.pieces)
this.SetItem(ll_row_coil, "coil_line_num", ids_coil.coil_line_num)
this.SetItem(ll_row_coil, "icra", ids_coil.icra )
this.SetItem(ll_row_coil, "coil_alloy2", ids_coil.alloy)
this.SetItem(ll_row_coil, "coil_gauge",ids_coil.gauge )
this.SetItem(ll_row_coil, "coil_temper",ids_coil.Temper )
this.SetItem(ll_row_coil, "net_wt",ids_coil.net_wt )
this.SetItem(ll_row_coil, "net_wt_balance", ids_coil.net_balance)
this.SetItem(ll_row_coil, "coil_width",ids_coil.width )
this.SetItem(ll_row_coil, "date_received", ids_coil.date_received)
this.SetItem(ll_row_coil, "coil_location", ids_coil.location )
this.SetItem(ll_row_coil, "coil_status",ids_coil.status )
this.SetItem(ll_row_coil, "coil_notes", ids_coil.notes )
this.SetItem(ll_row_coil, "coil_from_cust_id",ids_coil.coil_from_cust_id)
this.SetItem(ll_row_coil, "abco_coil_net_wt",ids_coil.abco_coil_net_wt)
this.SetItem(ll_row_coil, "consumed_coil_num",ids_coil.consumed_coil_num)
this.SetItem(ll_row_coil, "material_num",ids_coil.material_num)
this.SetItem(ll_row_coil, "cash_date",ids_coil.cash_date)
il_cur_coil = ll_new_id
ib_new = TRUE

Return ll_row_coil
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

event retrievestart;call super::retrievestart;//Alex Gerlants. 06/07/2017. Begin
If cbx_transfer_ready.Checked Then
	Return 2 //Append retrieved rows to the existing ones
End If
//Alex Gerlants. 06/07/2017. End
end event

type cb_cancel from u_cb within w_inv_coil
integer x = 3606
integer y = 1683
integer width = 307
integer height = 77
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "C&ancel"
end type

event clicked;dw_editor.Reset()
wf_normal_mode()
end event

type gb_1 from u_gb within w_inv_coil
integer x = 26
integer y = 1533
integer width = 3482
integer height = 272
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Editor"
end type

type st_9 from statictext within w_inv_coil
integer x = 1755
integer y = 1805
integer width = 179
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Return"
boolean focusrectangle = false
end type

type st_10 from statictext within w_inv_coil
integer x = 1946
integer y = 1805
integer width = 249
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Rebanded"
boolean focusrectangle = false
end type

type st_11 from statictext within w_inv_coil
integer x = 2216
integer y = 1805
integer width = 128
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Retry"
boolean focusrectangle = false
end type

type st_12 from statictext within w_inv_coil
integer x = 2370
integer y = 1805
integer width = 179
integer height = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 79741120
boolean enabled = false
string text = "Gone"
boolean focusrectangle = false
end type

type st_13 from statictext within w_inv_coil
integer x = 453
integer y = 1245
integer width = 249
integer height = 58
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Coil History "
boolean focusrectangle = false
end type

type dw_coil_history from u_dw within w_inv_coil
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_display_popup ( long al_row )
integer x = 453
integer y = 1280
integer width = 3463
integer height = 269
integer taborder = 20
string dataobject = "d_coil_history"
end type

event type integer ue_search_retrieve();RETURN 1
String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer li_net
String	ls_text //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error

IF this.Event pfc_UpdatesPending() = 1 THEN
	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
	if li_net = 1 then
		Parent.Event pfc_Save()      
	else
	  	return 0
	end if
END IF

ls_where = wf_search_terms()

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	ls_text = ddlb_customer.Text(il_index) //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
	
	If ls_text <> "ALL CUSTOMERS" Then //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
		this.Retrieve(ll_cust)
	Else //ls_text = "ALL CUSTOMERS" //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
		this.Retrieve() //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
	End If //Alex Gerlants. 10/26/2022. 1721_Coil_All_Customers_Search_Error
		
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

Return 1
end event

event ue_resume_where;RETURN
String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row

wf_reset_condition()
ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id ) "
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
	wf_display_total_info()
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event ue_display_popup;RETURN
s_coil_info lds_data
int li_status

lds_data.customer_id = this.GetItemNumber(al_row, "customer_id",Primary!, FALSE)
lds_data.ab_coil_num = this.GetItemNumber(al_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = this.GetItemString(al_row, "coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = this.GetItemString(al_row, "coil_mid_num", Primary!, FALSE)
lds_data.lot_num = this.GetItemString(al_row, "lot_num",Primary!, FALSE)
lds_data.pieces = this.GetItemNumber(al_row, "pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = this.GetItemNumber(al_row, "coil_line_num", Primary!, FALSE)
lds_data.icra = this.GetItemString(al_row, "icra", Primary!, FALSE)
lds_data.alloy = this.GetItemString(al_row, "coil_alloy2",Primary!, FALSE)
lds_data.gauge = this.GetItemNumber(al_row, "coil_gauge", Primary!, FALSE)
lds_data.Temper = this.GetItemString(al_row, "coil_temper", Primary!, FALSE)
lds_data.net_wt = this.GetItemNumber(al_row, "net_wt", Primary!, FALSE)
lds_data.net_balance = this.GetItemNumber(al_row, "net_wt_balance", Primary!, FALSE)
lds_data.width = this.GetItemNumber(al_row, "coil_width", Primary!, FALSE)
lds_data.date_received = this.GetItemDateTime(al_row, "date_received", Primary!, FALSE)
lds_data.location = this.GetItemString(al_row, "coil_location", Primary!, FALSE)
lds_data.status = this.GetItemNumber(al_row, "coil_status", Primary!, FALSE)
lds_data.notes = this.GetItemString(al_row, "coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = this.GetItemNumber(al_row, "coil_from_cust_id", Primary!, FALSE)

li_status = lds_data.status
OpenWithParm(w_coil_detail_2, lds_data)
IF li_status <> 0 THEN 
	lds_data = message.PowerObjectParm

	IF lds_data.ab_coil_num > 0 THEN
		//this.SetItem(al_row, "customer_id",lds_data.customer_id)
		//this.SetItem(al_row, "coil_abc_num", lds_data.ab_coil_num )
		this.SetItem(al_row, "coil_org_num",lds_data.coil_orig_num  )
		this.SetItem(al_row, "coil_mid_num",lds_data.coil_alt_num)
		this.SetItem(al_row, "lot_num", lds_data.lot_num   )
		this.SetItem(al_row, "pieces_per_case", lds_data.pieces)
		this.SetItem(al_row, "coil_line_num", lds_data.coil_line_num)
		this.SetItem(al_row, "icra", lds_data.icra )
		this.SetItem(al_row, "coil_alloy2", lds_data.alloy)
		this.SetItem(al_row, "coil_gauge",lds_data.gauge )
		this.SetItem(al_row, "coil_temper",lds_data.Temper )
		this.SetItem(al_row, "net_wt",lds_data.net_wt )
		this.SetItem(al_row, "net_wt_balance", lds_data.net_balance)
		this.SetItem(al_row, "coil_width",lds_data.width )
		this.SetItem(al_row, "date_received", lds_data.date_received)
		this.SetItem(al_row, "coil_location", lds_data.location )
		this.SetItem(al_row, "coil_status",lds_data.status )
		this.SetItem(al_row, "coil_notes", lds_data.notes )
		this.SetItem(al_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
		il_cur_coil = lds_data.ab_coil_num
		ib_modify = TRUE
		wf_editing_mode()
	ELSE
		this.Reset()
		ib_modify = FALSE
		wf_normal_mode()
	END IF
END IF	
end event

event clicked;//Override pfc_clicked

integer li_rc

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

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)



end event

event doubleclicked;RETURN
// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
long ll_coil_number, ll_num, ll_coil

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

IF f_security_door("Inventory(Coil)") = 0 THEN RETURN 

ll_coil = this.GetItemNumber(row, "coil_abc_num", Primary!, FALSE)
IF ll_coil > 0 THEN
	this.Event ue_display_popup(row)
END IF

end event

event rbuttondown;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//disable
Return 0
end event

event pfc_deleterow;call super::pfc_deleterow;Return 1
end event

event pfc_addrow;call super::pfc_addrow;RETURN 1
long ll_row_coil, ll_row_cut,ll_c_id, ll_new_id

ll_row_coil = this.GetRow()
ll_row_cut = dw_customer.GetRow()
ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
this.SetItem(ll_row_coil, "customer_id", ll_c_id)
ll_new_id = f_get_next_value("coil_abc_num_seq")
this.SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
this.setItem(ll_row_coil, "coil_entry_date", Today() )
this.setItem(ll_row_coil, "coil_status", 2 )  //new coil
//dw_coil_list.setItem(ll_row_coil, "material_type", 1 ) //aluminum

this.SetItem(ll_row_coil, "coil_org_num",ids_coil.coil_orig_num  )
this.SetItem(ll_row_coil, "coil_mid_num",ids_coil.coil_alt_num)
this.SetItem(ll_row_coil, "lot_num", ids_coil.lot_num   )
this.SetItem(ll_row_coil, "pieces_per_case", ids_coil.pieces)
this.SetItem(ll_row_coil, "coil_line_num", ids_coil.coil_line_num)
this.SetItem(ll_row_coil, "icra", ids_coil.icra )
this.SetItem(ll_row_coil, "coil_alloy2", ids_coil.alloy)
this.SetItem(ll_row_coil, "coil_gauge",ids_coil.gauge )
this.SetItem(ll_row_coil, "coil_temper",ids_coil.Temper )
this.SetItem(ll_row_coil, "net_wt",ids_coil.net_wt )
this.SetItem(ll_row_coil, "net_wt_balance", ids_coil.net_balance)
this.SetItem(ll_row_coil, "coil_width",ids_coil.width )
this.SetItem(ll_row_coil, "date_received", ids_coil.date_received)
this.SetItem(ll_row_coil, "coil_location", ids_coil.location )
this.SetItem(ll_row_coil, "coil_status",ids_coil.status )
this.SetItem(ll_row_coil, "coil_notes", ids_coil.notes )
this.SetItem(ll_row_coil, "coil_from_cust_id",ids_coil.coil_from_cust_id)
il_cur_coil = ll_new_id
ib_new = TRUE

Return ll_row_coil
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

type cb_import from u_cb within w_inv_coil
integer x = 329
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Import"
end type

event clicked;RETURN Parent.Event ue_import()

end event

type cb_archived_bol from u_cb within w_inv_coil
integer x = 647
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Archived BOL"
end type

event clicked;RETURN Parent.Event ue_show_archived()

end event

type cb_barcode from u_cb within w_inv_coil
integer x = 965
integer y = 1869
integer width = 315
integer height = 77
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Barcode"
end type

event clicked;RETURN Parent.Event ue_barcode()
end event

type gb_2 from u_gb within w_inv_coil
integer x = 911
integer y = 3
integer width = 856
integer height = 218
integer taborder = 11
integer weight = 700
string facename = "Arial"
string text = "Coil Showing"
end type

type r_1 from rectangle within w_inv_coil
long linecolor = 65535
integer linethickness = 3
long fillcolor = 65535
integer x = 29
integer y = 1965
integer width = 984
integer height = 125
end type

type ddlb_customer from dropdownlistbox within w_inv_coil
integer x = 26
integer y = 93
integer width = 859
integer height = 1264
integer taborder = 80
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

event selectionchanged;
String ls_text
Long ll_row, ll_i, ll_cust, ll_item, ll_found_row
String	ls_prior, ls_sql_orig, ls_sql_new, ls_add, ls_find_string //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
Long		ll_rows

il_index = index
ls_text = Text(index)
is_where = "" //Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items

CHOOSE CASE ls_text 
	CASE "ALL CUSTOMERS"
		//---
		//Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior. Begin
		dw_coil_list.DataObject = "d_coil_list_allcust_2"
		ls_sql_orig = dw_coil_list.GetSqlSelect()
		is_sql_orig_all_customers = ls_sql_orig //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097
		
		//If ii_show_prior = 1 Then
		//	ls_add = "  where date_received between " + "to_date('" + is_prior + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss') and to_date( '12/31/2099 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )"
		//Else
		//	ls_add = "  where coil.coil_status not in (0, 10, 13, 20)" // Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Added "20". This is coil for wh items
		//End If
		
		If ii_show_default = 1 Then
			is_where = "  where (coil.coil_status  not in (0, 10, 13, 20) )"
		else 
			If ii_showall = 1 Then 
				is_where = ""
			Else //ii_show_prior = 1
				//is_where = "  where date_received between " + "to_date('" + is_prior + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss') and to_date( '12/31/2099 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )"
				is_where = "  where to_date(to_char(coil.date_received,'MM/DD/YYYY'),'MM/DD/YYYY') >= to_date('" + is_prior + "','MM/DD/YYYY')"
			End If
		end if
		
		//is_where = ls_add //Alex Gerlants. 02/06/2023. 1757_Oracle_Message_0097 //Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Comment out
		ls_sql_new = ls_sql_orig + is_where
		
		
		dw_coil_list.SetSqlSelect(ls_sql_new)
		//Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior. End
		//---
		
		
		dw_coil_list.SetTransObject(SQLCA)
		
		ll_rows = dw_coil_list.Retrieve() //Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior
		
		dw_coil_list.SetSqlSelect(ls_sql_orig) //Alex Gerlants. 09/14/2022. 1690_All_Coils_for_Prior. Restore original SQL
		
		//dw_coil_list.Object.item_t.visible = false		//hide the total coil number
		cb_cancel.Event Clicked()
		//cb_reset.Event Clicked()	Alex Gerlants. 12/13/2022. 1757_Oracle_Message_0097. Comment out.
		ib_allcust = TRUE
		cb_new.Enabled = FALSE
		
		////Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Begin
		//If ii_show_default = 1 Then //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
		//	//Alex Gerlants. 02/09/2017. Added ", 13" to the line below
		//	is_where = "  where (coil.coil_status  not in (0, 10, 13, 20) )"
		//else 
		//	If ii_showall = 1 Then //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
		//		is_where = ""
		//	//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. Begin
		//	Else //ii_show_prior = 1
		//		//is_where = "  where (coil.coil_status  not in (0, 10, 13, 20) )"
		//		is_where = "  where date_received between " + "to_date('" + is_prior + " 00:00:00', 'mm/dd/yyyy hh24:mi:ss') and to_date( '12/31/2099 23:59:59', 'mm/dd/yyyy hh24:mi:ss' )"
		//	End If
		//	//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. End
		//end if
		////Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. End
		
	CASE ELSE		

		dw_coil_list.DataObject = "d_coil_list"
		dw_coil_list.SetTransObject(SQLCA)
		
		If ii_show_default = 0 And ii_showall = 0 And ii_show_prior = 0 Then //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. Before window opens
			ii_show_default = 1 //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
		End If //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
		
		//if ii_showall = 1 then //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
		If ii_show_default = 1 Then //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
			//Alex Gerlants. 02/09/2017. Added ", 13" to the line below
			is_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id and  ~~~"COIL~~~".~~~"COIL_STATUS~~~"  NOT IN (0, 10, 13, 20) )" //Alex Gerlants. 09/05/2023. 1960_Exclude_coil for wh items. Added "20". This is coil for wh items
		else 
			If ii_showall = 1 Then //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
				is_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id )"
			//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. Begin
			Else //ii_show_prior = 1
				is_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id )"
				is_where = is_where + " and (TO_DATE(TO_CHAR(~~~"COIL~~~".~~~"DATE_RECEIVED~~~",~~~'MM/DD/YYYY~~~'),~~~'MM/DD/YYYY~~~'  ) >= " + " TO_DATE(~~~'" + is_prior + "~~~',~~~'MM/DD/YYYY~~~' )" + " )"
			End If
			//Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior. End
		end if
	
		ll_row = dw_customer.RowCount()
		//dw_coil_list.Object.item_t.visible = false		//hide the total coil number
		FOR ll_i = 1 TO ll_row
			IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
				dw_customer.Event RowFocusChanged(ll_i)
				dw_customer.SelectRow(0, False)
				dw_customer.SelectRow(ll_i, True)
				ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")		
				cb_reset.Event Clicked()				
				cb_cancel.Event Clicked()
				IF NOT(ib_readonly) THEN cb_new.Enabled = TRUE
			END IF
		NEXT
		ib_allcust = FALSE
		
		ls_sql_new = dw_coil_list.GetSqlSelect()
		
		ll_row = dw_coil_list.Retrieve(ll_cust) //Alex Gerlants. 02/03/2022. dw_coil_listalready retrieve in ue_resume_where for dw_coil_list. ue_resume_where is called from cb_reset.Event Clicked()
		
		ll_row = dw_coil_list.RowCount() //Alex Gerlants. 02/03/2022
		
		st_rows.Text = String(ll_row) + " rows retrieved" //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
		wf_display_total_info() //Alex Gerlants. 03/19/2021. 1130_Coils_Skids_3_Years_Prior
	
END CHOOSE

//wf_display_total_info()

//show only the filted coil number
dw_coil_list.Object.item_t.visible = true
ll_item = dw_coil_list.RowCount()

IF ll_item = 0 THEN
	dw_coil_list.Object.item_t.Text = ""
ELSE
	dw_coil_list.Object.item_t.Text = String(ll_item, "#,###,###") + "  coil(s)"
END IF



end event

