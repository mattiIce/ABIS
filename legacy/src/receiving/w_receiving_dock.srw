$PBExportHeader$w_receiving_dock.srw
$PBExportComments$<Sheet> app for coil receiving dock, inherited from pfemain\w_sheet
forward
global type w_receiving_dock from w_sheet
end type
type sle_bol from u_sle within w_receiving_dock
end type
type st_3 from u_st within w_receiving_dock
end type
type sle_coilmidid from u_sle within w_receiving_dock
end type
type rb_abco from u_rb within w_receiving_dock
end type
type rb_109 from u_rb within w_receiving_dock
end type
type rb_1005 from u_rb within w_receiving_dock
end type
type rb_1533 from u_rb within w_receiving_dock
end type
type rb_1459 from u_rb within w_receiving_dock
end type
type rb_1591 from u_rb within w_receiving_dock
end type
type rb_93 from u_rb within w_receiving_dock
end type
type rb_188 from u_rb within w_receiving_dock
end type
type rb_50 from u_rb within w_receiving_dock
end type
type rb_1027 from u_rb within w_receiving_dock
end type
type rb_1188 from u_rb within w_receiving_dock
end type
type rb_106 from u_rb within w_receiving_dock
end type
type rb_35 from u_rb within w_receiving_dock
end type
type rb_55 from u_rb within w_receiving_dock
end type
type rb_1153 from u_rb within w_receiving_dock
end type
type rb_1 from u_rb within w_receiving_dock
end type
type rb_select from u_rb within w_receiving_dock
end type
type st_1 from u_st within w_receiving_dock
end type
type st_totalwt from u_st within w_receiving_dock
end type
type st_edi from u_st within w_receiving_dock
end type
type st_totalcoils from u_st within w_receiving_dock
end type
type st_2 from u_st within w_receiving_dock
end type
type cb_enter from u_cb within w_receiving_dock
end type
type sle_coilorgid from u_sle within w_receiving_dock
end type
type dw_coil_list from u_dw within w_receiving_dock
end type
type cb_new from u_cb within w_receiving_dock
end type
type cb_reset from u_cb within w_receiving_dock
end type
type cb_delete from u_cb within w_receiving_dock
end type
type dw_customer from u_dw within w_receiving_dock
end type
type cb_close from u_cb within w_receiving_dock
end type
type ddlb_customer from dropdownlistbox within w_receiving_dock
end type
type cb_modify from u_cb within w_receiving_dock
end type
type gb_coilid from u_gb within w_receiving_dock
end type
type cb_save from u_cb within w_receiving_dock
end type
type dw_editor from u_dw within w_receiving_dock
end type
type gb_detail from u_gb within w_receiving_dock
end type
type cb_barcode from u_cb within w_receiving_dock
end type
type gb_edi from u_gb within w_receiving_dock
end type
type gb_1 from u_gb within w_receiving_dock
end type
type rb_orig from u_rb within w_receiving_dock
end type
type gb_2 from u_gb within w_receiving_dock
end type
end forward

global type w_receiving_dock from w_sheet
string tag = "Customer Coils"
integer x = 4
integer y = 3
integer width = 3668
integer height = 2048
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
event type integer ue_new ( )
event type integer ue_modify ( )
event type integer ue_delete ( )
event type integer ue_refer ( )
event type integer ue_report ( )
event type integer ue_import ( )
event type long ue_barcode ( )
event type integer ue_entercoil ( )
event type integer ue_enterexistcoil ( )
event ue_reset ( )
sle_bol sle_bol
st_3 st_3
sle_coilmidid sle_coilmidid
rb_abco rb_abco
rb_109 rb_109
rb_1005 rb_1005
rb_1533 rb_1533
rb_1459 rb_1459
rb_1591 rb_1591
rb_93 rb_93
rb_188 rb_188
rb_50 rb_50
rb_1027 rb_1027
rb_1188 rb_1188
rb_106 rb_106
rb_35 rb_35
rb_55 rb_55
rb_1153 rb_1153
rb_1 rb_1
rb_select rb_select
st_1 st_1
st_totalwt st_totalwt
st_edi st_edi
st_totalcoils st_totalcoils
st_2 st_2
cb_enter cb_enter
sle_coilorgid sle_coilorgid
dw_coil_list dw_coil_list
cb_new cb_new
cb_reset cb_reset
cb_delete cb_delete
dw_customer dw_customer
cb_close cb_close
ddlb_customer ddlb_customer
cb_modify cb_modify
gb_coilid gb_coilid
cb_save cb_save
dw_editor dw_editor
gb_detail gb_detail
cb_barcode cb_barcode
gb_edi gb_edi
gb_1 gb_1
rb_orig rb_orig
gb_2 gb_2
end type
global w_receiving_dock w_receiving_dock

type variables
s_coil_info ids_coil
Long il_cust, il_abco_id, il_file_id
Boolean ib_edi, ib_modify, ib_dul_id
String is_org_id, is_alt_id, is_bol
end variables

forward prototypes
public function integer wf_duplicated_coil ()
public function integer wf_display_total_info ()
public function long wf_get_userid (string as_name)
public function boolean wf_coil_used (long al_coil)
public function integer wf_edi (string as_org_id)
public subroutine wf_disable_customers ()
public subroutine wf_enable_customers ()
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

event type string ue_whoami();RETURN "w_receiving_dock"
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

event type integer ue_new();IF dw_coil_list.RowCount() > 0 THEN
	MessageBox("Warning!", "Please finish processing current shipment." )
	RETURN -1
END IF
wf_enable_customers()
rb_abco.Enabled = FALSE
rb_abco.Checked = FALSE
ib_modify = FALSE
cb_delete.Enabled = TRUE
RETURN 1
end event

event type integer ue_modify();SetPointer(HourGlass!)
IF dw_coil_list.RowCount() > 0 THEN
	MessageBox("Warning!", "Please finish processing current shipment." )
	RETURN -1
END IF
wf_disable_customers()

rb_abco.Enabled = TRUE
ib_modify = TRUE
cb_delete.Enabled = FALSE

RETURN -1
end event

event type integer ue_delete();SetPointer(HourGlass!)

integer li_rc

li_rc = MessageBox("Warning!", "Deleting current coil, are you sure?", Exclamation!, OKCancel!, 2 )
IF Li_rc = 1 THEN
	dw_coil_list.inv_rowmanager.of_DeleteRow(0)
	wf_display_total_info()
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

event ue_report;SetPointer(HourGlass!)

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

event type long ue_barcode();SetPointer(HourGlass!)
IF dw_coil_list.RowCount() = 0 THEN
	MessageBox("Warning", "No coil specified.")
	RETURN 0
END IF

long ll_coil, ll_row

ll_row = dw_coil_list.GetRow()
ll_coil = dw_coil_list.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
IF ll_coil > 0 THEN OpenWithParm(w_report_coil_barcode_new, ll_coil )

RETURN 1

end event

event type integer ue_entercoil();Int li_c
String ls_bol
Long ll_file_id

IF ib_modify THEN RETURN this.Event ue_enterexistcoil()

IF dw_coil_list.RowCount() > 0 THEN wf_disable_customers()

is_org_id = sle_coilorgid.Text
is_alt_id = sle_coilmidid.Text
IF (LEN(is_org_id) <= 3) OR ISNULL(is_org_id) THEN
	MessageBox("Warning", "Invalid coil Number.")
	RETURN -1
END IF

IF wf_duplicated_coil() = 1 THEN RETURN -2

IF wf_edi(is_org_id) > 0 THEN
		
	SELECT count(*) INTO :li_c
	FROM inbound_coil
	WHERE (coil_number = :is_org_id) 
	USING SQLCA;
	
	SetNULL(ls_bol)
	SetNULL(ll_file_id)
	IF li_c = 1 THEN
		ib_dul_id = FALSE
		SELECT bol, edi_file_id INTO :ls_bol,:ll_file_id 
		FROM inbound_coil
		WHERE (coil_number = :is_org_id)
		USING SQLCA;
	ELSE
		ib_dul_id = TRUE
		SELECT bol,edi_file_id INTO :ls_bol, :ll_file_id
		FROM inbound_coil
		WHERE (coil_number = :is_org_id) AND (ps_coil_number = :is_alt_id)
		USING SQLCA;
		IF isNULL(is_bol) THEN
			MessageBox("Warning","Duplicated coil original id, please provide alt.number to identify the coil.")
			RETURN 0
		END IF
	END IF
	IF dw_coil_list.RowCount() = 0 THEN //first row
		is_bol = ls_bol
		il_file_id = ll_file_id
	ELSE
		IF (is_bol <> ls_bol) OR (il_file_id <> ll_file_id) THEN
			MessageBox("Warning","This coil is not part of this shipment based on EDI info. Please verify.")
			RETURN 0
		END IF
	END IF
	sle_bol.Text = is_bol
	ib_edi = TRUE
	st_edi.Text = "EDI"
ELSE 
	ib_edi = FALSE
	st_edi.Text = "NO"
END IF

dw_coil_list.Event pfc_addRow()

RETURN 1


RETURN 0
end event

event type integer ue_enterexistcoil();Int li_c, li_s

is_org_id = sle_coilorgid.Text
IF (LEN(is_org_id) <= 3) OR ISNULL(is_org_id) THEN
	MessageBox("Warning", "Invalid coil Number.")
	RETURN -1
END IF

IF rb_abco.Checked THEN 
	il_abco_id = Long(is_org_id)
	CONNECT USING SQLCA;
	SELECT Count(*) INTO :li_c
	FROM COIL
	WHERE coil_abc_num = :il_abco_id
	USING SQLCA;
	IF li_c <> 1 THEN 
		MessageBox("Warning","Invalid ABCO coil number.")
		RETURN 0
	END IF
	SELECT coil_status INTO :li_s
	FROM COIL
	WHERE coil_abc_num = :il_abco_id
	USING SQLCA;
	IF li_s <> 2 THEN 
		MessageBox("Warning","Coil has ready been processed. No change can be made here.")
		RETURN 0
	END IF
ELSE
	CONNECT USING SQLCA;
	SELECT Count(*) INTO :li_c
	FROM COIL
	WHERE coil_org_num = :is_org_id
	USING SQLCA;
	IF li_c = 0 THEN 
		MessageBox("Warning","Invalid coil original number.")
		RETURN 0
	END IF
	IF li_c > 1 THEN 
		MessageBox("Warning","Multiple coils have this original number, please specify.")
		RETURN 0
	END IF
	SELECT coil_status INTO :li_s
	FROM COIL
	WHERE coil_org_num = :is_org_id
	USING SQLCA;
	IF li_s <> 2 THEN 
		MessageBox("Warning","Coil has ready been processed. No change can be made here.")
		RETURN 0
	END IF
END IF

dw_coil_list.Event pfc_addRow()

RETURN 1

end event

event ue_reset();dw_coil_list.Reset()
wf_enable_customers()
wf_display_total_info()
rb_orig.Checked = TRUE
rb_abco.Enabled = FALSE
ib_edi = FALSE
st_edi.Text = "EDI/NO"
sle_bol.Text = ""
SetNULL(is_bol)
sle_coilorgid.Text = ""
SetNULL(is_org_id)
sle_coilmidid.Text = ""
SetNULL(is_alt_id)
ib_dul_id = FALSE
rb_1153.Checked = TRUE
il_cust = 1153
SetNULL(il_abco_id)
SetNULL(il_file_id)
ib_modify = FALSE
cb_delete.Enabled = TRUE

end event

public function integer wf_duplicated_coil ();//If there are duplcated coil_orig_num then return 1 else return 0
Long ll_row
Int li_i

CONNECT USING SQLCA;
SELECT count(*) INTO :li_i
FROM coil
WHERE (coil_org_num = :is_org_id) AND (customer_id = :il_cust) AND (coil_mid_num = :is_alt_id)
USING SQLCA;
IF li_i > 0 THEN
	MessageBox("Warning","Duplicated coil original number.")
	Return 1
END IF

ll_row = dw_coil_list.RowCount()
IF ll_row <= 0 THEN Return 0
FOR li_i = 1 to ll_row
	IF (is_org_id = dw_coil_list.GetItemString(li_i, "coil_org_num", Primary!, FALSE)) AND &
	 (is_alt_id = dw_coil_list.GetItemString(li_i, "coil_mid_num", Primary!, FALSE)) THEN
		MessageBox("Warning","Coil is already on the list.")
		RETURN 1
	END IF
NEXT
Return 0
end function

public function integer wf_display_total_info ();integer li_row, li_totalcoil, li_int
Long ll_total_wt, ll_coil_wt

ll_total_wt = 0

li_totalcoil = dw_coil_list.RowCount()
IF li_totalcoil > 0 THEN 
	FOR li_int = 1 TO li_totalcoil
		ll_coil_wt = dw_coil_list.GetItemNumber( li_int, "net_wt", Primary!, FALSE)
		IF isNULL(ll_coil_wt) THEN ll_coil_wt = 0
		ll_total_wt = ll_total_wt + ll_coil_wt
	NEXT
END IF

st_totalcoils.Text = String(li_totalcoil, "###,###" )
IF ll_total_wt > 1 THEN
	st_totalwt.Text =String(ll_total_wt, "###,###,###") + " LBs"
ELSE
	st_totalwt.Text =String(ll_total_wt, "###,###,###") + " LB"
END IF

RETURN li_totalcoil

end function

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

public function integer wf_edi (string as_org_id);Int li_yes

li_yes = 0
CONNECT USING SQLCA;
SELECT COUNT(*) INTO :li_yes
FROM inbound_coil
WHERE coil_number = :as_org_id
USING SQLCA;
RETURN li_yes 
end function

public subroutine wf_disable_customers ();rb_select.Enabled = FALSE
ddlb_customer.Enabled = FALSE
rb_1153.Enabled = FALSE
rb_55.Enabled = FALSE
rb_35.Enabled = FALSE
rb_106.Enabled = FALSE
rb_1188.Enabled = FALSE
rb_1027.Enabled = FALSE
rb_50.Enabled = FALSE
rb_188.Enabled = FALSE
rb_93.Enabled = FALSE
rb_1591.Enabled = FALSE
rb_1459.Enabled = FALSE
rb_1533.Enabled = FALSE
rb_1005.Enabled = FALSE
rb_109.Enabled = FALSE
end subroutine

public subroutine wf_enable_customers ();rb_select.Enabled = TRUE
ddlb_customer.Enabled = TRUE
rb_1153.Enabled = TRUE
rb_55.Enabled = TRUE
rb_35.Enabled = TRUE
rb_106.Enabled = TRUE
rb_1188.Enabled = TRUE
rb_1027.Enabled = TRUE
rb_50.Enabled = TRUE
rb_188.Enabled = TRUE
rb_93.Enabled = TRUE
rb_1591.Enabled = TRUE
rb_1459.Enabled = TRUE
rb_1533.Enabled = TRUE
rb_1005.Enabled = TRUE
rb_109.Enabled = TRUE
end subroutine

on w_receiving_dock.create
int iCurrent
call super::create
if this.MenuName = "m_coil_main" then this.MenuID = create m_coil_main
this.sle_bol=create sle_bol
this.st_3=create st_3
this.sle_coilmidid=create sle_coilmidid
this.rb_abco=create rb_abco
this.rb_109=create rb_109
this.rb_1005=create rb_1005
this.rb_1533=create rb_1533
this.rb_1459=create rb_1459
this.rb_1591=create rb_1591
this.rb_93=create rb_93
this.rb_188=create rb_188
this.rb_50=create rb_50
this.rb_1027=create rb_1027
this.rb_1188=create rb_1188
this.rb_106=create rb_106
this.rb_35=create rb_35
this.rb_55=create rb_55
this.rb_1153=create rb_1153
this.rb_1=create rb_1
this.rb_select=create rb_select
this.st_1=create st_1
this.st_totalwt=create st_totalwt
this.st_edi=create st_edi
this.st_totalcoils=create st_totalcoils
this.st_2=create st_2
this.cb_enter=create cb_enter
this.sle_coilorgid=create sle_coilorgid
this.dw_coil_list=create dw_coil_list
this.cb_new=create cb_new
this.cb_reset=create cb_reset
this.cb_delete=create cb_delete
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.ddlb_customer=create ddlb_customer
this.cb_modify=create cb_modify
this.gb_coilid=create gb_coilid
this.cb_save=create cb_save
this.dw_editor=create dw_editor
this.gb_detail=create gb_detail
this.cb_barcode=create cb_barcode
this.gb_edi=create gb_edi
this.gb_1=create gb_1
this.rb_orig=create rb_orig
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_bol
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.sle_coilmidid
this.Control[iCurrent+4]=this.rb_abco
this.Control[iCurrent+5]=this.rb_109
this.Control[iCurrent+6]=this.rb_1005
this.Control[iCurrent+7]=this.rb_1533
this.Control[iCurrent+8]=this.rb_1459
this.Control[iCurrent+9]=this.rb_1591
this.Control[iCurrent+10]=this.rb_93
this.Control[iCurrent+11]=this.rb_188
this.Control[iCurrent+12]=this.rb_50
this.Control[iCurrent+13]=this.rb_1027
this.Control[iCurrent+14]=this.rb_1188
this.Control[iCurrent+15]=this.rb_106
this.Control[iCurrent+16]=this.rb_35
this.Control[iCurrent+17]=this.rb_55
this.Control[iCurrent+18]=this.rb_1153
this.Control[iCurrent+19]=this.rb_1
this.Control[iCurrent+20]=this.rb_select
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.st_totalwt
this.Control[iCurrent+23]=this.st_edi
this.Control[iCurrent+24]=this.st_totalcoils
this.Control[iCurrent+25]=this.st_2
this.Control[iCurrent+26]=this.cb_enter
this.Control[iCurrent+27]=this.sle_coilorgid
this.Control[iCurrent+28]=this.dw_coil_list
this.Control[iCurrent+29]=this.cb_new
this.Control[iCurrent+30]=this.cb_reset
this.Control[iCurrent+31]=this.cb_delete
this.Control[iCurrent+32]=this.dw_customer
this.Control[iCurrent+33]=this.cb_close
this.Control[iCurrent+34]=this.ddlb_customer
this.Control[iCurrent+35]=this.cb_modify
this.Control[iCurrent+36]=this.gb_coilid
this.Control[iCurrent+37]=this.cb_save
this.Control[iCurrent+38]=this.dw_editor
this.Control[iCurrent+39]=this.gb_detail
this.Control[iCurrent+40]=this.cb_barcode
this.Control[iCurrent+41]=this.gb_edi
this.Control[iCurrent+42]=this.gb_1
this.Control[iCurrent+43]=this.rb_orig
this.Control[iCurrent+44]=this.gb_2
end on

on w_receiving_dock.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_bol)
destroy(this.st_3)
destroy(this.sle_coilmidid)
destroy(this.rb_abco)
destroy(this.rb_109)
destroy(this.rb_1005)
destroy(this.rb_1533)
destroy(this.rb_1459)
destroy(this.rb_1591)
destroy(this.rb_93)
destroy(this.rb_188)
destroy(this.rb_50)
destroy(this.rb_1027)
destroy(this.rb_1188)
destroy(this.rb_106)
destroy(this.rb_35)
destroy(this.rb_55)
destroy(this.rb_1153)
destroy(this.rb_1)
destroy(this.rb_select)
destroy(this.st_1)
destroy(this.st_totalwt)
destroy(this.st_edi)
destroy(this.st_totalcoils)
destroy(this.st_2)
destroy(this.cb_enter)
destroy(this.sle_coilorgid)
destroy(this.dw_coil_list)
destroy(this.cb_new)
destroy(this.cb_reset)
destroy(this.cb_delete)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.ddlb_customer)
destroy(this.cb_modify)
destroy(this.gb_coilid)
destroy(this.cb_save)
destroy(this.dw_editor)
destroy(this.gb_detail)
destroy(this.cb_barcode)
destroy(this.gb_edi)
destroy(this.gb_1)
destroy(this.rb_orig)
destroy(this.gb_2)
end on

event open;call super::open;dw_customer.Visible = FALSE
dw_customer.SetTransObject(SQLCA)
dw_customer.Retrieve()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)
ddlb_customer.Event SelectionChanged(1)

//share data
dw_coil_list.ShareData(dw_editor)

//initial
st_edi.Text = "NO"
rb_1153.Checked = TRUE
il_cust = 1153
wf_disable_customers()
rb_orig.Checked = TRUE
rb_abco.Enabled = FALSE
rb_abco.Checked = FALSE
ib_modify = FALSE
end event

event pfc_save;SetPointer(HourGlass!)
Long ll_rc, ll_coil, ll_net, ll_net_b, ll_from_cust
Int li_i, li_status, li_pc, li_edic
String ls_org_id, ls_mid_id, ls_temper, ls_alloy, ls_lot, ls_icra, ls_locat, ls_note
DateTime ld_receive, ld_enter, ld_d
Real lr_width, lr_gauge

dw_coil_list.AcceptText()
IF dw_coil_list.RowCount() < 1 THEN RETURN 0

ll_rc = dw_coil_list.RowCount()
IF ib_edi THEN
	CONNECT USING SQLCA;
	SELECT count(*) INTO :li_edic
	FROM inbound_coil
	WHERE bol = :is_bol
	USING SQLCA;
	IF li_edic <> ll_rc THEN
		IF MessageBox("Warning","The toal coil count doesn't match EDI info, Continue saving coil info?", Question!,YesNo!, 2) = 2 THEN RETURN -1
	END IF
END IF
	

FOR li_i = 1 TO ll_rc
	ll_coil = dw_coil_list.GetItemNumber(li_i, "coil_abc_num", Primary!, FALSE)
	li_status = dw_coil_list.GetItemNumber(li_i, "coil_status", Primary!, FALSE)
	li_pc = dw_coil_list.GetItemNumber(li_i, "Pieces_per_case", Primary!, FALSE)

	ls_org_id = dw_coil_list.GetItemString(li_i, "coil_org_num",Primary!, FALSE )
	ls_mid_id = dw_coil_list.GetItemString(li_i, "coil_mid_num",Primary!, FALSE )
	ls_icra = dw_coil_list.GetItemString(li_i, "icra",Primary!, FALSE )
	ld_receive = dw_coil_list.GetItemDateTime(li_i, "date_received",Primary!, FALSE)
	ld_enter = DateTime(Today(),Now())
	ls_temper = dw_coil_list.GetItemString(li_i, "coil_temper",Primary!, FALSE)
	ls_alloy = dw_coil_list.GetItemString(li_i, "coil_alloy2",Primary!, FALSE )
	ls_locat = dw_coil_list.GetItemString(li_i, "coil_location",Primary!, FALSE )
	ls_note = dw_coil_list.GetItemString(li_i, "coil_notes",Primary!, FALSE )
	ll_net = dw_coil_list.GetItemNumber(li_i, "net_wt",Primary!, FALSE )
	ll_net_b = ll_net
	lr_width = dw_coil_list.GetItemNumber(li_i, "coil_width",Primary!, FALSE )
	lr_gauge = dw_coil_list.GetItemNumber(li_i, "coil_gauge",Primary!, FALSE)
	ls_lot = dw_coil_list.GetItemString(li_i, "lot_num",Primary!, FALSE)
	ll_from_cust = dw_coil_list.GetItemNumber(li_i, "coil_from_cust_id",Primary!, FALSE)
	
	IF ib_modify THEN
		CONNECT USING SQLCA;
		UPDATE coil
		SET COIL_ORG_NUM =:ls_org_id,COIL_MID_NUM=:ls_mid_id, COIL_STATUS=:li_status, &
          LOT_NUM = :ls_lot,ICRA = :ls_icra,COIL_GAUGE = :lr_gauge,DATE_RECEIVED = :ld_receive,&
			 NET_WT = :ll_net,NET_WT_BALANCE = :ll_net_b,PIECES_PER_CASE = :li_pc, &
			 COIL_LOCATION = :ls_locat, COIL_NOTES = :ls_note,COIL_FROM_CUST_ID = :ll_from_cust,&
			 COIL_ALLOY2 = :ls_alloy, COIL_TEMPER = :ls_temper, COIL_WIDTH = :lr_width
		WHERE coil_abc_num = :ll_coil
		USING SQLCA;		
	ELSE
		CONNECT USING SQLCA;
		INSERT INTO coil(COIL_ABC_NUM,CUSTOMER_ID,COIL_ORG_NUM,COIL_MID_NUM, COIL_STATUS,LOT_NUM,ICRA,COIL_GAUGE,DATE_RECEIVED, NET_WT,NET_WT_BALANCE,PIECES_PER_CASE, COIL_LOCATION, COIL_NOTES,COIL_FROM_CUST_ID,COIL_ALLOY2, COIL_TEMPER, COIL_WIDTH)
		VALUES(:ll_coil,:il_cust,:ls_org_id,:ls_mid_id,:li_status,:ls_lot,:ls_icra,:lr_gauge,:ld_receive,:ll_net,:ll_net_b,:li_pc,:ls_locat,:ls_note,:il_cust,:ls_alloy, :ls_temper,:lr_width)
		USING SQLCA;
	END IF
NEXT
IF ib_edi THEN
	ld_d = DateTime(Today(),Now())
	INSERT INTO inbound_shipment_status
	VALUES(:il_file_id, :is_bol, 1, :ld_d)
	USING SQLCA;
END IF
COMMIT USING SQLCA;

this.Event ue_reset()

RETURN 1
end event

event close;call super::close;f_display_app()
end event

type sle_bol from u_sle within w_receiving_dock
integer x = 1324
integer y = 80
integer width = 1130
integer height = 93
integer taborder = 20
integer textsize = -11
integer weight = 700
string facename = "Arial"
boolean hideselection = false
end type

type st_3 from u_st within w_receiving_dock
integer x = 2304
integer y = 291
integer width = 238
integer height = 90
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "Alt. Num:"
alignment alignment = center!
end type

type sle_coilmidid from u_sle within w_receiving_dock
integer x = 2542
integer y = 272
integer width = 834
integer height = 128
integer taborder = 60
integer textsize = -20
string facename = "Arial"
boolean hideselection = false
end type

type rb_abco from u_rb within w_receiving_dock
integer x = 936
integer y = 346
integer width = 282
integer weight = 700
string facename = "Arial"
string text = "ABCO"
end type

type rb_109 from u_rb within w_receiving_dock
integer x = 22
integer y = 1747
integer width = 534
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "ALRO-JACKSON      "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 109
end event

type rb_1005 from u_rb within w_receiving_dock
integer x = 22
integer y = 1635
integer width = 534
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "SHERMAN           "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 1005
end event

type rb_1533 from u_rb within w_receiving_dock
integer x = 22
integer y = 1523
integer width = 735
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "ARCELOR STAINLESS "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 1533
end event

type rb_1459 from u_rb within w_receiving_dock
integer x = 22
integer y = 1411
integer width = 706
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "NOVELIS-OSWEGO    "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 1459
end event

type rb_1591 from u_rb within w_receiving_dock
integer x = 22
integer y = 1299
integer width = 746
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "SAMUEL SON-DETROIT"
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 1591
end event

type rb_93 from u_rb within w_receiving_dock
integer x = 22
integer y = 1187
integer width = 534
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "KEN-MAC-D         "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 93
end event

type rb_188 from u_rb within w_receiving_dock
integer x = 22
integer y = 1075
integer width = 534
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "KAISER            "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 188
end event

type rb_50 from u_rb within w_receiving_dock
integer x = 22
integer y = 963
integer width = 644
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "ALCOA-DAVENPORT   "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 50
end event

type rb_1027 from u_rb within w_receiving_dock
integer x = 22
integer y = 851
integer width = 702
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "ALCOA-LANCASTER   "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 1027
end event

type rb_1188 from u_rb within w_receiving_dock
integer x = 22
integer y = 739
integer width = 753
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "ALCOA-TEXARKANA   "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 1188
end event

type rb_106 from u_rb within w_receiving_dock
integer x = 22
integer y = 627
integer width = 534
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "SAMUEL-PITT       "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 106
end event

type rb_35 from u_rb within w_receiving_dock
integer x = 22
integer y = 515
integer width = 746
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "NOVELIS - WARREN"
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 35
end event

type rb_55 from u_rb within w_receiving_dock
integer x = 22
integer y = 403
integer width = 845
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "ALCAN ROLLED PRODUCTS"
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 55
end event

type rb_1153 from u_rb within w_receiving_dock
integer x = 22
integer y = 291
integer width = 731
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "NOVELIS-KINGSTON  "
end type

event clicked;call super::clicked;IF this.Checked THEN il_cust = 1153
end event

type rb_1 from u_rb within w_receiving_dock
integer x = 18
integer y = 163
integer width = 534
integer weight = 700
string facename = "Arial"
string text = "Select from the list:"
end type

type rb_select from u_rb within w_receiving_dock
integer x = 22
integer y = 77
integer width = 585
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "Select from the list:"
end type

type st_1 from u_st within w_receiving_dock
integer x = 3024
integer y = 6
integer width = 380
integer height = 83
integer textsize = -11
integer weight = 700
string facename = "Arial"
string text = "Total WT:"
alignment alignment = center!
end type

type st_totalwt from u_st within w_receiving_dock
integer x = 2973
integer y = 109
integer width = 483
integer height = 86
integer textsize = -11
integer weight = 700
string facename = "Arial"
string text = "0 LB"
alignment alignment = center!
end type

type st_edi from u_st within w_receiving_dock
integer x = 907
integer y = 83
integer width = 318
integer height = 86
integer textsize = -11
string facename = "Arial"
string text = "EDI/NO"
alignment alignment = center!
end type

type st_totalcoils from u_st within w_receiving_dock
integer x = 2571
integer y = 109
integer width = 380
integer height = 86
integer textsize = -11
integer weight = 700
string facename = "Arial"
string text = "0"
alignment alignment = center!
end type

type st_2 from u_st within w_receiving_dock
integer x = 2571
integer y = 6
integer width = 380
integer height = 86
integer textsize = -11
integer weight = 700
string facename = "Arial"
string text = "Total Coils:"
alignment alignment = center!
end type

type cb_enter from u_cb within w_receiving_dock
integer x = 3379
integer y = 275
integer width = 216
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Enter"
end type

event clicked;call super::clicked;RETURN Parent.Event ue_entercoil()

end event

type sle_coilorgid from u_sle within w_receiving_dock
integer x = 1240
integer y = 272
integer width = 1061
integer height = 128
integer taborder = 10
integer textsize = -20
string facename = "Arial"
end type

type dw_coil_list from u_dw within w_receiving_dock
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_goto_row ( )
event ue_display_changing ( integer ai_type )
integer x = 900
integer y = 442
integer width = 2278
integer height = 605
integer taborder = 30
string dataobject = "d_receiving_coil_list"
boolean hscrollbar = true
end type

event ue_goto_row();Long ll_crow, ll_trow, ll_i

//IF il_cur_coil <= 0 THEN RETURN
//
//ll_trow = RowCount()
//IF ll_trow > 0 THEN
//	ll_crow = 0
//	FOR ll_i = 1 TO ll_trow
//		IF GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE) = il_cur_coil THEN
//			ll_crow = ll_i
//		END IF
//	NEXT
//	IF ll_crow > 0 THEN
//		SelectRow(0, False)
//		SelectRow(ll_crow, True)
//		SetRow(ll_crow)
//		ScrollToRow(ll_crow)
//	END IF
//END IF
//

end event

event ue_display_changing(integer ai_type);//CHOOSE CASE ai_type
//	CASE 1	//new
//		dw_editor.RowsCopy(dw_editor.GetRow(), dw_editor.RowCount(), Primary!, this, 1, Primary!)
//		ib_new = FALSE
//		wf_display_total_info()
//	CASE 2	//modify
//		s_coil_info lds_data
//		Long ll_row
//		ll_row = dw_editor.GetRow()
//		lds_data.customer_id = dw_editor.GetItemNumber(ll_row, "customer_id",Primary!, FALSE)
//		lds_data.ab_coil_num = dw_editor.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
//		lds_data.coil_orig_num = dw_editor.GetItemString(ll_row, "coil_org_num", Primary!, FALSE)
//		lds_data.coil_alt_num = dw_editor.GetItemString(ll_row, "coil_mid_num", Primary!, FALSE)
//		lds_data.lot_num = dw_editor.GetItemString(ll_row, "lot_num",Primary!, FALSE)
//		lds_data.pieces = dw_editor.GetItemNumber(ll_row, "pieces_per_case", Primary!, FALSE)
//		lds_data.coil_line_num = dw_editor.GetItemNumber(ll_row, "coil_line_num", Primary!, FALSE)
//		lds_data.icra = dw_editor.GetItemString(ll_row, "icra", Primary!, FALSE)
//		lds_data.alloy = dw_editor.GetItemString(ll_row, "coil_alloy2",Primary!, FALSE)
//		lds_data.gauge = dw_editor.GetItemNumber(ll_row, "coil_gauge", Primary!, FALSE)
//		lds_data.Temper = dw_editor.GetItemString(ll_row, "coil_temper", Primary!, FALSE)
//		lds_data.net_wt = dw_editor.GetItemNumber(ll_row, "net_wt", Primary!, FALSE)
//		lds_data.net_balance = dw_editor.GetItemNumber(ll_row, "net_wt_balance", Primary!, FALSE)
//		lds_data.width = dw_editor.GetItemNumber(ll_row, "coil_width", Primary!, FALSE)
//		lds_data.date_received = dw_editor.GetItemDateTime(ll_row, "date_received", Primary!, FALSE)
//		lds_data.location = dw_editor.GetItemString(ll_row, "coil_location", Primary!, FALSE)
//		lds_data.status = dw_editor.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)
//		lds_data.notes = dw_editor.GetItemString(ll_row, "coil_notes", Primary!, FALSE)
//		lds_data.coil_from_cust_id = dw_editor.GetItemNumber(ll_row, "coil_from_cust_id", Primary!, FALSE)
//
//		IF lds_data.ab_coil_num > 0 THEN
//			ll_row = dw_coil_list.GetRow()
//			dw_coil_list.SetItem(ll_row, "coil_org_num",lds_data.coil_orig_num  )
//			dw_coil_list.SetItem(ll_row, "coil_mid_num",lds_data.coil_alt_num)
//			dw_coil_list.SetItem(ll_row, "lot_num", lds_data.lot_num   )
//			dw_coil_list.SetItem(ll_row, "pieces_per_case", lds_data.pieces)
//			dw_coil_list.SetItem(ll_row, "coil_line_num", lds_data.coil_line_num)
//			dw_coil_list.SetItem(ll_row, "icra", lds_data.icra )
//			dw_coil_list.SetItem(ll_row, "coil_alloy2", lds_data.alloy)
//			dw_coil_list.SetItem(ll_row, "coil_gauge",lds_data.gauge )
//			dw_coil_list.SetItem(ll_row, "coil_temper",lds_data.Temper )
//			dw_coil_list.SetItem(ll_row, "net_wt",lds_data.net_wt )
//			dw_coil_list.SetItem(ll_row, "net_wt_balance", lds_data.net_balance)
//			dw_coil_list.SetItem(ll_row, "coil_width",lds_data.width )
//			dw_coil_list.SetItem(ll_row, "date_received", lds_data.date_received)
//			dw_coil_list.SetItem(ll_row, "coil_location", lds_data.location )
//			dw_coil_list.SetItem(ll_row, "coil_status",lds_data.status )
//			dw_coil_list.SetItem(ll_row, "coil_notes", lds_data.notes )
//			dw_coil_list.SetItem(ll_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
//		END IF
//		ib_modify = FALSE
//	CASE 3	//delete
//		this.inv_rowmanager.of_DeleteRow(0)
//		ib_delete = FALSE
//		wf_display_total_info()
//END CHOOSE
//this.ResetUpdate()
//this.Event ue_goto_row()
//
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SettransObject(SQLCA)

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

dw_editor.ScrollToRow(li_row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
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


end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_new_id, ll_wt_b, ll_from_cust
Int li_pc
s_coil_info_import lds_data
DateTime ldt_d
String ls_notes, ls_icra, ls_cl

ll_row = this.GetRow()
IF ll_row < 1 THEN Return -1

IF ib_modify THEN
	IF rb_abco.Checked THEN
		CONNECT USING SQLCA;
		SELECT coil_org_num,coil_mid_num, coil_temper, net_wt, coil_width, coil_gauge, lot_num, coil_alloy2, coil_from_cust_id, date_received, net_wt_balance, icra, coil_location, coil_notes, pieces_per_case
		INTO :is_org_id,:lds_data.pack_id,:lds_data.temper, :lds_data.net_weight,:lds_data.coil_width, :lds_data.coil_gauge, :lds_data.lot, :lds_data.alloy, :ll_from_cust, :ldt_d, :ll_wt_b, :ls_icra, :ls_cl, :ls_notes, :li_pc
		FROM coil
 		WHERE coil_abc_num = :il_abco_id
		USING SQLCA;
	ELSE
		CONNECT USING SQLCA;
		SELECT coil_abc_num,coil_mid_num, coil_temper, net_wt, coil_width, coil_gauge, lot_num, coil_alloy2, coil_from_cust_id, date_received, net_wt_balance, icra, coil_location, coil_notes, pieces_per_case
		INTO :il_abco_id,:lds_data.pack_id,:lds_data.temper, :lds_data.net_weight,:lds_data.coil_width, :lds_data.coil_gauge, :lds_data.lot, :lds_data.alloy, :ll_from_cust, :ldt_d, :ll_wt_b, :ls_icra, :ls_cl, :ls_notes, :li_pc
		FROM coil
 		WHERE coil_org_num = :is_org_id
		USING SQLCA;		
	END IF
	this.SetItem(ll_row, "coil_abc_num",il_abco_id)
	this.SetItem(ll_row, "customer_id",il_cust )
	this.SetItem(ll_row, "coil_org_num",is_org_id )
	this.SetItem(ll_row, "icra",ls_icra )	
	this.SetItem(ll_row, "coil_mid_num",lds_data.pack_id )
	this.SetItem(ll_row, "coil_from_cust_id", ll_from_cust)
	this.SetItem(ll_row, "coil_status",2 )
	this.SetItem(ll_row, "date_received", ldt_d)
	this.SetItem(ll_row, "coil_temper",lds_data.temper )
	this.SetItem(ll_row, "coil_alloy2",lds_data.alloy )
	this.SetItem(ll_row, "net_wt",lds_data.net_weight )
	this.SetItem(ll_row, "net_wt_balance",ll_wt_b)
	this.SetItem(ll_row, "coil_width",lds_data.coil_width )
	this.SetItem(ll_row, "coil_gauge",lds_data.coil_gauge )
	this.SetItem(ll_row, "lot_num",lds_data.lot )	
	this.SetItem(ll_row, "coil_notes",ls_notes )	
	this.SetItem(ll_row, "pieces_per_case",li_pc)	
	this.SetItem(ll_row, "coil_location",ls_cl )	
ELSE //new coil
	ll_new_id = f_get_next_value("coil_abc_num_seq")
	this.SetItem(ll_row, "coil_abc_num",ll_new_id)

	IF ib_edi THEN
		IF ib_dul_id THEN //duplicated org id
			CONNECT USING SQLCA;
			SELECT pack_id, temper, net_weight, gross_weight, coil_width, coil_gauge, lot,alloy
			INTO :lds_data.pack_id,:lds_data.temper, :lds_data.net_weight, :lds_data.gross_weight, :lds_data.coil_width, :lds_data.coil_gauge, :lds_data.lot, :lds_data.alloy
			FROM inbound_coil
 			WHERE (coil_number = :is_org_id) AND (ps_coil_number = :is_alt_id)
			USING SQLCA;	
		ELSE
			CONNECT USING SQLCA;
			SELECT pack_id, temper, net_weight, gross_weight, coil_width, coil_gauge, lot,alloy
			INTO :lds_data.pack_id,:lds_data.temper, :lds_data.net_weight, :lds_data.gross_weight, :lds_data.coil_width, :lds_data.coil_gauge, :lds_data.lot, :lds_data.alloy
			FROM inbound_coil
 			WHERE coil_number = :is_org_id
			USING SQLCA;
		END IF
	
		this.SetItem(ll_row, "customer_id",il_cust )
		this.SetItem(ll_row, "coil_org_num",is_org_id )
		this.SetItem(ll_row, "coil_mid_num",lds_data.pack_id )
		this.SetItem(ll_row, "coil_from_cust_id", il_cust)
		this.SetItem(ll_row, "coil_status",2 )
		this.SetItem(ll_row, "date_received", DateTime(Today(),Now()))
		this.SetItem(ll_row, "coil_temper",lds_data.temper )
		this.SetItem(ll_row, "coil_alloy2",lds_data.alloy )
		this.SetItem(ll_row, "net_wt",lds_data.net_weight )
		this.SetItem(ll_row, "net_wt_balance",lds_data.net_weight )
		this.SetItem(ll_row, "coil_width",lds_data.coil_width )
		this.SetItem(ll_row, "coil_gauge",lds_data.coil_gauge )
		this.SetItem(ll_row, "lot_num",lds_data.lot )
	ELSE
		this.SetItem(ll_row, "customer_id",il_cust )
		this.SetItem(ll_row, "coil_org_num",is_org_id )
		this.SetItem(ll_row, "coil_from_cust_id", il_cust)
		this.SetItem(ll_row, "coil_status",2 )
		this.SetItem(ll_row, "date_received", DateTime(Today(),Now()))
	END IF
END IF

wf_display_total_info()
Return ll_new_id


end event

type cb_new from u_cb within w_receiving_dock
integer x = 3196
integer y = 442
integer width = 421
integer height = 179
integer taborder = 60
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Shipment"
end type

event clicked;RETURN Parent.Event ue_new()

end event

type cb_reset from u_cb within w_receiving_dock
integer x = 3196
integer y = 1450
integer width = 421
integer height = 179
integer taborder = 110
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;Parent.Event ue_reset()
RETURN 1

end event

type cb_delete from u_cb within w_receiving_dock
integer x = 3196
integer y = 845
integer width = 421
integer height = 179
integer taborder = 80
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete Coil"
end type

event clicked;RETURN Parent.Event ue_delete()


end event

type dw_customer from u_dw within w_receiving_dock
integer x = 3522
integer y = 10
integer width = 102
integer height = 38
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

type cb_close from u_cb within w_receiving_dock
string tag = "Exit"
integer x = 3196
integer y = 1651
integer width = 421
integer height = 179
integer taborder = 120
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type ddlb_customer from dropdownlistbox within w_receiving_dock
integer x = 26
integer y = 163
integer width = 859
integer height = 1264
integer taborder = 50
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
Long ll_row, ll_i, ll_cust, ll_item

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		il_cust = dw_customer.GetItemNumber(ll_i, "customer_id")				
	END IF
NEXT
//wf_display_total_info()


end event

type cb_modify from u_cb within w_receiving_dock
string tag = "modify coil information"
integer x = 3196
integer y = 1248
integer width = 421
integer height = 179
integer taborder = 100
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Update Coil Info"
end type

event clicked;RETURN Parent.Event ue_modify()
end event

type gb_coilid from u_gb within w_receiving_dock
integer x = 900
integer y = 202
integer width = 2728
integer height = 218
integer taborder = 0
integer textsize = -9
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "Current Coil ID"
borderstyle borderstyle = styleraised!
end type

type cb_save from u_cb within w_receiving_dock
integer x = 3196
integer y = 1046
integer width = 421
integer height = 179
integer taborder = 90
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save Coil Info"
end type

event clicked;Parent.Event pfc_Save()

end event

type dw_editor from u_dw within w_receiving_dock
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
integer x = 925
integer y = 1120
integer width = 2242
integer height = 678
integer taborder = 40
string dataobject = "d_receiving_coil_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

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

event constructor;of_SetTransObject(SQLCA)



end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event itemchanged;call super::itemchanged;String ls_colName
Long ll_id, ll_row, ll_wt

SetNull(ll_id)
ls_ColName = this.GetColumnName()
IF ls_ColName = "net_wt" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_wt = this.GetItemNumber(ll_row, "net_wt", Primary!, FALSE)
	this.SetItem(ll_row, "net_wt_balance", ll_wt)
	wf_display_total_info()
END IF
IF ls_ColName = "Coil_Org_num" THEN
	this.AcceptText()
	is_org_id = this.GetItemString(ll_row, "Coil_org_num", Primary!, FALSE)
	sle_coilorgid.Text = is_org_id
END IF
end event

event itemfocuschanged;call super::itemfocuschanged;AcceptText()
end event

type gb_detail from u_gb within w_receiving_dock
integer x = 900
integer y = 1062
integer width = 2282
integer height = 778
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Coil Detail"
borderstyle borderstyle = styleraised!
end type

type cb_barcode from u_cb within w_receiving_dock
integer x = 3196
integer y = 643
integer width = 421
integer height = 179
integer taborder = 70
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Print &Barcode"
end type

event clicked;RETURN Parent.Event ue_barcode()
end event

type gb_edi from u_gb within w_receiving_dock
integer x = 900
integer y = 3
integer width = 373
integer height = 182
integer taborder = 0
integer textsize = -11
integer weight = 700
string facename = "Arial"
string text = "EDI Info"
borderstyle borderstyle = styleraised!
end type

type gb_1 from u_gb within w_receiving_dock
integer y = 3
integer width = 896
integer height = 1837
integer taborder = 0
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Customer"
borderstyle borderstyle = styleraised!
end type

type rb_orig from u_rb within w_receiving_dock
integer x = 936
integer y = 262
integer width = 282
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "Original"
end type

type gb_2 from u_gb within w_receiving_dock
integer x = 1291
integer y = 3
integer width = 1207
integer height = 182
integer taborder = 60
integer textsize = -11
integer weight = 700
string facename = "Arial"
string text = "Bill of Lading"
borderstyle borderstyle = styleraised!
end type

