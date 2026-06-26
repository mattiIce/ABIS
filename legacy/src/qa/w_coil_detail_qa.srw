$PBExportHeader$w_coil_detail_qa.srw
$PBExportComments$<Child> list new coil detail used in the w_inv_coil, just like w_coil_detail
forward
global type w_coil_detail_qa from w_child
end type
type dw_coil_detail from u_dw within w_coil_detail_qa
end type
type cb_coil_cancel from u_cb within w_coil_detail_qa
end type
type cb_ok from u_cb within w_coil_detail_qa
end type
end forward

global type w_coil_detail_qa from w_child
string tag = "detail information of an new coil"
integer x = 878
integer y = 488
integer width = 1856
integer height = 988
string title = " New Coil Information"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_coil_detail dw_coil_detail
cb_coil_cancel cb_coil_cancel
cb_ok cb_ok
end type
global w_coil_detail_qa w_coil_detail_qa

on w_coil_detail_qa.create
int iCurrent
call super::create
this.dw_coil_detail=create dw_coil_detail
this.cb_coil_cancel=create cb_coil_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_detail
this.Control[iCurrent+2]=this.cb_coil_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_coil_detail_qa.destroy
call super::destroy
destroy(this.dw_coil_detail)
destroy(this.cb_coil_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;s_coil_info lds_data
Long ll_row
dw_coil_detail.SetTransObject(sqlca)

lds_data = message.PowerObjectParm
this.title = "New coil"
ll_row = dw_coil_detail.InsertRow(0)

dw_coil_detail.SetItem(ll_row, "customer_id",lds_data.customer_id)
dw_coil_detail.SetItem(ll_row, "coil_abc_num",lds_data.ab_coil_num)
dw_coil_detail.SetItem(ll_row, "coil_status",lds_data.status )
dw_coil_detail.SetItem(ll_row, "coil_from_cust_id", lds_data.customer_id)
dw_coil_detail.SetItem(ll_row, "date_received", Today())

dw_coil_detail.ResetUpdate()

dw_coil_detail.SetFocus()

end event

type dw_coil_detail from u_dw within w_coil_detail_qa
string tag = "Detail information of an  new coil"
integer x = 41
integer y = 24
integer width = 1755
integer height = 752
integer taborder = 20
string dataobject = "d_coil_detail_qa"
boolean vscrollbar = false
boolean livescroll = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event itemchanged;call super::itemchanged;this.ResetUpdate()
end event

type cb_coil_cancel from u_cb within w_coil_detail_qa
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 1106
integer y = 784
integer taborder = 10
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;s_coil_info lds_data
long ll_row

ll_row = dw_coil_detail.GetRow()
IF ll_row < 1 THEN RETURN
lds_data.customer_id = -1

dw_coil_detail.Reset()
CloseWithReturn(parent, lds_data)
end event

type cb_ok from u_cb within w_coil_detail_qa
string tag = "Close this window and pass the information"
integer x = 352
integer y = 784
integer taborder = 11
string facename = "Arial"
string text = "&Ok"
end type

event clicked;s_coil_info lds_data
long ll_row

dw_coil_detail.AcceptText()
dw_coil_detail.ResetUpdate()

ll_row = dw_coil_detail.GetRow()
IF ll_row < 1 THEN RETURN
lds_data.customer_id = dw_coil_detail.GetItemNumber(ll_row, "customer_id",Primary!, FALSE)
lds_data.ab_coil_num = dw_coil_detail.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = dw_coil_detail.GetItemString(ll_row, "coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = dw_coil_detail.GetItemString(ll_row, "coil_mid_num", Primary!, FALSE)
lds_data.lot_num = dw_coil_detail.GetItemString(ll_row, "lot_num",Primary!, FALSE)
lds_data.pieces = dw_coil_detail.GetItemNumber(ll_row, "pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = dw_coil_detail.GetItemNumber(ll_row, "coil_line_num", Primary!, FALSE)
lds_data.icra = dw_coil_detail.GetItemString(ll_row, "icra", Primary!, FALSE)
lds_data.alloy = dw_coil_detail.GetItemString(ll_row, "coil_alloy2",Primary!, FALSE)
lds_data.gauge = dw_coil_detail.GetItemNumber(ll_row, "coil_gauge", Primary!, FALSE)
lds_data.Temper = dw_coil_detail.GetItemString(ll_row, "coil_temper", Primary!, FALSE)
lds_data.net_wt = dw_coil_detail.GetItemNumber(ll_row, "net_wt", Primary!, FALSE)
lds_data.net_balance = dw_coil_detail.GetItemNumber(ll_row, "net_wt_balance", Primary!, FALSE)
lds_data.width = dw_coil_detail.GetItemNumber(ll_row, "coil_width", Primary!, FALSE)
lds_data.date_received = dw_coil_detail.GetItemDateTime(ll_row, "date_received", Primary!, FALSE)
lds_data.location = dw_coil_detail.GetItemString(ll_row, "coil_location", Primary!, FALSE)
lds_data.status = dw_coil_detail.GetItemNumber(ll_row, "coil_status", Primary!, FALSE)
lds_data.notes = dw_coil_detail.GetItemString(ll_row, "coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = dw_coil_detail.GetItemNumber(ll_row, "coil_from_cust_id", Primary!, FALSE)

IF IsNULL(lds_data.net_wt) THEN
	MessageBox("Error", "Invalid coil net weight.", StopSign!)
	RETURN -1
END IF
IF IsNULL(lds_data.net_balance) THEN
	MessageBox("Error", "Invalid coil current weight.", StopSign!)
	RETURN -2
END IF
IF IsNULL(lds_data.width) THEN
	MessageBox("Error", "Invalid coil coil width.", StopSign!)
	RETURN -3
END IF
IF (lds_data.net_balance / lds_data.width <= 100.0) AND (lds_data.gauge >= 0.1) THEN
	MessageBox("Warning", "Heavy gauge, small OD coil!")
END IF

dw_coil_detail.Reset()
CloseWithReturn(parent, lds_data)
end event

