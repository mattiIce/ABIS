$PBExportHeader$w_qa_coil_bk.srw
forward
global type w_qa_coil_bk from w_sheet
end type
type dw_customer from u_dw within w_qa_coil_bk
end type
type cb_6 from commandbutton within w_qa_coil_bk
end type
type cb_5 from commandbutton within w_qa_coil_bk
end type
type cb_4 from commandbutton within w_qa_coil_bk
end type
type cb_cancel from u_cb within w_qa_coil_bk
end type
type cb_save from u_cb within w_qa_coil_bk
end type
type dw_coil_modify from u_dw within w_qa_coil_bk
end type
type cb_delete_pic from u_cb within w_qa_coil_bk
end type
type cb_add_pic from u_cb within w_qa_coil_bk
end type
type dw_coil_pic from u_dw within w_qa_coil_bk
end type
type dw_coil_history from u_dw within w_qa_coil_bk
end type
type st_13 from statictext within w_qa_coil_bk
end type
type dw_coil_list from u_dw within w_qa_coil_bk
end type
type rb_all from u_rb within w_qa_coil_bk
end type
type rb_current from u_rb within w_qa_coil_bk
end type
type ddlb_customer from dropdownlistbox within w_qa_coil_bk
end type
type st_1 from statictext within w_qa_coil_bk
end type
type gb_2 from u_gb within w_qa_coil_bk
end type
type gb_1 from u_gb within w_qa_coil_bk
end type
type gb_4 from groupbox within w_qa_coil_bk
end type
end forward

global type w_qa_coil_bk from w_sheet
integer width = 3822
integer height = 2282
event ue_read_only ( )
dw_customer dw_customer
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_cancel cb_cancel
cb_save cb_save
dw_coil_modify dw_coil_modify
cb_delete_pic cb_delete_pic
cb_add_pic cb_add_pic
dw_coil_pic dw_coil_pic
dw_coil_history dw_coil_history
st_13 st_13
dw_coil_list dw_coil_list
rb_all rb_all
rb_current rb_current
ddlb_customer ddlb_customer
st_1 st_1
gb_2 gb_2
gb_1 gb_1
gb_4 gb_4
end type
global w_qa_coil_bk w_qa_coil_bk

event ue_read_only();dw_coil_modify.Object.DataWindow.ReadOnly = "YES"
cb_save.Enabled = FALSE
cb_cancel.Enabled = FALSE
cb_add_pic.Enabled = FALSE
cb_delete_pic.Enabled = FALSE
end event

on w_qa_coil_bk.create
int iCurrent
call super::create
this.dw_customer=create dw_customer
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_coil_modify=create dw_coil_modify
this.cb_delete_pic=create cb_delete_pic
this.cb_add_pic=create cb_add_pic
this.dw_coil_pic=create dw_coil_pic
this.dw_coil_history=create dw_coil_history
this.st_13=create st_13
this.dw_coil_list=create dw_coil_list
this.rb_all=create rb_all
this.rb_current=create rb_current
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_customer
this.Control[iCurrent+2]=this.cb_6
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.dw_coil_modify
this.Control[iCurrent+8]=this.cb_delete_pic
this.Control[iCurrent+9]=this.cb_add_pic
this.Control[iCurrent+10]=this.dw_coil_pic
this.Control[iCurrent+11]=this.dw_coil_history
this.Control[iCurrent+12]=this.st_13
this.Control[iCurrent+13]=this.dw_coil_list
this.Control[iCurrent+14]=this.rb_all
this.Control[iCurrent+15]=this.rb_current
this.Control[iCurrent+16]=this.ddlb_customer
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_4
end on

on w_qa_coil_bk.destroy
call super::destroy
destroy(this.dw_customer)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_coil_modify)
destroy(this.cb_delete_pic)
destroy(this.cb_add_pic)
destroy(this.dw_coil_pic)
destroy(this.dw_coil_history)
destroy(this.st_13)
destroy(this.dw_coil_list)
destroy(this.rb_all)
destroy(this.rb_current)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_4)
end on

event activate;call super::activate;IF f_security_door("Quality Control") = 1 THEN RETURN 1
//This.Event ue_read_only()
end event

event open;call super::open;dw_coil_list.SetTransObject(SQLCA)
dw_coil_history.SetTransObject(SQLCA)
dw_coil_modify.SetTransObject(SQLCA)
dw_coil_pic.SetTransObject(SQLCA)

dw_customer.Visible = FALSE
dw_customer.Retrieve()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)

dw_coil_list.of_SetLinkage(TRUE)
dw_coil_list.inv_linkage.of_SetConfirmOnRowChange (True)
dw_coil_list.inv_linkage.of_setUpdateOnRowChange (TRUE)

dw_coil_history.of_SetLinkage( TRUE ) 
dw_coil_history.inv_Linkage.of_SetMaster(dw_coil_list)
IF NOT dw_coil_history.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link coil & coil history in win w_qa_coil" )
ELSE
	dw_coil_history.inv_Linkage.of_Register( "coil_abc_num", "coil_abc_num" ) 
	dw_coil_history.inv_Linkage.of_SetStyle( dw_coil_history.inv_linkage.RETRIEVE )
END IF

dw_coil_modify.of_SetLinkage( TRUE ) 
dw_coil_modify.inv_Linkage.of_SetMaster(dw_coil_list)
IF NOT dw_coil_modify.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link coil & coil modify in win w_qa_coil" )
ELSE
	dw_coil_modify.inv_Linkage.of_Register( "coil_abc_num", "coil_abc_num" ) 
	dw_coil_modify.inv_Linkage.of_SetStyle( dw_coil_modify.inv_linkage.RETRIEVE )
END IF

dw_coil_pic.of_SetLinkage( TRUE ) 
dw_coil_pic.inv_Linkage.of_SetMaster(dw_coil_list)
IF NOT dw_coil_pic.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link coil & coil picture in win w_qa_coil" )
ELSE
	dw_coil_pic.inv_Linkage.of_Register( "coil_abc_num", "coil_abc_num" ) 
	dw_coil_pic.inv_Linkage.of_SetStyle( dw_coil_pic.inv_linkage.RETRIEVE )
END IF



end event

type dw_customer from u_dw within w_qa_coil_bk
integer x = 538
integer y = 29
integer width = 102
integer height = 35
integer taborder = 40
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

type cb_6 from commandbutton within w_qa_coil_bk
integer x = 1723
integer y = 2035
integer width = 347
integer height = 99
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Print"
end type

type cb_5 from commandbutton within w_qa_coil_bk
integer x = 2600
integer y = 2035
integer width = 344
integer height = 99
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

type cb_4 from commandbutton within w_qa_coil_bk
integer x = 922
integer y = 2035
integer width = 369
integer height = 99
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Send &E-Mail"
end type

type cb_cancel from u_cb within w_qa_coil_bk
integer x = 3405
integer y = 925
integer width = 307
integer height = 77
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

type cb_save from u_cb within w_qa_coil_bk
integer x = 3405
integer y = 714
integer width = 307
integer height = 77
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

type dw_coil_modify from u_dw within w_qa_coil_bk
integer x = 2304
integer y = 608
integer width = 1072
integer height = 522
integer taborder = 50
string dataobject = "d_coil_detail_qa_editor"
end type

type cb_delete_pic from u_cb within w_qa_coil_bk
integer x = 3405
integer y = 1616
integer width = 307
integer height = 77
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete"
end type

type cb_add_pic from u_cb within w_qa_coil_bk
integer x = 3405
integer y = 1411
integer width = 307
integer height = 77
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Add"
end type

event clicked;Parent.Event pfc_Save()

end event

type dw_coil_pic from u_dw within w_qa_coil_bk
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_display_popup ( long al_row )
integer x = 33
integer y = 1245
integer width = 3332
integer height = 688
integer taborder = 60
string dataobject = "d_pic_sample"
boolean hscrollbar = true
end type

event type integer ue_search_retrieve();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//integer li_net
//
//IF this.Event pfc_UpdatesPending() = 1 THEN
//	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
//	if li_net = 1 then
//		Parent.Event pfc_Save()      
//	else
//	  	return 0
//	end if
//END IF
//
//ls_where = wf_search_terms()
//
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
//END IF
//
Return 1
end event

event ue_resume_where();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//
//wf_reset_condition()
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id ) "
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to resume datawindow!", StopSign!)
//END IF
//st_cond.Text = "All"
//
end event

event ue_display_popup(long al_row);//s_coil_info lds_data
//int li_status
//
//lds_data.customer_id = this.GetItemNumber(al_row, "customer_id",Primary!, FALSE)
//lds_data.ab_coil_num = this.GetItemNumber(al_row, "coil_abc_num", Primary!, FALSE)
//lds_data.coil_orig_num = this.GetItemString(al_row, "coil_org_num", Primary!, FALSE)
//lds_data.coil_alt_num = this.GetItemString(al_row, "coil_mid_num", Primary!, FALSE)
//lds_data.lot_num = this.GetItemString(al_row, "lot_num",Primary!, FALSE)
//lds_data.pieces = this.GetItemNumber(al_row, "pieces_per_case", Primary!, FALSE)
//lds_data.coil_line_num = this.GetItemNumber(al_row, "coil_line_num", Primary!, FALSE)
//lds_data.icra = this.GetItemString(al_row, "icra", Primary!, FALSE)
//lds_data.alloy = this.GetItemString(al_row, "coil_alloy2",Primary!, FALSE)
//lds_data.gauge = this.GetItemNumber(al_row, "coil_gauge", Primary!, FALSE)
//lds_data.Temper = this.GetItemString(al_row, "coil_temper", Primary!, FALSE)
//lds_data.net_wt = this.GetItemNumber(al_row, "net_wt", Primary!, FALSE)
//lds_data.net_balance = this.GetItemNumber(al_row, "net_wt_balance", Primary!, FALSE)
//lds_data.width = this.GetItemNumber(al_row, "coil_width", Primary!, FALSE)
//lds_data.date_received = this.GetItemDateTime(al_row, "date_received", Primary!, FALSE)
//lds_data.location = this.GetItemString(al_row, "coil_location", Primary!, FALSE)
//lds_data.status = this.GetItemNumber(al_row, "coil_status", Primary!, FALSE)
//lds_data.notes = this.GetItemString(al_row, "coil_notes", Primary!, FALSE)
//lds_data.coil_from_cust_id = this.GetItemNumber(al_row, "coil_from_cust_id", Primary!, FALSE)
//
//li_status = lds_data.status
//OpenWithParm(w_coil_detail_2, lds_data)
//IF li_status <> 0 THEN 
//	lds_data = message.PowerObjectParm
//
//	IF lds_data.ab_coil_num > 0 THEN
//		//this.SetItem(al_row, "customer_id",lds_data.customer_id)
//		//this.SetItem(al_row, "coil_abc_num", lds_data.ab_coil_num )
//		this.SetItem(al_row, "coil_org_num",lds_data.coil_orig_num  )
//		this.SetItem(al_row, "coil_mid_num",lds_data.coil_alt_num)
//		this.SetItem(al_row, "lot_num", lds_data.lot_num   )
//		this.SetItem(al_row, "pieces_per_case", lds_data.pieces)
//		this.SetItem(al_row, "coil_line_num", lds_data.coil_line_num)
//		this.SetItem(al_row, "icra", lds_data.icra )
//		this.SetItem(al_row, "coil_alloy2", lds_data.alloy)
//		this.SetItem(al_row, "coil_gauge",lds_data.gauge )
//		this.SetItem(al_row, "coil_temper",lds_data.Temper )
//		this.SetItem(al_row, "net_wt",lds_data.net_wt )
//		this.SetItem(al_row, "net_wt_balance", lds_data.net_balance)
//		this.SetItem(al_row, "coil_width",lds_data.width )
//		this.SetItem(al_row, "date_received", lds_data.date_received)
//		this.SetItem(al_row, "coil_location", lds_data.location )
//		this.SetItem(al_row, "coil_status",lds_data.status )
//		this.SetItem(al_row, "coil_notes", lds_data.notes )
//		this.SetItem(al_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
//		il_cur_coil = lds_data.ab_coil_num
//		ib_modify = TRUE
//		wf_editing_mode()
//	ELSE
//		this.Reset()
//		ib_modify = FALSE
//		wf_normal_mode()
//	END IF
//END IF	
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
//
//ll_row_coil = this.GetRow()
//ll_row_cut = dw_customer.GetRow()
//ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
//this.SetItem(ll_row_coil, "customer_id", ll_c_id)
//ll_new_id = f_get_next_value("coil_abc_num_seq")
//this.SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
//this.setItem(ll_row_coil, "coil_entry_date", Today() )
//this.setItem(ll_row_coil, "coil_status", 2 )  //new coil
////dw_coil_list.setItem(ll_row_coil, "material_type", 1 ) //aluminum
//
//this.SetItem(ll_row_coil, "coil_org_num",ids_coil.coil_orig_num  )
//this.SetItem(ll_row_coil, "coil_mid_num",ids_coil.coil_alt_num)
//this.SetItem(ll_row_coil, "lot_num", ids_coil.lot_num   )
//this.SetItem(ll_row_coil, "pieces_per_case", ids_coil.pieces)
//this.SetItem(ll_row_coil, "coil_line_num", ids_coil.coil_line_num)
//this.SetItem(ll_row_coil, "icra", ids_coil.icra )
//this.SetItem(ll_row_coil, "coil_alloy2", ids_coil.alloy)
//this.SetItem(ll_row_coil, "coil_gauge",ids_coil.gauge )
//this.SetItem(ll_row_coil, "coil_temper",ids_coil.Temper )
//this.SetItem(ll_row_coil, "net_wt",ids_coil.net_wt )
//this.SetItem(ll_row_coil, "net_wt_balance", ids_coil.net_balance)
//this.SetItem(ll_row_coil, "coil_width",ids_coil.width )
//this.SetItem(ll_row_coil, "date_received", ids_coil.date_received)
//this.SetItem(ll_row_coil, "coil_location", ids_coil.location )
//this.SetItem(ll_row_coil, "coil_status",ids_coil.status )
//this.SetItem(ll_row_coil, "coil_notes", ids_coil.notes )
//this.SetItem(ll_row_coil, "coil_from_cust_id",ids_coil.coil_from_cust_id)
//il_cur_coil = ll_new_id
//ib_new = TRUE

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

type dw_coil_history from u_dw within w_qa_coil_bk
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_display_popup ( long al_row )
integer x = 33
integer y = 557
integer width = 2194
integer height = 595
integer taborder = 40
string dataobject = "d_coil_track_qa"
boolean hscrollbar = true
end type

event type integer ue_search_retrieve();//RETURN 1
//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//integer li_net
//
//IF this.Event pfc_UpdatesPending() = 1 THEN
//	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
//	if li_net = 1 then
//		Parent.Event pfc_Save()      
//	else
//	  	return 0
//	end if
//END IF
//
//ls_where = wf_search_terms()
//
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
//END IF
//
Return 1
end event

event ue_resume_where();//RETURN
//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//
//wf_reset_condition()
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id ) "
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to resume datawindow!", StopSign!)
//END IF
//st_cond.Text = "All"

end event

event ue_display_popup(long al_row);//RETURN
//s_coil_info lds_data
//int li_status
//
//lds_data.customer_id = this.GetItemNumber(al_row, "customer_id",Primary!, FALSE)
//lds_data.ab_coil_num = this.GetItemNumber(al_row, "coil_abc_num", Primary!, FALSE)
//lds_data.coil_orig_num = this.GetItemString(al_row, "coil_org_num", Primary!, FALSE)
//lds_data.coil_alt_num = this.GetItemString(al_row, "coil_mid_num", Primary!, FALSE)
//lds_data.lot_num = this.GetItemString(al_row, "lot_num",Primary!, FALSE)
//lds_data.pieces = this.GetItemNumber(al_row, "pieces_per_case", Primary!, FALSE)
//lds_data.coil_line_num = this.GetItemNumber(al_row, "coil_line_num", Primary!, FALSE)
//lds_data.icra = this.GetItemString(al_row, "icra", Primary!, FALSE)
//lds_data.alloy = this.GetItemString(al_row, "coil_alloy2",Primary!, FALSE)
//lds_data.gauge = this.GetItemNumber(al_row, "coil_gauge", Primary!, FALSE)
//lds_data.Temper = this.GetItemString(al_row, "coil_temper", Primary!, FALSE)
//lds_data.net_wt = this.GetItemNumber(al_row, "net_wt", Primary!, FALSE)
//lds_data.net_balance = this.GetItemNumber(al_row, "net_wt_balance", Primary!, FALSE)
//lds_data.width = this.GetItemNumber(al_row, "coil_width", Primary!, FALSE)
//lds_data.date_received = this.GetItemDateTime(al_row, "date_received", Primary!, FALSE)
//lds_data.location = this.GetItemString(al_row, "coil_location", Primary!, FALSE)
//lds_data.status = this.GetItemNumber(al_row, "coil_status", Primary!, FALSE)
//lds_data.notes = this.GetItemString(al_row, "coil_notes", Primary!, FALSE)
//lds_data.coil_from_cust_id = this.GetItemNumber(al_row, "coil_from_cust_id", Primary!, FALSE)
//
//li_status = lds_data.status
//OpenWithParm(w_coil_detail_2, lds_data)
//IF li_status <> 0 THEN 
//	lds_data = message.PowerObjectParm
//
//	IF lds_data.ab_coil_num > 0 THEN
//		//this.SetItem(al_row, "customer_id",lds_data.customer_id)
//		//this.SetItem(al_row, "coil_abc_num", lds_data.ab_coil_num )
//		this.SetItem(al_row, "coil_org_num",lds_data.coil_orig_num  )
//		this.SetItem(al_row, "coil_mid_num",lds_data.coil_alt_num)
//		this.SetItem(al_row, "lot_num", lds_data.lot_num   )
//		this.SetItem(al_row, "pieces_per_case", lds_data.pieces)
//		this.SetItem(al_row, "coil_line_num", lds_data.coil_line_num)
//		this.SetItem(al_row, "icra", lds_data.icra )
//		this.SetItem(al_row, "coil_alloy2", lds_data.alloy)
//		this.SetItem(al_row, "coil_gauge",lds_data.gauge )
//		this.SetItem(al_row, "coil_temper",lds_data.Temper )
//		this.SetItem(al_row, "net_wt",lds_data.net_wt )
//		this.SetItem(al_row, "net_wt_balance", lds_data.net_balance)
//		this.SetItem(al_row, "coil_width",lds_data.width )
//		this.SetItem(al_row, "date_received", lds_data.date_received)
//		this.SetItem(al_row, "coil_location", lds_data.location )
//		this.SetItem(al_row, "coil_status",lds_data.status )
//		this.SetItem(al_row, "coil_notes", lds_data.notes )
//		this.SetItem(al_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
//		il_cur_coil = lds_data.ab_coil_num
//		ib_modify = TRUE
//		wf_editing_mode()
//	ELSE
//		this.Reset()
//		ib_modify = FALSE
//		wf_normal_mode()
//	END IF
//END IF	
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
//long ll_row_coil, ll_row_cut,ll_c_id, ll_new_id
//
//ll_row_coil = this.GetRow()
//ll_row_cut = dw_customer.GetRow()
//ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
//this.SetItem(ll_row_coil, "customer_id", ll_c_id)
//ll_new_id = f_get_next_value("coil_abc_num_seq")
//this.SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
//this.setItem(ll_row_coil, "coil_entry_date", Today() )
//this.setItem(ll_row_coil, "coil_status", 2 )  //new coil
////dw_coil_list.setItem(ll_row_coil, "material_type", 1 ) //aluminum
//
//this.SetItem(ll_row_coil, "coil_org_num",ids_coil.coil_orig_num  )
//this.SetItem(ll_row_coil, "coil_mid_num",ids_coil.coil_alt_num)
//this.SetItem(ll_row_coil, "lot_num", ids_coil.lot_num   )
//this.SetItem(ll_row_coil, "pieces_per_case", ids_coil.pieces)
//this.SetItem(ll_row_coil, "coil_line_num", ids_coil.coil_line_num)
//this.SetItem(ll_row_coil, "icra", ids_coil.icra )
//this.SetItem(ll_row_coil, "coil_alloy2", ids_coil.alloy)
//this.SetItem(ll_row_coil, "coil_gauge",ids_coil.gauge )
//this.SetItem(ll_row_coil, "coil_temper",ids_coil.Temper )
//this.SetItem(ll_row_coil, "net_wt",ids_coil.net_wt )
//this.SetItem(ll_row_coil, "net_wt_balance", ids_coil.net_balance)
//this.SetItem(ll_row_coil, "coil_width",ids_coil.width )
//this.SetItem(ll_row_coil, "date_received", ids_coil.date_received)
//this.SetItem(ll_row_coil, "coil_location", ids_coil.location )
//this.SetItem(ll_row_coil, "coil_status",ids_coil.status )
//this.SetItem(ll_row_coil, "coil_notes", ids_coil.notes )
//this.SetItem(ll_row_coil, "coil_from_cust_id",ids_coil.coil_from_cust_id)
//il_cur_coil = ll_new_id
//ib_new = TRUE
//
//Return ll_row_coil
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

type st_13 from statictext within w_qa_coil_bk
integer x = 37
integer y = 480
integer width = 735
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "QA Track of Coil ABC #: 58976"
boolean focusrectangle = false
end type

type dw_coil_list from u_dw within w_qa_coil_bk
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_goto_row ( )
event ue_display_changing ( integer ai_type )
integer x = 1232
integer y = 10
integer width = 2491
integer height = 525
integer taborder = 30
string dataobject = "d_coil_list_qa_cur"
boolean hscrollbar = true
end type

event type integer ue_search_retrieve();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//integer li_net
//
//IF this.Event pfc_UpdatesPending() = 1 THEN
//	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
//	if li_net = 1 then
//		Parent.Event pfc_Save()      
//	else
//	  	return 0
//	end if
//END IF
//
//ls_where = wf_search_terms()
//
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	IF Len(is_where) < 2 THEN
//		this.Retrieve()
//	ELSE
//		this.Retrieve(ll_cust)
//	END IF
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
//END IF
//
Return 1
end event

event ue_resume_where();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//
//wf_reset_condition()
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + is_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	IF Len(is_where) < 2 THEN
//		this.Retrieve()
//	ELSE
//		this.Retrieve(ll_cust)
//	END IF
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to resume datawindow!", StopSign!)
//END IF
//st_cond.Text = "All"
//
end event

event ue_goto_row();//Long ll_crow, ll_trow, ll_i
//
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

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

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

event rbuttondown;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
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

type rb_all from u_rb within w_qa_coil_bk
integer x = 720
integer y = 138
integer width = 457
integer height = 64
string text = "Historic QA Coil"
end type

event clicked;call super::clicked;//if This.Checked then
//	ii_showall =1
//	ddlb_customer.SelectItem(il_index)
//	ddlb_customer.Event SelectionChanged(il_index)
//end if
//
end event

type rb_current from u_rb within w_qa_coil_bk
integer x = 720
integer y = 58
integer width = 450
integer height = 64
string text = "Current QA Coil"
boolean checked = true
end type

event clicked;call super::clicked;//if This.Checked then
//	ii_showall =0
//	ddlb_customer.SelectItem(il_index)
//	ddlb_customer.Event SelectionChanged(il_index)
//end if
//
end event

type ddlb_customer from dropdownlistbox within w_qa_coil_bk
integer x = 18
integer y = 83
integer width = 647
integer height = 1059
integer taborder = 10
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
Long ll_row, ll_i, ll_cust

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		dw_customer.Event RowFocusChanged(ll_i)
		dw_customer.SelectRow(0, False)
		dw_customer.SelectRow(ll_i, True)
		ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")		
		
		if rb_all.Checked = True then		//all historic QA coil
			/*action1*/
		end if

		dw_coil_list.Retrieve(ll_cust)	
//		dw_coil_list.reset()
	END IF
NEXT

end event

type st_1 from statictext within w_qa_coil_bk
integer x = 18
integer y = 10
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

type gb_2 from u_gb within w_qa_coil_bk
integer x = 688
integer width = 505
integer height = 221
integer taborder = 10
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "Coil Showing"
end type

type gb_1 from u_gb within w_qa_coil_bk
integer y = 1181
integer width = 3749
integer height = 810
integer taborder = 50
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "QA Picture"
end type

type gb_4 from groupbox within w_qa_coil_bk
integer x = 2271
integer y = 538
integer width = 1477
integer height = 621
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "QA Modification"
end type

