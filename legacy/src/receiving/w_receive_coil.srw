$PBExportHeader$w_receive_coil.srw
$PBExportComments$<Sheet> receive coil and print out barcode_abc_coil_form inherited froam pfemain/w_sheet
forward
global type w_receive_coil from w_sheet
end type
type dw_coil_list from u_dw within w_receive_coil
end type
type cb_new from u_cb within w_receive_coil
end type
type cb_print from u_cb within w_receive_coil
end type
type dw_customer from u_dw within w_receive_coil
end type
type cb_close from u_cb within w_receive_coil
end type
type cb_sort from u_cb within w_receive_coil
end type
type gb_search from u_gb within w_receive_coil
end type
type ddlb_customer from dropdownlistbox within w_receive_coil
end type
type st_1 from statictext within w_receive_coil
end type
type cb_modify from u_cb within w_receive_coil
end type
type st_cond from statictext within w_receive_coil
end type
type cb_search from u_cb within w_receive_coil
end type
type cb_reset from u_cb within w_receive_coil
end type
type dw_editor from u_dw within w_receive_coil
end type
type cb_cancel from u_cb within w_receive_coil
end type
type cb_save from u_cb within w_receive_coil
end type
end forward

global type w_receive_coil from w_sheet
int X=4
int Y=3
int Width=3566
int Height=2112
boolean TitleBar=true
string Title="Coil Receiving"
string Tag="Receive coils from customer"
string MenuName="m_receive_coil"
boolean MaxBox=false
boolean Resizable=false
event type integer ue_printreport ( string titlestr )
event type datastore ue_return_dw ( )
event ue_menu_new ( )
event ue_menu_del ( )
event ue_deleteitem ( )
event ue_sort ( )
event type string ue_whoami ( )
event ue_read_only ( )
event ue_set_search ( datawindow adw_d )
event type any ue_get_header ( string as_id )
event type integer ue_new ( )
dw_coil_list dw_coil_list
cb_new cb_new
cb_print cb_print
dw_customer dw_customer
cb_close cb_close
cb_sort cb_sort
gb_search gb_search
ddlb_customer ddlb_customer
st_1 st_1
cb_modify cb_modify
st_cond st_cond
cb_search cb_search
cb_reset cb_reset
dw_editor dw_editor
cb_cancel cb_cancel
cb_save cb_save
end type
global w_receive_coil w_receive_coil

type variables
datastore ids_datastore
String is_select
s_coil_info ids_coil
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_new
Boolean ib_modify
Long il_cur_coil
end variables

forward prototypes
public function string wf_search_terms ()
public function datawindow wf_return_dw_coil_list ()
public function integer wf_duplicated_coil ()
public subroutine wf_init_dwdb ()
public subroutine wf_reset_condition ()
public function long wf_get_userid (string as_name)
public subroutine wf_normal_mode ()
public subroutine wf_editor_mode ()
end prototypes

event ue_printreport;call super::ue_printreport;
Return 1
end event

event ue_return_dw;call super::ue_return_dw;Return  ids_datastore
end event

event ue_menu_new;call super::ue_menu_new;dw_coil_list.Event pfc_addRow()
end event

event ue_deleteitem;call super::ue_deleteitem;integer li_rc
li_rc = MessageBox("Warning!", "Are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	//dw_coil_list.Event pfc_deleteRow()
	dw_coil_list.inv_rowmanager.of_DeleteRow(0)
END IF

end event

event ue_sort;call super::ue_sort;String ls_null

SetNULL(ls_null)
dw_coil_list.inv_sort.of_SetSort(ls_null)
dw_coil_list.inv_sort.of_Sort()
end event

event ue_whoami;RETURN "w_receive_coil"
end event

event ue_read_only;dw_coil_list.Object.DataWindow.ReadOnly = "YES"
cb_new.Enabled = FALSE
cb_save.Enabled = FALSE
cb_modify.Enabled = FALSE

m_receive_coil.m_file.m_new.Disable()
m_receive_coil.m_file.m_save.Disable()
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
					CASE "DONE"
						istr_search[li_s].value = "0"
					CASE "INPROCESS"
						istr_search[li_s].value = "1"					
					CASE "READY"
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
					CASE ELSE
						istr_search[li_s].value = "9999"
				END CHOOSE
			END IF
			IF istr_search[li_s].col_type = "customer" THEN
					istr_search[li_s].value = String(wf_get_userid(istr_search[li_s].value))
			END IF
			li_s++
		END IF
	li_i++
	LOOP
NEXT

dw_coil_list.Event ue_search_retrieve()

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
	ib_new = TRUE
	dw_editor.Event pfc_addRow()
	wf_editor_mode()
END IF

RETURN 1

end event

public function string wf_search_terms ();String ls_1, ls_op
String ls_terms
integer li_i

ls_terms = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id ) AND ( ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 2 ) OR ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 5 ) )"
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "number"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "customer"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
			CASE "status"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
			CASE "date"
				ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
			CASE "string"
				ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public function datawindow wf_return_dw_coil_list ();Return dw_coil_list
end function

public function integer wf_duplicated_coil ();//If there are duplcated coil_orig_num then return 1 else return 0
Long ll_row
Long ll_id, ll_old_id
String ls_num, ls_alt
Int li_rc

ll_row = dw_editor.RowCount()
IF ll_row <= 0 THEN Return 1
ll_id = dw_editor.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE )
ls_num = dw_editor.GetItemString(ll_row, "coil_org_num", Primary!, FALSE )
ls_alt = dw_editor.GetItemString(ll_row, "coil_mid_num", Primary!, FALSE )
ll_old_id = 0

CONNECT USING SQLCA;
SELECT coil_abc_num INTO :ll_old_id
FROM coil
WHERE coil_org_num = :ls_num
USING SQLCA;
IF (ll_id <> ll_old_id) AND (ll_old_id > 1) THEN
	li_rc = MessageBox("Warning","Coil #" + String(ll_id) + " and coil #" + String(ll_old_id) +" have duplicated coil original number, Continue?", Question!,YesNo!, 2)
	IF li_rc = 2 THEN Return -1
END IF

SELECT coil_abc_num INTO :ll_old_id
FROM coil
WHERE coil_mid_num = :ls_alt
USING SQLCA;
IF (ll_id <> ll_old_id) AND (ll_old_id > 1) THEN
	li_rc = MessageBox("Warning","Coil #" + String(ll_id) + " and coil #" + String(ll_old_id) +" have duplicated alt. coil number, Continue?", Question!,YesNo!, 2)
	IF li_rc = 2 THEN Return -1
END IF

Return 1
end function

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

public subroutine wf_normal_mode ();cb_save.Enabled = FALSE
cb_new.Enabled = TRUE
cb_modify.Enabled = TRUE
il_cur_coil = 0
end subroutine

public subroutine wf_editor_mode ();cb_save.Enabled = TRUE
cb_new.Enabled = FALSE
cb_modify.Enabled = FALSE
end subroutine

on w_receive_coil.create
int iCurrent
call super::create
if this.MenuName = "m_receive_coil" then this.MenuID = create m_receive_coil
this.dw_coil_list=create dw_coil_list
this.cb_new=create cb_new
this.cb_print=create cb_print
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.cb_sort=create cb_sort
this.gb_search=create gb_search
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.cb_modify=create cb_modify
this.st_cond=create st_cond
this.cb_search=create cb_search
this.cb_reset=create cb_reset
this.dw_editor=create dw_editor
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_list
this.Control[iCurrent+2]=this.cb_new
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.dw_customer
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_sort
this.Control[iCurrent+7]=this.gb_search
this.Control[iCurrent+8]=this.ddlb_customer
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cb_modify
this.Control[iCurrent+11]=this.st_cond
this.Control[iCurrent+12]=this.cb_search
this.Control[iCurrent+13]=this.cb_reset
this.Control[iCurrent+14]=this.dw_editor
this.Control[iCurrent+15]=this.cb_cancel
this.Control[iCurrent+16]=this.cb_save
end on

on w_receive_coil.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_coil_list)
destroy(this.cb_new)
destroy(this.cb_print)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.cb_sort)
destroy(this.gb_search)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.cb_modify)
destroy(this.st_cond)
destroy(this.cb_search)
destroy(this.cb_reset)
destroy(this.dw_editor)
destroy(this.cb_cancel)
destroy(this.cb_save)
end on

event open;call super::open;dw_customer.Visible = FALSE

dw_customer.of_SetLinkage(TRUE)
dw_customer.inv_linkage.of_SetStyle(2)
dw_customer.inv_linkage.of_SetConfirmOnRowChange (True)
dw_customer.inv_linkage.of_setUpdateOnRowChange (TRUE)

dw_coil_list.of_SetLinkage( TRUE ) 
dw_coil_list.inv_Linkage.of_SetMaster(dw_customer)
IF NOT dw_coil_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & coil in win w_inv_coil!" )
ELSE
	dw_coil_list.inv_Linkage.of_Register( "customer_id", "customer_id" ) 
	dw_coil_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer.inv_Linkage.of_SetTransObject(sqlca) 
IF dw_customer.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_inv_coil::open function" )
ELSE
	SQLCA.of_Commit()
	dw_customer.SelectRow(1,TRUE)
	dw_customer.SetFocus()
End IF

wf_init_dwdb()

is_select = "SELECT  ~~~"COIL~~~".~~~"COIL_ABC_NUM~~~" ,           ~~~"COIL~~~".~~~"COIL_ORG_NUM~~~" ,           ~~~"COIL~~~".~~~"ICRA~~~" ,           ~~~"COIL~~~".~~~"COIL_MID_NUM~~~" ,           ~~~"COIL~~~".~~~"COIL_STATUS~~~" ,           ~~~"COIL~~~".~~~"COIL_ALLOY~~~" ,           ~~~"COIL~~~".~~~"COIL_TEMPER~~~" ,           ~~~"COIL~~~".~~~"LOT_NUM~~~" ,           ~~~"COIL~~~".~~~"COIL_GAUGE~~~" ,           ~~~"COIL~~~".~~~"COIL_WIDTH~~~" ,           ~~~"COIL~~~".~~~"DATE_RECEIVED~~~" ,           ~~~"COIL~~~".~~~"COIL_ENTRY_DATE~~~" ,           ~~~"COIL~~~".~~~"NET_WT~~~" ,           ~~~"COIL~~~".~~~"PIECES_PER_CASE~~~" ,           ~~~"COIL~~~".~~~"COIL_LOCATION~~~" ,           ~~~"COIL~~~".~~~"NET_WT_BALANCE~~~" ,           ~~~"COIL~~~".~~~"COIL_NOTES~~~" ,           ~~~"COIL~~~".~~~"COIL_LINE_NUM~~~" ,           ~~~"COIL~~~".~~~"COIL_EDI856_STATUS~~~" ,~~~"COIL~~~".~~~"CUSTOMER_ID~~~", ~~~"COIL~~~".~~~"COIL_FROM_CUST_ID~~~"      FROM ~~~"COIL~~~"    "  

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)



end event

event pfc_save;call super::pfc_save;SetPointer(HourGlass!)
Int li_rc

dw_editor.AcceptText()
IF wf_duplicated_coil() < 0 THEN Return -1

li_rc = dw_editor.Update()
IF li_rc = 1 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -2
END IF

IF ib_new THEN dw_coil_list.Event ue_display_changing(1)
IF ib_modify THEN dw_coil_list.Event ue_display_changing(2)

dw_editor.Reset()
wf_normal_mode()

RETURN 1
end event

event pfc_print;SetPointer(HourGlass!)

long ll_coil
Long ll_row

IF dw_customer.inv_Linkage.of_GetUpdatesPending() = 1 THEN
	MessageBox("Warning", "Save new information first!", StopSign!)
	Return -1
END IF

ll_row = dw_coil_list.GetRow()
IF ll_row <= 0 THEN RETURN 0
ll_coil = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num")

OpenwithParm(w_report_coil_barcode, ll_coil)

Return 1

end event

event close;call super::close;f_display_app()
end event

event activate;call super::activate;IF f_security_door("Shipment(Receiving)") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

type dw_coil_list from u_dw within w_receive_coil
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_display_changing ( integer ai_type )
event ue_goto_row ( )
int X=29
int Y=192
int Width=3493
int Height=1427
int TabOrder=10
string DataObject="d_receive_coil_list"
boolean HScrollBar=true
end type

event ue_search_retrieve;String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer ls_net

ls_where = wf_search_terms()

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
ls_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id ) AND ( ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 2 ) OR ( ~~~"COIL~~~".~~~"COIL_STATUS~~~" = 5 ) )"
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(ll_cust)
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"

end event

event ue_display_changing;CHOOSE CASE ai_type
	CASE 1	//new
		dw_editor.RowsCopy(dw_editor.GetRow(), dw_editor.RowCount(), Primary!, dw_coil_list, 1, Primary!)
		ib_new = FALSE
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
		END IF
		ib_modify = FALSE
END CHOOSE
this.ResetUpdate()
this.Event ue_goto_row()

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

event doubleclicked;// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
long ll_coil, ll_num

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

IF f_security_door("Shipment(Receiving)") = 0 THEN RETURN 

ll_coil = this.GetItemNumber(row, "coil_abc_num", Primary!, FALSE)

IF ll_coil > 0 THEN OpenWithParm(w_coil_detail_display, ll_coil)


end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
//of_SetReqColumn(True)
//inv_reqcolumn.of_RegisterSkipColumn("coil_org_num")
//
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

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

type cb_new from u_cb within w_receive_coil
int X=541
int Y=1837
int Width=340
int Height=74
int TabOrder=80
string Text="&New"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;RETURN Parent.Event ue_new()

end event

type cb_print from u_cb within w_receive_coil
int X=2242
int Y=1837
int Width=340
int Height=74
int TabOrder=110
string Text="&BarCode"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Parent.Event pfc_print()
end event

type dw_customer from u_dw within w_receive_coil
int X=761
int Y=19
int Width=106
int Height=35
int TabOrder=0
string DataObject="d_customer_short_display"
boolean VScrollBar=false
boolean RightToLeft=true
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event clicked;SelectRow(0, FALSE)

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

event constructor;SetRowFocusIndicator(FocusRect!)
of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event itemfocuschanged;call super::itemfocuschanged;dw_coil_list.SetFilter("")
dw_coil_list.Filter()
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

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type cb_close from u_cb within w_receive_coil
int X=2809
int Y=1837
int Width=340
int Height=74
int TabOrder=120
string Tag="Exit"
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(Parent)
end event

type cb_sort from u_cb within w_receive_coil
event clicked pbm_bnclicked
int X=1675
int Y=1837
int Width=340
int Height=74
int TabOrder=100
string Tag="click item then sort"
string Text="S&ort"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;SetPointer(HourGlass!)

Parent.Event ue_sort()
end event

type gb_search from u_gb within w_receive_coil
int X=878
int Y=0
int Width=2633
int Height=186
int TabOrder=0
string Text="Search"
BorderStyle BorderStyle=StyleRaised!
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

type ddlb_customer from dropdownlistbox within w_receive_coil
int X=29
int Y=83
int Width=834
int Height=1363
int TabOrder=70
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
int Limit=20
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		dw_coil_list.Event ue_resume_where()
	END IF
NEXT

end event

type st_1 from statictext within w_receive_coil
int X=29
int Y=22
int Width=432
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="Current customer:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_modify from u_cb within w_receive_coil
int X=1108
int Y=1837
int Width=340
int Height=74
int TabOrder=90
string Text="&Modify"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;SetPointer(HourGlass!)

Long ll_row, ll_coil
ll_row = dw_coil_list.GetRow()
IF ll_row < 1 THEN RETURN -1
ll_coil = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
il_cur_coil = ll_coil

IF ll_coil > 0 THEN
	ib_modify = TRUE
	dw_editor.Event ue_display_popup(ll_row)
END IF

RETURN -1
end event

type st_cond from statictext within w_receive_coil
int X=911
int Y=48
int Width=2352
int Height=128
boolean Enabled=false
boolean BringToTop=true
string Text="All"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_search from u_cb within w_receive_coil
int X=3273
int Y=42
int Width=223
int Height=64
int TabOrder=50
boolean BringToTop=true
string Text="&Search"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;OpenWithParm(w_buildfilter, dw_coil_list.DataObject)
Return 1
end event

type cb_reset from u_cb within w_receive_coil
int X=3273
int Y=112
int Width=223
int Height=64
int TabOrder=30
boolean BringToTop=true
string Text="&Reset"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_coil_list.Event ue_resume_where()
end event

type dw_editor from u_dw within w_receive_coil
event ue_display_popup ( long al_row )
int X=44
int Y=1622
int Width=3160
int Height=205
int TabOrder=20
string DataObject="d_receive_coil_list_editor"
boolean HScrollBar=true
boolean VScrollBar=false
end type

event ue_display_popup;s_coil_info lds_data
Long ll_row 

lds_data.customer_id = dw_coil_list.GetItemNumber(al_row, "customer_id",Primary!, FALSE)
lds_data.ab_coil_num = dw_coil_list.GetItemNumber(al_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = dw_coil_list.GetItemString(al_row, "coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = dw_coil_list.GetItemString(al_row, "coil_mid_num", Primary!, FALSE)
lds_data.lot_num = dw_coil_list.GetItemString(al_row, "lot_num",Primary!, FALSE)
lds_data.pieces = dw_coil_list.GetItemNumber(al_row, "pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = dw_coil_list.GetItemNumber(al_row, "coil_line_num", Primary!, FALSE)
lds_data.icra = dw_coil_list.GetItemString(al_row, "icra", Primary!, FALSE)
lds_data.alloy = dw_coil_list.GetItemString(al_row, "coil_alloy2",Primary!, FALSE)
lds_data.gauge = dw_coil_list.GetItemNumber(al_row, "coil_gauge", Primary!, FALSE)
lds_data.Temper = dw_coil_list.GetItemString(al_row, "coil_temper", Primary!, FALSE)
lds_data.net_wt = dw_coil_list.GetItemNumber(al_row, "net_wt", Primary!, FALSE)
lds_data.net_balance = dw_coil_list.GetItemNumber(al_row, "net_wt_balance", Primary!, FALSE)
lds_data.width = dw_coil_list.GetItemNumber(al_row, "coil_width", Primary!, FALSE)
lds_data.date_received = dw_coil_list.GetItemDateTime(al_row, "date_received", Primary!, FALSE)
lds_data.location = dw_coil_list.GetItemString(al_row, "coil_location", Primary!, FALSE)
lds_data.status = dw_coil_list.GetItemNumber(al_row, "coil_status", Primary!, FALSE)
lds_data.notes = dw_coil_list.GetItemString(al_row, "coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = dw_coil_list.GetItemNumber(al_row, "coil_from_cust_id", Primary!, FALSE)

OpenWithParm(w_coil_detail_2, lds_data)
lds_data = message.PowerObjectParm

IF lds_data.ab_coil_num > 0 THEN
	//this.SetItem(al_row, "customer_id",lds_data.customer_id)
	//this.SetItem(al_row, "coil_abc_num", lds_data.ab_coil_num )
	dw_editor.Retrieve(lds_data.ab_coil_num)
	ll_row = dw_editor.GetRow()
	this.SetItem(ll_row, "coil_org_num",lds_data.coil_orig_num  )
	this.SetItem(ll_row, "coil_mid_num",lds_data.coil_alt_num)
	this.SetItem(ll_row, "lot_num", lds_data.lot_num   )
	this.SetItem(ll_row, "pieces_per_case", lds_data.pieces)
	this.SetItem(ll_row, "coil_line_num", lds_data.coil_line_num)
	this.SetItem(ll_row, "icra", lds_data.icra )
	this.SetItem(ll_row, "coil_alloy2", lds_data.alloy)
	this.SetItem(ll_row, "coil_gauge",lds_data.gauge )
	this.SetItem(ll_row, "coil_temper",lds_data.Temper )
	this.SetItem(ll_row, "net_wt",lds_data.net_wt )
	this.SetItem(ll_row, "net_wt_balance", lds_data.net_balance)
	this.SetItem(ll_row, "coil_width",lds_data.width )
	this.SetItem(ll_row, "date_received", lds_data.date_received)
	this.SetItem(ll_row, "coil_location", lds_data.location )
	this.SetItem(ll_row, "coil_status",lds_data.status )
	this.SetItem(ll_row, "coil_notes", lds_data.notes )
	this.SetItem(ll_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
	wf_editor_mode()
END IF
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

event pfc_addrow;call super::pfc_addrow;long ll_row_coil, ll_row_cut,ll_c_id, ll_new_id

ll_row_coil = this.GetRow()
ll_row_cut = dw_customer.GetRow()
ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
this.SetItem(ll_row_coil, "customer_id", ll_c_id)
ll_new_id = f_get_next_value("coil_abc_num_seq")
this.SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
this.setItem(ll_row_coil, "coil_entry_date", Today() )
this.setItem(ll_row_coil, "coil_status", 2 )  //new coil
//dw_editor.setItem(ll_row_coil, "material_type", 1 ) //aluminum

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

RETURN ll_new_id 

end event

type cb_cancel from u_cb within w_receive_coil
int X=3215
int Y=1738
int Width=300
int Height=74
int TabOrder=60
string Text="C&ancel"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_editor.Reset()
wf_normal_mode()
end event

type cb_save from u_cb within w_receive_coil
int X=3215
int Y=1642
int Width=300
int Height=74
int TabOrder=40
boolean BringToTop=true
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Parent.Event pfc_Save()

end event

