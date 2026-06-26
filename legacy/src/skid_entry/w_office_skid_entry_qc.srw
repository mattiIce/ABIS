$PBExportHeader$w_office_skid_entry_qc.srw
forward
global type w_office_skid_entry_qc from w_sheet
end type
type dw_prod_order_detail from u_dw within w_office_skid_entry_qc
end type
type cb_close from u_cb within w_office_skid_entry_qc
end type
type st_title1 from u_st within w_office_skid_entry_qc
end type
type st_title# from u_st within w_office_skid_entry_qc
end type
type dw_skid_list from u_dw within w_office_skid_entry_qc
end type
type cb_print from u_cb within w_office_skid_entry_qc
end type
type cb_new from u_cb within w_office_skid_entry_qc
end type
type cb_insert from u_cb within w_office_skid_entry_qc
end type
type cb_delete from u_cb within w_office_skid_entry_qc
end type
type dw_coil_status from u_dw within w_office_skid_entry_qc
end type
type gb_1 from groupbox within w_office_skid_entry_qc
end type
type cb_save from u_cb within w_office_skid_entry_qc
end type
type cb_cancel from u_cb within w_office_skid_entry_qc
end type
type dw_skid_editor from u_dw within w_office_skid_entry_qc
end type
type cb_modify from u_cb within w_office_skid_entry_qc
end type
type cb_refresh from u_cb within w_office_skid_entry_qc
end type
end forward

global type w_office_skid_entry_qc from w_sheet
integer x = 73
integer y = 160
integer width = 3573
integer height = 2106
string title = "Skid Entry"
string menuname = "m_office_entry"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type integer ue_partial_exist ( long al_skid )
dw_prod_order_detail dw_prod_order_detail
cb_close cb_close
st_title1 st_title1
st_title# st_title#
dw_skid_list dw_skid_list
cb_print cb_print
cb_new cb_new
cb_insert cb_insert
cb_delete cb_delete
dw_coil_status dw_coil_status
gb_1 gb_1
cb_save cb_save
cb_cancel cb_cancel
dw_skid_editor dw_skid_editor
cb_modify cb_modify
cb_refresh cb_refresh
end type
global w_office_skid_entry_qc w_office_skid_entry_qc

type variables
Long il_current_job_num
Long il_current_order
Real ir_theo_pcwt
Long il_partial[]
Long il_cur_skid
Boolean ib_partial
Int ii_action  //0 - nothing  1 - newskid 2- new item 3-delect 4 - modify
Int il_current_order_item
end variables

forward prototypes
public subroutine wf_get_prodorder# ()
public function integer wf_check_coil ()
public function string wf_filter_condition ()
public function integer wf_get_partial_skid ()
public function boolean wf_is_partial (long al_skid)
public function real wf_get_pc_theowt ()
public subroutine wf_set_action (integer ai_action)
public function integer wf_check_skid_wt (long al_skid, long al_item)
public function long wf_item_netwts (long al_skid, long al_item)
public function long wf_get_skid_theowt ()
public function integer wf_coil_sheet_wt (long al_coil, long al_item, long al_itemwt)
public function integer wf_assign_package_num_2sheet_skid ()
end prototypes

event ue_whoami;RETURN "w_offics_skid_entry"
end event

event ue_partial_exist;Long ll_row, ll_l

ll_row = dw_skid_list.RowCount()
IF ll_row > 0 THEN
	FOR ll_l = 1 TO ll_row
		IF dw_skid_list.getItemNumber(ll_l, "sheet_skid_sheet_skid_num", Primary!, FALSE) = al_skid THEN
			RETURN 1
		END IF
	NEXT
END IF

RETURN 0
end event

public subroutine wf_get_prodorder# ();SingleLineEdit sle_order#
sle_order# = Message.PowerObjectParm
st_title#.Text = sle_order#.Text
il_current_job_num = Long(st_title#.Text)

end subroutine

public function integer wf_check_coil ();Long ll_coil, ll_trows, ll_i, ll_trowc, ll_j

dw_coil_status.AcceptText()
ll_trowc = dw_coil_status.RowCount()
IF ll_trowc < 1 THEN RETURN 0

FOR ll_i = 1 TO ll_trows
	ll_coil = dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_coil_abc_num", Primary!, FALSE)
	FOR ll_j = 1 TO ll_trowc
		IF dw_coil_status.GetItemNumber(ll_j, "coil_coil_abc_num", Primary!, FALSE) = ll_coil THEN 
			IF dw_coil_status.GetItemNumber(ll_j, "coil_coil_status", Primary!, FALSE) = 2 THEN
				dw_coil_status.SetItem(ll_j, "coil_coil_status", 1) //processing
			END IF
		END IF
	NEXT
NEXT 

RETURN 1
end function

public function string wf_filter_condition ();Int li_up, li_i
String ls_terms

ls_terms = " ( sheet_skid_ab_job_num = " + String(il_current_job_num) + ") "
li_up = UpperBound(il_partial)
IF li_up > 0 THEN
	FOR li_i = 1 TO li_up
		IF il_partial[li_i] > 0 THEN
			ls_terms = ls_terms + " OR (sheet_skid_sheet_skid_num = " + String(il_partial[li_i]) + " ) "
		END IF
	NEXT
END IF

RETURN ls_terms
end function

public function integer wf_get_partial_skid ();Long ll_skid
Long ll_i
Long ll_row, ll_l
DataStore lds_d

lds_d = CREATE DataStore
lds_d.DataObject = "d_job_partial_skid_list"
lds_d.setTransObject(SQLCA)
lds_d.retrieve(il_current_job_num)

IF RowCount(lds_d) = 0 THEN RETURN 0

FOR ll_i = 1 TO rowCount(lds_d) 
	ll_skid = lds_d.GetItemNumber(ll_i, "sheet_skid_num")
	il_partial[Upperbound(il_partial) + 1] = ll_skid

	ll_row = dw_skid_list.RowCount()
	IF ll_row > 0 THEN
		FOR ll_l = 1 TO ll_row
			IF dw_skid_list.getItemNumber(ll_l, "sheet_skid_sheet_skid_num", Primary!, FALSE) = ll_skid THEN
				IF dw_skid_list.getItemNumber(ll_l,"sheet_skid_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN
					dw_skid_list.SetItem(ll_l, "sheet_skid_ab_job_num", il_current_job_num)
				END IF
			END IF
		NEXT
	END IF
	
//	ll_row = dw_skid_data.RowCount()
//	IF ll_row > 0 THEN
//		FOR ll_l = 1 TO ll_row
//			IF dw_skid_data.getItemNumber(ll_l, "sheet_skid_num", Primary!, FALSE) = ll_skid THEN
//				IF dw_skid_data.getItemNumber(ll_l,"ab_job_num", Primary!, FALSE) <> il_current_job_num THEN
//					dw_skid_data.SetItem(ll_l, "ab_job_num", il_current_job_num)
//				END IF
//			END IF
//		NEXT
//	END IF
	
NEXT
dw_skid_list.AcceptText()
dw_skid_list.inv_filter.of_SetFilter(wf_filter_condition())
dw_skid_list.inv_filter.of_Filter()


DESTROY lds_d

RETURN 0
end function

public function boolean wf_is_partial (long al_skid);Boolean lb_partial

lb_partial = FALSE

RETURN lb_partial
end function

public function real wf_get_pc_theowt ();Long ll_order_item, ll_order
Real lr_wt

lr_wt = 0
CONNECT USING SQLCA;
SELECT order_item_num, order_abc_num INTO :ll_order_item, :ll_order
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;

IF ll_order_item > 0 AND ll_order > 0 THEN
	SELECT theoretical_unit_wt INTO :lr_wt
	FROM order_item
	WHERE order_abc_num = :ll_order AND order_item_num = :ll_order_item
	USING SQLCA;
END IF
IF IsNULL(lr_wt) THEN lr_wt = 0

RETURN lr_wt
end function

public subroutine wf_set_action (integer ai_action);IF ai_action = 0 THEN
	cb_new.Enabled = TRUE
	cb_insert.Enabled = TRUE
	cb_delete.Enabled = TRUE
	cb_modify.Enabled = TRUE
	cb_refresh.Enabled = TRUE
ELSE
	cb_new.Enabled = FALSE
	cb_insert.Enabled = FALSE
	cb_delete.Enabled = FALSE
	cb_modify.Enabled = FALSE
	cb_refresh.Enabled = FALSE
END IF
ii_action = ai_action
end subroutine

public function integer wf_check_skid_wt (long al_skid, long al_item);Long ll_row, ll_pc, ll_totalpc, ll_totalwt
Long ll_trow, ll_skid, ll_item, ll_i, ll_net
Long ll_otherpc, ll_othernet

dw_skid_editor.AcceptText()
ll_row = dw_skid_editor.GetRow()
ll_pc = dw_skid_editor.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_net = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)

ll_totalpc = dw_skid_editor.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
ll_totalwt = dw_skid_editor.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)

ll_trow = dw_skid_list.RowCount()
IF (ll_trow < 1) OR IsNULL(ll_trow) THEN RETURN 0
ll_otherpc = 0
ll_othernet = 0
FOR ll_i = 1 TO ll_trow
	ll_skid = dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE)
	IF ll_skid = al_skid AND al_item <> ll_item THEN
		ll_otherpc = ll_otherpc + dw_skid_list.GetItemNumber(ll_i,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
		ll_othernet = ll_othernet + dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)		
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

public function long wf_item_netwts (long al_skid, long al_item);Long ll_net
Long ll_row, ll_i

ll_net = 0
ll_row = dw_skid_list.RowCount()
IF ll_row < 1 THEN RETURN ll_net
FOR ll_i = 1 TO ll_row
	IF al_skid = dw_skid_list.GetItemNumber(ll_i,"sheet_skid_sheet_skid_num", Primary!, FALSE) THEN
		IF al_item <> dw_skid_list.GetItemNumber(ll_i, "sheet_skid_detail_prod_item_num", Primary!, FALSE) THEN
			ll_net = ll_net + dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
		END IF
	END IF
NEXT	

RETURN ll_net
end function

public function long wf_get_skid_theowt ();Long ll_theowt
Long ll_row, ll_i, ll_skid, ll_item

ll_row = dw_skid_editor.GetRow()
IF ll_row < 1 THEN RETURN ll_theowt
ll_skid = dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_num", Primary!, FALSE)
ll_theowt = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)

ll_row = dw_skid_list.RowCount()
IF ll_row < 1 THEN RETURN ll_theowt	
FOR ll_i = 1 TO ll_row
	IF ll_skid = dw_skid_list.GetItemNumber(ll_i,"sheet_skid_sheet_skid_num", Primary!, FALSE) THEN
		IF ll_item <> dw_skid_list.GetItemNumber(ll_i, "sheet_skid_detail_prod_item_num", Primary!, FALSE) THEN
			ll_theowt = ll_theowt + dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
		END IF
	END IF
NEXT	

RETURN ll_theowt
end function

public function integer wf_coil_sheet_wt (long al_coil, long al_item, long al_itemwt);Long ll_coilwt, ll_sheetwt, ll_othersheet
String	ls_answer //Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt

IF IsNULL(al_item) OR IsNULL(al_coil) OR IsNULL(al_itemwt) THEN RETURN 0

CONNECT USING SQLCA;
SELECT process_quantity INTO :ll_coilwt
FROM process_coil
WHERE coil_abc_num = :al_coil AND ab_job_num = :il_current_job_num
USING SQLCA;

IF ll_coilwt < 1 OR IsNULL(ll_coilwt) THEN RETURN 0

SELECT SUM(prod_item_net_wt) INTO :ll_othersheet
FROM production_sheet_item
WHERE coil_abc_num = :al_coil AND ab_job_num = :il_current_job_num AND prod_item_num <> :al_item
USING SQLCA;
ll_sheetwt = al_itemwt + ll_othersheet

//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. Comment out begin
//IF ll_sheetwt > ll_coilwt THEN
//	IF MessageBox("Question", "This coil has more net sheet wt than the beginning coil wt, continue?", Question!, YesNo!, 1) <> 1 THEN RETURN -1
//END IF 
//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. Comment out end

//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. Begin
//ll_sheetwt = ll_sheetwt + 5000 //TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY TEST ONLY

If ll_sheetwt > ll_coilwt Then
	Open(w_net_wt_warning)
	ls_answer = Message.StringParm
	
	If Upper(ls_answer) <> "YES" Then Return -1
End If
//Alex Gerlants. 06/25/2021. 1214_Net_Wt_Greater_Than_Starting_Wt. End

RETURN 1
end function

public function integer wf_assign_package_num_2sheet_skid ();//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
/*
Function:	wf_assign_package_num_2sheet_skid
Returns:		integer	 1 if ok
							-1 if DB error
Arguments:	none							
*/

Integer	li_rtn = 1
Long		ll_ab_job_num, ll_rows, ll_row, ll_sheet_skid_num
Boolean	lb_use_package_num

ll_ab_job_num = Long(st_title#.Text)


li_rtn = f_get_use_package_num_4job(ll_ab_job_num, sqlca, lb_use_package_num)

If li_rtn = 0 Then //OK in f_get_use_package_num_4job(). li_rtn = sqlca.sqlcode in f_get_use_package_num_4job().
	If IsNull(lb_use_package_num) Then lb_use_package_num = False
Else //DB error in f_get_use_package_num_4job(). Error message is in this function.
	lb_use_package_num = False
End If

If lb_use_package_num Then
	dw_skid_list.AcceptText()
	
	ll_rows = dw_skid_list.RowCount()
	
	For ll_row = 1 To ll_rows
		ll_ab_job_num = dw_skid_list.Object.sheet_skid_ab_job_num[ll_row]
		ll_sheet_skid_num = dw_skid_list.Object.sheet_skid_sheet_skid_num[ll_row]
		
		li_rtn = f_assign_package_num(ll_ab_job_num, ll_sheet_skid_num, sqlca)
		
		If li_rtn <> 0 Then //Error in f_assign_package_num()
			Return -1
		End If
	Next
End If

Return li_rtn
//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
end function

on w_office_skid_entry_qc.create
int iCurrent
call super::create
if this.MenuName = "m_office_entry" then this.MenuID = create m_office_entry
this.dw_prod_order_detail=create dw_prod_order_detail
this.cb_close=create cb_close
this.st_title1=create st_title1
this.st_title#=create st_title#
this.dw_skid_list=create dw_skid_list
this.cb_print=create cb_print
this.cb_new=create cb_new
this.cb_insert=create cb_insert
this.cb_delete=create cb_delete
this.dw_coil_status=create dw_coil_status
this.gb_1=create gb_1
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
this.dw_skid_editor=create dw_skid_editor
this.cb_modify=create cb_modify
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_prod_order_detail
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.st_title1
this.Control[iCurrent+4]=this.st_title#
this.Control[iCurrent+5]=this.dw_skid_list
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_new
this.Control[iCurrent+8]=this.cb_insert
this.Control[iCurrent+9]=this.cb_delete
this.Control[iCurrent+10]=this.dw_coil_status
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_save
this.Control[iCurrent+13]=this.cb_cancel
this.Control[iCurrent+14]=this.dw_skid_editor
this.Control[iCurrent+15]=this.cb_modify
this.Control[iCurrent+16]=this.cb_refresh
end on

on w_office_skid_entry_qc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_prod_order_detail)
destroy(this.cb_close)
destroy(this.st_title1)
destroy(this.st_title#)
destroy(this.dw_skid_list)
destroy(this.cb_print)
destroy(this.cb_new)
destroy(this.cb_insert)
destroy(this.cb_delete)
destroy(this.dw_coil_status)
destroy(this.gb_1)
destroy(this.cb_save)
destroy(this.cb_cancel)
destroy(this.dw_skid_editor)
destroy(this.cb_modify)
destroy(this.cb_refresh)
end on

event open;call super::open;Open(w_office_entry_open)

il_current_job_num = Message.DoubleParm
IF il_current_job_num < 1 THEN 
	Close(this)
	RETURN 0
END IF
st_title#.Text = String(il_current_job_num)

CONNECT USING SQLCA;
SELECT order_abc_num INTO :il_current_order
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;

CONNECT USING SQLCA;
SELECT order_item_num INTO :il_current_order_item
FROM ab_job
WHERE ab_job_num = :il_current_job_num
USING SQLCA;


dw_coil_status.Retrieve(il_current_job_num)
dw_prod_order_detail.Event pfc_Retrieve()

dw_skid_list.Event pfc_Retrieve()
dw_skid_list.SetFocus()
IF il_current_job_num > 0 THEN
	ir_theo_pcwt = wf_get_pc_theowt()
	dw_skid_list.inv_filter.of_SetFilter("sheet_skid_ab_job_num = " + String(il_current_job_num))
	dw_skid_list.inv_filter.of_Filter()
ELSE
	ir_theo_pcwt = 0
END IF
dw_skid_editor.Event pfc_Retrieve()
dw_skid_editor.Reset()

dw_coil_status.visible = FALSE

wf_get_partial_skid()


end event

event pfc_save;Int li_rc
Int qc_flag = 1
Long ll_skid, ll_item, ll_row, ll_i

Int ls_property_status = 0
Int ls_lube_status = 0

Long ll_snet, ll_stare, ll_spc, ll_theo, ll_job
Int li_sstatus , li_qc_status
DateTime ld_sdate

Long ll_inet, ll_icoil, ll_ipc, ll_itheo 
Int li_istatus
DateTime ld_idate
String ls_place

Integer	li_rtn //Alex Gerlants. 06/15/2018. Arconic_Package_Num

IF wf_check_coil() < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF

dw_skid_editor.AcceptText()
ll_row = dw_skid_editor.GetRow()
IF (ll_row < 1) OR IsNULL(ll_row) THEN RETURN -2
ll_skid = dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
ll_item = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_num", Primary!, FALSE)

ll_snet = dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_net_wt", Primary!, FALSE)
ll_stare = dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_sheet_tare_wt", Primary!, FALSE)
ll_spc = dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_skid_pieces", Primary!, FALSE)
li_sstatus = dw_skid_editor.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
ld_sdate = dw_skid_editor.GetItemDateTime(ll_row, "sheet_skid_skid_date", Primary!, FALSE)
ll_theo = wf_get_skid_theowt()

ll_icoil = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_coil_abc_num", Primary!, FALSE)
ll_job = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE)
li_istatus = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_status", Primary!, FALSE)
ll_ipc = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
ll_inet = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_net_wt", Primary!, FALSE)
ll_itheo = dw_skid_editor.GetItemNumber(ll_row, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
ld_idate = dw_skid_editor.GetItemDateTime(ll_row, "production_sheet_item_prod_item_date", Primary!, FALSE)
ls_place = dw_skid_editor.GetItemString(ll_row, "production_sheet_item_prod_item_placemen", Primary!, FALSE)

IF wf_coil_sheet_wt(ll_icoil,ll_item,ll_inet) < 0 THEN 
	MessageBox("Info", "Failed to save data.")
	RETURN -1
END IF

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
  
//Alex Gerlants. 06/15/2018. Arconic_Package_Num
//Commented out the SQL below, and the 8 lines after because columns coil_property_status and lube_weight_status do not exist on table process_coil
  
//  SELECT "PROCESS_COIL"."COIL_PROPERTY_STATUS",   "PROCESS_COIL"."LUBE_WEIGHT_STATUS"
//    INTO :ls_property_status, :ls_lube_status
//    FROM "PROCESS_COIL"
//	 WHERE "PROCESS_COIL"."COIL_ABC_NUM" =:ll_icoil and "PROCESS_COIL"."AB_JOB_NUM" =:ll_job;
	
//	IF (SQLCA.SQLCode <> 0) or IsNull(ls_property_status) then 
//		ls_property_status = 0
//	END IF
//
//	IF (SQLCA.SQLCode <> 0) or IsNull(ls_lube_status) then 
//		//ls_property_status = 0
//		ls_lube_status = 0
//	END IF


	//MessageBox("test", ls_property_status)
	
	
	
	li_qc_status = li_sstatus
	
	//Alex Gerlants. 06/15/2018. Arconic_Package_Num
	//Added 2 lines below to avoid error messages below.
	ls_property_status = 1
	ls_lube_status = 1

	IF (ls_property_status <> 1) THEN
		MessageBox("Warning", "This Coil has not passed QC properties test! Skid status will be put on QC-Hold. Please contact QC dept. to release OnHold status.", Exclamation!)
		li_sstatus = 14
		qc_flag = 0
	END IF

	IF  ( ls_lube_status <> 1 ) THEN
		MessageBox("Warning", "This Coil has not passed lube weight test! Skid status will be put on QC-Hold. Please contact QC dept. to release OnHold status.", Exclamation!)
		li_sstatus = 14
		qc_flag = 0
	END IF






CONNECT USING SQLCA;
CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		INSERT INTO sheet_skid (sheet_skid_num, ab_job_num, sheet_net_wt , sheet_tare_wt, skid_date, skid_pieces , skid_sheet_status, sheet_theoretical_wt, ref_order_abc_num, ref_order_abc_item, skid_sheet_status_held_by_qc)
		VALUES (:ll_skid, :il_current_job_num, :ll_snet, :ll_stare,:ld_sdate,:ll_spc, :li_sstatus, :ll_theo, :il_current_order, :il_current_order_item, :li_qc_status)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid table" )
			RETURN -5
		END IF
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:il_current_job_num,:li_istatus,:ll_inet,SYSDATE,:ll_ipc, :ll_itheo, :ls_place)
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid item table" )
			RETURN -5
		END IF
		INSERT INTO sheet_skid_detail (sheet_skid_num, prod_item_num )
		VALUES (:ll_skid, :ll_item)
		USING SQLCA;		
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Insert Skid function: skid detail table" )
			RETURN -5
		END IF
		
//		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
//		li_rtn = f_insert_sheet_skid_package(il_current_job_num, ll_skid, sqlca)
//		
//		If li_rtn <> 0 Then //li_rtn = sqlca.sqlcode in f_insert_sheet_skid_package()
//			rollback using sqlca;
//			Return -5
//		End If
//		//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	CASE 2	//item
		
		IF (qc_flag = 0) and (li_qc_status =14)  THEN
			UPDATE sheet_skid
			SET sheet_net_wt = :ll_snet, ab_job_num = :il_current_job_num, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo, ref_order_abc_num = :il_current_order, ref_order_abc_item=:il_current_order_item
			WHERE sheet_skid_num = :ll_skid
			USING SQLCA;
		ELSE
			UPDATE sheet_skid
			SET sheet_net_wt = :ll_snet, ab_job_num = :il_current_job_num, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo, ref_order_abc_num = :il_current_order, ref_order_abc_item=:il_current_order_item, skid_sheet_status_held_by_qc =:li_qc_status
			WHERE sheet_skid_num = :ll_skid
			USING SQLCA;
		END IF
		
		
		
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "add item function" )
			RETURN -4
		END IF			
		
		
		
		
		INSERT INTO production_sheet_item (prod_item_num, coil_abc_num , ab_job_num , prod_item_status, prod_item_net_wt, prod_item_date, prod_item_pieces , prod_item_theoretical_wt, prod_item_placement)
		VALUES (:ll_item, :ll_icoil,:il_current_job_num,:li_istatus,:ll_inet,SYSDATE,:ll_ipc, :ll_itheo, :ls_place)
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
	CASE 4	//modify
		IF (qc_flag = 0) and (li_qc_status =14)  THEN
			UPDATE sheet_skid
			SET sheet_net_wt = :ll_snet, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo
			WHERE sheet_skid_num = :ll_skid
			USING SQLCA;
		ELSE
			UPDATE sheet_skid
			SET sheet_net_wt = :ll_snet, sheet_tare_wt = :ll_stare, skid_date = :ld_sdate, skid_pieces = :ll_spc, skid_sheet_status = :li_sstatus, sheet_theoretical_wt = :ll_theo, skid_sheet_status_held_by_qc =:li_qc_status
			WHERE sheet_skid_num = :ll_skid
			USING SQLCA;
		END IF
		
		
		
		IF SQLCA.SQLNRows = 0 THEN
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Modify function" )
			RETURN -5
		END IF			
		
		
		UPDATE production_sheet_item
		SET coil_abc_num = :ll_icoil, ab_job_num = :il_current_job_num, prod_item_status = :li_istatus, prod_item_net_wt = :ll_inet, prod_item_date = SYSDATE, prod_item_pieces = :ll_ipc, prod_item_theoretical_wt = :ll_itheo, prod_item_placement = :ls_place		WHERE prod_item_num = :ll_item
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

dw_coil_status.AcceptText()
li_rc = dw_coil_status.Update()
IF li_rc = 1 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	Messagebox("DBError", "dw_coil_status" )
	RETURN -6
END IF

IF li_rc = 1 THEN
	
	//Alex Gerlants. 06/15/2018. Arconic_Package_Num. Begin
	li_rtn = wf_assign_package_num_2sheet_skid() //Error message is in this function
	
	If li_rtn <> 0 Then
		sqlca.of_rollback( )
		MessageBox("Update dbo.sheet_skid_package", "Failed to save skid package number!" + sqlca.sqlerrtext )
		Return -8
	End If
	//Alex Gerlants. 06/15/2018. Arconic_Package_Num. End
	
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	Messagebox("DBError", "dw_skid_detail during adding" )
	RETURN -7
END IF

MessageBox("Info", "Data had been saved.")

CHOOSE CASE ii_action
	CASE 0 	//nothing
	CASE 1 	//new skid
		dw_skid_editor.RowsCopy(dw_skid_editor.GetRow(), dw_skid_editor.GetRow(), Primary!, dw_skid_list, (dw_skid_list.RowCount() + 1), Primary!)
		dw_skid_list.SetItem(dw_skid_list.RowCount(), "sheet_skid_skid_sheet_status", li_sstatus)
	CASE 2	//item
		ll_row = dw_skid_list.GetRow()
		IF ll_row = dw_skid_list.RowCount() THEN
			ll_row = 0
		ELSE
			ll_row = ll_row + 1
		END IF
		ll_row = dw_skid_list.InsertRow(ll_row)
		dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
		dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
		dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_net_wt", ll_snet)
		dw_skid_list.SetItem(ll_row, "sheet_skid_sheet_tare_wt",ll_stare)
		dw_skid_list.SetItem(ll_row, "sheet_skid_skid_pieces",ll_spc)
		dw_skid_list.SetItem(ll_row, "sheet_skid_skid_sheet_status", li_sstatus)
		dw_skid_list.SetItem(ll_row, "sheet_skid_skid_date",ld_sdate) 
		dw_skid_list.SetItem(ll_row, "production_sheet_item_coil_abc_num", ll_icoil)
		dw_skid_list.setItem(ll_row, "production_sheet_item_ab_job_num", ll_job)
		dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_status", li_istatus)
		dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_ipc)
		dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_net_wt", ll_inet)
		dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_itheo)
		dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_date", ld_idate)
		dw_skid_list.SetItem(ll_row, "production_sheet_item_prod_item_placemen",ls_place)
		
		ll_row = dw_skid_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				dw_skid_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				dw_skid_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				dw_skid_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate) 
			END IF
		NEXT
	CASE 3	//delete item
		IF dw_skid_list.GetRow() > 0 THEN
			dw_skid_list.DeleteRow(dw_skid_list.GetRow() )
		END IF
	CASE 4	//modify
		ll_row = dw_skid_list.RowCount()
		FOR ll_i = 1 TO ll_row
			IF ll_skid = dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) THEN		
				dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_net_wt", ll_snet)
				dw_skid_list.SetItem(ll_i, "sheet_skid_sheet_tare_wt",ll_stare)
				dw_skid_list.SetItem(ll_i, "sheet_skid_skid_pieces",ll_spc)
				dw_skid_list.SetItem(ll_i, "sheet_skid_skid_sheet_status", li_sstatus)
				dw_skid_list.SetItem(ll_i, "sheet_skid_skid_date",ld_sdate) 

				IF ll_item = dw_skid_list.GetItemNumber(ll_i, "production_sheet_item_prod_item_num", Primary!, FALSE) THEN
					dw_skid_list.SetItem(ll_i, "production_sheet_item_coil_abc_num", ll_icoil)
					dw_skid_list.setItem(ll_row, "production_sheet_item_ab_job_num", ll_job)
					dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_status", li_istatus)
					dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_pieces", ll_ipc)
					dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_net_wt", ll_inet)
					dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_theoreti", ll_itheo)
					dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_date", ld_idate)
					dw_skid_list.SetItem(ll_i, "production_sheet_item_prod_item_placemen",ls_place)
				END IF
			END IF
		NEXT
	CASE 5	//delete skid
		IF dw_skid_list.GetRow() > 0 THEN
			dw_skid_list.DeleteRow(dw_skid_list.GetRow() )
		END IF
END CHOOSE
dw_skid_list.ResetUpdate()
dw_skid_list.Event ue_goto_row()

dw_skid_editor.ResetUpdate()
dw_skid_editor.Reset()
wf_set_action(0)

RETURN 1
end event

event pfc_print;OpenwithParm(w_report_skid_entry, il_current_job_num)
RETURN 1
end event

event close;call super::close;f_display_app()
end event

type dw_prod_order_detail from u_dw within w_office_skid_entry_qc
integer x = 841
integer y = 3
integer width = 2681
integer height = 154
integer taborder = 0
string dataobject = "d_office_entry_job_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_current_job_num)
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event constructor;call super::constructor;of_SetTransObject(sqlca) 
end event

type cb_close from u_cb within w_office_skid_entry_qc
integer x = 3079
integer y = 1830
integer width = 369
integer height = 80
integer taborder = 110
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_title1 from u_st within w_office_skid_entry_qc
integer x = 26
integer width = 805
integer height = 58
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Production Order Number"
alignment alignment = center!
boolean border = true
end type

type st_title# from u_st within w_office_skid_entry_qc
integer x = 26
integer y = 58
integer width = 805
integer height = 102
boolean bringtotop = true
integer textsize = -18
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "100001"
alignment alignment = center!
boolean border = true
end type

type dw_skid_list from u_dw within w_office_skid_entry_qc
event ue_goto_row ( )
integer x = 18
integer y = 166
integer width = 3522
integer height = 1338
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_office_entry_skid_list_display"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_goto_row;Long ll_crow, ll_trow, ll_i

IF il_cur_skid <= 0 THEN RETURN

ll_trow = RowCount()
IF ll_trow > 0 THEN
	ll_crow = 0
	FOR ll_i = 1 TO ll_trow
		IF GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) = il_cur_skid THEN
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

event pfc_retrieve;call super::pfc_retrieve;DataWindowChild ldddw_cni
IF this.GetChild("production_sheet_item_coil_abc_num", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("production_sheet_item_coil_abc_num", ldddw_cni)
END IF

Return this.Retrieve(il_current_job_num)
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
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

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE 
	IF il_current_job_num <= 0 THEN RETURN -2
	Return adwc_obj.Retrieve(il_current_job_num)  
END IF
end event

type cb_print from u_cb within w_office_skid_entry_qc
integer x = 2593
integer y = 1830
integer width = 369
integer height = 80
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Parent.Event pfc_print()
end event

type cb_new from u_cb within w_office_skid_entry_qc
integer x = 161
integer y = 1830
integer width = 369
integer height = 80
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New Skid"
end type

event clicked;dw_skid_editor.Event pfc_addrow()


end event

type cb_insert from u_cb within w_office_skid_entry_qc
integer x = 647
integer y = 1830
integer width = 369
integer height = 80
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Insert Item"
end type

event clicked;dw_skid_editor.Event ue_insertitem()
end event

type cb_delete from u_cb within w_office_skid_entry_qc
integer x = 1134
integer y = 1830
integer width = 369
integer height = 80
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;dw_skid_editor.Event ue_del_row()
RETURN 1
end event

type dw_coil_status from u_dw within w_office_skid_entry_qc
integer x = 3463
integer y = 1853
integer width = 44
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_coil_skid_entry_status"
end type

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type gb_1 from groupbox within w_office_skid_entry_qc
integer x = 22
integer y = 1507
integer width = 3511
integer height = 317
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Editor"
borderstyle borderstyle = styleraised!
end type

type cb_save from u_cb within w_office_skid_entry_qc
integer x = 3226
integer y = 1590
integer width = 285
integer height = 77
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

event clicked;Parent.Event pfc_save()

end event

type cb_cancel from u_cb within w_office_skid_entry_qc
integer x = 3226
integer y = 1702
integer width = 285
integer height = 77
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;dw_skid_editor.ResetUpdate()
dw_skid_editor.Reset()
wf_set_action(0)
end event

type dw_skid_editor from u_dw within w_office_skid_entry_qc
event ue_insertitem ( )
event ue_del_row ( )
integer x = 40
integer y = 1558
integer width = 3174
integer height = 243
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_office_entry_skid_list_input"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_insertitem;Long ll_row, ll_item
Int li_status

ll_row = dw_skid_list.GetRow()
IF ll_row < 1 THEN Return
li_status = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to add item to this skid because it has been shipped to customer already!", StopSign!)
	RETURN
END IF

ib_partial = FALSE
IF dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN ib_partial = TRUE

dw_skid_list.RowsCopy(dw_skid_list.GetRow(), dw_skid_list.GetRow(), Primary!, this, 1, Primary!)
ll_row = this.GetRow()
il_cur_skid = this.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ib_partial THEN
	this.SetItem(ll_row, "sheet_skid_skid_date", Today())
	this.SetItem(ll_row, "production_sheet_item_ab_job_num", il_current_job_num)
	this.SetItem(ll_row, "sheet_skid_ab_job_num",  il_current_job_num)
END IF
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)

wf_set_action(2)
end event

event ue_del_row;Long ll_row, ll_item, ll_i, ll_numitem, ll_skid
Int li_status

ll_row = dw_skid_list.GetRow()
IF ll_row < 1 THEN Return
li_status = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to delete item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN
END IF

IF dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN 
	MessageBox("Error","Failed to delete item to this skid because it was created by other job.", StopSign!)
	RETURN
END IF
ll_skid =  dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)
IF ll_row > 1 THEN
	il_cur_skid = dw_skid_list.GetItemNumber((ll_row - 1), "sheet_skid_sheet_skid_num", Primary!, FALSE)
ELSE
	il_cur_skid = 0
END IF

dw_skid_list.RowsCopy(dw_skid_list.GetRow(), dw_skid_list.GetRow(), Primary!, dw_skid_editor, 1, Primary!)

IF MessageBox("Warning","About to delete the item in editor box, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	ll_numitem = 0
	ll_row = dw_skid_list.RowCount()
	FOR ll_i = 1 TO ll_row
		IF  dw_skid_list.GetItemNumber(ll_i, "sheet_skid_sheet_skid_num", Primary!, FALSE) = ll_skid THEN ll_numitem = ll_numitem + 1
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

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)



end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row, ll_pc, ll_totalpc, ll_totalwt, ll_skid, ll_netwt, ll_item

ls_ColName = this.GetColumnName()
IF ls_ColName = "production_sheet_item_prod_item_pieces" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_skid = this.GetItemNumber(ll_row,"sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = this.GetItemNumber(ll_row, "sheet_skid_detail_prod_item_num", Primary!, FALSE)
	ll_pc = this.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
	ll_totalpc = this.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
	ll_totalwt = this.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)
	this.SetItem(ll_row,"production_sheet_item_prod_item_theoreti", Long(ir_theo_pcwt * ll_pc + 0.5) )
	IF ll_totalpc > 0 THEN
		ll_netwt = wf_item_netwts(ll_skid, ll_item)
		IF ll_netwt = 0 THEN
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", Ceiling(ll_totalwt * (ll_pc / ll_totalpc)))
		ELSE
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", (ll_totalwt - ll_netwt))
		END IF			
	END IF
END IF
IF ls_ColName = "sheet_skid_sheet_net_wt" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	ll_skid = this.GetItemNumber(ll_row,"sheet_skid_sheet_skid_num", Primary!, FALSE)
	ll_item = this.GetItemNumber(ll_row, "sheet_skid_detail_prod_item_num", Primary!, FALSE)
	ll_pc = this.GetItemNumber(ll_row,"production_sheet_item_prod_item_pieces", Primary!, FALSE)
	ll_totalpc = this.GetItemNumber(ll_row,"sheet_skid_skid_pieces", Primary!, FALSE)
	ll_totalwt = this.GetItemNumber(ll_row,"sheet_skid_sheet_net_wt", Primary!, FALSE)
	this.SetItem(ll_row,"production_sheet_item_prod_item_theoreti", Long(ir_theo_pcwt * ll_pc + 0.5) )
	IF ll_totalpc > 0 THEN
		ll_netwt = wf_item_netwts(ll_skid, ll_item)
		IF ll_netwt = 0 THEN
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", Ceiling(ll_totalwt * (ll_pc / ll_totalpc)))
		ELSE
			this.setItem(ll_row, "production_sheet_item_prod_item_net_wt", (ll_totalwt - ll_netwt))
		END IF			
	END IF
END IF

end event

event rbuttondown;//Override
RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_skid, ll_item, ll_l, ll_job
Int li_i
Long ll_lrow

ll_row = this.GetRow()
IF ll_row < 1 THEN RETURN 0
ib_partial = FALSE

ll_skid = f_get_next_value("sheet_skid_num_seq")
il_cur_skid = ll_skid
this.SetItem(ll_row, "sheet_skid_sheet_skid_num", ll_skid)
this.SetItem(ll_row, "sheet_skid_detail_sheet_skid_num", ll_skid)
ll_item = f_get_next_value("prod_item_num_seq")
this.SetItem(ll_row, "sheet_skid_detail_prod_item_num", ll_item)
this.SetItem(ll_row, "production_sheet_item_prod_item_num", ll_item)
this.SetItem(ll_row, "sheet_skid_ab_job_num",  il_current_job_num)
this.SetItem(ll_row, "production_sheet_item_ab_job_num",il_current_job_num)
this.SetItem(ll_row, "sheet_skid_skid_date",Today())
this.SetItem(ll_row, "production_sheet_item_prod_item_date", Today())		
this.SetItem(ll_row, "sheet_skid_skid_sheet_status", 5)  //new

ll_lrow = dw_skid_list.GetRow()
IF ll_lrow > 0 THEN
	li_i = dw_skid_list.GetItemNumber(ll_lrow, "sheet_skid_skid_pieces", Primary!, FALSE)
	this.SetItem(ll_row, "sheet_skid_skid_pieces", li_i)

	//production sheet item
	ll_l = dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_coil_abc_num", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_coil_abc_num", ll_l)
	ll_l = dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_ab_job_num", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_ab_job_num", ll_l)
	//li_i = this.GetItemNumber((ll_row -1), "production_sheet_item_prod_item_status", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_status", 2 ) //new
	ll_l = dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_theoreti", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_theoreti", ll_l)
	ll_l = dw_skid_list.GetItemNumber(ll_lrow, "production_sheet_item_prod_item_pieces", Primary!, FALSE)
	this.SetItem(ll_row, "production_sheet_item_prod_item_pieces", ll_l)
END IF

wf_set_action(1)

RETURN ll_skid

end event

event pfc_retrieve;call super::pfc_retrieve;DataWindowChild ldddw_cni
IF this.GetChild("production_sheet_item_coil_abc_num", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("production_sheet_item_coil_abc_num", ldddw_cni)
END IF

Return this.Retrieve(il_current_job_num)
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE 
	IF il_current_job_num <= 0 THEN RETURN -2
	Return adwc_obj.Retrieve(il_current_job_num)  
END IF
end event

event losefocus;this.ResetUpdate()
end event

type cb_modify from u_cb within w_office_skid_entry_qc
integer x = 1620
integer y = 1830
integer width = 369
integer height = 80
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Modify"
end type

event clicked;Long ll_row, ll_item
Int li_status

ll_row = dw_skid_list.GetRow()
IF ll_row < 1 THEN Return
li_status = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_skid_sheet_status", Primary!, FALSE)
IF li_status = 0 THEN
	MessageBox("Error","Failed to modify item to this skid because it has been shipped to customer already.", StopSign!)
	RETURN
END IF

IF dw_skid_list.GetItemNumber(ll_row, "production_sheet_item_ab_job_num", Primary!, FALSE) <> il_current_job_num THEN 
	MessageBox("Error","Failed to modify item to this skid because it was created by other job.", StopSign!)
	RETURN
END IF
il_cur_skid = dw_skid_list.GetItemNumber(ll_row, "sheet_skid_sheet_skid_num", Primary!, FALSE)

dw_skid_list.RowsCopy(dw_skid_list.GetRow(), dw_skid_list.GetRow(), Primary!, dw_skid_editor, 1, Primary!)

wf_set_action(4)
end event

type cb_refresh from u_cb within w_office_skid_entry_qc
integer x = 2107
integer y = 1830
integer width = 369
integer height = 80
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Refresh"
end type

event clicked;dw_skid_list.Event pfc_Retrieve()
dw_skid_list.SetFocus()
IF il_current_job_num > 0 THEN
	dw_skid_list.inv_filter.of_SetFilter("sheet_skid_ab_job_num = " + String(il_current_job_num))
	dw_skid_list.inv_filter.of_Filter()
END IF
dw_skid_list.Event ue_goto_row()

end event

