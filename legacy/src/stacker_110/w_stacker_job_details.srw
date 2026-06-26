$PBExportHeader$w_stacker_job_details.srw
$PBExportComments$<opoup>Production info inherited from pfemain\w_sheet
forward
global type w_stacker_job_details from w_sheet
end type
type cb_prod_print from u_cb within w_stacker_job_details
end type
type tab_production from tab within w_stacker_job_details
end type
type tabpage_item from userobject within tab_production
end type
type dw_prod_item from u_dw within tabpage_item
end type
type tabpage_item from userobject within tab_production
dw_prod_item dw_prod_item
end type
type tabpage_shape from userobject within tab_production
end type
type dw_spec_item from u_dw within tabpage_shape
end type
type tabpage_shape from userobject within tab_production
dw_spec_item dw_spec_item
end type
type tabpage_pack from userobject within tab_production
end type
type dw_package_term from u_dw within tabpage_pack
end type
type tabpage_pack from userobject within tab_production
dw_package_term dw_package_term
end type
type tab_production from tab within w_stacker_job_details
tabpage_item tabpage_item
tabpage_shape tabpage_shape
tabpage_pack tabpage_pack
end type
type cb_orderopen from u_cb within w_stacker_job_details
end type
type cb_close from u_cb within w_stacker_job_details
end type
type cb_sum from u_cb within w_stacker_job_details
end type
type gb_3 from groupbox within w_stacker_job_details
end type
type mle_desc from u_mle within w_stacker_job_details
end type
type dw_prod_order from u_dw within w_stacker_job_details
end type
type tab_mat from tab within w_stacker_job_details
end type
type tabpage_coil from userobject within tab_mat
end type
type dw_prod_coil from u_dw within tabpage_coil
end type
type st_1 from statictext within tabpage_coil
end type
type st_coil# from statictext within tabpage_coil
end type
type st_2 from statictext within tabpage_coil
end type
type st_total_wt from statictext within tabpage_coil
end type
type cb_detail_coil from commandbutton within tabpage_coil
end type
type tabpage_coil from userobject within tab_mat
dw_prod_coil dw_prod_coil
st_1 st_1
st_coil# st_coil#
st_2 st_2
st_total_wt st_total_wt
cb_detail_coil cb_detail_coil
end type
type tabpage_wh from userobject within tab_mat
end type
type dw_job_wh_item from u_dw within tabpage_wh
end type
type tabpage_wh from userobject within tab_mat
dw_job_wh_item dw_job_wh_item
end type
type tabpage_partial from userobject within tab_mat
end type
type dw_partial from u_dw within tabpage_partial
end type
type tabpage_partial from userobject within tab_mat
dw_partial dw_partial
end type
type tab_mat from tab within w_stacker_job_details
tabpage_coil tabpage_coil
tabpage_wh tabpage_wh
tabpage_partial tabpage_partial
end type
type cb_viewsketch from u_cb within w_stacker_job_details
end type
type p_1 from u_p within w_stacker_job_details
end type
end forward

global type w_stacker_job_details from w_sheet
string tag = "Production info"
integer x = 4
integer y = 3
integer width = 3632
integer height = 2054
string title = "Production order #"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 82042848
event ue_open_porder ( long el_ab_job_id )
event ue_canceled ( integer ai_id )
event ue_open ( )
event type string ue_whoami ( )
event ue_read_only ( )
event type integer ue_coil_finish_wt ( datawindow ads_data )
event type long ue_job_wizard ( )
cb_prod_print cb_prod_print
tab_production tab_production
cb_orderopen cb_orderopen
cb_close cb_close
cb_sum cb_sum
gb_3 gb_3
mle_desc mle_desc
dw_prod_order dw_prod_order
tab_mat tab_mat
cb_viewsketch cb_viewsketch
p_1 p_1
end type
global w_stacker_job_details w_stacker_job_details

type variables
long il_current_ab_job_id
Long il_old_job_id
Long il_order
Int ii_item
Boolean ib_new_order
Long il_pic_id
Boolean ib_coilchanged
end variables

forward prototypes
public function integer wf_retrieve_item_tab ()
public subroutine wf_tabpage_coil_wt ()
public function integer wf_updatespending ()
public function integer wf_save_order ()
public function integer wf_set_sketch_file ()
public function integer wf_ok_to_modify ()
public subroutine wf_get_sketch ()
public function integer wf_check_values ()
public function long wf_number_of_skids ()
public function integer wf_save_order_orig ()
public subroutine wf_set_updatable ()
public subroutine wf_set_non_updatable ()
public function integer wf_number_of_skid_by_coil ()
end prototypes

event ue_open_porder;dw_prod_order.inv_linkage.of_Reset()
wf_tabpage_coil_wt()
tab_production.tabpage_item.dw_prod_item.Reset()
tab_production.tabpage_shape.dw_spec_item.Reset()
tab_production.tabpage_pack.dw_package_term.Reset()
tab_mat.tabpage_wh.dw_job_wh_item.Reset()

il_current_ab_job_id = el_ab_job_id

DataWindowChild ldddw_cni
IF dw_prod_order.GetChild("line_num", ldddw_cni) = -1 THEN Return
dw_prod_order.Event pfc_PopulateDDDW("line_num", ldddw_cni)

dw_prod_order.inv_linkage.of_Reset()
IF dw_prod_order.inv_linkage.of_retrieve() = -1 THEN
	sqlca.of_Rollback()
	MessageBox("Error", "w_production::open function" )
ELSE
	SQLCA.of_Commit()
	dw_prod_order.SetFocus()
	dw_prod_order.Visible = TRUE
	wf_retrieve_item_tab()
End IF

wf_tabpage_coil_wt()
wf_get_sketch()


end event

event ue_canceled;call super::ue_canceled;IF  il_current_ab_job_id = 0 THEN Close(this)
end event

event ue_open;Int li_rc
IF wf_updatespending() > 0 THEN
	li_rc = MessageBox("Question","Save current production order first?",Question!, YesNo!, 2)
	IF li_rc = 1 THEN wf_save_order()
END IF

Close(this)

SetPointer(HourGlass!)
Message.StringParm = "w_ab_job_list" 
gnv_app.of_getFrame().Event pfc_open()

//open(w_ab_job_browser)

end event

event type string ue_whoami();RETURN "w_job_details"
end event

event ue_read_only();
mle_desc.Enabled = FALSE

dw_prod_order.Enabled = FALSE
tab_mat.tabpage_coil.dw_prod_coil.Object.DataWindow.ReadOnly = "YES"
tab_mat.tabpage_wh.dw_job_wh_item.Object.DataWindow.ReadOnly = "YES"
tab_mat.tabpage_partial.dw_partial.Object.DataWindow.ReadOnly = "YES"


end event

event ue_coil_finish_wt;Long ll_datarow, ll_coilrow, ll_i, ll_j
Long ll_coil, ll_cwt, ll_status, ll_jobcoilstatus
DateTime ld_date

ll_datarow = ads_data.RowCount()
ll_coilrow = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_datarow < 1 THEN RETURN 0
IF ll_coilrow < 1 THEN RETURN 0
FOR ll_i = 1 TO ll_datarow
	ll_coil = ads_data.GetItemNumber(ll_i, "abc_num", Primary!, FALSE)
	ll_cwt = ads_data.getItemNumber(ll_i, "lb_cut", Primary!, FALSE)
	ld_date = ads_data.GetItemDateTime(ll_i, "processed_date", Primary!, FALSE)
	ll_jobcoilstatus = ads_data.GetItemNumber(ll_i, "job_coil_status", Primary!, FALSE)
	ll_status = ads_data.GetItemNumber(ll_i, "status", Primary!, FALSE)
	FOR ll_j = 1 TO ll_coilrow
		IF tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_j,"process_coil_coil_abc_num",Primary!, FALSE) = ll_coil THEN	
			tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_date", ld_date) 
			tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"coil_net_wt_balance", ll_cwt)
			tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"coil_coil_status", ll_status)
			IF ll_cwt > 1 THEN
				tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_coil_status", ll_jobcoilstatus ) 
			ELSE
				tab_mat.tabpage_coil.dw_prod_coil.SetItem(ll_j,"process_coil_process_coil_status", 0 ) //else done
			END IF
		END IF
	NEXT
NEXT

RETURN 1
end event

event type long ue_job_wizard();s_wizard_question lstr_q
Long ll_qty, ll_sheetwt, ll_pcskid, ll_skid
Real lr_yield

Long ll_temp, ll_coil_wt
Int li_row, li_i, li_sheettype, li_item
Long ll_prodrow, ll_order, ll_max_skid_wt, ll_syspcskid
Real lr_pcwt

ll_prodrow = dw_prod_order.GetRow()
IF ll_prodrow < 1 THEN RETURN 0

ll_qty = 0
li_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF li_row > 0 THEN
	FOR li_i = 1 TO li_row
		ll_coil_wt = 0
		ll_coil_wt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(li_i,"process_coil_process_quantity", Primary!, FALSE )	
		IF NOT(IsNULL(ll_coil_wt)) THEN ll_qty = ll_qty + ll_coil_wt
	NEXT
END IF

lr_yield = dw_prod_order.GetItemNumber(ll_prodrow, "material_yield", Primary!, FALSE)
IF IsNULL(lr_yield) OR lr_yield <= 0  THEN 
	MessageBox("Warning", "Invalid yield value.")
	RETURN -1
END IF

ll_sheetwt = Long(ll_qty * lr_yield)

ll_order = dw_prod_order.GetItemNumber(ll_prodrow, "order_abc_num", Primary!, FALSE)
li_item = dw_prod_order.GetItemNumber(ll_prodrow, "order_item_num", Primary!, FALSE)
CONNECT USING SQLCA;
SELECT CUSTOMER_ORDER.SHEET_HANDLING_TYPE INTO :li_sheettype
FROM CUSTOMER_ORDER 
WHERE CUSTOMER_ORDER.ORDER_ABC_NUM = :ll_order
USING SQLCA;
SELECT max_skid_wt, theoretical_unit_wt, pieces_skid INTO :ll_max_skid_wt, :lr_pcwt, :ll_syspcskid
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;
IF IsNULL(ll_max_skid_wt) OR ll_max_skid_wt <= 0  THEN 
	MessageBox("Warning", "Invalid max skid weight value.")
	RETURN -1
END IF
IF IsNULL(lr_pcwt) OR lr_pcwt <= 0  THEN 
	MessageBox("Warning", "Invalid theo. piece weight value.")
	RETURN -1
END IF

CHOOSE CASE li_sheettype
	CASE 1
		ll_skid = wf_number_of_skid_by_coil()
		lstr_q.combine_lot = FALSE
	CASE ELSE
		ll_skid = Ceiling( ll_sheetwt / ll_max_skid_wt)
		lstr_q.combine_lot = TRUE
END CHOOSE

lstr_q.qty = ll_qty
lstr_q.sheet = ll_sheetwt
lstr_q.yield = lr_yield
lstr_q.theo_pcwt = lr_pcwt
lstr_q.pcskid = ll_syspcskid
lstr_q.max_skid_wt = ll_max_skid_wt
lstr_q.skid = ll_skid

OpenwithParm(w_job_wizard, lstr_q)
lstr_q = Message.PowerObjectParm

IF NOT(lstr_q.Cancel) THEN
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_process_quantity", lstr_q.qty)
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_sheet_wt", lstr_q.sheet)
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_skid", lstr_q.skid)
	dw_prod_order.SetItem(ll_prodrow, "material_yield", lstr_q.yield)
	IF (li_sheettype <> 1) OR IsNULL(li_sheettype) THEN
		ll_pcskid =  lstr_q.pcskid
	ELSE
		SetNULL(ll_pcskid)
	END IF
	dw_prod_order.SetItem(ll_prodrow, "ab_job_job_pieces_skid", ll_pcskid)
	ib_coilchanged = FALSE
END IF

RETURN 1

end event

public function integer wf_retrieve_item_tab ();Integer li_row
li_row = dw_prod_order.GetRow()
ii_item = 0
il_order = 0
tab_production.tabpage_item.dw_prod_item.Reset()
tab_production.tabpage_shape.dw_spec_item.Reset()
tab_production.tabpage_pack.dw_package_term.Reset()

IF li_row > 0 THEN
	ii_item = dw_prod_order.GetItemNumber(li_row, "order_item_num", Primary!, FALSE )
	il_order = dw_prod_order.GetItemNumber( li_row, "order_abc_num", Primary!, FALSE )
	IF (ii_item <= 0) OR (il_order <= 0) THEN
		//MessageBox("Warning", "No customer order OR order item specified!" )
		Return -1
	END IF
	tab_production.tabpage_item.dw_prod_item.Event pfc_Retrieve()
	tab_production.tabpage_shape.dw_spec_item.Event pfc_Retrieve()
	tab_production.tabpage_pack.dw_package_term.Event pfc_Retrieve()
	Return 1
END IF

Return 0
end function

public subroutine wf_tabpage_coil_wt ();Long ll_total_wt, ll_coil_wt
Int li_row, li_int

ll_total_wt = 0
li_row = 0
li_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF li_row > 0 THEN
	tab_mat.tabpage_coil.st_coil#.Text = String(li_row)
	FOR li_int = 1 TO li_row
		ll_coil_wt = 0
		ll_coil_wt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(li_int,"process_coil_process_quantity", Primary!, FALSE )	
		ll_total_wt = ll_total_wt + ll_coil_wt
		tab_mat.tabpage_coil.st_total_wt.Text = String(ll_total_wt, "###,###,###") + "  lbs"
	NEXT
ELSE
	tab_mat.tabpage_coil.st_coil#.Text = "0"
	tab_mat.tabpage_coil.st_total_wt.Text = "0 lb"
END IF

end subroutine

public function integer wf_updatespending ();Int li_return

dw_prod_order.AcceptText()
tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
li_return = dw_prod_order.inv_linkage.of_GetUpdatesPending()
IF li_return = -1 THEN
	//accceptText error
	MessageBox("Edit Errors", "Check for valid data" )
	Return -1
ELSEIF li_return = 1 THEN
	//Change
	Return 1
END IF
	
RETURN 0
end function

public function integer wf_save_order ();SetPointer(HourGlass!)
int li_return
Long skid_pieces, max_skid_wt, est_skid_wt

//Date: 03/09/04
//Author: victor huang
//Problem: Est. wt excesss Max skid wt
tab_production.tabpage_item.dw_prod_item.AcceptText()
skid_pieces = dw_prod_order.GetItemNumber(1,"ab_job_job_pieces_skid")
max_skid_wt = tab_production.tabpage_item.dw_prod_item.GetItemNumber(1, "max_skid_wt")
est_skid_wt = tab_production.tabpage_item.dw_prod_item.GetItemNumber(1, "theoretical_unit_wt") * skid_pieces

if (est_skid_wt > max_skid_wt) then
	MessageBox("Warning", "ESTIMATED SKID WT. EXCEEDS MAX SKID WT. MUST RE-EDIT!!!")
	return -1
end if

dw_prod_order.AcceptText()
tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
li_return = dw_prod_order.inv_linkage.of_update(TRUE,FALSE)
	IF li_return <> 1 THEN
		ROLLBACK USING SQLCA;
		IF SQLCA.SQLCODE <> 0 THEN
			MessageBox("Rollback Error", SQLCA.SQLErrText)
		ELSE
			MessageBox("Update Failed", "Rollback Succeeded")
		END IF
		Return -1
	END IF
	
COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText)
		Return -6
	END IF
dw_prod_order.inv_linkage.of_ResetUpdate()

Return 1
end function

public function integer wf_set_sketch_file ();//copy current sketch to current directory sketch.jpg file
// and will be used in the production order report
Int li_filenum
Long ll_flen
Long ll_new_pos
Int li_loops, li_i
Blob lb_pic

SetPointer(HourGlass!)

SELECTBLOB sketch_view 
INTO :lb_pic
FROM sketch_jpg
WHERE sketch_id = :il_pic_id
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return -1
END IF

ll_flen = Len(lb_pic)
IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
		li_loops = ll_flen / 32765
	ELSE
		li_loops = (ll_flen / 32765) + 1
	END IF
ELSE
	li_loops = 1
END IF

ll_new_pos = 1
li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockReadWrite!, Replace!)
FileWrite(li_filenum, BlobMid(lb_pic, 0, 32765))
FileClose(li_FileNum)

FOR li_i = 1 TO li_loops
	li_filenum = FileOpen(gs_Sketch_file, StreamMode!, Write!, LockreadWrite!,Append!)
	FileWrite(li_filenum, BlobMid(lb_pic, li_i*32765, 32765) )
	FileClose(li_FileNum)
NEXT

Return 1


end function

public function integer wf_ok_to_modify ();Long ll_row, ll_order_id
Int li_status

ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN 
	ll_order_id = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
	li_status = dw_prod_order.GetItemNumber(ll_row, "job_status", Primary!, FALSE)
ELSE
	MessageBox("Warning", "NO ABC Order specified in the production order")
	Return -1
END IF
IF li_status = 0 THEN 
	MessageBox("Warning", "This job is done, nothing can be modified now.")
	Return -2
END IF

RETURN 1

end function

public subroutine wf_get_sketch ();int li_rc
Blob lb_pic

SELECT sketch_id, sketch_job_note
INTO :il_pic_id,:mle_desc.Text 
FROM ab_job
WHERE ab_job_num = :il_current_ab_job_id
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return
END IF
IF IsNUll(il_pic_id) OR il_pic_id < 1 THEN 
	SetNULL(lb_pic)
	p_1.SetPicture(lb_pic)
	Return
END IF

SetPointer(HourGlass!)

SELECTBLOB sketch_view 
INTO :lb_pic
FROM sketch_jpg
WHERE sketch_id = :il_pic_id
USING SQLCA;
IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText, StopSign!)
	Return
END IF
p_1.SetPicture(lb_pic)

end subroutine

public function integer wf_check_values ();Long ll_line, ll_row, ll_i, ll_coil
Real lr_m_width, lr_i_thick, lr_m_thick, lr_m_wt
Real lr_c_gauge, lr_c_width, lr_c_netwt, lr_c_netbal
Int li_rc
String ls_msg
String ls_notes

dw_prod_order.AcceptText()
ll_row = dw_prod_order.GetRow()
ll_line = dw_prod_order.getItemNumber(ll_row, "line_num", Primary!, FALSE)
IF IsNULL(ll_line) OR ll_line < 1 THEN RETURN 1

CONNECT USING SQLCA;
SELECT max_width, min_thickness, max_thickness,max_weight
INTO :lr_m_width, :lr_i_thick, :lr_m_thick, :lr_m_wt
FROM line
WHERE line_num = :ll_line
USING SQLCA;

tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
ll_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"process_coil_coil_abc_num")
		lr_c_gauge = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_coil_gauge")
		IF IsNULL(lr_c_gauge) THEN lr_c_gauge = 0
		lr_c_width = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_coil_width")
		IF IsNULL(lr_c_width) THEN lr_c_width = 0
		lr_c_netbal = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_net_wt_balance")
		IF IsNULL(lr_c_netbal) THEN lr_c_netbal = 0
		lr_c_netwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"coil_net_wt")
		IF IsNULL(lr_c_netwt) THEN lr_c_netwt = 0
		IF lr_c_netbal > 0 THEN lr_c_netwt = MIN(lr_c_netwt, lr_c_netbal)
		
		IF (lr_c_gauge >= 0.1) AND ((lr_c_netbal / lr_c_width) <= 100.0) THEN
			ls_msg = "Coil " + String(ll_coil) + " is heavy gauge and small OD coil!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
			
		END IF
		IF lr_c_netwt > lr_m_wt THEN
			ls_msg = "Coil " + String(ll_coil) + " overweight, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
		IF lr_c_width > lr_m_width THEN
			ls_msg = "Coil " + String(ll_coil) + " overwidth, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
		IF lr_c_gauge > lr_m_thick THEN
			ls_msg = "Coil " + String(ll_coil) + " overthickness, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
		IF lr_c_gauge < lr_i_thick THEN
			ls_msg = "Coil " + String(ll_coil) + " too thin, please change this coil or this production line!, Continue?"
			li_rc = MessageBox("Warning", ls_msg , Question!, YesNo!, 2)
			IF li_rc = 2 THEN RETURN -1
		END IF
	NEXT
END IF
 
RETURN 1
end function

public function long wf_number_of_skids ();Long ll_row, ll_i, ll_j, ll_skid, ll_lotwt, ll_l
String ls_loted[], ls_lot
Boolean lb_existed
Real lr_yield
Long ll_max, ll_order
Int li_item

ll_row = dw_prod_order.GetRow()
IF ll_row <= 0 THEN RETURN 0
lr_yield = dw_prod_order.GetItemNumber(ll_row, "material_yield", Primary!, FALSE)

ll_order = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
li_item = dw_prod_order.GetItemNumber(ll_row, "order_item_num", Primary!, FALSE)
CONNECT USING SQLCA;
SELECT max_skid_wt INTO :ll_max
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ll_skid = 0
ll_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		lb_existed = FALSE
		ls_lot = tab_mat.tabpage_coil.dw_prod_coil.GetItemString(ll_i,"coil_lot_num", Primary!, FALSE )
		FOR ll_l = 1 TO UpperBound(ls_loted)
			IF ls_loted[ll_l] = ls_lot THEN lb_existed = TRUE
		NEXT
		IF NOT(lb_existed) THEN ls_loted[UpperBound(ls_loted) + 1] = ls_lot
	NEXT
	FOR ll_l = 1 To UpperBound(ls_loted)
		ll_lotwt = 0
		FOR ll_i = 1 TO ll_row
			IF tab_mat.tabpage_coil.dw_prod_coil.GetItemString(ll_i,"coil_lot_num", Primary!, FALSE ) = ls_loted[ll_l] THEN
				ll_lotwt = ll_lotwt + tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"process_coil_process_quantity", Primary!, FALSE )
			END IF
		NEXT
		IF (ll_max > 0) AND (lr_yield > 0) THEN
			ll_skid = ll_skid + Ceiling( ll_lotwt * lr_yield / ll_max )
		END IF
	NEXT
END IF

RETURN ll_skid

end function

public function integer wf_save_order_orig ();SetPointer(HourGlass!)
int li_return

dw_prod_order.AcceptText()
tab_mat.tabpage_coil.dw_prod_coil.AcceptText()
li_return = dw_prod_order.inv_linkage.of_update(TRUE,FALSE)
	IF li_return <> 1 THEN
		ROLLBACK USING SQLCA;
		IF SQLCA.SQLCODE <> 0 THEN
			MessageBox("Rollback Error", SQLCA.SQLErrText)
		ELSE
			MessageBox("Update Failed", "Rollback Succeeded")
		END IF
		Return -1
	END IF
	
COMMIT using SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText)
		Return -6
	END IF
dw_prod_order.inv_linkage.of_ResetUpdate()

Return 1
end function

public subroutine wf_set_updatable ();dw_prod_order.SetTabOrder("material_yield", 10)
dw_prod_order.SetTabOrder("number_of_men_used", 20)
dw_prod_order.SetTabOrder("line_num", 30)
dw_prod_order.SetTabOrder("job_status", 40)
dw_prod_order.SetTabOrder("due_date", 50)
dw_prod_order.SetTabOrder("time_date_started", 60)
dw_prod_order.SetTabOrder("time_date_finished", 70)
dw_prod_order.SetTabOrder("time_date_finished", 80)
dw_prod_order.SetTabOrder("job_notes", 90)
dw_prod_order.SetTabOrder("ab_job_job_reference_codes", 100)

end subroutine

public subroutine wf_set_non_updatable ();dw_prod_order.SetTabOrder("number_of_men_used", 0)
dw_prod_order.SetTabOrder("material_yield", 0)
dw_prod_order.SetTabOrder("line_num", 0)
dw_prod_order.SetTabOrder("job_status", 0)
dw_prod_order.SetTabOrder("due_date", 0)
dw_prod_order.SetTabOrder("time_date_started", 0)
dw_prod_order.SetTabOrder("time_date_finished", 0)
dw_prod_order.SetTabOrder("time_date_finished", 0)
dw_prod_order.SetTabOrder("job_notes", 0)
dw_prod_order.SetTabOrder("ab_job_job_reference_codes", 0)

end subroutine

public function integer wf_number_of_skid_by_coil ();Long ll_row, ll_i, ll_j, ll_skid, ll_coilwt, ll_l
//String ls_loted[], ls_lot
//Boolean lb_existed
Real lr_yield
Long ll_max, ll_order
Int li_item

ll_row = dw_prod_order.GetRow()
IF ll_row <= 0 THEN RETURN 0
lr_yield = dw_prod_order.GetItemNumber(ll_row, "material_yield", Primary!, FALSE)

ll_order = dw_prod_order.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)
li_item = dw_prod_order.GetItemNumber(ll_row, "order_item_num", Primary!, FALSE)
CONNECT USING SQLCA;
SELECT max_skid_wt INTO :ll_max
FROM order_item
WHERE order_abc_num = :ll_order AND order_item_num = :li_item
USING SQLCA;

ll_skid = 0
ll_row = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coilwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_i,"process_coil_process_quantity", Primary!, FALSE )
		IF (ll_max > 0) AND (lr_yield > 0) THEN
			ll_skid = ll_skid + Ceiling( ll_coilwt * lr_yield / ll_max )
		END IF
	NEXT
END IF

RETURN ll_skid

end function

on w_stacker_job_details.create
int iCurrent
call super::create
this.cb_prod_print=create cb_prod_print
this.tab_production=create tab_production
this.cb_orderopen=create cb_orderopen
this.cb_close=create cb_close
this.cb_sum=create cb_sum
this.gb_3=create gb_3
this.mle_desc=create mle_desc
this.dw_prod_order=create dw_prod_order
this.tab_mat=create tab_mat
this.cb_viewsketch=create cb_viewsketch
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_prod_print
this.Control[iCurrent+2]=this.tab_production
this.Control[iCurrent+3]=this.cb_orderopen
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_sum
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.mle_desc
this.Control[iCurrent+8]=this.dw_prod_order
this.Control[iCurrent+9]=this.tab_mat
this.Control[iCurrent+10]=this.cb_viewsketch
this.Control[iCurrent+11]=this.p_1
end on

on w_stacker_job_details.destroy
call super::destroy
destroy(this.cb_prod_print)
destroy(this.tab_production)
destroy(this.cb_orderopen)
destroy(this.cb_close)
destroy(this.cb_sum)
destroy(this.gb_3)
destroy(this.mle_desc)
destroy(this.dw_prod_order)
destroy(this.tab_mat)
destroy(this.cb_viewsketch)
destroy(this.p_1)
end on

event open;call super::open;Long ll_job

ll_job = Message.DoubleParm
this.title = "Production Order # " + String(ll_job)

//initial
il_order = 0
ii_item = 0
il_current_ab_job_id = 0
ib_coilchanged = FALSE

// Setup order window
DataWindowChild ldddw_cni
IF dw_prod_order.GetChild("line_num", ldddw_cni) = -1 THEN Return -1
dw_prod_order.Event pfc_PopulateDDDW("line_num", ldddw_cni)

// Turn on the linkage service.
dw_prod_order.of_SetLinkage ( TRUE ) 

//Setup coil window
tab_mat.tabpage_coil.dw_prod_coil.of_SetLinkage ( TRUE )
tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_SetMaster(dw_prod_order)
IF NOT tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & coil in win w_prod!" )
ELSE
	tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_Register( "ab_job_num", "process_coil_ab_job_num" ) 
	tab_mat.tabpage_coil.dw_prod_coil.inv_linkage.of_SetStyle( 2 ) 
	tab_mat.tabpage_coil.dw_prod_coil.SetRowFocusIndicator(FocusRect!) 
END IF

//wh items
tab_mat.tabpage_wh.dw_job_wh_item.of_SetLinkage ( TRUE )
tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_SetMaster(dw_prod_order)
IF NOT tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked warehouse items in win w_prodution!" )
ELSE
	tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_Register( "ab_job_num", "ab_job_num"  ) 
	tab_mat.tabpage_wh.dw_job_wh_item.inv_linkage.of_SetStyle( 2 ) 
END IF

//partial
tab_mat.tabpage_partial.dw_partial.of_SetLinkage ( TRUE )
tab_mat.tabpage_partial.dw_partial.inv_linkage.of_SetMaster(dw_prod_order)
IF NOT tab_mat.tabpage_partial.dw_partial.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked partial skids in win w_prodution!" )
ELSE
	tab_mat.tabpage_partial.dw_partial.inv_linkage.of_Register( "ab_job_num", "ab_job_num"  ) 
	tab_mat.tabpage_partial.dw_partial.inv_linkage.of_SetStyle( 2 ) 
END IF

//retrieve
dw_prod_order.inv_Linkage.of_SetTransObject(sqlca) 
ib_new_order = FALSE

IF ll_job> 0 THEN
	this.Event ue_open_porder(ll_job)
ELSE
	MessageBox("Warning", "Please select a job first.")
	RETURN 0
END IF
wf_set_updatable()
RETURN 1

end event

event pfc_print;SetPointer(HourGlass!)
Int li_rc
IF wf_updatespending() > 0 THEN
	li_rc = MessageBox("Question","Save current production order first?",Question!, OKCancel!, 1)
	IF li_rc = 1 THEN
		//Date: 03/09/04
		//Author: victor huang
		//Problem: Est. wt excesss Max skid wt
		if wf_save_order() < 0 then
			return -1
		end if		
	ELSE
		Return -1
	END IF
END IF
IF ib_new_order THEN
		MessageBox("Error","Failed to print an new & unsaved production order!", StopSign!)
		Return -2
END IF

IF wf_set_sketch_file() < 0 THEN Return 0
openwithparm(w_report_prod_order,il_current_ab_job_id)
Return 1
end event

event activate;call super::activate;This.Event ue_read_only()
end event

type cb_prod_print from u_cb within w_stacker_job_details
string tag = "Print current production order"
integer x = 1968
integer y = 1859
integer width = 391
integer height = 77
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print..."
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type tab_production from tab within w_stacker_job_details
event create ( )
event destroy ( )
integer x = 22
integer y = 1165
integer width = 3529
integer height = 691
integer taborder = 150
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean boldselectedtext = true
boolean pictureonright = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_item tabpage_item
tabpage_shape tabpage_shape
tabpage_pack tabpage_pack
end type

on tab_production.create
this.tabpage_item=create tabpage_item
this.tabpage_shape=create tabpage_shape
this.tabpage_pack=create tabpage_pack
this.Control[]={this.tabpage_item,&
this.tabpage_shape,&
this.tabpage_pack}
end on

on tab_production.destroy
destroy(this.tabpage_item)
destroy(this.tabpage_shape)
destroy(this.tabpage_pack)
end on

type tabpage_item from userobject within tab_production
event create ( )
event destroy ( )
integer x = 102
integer y = 13
integer width = 3412
integer height = 666
long backcolor = 79741120
string text = "Specs"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Properties!"
long picturemaskcolor = 79741120
dw_prod_item dw_prod_item
end type

on tabpage_item.create
this.dw_prod_item=create dw_prod_item
this.Control[]={this.dw_prod_item}
end on

on tabpage_item.destroy
destroy(this.dw_prod_item)
end on

type dw_prod_item from u_dw within tabpage_item
integer x = 128
integer width = 3156
integer height = 666
integer taborder = 2
string dataobject = "d_order_item_detail_2"
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(ii_item, il_order )
end event

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

type tabpage_shape from userobject within tab_production
integer x = 102
integer y = 13
integer width = 3412
integer height = 666
long backcolor = 12632256
string text = "Shape"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "UserObject!"
long picturemaskcolor = 79741120
dw_spec_item dw_spec_item
end type

on tabpage_shape.create
this.dw_spec_item=create dw_spec_item
this.Control[]={this.dw_spec_item}
end on

on tabpage_shape.destroy
destroy(this.dw_spec_item)
end on

type dw_spec_item from u_dw within tabpage_shape
integer x = 435
integer y = 26
integer width = 2600
integer height = 621
integer taborder = 2
string dataobject = "d_rectangle_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Int li_row
String ls_shape
li_row = tab_production.tabpage_item.dw_prod_item.GetRow()
IF li_row <= 0 THEN Return -1
ls_shape = tab_production.tabpage_item.dw_prod_item.GetItemString(li_row, "sheet_type", Primary!,TRUE ) 

CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		this.DataObject = "d_rectangle_display"
	CASE "PARALLELOGRAM"
		this.DataObject = "d_parallelogram_display"
	CASE "FENDER"
		this.DataObject = "d_fender_display"
	CASE "CHEVRON"
		this.DataObject = "d_chevron_display"
	CASE "CIRCLE"
		this.DataObject = "d_circle_display"
	CASE "TRAPEZOID"
		this.DataObject = "d_trapezoid_display"
	CASE "L.TRAPEZOID"
		this.DataObject = "d_ltrapezoid_display"
	CASE "R.TRAPEZOID"
		this.DataObject = "d_rtrapezoid_display"
	CASE "REINFORCEMENT"
		this.DataObject = "d_reinforcement_display"
	CASE "LIFTGATE"
		this.DataObject = "d_liftgate_shape_display"
	CASE ELSE
		this.DataObject = "d_x1shape_display"
END CHOOSE

SetTransObject(SQLCA)

//Alex Gerlants. 03/27/2017. Added ", il_current_ab_job_id".
//because all datawindows listed above have additional retrieval argument ab_job.ab_job_num.
//They now retrieve die_id from table ab_job instead of a shape table (like rectangle, fender, etc).
Return this.Retrieve(ii_item, il_order, il_current_ab_job_id )
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event retrieveend;call super::retrieveend;//Alex Gerlants. 03/27/2017. Begin
//Disable column ab_job_ab_job_num

String	ls_modstring, ls_rtn

ls_modstring = "ab_job_die_id.tabsequence='0'"
ls_rtn = This.Modify(ls_modstring)

ls_modstring = "ab_job_die_id.Background.Color='553648127'" //Transparent
ls_rtn = This.Modify(ls_modstring)
//Alex Gerlants. 03/27/2017. End
end event

type tabpage_pack from userobject within tab_production
integer x = 102
integer y = 13
integer width = 3412
integer height = 666
long backcolor = 12632256
string text = "Pack"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Parameter!"
long picturemaskcolor = 79741120
dw_package_term dw_package_term
end type

on tabpage_pack.create
this.dw_package_term=create dw_package_term
this.Control[]={this.dw_package_term}
end on

on tabpage_pack.destroy
destroy(this.dw_package_term)
end on

type dw_package_term from u_dw within tabpage_pack
integer x = 51
integer y = 77
integer width = 3324
integer height = 515
integer taborder = 2
string dataobject = "d_order_item_detail_proc_pack"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(ii_item, il_order )
end event

event constructor;call super::constructor;SetTransObject(SQLCA)
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

type cb_orderopen from u_cb within w_stacker_job_details
string tag = "Open an order"
integer x = 563
integer y = 1859
integer width = 391
integer height = 77
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Open"
end type

event clicked;Parent.Event ue_open()
end event

type cb_close from u_cb within w_stacker_job_details
string tag = "Close"
integer x = 2670
integer y = 1859
integer width = 391
integer height = 77
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_sum from u_cb within w_stacker_job_details
string tag = "Show summary of current order"
integer x = 1265
integer y = 1859
integer width = 391
integer height = 77
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "S&ummary..."
end type

event clicked;SetPointer(HourGlass!)
Int li_rc, li_status
Long ll_row
IF wf_updatespending() > 0 THEN
	li_rc = MessageBox("Question","Save current production order first?",Question!, OKCancel!, 1)
	IF li_rc = 1 THEN
		//Date: 03/09/04
		//Author: victor huang
		//Problem: Est. wt excesss Max skid wt
		if wf_save_order() < 0 then
			return -1
		end if	
	ELSE
		Return -1
	END IF
END IF
IF ib_new_order THEN
		MessageBox("Error","Failed to print an new & unsaved production order!", StopSign!)
		Return -2
END IF
ll_row = dw_prod_order.GetRow()
IF ll_row > 0 THEN
	li_status = dw_prod_order.GetItemNumber(ll_row, "job_status", Primary!, FALSE)
ELSE
	MessageBox("Error","Failed to retrieve this production order!", StopSign!)
	Return -3
END IF

openwithparm(w_prod_order_summary,il_current_ab_job_id)
RETURN 1

end event

type gb_3 from groupbox within w_stacker_job_details
integer x = 22
integer y = 333
integer width = 1371
integer height = 819
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sketch"
end type

type mle_desc from u_mle within w_stacker_job_details
integer x = 40
integer y = 381
integer width = 1335
integer height = 157
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event rbuttonup;RETURN 0
end event

type dw_prod_order from u_dw within w_stacker_job_details
integer width = 3617
integer height = 333
integer taborder = 140
string dataobject = "d_product_order_detail"
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_current_ab_job_id)
end event

event pfc_addrow;call super::pfc_addrow;long ll_new_id
Long ll_row
Integer li_rc
Long ll_cust, ll_enduser
String ls_custpo, ls_enduserpo, ls_scrap, ls_ref

Long ll_sketch,ll_order
Int li_line, li_item,li_men
Real lr_yield,lr_pitch, lr_pp, lr_pm
String ls_sketch_note

ll_new_id = f_get_next_value("ab_job_num_seq")

ll_row = this.GetRow()
li_rc = SetItem(ll_row,"ab_job_num",ll_new_id )
li_rc = SetItem(ll_row,"create_date", Today() )
li_rc = SetItem(ll_row,"time_date_started", Today() )
li_rc = SetItem(ll_row,"job_status", 2 )  //new job
IF il_old_job_id > 0 THEN
	CONNECT USING SQLCA;
	SELECT sketch_id,line_num,order_item_num, material_yield,order_abc_num,number_of_men_used,sketch_job_note, pitch, pitch_plus,pitch_minus
	INTO :ll_sketch, :li_line, :li_item, :lr_yield, :ll_order, :li_men, :ls_sketch_note,  :lr_pitch, :lr_pp, :lr_pm
	FROM ab_job
	WHERE ab_job_num = :il_old_job_id
	USING SQLCA;
	li_rc = SetItem(ll_row,"line_num", li_line )
	li_rc = SetItem(ll_row,"order_item_num", li_item )
	li_rc = SetItem(ll_row,"material_yield", lr_yield)
	li_rc = SetItem(ll_row,"order_abc_num", ll_order)
	li_rc = SetItem(ll_row,"number_of_men_used", li_men)
	li_rc = SetItem(ll_row,"ab_job_sketch_id", ll_sketch)
	li_rc = SetItem(ll_row,"ab_job_sketch_job_note", ls_sketch_note)
	li_rc = SetItem(ll_row,"ab_job_pitch", lr_pitch)
	li_rc = SetItem(ll_row,"ab_job_pitch_plus", lr_pp)
	li_rc = SetItem(ll_row,"ab_job_pitch_minus", lr_pm)
	li_rc = SetItem(ll_row,"job_notes","Order copy from Job #" + String(il_old_job_id))
	il_pic_id = ll_sketch
ELSE
	li_rc = SetItem(ll_row,"order_abc_num", gstr_order.order_num )
	li_rc = SetItem(ll_row,"order_item_num", gstr_order.item_num )
	li_rc = SetItem(ll_row,"line_num", 0)
	li_rc = SetItem(ll_row,"number_of_men_used", 6)
	li_rc = SetItem(ll_row,"material_yield", 0.0)
	ll_order = gstr_order.order_num
END IF
il_current_ab_job_id = ll_new_id
il_old_job_id = 0

DataWindowChild ldddw_cni
IF this.GetChild("line_num", ldddw_cni) = -1 THEN Return -1
this.Event pfc_PopulateDDDW("line_num", ldddw_cni)
//this.Event pfc_RetrieveDDDW("line_num")

CONNECT USING SQLCA;
SELECT orig_customer_id, enduser_id, orig_customer_po, enduser_po, scrap_handing_type, reference
INTO :ll_cust, :ll_enduser, :ls_custpo, :ls_enduserpo, :ls_scrap, :ls_ref
FROM customer_order
WHERE order_abc_num = :ll_order
USING SQLCA;

SetItem(ll_row, "customer_order_orig_customer_id", ll_cust)
SetItem(ll_row, "customer_order_enduser_id", ll_enduser)
SetItem(ll_row, "customer_order_orig_customer_po", ls_custpo)
SetItem(ll_row, "customer_order_enduser_po", ls_enduserpo)
SetItem(ll_row, "customer_order_scrap_handing_type",ls_scrap)
SetItem(ll_row, "customer_order_reference", ls_ref)

dw_prod_order.SetFocus()
dw_prod_order.Visible = TRUE

Return ll_new_id

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event constructor;call super::constructor;SetTransObject(sqlca) 
end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row, ll_coilrow, ll_c, ll_bwt, ll_cwt
Int li_status, li_flag
DateTime ldt_t

li_flag = 1

ls_ColName = this.GetColumnName()
IF ls_ColName = "job_status" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	li_status = this.GetItemNumber(ll_row,"job_status")
	IF li_status = 0 THEN
		this.SetItem(ll_row, "ab_job_job_done_time", Datetime(Today(), Now()))
		ll_coilrow = tab_mat.tabpage_coil.dw_prod_coil.RowCount()
		IF ll_coilrow > 0 THEN 
			li_flag = 0 //no
			FOR ll_c = 1 TO ll_coilrow
				ll_bwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_c,"process_coil_process_quantity", Primary!, FALSE)
				ll_cwt = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_c,"coil_net_wt_balance", Primary!, FALSE)			
				IF ll_bwt <> ll_cwt THEN li_flag = 1 //yes
			NEXT
		END IF
	ELSE
		SetNULL(ldt_t)
		this.SetItem(ll_row, "ab_job_job_done_time", ldt_t)
	END IF
END IF

IF li_flag = 0 THEN openwithparm(w_ab_job_coil_cut, tab_mat.tabpage_coil.dw_prod_coil)

end event

type tab_mat from tab within w_stacker_job_details
event create ( )
event destroy ( )
integer x = 1404
integer y = 336
integer width = 2150
integer height = 819
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean fixedwidth = true
boolean raggedright = true
boolean pictureonright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_coil tabpage_coil
tabpage_wh tabpage_wh
tabpage_partial tabpage_partial
end type

on tab_mat.create
this.tabpage_coil=create tabpage_coil
this.tabpage_wh=create tabpage_wh
this.tabpage_partial=create tabpage_partial
this.Control[]={this.tabpage_coil,&
this.tabpage_wh,&
this.tabpage_partial}
end on

on tab_mat.destroy
destroy(this.tabpage_coil)
destroy(this.tabpage_wh)
destroy(this.tabpage_partial)
end on

type tabpage_coil from userobject within tab_mat
event create ( )
event destroy ( )
integer x = 15
integer y = 102
integer width = 2121
integer height = 704
long backcolor = 79741120
string text = "Coil"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Database!"
long picturemaskcolor = 553648127
dw_prod_coil dw_prod_coil
st_1 st_1
st_coil# st_coil#
st_2 st_2
st_total_wt st_total_wt
cb_detail_coil cb_detail_coil
end type

on tabpage_coil.create
this.dw_prod_coil=create dw_prod_coil
this.st_1=create st_1
this.st_coil#=create st_coil#
this.st_2=create st_2
this.st_total_wt=create st_total_wt
this.cb_detail_coil=create cb_detail_coil
this.Control[]={this.dw_prod_coil,&
this.st_1,&
this.st_coil#,&
this.st_2,&
this.st_total_wt,&
this.cb_detail_coil}
end on

on tabpage_coil.destroy
destroy(this.dw_prod_coil)
destroy(this.st_1)
destroy(this.st_coil#)
destroy(this.st_2)
destroy(this.st_total_wt)
destroy(this.cb_detail_coil)
end on

type dw_prod_coil from u_dw within tabpage_coil
integer x = 4
integer y = 3
integer width = 1774
integer height = 717
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ab_job_process_coil"
end type

event constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 


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

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event doubleclicked;tab_mat.tabpage_coil.cb_detail_coil.Event Clicked()
end event

type st_1 from statictext within tabpage_coil
integer x = 1799
integer y = 448
integer width = 110
integer height = 58
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
string text = "Coil:"
boolean focusrectangle = false
end type

type st_coil# from statictext within tabpage_coil
integer x = 1799
integer y = 499
integer width = 278
integer height = 58
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
string text = "       "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_coil
integer x = 1799
integer y = 557
integer width = 176
integer height = 51
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
string text = "NetWT:"
boolean focusrectangle = false
end type

type st_total_wt from statictext within tabpage_coil
integer x = 1799
integer y = 621
integer width = 307
integer height = 61
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
string text = "            "
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_detail_coil from commandbutton within tabpage_coil
integer x = 1807
integer y = 13
integer width = 307
integer height = 74
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Detail"
end type

event clicked;Long ll_row, ll_coil

ll_row = tab_mat.tabpage_coil.dw_prod_coil.GetRow()
IF ll_row > 0 THEN 
	ll_coil = tab_mat.tabpage_coil.dw_prod_coil.GetItemNumber(ll_row,"process_coil_coil_abc_num", Primary!, FALSE)
	OpenWithParm(w_job_coil_detail_display, ll_coil)
END IF
end event

type tabpage_wh from userobject within tab_mat
event create ( )
event destroy ( )
integer x = 15
integer y = 102
integer width = 2121
integer height = 704
long backcolor = 79741120
string text = "Warehouse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Library5!"
long picturemaskcolor = 553648127
dw_job_wh_item dw_job_wh_item
end type

on tabpage_wh.create
this.dw_job_wh_item=create dw_job_wh_item
this.Control[]={this.dw_job_wh_item}
end on

on tabpage_wh.destroy
destroy(this.dw_job_wh_item)
end on

type dw_job_wh_item from u_dw within tabpage_wh
integer y = 3
integer width = 2107
integer height = 704
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_prod_wh_list"
boolean hscrollbar = true
end type

event constructor;SetTransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
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

type tabpage_partial from userobject within tab_mat
integer x = 15
integer y = 102
integer width = 2121
integer height = 704
long backcolor = 79741120
string text = "Partial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Cascade!"
long picturemaskcolor = 553648127
dw_partial dw_partial
end type

on tabpage_partial.create
this.dw_partial=create dw_partial
this.Control[]={this.dw_partial}
end on

on tabpage_partial.destroy
destroy(this.dw_partial)
end on

type dw_partial from u_dw within tabpage_partial
integer y = 10
integer width = 1818
integer height = 707
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ab_job_process_partial"
boolean livescroll = false
end type

event constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
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

type cb_viewsketch from u_cb within w_stacker_job_details
integer x = 1075
integer y = 550
integer width = 304
integer height = 74
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&View Sketch"
end type

event clicked;IF il_pic_id < 1 OR IsNULL(il_pic_id) THEN
	MessageBox("Info", "No sketch here.")
	RETURN 0
END IF
OpenWithParm(w_sketch_viewer, il_pic_id)
end event

type p_1 from u_p within w_stacker_job_details
integer x = 48
integer y = 541
integer width = 1017
integer height = 605
boolean bringtotop = true
boolean enabled = false
end type

