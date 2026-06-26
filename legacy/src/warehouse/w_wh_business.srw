$PBExportHeader$w_wh_business.srw
$PBExportComments$<Sheet> wharehouse item and details, inherited from pfemain\w_sheet
forward
global type w_wh_business from w_sheet
end type
type cb_orig from u_cb within w_wh_business
end type
type dw_item_list from u_dw within w_wh_business
end type
type dw_editor from u_dw within w_wh_business
end type
type cb_newskid from u_cb within w_wh_business
end type
type cb_delete from u_cb within w_wh_business
end type
type cb_close from u_cb within w_wh_business
end type
type cb_print from u_cb within w_wh_business
end type
type gb_editor from u_gb within w_wh_business
end type
type gb_search from u_gb within w_wh_business
end type
type st_cond from statictext within w_wh_business
end type
type cb_search from u_cb within w_wh_business
end type
type cb_reset from u_cb within w_wh_business
end type
type dw_customer from u_dw within w_wh_business
end type
type ddlb_customer from u_ddlb within w_wh_business
end type
type st_1 from statictext within w_wh_business
end type
type cb_save from u_cb within w_wh_business
end type
type cb_cancel from u_cb within w_wh_business
end type
type cb_newitem from u_cb within w_wh_business
end type
type cb_modify from u_cb within w_wh_business
end type
type cb_refer from u_cb within w_wh_business
end type
type cb_sort from u_cb within w_wh_business
end type
end forward

global type w_wh_business from w_sheet
integer x = 66
integer y = 106
integer width = 3610
integer height = 2029
string title = "Warehouse Business"
string menuname = "m_warehouse_main"
boolean maxbox = false
boolean resizable = false
event ue_search ( )
event ue_deleteitem ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
event type integer ue_modify ( )
event type string ue_cur_retrieve ( )
event ue_sort ( )
cb_orig cb_orig
dw_item_list dw_item_list
dw_editor dw_editor
cb_newskid cb_newskid
cb_delete cb_delete
cb_close cb_close
cb_print cb_print
gb_editor gb_editor
gb_search gb_search
st_cond st_cond
cb_search cb_search
cb_reset cb_reset
dw_customer dw_customer
ddlb_customer ddlb_customer
st_1 st_1
cb_save cb_save
cb_cancel cb_cancel
cb_newitem cb_newitem
cb_modify cb_modify
cb_refer cb_refer
cb_sort cb_sort
end type
global w_wh_business w_wh_business

type variables
String is_select
String is_condition
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Long il_cur_skid
Int ii_action  //0 - nothing  1 - newskid 2- new item 3-delect 4 - modify

Long		il_customer_id //Alex Gerlants. 03/05/2021. Warehouse_Application_Fix
String	is_customer_short_name //Alex Gerlants. 03/05/2021. Warehouse_Application_Fix

end variables

forward prototypes
public function string wf_search_terms ()
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
public function long wf_get_userid (string as_name)
public subroutine wf_set_action (integer ai_action)
public function integer wf_check_skid_wt (long al_skid, long al_item)
public function integer wf_coil_used_by_others (long al_coil, long al_item)
public subroutine wf_display_total_info ()
public function long wf_orig_item_coil_id (long al_item)
public function integer wf_get_coil_info (string as_coil_org_num, ref string as_cash_date, ref long al_customer_id)
public function integer wf_load_original_data (long al_row)
end prototypes

event ue_search;call super::ue_search;dw_item_list.Event ue_search_retrieve()
end event

event ue_deleteitem;dw_editor.Event ue_delete_row()
end event

event ue_whoami;RETURN "w_wh_business"
end event

event ue_read_only;dw_item_list.Object.DataWindow.ReadOnly = "YES"
dw_editor.Object.DataWindow.ReadOnly = "YES"
cb_newskid.Enabled = FALSE
cb_newitem.Enabled = FALSE
cb_cancel.Enabled = FALSE
cb_save.Enabled = FALSE
cb_delete.Enabled = FALSE
cb_modify.Enabled = FALSE
m_warehouse_main.m_file.m_new.Disable()
m_warehouse_main.m_file.m_save.Disable()
m_warehouse_main.m_file.m_delete.Disable()


end event

event ue_set_search;Long ll_row, ll_l
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
					CASE "GONE"
						istr_search[li_s].value = "0"
					CASE "INPROCESS"
						istr_search[li_s].value = "1"					
					CASE "READY"
						istr_search[li_s].value = "2"					
					CASE "CANCELED"
						istr_search[li_s].value = "3"					
					CASE "ONHOLD"
						istr_search[li_s].value = "4"
					CASE "WH-READY"
						istr_search[li_s].value = "8"
					CASE "WH-COMING"
						istr_search[li_s].value = "9"
					CASE "WH-SORT"
						istr_search[li_s].value = "10"
					CASE "WH-GONE"
						istr_search[li_s].value = "11"
					CASE "WAREHOUSE"
						istr_search[li_s].value = "1"	
					CASE "RETURN"
						istr_search[li_s].value = "2"	
					CASE ELSE
						istr_search[li_s].value = "9999"
				END CHOOSE
			END IF
			
	//		IF istr_search[li_s].col_type = "type" THEN
	//				CHOOSE CASE Upper(Trim(istr_search[li_s].value))
	//				CASE "WAREHOUSE"
	//					istr_search[li_s].value = "1"
	//				CASE "RETURN"
	//					istr_search[li_s].value = "2"					
	//				CASE "NONE WH"
	//					istr_search[li_s].value = "0"					
	//				CASE ELSE
	//					istr_search[li_s].value = "9999"
	//			END CHOOSE
	//		END IF
						
			IF istr_search[li_s].col_type = "customer" THEN
					istr_search[li_s].value = String(wf_get_userid(istr_search[li_s].value))
			END IF
			li_s++
		END IF
	li_i++
	LOOP
NEXT

dw_item_list.Event ue_search_retrieve()

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

event type integer ue_modify();Long ll_row
Int li_status

//Alex Gerlants. 10/24/2019. Begin
DataWindowChild	ldwc
Integer				li_rtn
Long					ll_rows
//Alex Gerlants. 10/24/2019. End

ll_row = dw_item_list.GetRow()
IF ll_row < 1 THEN Return -1
li_status = dw_item_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN 0
END IF

il_cur_skid = dw_item_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

dw_item_list.RowsCopy(dw_item_list.GetRow(), dw_item_list.GetRow(), Primary!, dw_editor, 1, Primary!)

DataWindowChild ldddw_cni
IF dw_editor.GetChild("sheet_skid_skid_from_if_whed", ldddw_cni) = -1 THEN
	dw_editor.ResetUpdate()
	dw_editor.Reset()
	wf_set_action(0)
	Return -1
ELSE
	dw_editor.Event pfc_PopulateDDDW("sheet_skid_skid_from_if_whed", ldddw_cni)
END IF

wf_set_action(4)

//Alex Gerlants. 10/24/2019. Begin
li_rtn = dw_editor.GetChild("sheet_skid_skid_sheet_status", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_rows = ldwc.Retrieve()
End If
//Alex Gerlants. 10/24/2019. End

RETURN 1
end event

event ue_cur_retrieve;String ls_mod
ls_mod ="DataWindow.Table.Select = '" + is_select + is_condition + " '"
RETURN ls_mod

end event

event ue_sort;SetPointer(HourGlass!)

String ls_null

SetNULL(ls_null)
dw_item_list.inv_sort.of_SetSort(ls_null)
dw_item_list.inv_sort.of_Sort()
end event

public function string wf_search_terms ();String ls_terms
integer li_i

ls_terms = " WHERE ( production_sheet_item.coil_abc_num = coil.coil_abc_num (+)) and ( ~"SHEET_SKID_DETAIL~".~"SHEET_SKID_NUM~" = ~"SHEET_SKID~".~"SHEET_SKID_NUM~" ) and ( ~"SHEET_SKID_DETAIL~".~"PROD_ITEM_NUM~" = ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_NUM~" ) and  ( ~"SHEET_SKID~".~"AB_JOB_NUM~" = ~"AB_JOB~".~"AB_JOB_NUM~" ) and  ( ~"AB_JOB~".~"ORDER_ABC_NUM~" = ~"CUSTOMER_ORDER~".~"ORDER_ABC_NUM~" ) and  ( ~"SHEET_SKID~".~"SKID_FROM_IF_WHED~" > 0 ) AND (~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" = :customer_id ) "   

li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		IF Len(ls_terms) > 10 THEN ls_terms = ls_terms + " AND "
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "customer"
				ls_terms = ls_terms + " ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "status"
				ls_terms = ls_terms + " ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
			CASE "date"
				ls_terms = ls_terms + " (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
			CASE "string"
				ls_terms = ls_terms + " ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public subroutine wf_init_dwdb ();Int li_i

li_i = 1
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SHEET_SKID_NUM"
istr_dwdb[li_i].dw_column = "sheet_skid_sheet_skid_num"
istr_dwdb[li_i].col_type = "number"
istr_dwdb[li_i].dw_header = "Skid ID"

li_i = 2 
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_TICKET_IF_WHED"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_ticket_if_whed"
istr_dwdb[li_i].col_type = "string"
istr_dwdb[li_i].dw_header = "Orig. Ticket No."

li_i = 3 
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_FROM_IF_WHED"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_from_if_whed"
istr_dwdb[li_i].col_type = "customer"
istr_dwdb[li_i].dw_header = "Orig. Blanked by"

li_i = 4 
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "AB_JOB_NUM"
istr_dwdb[li_i].dw_column = "sheet_skid_ab_job_num"
istr_dwdb[li_i].col_type = "number"
istr_dwdb[li_i].dw_header = "Prod Order"

li_i = 5
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SHEET_NET_WT"
istr_dwdb[li_i].dw_column = "sheet_skid_sheet_net_wt"
istr_dwdb[li_i].col_type = "number"
istr_dwdb[li_i].dw_header = "Net WT"

li_i = 6
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SHEET_TARE_WT"
istr_dwdb[li_i].dw_column = "sheet_skid_sheet_tare_wt"
istr_dwdb[li_i].col_type = "number"
istr_dwdb[li_i].dw_header = "Tare WT"

li_i = 7
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_PIECES"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_pieces"
istr_dwdb[li_i].col_type = "number"
istr_dwdb[li_i].dw_header = "Pieces"

li_i = 8
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_SHEET_STATUS"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_sheet_status"
istr_dwdb[li_i].col_type = "status"
istr_dwdb[li_i].dw_header = "Status"

li_i = 9
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_EDI856_DATE"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_edi856_date"
istr_dwdb[li_i].col_type = "date"
istr_dwdb[li_i].dw_header = "Edi856 Date"

li_i = 10
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_LOCATION"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_location"
istr_dwdb[li_i].col_type = "string"
istr_dwdb[li_i].dw_header = "Location"

li_i = 11
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_DATE"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_date"
istr_dwdb[li_i].col_type = "date"
istr_dwdb[li_i].dw_header = "Created Date"

li_i = 12
istr_dwdb[li_i].db_name = "SHEET_SKID"
istr_dwdb[li_i].db_field = "SKID_TYPE_IF_WHED"
istr_dwdb[li_i].dw_column = "sheet_skid_skid_type_if_whed"
istr_dwdb[li_i].col_type = "status"
istr_dwdb[li_i].dw_header = "Skid Type"

end subroutine

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

public subroutine wf_set_action (integer ai_action);IF ai_action = 0 THEN
	cb_newskid.Enabled = TRUE
	cb_newitem.Enabled = TRUE
	cb_delete.Enabled = TRUE
	cb_modify.Enabled = TRUE
ELSE
	cb_newskid.Enabled = FALSE
	cb_newitem.Enabled = FALSE
	cb_delete.Enabled = FALSE
	cb_modify.Enabled = FALSE
END IF
ii_action = ai_action
end subroutine

public function integer wf_check_skid_wt (long al_skid, long al_item);Long ll_row, ll_pc, ll_totalpc, ll_totalwt
Long ll_trow, ll_skid, ll_item, ll_i, ll_net
Long ll_otherpc, ll_othernet

dw_editor.AcceptText()
ll_row = dw_editor.GetRow()
ll_pc = dw_editor.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_net = dw_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)

ll_totalpc = dw_editor.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
ll_totalwt = dw_editor.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)

ll_trow = dw_item_list.RowCount()
IF (ll_trow < 1) OR IsNULL(ll_trow) THEN RETURN 0
ll_otherpc = 0
ll_othernet = 0
FOR ll_i = 1 TO ll_trow
	ll_skid = dw_item_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = dw_item_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE)
	IF ll_skid = al_skid AND al_item <> ll_item THEN
		ll_otherpc = ll_otherpc + dw_item_list.GetItemNumber(ll_i,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
		ll_othernet = ll_othernet + dw_item_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)		
	END IF
NEXT
IF ll_otherpc <> ll_totalpc - ll_pc THEN
	IF MessageBox("Question", "Skid pieces do not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
END IF
IF ll_othernet <> ll_totalwt - ll_net THEN
	IF MessageBox("Question", "Skid net wt does not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -2
END IF

RETURN 1
end function

public function integer wf_coil_used_by_others (long al_coil, long al_item);Int li_rc

li_rc = 0

SELECT COUNT(coil_abc_num) INTO :li_rc
FROM production_sheet_item
WHERE coil_abc_num = :al_coil and prod_item_num <>:al_item
USING SQLCA;

RETURN li_rc

end function

public subroutine wf_display_total_info ();
end subroutine

public function long wf_orig_item_coil_id (long al_item);Long ll_coil
Long ll_row, ll_i

ll_row = dw_item_list.RowCount()
FOR ll_i = 1 TO ll_row
	IF al_item = dw_item_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE) THEN
		ll_coil = dw_item_list.GetItemNumber(ll_i, "production_sheet_item_coil_abc_num", Primary!, FALSE)
	END IF
NEXT

RETURN ll_coil
end function

public function integer wf_get_coil_info (string as_coil_org_num, ref string as_cash_date, ref long al_customer_id);//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. Begin
/*
Function:	wf_get_coil_info
Returns:		integer	 0 if there is no row in coil table for coil_org_num = :as_coil_org_num
							 1 if OK
							-1 if DB error
Arguments:	value			string	as_coil_org_num
				reference	string	as_cash_date
*/

Integer	li_rtn = 1

select   cash_date, customer_id
into		:as_cash_date, :al_customer_id
from     coil
where    coil_abc_num = (  select max(coil_abc_num)
                           from   coil
                           where  coil_org_num = :as_coil_org_num
                           and    cash_date is not null
                           and    coil_status <> 20
                        )
using	   sqlca;

Choose Case sqlca.sqlcode
	Case 0 //OK
		//li_rtn = 1 at this point
	Case 100 //There is no row in coil table for coil_org_num = :as_coil_org_num
		li_rtn = 0
		
		//Alex Gerlants. 03/05/2021. Warehouse_Application_Fix
		//Moved error message to pfc_save event for window
		//MessageBox("Coil does not exist", 	"Table coil does not have a regular coil with coil_org_num " + as_coil_org_num + &
		//												"~n~rCash Date and Customer Id will not have value for the new ABC coil for customer coil " + as_coil_org_num)
	Case Else //DB error
		li_rtn = -1
	
		MessageBox("DB error", 	"Database error in wf_get_cash_date for w_wh_business while retrieving data from table coil for coil_org_num " + as_coil_org_num + &
										"~n~r~n~rError:~n~rsqlca.sqlerrtext" + &
										"~n~r~n~rPlease contact abis support.", StopSign!)
End Choose

Return li_rtn
//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. End
end function

public function integer wf_load_original_data (long al_row);//Alex Gerlants. 01/02/2022. 1715_Auto_Fill_WH_Skids_Edit. Begin
/*
Function:	wf_load_original_data
Returns:		intger
Arguments:	value	long	al_row
*/

Integer		li_rtn = 1, li_rows, li_row, li_found_row
Long			ll_sheet_skid_num_orig, ll_sheet_net_wt_orig, ll_sheet_tare_wt_orig, ll_skid_pieces_orig, ll_coil_abc_num_orig, ll_prod_item_net_wt_orig, ll_prod_item_pieces_orig
String		ls_coil_org_num_wh, ls_lot_num_wh, ls_sheet_skid_num_orig
String		ls_coil_org_num_orig, ls_lot_num_orig, ls_find_string
DataStore	lds_orig_skid_data_4wh_skid

ls_coil_org_num_wh = dw_item_list.Object.coil_coil_org_num[al_row]
ls_lot_num_wh = dw_item_list.Object.coil_lot_num[al_row]
ls_sheet_skid_num_orig = dw_item_list.Object.sheet_skid_skid_ticket_if_whed[al_row]

select	sheet_skid_num
into		:ll_sheet_skid_num_orig
from		sheet_skid
where		sheet_skid_display_num = :ls_sheet_skid_num_orig
using		sqlca;

If sqlca.sqlcode <> 0 Then
	li_rtn = -1
	
	MessageBox("DB error", 	"Database error in wf_lookup_original_data for w_wh_business while retrieving sheet_skid_num for original skid " + &
									ls_sheet_skid_num_orig, StopSign!)
End If

If li_rtn = 1 Then
	lds_orig_skid_data_4wh_skid = Create DataStore
	lds_orig_skid_data_4wh_skid.DataObject = "d_orig_skid_data_4wh_skid"
	lds_orig_skid_data_4wh_skid.SetTransObject(sqlca)
	li_rows = lds_orig_skid_data_4wh_skid.Retrieve(ll_sheet_skid_num_orig)
	
	If li_rows > 0 Then
		For li_row = 1 To li_rows
			ls_coil_org_num_orig = lds_orig_skid_data_4wh_skid.Object.coil_org_num[li_row]
			ls_lot_num_orig = lds_orig_skid_data_4wh_skid.Object.lot_num[li_row]
			ls_find_string = "coil_coil_org_num = '" + ls_coil_org_num_orig + "'" + " and coil_lot_num = '" + ls_lot_num_orig + "'"
			li_found_row = dw_editor.Find(ls_find_string, 1, dw_editor.RowCount())
			
			If li_found_row > 0 Then
				ll_sheet_net_wt_orig = lds_orig_skid_data_4wh_skid.Object.sheet_net_wt[li_row]
				ll_sheet_tare_wt_orig = lds_orig_skid_data_4wh_skid.Object.sheet_tare_wt[li_row]
				ll_skid_pieces_orig = lds_orig_skid_data_4wh_skid.Object.skid_pieces[li_row]
				
				ll_prod_item_net_wt_orig = lds_orig_skid_data_4wh_skid.Object.prod_item_net_wt[li_row]
				ll_coil_abc_num_orig = lds_orig_skid_data_4wh_skid.Object.coil_abc_num[li_row]
				ll_prod_item_pieces_orig = lds_orig_skid_data_4wh_skid.Object.prod_item_pieces[li_row]
				
				//---
				
				dw_editor.Object.sheet_skid_sheet_net_wt[li_found_row] = ll_sheet_net_wt_orig
				dw_editor.Object.sheet_skid_sheet_tare_wt[li_found_row] = ll_sheet_tare_wt_orig
				dw_editor.Object.sheet_skid_skid_pieces[li_found_row] = ll_skid_pieces_orig
				
				dw_editor.Object.coil_coil_org_num[li_found_row] = ls_coil_org_num_orig
				dw_editor.Object.coil_lot_num[li_found_row] = ls_lot_num_orig
				dw_editor.Object.production_sheet_item_prod_item_net_wt[li_found_row] = ll_prod_item_net_wt_orig
				dw_editor.Object.production_sheet_item_prod_item_pieces[li_found_row] = ll_prod_item_pieces_orig
			End If
		Next
	End If
	
	If IsValid(lds_orig_skid_data_4wh_skid) Then Destroy lds_orig_skid_data_4wh_skid
End If

Return li_rtn
//Alex Gerlants. 01/02/2022. 1715_Auto_Fill_WH_Skids_Edit. End
end function

on w_wh_business.create
int iCurrent
call super::create
if this.MenuName = "m_warehouse_main" then this.MenuID = create m_warehouse_main
this.cb_orig=create cb_orig
this.dw_item_list=create dw_item_list
this.dw_editor=create dw_editor
this.cb_newskid=create cb_newskid
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.cb_print=create cb_print
this.gb_editor=create gb_editor
this.gb_search=create gb_search
this.st_cond=create st_cond
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.dw_customer=create dw_customer
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
this.cb_newitem=create cb_newitem
this.cb_modify=create cb_modify
this.cb_refer=create cb_refer
this.cb_sort=create cb_sort
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_orig
this.Control[iCurrent+2]=this.dw_item_list
this.Control[iCurrent+3]=this.dw_editor
this.Control[iCurrent+4]=this.cb_newskid
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.gb_editor
this.Control[iCurrent+9]=this.gb_search
this.Control[iCurrent+10]=this.st_cond
this.Control[iCurrent+11]=this.cb_search
this.Control[iCurrent+12]=this.cb_reset
this.Control[iCurrent+13]=this.dw_customer
this.Control[iCurrent+14]=this.ddlb_customer
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.cb_save
this.Control[iCurrent+17]=this.cb_cancel
this.Control[iCurrent+18]=this.cb_newitem
this.Control[iCurrent+19]=this.cb_modify
this.Control[iCurrent+20]=this.cb_refer
this.Control[iCurrent+21]=this.cb_sort
end on

on w_wh_business.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_orig)
destroy(this.dw_item_list)
destroy(this.dw_editor)
destroy(this.cb_newskid)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.gb_editor)
destroy(this.gb_search)
destroy(this.st_cond)
destroy(this.cb_search)
destroy(this.cb_reset)
destroy(this.dw_customer)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.cb_cancel)
destroy(this.cb_newitem)
destroy(this.cb_modify)
destroy(this.cb_refer)
destroy(this.cb_sort)
end on

event open;call super::open;dw_customer.Visible = FALSE

dw_customer.of_SetLinkage(TRUE)

dw_item_list.of_SetLinkage( TRUE ) 
dw_item_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_item_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & skid in win w_wh_business!" )
ELSE
	dw_item_list.inv_Linkage.of_Register( "customer_order_orig_customer_id", "customer_id" ) 
	dw_item_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_wh_business::open function" )
ELSE
	SQLCA.of_Commit()
	dw_customer.SelectRow(1,TRUE)
	dw_customer.SetFocus()
End IF

is_select =   "SELECT  ~"SHEET_SKID~".~"SHEET_SKID_NUM~" ,  ~"SHEET_SKID~".~"AB_JOB_NUM~" ,   ~"SHEET_SKID~".~"SHEET_NET_WT~" ,  ~"SHEET_SKID~".~"SHEET_TARE_WT~" , ~"SHEET_SKID~".~"SKID_PIECES~" , ~"SHEET_SKID~".~"SKID_SHEET_STATUS~" , ~"SHEET_SKID~".~"SKID_DATE~" ,  ~"SHEET_SKID_DETAIL~".~"PROD_ITEM_NUM~" ,  ~"SHEET_SKID_DETAIL~".~"SHEET_SKID_NUM~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_NUM~" ,   ~"PRODUCTION_SHEET_ITEM~".~"AB_JOB_NUM~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_STATUS~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_PIECES~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_NET_WT~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_THEORETICAL_WT~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_DATE~" ,  ~"SHEET_SKID~".~"SHEET_THEORETICAL_WT~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_NOTE~" ,  ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_PLACEMENT~" , ~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" , ~"SHEET_SKID~".~"SKID_FROM_IF_WHED~" , ~"SHEET_SKID~".~"SKID_TICKET_IF_WHED~", ~"COIL~".~"COIL_ORG_NUM~", ~"COIL~".~"LOT_NUM~" ,~"SHEET_SKID~".~"SKID_TYPE_IF_WHED~",f_get_skid_duration(sheet_skid.sheet_skid_num) FROM ~"PRODUCTION_SHEET_ITEM~" , ~"SHEET_SKID~" ,  ~"SHEET_SKID_DETAIL~" , ~"AB_JOB~" , ~"CUSTOMER_ORDER~", ~"COIL~"  "

wf_init_dwdb()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)


end event

event pfc_save;Long ll_skid, ll_item, ll_row, ll_i, ll_from_id

Long ll_snet, ll_stare, ll_spc, ll_theo, ll_job, ll_order_abc_no
Int li_sstatus, ll_order_item_num
int li_stype
DateTime ld_sdate

Long ll_inet, ll_icoil, ll_ipc, ll_itheo 
Int li_istatus
DateTime ld_idate
String ls_place, ls_ticket, ls_coil_num, ls_lot
Boolean lb_newcoil

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num
String	ls_cash_date //Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil
Long		ll_customer_id //Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil

String	ls_coil_cert_label_req, ls_cash_date_required //Alex Gerlants. 03/05/2021. Warehouse_Application_Fix

dw_editor.AcceptText()
ll_row = dw_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN -2
ll_skid = dw_editor.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = dw_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_num", Primary!, FALSE)

ll_snet = dw_editor.GetItemNumber(ll_row, "sheet_skid_sheet_net_wt", Primary!, FALSE)
ll_stare = dw_editor.GetItemNumber(ll_row, "sheet_skid_sheet_tare_wt", Primary!, FALSE)
ll_spc = dw_editor.GetItemNumber(ll_row, "sheet_skid_skid_pieces", Primary!, FALSE)
li_sstatus = dw_editor.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
li_stype = dw_editor.GetItemNumber(ll_row, "sheet_skid_skid_type_if_whed", Primary!, FALSE)
ld_sdate = dw_editor.GetItemDateTime(ll_row, "sheet_skid_skid_date", Primary!, FALSE)
ll_theo = dw_editor.GetItemNumber(ll_row, "sheet_skid_sheet_theoretical_wt", Primary!, FALSE)
ls_ticket = dw_editor.GetItemString(ll_row,"sheet_skid_skid_ticket_if_whed", Primary!, FALSE)
ll_from_id = dw_editor.GetItemNumber(ll_row,"sheet_skid_skid_from_if_whed", Primary!, FALSE)
ls_coil_num = dw_editor.GetItemString(ll_row,"coil_coil_org_num", Primary!, FALSE)
ls_lot = dw_editor.GetItemString(ll_row,"coil_lot_num", Primary!, FALSE)

ll_job = dw_editor.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE)
li_istatus = dw_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_status", Primary!, FALSE)
ll_ipc = dw_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_inet = dw_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
ll_itheo = dw_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
ld_idate = dw_editor.GetItemDateTime(ll_row, "production_sheet_item_prod_item_date", Primary!, FALSE)
ls_place = dw_editor.GetItemString(ll_row, "production_sheet_item_prod_item_placemen", Primary!, FALSE)

If IsNull(ll_inet) Or ll_inet = 0 Then
	MessageBox("Error. iNet missing", "Please enter iNet", StopSign!)
	Return -99
End If

CHOOSE CASE ii_action
	CASE 1 //new skid
		IF (li_sstatus <> 7) AND (ll_spc <> ll_ipc) THEN
			IF MessageBox("Question", "Skid pieces do not add up right, save it anyway?", Question!, YesNo!, 2) = 2 THEN RETURN -1	
		END IF
	CASE 2 //new item
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -2
	CASE 3 //delete item
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -3
	CASE 4 //modify
		IF wf_check_skid_wt(ll_skid, ll_item) < 0 THEN RETURN -4
END CHOOSE

CONNECT USING SQLCA;


ll_order_abc_no = 0
SELECT ORDER_ABC_NUM, ORDER_ITEM_NUM INTO :ll_order_abc_no, :ll_order_item_num
FROM AB_JOB 
WHERE AB_JOB_NUM = :ll_job
USING SQLCA;

IF ll_order_abc_no <= 0 THEN
		Messagebox("ERROR", "Can not find order number from job number!!, please correct it!" )
		RETURN -10
END IF
	





ll_icoil = 0
SELECT coil_abc_num INTO :ll_icoil
FROM coil
WHERE coil_org_num = :ls_coil_num and lot_num = :ls_lot and coil_status = 20
USING SQLCA;
IF ll_icoil > 0 THEN 
	lb_newcoil = FALSE
ELSE
	lb_newcoil = TRUE
END IF
CHOOSE CASE ii_action
	CASE 0 //nothing
	CASE 1,2,4 //new skid, item, modify
		IF lb_newcoil THEN //coil not exist
			ll_icoil = f_get_next_value("coil_abc_num_seq")
			
			li_rtn  = wf_get_coil_info(ls_coil_num, ls_cash_date, ll_customer_id) //Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil
			
			If li_rtn <> 1 Then
				If li_rtn = 0 Then //There is no row in coil table for ls_coil_num
					select	coil_cert_label_req, cash_date_required
					into		:ls_coil_cert_label_req, :ls_cash_date_required
					from		customer
					where		customer_id = :il_customer_id
					using		sqlca;
					
					If sqlca.sqlcode = 0 Then //OK
						If Upper(ls_coil_cert_label_req) = "Y" Or Upper(ls_cash_date_required) = "Y" Then
							MessageBox("Coil does not exist", "Table coil does not have a regular coil with customer coil number " + ls_coil_num + &
								"~n~rPlease contact abis support.", StopSign!)
							Return -99
						Else //Cert label is not required
							SetNull(ls_cash_date)
							SetNull(ll_customer_id)
						End If
					ElseIf sqlca.sqlcode = 100 Then //Customer does not exist. Should not happen
						MessageBox("Customer does not exist", 	"Customer " + is_customer_short_name + " does not exist." + &
											"~n~r~n~rPlease contact abis support.", StopSign!)
						Return -99
					Else //li_rtn = -1. DB error
						MessageBox("DB error", 	"Database error in pfc_save event for w_wh_business while retrieving data from table customer for customer " + is_customer_short_name + &
											"~n~r~n~rError:~n~rsqlca.sqlerrtext" + &
											"~n~r~n~rPlease contact abis support.", StopSign!)
						Return -99
					End If
				Else //li_rtn = -1. DB error in wf_get_coil_info()
					Return -99
				End If
			End If
			
			//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. Added cash_date and customer_id to the statement below.
			INSERT INTO coil (coil_abc_num, coil_org_num, lot_num, coil_status, net_wt, net_wt_balance,  cash_date,     customer_id)
			VALUES (           :ll_icoil,   :ls_coil_num, :ls_lot,   20,          0,          0,       :ls_cash_date, :ll_customer_id)
			USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				ROLLBACK USING SQLCA;
				Messagebox("DBError", "Insert coil function: coil table" )
				RETURN -10
			END IF
			INSERT INTO process_coil(coil_abc_num, ab_job_num, process_quantity)
			VALUES (:ll_icoil, :ll_job, 0)
			USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				ROLLBACK USING SQLCA;
				Messagebox("DBError", "Insert coil function: process_coil table" )
				RETURN -11
			END IF
			COMMIT USING SQLCA;
		END IF	
END CHOOSE

CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid			
		INSERT INTO sheet_skid (sheet_skid_num, ab_job_num, sheet_net_wt , sheet_tare_wt, skid_date, skid_pieces , skid_sheet_status, sheet_theoretical_wt, skid_from_if_whed, skid_ticket_if_whed,skid_type_if_whed, ref_order_abc_num, ref_order_abc_item)
		VALUES (:ll_skid, :ll_job, :ll_snet, :ll_stare,:ld_sdate,:ll_spc, :li_sstatus, :ll_theo, :ll_from_id, :ls_ticket, :li_stype, :ll_order_abc_no, :ll_order_item_num)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid table" )
			RETURN -5
		END IF
	//	COMMIT USING SQLCA;
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:ll_job,:li_istatus,:ll_inet,:ld_idate,:ll_ipc, :ll_itheo, :ls_place)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid item table" )
			RETURN -5
		END IF
	//	COMMIT USING SQLCA;
		INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid detail table" )
			RETURN -5
		END IF
//		COMMIT USING SQLCA;

		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
		li_rtn = f_insert_sheet_skid_package(ll_job, ll_skid, sqlca)
		
		If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package()
			rollback using sqlca;
			Return -5
		End If
		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End

	CASE 2	//item		
		UPDATE sheet_skid
		SET sheet_net_wt = :ll_snet, ab_job_num = :ll_job, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_type_if_whed = :li_stype, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo ,ref_order_abc_num = :ll_order_abc_no, ref_order_abc_item = :ll_order_item_num
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "add item function" )
			RETURN -4
		END IF			
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:ll_job,:li_istatus,:ll_inet,:ld_idate,:ll_ipc, :ll_itheo, :ls_place)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Item function: skid item table" )
			RETURN -5
		END IF
		INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Item function: skid detail table" )
			RETURN -5
		END IF
	CASE 3	//delete item
		DELETE FROM sheet_skid_detail
		WHERE sheet_skid_num = :ll_skid AND prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid detail table" )
			RETURN -5
		END IF
		DELETE FROM production_sheet_item
		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete item function: skid item table" )
			RETURN -5
		END IF
		IF wf_coil_used_by_others(ll_icoil, ll_item) = 0 THEN //not used by others
			DELETE FROM coil
			WHERE coil_abc_num = :ll_icoil
			USING SQLCA;
		END IF
	CASE 4	//modify
		UPDATE sheet_skid
		SET sheet_net_wt = :ll_snet, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, skid_type_if_whed = :li_stype, sheet_theoretical_wt = :ll_theo, skid_from_if_whed = :ll_from_id, skid_ticket_if_whed = :ls_ticket, ref_order_abc_num =:ll_order_abc_no, ref_order_abc_item = :ll_order_item_num
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF			
		UPDATE production_sheet_item
		SET coil_abc_num = :ll_icoil, ab_job_num = :ll_job, prod_item_status = :li_istatus, prod_item_net_wt = :ll_inet, prod_item_date = :ld_idate, prod_item_pieces = :ll_ipc, prod_item_theoretical_wt = :ll_itheo, prod_item_placement = :ls_place		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF
	CASE 5	//delete skid
		DELETE FROM sheet_skid_detail
		WHERE sheet_skid_num = :ll_skid AND prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: skid detail table" )
			RETURN -5
		END IF
 		DELETE FROM production_sheet_item
		WHERE prod_item_num = :ll_item
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: skid item table" )
			RETURN -5
		END IF
		DELETE FROM sheet_skid
		WHERE sheet_skid_num = :ll_skid
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Delete function: skid table" )
			RETURN -5
		END IF
END CHOOSE

CHOOSE CASE ii_action
	CASE 0 //nothing
	CASE 3,5 //delete item, skid
		IF wf_coil_used_by_others(ll_icoil, ll_item) = 0 THEN //not used by others
			DELETE FROM process_coil
			WHERE coil_abc_num = :ll_icoil
			USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				ROLLBACK USING SQLCA;
				Messagebox("DBError", "Delete function: process_coil table" )
				RETURN -12
			END IF
			DELETE FROM coil
			WHERE coil_abc_num = :ll_icoil
			USING SQLCA;
			IF SQLCA.SQLCode <> 0 then
				ROLLBACK USING SQLCA;
				Messagebox("DBError", "Delete function: coil table" )
				RETURN -14
			END IF
		END IF
	CASE 4 //modify
		IF lb_newcoil THEN
			IF wf_coil_used_by_others(wf_orig_item_coil_id(ll_item), ll_item) = 0 THEN //not used by others
				DELETE FROM process_coil
				WHERE coil_abc_num = :ll_icoil
				USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					ROLLBACK USING SQLCA;
					Messagebox("DBError", "Delete function: process_coil table" )
					RETURN -15
				END IF
				DELETE FROM coil
				WHERE coil_abc_num = :ll_icoil
				USING SQLCA;
				IF SQLCA.SQLCode <> 0 then
					ROLLBACK USING SQLCA;
					Messagebox("DBError", "Delete function: coil table" )
					RETURN -16
				END IF
			END IF			
		END IF
END CHOOSE

COMMIT USING SQLCA;

MessageBox("Info", "Data had been saved.")

CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		dw_editor.RowsCopy(dw_editor.GetRow(), dw_editor.GetRow(), Primary!, dw_item_list, (dw_item_list.RowCount() + 1), Primary!)		
	CASE 2	//item
		ll_row = dw_item_list.GetRow()
		IF ll_row = dw_item_list.RowCount() THEN
			ll_row = 0
		ELSE
			ll_row = ll_row + 1
		END IF
		ll_row = dw_item_list.InsertRow(ll_row)
		dw_item_list.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
		dw_item_list.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
		dw_item_list.SetItem(ll_row, "sheet_skid_sheet_net_wt", ll_snet)
		dw_item_list.SetItem(ll_row, "sheet_skid_sheet_tare_wt",ll_stare)
		dw_item_list.SetItem(ll_row, "sheet_skid_sheet_theoretical_wt", ll_theo)
		dw_item_list.SetItem(ll_row, "sheet_skid_skid_pieces",ll_spc)
		dw_item_list.SetItem(ll_row, "sheet_skid_skid_sheet_status", li_sstatus)
		dw_item_list.SetItem(ll_row, "sheet_skid_skid_type_if_whed", li_stype)
		dw_item_list.SetItem(ll_row, "sheet_skid_skid_date",ld_sdate) 
		dw_item_list.setItem(ll_row, "production_sheet_item_ab_job_num", ll_job)
		dw_item_list.SetItem(ll_row, "production_sheet_item_prod_item_status", li_istatus)
		dw_item_list.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_ipc)
		dw_item_list.SetItem(ll_row, "production_sheet_item_prod_item_net_wt", ll_inet)
		dw_item_list.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_itheo)
		dw_item_list.SetItem(ll_row, "production_sheet_item_prod_item_date", ld_idate)
		dw_item_list.SetItem(ll_row, "production_sheet_item_prod_item_placemen",ls_place)
		dw_item_list.SetItem(ll_row, "sheet_skid_skid_from_if_whed",ll_from_id)
		dw_item_list.SetItem(ll_row, "sheet_skid_skid_ticket_if_whed",ls_ticket)
		dw_item_list.SetItem(ll_row, "coil_coil_org_num", ls_coil_num)
		dw_item_list.SetItem(ll_row, "coil_lot_num", ls_lot)
		
		ll_row = dw_item_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = dw_item_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				dw_item_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				dw_item_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				dw_item_list.SetItem(ll_i, "sheet_skid_sheet_theoretical_wt", ll_theo)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate) 
			END IF
		NEXT
	CASE 3	//delete item
		IF dw_item_list.GetRow() > 0 THEN
			dw_item_list.DeleteRow(dw_item_list.GetRow() )
		END IF
	CASE 4	//modify
		ll_row = dw_item_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = dw_item_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				dw_item_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				dw_item_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate) 
				dw_item_list.SetItem(ll_i, "sheet_skid_sheet_theoretical_wt", ll_theo)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_from_if_whed",ll_from_id)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_ticket_if_whed",ls_ticket)
				dw_item_list.SetItem(ll_i, "sheet_skid_skid_type_if_whed", li_stype)
				IF ll_item = dw_item_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE) THEN
					dw_item_list.setItem(ll_i, "production_sheet_item_ab_job_num", ll_job)
					dw_item_list.SetItem(ll_i, "production_sheet_item_prod_item_status", li_istatus)
					dw_item_list.SetItem(ll_i, "production_sheet_item_prod_item_pieces", ll_ipc)
					dw_item_list.SetItem(ll_i, "production_sheet_item_prod_item_net_wt", ll_inet)
					dw_item_list.SetItem(ll_i, "production_sheet_item_prod_item_theoreti", ll_itheo)
					dw_item_list.SetItem(ll_i, "production_sheet_item_prod_item_date", ld_idate)
					dw_item_list.SetItem(ll_i, "production_sheet_item_prod_item_placemen",ls_place)
					dw_item_list.SetItem(ll_i, "coil_coil_org_num", ls_coil_num)
					dw_item_list.SetItem(ll_i, "coil_lot_num", ls_lot)
				END IF
			END IF
		NEXT
	CASE 5	//delete skid
		IF dw_item_list.GetRow() > 0 THEN
			dw_item_list.DeleteRow(dw_item_list.GetRow() )
		END IF
END CHOOSE
dw_item_list.ResetUpdate()
//dw_item_list.Event ue_goto_row()

dw_editor.ResetUpdate()
dw_editor.Reset()
wf_set_action(0)

RETURN 1
end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Warehouse") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event pfc_new;dw_editor.Event pfc_addrow()
end event

event pfc_print;long ll_row_cut
Long ll_cust_id

ll_row_cut = dw_customer.GetRow()
ll_cust_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, TRUE)

OpenWithParm(w_report_inv_wh_skid, ll_cust_id )

Return 1
end event

type cb_orig from u_cb within w_wh_business
integer x = 2604
integer y = 1741
integer width = 362
integer height = 86
integer taborder = 140
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Load Orig.Data"
end type

event clicked;call super::clicked;Long		ll_row
Integer	li_status

If dw_editor.RowCount() > 0 Then
	ll_row = dw_item_list.GetRow()
	If ll_row < 1 Then Return -1
	
	li_status = dw_item_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, False)
	
	If li_status = 0 Then
		MessageBox("Error","Cannot modify data for this skid because it has been shipped to customer already.", StopSign!)
		Return 0
	End If
	
	wf_load_original_data(ll_row)
End If
end event

type dw_item_list from u_dw within w_wh_business
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 22
integer y = 179
integer width = 3525
integer height = 1290
integer taborder = 50
string dataobject = "d_wh_entry_skid_list_display"
boolean hscrollbar = true
end type

event ue_search_retrieve;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

ls_where = wf_search_terms()
is_condition = ls_where

ll_row = dw_customer.GetRow()
ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
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
ls_where = " WHERE ( production_sheet_item.coil_abc_num = coil.coil_abc_num (+)) and ( ~"SHEET_SKID_DETAIL~".~"SHEET_SKID_NUM~" = ~"SHEET_SKID~".~"SHEET_SKID_NUM~" ) and ( ~"SHEET_SKID_DETAIL~".~"PROD_ITEM_NUM~" = ~"PRODUCTION_SHEET_ITEM~".~"PROD_ITEM_NUM~" ) and  ( ~"SHEET_SKID~".~"AB_JOB_NUM~" = ~"AB_JOB~".~"AB_JOB_NUM~" ) and  ( ~"AB_JOB~".~"ORDER_ABC_NUM~" = ~"CUSTOMER_ORDER~".~"ORDER_ABC_NUM~" ) and   ( ~"SHEET_SKID~".~"SKID_FROM_IF_WHED~" > 0 ) AND  (~"CUSTOMER_ORDER~".~"ORIG_CUSTOMER_ID~" = :customer_id ) "   
is_condition = ls_where
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event constructor;of_SetBase(TRUE)
SetRowFocusIndicator(FocusRect!) 
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

event doubleclicked;long ll_skid, ll_row

ll_row = this.GetRow()
IF ll_row <= 0 THEN RETURN

IF f_security_door("Warehouse") = 0 THEN RETURN 

ll_skid = GetItemNumber(this.GetRow(), "sheet_skid_sheet_skid_num")

OpenWithParm(w_wh_detail, ll_skid)

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	Return dddw_cni.Retrieve()
END IF
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

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event retrieveend;//
end event

type dw_editor from u_dw within w_wh_business
event ue_insertitem ( )
event ue_delete_row ( )
integer x = 48
integer y = 1517
integer width = 3222
integer height = 208
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_wh_entry_skid_list_input"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event ue_insertitem;Long ll_row, ll_item
Int li_status

ll_row = dw_item_list.GetRow()
IF ll_row < 1 THEN Return
li_status = dw_item_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to add item to this skid because it has been shipped to customer already!", StopSign!)
	RETURN
END IF

dw_item_list.RowsCopy(dw_item_list.GetRow(), dw_item_list.GetRow(), Primary!, this, 1, Primary!)
ll_row = this.GetRow()
il_cur_skid = this.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)

DataWindowChild ldddw_cni
IF this.GetChild("sheet_skid_skid_from_if_whed", ldddw_cni) = -1 THEN 
	dw_editor.ResetUpdate()
	dw_editor.Reset()
	wf_set_action(0)
	RETURN
ELSE
	this.Event pfc_PopulateDDDW("sheet_skid_skid_from_if_whed", ldddw_cni)
END IF

wf_set_action(2)
end event

event ue_delete_row;Long ll_row, ll_item, ll_i, ll_numitem, ll_skid
Int li_status

ll_row = dw_item_list.GetRow()
IF ll_row < 1 THEN Return
li_status = dw_item_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to delete item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN
END IF

ll_skid =  dw_item_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ll_row > 1 THEN
	il_cur_skid = dw_item_list.GetItemNumber((ll_row - 1), "sheet_skid_sheet_skid_num", Primary!, FALSE)
ELSE
	il_cur_skid = 0
END IF

dw_item_list.RowsCopy(dw_item_list.GetRow(), dw_item_list.GetRow(), Primary!, this, 1, Primary!)

IF MessageBox("Warning","About to delete the item in editor box, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	ll_numitem = 0
	ll_row = dw_item_list.RowCount()
	FOR ll_i = 1 TO ll_row
		IF  dw_item_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) = ll_skid THEN ll_numitem = ll_numitem + 1
	NEXT
	IF ll_numitem > 1 THEN
		wf_set_action(3)
	ELSE
		wf_set_action(5)
	END IF
	cb_save.Event Clicked()
ELSE
	cb_cancel.Event Clicked()
END IF

end event

event constructor;SetRowFocusIndicator(FocusRect!) 
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
of_SetTransObject(SQLCA)


end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_skid, ll_item, ll_l, ll_job
Int li_i
Long ll_lrow
String ls_s

//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. Begin
String	ls_null
Long		ll_null
Integer	li_null

SetNull(ls_null)
SetNull(ll_null)
SetNull(li_null)
//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. End

ll_row = this.GetRow()
IF ll_row < 1 THEN RETURN 0

ll_skid = f_get_next_value("sheet_skid_num_seq")
il_cur_skid = ll_skid
this.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
this.SetItem(ll_row, "sheet_skid_detail_sheet_skid_num", ll_skid)
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
this.SetItem(ll_row, "sheet_skid_skid_date",Today())
this.SetItem(ll_row, "production_sheet_item_prod_item_date", Today())		
this.SetItem(ll_row, "sheet_skid_skid_sheet_status", 8)  //wh-ready
this.SetItem(ll_row, "production_sheet_item_prod_item_status", 2 ) //new

ll_lrow = dw_item_list.GetRow()
IF ll_lrow > 0 THEN
	//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. Comment out begin
	//li_i = dw_item_list.GetItemNumber(ll_lrow, "sheet_skid_skid_pieces", Primary!, FALSE)
	//this.SetItem(ll_row, "sheet_skid_skid_pieces", li_i)

	//production sheet item
	//ls_s = dw_item_list.GetItemString(ll_lrow, "coil_coil_org_num", Primary!, FALSE)
	//This.SetItem(ll_row, "coil_coil_org_num", ls_s)
	//ls_s = dw_item_list.GetItemString(ll_lrow, "coil_lot_num", Primary!, FALSE)
	//This.SetItem(ll_row, "coil_lot_num", ls_s)
	//ll_l = dw_item_list.GetItemNumber(ll_lrow, "production_sheet_item_ab_job_num", Primary!, FALSE)
	//this.SetItem(ll_row, "production_sheet_item_ab_job_num", ll_l)
	//ll_l = dw_item_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
	//this.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_l)
	//ll_l = dw_item_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
	//this.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_l)
	//ll_l = dw_item_list.GetItemNumber(ll_lrow, "sheet_skid_ab_job_num",Primary!, FALSE)
	//this.SetItem(ll_row,"sheet_skid_ab_job_num", ll_l)
	//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. Comment out End
	
	//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. Begin 
	This.SetItem(ll_row, "sheet_skid_skid_pieces", li_null)
	
	This.SetItem(ll_row, "coil_coil_org_num", ls_null)
	This.SetItem(ll_row, "coil_lot_num", ls_null)
	This.SetItem(ll_row, "production_sheet_item_ab_job_num", ll_null)
	This.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_null)
	This.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_null)
	This.SetItem(ll_row,"sheet_skid_ab_job_num", ll_null)
	//Alex Gerlants. 07/22/2020. Add_Cash_Date_2Warehouse_Coil. End
END IF

wf_set_action(1)

RETURN ll_skid

end event

event losefocus;call super::losefocus;Modify("DataWindow.Color = " + String(RGB(192,192,192)) )

end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.event pfc_rowchanged()
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

type cb_newskid from u_cb within w_wh_business
integer x = 29
integer y = 1741
integer width = 304
integer height = 86
integer taborder = 100
string facename = "Arial"
string text = "&New Skid"
end type

event clicked;dw_editor.Event pfc_addrow()
end event

type cb_delete from u_cb within w_wh_business
integer x = 768
integer y = 1741
integer width = 304
integer height = 86
integer taborder = 120
boolean bringtotop = true
string facename = "Arial"
string text = "&Delete"
end type

event clicked;dw_editor.Event ue_delete_row()
end event

type cb_close from u_cb within w_wh_business
integer x = 3237
integer y = 1741
integer width = 304
integer height = 86
integer taborder = 140
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_print from u_cb within w_wh_business
integer x = 2220
integer y = 1741
integer width = 304
integer height = 86
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.event pfc_print()
end event

type gb_editor from u_gb within w_wh_business
integer x = 26
integer y = 1466
integer width = 3522
integer height = 272
integer taborder = 10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Editor"
end type

type gb_search from u_gb within w_wh_business
integer x = 823
integer width = 2728
integer height = 176
integer taborder = 0
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "Search"
borderstyle borderstyle = styleraised!
end type

type st_cond from statictext within w_wh_business
integer x = 911
integer y = 54
integer width = 2377
integer height = 99
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

type cb_search from u_cb within w_wh_business
integer x = 3313
integer y = 32
integer width = 223
integer height = 64
integer taborder = 160
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&earch"
end type

event clicked;OpenWithParm(w_buildfilter, dw_item_list.DataObject)
Return 1
end event

type cb_reset from u_cb within w_wh_business
integer x = 3313
integer y = 102
integer width = 223
integer height = 64
integer taborder = 150
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;dw_item_list.Event ue_resume_where()
end event

type dw_customer from u_dw within w_wh_business
integer x = 658
integer y = 6
integer width = 88
integer height = 38
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_customer_short_display"
end type

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)
wf_display_total_info()

Return 

end event

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event rbuttondown;//override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type ddlb_customer from u_ddlb within w_wh_business
integer x = 26
integer y = 74
integer width = 779
integer height = 1251
integer taborder = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
integer limit = 20
end type

event selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		il_customer_id = dw_customer.Object.customer_id[ll_i] //Alex Gerlants. 03/05/2021. Warehouse_Application_Fix
		is_customer_short_name = ls_text //Alex Gerlants. 03/05/2021. Warehouse_Application_Fix
		
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		dw_item_list.Event ue_resume_where()
	END IF
NEXT

end event

type st_1 from statictext within w_wh_business
integer x = 26
integer y = 6
integer width = 424
integer height = 54
boolean bringtotop = true
integer textsize = -8
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

type cb_save from u_cb within w_wh_business
integer x = 3284
integer y = 1536
integer width = 245
integer height = 74
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;Parent.Event pfc_save()
end event

type cb_cancel from u_cb within w_wh_business
integer x = 3284
integer y = 1638
integer width = 245
integer height = 74
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "C&ancel"
end type

event clicked;dw_editor.ResetUpdate()
dw_editor.Reset()
wf_set_action(0)
end event

type cb_newitem from u_cb within w_wh_business
integer x = 391
integer y = 1741
integer width = 304
integer height = 86
integer taborder = 110
string facename = "Arial"
string text = "New &Item"
end type

event clicked;dw_editor.Event ue_insertitem()
end event

type cb_modify from u_cb within w_wh_business
integer x = 1477
integer y = 1741
integer width = 304
integer height = 86
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;Return parent.Event ue_modify()
end event

type cb_refer from u_cb within w_wh_business
integer x = 1851
integer y = 1741
integer width = 304
integer height = 86
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Refer.."
end type

event clicked;long ll_skid, ll_row

ll_row = dw_item_list.GetRow()
IF ll_row <= 0 THEN RETURN

IF f_security_door("Warehouse") = 0 THEN RETURN 

ll_skid = dw_item_list.GetItemNumber(dw_item_list.GetRow(), "sheet_skid_sheet_skid_num")

OpenWithParm(w_wh_detail, ll_skid)

end event

type cb_sort from u_cb within w_wh_business
string tag = "click item then sort"
integer x = 1145
integer y = 1741
integer width = 267
integer height = 83
integer taborder = 11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ort"
end type

event clicked;Parent.Event ue_sort()
end event

