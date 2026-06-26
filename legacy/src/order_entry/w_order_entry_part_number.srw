$PBExportHeader$w_order_entry_part_number.srw
$PBExportComments$<Sheet> Order Entry window inherited from w_sheet (calling part number)
forward
global type w_order_entry_part_number from w_sheet
end type
type cb_order_entry_browse from u_cb within w_order_entry_part_number
end type
type cb_order_entry_print from u_cb within w_order_entry_part_number
end type
type cb_order_entry_save from u_cb within w_order_entry_part_number
end type
type gb_order from u_gb within w_order_entry_part_number
end type
type dw_order_coil from u_dw within w_order_entry_part_number
end type
type dw_order_list from u_dw within w_order_entry_part_number
end type
type cb_saveas from u_cb within w_order_entry_part_number
end type
type cb_close from u_cb within w_order_entry_part_number
end type
type dw_order_entry_coil from u_dw within w_order_entry_part_number
end type
type dw_order_item_list from u_dw within w_order_entry_part_number
end type
type cb_item_del from u_cb within w_order_entry_part_number
end type
type cb_item_add from u_cb within w_order_entry_part_number
end type
type dw_job_list from u_dw within w_order_entry_part_number
end type
type dw_rectangle from u_dw within w_order_entry_part_number
end type
type dw_chevron from u_dw within w_order_entry_part_number
end type
type dw_circle from u_dw within w_order_entry_part_number
end type
type dw_fender from u_dw within w_order_entry_part_number
end type
type dw_ltrapezoid from u_dw within w_order_entry_part_number
end type
type dw_x1shape from u_dw within w_order_entry_part_number
end type
type dw_parallelogram from u_dw within w_order_entry_part_number
end type
type dw_trapezoid from u_dw within w_order_entry_part_number
end type
type dw_rtrapezoid from u_dw within w_order_entry_part_number
end type
type dw_shape from u_dw within w_order_entry_part_number
end type
type dw_item_detail from u_dw within w_order_entry_part_number
end type
type cb_job from u_cb within w_order_entry_part_number
end type
type cb_order_entry_coil from u_cb within w_order_entry_part_number
end type
type gb_2 from groupbox within w_order_entry_part_number
end type
type dw_reinforcement from u_dw within w_order_entry_part_number
end type
type dw_liftgate_shape from u_dw within w_order_entry_part_number
end type
type cb_calculate from u_cb within w_order_entry_part_number
end type
end forward

global type w_order_entry_part_number from w_sheet
string tag = "Order Entry Information"
integer x = 4
integer y = 3
integer width = 3463
integer height = 2128
string title = "Order Entry"
string menuname = "m_order_entry"
boolean maxbox = false
boolean resizable = false
long backcolor = 12632256
event ue_open_order ( long el_order_id,  long el_cust_id )
event type integer ue_pick_contacts ( )
event type integer ue_get_coil ( long al_coil_num,  long al_order )
event ue_canceled ( integer al_id )
event ue_open ( )
event type string ue_whoami ( )
event ue_read_only ( )
event type long ue_get_orderid ( )
event type long ue_get_customerid ( )
event type integer ue_del_coil ( datawindow adw_del )
event type integer ue_coil_delable ( long al_coil )
event type integer ue_add_coil ( datawindow adw_coil,  datawindow adw_order_coil )
event type integer ue_save ( )
event type long ue_new ( )
event type long ue_copy_order ( long al_old_order )
event ue_calculate ( )
cb_order_entry_browse cb_order_entry_browse
cb_order_entry_print cb_order_entry_print
cb_order_entry_save cb_order_entry_save
gb_order gb_order
dw_order_coil dw_order_coil
dw_order_list dw_order_list
cb_saveas cb_saveas
cb_close cb_close
dw_order_entry_coil dw_order_entry_coil
dw_order_item_list dw_order_item_list
cb_item_del cb_item_del
cb_item_add cb_item_add
dw_job_list dw_job_list
dw_rectangle dw_rectangle
dw_chevron dw_chevron
dw_circle dw_circle
dw_fender dw_fender
dw_ltrapezoid dw_ltrapezoid
dw_x1shape dw_x1shape
dw_parallelogram dw_parallelogram
dw_trapezoid dw_trapezoid
dw_rtrapezoid dw_rtrapezoid
dw_shape dw_shape
dw_item_detail dw_item_detail
cb_job cb_job
cb_order_entry_coil cb_order_entry_coil
gb_2 gb_2
dw_reinforcement dw_reinforcement
dw_liftgate_shape dw_liftgate_shape
cb_calculate cb_calculate
end type
global w_order_entry_part_number w_order_entry_part_number

type variables
Long il_curent_order_id
Long il_current_customer_id
integer ii_active_dw
Long il_coilnew[]
Long il_old_orderid
Long il_pn_id


end variables

forward prototypes
public function integer wf_open_spec_order (long order_number)
public function long wf_next_coil_id ()
public function integer wf_delete_item_shape (integer ai_item_num)
public function integer wf_duplicated_coil ()
public subroutine wf_changing_item_shape (integer ai_item, string as_shape)
public function integer wf_add_item_shape (integer ai_item, string as_shape)
public function integer wf_check_order_info ()
public function integer wf_one_order_selected (long al_order_id)
public function integer wf_coil_in_job (long al_coil_id)
public function integer wf_check_coil_wt ()
public subroutine wf_set_item_updatable ()
public function integer wf_check_coil_assigned ()
public subroutine wf_pieces_per_skid ()
public function integer wf_copy_item_shape ()
public function integer wf_add_pn_shape (string as_shape, integer ai_item)
end prototypes

event ue_open_order;//dw_order_list.inv_linkage.of_Reset()
//wf_one_order_selected(el_order_id)
Long ll_row

//pass the current order number into this window
il_curent_order_id = el_order_id

dw_order_list.inv_linkage.of_Reset()
IF dw_order_list.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_order_entry::wf_oderorder_selected" )
	Return 
ELSE
	SQLCA.of_Commit()
	dw_order_list.SetFocus()
End IF

ll_row = dw_order_list.GetRow()
il_current_customer_id = dw_order_list.GetItemNumber(ll_row, "orig_customer_id")

//show shape
dw_shape.Event ue_show_shape()




end event

event ue_pick_contacts;Long ll_row
Long ll_customer

//this.Event pfc_Save()

ll_row = dw_order_list.GetRow()
IF ll_row >= 0 THEN
	il_curent_order_id = dw_order_list.GetItemNumber(ll_row,"order_abc_num", Primary!, FALSE) 
	ll_customer = dw_order_list.GetItemNumber(ll_row,"Orig_customer_id", Primary!, FALSE) 
ELSE
	il_current_customer_id = 0
END IF

IF IsNULL(ll_customer) OR ll_customer <= 0 THEN 
	//MessageBox("Warning","Select a customer first!")
	Return 0
END IF

// if customer has NOT been changed
IF ll_customer = il_current_customer_id THEN
	Return 0
END IF 

//if customer has been changed
il_current_customer_id = ll_customer

DataWindowChild ldddw_cni
IF dw_order_list.GetChild("order_contact_id", ldddw_cni) = -1 THEN Return -1
IF il_current_customer_id > 0 THEN
	dw_order_list.Event pfc_PopulateDDDW("order_contact_ID", ldddw_cni)
END IF
//dw_order_list.Event pfc_RetrieveDDDW("order_contact_ID")

Return 1
end event

event ue_get_coil;IF dw_order_entry_coil.Event ue_add_existing_coil(al_coil_num) = 1 THEN
		dw_order_coil.Event ue_getrow(al_coil_num)
		IF (al_order = 0) OR IsNULL(al_order) THEN
			il_coilnew[UpperBound(il_coilnew) + 1] = al_coil_num
		END IF
END IF
Return 1
end event

event ue_canceled;call super::ue_canceled;IF il_curent_order_id = 0 THEN Close(this)
end event

event ue_open;Int li_rc
Long ll_return

IF dw_order_list.inv_linkage.of_GetUpdatespending() = 1 THEN
	li_rc = MessageBox("Question", "Save current order first?", Question!, YesNoCancel!, 1)
	IF li_rc = 3 THEN Return	
	IF li_rc = 1 THEN 
		IF this.Event pfc_save() < 0 THEN 
			MessageBox("Error", "Failed to save current order!", StopSign! )
			Return
		END IF
	END IF
END IF

Close(this)

SetPointer(HourGlass!)
Message.StringParm = "w_cust_order_list" 
gnv_app.of_getFrame().Event pfc_open()





end event

event ue_whoami;RETURN "w_cust_order_list"
end event

event ue_read_only;cb_order_entry_save.Enabled = FALSE
cb_order_entry_coil.Enabled = FALSE
cb_saveas.Enabled = FALSE
cb_item_add.Enabled = FALSE
cb_item_del.Enabled = FALSE

dw_order_list.Enabled = FALSE
dw_order_item_list.Object.DataWindow.ReadOnly = "YES"
dw_order_entry_coil.Object.DataWindow.ReadOnly = "YES"
dw_shape.Object.DataWindow.ReadOnly = "YES"
dw_item_detail.Object.DataWindow.ReadOnly = "YES"
dw_order_coil.Object.DataWindow.ReadOnly = "YES"

m_order_entry.m_file.m_save.Disable()

end event

event ue_get_orderid;RETURN il_curent_order_id
end event

event ue_get_customerid;Long ll_row

ll_row = dw_order_list.GetRow()
IF ll_row < 1 THEN Return 0
RETURN dw_order_list.GetItemNumber(ll_row, "Orig_customer_id", Primary!, FALSE)
end event

event ue_del_coil;Long ll_row, ll_coil_num, ll_totalrow
integer li_rc, li_i

ll_totalrow = adw_del.rowCount()
IF ll_totalrow < 1 THEN RETURN 0
FOR ll_row = 1 TO ll_totalrow
	ll_coil_num = adw_del.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
	dw_order_coil.Event ue_deleterow(ll_coil_num)
	dw_order_entry_coil.Event ue_del_row(ll_coil_num)
	IF UpperBound(il_coilnew) > 0 THEN
		FOR li_i = 1 TO UpperBound(il_coilnew) 
			IF il_coilnew[li_i] = ll_coil_num THEN il_coilnew[li_i] = 0
		NEXT
	END IF
NEXT

RETURN 1


end event

event ue_coil_delable;IF al_coil <= 0 THEN 
	MessageBox("Error", "Failed to retrieve this coil!" )
	Return -1
END IF	
IF wf_coil_in_job(al_coil) = 1 THEN 
	MessageBox("Error","Failed to delete coil because it has been assigned to a job already.", StopSign!)
	RETURN -2
END IF
RETURN 1
end event

event ue_add_coil;Long ll_row, ll_totalrow, ll_coil_num, ll_newrow
Long ll_coiltotal, ll_i, ll_curcoiltotal, ll_j
Long ll_wt, ll_wt_bal
Boolean lb_exist
s_coil_info lds_data

ll_totalrow = adw_order_coil.rowCount()
IF ll_totalrow > 0 THEN 
	FOR ll_row = 1 TO ll_totalrow
		ll_coil_num = adw_order_coil.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
		ll_newrow = dw_order_coil.InsertRow(0)
		dw_order_coil.SetItem(ll_newrow, "coil_abc_num", ll_coil_num)
		dw_order_coil.SetItem(ll_newrow, "order_abc_num", il_curent_order_id)
	NEXT
END IF

//dw_order_entry_coil
ll_coiltotal = adw_coil.RowCount()
IF ll_coiltotal > 0 THEN
	FOR ll_i = 1 TO ll_coiltotal
		ll_coil_num = adw_coil.GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE)

		lds_data.customer_id = adw_coil.GetItemNumber(ll_i, "coil_customer_id",Primary!, FALSE)
		lds_data.coil_orig_num = adw_coil.GetItemString(ll_i, "coil_coil_org_num", Primary!, FALSE)
		lds_data.coil_alt_num = adw_coil.GetItemString(ll_i, "coil_coil_mid_num", Primary!, FALSE)
		lds_data.lot_num = adw_coil.GetItemString(ll_i, "coil_lot_num",Primary!, FALSE)
		lds_data.pieces = adw_coil.GetItemNumber(ll_i, "coil_pieces_per_case", Primary!, FALSE)
		lds_data.coil_line_num = adw_coil.GetItemNumber(ll_i, "coil_coil_line_num", Primary!, FALSE)
		lds_data.icra = adw_coil.GetItemString(ll_i, "coil_icra", Primary!, FALSE)
		lds_data.alloy = adw_coil.GetItemString(ll_i, "coil_coil_alloy2",Primary!, FALSE)
		lds_data.gauge = adw_coil.GetItemNumber(ll_i, "coil_coil_gauge", Primary!, FALSE)
		lds_data.Temper = adw_coil.GetItemString(ll_i, "coil_coil_temper", Primary!, FALSE)
		lds_data.net_wt = adw_coil.GetItemNumber(ll_i, "coil_net_wt", Primary!, FALSE)
		lds_data.net_balance = adw_coil.GetItemNumber(ll_i, "coil_net_wt_balance", Primary!, FALSE)
		lds_data.width = adw_coil.GetItemNumber(ll_i, "coil_coil_width", Primary!, FALSE)
		lds_data.date_received = adw_coil.GetItemDateTime(ll_i, "coil_date_received", Primary!, FALSE)
		lds_data.location = adw_coil.GetItemString(ll_i, "coil_coil_location", Primary!, FALSE)
		lds_data.status = adw_coil.GetItemNumber(ll_i, "coil_coil_status", Primary!, FALSE)
		lds_data.notes = adw_coil.GetItemString(ll_i, "coil_coil_notes", Primary!, FALSE)
		lds_data.coil_from_cust_id = adw_coil.GetItemNumber(ll_i, "coil_coil_from_cust_id", Primary!, FALSE)

		lb_exist = FALSE
		ll_curcoiltotal = dw_order_entry_coil.RowCount()
		IF ll_curcoiltotal > 0 THEN
			FOR ll_j = 1 TO ll_curcoiltotal 
				IF dw_order_entry_coil.GetItemNumber(ll_j, "coil_abc_num", Primary!, FALSE) = ll_coil_num THEN

					dw_order_entry_coil.SetItem(ll_j, "coil_customer_id", lds_data.customer_id)
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_org_num", lds_data.coil_orig_num)
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_mid_num", lds_data.coil_alt_num)
					dw_order_entry_coil.SetItem(ll_j, "coil_lot_num",lds_data.lot_num)
					dw_order_entry_coil.SetItem(ll_j, "coil_pieces_per_case",lds_data.pieces )
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_line_num",lds_data.coil_line_num )
					dw_order_entry_coil.SetItem(ll_j, "coil_icra",lds_data.icra)
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_alloy2",lds_data.alloy)
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_gauge",lds_data.gauge )
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_temper",lds_data.gauge )
					dw_order_entry_coil.SetItem(ll_j, "coil_net_wt", lds_data.net_wt)
					dw_order_entry_coil.SetItem(ll_j, "coil_net_wt_balance",lds_data.net_balance )
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_width",lds_data.width)
					dw_order_entry_coil.SetItem(ll_j, "coil_date_received",lds_data.date_received )
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_location",lds_data.location)
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_status", lds_data.status)
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_notes",lds_data.notes)
					dw_order_entry_coil.SetItem(ll_j, "coil_coil_from_cust_id",lds_data.coil_from_cust_id )
		
					lb_exist = TRUE
				END IF
			NEXT
		END IF
		IF NOT(lb_exist) THEN
			ll_newrow = dw_order_entry_coil.InsertRow(0)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_abc_num", ll_coil_num)

			dw_order_entry_coil.SetItem(ll_newrow, "coil_customer_id", lds_data.customer_id)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_org_num", lds_data.coil_orig_num)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_mid_num", lds_data.coil_alt_num)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_lot_num",lds_data.lot_num)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_pieces_per_case",lds_data.pieces )
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_line_num",lds_data.coil_line_num )
			dw_order_entry_coil.SetItem(ll_newrow, "coil_icra",lds_data.icra)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_alloy2",lds_data.alloy)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_gauge",lds_data.gauge )
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_temper",lds_data.gauge )
			dw_order_entry_coil.SetItem(ll_newrow, "coil_net_wt", lds_data.net_wt)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_net_wt_balance",lds_data.net_balance )
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_width",lds_data.width)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_date_received",lds_data.date_received )
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_location",lds_data.location)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_status", lds_data.status)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_notes",lds_data.notes)
			dw_order_entry_coil.SetItem(ll_newrow, "coil_coil_from_cust_id",lds_data.coil_from_cust_id )
		
		END IF
	NEXT
END IF

RETURN 1

end event

event ue_save;if messagebox("Save", "About to update Order information.",&
             Question!, OkCancel!,1)<>1 then
   Return 0
else
	this.Event pfc_Save()
end if

RETURN 1
	
end event

event ue_new;Long ll_new_order
CHOOSE CASE il_old_orderid
	CASE 0  //new
		MessageBox("Warning", "You can only duplicate a existing order, not a new one.")
		Return 0
	CASE -1 //close
		Return -1
	CASE ELSE
		ll_new_order = this.Event ue_copy_order(il_old_orderid)
		wf_set_item_updatable()
END CHOOSE
RETURN ll_new_order

end event

event ue_copy_order;Int li_rc
IF dw_order_list.inv_linkage.of_GetUpdatespending() = 1 THEN
	li_rc = MessageBox("Question", "Save current order first?", Question!, YesNoCancel!, 1)
	IF li_rc = 3 THEN Return -1
	IF li_rc = 1 THEN 
		IF this.Event pfc_Save() < 0 THEN Return -2
	END IF
END IF

dw_order_list.DBCancel()
//dw_order_list.inv_linkage.of_Reset()
dw_order_item_list.ShareDataOff()
dw_order_entry_coil.ShareDataOff()
dw_order_list.inv_linkage.of_reset()
dw_item_detail.Reset()
dw_job_list.Reset()
//redo sharedata
dw_order_item_list.ShareData(dw_item_detail)

RETURN dw_order_list.Event pfc_AddRow()


end event

event ue_calculate;String ls_alloy, ls_shape
Real lr_density, lr_gauge, lr_pc_wt
Real lr_length, lr_llength, lr_slength, lr_width, lr_diameter
Int li_rc

//get alloy
dw_order_item_list.AcceptText()
ls_alloy = Trim(dw_item_detail.GetItemString(dw_item_detail.GetRow(),"alloy2"))
IF Len(ls_alloy) <= 0 THEN		//if empty, error message
	MessageBox("Error","Alloy data is not available.", StopSign!,OK!)
	Return
ELSE
	CONNECT USING SQLCA;
	SELECT METAL_DENSITY INTO :lr_density
	FROM METAL_DENSITY
	WHERE METAL_ALLOY = :ls_alloy;
	IF ISNULL(lr_density) OR (lr_density <= 0) THEN		//if empty, error message
		MessageBox("Error","Density data for this kind of alloy is not available.", StopSign!,OK!)
		Return
	END IF
	
	//get gauge
	li_rc = dw_order_item_list.GetRow()
	dw_order_item_list.AcceptText()
	lr_gauge = dw_order_item_list.GetItemNumber(li_rc,"gauge")
	
	//get shape
	ls_shape = Trim(dw_order_item_list.GetItemString(li_rc,"sheet_type"))
	
	li_rc = dw_shape.GetRow()
	//if not calculatable, error message
	CHOOSE CASE ls_shape
	CASE "Rectangle"
		lr_length = dw_shape.GetItemNumber(li_rc, "rt_length")
		IF ISNULL(lr_length) OR (lr_length <= 0) THEN		//if empty, error message
			MessageBox("Error","Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_width = dw_shape.GetItemNumber(li_rc, "rt_width")
		IF ISNULL(lr_width) OR (lr_width <= 0) THEN		//if empty, error message
			MessageBox("Error","Width data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_pc_wt = lr_length * lr_width * lr_gauge * lr_density
	CASE "Parallelogram"
		lr_length = dw_shape.GetItemNumber(li_rc, "p_length")
		IF ISNULL(lr_length) OR (lr_length <= 0) THEN		//if empty, error message
			MessageBox("Error","Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_width = dw_shape.GetItemNumber(li_rc, "p_width")
		IF ISNULL(lr_width) OR (lr_width <= 0) THEN		//if empty, error message
			MessageBox("Error","Width data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_pc_wt = lr_length * lr_width * lr_gauge * lr_density
	CASE "Chevron"
		lr_length = dw_shape.GetItemNumber(li_rc, "ch_length")
		IF ISNULL(lr_length) OR (lr_length <= 0) THEN		//if empty, error message
			MessageBox("Error","Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_width = dw_shape.GetItemNumber(li_rc, "ch_width")
		IF ISNULL(lr_width) OR (lr_width <= 0) THEN		//if empty, error message
			MessageBox("Error","Width data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_pc_wt = lr_length * lr_width * lr_gauge * lr_density
	CASE "Trapezoid"
		lr_llength = dw_shape.GetItemNumber(li_rc, "tr_long_length")
		IF ISNULL(lr_llength) OR (lr_llength <= 0) THEN		//if empty, error message
			MessageBox("Error","Long Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_slength = dw_shape.GetItemNumber(li_rc, "tr_short_length")
		IF ISNULL(lr_slength) OR (lr_slength <= 0) THEN		//if empty, error message
			MessageBox("Error","Short Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_width = dw_shape.GetItemNumber(li_rc, "tr_width")
		IF ISNULL(lr_width) OR (lr_width <= 0) THEN		//if empty, error message
			MessageBox("Error","Width data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_pc_wt = (lr_llength + lr_slength)/2 * lr_width * lr_gauge * lr_density
	CASE "L.Trapezoid"
		lr_llength = dw_shape.GetItemNumber(li_rc, "ltr_long_length")
		IF ISNULL(lr_llength) OR (lr_llength <= 0) THEN		//if empty, error message
			MessageBox("Error","Long Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_slength = dw_shape.GetItemNumber(li_rc, "ltr_short_length")
		IF ISNULL(lr_slength) OR (lr_slength <= 0) THEN		//if empty, error message
			MessageBox("Error","Short Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_width = dw_shape.GetItemNumber(li_rc, "ltr_width")
		IF ISNULL(lr_width) OR (lr_width <= 0) THEN		//if empty, error message
			MessageBox("Error","Width data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_pc_wt = (lr_llength + lr_slength)/2 * lr_width * lr_gauge * lr_density
	CASE "R.Trapezoid"
		lr_llength = dw_shape.GetItemNumber(li_rc, "rtr_long_length")
		IF ISNULL(lr_llength) OR (lr_llength <= 0) THEN		//if empty, error message
			MessageBox("Error","Long Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_slength = dw_shape.GetItemNumber(li_rc, "rtr_short_length")
		IF ISNULL(lr_slength) OR (lr_slength <= 0) THEN		//if empty, error message
			MessageBox("Error","Short Length data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_width = dw_shape.GetItemNumber(li_rc, "rtr_width")
		IF ISNULL(lr_width) OR (lr_width <= 0) THEN		//if empty, error message
			MessageBox("Error","Width data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_pc_wt = (lr_llength + lr_slength)/2 * lr_width * lr_gauge * lr_density
	CASE "Circle"
		lr_diameter = dw_shape.GetItemNumber(li_rc, "c_diameter")
		IF ISNULL(lr_diameter) OR (lr_diameter <= 0) THEN		//if empty, error message
			MessageBox("Error","Diameter data is not available.", StopSign!,OK!)
			Return
		END IF
		lr_pc_wt = 3.1415927 * (lr_diameter * lr_diameter)/4 * lr_gauge * lr_density		
	CASE ELSE
		MessageBox("Error", "Piece Weight of this shape is not calculalbe.", StopSign!,OK!)
		Return
	END CHOOSE

	//output result
	li_rc = 	MessageBox("Result", "Suggested Piece Weight is " + String(Round(lr_pc_wt,2)) + ". Do you want to use it?", Question!,YesNo!)
	IF li_rc = 1 THEN
		dw_item_detail.SetItem(dw_item_detail.GetRow(), "theoretical_unit_wt", Round(lr_pc_wt,2))
		dw_item_detail.AcceptText()
	END IF
END IF
Return



end event

public function integer wf_open_spec_order (long order_number);IF dw_order_list.retrieve(order_number) = -1 THEN
	MessageBox("Error", "w_order_entry::wf_open_spec_order" )
	Return -1
End IF
dw_order_list.inv_linkage.of_Reset()
dw_order_list.SetFocus()
Return 1
end function

public function long wf_next_coil_id ();Long  ll_int_next_id
String ls_col_name

ls_col_name = 'coil_abc_num_seq'
SELECT Coil_abc_num_seq.NEXTVAL INTO :ll_int_next_id FROM DUAL;

// generate next id using oracle sequence 
UPDATE sequence_key
SET sequence_curval = :ll_int_next_id
WHERE sequence_name = :ls_col_name
USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Database Error", SQLCA.SQLErrText, Exclamation!)
	ROLLBACK using SQLCA;
	Return -2
ELSE
	COMMIT using SQLCA;
END IF

Return ll_int_next_id

end function

public function integer wf_delete_item_shape (integer ai_item_num);SetPointer(HourGlass!)
Int li_count
Long ll_totalrow, ll_i

//delete old shape
ll_totalrow = dw_rectangle.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_rectangle.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_rectangle.DeleteRow(ll_i)
	END IF
NEXT
ll_totalrow = dw_parallelogram.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_parallelogram.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_parallelogram.DeleteRow(ll_i)
	END IF
NEXT
ll_totalrow = dw_fender.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_fender.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_fender.DeleteRow(ll_i)
	END IF
NEXT
ll_totalrow = dw_chevron.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_chevron.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_chevron.DeleteRow(ll_i)
	END IF
NEXT
ll_totalrow = dw_circle.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1 
	IF dw_circle.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_circle.DeleteRow(ll_i)
	END IF
NEXT
ll_totalrow = dw_trapezoid.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_trapezoid.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_trapezoid.DeleteRow(ll_i)
	END IF
NEXT
ll_totalrow = dw_ltrapezoid.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_ltrapezoid.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_ltrapezoid.DeleteRow(ll_i)
	END IF
NEXT
ll_totalrow = dw_rtrapezoid.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_rtrapezoid.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_rtrapezoid.DeleteRow(ll_i)
	END IF
NEXT

ll_totalrow = dw_reinforcement.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_reinforcement.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_reinforcement.DeleteRow(ll_i)
	END IF
NEXT

ll_totalrow = dw_liftgate_shape.RowCount()
FOR ll_i = ll_totalrow TO 1 STEP -1
	IF dw_liftgate_shape.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE ) = ai_item_num THEN 
		dw_liftgate_shape.DeleteRow(ll_i)
	END IF
NEXT




Return 1
end function

public function integer wf_duplicated_coil ();//If there are duplcated coil_orig_num then return 1 else return 0
Long ll_row, ll_int
Long ll_id, ll_old_id
String ls_num
Int li_rc

ll_row = dw_order_entry_coil.RowCount()
IF ll_row <= 0 THEN Return 1
FOR ll_int = 1 TO ll_row
	ll_id = dw_order_entry_coil.GetItemNumber(ll_int, "coil_abc_num" )
	ls_num = dw_order_entry_coil.GetItemString(ll_int, "coil_coil_org_num")
	ll_old_id = 0
	IF Len(ls_num) > 0 THEN
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
NEXT

Return 1
end function

public subroutine wf_changing_item_shape (integer ai_item, string as_shape);wf_delete_item_shape(ai_item)
wf_add_item_shape(ai_item, as_shape)

end subroutine

public function integer wf_add_item_shape (integer ai_item, string as_shape);Long ll_row

CHOOSE CASE Upper(Trim(as_shape))
	CASE "RECTANGLE"
		ll_row = dw_rectangle.event pfc_addrow()
		dw_rectangle.SetItem(ll_row, "order_item_num", ai_item)
		dw_rectangle.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "PARALLELOGRAM"
		ll_row = dw_parallelogram.InsertRow(0)
		dw_parallelogram.SetItem(ll_row, "order_item_num", ai_item)
		dw_parallelogram.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "FENDER"
		ll_row = dw_fender.InsertRow(0)
		dw_fender.SetItem(ll_row, "order_item_num", ai_item)
		dw_fender.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "CHEVRON"
		ll_row = dw_chevron.InsertRow(0)
		dw_chevron.SetItem(ll_row, "order_item_num", ai_item)
		dw_chevron.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "CIRCLE"
		ll_row = dw_circle.InsertRow(0)
		dw_circle.SetItem(ll_row, "order_item_num", ai_item)
		dw_circle.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "TRAPEZOID"
		ll_row = dw_trapezoid.InsertRow(0)
		dw_trapezoid.SetItem(ll_row, "order_item_num", ai_item)
		dw_trapezoid.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "L.TRAPEZOID"
		ll_row = dw_ltrapezoid.InsertRow(0)
		dw_ltrapezoid.SetItem(ll_row, "order_item_num", ai_item)
		dw_ltrapezoid.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "R.TRAPEZOID"
		ll_row = dw_rtrapezoid.InsertRow(0)
		dw_rtrapezoid.SetItem(ll_row, "order_item_num", ai_item)
		dw_rtrapezoid.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "REINFORCEMENT"
		ll_row = dw_reinforcement.InsertRow(0)
		dw_reinforcement.SetItem(ll_row, "order_item_num", ai_item)
		dw_reinforcement.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
	CASE "LIFTGATE"
		ll_row = dw_liftgate_shape.InsertRow(0)
		dw_liftgate_shape.SetItem(ll_row, "order_item_num", ai_item)
		dw_liftgate_shape.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		
CASE ELSE
		ll_row = dw_x1shape.InsertRow(0)
		dw_x1shape.SetItem(ll_row, "order_item_num", ai_item)
		dw_x1shape.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
END CHOOSE		
RETURN 1

end function

public function integer wf_check_order_info ();RETURN 1
end function

public function integer wf_one_order_selected (long al_order_id);Long ll_row

//pass the current order number into this window
il_curent_order_id = al_order_id

IF dw_order_list.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_order_entry::wf_oderorder_selected" )
	Return 0
ELSE
	SQLCA.of_Commit()
	dw_order_list.SetFocus()
End IF

ll_row = dw_order_list.GetRow()
il_current_customer_id = dw_order_list.GetItemNumber(ll_row, "orig_customer_id")

//show shape
dw_shape.Event ue_show_shape()

Return 1
end function

public function integer wf_coil_in_job (long al_coil_id);Long ll_total, ll_row, ll_job, ll_rc

ll_total = dw_job_list.RowCount()
IF ll_total > 0 THEN	
	CONNECT USING SQLCA;
	FOR ll_row = 1 TO ll_total
		ll_rc = 0
		ll_job = dw_job_list.GetItemNumber(ll_row, "ab_job_num")
		SELECT Count(ab_job_num) INTO :ll_rc
		FROM process_coil
		WHERE ab_job_num = :ll_job AND coil_abc_num = :al_coil_id
		USING SQLCA;
		IF ll_rc > 0 THEN RETURN 1
	NEXT
END IF

RETURN 0
end function

public function integer wf_check_coil_wt ();//If there is some coil with wt then return -1 else return 
Long ll_row, ll_int
Long ll_wt, ll_wt_bal

ll_row = dw_order_entry_coil.RowCount()
IF ll_row <= 0 THEN Return 1
FOR ll_int = 1 TO ll_row
	ll_wt = dw_order_entry_coil.GetItemNumber(ll_int, "coil_net_wt", Primary!, FALSE )
	ll_wt_bal = dw_order_entry_coil.GetItemNumber(ll_int, "coil_net_wt_balance", Primary!, FALSE)
	IF IsNULL(ll_wt) OR ll_wt = 0 THEN
		MessageBox("Error", "Invalid coil weight.", StopSign!)
		RETURN -1
	END IF
	If IsNULL(ll_wt_bal) THEN
		dw_order_entry_coil.SetItem(ll_int, "coil_net_wt_balance", ll_wt)
	END IF
NEXT
dw_order_entry_coil.AcceptText()

Return 1
end function

public subroutine wf_set_item_updatable ();//dw_order_list.SetTabOrder("order_contact_id", 10)
dw_order_list.SetTabOrder("term", 20)

IF dw_job_list.RowCount() > 0 THEN
	dw_order_list.SetTabOrder("orig_customer_id", 0)
ELSE
	dw_order_list.SetTabOrder("orig_customer_id", 30)
END IF

dw_order_list.SetTabOrder("orig_customer_po", 40)
dw_order_list.SetTabOrder("reference", 50)
dw_order_list.SetTabOrder("cust_order_line_note", 60)
dw_order_list.SetTabOrder("enduser_id", 70)
dw_order_list.SetTabOrder("enduser_po", 80)
dw_order_list.SetTabOrder("scrap_handing_type", 90)
dw_order_list.SetTabOrder("cust_order_note", 100)
dw_order_list.SetTabOrder("sales_order", 110)
dw_order_list.SetTabOrder("sheet_handling_type", 120)

end subroutine

public function integer wf_check_coil_assigned ();Int li_upper, li_i
Long ll_order

li_upper = UpperBound(il_coilnew)
IF IsNULL(li_upper) OR li_upper = 0 THEN RETURN 1

FOR li_i = 1 TO li_upper
	IF il_coilnew[li_i] <> 0 THEN
		ll_order = 0
		CONNECT USING SQLCA;
		SELECT order_abc_num INTO :ll_order
		FROM order_coil
		WHERE coil_abc_num = :il_coilnew[li_i]
		USING SQLCA;
		IF ll_order > 1 THEN
			IF MessageBox("Warning", "Coil " + String(il_coilnew[li_i]) + " has just been assigned to customer order " + string(ll_order) + ". Save it anyway?", Question!, YesNo!, 2) = 2 THEN
				RETURN -1
			ELSE
				il_coilnew[li_i] = 0
			END IF
		END IF
	END IF
NEXT

RETURN 1
end function

public subroutine wf_pieces_per_skid ();Long ll_row, ll_i
Long ll_ps, ll_maxwt, ll_theo

ll_row = dw_order_item_list.RowCount()
IF ll_row < 1 THEN RETURN
FOR ll_i = 1 TO ll_row
	ll_ps = dw_order_item_list.GetItemNumber(ll_i, "pieces_skid", Primary!, FALSE)
	ll_maxwt = dw_order_item_list.GetItemNumber(ll_i, "max_skid_wt", Primary!, FALSE)
	ll_theo = dw_order_item_list.GetItemNumber(ll_i, "theoretical_unit_wt", Primary!, FALSE)
	IF ll_ps = 0 OR IsNULL(ll_ps) THEN
		IF ll_theo > 0 AND ll_maxwt > 0 THEN
			ll_ps = Int(ll_maxwt / ll_theo )
			dw_order_item_list.SetItem(ll_i, "pieces_skid", ll_ps)
		END IF
	END IF
NEXT
	
end subroutine

public function integer wf_copy_item_shape ();Long ll_row, ll_i, nulllong
DataStore lds_temp

setnull(nulllong)

lds_temp = CREATE DataStore
// "CASE "rectangle"
lds_temp.DataObject = "d_rectangle_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_rectangle, 1, Primary!)
	FOR ll_i = 1 TO dw_rectangle.RowCount()
		dw_rectangle.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		//Added by Victor Huang in 05/04 for not allow to copy 5 critical spec data: tempar, alloy, gauge, length, width
		dw_rectangle.SetItem(ll_i,"rt_length", nulllong )
		dw_rectangle.SetItem(ll_i,"rt_length_plus", nulllong )
		dw_rectangle.SetItem(ll_i,"rt_length_minus", nulllong )
		dw_rectangle.SetItem(ll_i,"rt_width", nulllong )
		dw_rectangle.SetItem(ll_i,"rt_width_plus", nulllong )
		dw_rectangle.SetItem(ll_i,"rt_width_minus", nulllong )
	NEXT
END IF
//	CASE "PARALLELOGRAM"
lds_temp.DataObject = "d_parallelogram_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_parallelogram, 1, Primary!)
	FOR ll_i = 1 TO dw_parallelogram.RowCount()
		dw_parallelogram.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_parallelogram.SetItem(ll_i,"p_length", nulllong )
		dw_parallelogram.SetItem(ll_i,"p_length_plus", nulllong )
		dw_parallelogram.SetItem(ll_i,"p_length_minus", nulllong )
		dw_parallelogram.SetItem(ll_i,"p_width", nulllong )
		dw_parallelogram.SetItem(ll_i,"p_width_plus", nulllong )
		dw_parallelogram.SetItem(ll_i,"p_width_minus", nulllong )
		dw_parallelogram.SetItem(ll_i,"p_angle1", nulllong )
		dw_parallelogram.SetItem(ll_i,"p_angle2", nulllong )
	NEXT
END IF
//	CASE "FENDER"
lds_temp.DataObject = "d_fender_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_fender, 1, Primary!)
	FOR ll_i = 1 TO dw_fender.RowCount()
		dw_fender.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		//dw_fender.SetItem(ll_i,"fe_length", nulllong )
		//dw_fender.SetItem(ll_i,"fe_length_plus", nulllong )
		//dw_fender.SetItem(ll_i,"fe_length_minus", nulllong )
		dw_fender.SetItem(ll_i,"fe_side", nulllong )
		dw_fender.SetItem(ll_i,"fe_side_plus", nulllong )
		dw_fender.SetItem(ll_i,"fe_side_minus", nulllong )
	NEXT
END IF
//	CASE "CHEVRON"
lds_temp.DataObject = "d_chevron_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_chevron, 1, Primary!)
	FOR ll_i = 1 TO dw_chevron.RowCount()
		dw_chevron.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_chevron.SetItem(ll_i,"ch_length", nulllong )
		dw_chevron.SetItem(ll_i,"ch_length_plus", nulllong )
		dw_chevron.SetItem(ll_i,"ch_length_minus", nulllong )
		dw_chevron.SetItem(ll_i,"ch_width", nulllong )
		dw_chevron.SetItem(ll_i,"ch_width_plus", nulllong )
		dw_chevron.SetItem(ll_i,"ch_width_minus", nulllong )
	NEXT
END IF
//	CASE "CIRCLE"
lds_temp.DataObject = "d_circle_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_circle, 1, Primary!)
	FOR ll_i = 1 TO dw_circle.RowCount()
		dw_circle.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_circle.SetItem(ll_i,"c_diameter", nulllong )
		dw_circle.SetItem(ll_i,"c_diameter_plus", nulllong )
		dw_circle.SetItem(ll_i,"c_diameter_minus", nulllong )
	NEXT
END IF
//	CASE "TRAPEZOID"
lds_temp.DataObject = "d_trapezoid_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_trapezoid, 1, Primary!)
	FOR ll_i = 1 TO dw_trapezoid.RowCount()
		dw_trapezoid.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_trapezoid.SetItem(ll_i,"tr_long_length", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_long_plus", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_long_minus", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_short_length", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_short_plus", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_short_minus", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_width", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_width_plus", nulllong )
		dw_trapezoid.SetItem(ll_i,"tr_width_minus", nulllong )
		
	NEXT
END IF
//	CASE "L.TRAPEZOID"
lds_temp.DataObject = "d_ltrapezoid_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_ltrapezoid, 1, Primary!)
	FOR ll_i = 1 TO dw_ltrapezoid.RowCount()
		dw_ltrapezoid.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_ltrapezoid.SetItem(ll_i,"ltr_long_length", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_long_plus", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_long_minus", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_short_length", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_short_plus", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_short_minus", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_width", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_width_plus", nulllong )
		dw_ltrapezoid.SetItem(ll_i,"ltr_width_minus", nulllong )
	NEXT
END IF
//	CASE "R.TRAPEZOID"
lds_temp.DataObject = "d_rtrapezoid_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_rtrapezoid, 1, Primary!)
	FOR ll_i = 1 TO dw_rtrapezoid.RowCount()
		dw_rtrapezoid.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_rtrapezoid.SetItem(ll_i,"rtr_long_length", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_long_plus", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_long_minus", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_short_length", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_short_plus", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_short_minus", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_width", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_width_plus", nulllong )
		dw_rtrapezoid.SetItem(ll_i,"rtr_width_minus", nulllong )
	NEXT
END IF
//CASE REINFORCEMENT
lds_temp.DataObject = "d_reinforcement_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_reinforcement, 1, Primary!)
	FOR ll_i = 1 TO dw_reinforcement.RowCount()
		dw_reinforcement.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_reinforcement.SetItem(ll_i,"re_length", nulllong )
		dw_reinforcement.SetItem(ll_i,"re_length_plus", nulllong )
		dw_reinforcement.SetItem(ll_i,"re_length_minus", nulllong )
		dw_reinforcement.SetItem(ll_i,"re_width", nulllong )
		dw_reinforcement.SetItem(ll_i,"re_width_plus", nulllong )
		dw_reinforcement.SetItem(ll_i,"re_width_minus", nulllong )
		
	NEXT
END IF

//CASE LIFTGATE

lds_temp.DataObject = "d_liftgate_shape_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_liftgate_shape, 1, Primary!)
	FOR ll_i = 1 TO dw_liftgate_shape.RowCount()
		dw_liftgate_shape.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_liftgate_shape.SetItem(ll_i,"li_length", nulllong )
		dw_liftgate_shape.SetItem(ll_i,"li_length_plus", nulllong )
		dw_liftgate_shape.SetItem(ll_i,"li_length_minus", nulllong )
		dw_liftgate_shape.SetItem(ll_i,"li_width", nulllong )
		dw_liftgate_shape.SetItem(ll_i,"li_width_plus", nulllong )
		dw_liftgate_shape.SetItem(ll_i,"li_width_minus", nulllong )
	NEXT
END IF


//	CASE ELSE
lds_temp.DataObject = "d_x1shape_data"  
lds_temp.SetTransObject (SQLCA)
lds_temp.retrieve(il_old_orderid)
IF lds_temp.RowCount() > 0 THEN
	lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, dw_x1shape, 1, Primary!)
	FOR ll_i = 1 TO dw_x1shape.RowCount()
		dw_x1shape.SetItem(ll_i,"order_abc_num", il_curent_order_id )
		dw_x1shape.SetItem(ll_i,"x_1", nulllong )
		dw_x1shape.SetItem(ll_i,"x_2", nulllong )
		dw_x1shape.SetItem(ll_i,"x_3", nulllong )
		dw_x1shape.SetItem(ll_i,"x_4", nulllong )
		dw_x1shape.SetItem(ll_i,"x_5", nulllong )
		dw_x1shape.SetItem(ll_i,"x_6", nulllong )
	NEXT
END IF

DESTROY lds_temp

RETURN 1
end function

public function integer wf_add_pn_shape (string as_shape, integer ai_item);Long ll_row
Real lr_1, lr_2, lr_3, lr_4, lr_5, lr_6, lr_7, lr_8, lr_9

CHOOSE CASE Upper(Trim(as_shape))
	CASE "RECTANGLE"
		ll_row = dw_rectangle.event pfc_addrow()
		dw_rectangle.SetItem(ll_row, "order_item_num", ai_item)
		dw_rectangle.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT rt_length, rt_length_plus, rt_length_minus, rt_width, rt_width_plus, rt_width_minus
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6
		FROM part_num_rectangle
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_rectangle.SetItem(ll_row, "rt_length", lr_1 )
		dw_rectangle.SetItem(ll_row, "rt_length_plus",  lr_2 )
		dw_rectangle.SetItem(ll_row, "rt_length_minus", lr_3 )
		dw_rectangle.SetItem(ll_row, "rt_width",  lr_4 )
		dw_rectangle.SetItem(ll_row, "rt_width_plus", lr_5 )
		dw_rectangle.SetItem(ll_row, "rt_width_minus",  lr_6 )			
	CASE "PARALLELOGRAM"
		ll_row = dw_parallelogram.InsertRow(0)
		dw_parallelogram.SetItem(ll_row, "order_item_num", ai_item)
		dw_parallelogram.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT p_length, p_length_plus, p_length_minus, p_width, p_width_plus, p_width_minus, p_angle1, p_angle2
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6, :lr_7, :lr_8
		FROM part_num_parallelogram
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_parallelogram.SetItem(ll_row, "p_length", lr_1 )
		dw_parallelogram.SetItem(ll_row, "p_length_plus",  lr_2 )
		dw_parallelogram.SetItem(ll_row, "p_length_minus", lr_3 )
		dw_parallelogram.SetItem(ll_row, "p_width",  lr_4 )
		dw_parallelogram.SetItem(ll_row, "p_width_plus", lr_5 )
		dw_parallelogram.SetItem(ll_row, "p_width_minus",  lr_6 )		
		dw_parallelogram.SetItem(ll_row, "p_angle1", lr_7 )
		dw_parallelogram.SetItem(ll_row, "p_angle2",  lr_8 )		
	CASE "FENDER"
		ll_row = dw_fender.InsertRow(0)
		dw_fender.SetItem(ll_row, "order_item_num", ai_item)
		dw_fender.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT fe_side, fe_side_plus, fe_side_minus
		INTO  :lr_1, :lr_2, :lr_3
		FROM part_num_fender
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_fender.SetItem(ll_row, "fe_side", lr_1 )
		dw_fender.SetItem(ll_row, "fe_side_plus",  lr_2 )
		dw_fender.SetItem(ll_row, "fe_side_minus", lr_3 )
	CASE "CHEVRON"
		ll_row = dw_chevron.InsertRow(0)
		dw_chevron.SetItem(ll_row, "order_item_num", ai_item)
		dw_chevron.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT ch_length, ch_length_plus, ch_length_minus, ch_width, ch_width_plus, ch_width_minus
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6
		FROM part_num_chevron
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_chevron.SetItem(ll_row, "ch_length", lr_1 )
		dw_chevron.SetItem(ll_row, "ch_length_plus",  lr_2 )
		dw_chevron.SetItem(ll_row, "ch_length_minus", lr_3 )
		dw_chevron.SetItem(ll_row, "ch_width",  lr_4 )
		dw_chevron.SetItem(ll_row, "ch_width_plus", lr_5 )
		dw_chevron.SetItem(ll_row, "ch_width_minus",  lr_6 )		
	CASE "CIRCLE"
		ll_row = dw_circle.InsertRow(0)
		dw_circle.SetItem(ll_row, "order_item_num", ai_item)
		dw_circle.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT c_diameter, c_diameter_plus, c_diameter_minus
		INTO  :lr_1, :lr_2, :lr_3
		FROM part_num_circle
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_circle.SetItem(ll_row, "c_diameter", lr_1 )
		dw_circle.SetItem(ll_row, "c_diameter_plus",  lr_2 )
		dw_circle.SetItem(ll_row, "c_diameter_minus", lr_3 )
	CASE "TRAPEZOID"
		ll_row = dw_trapezoid.InsertRow(0)
		dw_trapezoid.SetItem(ll_row, "order_item_num", ai_item)
		dw_trapezoid.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT tr_long_length, tr_long_plus, tr_long_minus, tr_short_length, tr_short_plus, tr_short_minus, tr_width, tr_width_plus, tr_width_minus
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6, :lr_7, :lr_8, :lr_9
		FROM part_num_trapezoid
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_trapezoid.SetItem(ll_row, "tr_long_length", lr_1 )
		dw_trapezoid.SetItem(ll_row, "tr_long_plus",  lr_2 )
		dw_trapezoid.SetItem(ll_row, "tr_long_minus", lr_3 )
		dw_trapezoid.SetItem(ll_row, "tr_short_length",  lr_4 )
		dw_trapezoid.SetItem(ll_row, "tr_short_plus", lr_5 )
		dw_trapezoid.SetItem(ll_row, "tr_short_minus",  lr_6 )		
		dw_trapezoid.SetItem(ll_row, "tr_width",  lr_7 )
		dw_trapezoid.SetItem(ll_row, "tr_width_plus", lr_8 )
		dw_trapezoid.SetItem(ll_row, "tr_width_minus",  lr_9 )		
	CASE "L.TRAPEZOID"
		ll_row = dw_ltrapezoid.InsertRow(0)
		dw_ltrapezoid.SetItem(ll_row, "order_item_num", ai_item)
		dw_ltrapezoid.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT ltr_long_length, ltr_long_plus, ltr_long_minus, ltr_short_length, ltr_short_plus, ltr_short_minus, ltr_width, ltr_width_plus, ltr_width_minus
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6, :lr_7, :lr_8, :lr_9
		FROM part_num_left_trapezoid
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_ltrapezoid.SetItem(ll_row, "ltr_long_length", lr_1 )
		dw_ltrapezoid.SetItem(ll_row, "ltr_long_plus",  lr_2 )
		dw_ltrapezoid.SetItem(ll_row, "ltr_long_minus", lr_3 )
		dw_ltrapezoid.SetItem(ll_row, "ltr_short_length",  lr_4 )
		dw_ltrapezoid.SetItem(ll_row, "ltr_short_plus", lr_5 )
		dw_ltrapezoid.SetItem(ll_row, "ltr_short_minus",  lr_6 )		
		dw_ltrapezoid.SetItem(ll_row, "ltr_width",  lr_7 )
		dw_ltrapezoid.SetItem(ll_row, "ltr_width_plus", lr_8 )
		dw_ltrapezoid.SetItem(ll_row, "ltr_width_minus",  lr_9 )		
	CASE "R.TRAPEZOID"
		ll_row = dw_rtrapezoid.InsertRow(0)
		dw_rtrapezoid.SetItem(ll_row, "order_item_num", ai_item)
		dw_rtrapezoid.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT rtr_long_length, rtr_long_plus, rtr_long_minus, rtr_short_length, rtr_short_plus, rtr_short_minus, rtr_width, rtr_width_plus, rtr_width_minus
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6, :lr_7, :lr_8, :lr_9
		FROM part_num_right_trapezoid
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_rtrapezoid.SetItem(ll_row, "rtr_long_length", lr_1 )
		dw_rtrapezoid.SetItem(ll_row, "rtr_long_plus",  lr_2 )
		dw_rtrapezoid.SetItem(ll_row, "rtr_long_minus", lr_3 )
		dw_rtrapezoid.SetItem(ll_row, "rtr_short_length",  lr_4 )
		dw_rtrapezoid.SetItem(ll_row, "rtr_short_plus", lr_5 )
		dw_rtrapezoid.SetItem(ll_row, "rtr_short_minus",  lr_6 )		
		dw_rtrapezoid.SetItem(ll_row, "rtr_width",  lr_7 )
		dw_rtrapezoid.SetItem(ll_row, "rtr_width_plus", lr_8 )
		dw_rtrapezoid.SetItem(ll_row, "rtr_width_minus",  lr_9 )		
	CASE "REINFORCEMENT"
		ll_row = dw_reinforcement.InsertRow(0)
		dw_reinforcement.SetItem(ll_row, "order_item_num", ai_item)
		dw_reinforcement.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT re_length, re_length_plus, re_lenght_minus, re_width, re_width_plus, re_width_minus
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6
		FROM part_num_reinforcement
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_reinforcement.SetItem(ll_row, "re_length", lr_1 )
		dw_reinforcement.SetItem(ll_row, "re_length_plus",  lr_2 )
		dw_reinforcement.SetItem(ll_row, "re_length_minus", lr_3 )
		dw_reinforcement.SetItem(ll_row, "re_width",  lr_4 )
		dw_reinforcement.SetItem(ll_row, "re_width_plus", lr_5 )
		dw_reinforcement.SetItem(ll_row, "re_width_minus",  lr_6 )		
	CASE "LIFTGATE"
		ll_row = dw_liftgate_shape.InsertRow(0)
		dw_liftgate_shape.SetItem(ll_row, "order_item_num", ai_item)
		dw_liftgate_shape.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT li_length, li_length_plus, li_length_minus, li_width, li_width_plus, li_width_minus
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6
		FROM part_num_liftgate
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_liftgate_shape.SetItem(ll_row, "li_length", lr_1 )
		dw_liftgate_shape.SetItem(ll_row, "li_length_plus",  lr_2 )
		dw_liftgate_shape.SetItem(ll_row, "li_length_minus", lr_3 )
		dw_liftgate_shape.SetItem(ll_row, "li_width",  lr_4 )
		dw_liftgate_shape.SetItem(ll_row, "li_width_plus", lr_5 )
		dw_liftgate_shape.SetItem(ll_row, "li_width_minus",  lr_6 )		
		
CASE ELSE
		ll_row = dw_x1shape.InsertRow(0)
		dw_x1shape.SetItem(ll_row, "order_item_num", ai_item)
		dw_x1shape.SetItem(ll_row, "order_abc_num",  il_curent_order_id )
		SELECT x_1, x_2, x_3, x_4, x_5, x_6
		INTO  :lr_1, :lr_2, :lr_3, :lr_4, :lr_5, :lr_6
		FROM part_num_x1_shape
		WHERE part_num_id = :il_pn_id
		USING SQLCA;
		dw_liftgate_shape.SetItem(ll_row, "x_1", lr_1 )
		dw_liftgate_shape.SetItem(ll_row, "x_2",  lr_2 )
		dw_liftgate_shape.SetItem(ll_row, "x_3", lr_3 )
		dw_liftgate_shape.SetItem(ll_row, "x_4",  lr_4 )
		dw_liftgate_shape.SetItem(ll_row, "x_5", lr_5 )
		dw_liftgate_shape.SetItem(ll_row, "x_6",  lr_6 )		
END CHOOSE		
RETURN 1

end function

on w_order_entry_part_number.create
int iCurrent
call super::create
if this.MenuName = "m_order_entry" then this.MenuID = create m_order_entry
this.cb_order_entry_browse=create cb_order_entry_browse
this.cb_order_entry_print=create cb_order_entry_print
this.cb_order_entry_save=create cb_order_entry_save
this.gb_order=create gb_order
this.dw_order_coil=create dw_order_coil
this.dw_order_list=create dw_order_list
this.cb_saveas=create cb_saveas
this.cb_close=create cb_close
this.dw_order_entry_coil=create dw_order_entry_coil
this.dw_order_item_list=create dw_order_item_list
this.cb_item_del=create cb_item_del
this.cb_item_add=create cb_item_add
this.dw_job_list=create dw_job_list
this.dw_rectangle=create dw_rectangle
this.dw_chevron=create dw_chevron
this.dw_circle=create dw_circle
this.dw_fender=create dw_fender
this.dw_ltrapezoid=create dw_ltrapezoid
this.dw_x1shape=create dw_x1shape
this.dw_parallelogram=create dw_parallelogram
this.dw_trapezoid=create dw_trapezoid
this.dw_rtrapezoid=create dw_rtrapezoid
this.dw_shape=create dw_shape
this.dw_item_detail=create dw_item_detail
this.cb_job=create cb_job
this.cb_order_entry_coil=create cb_order_entry_coil
this.gb_2=create gb_2
this.dw_reinforcement=create dw_reinforcement
this.dw_liftgate_shape=create dw_liftgate_shape
this.cb_calculate=create cb_calculate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_order_entry_browse
this.Control[iCurrent+2]=this.cb_order_entry_print
this.Control[iCurrent+3]=this.cb_order_entry_save
this.Control[iCurrent+4]=this.gb_order
this.Control[iCurrent+5]=this.dw_order_coil
this.Control[iCurrent+6]=this.dw_order_list
this.Control[iCurrent+7]=this.cb_saveas
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.dw_order_entry_coil
this.Control[iCurrent+10]=this.dw_order_item_list
this.Control[iCurrent+11]=this.cb_item_del
this.Control[iCurrent+12]=this.cb_item_add
this.Control[iCurrent+13]=this.dw_job_list
this.Control[iCurrent+14]=this.dw_rectangle
this.Control[iCurrent+15]=this.dw_chevron
this.Control[iCurrent+16]=this.dw_circle
this.Control[iCurrent+17]=this.dw_fender
this.Control[iCurrent+18]=this.dw_ltrapezoid
this.Control[iCurrent+19]=this.dw_x1shape
this.Control[iCurrent+20]=this.dw_parallelogram
this.Control[iCurrent+21]=this.dw_trapezoid
this.Control[iCurrent+22]=this.dw_rtrapezoid
this.Control[iCurrent+23]=this.dw_shape
this.Control[iCurrent+24]=this.dw_item_detail
this.Control[iCurrent+25]=this.cb_job
this.Control[iCurrent+26]=this.cb_order_entry_coil
this.Control[iCurrent+27]=this.gb_2
this.Control[iCurrent+28]=this.dw_reinforcement
this.Control[iCurrent+29]=this.dw_liftgate_shape
this.Control[iCurrent+30]=this.cb_calculate
end on

on w_order_entry_part_number.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_order_entry_browse)
destroy(this.cb_order_entry_print)
destroy(this.cb_order_entry_save)
destroy(this.gb_order)
destroy(this.dw_order_coil)
destroy(this.dw_order_list)
destroy(this.cb_saveas)
destroy(this.cb_close)
destroy(this.dw_order_entry_coil)
destroy(this.dw_order_item_list)
destroy(this.cb_item_del)
destroy(this.cb_item_add)
destroy(this.dw_job_list)
destroy(this.dw_rectangle)
destroy(this.dw_chevron)
destroy(this.dw_circle)
destroy(this.dw_fender)
destroy(this.dw_ltrapezoid)
destroy(this.dw_x1shape)
destroy(this.dw_parallelogram)
destroy(this.dw_trapezoid)
destroy(this.dw_rtrapezoid)
destroy(this.dw_shape)
destroy(this.dw_item_detail)
destroy(this.cb_job)
destroy(this.cb_order_entry_coil)
destroy(this.gb_2)
destroy(this.dw_reinforcement)
destroy(this.dw_liftgate_shape)
destroy(this.cb_calculate)
end on

event open;call super::open;// Turn on the linkage service.
dw_order_list.of_SetLinkage ( TRUE ) 

//item window
dw_order_item_list.of_SetLinkage( TRUE ) 
dw_order_item_list.inv_Linkage.of_SetMaster( dw_order_list )
IF NOT dw_order_item_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & item in win w_Order_Entry!" )
ELSE
	dw_order_item_list.inv_Linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_order_item_list.inv_Linkage.of_SetStyle( 2 ) 
	dw_order_item_list.SetRowFocusIndicator(FocusRect!)
END IF

//coil window
dw_order_entry_coil.of_SetLinkage ( TRUE )
dw_order_entry_coil.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_order_entry_coil.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & coil in win w_Order_Entry!" )
ELSE
	dw_order_entry_coil.inv_linkage.of_Register( "order_abc_num", "order_coil_order_abc_num" ) 
	dw_order_entry_coil.inv_linkage.of_SetStyle( 2 ) 
	dw_order_entry_coil.SetRowFocusIndicator(FocusRect!) 
END IF

//job window
dw_job_list.of_SetLinkage ( TRUE )
dw_job_list.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_job_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & job in win w_Order_Entry!" )
ELSE
	dw_job_list.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_job_list.inv_linkage.of_SetStyle( 2 ) 
	dw_job_list.SetRowFocusIndicator(FocusRect!) 
END IF

//order_coil window
dw_order_coil.of_SetLinkage ( TRUE )
dw_order_coil.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_order_coil.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & order_coil in win w_Order_Entry!" )
ELSE
	dw_order_coil.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_order_coil.inv_linkage.of_SetStyle( 2 ) 
END IF

//order_shape
dw_x1shape.of_SetLinkage ( TRUE )
dw_x1shape.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_x1shape.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & x1shape in win w_Order_Entry!" )
ELSE
	dw_x1shape.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_x1shape.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_rectangle.of_SetLinkage ( TRUE )
dw_rectangle.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_rectangle.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & rectangle in win w_Order_Entry!" )
ELSE
	dw_rectangle.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_rectangle.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_parallelogram.of_SetLinkage ( TRUE )
dw_parallelogram.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_parallelogram.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & parallelogram in win w_Order_Entry!" )
ELSE
	dw_parallelogram.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_parallelogram.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_fender.of_SetLinkage ( TRUE )
dw_fender.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_fender.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & fender in win w_Order_Entry!" )
ELSE
	dw_fender.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_fender.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_chevron.of_SetLinkage ( TRUE )
dw_chevron.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_chevron.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & chevron in win w_Order_Entry!" )
ELSE
	dw_chevron.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_chevron.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_circle.of_SetLinkage ( TRUE )
dw_circle.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_circle.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & circle in win w_Order_Entry!" )
ELSE
	dw_circle.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_circle.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_trapezoid.of_SetLinkage ( TRUE )
dw_trapezoid.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_trapezoid.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & trapezoid in win w_Order_Entry!" )
ELSE
	dw_trapezoid.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_trapezoid.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_ltrapezoid.of_SetLinkage ( TRUE )
dw_ltrapezoid.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_ltrapezoid.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & ltrapezoid in win w_Order_Entry!" )
ELSE
	dw_ltrapezoid.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_ltrapezoid.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_rtrapezoid.of_SetLinkage ( TRUE )
dw_rtrapezoid.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_rtrapezoid.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & rtrapezoid in win w_Order_Entry!" )
ELSE
	dw_rtrapezoid.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_rtrapezoid.inv_linkage.of_SetStyle( 2 ) 
END IF

dw_reinforcement.of_SetLinkage ( TRUE )
dw_reinforcement.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_reinforcement.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & reinforcement in win w_Order_Entry!" )
ELSE
	dw_reinforcement.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_reinforcement.inv_linkage.of_SetStyle( 2 ) 
END IF


dw_liftgate_shape.of_SetLinkage ( TRUE )
dw_liftgate_shape.inv_linkage.of_SetMaster(dw_order_list)
IF NOT dw_liftgate_shape.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked order & liftgate_shape in win w_Order_Entry!" )
ELSE
	dw_liftgate_shape.inv_linkage.of_Register( "order_abc_num", "order_abc_num" ) 
	dw_liftgate_shape.inv_linkage.of_SetStyle( 2 ) 
END IF





//Set the transaction object for all datawindows in the linked chain.
//Perform the initial retrieve.
dw_order_list.inv_Linkage.of_SetTransObject(sqlca)

//cover datastores
dw_order_coil.Visible = FALSE
dw_order_entry_coil.Visible = FALSE
dw_job_list.Visible = FALSE
dw_x1shape.Visible = FALSE
dw_rectangle.Visible = FALSE
dw_parallelogram.Visible = FALSE
dw_fender.Visible = FALSE
dw_chevron.Visible = FALSE
dw_circle.Visible = FALSE
dw_trapezoid.Visible = FALSE
dw_ltrapezoid.Visible = FALSE
dw_rtrapezoid.Visible = FALSE
dw_reinforcement.Visible = FALSE
dw_liftgate_shape.Visible = FALSE
il_curent_order_id = 0

//share data
dw_order_item_list.ShareData(dw_item_detail)

//initial
il_curent_order_id = 0
il_current_customer_id = 0

//open list windows
CHOOSE CASE gl_message
	CASE 0  //new
		this.Event pfc_new()
		wf_set_item_updatable()
	CASE -1 //close
		IF il_curent_order_id > 1 THEN
			//nothing
		ELSE
			Close(this)
		END IF
	CASE ELSE
		il_old_orderid = gl_message
		this.Event ue_open_order(il_old_orderid, 0)
		wf_set_item_updatable()
END CHOOSE



end event

event resize;If IsValid (inv_resize) Then
	inv_resize.Event pfc_Resize (sizetype, This.Width, This.Height)
End If

// Store the position and size on the preference service.
// With this information the service knows the normal size of the 
// window even when the window is closed as maximized/minimized.	
If IsValid (inv_preference) And This.windowstate = normal! Then
	inv_preference.Post of_SetPosSize()
End If
end event

event pfc_postopen;call super::pfc_postopen;// default to dw_order_list
ii_active_dw = 1
end event

event pfc_print;Int li_rc
Long ll_order, ll_row
IF dw_order_list.inv_linkage.of_GetUpdatespending() = 1 THEN
	li_rc = MessageBox("Question", "Save current order first?", Question!, YesNo!, 2)
	IF li_rc = 1 THEN 
		IF this.Event pfc_Save() < 0 THEN 
			MessageBox("Error", "Failed to save current order!", StopSign! )
			Return -1
		END IF
	END IF
END IF

ll_row = dw_order_list.GetRow()
IF ll_row < 1 THEN RETURn -2
ll_order = dw_order_list.GetItemNumber(ll_row, "order_abc_num", Primary!, FALSE)

RETURN openwithparm(w_report_order_entry, ll_order)
end event

event pfc_new;Int li_rc
IF dw_order_list.inv_linkage.of_GetUpdatespending() = 1 THEN
	li_rc = MessageBox("Question", "Save current order first?", Question!, YesNoCancel!, 1)
	IF li_rc = 3 THEN Return	
	IF li_rc = 1 THEN 
		IF this.Event pfc_Save() < 0 THEN Return
	END IF
END IF

dw_order_list.DBCancel()
//dw_order_list.inv_linkage.of_Reset()
dw_order_item_list.ShareDataOff()
dw_order_entry_coil.ShareDataOff()
dw_order_list.inv_linkage.of_reset()
dw_item_detail.Reset()
dw_job_list.Reset()
//redo sharedata
dw_order_item_list.ShareData(dw_item_detail)

dw_order_list.Event pfc_AddRow()


end event

event pfc_save;SetPointer(HourGlass!)

Int li_return, li_i
Long ll_row
string li_po, li_so

//li_po = 

/*
ll_row = dw_order_list.GetRow()
IF ll_row <= 0 THEN 
	MessageBox("Error", "InValid order entry information", StopSign! )
	Return -1
END IF

*/


IF wf_duplicated_coil() < 0 THEN
	MessageBox("Info", "Failed to save current information!")
	Return -1
END IF
IF wf_check_coil_wt() < 0 THEN
	MessageBox("Info", "Failed to save current information!")
	Return -2
END IF
IF wf_check_coil_assigned() < 0 THEN
	MessageBox("Info", "Failed to save current information!")
	Return -3
END IF






dw_order_item_list.AcceptText()
IF dw_order_item_list.RowCount() < 1 THEN
	IF MessageBox("Question", "Order has not item to save here, Continue?", Question!, YesNo!, 1) <> 1 THEN RETURN -6
END IF


//check sales_order and orig_customer_po
dw_order_list.AcceptText()
li_po = dw_order_list.GetItemString(1,"orig_customer_po") //Primary!, false)
li_so = dw_order_list.GetItemString(1,"sales_order") //Primary!, false)

if (isNull(li_po) or li_po = "") then
	MessageBox("Info", "You must enter Customer_PO!")
	return -1
end if

if ((isNull(li_po) or li_po = "") and (isNull(li_so) or li_so = "")) then
	MessageBox("Info", "You must enter either Customer_PO or Sales_Order!")
	return -1
end if




//check order
IF wf_check_order_info() < 0 THEN RETURN -4

//pieces per skid
wf_pieces_per_skid()

//unlink one coil table
dw_order_entry_coil.AcceptText()
dw_order_entry_coil.ResetUpdate()

//save other information
dw_order_list.inv_linkage.of_AcceptText(TRUE)
li_return = dw_order_list.inv_linkage.of_UpdateBottomUpAndTopDown()
IF li_return <> 1 THEN
	ROLLBACK USING SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN 
		MessageBox("Rollback Error", SQLCA.SQLErrText)
	ELSE
		MessageBox("Update Failed", "ROLLBACK Succeeded")
	END IF
ELSE
	COMMIT USING SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText)
		RETURN -5
	END IF
	dw_shape.AcceptText()
	dw_shape.ResetUpdate()
	dw_item_detail.AcceptText()
	dw_item_detail.ResetUpdate()
	dw_order_list.inv_linkage.of_acceptText()
	dw_order_list.inv_linkage.of_ResetUpdate()
	
	IF UpperBound(il_coilnew) > 0 THEN
		FOR li_i = 1 TO UpperBound(il_coilnew) 
			il_coilnew[li_i] = 0
		NEXT
	END IF
	
END IF

RETURN 1
end event

event activate;call super::activate;IF f_security_door("Order Entry") = 1 THEN RETURN 1
This.Event ue_read_only()
end event

event close;call super::close;f_display_app()
end event

event pfc_saveas;Long ll_order

ll_order = this.Event ue_new()
IF ll_order < 1 THEN
	MessageBox("Info", "Failed to save as a new customer order.")
END IF
end event

type cb_order_entry_browse from u_cb within w_order_entry_part_number
string tag = "Open a  existing order"
integer x = 263
integer y = 1866
integer width = 307
integer height = 77
integer taborder = 120
boolean bringtotop = true
string facename = "Arial"
string text = "&Open"
end type

event clicked;call super::clicked;Parent.Event ue_open()
end event

type cb_order_entry_print from u_cb within w_order_entry_part_number
string tag = "Print current order"
integer x = 2052
integer y = 1866
integer width = 307
integer height = 77
integer taborder = 160
boolean bringtotop = true
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_order_entry_save from u_cb within w_order_entry_part_number
string tag = "Save order info"
integer x = 713
integer y = 1866
integer width = 307
integer height = 77
integer taborder = 140
boolean bringtotop = true
string facename = "Arial"
string text = "&Save"
end type

event clicked;RETURN Parent.Event ue_save()
	
end event

type gb_order from u_gb within w_order_entry_part_number
string tag = "Order Information"
integer x = 26
integer width = 3387
integer height = 336
integer taborder = 0
string facename = "Arial"
long backcolor = 79741120
string text = "Customer Order"
borderstyle borderstyle = styleraised!
end type

type dw_order_coil from u_dw within w_order_entry_part_number
event ue_deleteall ( )
event type integer ue_deleterow ( long al_coil_num )
event ue_getrow ( long al_coil_num )
boolean visible = false
integer x = 3288
integer y = 1898
integer width = 113
integer height = 42
integer taborder = 0
boolean enabled = false
string dataobject = "d_coil_per_order_en"
boolean livescroll = false
end type

event ue_deleteall;call super::ue_deleteall;Long ll_row, ll_i
ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		this.deleterow(ll_i)
	NEXT
END IF

end event

event ue_deleterow;call super::ue_deleterow;Long ll_row, ll_i
ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF GetItemNumber(ll_i, "coil_abc_num") = al_coil_num THEN
			this.deleterow(ll_i)
			Return 1
		END IF
	NEXT
END IF

Return 0
end event

event ue_getrow;call super::ue_getrow;long	ll_rc

// Insert row
if IsValid (inv_rowmanager) then
	ll_rc = inv_rowmanager.event pfc_addrow ()
else
	ll_rc = this.InsertRow (0) 
end if

// Notify the Linkage Service that a new row has been added.
IF IsValid ( inv_Linkage ) THEN 
	inv_Linkage.Event pfc_InsertRow (ll_rc) 
END IF 

//fill values
IF ll_rc > 0 THEN
		this.SetItem(ll_rc, "coil_abc_num", al_coil_num)
		this.SetItem(ll_rc, "order_abc_num",  il_curent_order_id )
END IF



end event

event pfc_addrow;call super::pfc_addrow;Long ll_coil_row, ll_coil_num, ll_this_row

ll_this_row = this.GetRow()
ll_coil_row = dw_order_entry_coil.Getrow()
IF ll_coil_row > 0 THEN
	ll_coil_num = dw_order_entry_coil.GetItemNumber(ll_coil_row,"coil_abc_num")
	IF ll_coil_num > 0 THEN
		this.SetItem(ll_this_row, "coil_abc_num", ll_coil_num)
		this.SetItem(ll_this_row, "order_abc_num",  il_curent_order_id )
	END IF
END IF
Return ll_this_row


end event

event rbuttondown;//Override
Return 1
end event

event rbuttonup;//Override
Return 1
end event

type dw_order_list from u_dw within w_order_entry_part_number
string tag = "List orders"
integer x = 51
integer y = 45
integer width = 3346
integer height = 275
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_order_entry_order_detail"
boolean vscrollbar = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve (il_curent_order_id)





end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	IF il_current_customer_id <= 0 THEN Return -1
	
	Return dddw_cni.Retrieve() 
END IF
end event

event pfc_addrow;call super::pfc_addrow;long ll_new_id, ll_cust_id, ll_enduser_id
String ls_sheet, ls_enduser_part  
Long ll_row
Integer li_rc

ll_new_id = f_get_next_value("order_abc_num_seq")
il_curent_order_id = ll_new_id

ll_row = GetRow()
li_rc = SetItem(ll_row,"order_abc_num",ll_new_id )
li_rc = SetItem(ll_row,"Created_date", Today() )

//retrieve part number info
Open(w_order_entry_pn_list)
il_pn_id = Message.DoubleParm

IF il_pn_id > 0 THEN //copy part number info
	CONNECT USING SQLCA;
	SELECT customer_id, enduser_id, enduser_part_num
	INTO :ll_cust_id, :ll_enduser_id, :ls_enduser_part
	FROM Part_num
	WHERE part_num_id = :il_pn_id
	USING SQLCA;
	
	IF isNULL(ll_cust_id) THEN 
		li_rc = SetItem(ll_row,"orig_customer_id",0 )
	ELSE
		li_rc = SetItem(ll_row,"orig_customer_id",ll_cust_id )
	END IF
	
	IF isNULL(ll_enduser_id) THEN
		li_rc = SetItem(ll_row,"enduser_id", 0 )	
	ELSE
		li_rc = SetItem(ll_row,"enduser_id", ll_enduser_id )
	END IF
	

	dw_order_item_list.Event ue_add_pn_item(il_pn_id)
ELSE //no pn selected
	MessageBox("Warning", "No part number selected. Using default info here.")
	li_rc = SetItem(ll_row,"orig_customer_id",0 )
	li_rc = SetItem(ll_row,"enduser_id", 0 )
	li_rc = SetItem(ll_row,"term", "30")
	li_rc = SetItem(ll_row,"scrap_handing_type", "Accumulated")
	li_rc = SetItem(ll_row,"sheet_handling_type", 0)
	li_rc = SetItem(ll_row,"order_contact_id", 1003)
	li_rc = SetItem(ll_row,"cust_order_line_note", 0)
	li_rc = SetItem(ll_row,"cust_order_note","New order" )	
END IF
this.Event GetFocus()

Return ll_new_id

end event

event itemfocuschanged;call super::itemfocuschanged;String ls_colName
Long ll_row, ll_id

ls_ColName = this.GetColumnName()
IF ls_ColName = "order_contact_id" THEN
	Parent.Event ue_Pick_contacts()
END IF

IF ls_ColName = "orig_customer_id" THEN
	ll_row = dw_order_entry_coil.RowCount()
	IF ll_row > 0 THEN
		MessageBox("Warning","Selecting a different customer will reset coil infromation in this order!", StopSign! )
	END IF
END IF



end event

event getfocus;call super::getfocus;ii_active_dw = 1
end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
Return 0
end event

event itemchanged;call super::itemchanged;String ls_colName
Long ll_id, ll_row

SetNull(ll_id)
ls_ColName = this.GetColumnName()
IF ls_ColName = "orig_customer_id" THEN
	ll_row = this.GetRow()
	this.SetItem(ll_row,"order_contact_id" , ll_id)
	dw_order_entry_coil.Event ue_change_customer()
	dw_order_coil.Event ue_deleteall()
END IF

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

type cb_saveas from u_cb within w_order_entry_part_number
string tag = "duplicate order info"
integer x = 1159
integer y = 1866
integer width = 307
integer height = 77
integer taborder = 150
boolean bringtotop = true
string facename = "Arial"
boolean enabled = false
string text = "D&uplicate"
end type

event clicked;if messagebox("Save", "About to Save order information as a new customer order.",&
             Question!, OkCancel!,2) <> 1 then
   Return 0
else
	Parent.Event pfc_Saveas()
end if

RETURN 1
	
	
end event

type cb_close from u_cb within w_order_entry_part_number
string tag = "Exit"
integer x = 2944
integer y = 1866
integer width = 307
integer height = 77
integer taborder = 180
boolean bringtotop = true
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type dw_order_entry_coil from u_dw within w_order_entry_part_number
event type integer ue_add_existing_coil ( long al_coil_num )
event type integer ue_change_customer ( )
event type integer ue_del_row ( long al_coil )
boolean visible = false
integer x = 201
integer y = 1882
integer width = 55
integer height = 42
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_coil_order_entry_list_en"
boolean hscrollbar = true
end type

event ue_add_existing_coil;long	ll_rc, ll_rowcount, ll_row, ll_coil

ll_rowcount = this.RowCount()
IF ll_rowcount > 0 THEN
	FOR ll_row = 1 TO ll_rowcount
		ll_coil = this.GetItemNumber(ll_row, "coil_abc_num")
		IF ll_coil = al_coil_num THEN
			MessageBox("Error","Coil had already been asigned to this order", StopSign!)
			Return 0
		END IF
	NEXT
END IF

// Insert row
if IsValid (inv_rowmanager) then
	ll_rc = inv_rowmanager.event pfc_addrow ()
else
	ll_rc = this.InsertRow (0) 
end if

// Notify the Linkage Service that a new row has been added.
IF IsValid ( inv_Linkage ) THEN 
	inv_Linkage.Event pfc_InsertRow (ll_rc) 
END IF 

this.SetItem(ll_rc, "coil_abc_num", al_coil_num)

Long ll_1, ll_2, ll_3, ll_4, ll_5
String ls_0, ls_1, ls_2, ls_3, ls_4, ls_5, ls_6, ls_7
Int li_1, li_2, li_3, li_4
Real lr_1, lr_2
DATE ld_1, ld_2
CONNECT USING SQLCA;
SELECT coil_org_num, icra, coil_mid_num, coil_status, coil_alloy2, coil_temper, lot_num, coil_gauge, coil_width, date_received, coil_entry_date, net_wt, pieces_per_case, coil_location, net_wt_balance, coil_notes, coil_line_num, customer_id, coil_from_cust_id
INTO :ls_0, :ls_1, :ls_2, :li_1, :ls_7, :ls_3, :ls_4, :lr_1, :lr_2, :ld_1, :ld_2, :ll_2, :li_3, :ls_5, :ll_3, :ls_6, :li_4, :ll_4, :ll_5
FROM coil
WHERE coil_abc_num = :al_coil_num;

this.SetItem(ll_rc, "coil_coil_org_num", ls_0)
this.SetItem(ll_rc, "coil_icra", ls_1)
this.SetItem(ll_rc, "coil_coil_mid_num", ls_2)
this.SetItem(ll_rc, "coil_coil_status", li_1)
this.SetItem(ll_rc, "coil_coil_alloy2", ls_7)
this.SetItem(ll_rc, "coil_coil_temper", ls_3)
this.SetItem(ll_rc, "coil_lot_num", ls_4)
this.SetItem(ll_rc, "coil_coil_gauge", lr_1)
this.SetItem(ll_rc, "coil_coil_width", lr_2)
this.SetItem(ll_rc, "coil_date_received", ld_1)
this.SetItem(ll_rc, "coil_coil_entry_date", ld_2)
this.SetItem(ll_rc, "coil_net_wt", ll_2)
this.SetItem(ll_rc, "coil_pieces_per_case", li_3)
this.SetItem(ll_rc, "coil_coil_location", ls_5)
this.SetItem(ll_rc, "coil_net_wt_balance", ll_3)
this.SetItem(ll_rc, "coil_coil_notes", ls_6)
this.SetItem(ll_rc, "coil_coil_line_num", li_4)
this.SetItem(ll_rc, "coil_customer_id", ll_4)
this.SetItem(ll_rc, "coil_coil_from_cust_id", ll_5)

Return 1
end event

event ue_change_customer;this.reset()
Return 1
end event

event ue_del_row;Long ll_row, ll_i
ll_row = this.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF GetItemNumber(ll_i, "coil_abc_num") = al_coil THEN
			this.deleterow(ll_i)
			Return 1
		END IF
	NEXT
END IF
RETURN 0

end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetMultiTable ( TRUE ) 

string	ls_table
string	ls_keycols[]

// ------ Register the Updtates. ---------
ls_table = "coil"
ls_keycols[1] = "coil_abc_num"
this.inv_MultiTable.of_Register(ls_table, ls_keycols ) 

ls_table = "order_coil"
ls_keycols[1] = "coil_abc_num"
ls_keycols[2] = "order_abc_num"
this.inv_MultiTable.of_Register(ls_table, ls_keycols ) 


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

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event getfocus;call super::getfocus;ii_active_dw = 3

end event

event pfc_addrow;call super::pfc_addrow;long ll_row_coil, ll_row_cut,ll_c_id, ll_new_id, ll_row_item
String ls_alloy
Real lr_gauge
String ls_temper

ll_row_coil = this.GetRow()
ll_row_cut = dw_order_list.GetRow()
IF ll_row_cut <= 0 THEN
	MessageBox("Error", "No order specified above!" )
	this.Event pfc_deleterow()
	Return 0
END IF
ll_c_id = dw_order_list.GetItemNumber(ll_row_cut, "Orig_customer_id", Primary!, FALSE)
IF ll_c_id <= 0 THEN
	MessageBox("Error", "No customer specified above!" )
	this.Event pfc_deleterow()
	Return 0
END IF
SetItem(ll_row_coil, "coil_customer_id", ll_c_id)
//ll_new_id = wf_next_coil_id()
ll_new_id = f_get_next_value("coil_abc_num_seq")
SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
SetItem(ll_row_coil,"order_coil_coil_abc_num", ll_new_id )
setItem(ll_row_coil, "coil_coil_entry_date", Today() )
setItem(ll_row_coil, "coil_coil_status", 5 )  //coming but not availiable new coil
setItem(ll_row_coil, "coil_net_wt", 0 )

ll_row_item = dw_order_item_list.GetRow()
IF ll_row_item > 0 THEN 
	ls_alloy = dw_order_item_list.GetItemstring(ll_row_item, "alloy2", Primary!, FALSE)
	ls_temper = dw_order_item_list.GetItemString(ll_row_item, "temper",Primary!, FALSE)
	lr_gauge = dw_order_item_list.GetItemNumber(ll_row_item, "gauge",Primary!, FALSE)
	setItem(ll_row_coil, "coil_coil_alloy", ls_alloy )  
	setItem(ll_row_coil, "coil_coil_temper", ls_temper )  
	setItem(ll_row_coil, "coil_coil_gauge", lr_gauge )  
END IF

Return ll_new_id
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type dw_order_item_list from u_dw within w_order_entry_part_number
event ue_add_item ( )
event ue_del_item ( )
event ue_add_pn_item ( long al_pn_id )
integer x = 51
integer y = 384
integer width = 3024
integer height = 221
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_order_entry_item_list"
boolean livescroll = false
end type

event ue_add_item;Long ll_row, ll_i, nulllong
Int li_item
String ls_shape, nullstring
DataStore lds_temp

SetNull(nulllong)
SetNull(nullstring)


ll_row = dw_order_list.GetRow()
IF ll_row > 0 THEN
	IF this.RowCount() = 0 THEN
		IF (il_old_orderid > 0) and il_curent_order_id <> il_old_orderid THEN
			lds_temp = CREATE DataStore
			lds_temp.DataObject = "d_order_entry_item_list"  
			lds_temp.SetTransObject (SQLCA)
			lds_temp.retrieve(il_old_orderid)
			lds_temp.RowsCopy(1, lds_temp.RowCount(), Primary!, this, 1, Primary!)
			DESTROY lds_temp
			FOR ll_i = 1 TO This.RowCount()
				This.SetItem(ll_i,"order_abc_num", il_curent_order_id )
				//Added by Victor Huang in 05/04 for not allow to copy 5 critical spec data: tempar, alloy, gauge, length, width
				This.SetItem(ll_i,"alloy2", nullstring)	
				This.SetItem(ll_i,"temper", nullstring)
				This.SetItem(ll_i,"gauge", nulllong)
				This.SetItem(ll_i,"gauge_p", nulllong)
				This.SetItem(ll_i,"gauge_m", nulllong)
				
  				li_item = This.GetItemNumber(ll_i, "order_item_num", Primary!, FALSE)
				ls_shape = This.GetItemString(ll_i, "sheet_type", Primary!, FALSE)
			NEXT
			wf_copy_item_shape()
		ELSE
			this.Event pfc_addrow()
		END IF
	ELSE
		this.Event pfc_addrow()
	END IF

	dw_shape.Event ue_show_shape()

ELSE
	MessageBox("Warning", "NO order specified")
END IF

end event

event ue_del_item;Long ll_row
Int li_item

ll_row = this.GetRow()
IF ll_row > 0 THEN 
	if messagebox("Delete", "About to delete item.", Question!, OkCancel!,1)<>1 then
  		 Return
	else
		li_item = this.GetItemNumber(ll_row,"order_item_num", Primary!, FALSE)
		wf_delete_item_shape(li_item)
		this.DeleteRow(ll_row)
	end if
ELSE
	MessageBox("Warning", "No item specified")
END IF

end event

event ue_add_pn_item(long al_pn_id);Long ll_row

ll_row = dw_order_list.GetRow()
IF ll_row > 0 THEN
	this.Event pfc_addrow()
END IF
dw_shape.Event ue_show_shape()



end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 


end event

event itemchanged;call super::itemchanged;String ls_colName, ls_shape
Long ll_id, ll_row
Int li_item

SetNull(ll_id)
ls_ColName = this.GetColumnName()
IF ls_ColName = "sheet_type" THEN
	this.AcceptText()
	ll_row = this.GetRow()
	li_item = this.GetItemNumber(ll_row, "order_item_num", Primary!, FALSE)
	ls_shape = this.GetItemString(ll_row, "sheet_type", Primary!, FALSE)
	wf_changing_item_shape(li_item, ls_shape)
	dw_shape.Event ue_show_shape()

END IF

end event

event rbuttondown;//Override
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//Override
Return 0
end event

event pfc_addrow;call super::pfc_addrow;Long ll_row
Int li_item_num, li_i, li_allrow, li_max, li_temp
Real lr_gauge, lr_gaugep, lr_gaugem
String ls_shape, nullstring, ls_alloy, ls_temper, ls_ps1, ls_ps2, ls_ps3, ls_ps4, ls_ps5, ls_ps6, ls_ps7, ls_psb, ls_pos

ll_row = this.GetRow()
IF ll_row <= 0 THEN Return -1
li_allrow = this.RowCount()
li_item_num = 0
FOR li_i = 1 TO li_allrow
	li_temp = this.GetItemnumber(li_i, "order_item_num", Primary!, FALSE)
	IF IsNULL(li_temp) THEN li_temp = 0
	li_item_num = MAX(li_item_num, li_temp) 
NEXT
li_item_num = li_item_num + 1

This.SetItem(ll_row,"order_item_num",li_item_num) 
This.SetItem(ll_row,"item_status",2 ) 
This.SetItem(ll_row,"order_abc_num", il_curent_order_id )
IF il_pn_id > 0 THEN //copy
		CONNECT USING SQLCA;
		SELECT sheet_type, alloy, temper, gauge, gauge_p, gauge_m, packaging_spec1,packaging_spec2,packaging_spec3,packaging_spec4,packaging_spec5,packaging_spec6,packaging_spec7,packaging_bands,packaging_other_spec
		INTO :ls_shape, :ls_alloy, :ls_temper, :lr_gauge, :lr_gaugep, :lr_gaugem, :ls_ps1, :ls_ps2,:ls_ps3, :ls_ps4, :ls_ps5, :ls_ps6, :ls_ps7, :ls_psb, :ls_pos
		FROM Part_num
		WHERE part_num_id = :il_pn_id
		USING SQLCA;

		This.SetItem(ll_row, "sheet_type", ls_shape)
		This.SetItem(ll_row,"alloy2", ls_alloy)	
		This.SetItem(ll_row,"temper", ls_temper)
		This.SetItem(ll_row,"gauge", lr_gauge)
		This.SetItem(ll_row,"gauge_p", lr_gaugep)
		This.SetItem(ll_row,"gauge_m", lr_gaugem)
		This.SetItem(ll_row,"packaging_spec1", ls_ps1)
		This.SetItem(ll_row,"packaging_spec2", ls_ps2)
		This.SetItem(ll_row,"packaging_spec3", ls_ps3)
		This.SetItem(ll_row,"packaging_spec4", ls_ps4)
		This.SetItem(ll_row,"packaging_spec5", ls_ps5)
		This.SetItem(ll_row,"packaging_spec6", ls_ps6)
		This.SetItem(ll_row,"packaging_spec7", ls_ps7)
		This.SetItem(ll_row,"packaging_bands", ls_psb)
		This.SetItem(ll_row,"packaging_other_spec", ls_pos)
				
		wf_add_pn_shape(ls_shape, li_item_num)
ELSE //new
	This.SetItem(ll_row, "sheet_type", "Rectangle")
	wf_add_item_shape(li_item_num, "RECTANGLE ")
END IF
RETURN 1
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

dw_item_detail.ScrollToRow(li_row)
dw_shape.Event ue_show_shape()

Return 

end event

type cb_item_del from u_cb within w_order_entry_part_number
string tag = "delete item"
integer x = 3076
integer y = 458
integer width = 296
integer height = 64
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete"
end type

event clicked;dw_order_item_list.Event ue_del_item()
end event

type cb_item_add from u_cb within w_order_entry_part_number
string tag = "add item"
integer x = 3076
integer y = 381
integer width = 296
integer height = 64
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Add"
end type

event clicked;IF MessageBox("Question", "Do you want to use an existing part number?", Question!, YesNO!, 1 ) = 1 THEN 
	//retrieve part number info
	Open(w_order_entry_pn_list)
	il_pn_id = Message.DoubleParm
	IF il_pn_id > 0 THEN 
		dw_order_item_list.Event ue_add_pn_item(il_pn_id)
	END IF
ELSE
	il_pn_id = 0
	dw_order_item_list.Event ue_add_item()	
END IF



end event

type dw_job_list from u_dw within w_order_entry_part_number
boolean visible = false
integer x = 3280
integer y = 1856
integer width = 121
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_order_entry_job_list"
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

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event doubleclicked;IF (row < 1) OR IsNULL(row) THEN Return 0

gl_message = this.GetItemNumber(row, "ab_job_num" )

IF gl_message > 0 THEN 
	SetPointer(HourGlass!)
	Message.StringParm = "w_production" 
	gnv_app.of_getFrame().Event pfc_open()
END IF

RETURN 1
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type dw_rectangle from u_dw within w_order_entry_part_number
integer x = 2823
integer y = 1923
integer width = 51
integer height = 45
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_rectangle_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_chevron from u_dw within w_order_entry_part_number
integer x = 647
integer y = 1869
integer width = 59
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_chevron_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_circle from u_dw within w_order_entry_part_number
integer x = 1061
integer y = 1917
integer width = 66
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_circle_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_fender from u_dw within w_order_entry_part_number
integer x = 1057
integer y = 1859
integer width = 73
integer height = 45
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_fender_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_ltrapezoid from u_dw within w_order_entry_part_number
integer x = 1712
integer y = 1901
integer width = 51
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_ltrapezoid_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_x1shape from u_dw within w_order_entry_part_number
integer x = 1715
integer y = 1859
integer width = 40
integer height = 42
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_x1shape_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_parallelogram from u_dw within w_order_entry_part_number
integer x = 2428
integer y = 1891
integer width = 40
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_parallelogram_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_trapezoid from u_dw within w_order_entry_part_number
integer x = 2823
integer y = 1859
integer width = 51
integer height = 35
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_trapezoid_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_rtrapezoid from u_dw within w_order_entry_part_number
integer x = 1993
integer y = 1866
integer width = 51
integer height = 42
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_rtrapezoid_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_shape from u_dw within w_order_entry_part_number
event ue_show_shape ( )
integer x = 2289
integer y = 608
integer width = 1079
integer height = 1229
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trapezoid"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_show_shape;Long ll_row
String ls_shape
Int li_item, li_totalrow, li_i, li_row

ll_row = dw_order_item_list.GetRow()
IF ll_row < 1 THEN RETURN
ls_shape = dw_order_item_list.GetItemString(ll_row, "sheet_type", PRIMARY!, FALSE)
li_item = dw_order_item_list.GetItemNumber(ll_row, "order_item_num", PRIMARY!, FALSE)

//messagebox("test", ls_shape)

CHOOSE CASE Upper(Trim(ls_shape))
	CASE "RECTANGLE"
		this.DataObject = "d_rectangle"
		dw_rectangle.ShareData(this)
		li_totalrow = dw_rectangle.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_rectangle.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "PARALLELOGRAM"
		this.DataObject = "d_parallelogram"
		dw_parallelogram.ShareData(this)
		li_totalrow = dw_parallelogram.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_parallelogram.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "FENDER"
		this.DataObject = "d_fender"
		dw_fender.ShareData(this)
		li_totalrow = dw_fender.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_fender.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "CHEVRON"
		this.DataObject = "d_chevron"
		dw_chevron.ShareData(this)
		li_totalrow = dw_chevron.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_chevron.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "CIRCLE"
		this.DataObject = "d_circle"
		dw_circle.ShareData(this)
		li_totalrow = dw_circle.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_circle.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "TRAPEZOID"
		this.DataObject = "d_trapezoid"
		dw_trapezoid.ShareData(this)
		li_totalrow = dw_trapezoid.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_trapezoid.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "L.TRAPEZOID"
		this.DataObject = "d_ltrapezoid"
		dw_ltrapezoid.ShareData(this)
		li_totalrow = dw_ltrapezoid.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_ltrapezoid.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "R.TRAPEZOID"
		this.DataObject = "d_rtrapezoid"
		dw_rtrapezoid.ShareData(this)
		li_totalrow = dw_rtrapezoid.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_rtrapezoid.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "REINFORCEMENT"
		this.DataObject = "d_reinforcement"
		dw_reinforcement.ShareData(this)
		li_totalrow = dw_reinforcement.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_reinforcement.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
	CASE "LIFTGATE"
		this.DataObject = "d_liftgate_shape"
		dw_liftgate_shape.ShareData(this)
		li_totalrow = dw_liftgate_shape.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_liftgate_shape.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
		
CASE ELSE
		this.DataObject = "d_x1shape"
		dw_x1shape.ShareData(this)
		li_totalrow = dw_x1shape.RowCount()
		FOR li_i = 1 TO li_totalrow 
			IF dw_x1shape.GetItemNumber(li_i, "order_item_num", Primary!, FALSE ) = li_item THEN li_row = li_i
		NEXT
		this.ScrollToRow(li_row)
END CHOOSE		


end event

event losefocus;AcceptText()
end event

type dw_item_detail from u_dw within w_order_entry_part_number
integer x = 51
integer y = 608
integer width = 2242
integer height = 1232
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_order_item_detail"
boolean livescroll = false
end type

event itemfocuschanged;call super::itemfocuschanged;AcceptText()
end event

event losefocus;AcceptText()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

type cb_job from u_cb within w_order_entry_part_number
string tag = "Production Order"
integer x = 3076
integer y = 528
integer width = 296
integer height = 64
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Job..."
end type

event clicked;Long ll_r
s_order_and_item lstr_s

ll_r = dw_order_item_list.GetRow()
IF ll_r < 1 THEN 
	MessageBox("Info", "Select a customer order item first.")
	RETURN -1
END IF
lstr_s.item_num = dw_order_item_list.GetItemNumber(ll_r, "order_item_num", Primary!, FALSE)
lstr_s.order_num = il_curent_order_id

OpenwithParm(w_order_entry_job_list, lstr_s)
end event

type cb_order_entry_coil from u_cb within w_order_entry_part_number
string tag = "Coil list for current order"
integer x = 2498
integer y = 1866
integer width = 307
integer height = 77
integer taborder = 170
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Coil..."
end type

event clicked;OpenwithParm(w_order_entry_coil_list, dw_order_entry_coil)
//wf_total_coil_wt()
end event

type gb_2 from groupbox within w_order_entry_part_number
integer x = 26
integer y = 336
integer width = 3394
integer height = 1514
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Order Item"
borderstyle borderstyle = styleraised!
end type

type dw_reinforcement from u_dw within w_order_entry_part_number
integer x = 33
integer y = 1869
integer width = 48
integer height = 42
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_reinforcement_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type dw_liftgate_shape from u_dw within w_order_entry_part_number
integer x = 135
integer y = 1866
integer width = 55
integer height = 48
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_liftgate_shape_data"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

type cb_calculate from u_cb within w_order_entry_part_number
string tag = "duplicate order info"
integer x = 1605
integer y = 1866
integer width = 307
integer height = 77
integer taborder = 20
boolean bringtotop = true
string facename = "Arial"
string text = "Calc&ulate"
end type

event clicked;Parent.Event ue_calculate()
end event

