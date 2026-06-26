$PBExportHeader$w_daily_prod_coil_update.srw
$PBExportComments$<child> list all coils for an shift, inherited from pfemain\w_child
forward
global type w_daily_prod_coil_update from w_child
end type
type dw_order_coil from u_dw within w_daily_prod_coil_update
end type
type cb_cancel from u_cb within w_daily_prod_coil_update
end type
type cb_add from u_cb within w_daily_prod_coil_update
end type
type dw_1 from u_dw within w_daily_prod_coil_update
end type
end forward

global type w_daily_prod_coil_update from w_child
int X=519
int Y=374
int Width=2139
int Height=1565
WindowType WindowType=response!
boolean TitleBar=true
string Title="Coils for production orders assigned to this shift"
string Tag="list all coils"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_order_coil dw_order_coil
cb_cancel cb_cancel
cb_add cb_add
dw_1 dw_1
end type
global w_daily_prod_coil_update w_daily_prod_coil_update

type variables
s_new_daily_prod_info istr_q
end variables

on w_daily_prod_coil_update.create
int iCurrent
call super::create
this.dw_order_coil=create dw_order_coil
this.cb_cancel=create cb_cancel
this.cb_add=create cb_add
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_order_coil
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.dw_1
end on

on w_daily_prod_coil_update.destroy
call super::destroy
destroy(this.dw_order_coil)
destroy(this.cb_cancel)
destroy(this.cb_add)
destroy(this.dw_1)
end on

event open;call super::open;Long ll_rc, ll_i, ll_rc1, ll_j, ll_newcoil, ll_job 

istr_q = message.PowerObjectParm

dw_1.Visible = FALSE

datastore lds_job

lds_job = CREATE datastore  
lds_job.DataObject = "d_daily_prod_job_list"  
lds_job.SetTransObject (SQLCA)  
lds_job.Retrieve(istr_q.shift_id)
ll_rc = lds_job.RowCount()

IF ll_rc <= 0 THEN RETURN 0

FOR ll_i = 1 TO ll_rc	
	ll_job = lds_job.GetItemNumber(ll_i, "ab_job_num", Primary!, FALSE)
	dw_1.Retrieve(ll_job)
	ll_rc1 = dw_1.RowCount()
	IF ll_rc1 > 0 THEN
		FOR ll_J = 1 TO ll_rc1
			ll_newcoil = dw_order_coil.InsertRow(0)
			dw_order_coil.SetItem(ll_newcoil, "process_coil_ab_job_num", ll_job)
			dw_order_coil.SetItem(ll_newcoil, "coil_coil_abc_num", dw_1.GetItemNumber(ll_j, "coil_coil_abc_num"))
			dw_order_coil.SetItem(ll_newcoil, "coil_coil_org_num", dw_1.GetItemString(ll_j, "coil_coil_org_num"))
			dw_order_coil.SetItem(ll_newcoil, "coil_lot_num", dw_1.GetItemString(ll_j, "coil_lot_num"))
			dw_order_coil.SetItem(ll_newcoil, "coil_coil_status", dw_1.GetItemNumber(ll_j,"coil_coil_status"))
			dw_order_coil.SetItem(ll_newcoil, "coil_net_wt_balance", dw_1.GetItemNumber(ll_j,"coil_net_wt_balance"))
		NEXT
	END IF
NEXT

DESTROY lds_job

dw_order_coil.ResetUpdate()
dw_order_coil.SetFocus()

end event

type dw_order_coil from u_dw within w_daily_prod_coil_update
int X=29
int Y=10
int Width=2063
int Height=1331
int TabOrder=10
string DragIcon="Information!"
string Tag="list all coils for this shift"
string DataObject="d_daily_prod_update_coil_list"
boolean HScrollBar=true
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 1 ) 
SetTransObject(sqlca)

end event

event rbuttondown;//Override
Return
end event

event rbuttonup;//Override
Return 
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

type cb_cancel from u_cb within w_daily_prod_coil_update
int X=1207
int Y=1354
int Width=435
int Height=83
int TabOrder=30
string Text="&Close"
string FaceName="Arial"
end type

event clicked;s_job_and_coil lstr_1
lstr_1.coil_num = 0
lstr_1.job_num = 0
CloseWithReturn(Parent,lstr_1)
RETURN 1


end event
type cb_add from u_cb within w_daily_prod_coil_update
int X=410
int Y=1354
int Width=435
int Height=83
int TabOrder=20
string Tag="add coil to current production order"
string Text="&Add"
string FaceName="Arial"
end type

event clicked;Long ll_row, ll_coil_num, ll_job
//Window lw_parent
s_job_and_coil lstr_1

ll_row = dw_order_coil.GetRow()
IF ll_row > 0 THEN
	ll_coil_num = dw_order_coil.GetItemNumber(ll_row, "coil_coil_abc_num", Primary!, FALSE)
	IF ll_coil_num <= 0 THEN 
		MessageBox("Error", "Failed to retrieve this coil!" )
		Return 1
	END IF	
	ll_job = dw_order_coil.GetItemNumber(ll_row, "process_coil_ab_job_num", Primary!, FALSE)	
END IF

////add new coil to ab_job
//lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
//IF IsValid(lw_parent) THEN
//	lw_Parent.Dynamic Event ue_add_coil(ll_coil_num)
//END IF	
//dw_order_coil.DeleteRow(ll_row)
//dw_order_coil.ResetUpdate()
//
lstr_1.coil_num = ll_coil_num
lstr_1.job_num = ll_job
CloseWithReturn(Parent,lstr_1)
RETURN 1

end event
type dw_1 from u_dw within w_daily_prod_coil_update
int X=1832
int Y=1366
int Width=139
int Height=51
int TabOrder=11
boolean BringToTop=true
string DataObject="d_daily_prod_process_coil"
end type

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 1 ) 
SetTransObject(sqlca)

end event

