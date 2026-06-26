$PBExportHeader$w_order_entry_coil_list.srw
$PBExportComments$<Response> list coil from this order inherited from pfemain/w_response
forward
global type w_order_entry_coil_list from w_response
end type
type cb_detail from u_cb within w_order_entry_coil_list
end type
type cb_cancel from u_cb within w_order_entry_coil_list
end type
type dw_order_entry_coil from u_dw within w_order_entry_coil_list
end type
type cb_get from u_cb within w_order_entry_coil_list
end type
type cb_del from u_cb within w_order_entry_coil_list
end type
type cb_finish from u_cb within w_order_entry_coil_list
end type
type dw_order_coil from u_dw within w_order_entry_coil_list
end type
type dw_del_coil from u_dw within w_order_entry_coil_list
end type
type st_1 from statictext within w_order_entry_coil_list
end type
type st_2 from statictext within w_order_entry_coil_list
end type
type st_totalcoil from statictext within w_order_entry_coil_list
end type
type st_totalwt from statictext within w_order_entry_coil_list
end type
type st_3 from statictext within w_order_entry_coil_list
end type
type st_4 from statictext within w_order_entry_coil_list
end type
type st_5 from statictext within w_order_entry_coil_list
end type
type st_6 from statictext within w_order_entry_coil_list
end type
type st_7 from statictext within w_order_entry_coil_list
end type
type st_8 from statictext within w_order_entry_coil_list
end type
type st_9 from statictext within w_order_entry_coil_list
end type
end forward

global type w_order_entry_coil_list from w_response
int X=311
int Y=310
int Width=3032
int Height=1610
boolean TitleBar=true
string Title="Coil list for this customer order"
cb_detail cb_detail
cb_cancel cb_cancel
dw_order_entry_coil dw_order_entry_coil
cb_get cb_get
cb_del cb_del
cb_finish cb_finish
dw_order_coil dw_order_coil
dw_del_coil dw_del_coil
st_1 st_1
st_2 st_2
st_totalcoil st_totalcoil
st_totalwt st_totalwt
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
end type
global w_order_entry_coil_list w_order_entry_coil_list

type variables
Long il_order


end variables

forward prototypes
public function long wf_get_order_id ()
public function long wf_get_customerid ()
public subroutine wf_show_coil_wt ()
end prototypes

public function long wf_get_order_id ();Long ll_id
Window lw_parent

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	ll_id = lw_Parent.Event Dynamic ue_get_orderid()
END IF
		
RETURN ll_id
end function

public function long wf_get_customerid ();Long ll_id
Window lw_parent

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	ll_id = lw_Parent.Event Dynamic ue_get_customerid()
END IF
		
RETURN ll_id
end function

public subroutine wf_show_coil_wt ();Long ll_total_wt, ll_coil_wt
Int li_row, li_int

ll_total_wt = 0
li_row = 0
li_row = dw_order_entry_coil.RowCount()
IF li_row > 0 THEN
	FOR li_int = 1 TO li_row
		ll_coil_wt = 0
		ll_coil_wt = dw_order_entry_coil.GetItemNumber(li_int,"coil_net_wt", Primary!, FALSE )
		ll_total_wt = ll_total_wt + ll_coil_wt
		st_totalwt.Text = String(ll_total_wt, "###,###,###") + "  lb"
		st_totalcoil.Text = String(li_row, "###,###,###")
	NEXT
ELSE
	st_totalwt.Text = "  0  lb"
	st_totalcoil.Text = "  0 "	
END IF

end subroutine

event open;call super::open;DataWindow ldw_d
ldw_d = Message.PowerObjectParm

il_order = wf_get_order_id()
this.Title = "Coil list for order#" + String(il_order)

ldw_d.RowsCopy(1, ldw_d.rowCount(), Primary!, dw_order_entry_coil, 1, Primary!)
dw_order_entry_coil.ResetUpdate()

wf_show_coil_wt()





end event

on w_order_entry_coil_list.create
int iCurrent
call super::create
this.cb_detail=create cb_detail
this.cb_cancel=create cb_cancel
this.dw_order_entry_coil=create dw_order_entry_coil
this.cb_get=create cb_get
this.cb_del=create cb_del
this.cb_finish=create cb_finish
this.dw_order_coil=create dw_order_coil
this.dw_del_coil=create dw_del_coil
this.st_1=create st_1
this.st_2=create st_2
this.st_totalcoil=create st_totalcoil
this.st_totalwt=create st_totalwt
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_detail
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.dw_order_entry_coil
this.Control[iCurrent+4]=this.cb_get
this.Control[iCurrent+5]=this.cb_del
this.Control[iCurrent+6]=this.cb_finish
this.Control[iCurrent+7]=this.dw_order_coil
this.Control[iCurrent+8]=this.dw_del_coil
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_totalcoil
this.Control[iCurrent+12]=this.st_totalwt
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.st_8
this.Control[iCurrent+19]=this.st_9
end on

on w_order_entry_coil_list.destroy
call super::destroy
destroy(this.cb_detail)
destroy(this.cb_cancel)
destroy(this.dw_order_entry_coil)
destroy(this.cb_get)
destroy(this.cb_del)
destroy(this.cb_finish)
destroy(this.dw_order_coil)
destroy(this.dw_del_coil)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_totalcoil)
destroy(this.st_totalwt)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
end on

type cb_detail from u_cb within w_order_entry_coil_list
int X=757
int Y=1402
int Height=83
int TabOrder=60
boolean BringToTop=true
string Text="&Detail"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Long ll_row

ll_row = dw_order_entry_coil.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an coil first!", StopSign! )
	RETURN
END IF

RETURN dw_order_entry_coil.Event ue_display_popup(ll_row)


end event

type cb_cancel from u_cb within w_order_entry_coil_list
int X=2512
int Y=1402
int Height=83
int TabOrder=80
boolean BringToTop=true
string Text="&Cancel"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_order_entry_coil.ResetUpdate()
dw_del_coil.resetUpdate()
dw_order_coil.ResetUpdate()
Close(Parent)
end event

type dw_order_entry_coil from u_dw within w_order_entry_coil_list
event type integer ue_display_popup ( long al_row )
event type integer ue_add_existing_coil ( long al_coil_num )
int X=22
int Y=0
int Width=2970
int Height=1315
int TabOrder=10
boolean BringToTop=true
string DataObject="d_coil_order_entry_list"
boolean HScrollBar=true
end type

event ue_display_popup;s_coil_info lds_data
int li_status

lds_data.customer_id = this.GetItemNumber(al_row, "coil_customer_id",Primary!, FALSE)
lds_data.ab_coil_num = this.GetItemNumber(al_row, "coil_abc_num", Primary!, FALSE)
lds_data.coil_orig_num = this.GetItemString(al_row, "coil_coil_org_num", Primary!, FALSE)
lds_data.coil_alt_num = this.GetItemString(al_row, "coil_coil_mid_num", Primary!, FALSE)
lds_data.lot_num = this.GetItemString(al_row, "coil_lot_num",Primary!, FALSE)
lds_data.pieces = this.GetItemNumber(al_row, "coil_pieces_per_case", Primary!, FALSE)
lds_data.coil_line_num = this.GetItemNumber(al_row, "coil_coil_line_num", Primary!, FALSE)
lds_data.icra = this.GetItemString(al_row, "coil_icra", Primary!, FALSE)
lds_data.alloy = this.GetItemString(al_row, "coil_coil_alloy2",Primary!, FALSE)
lds_data.gauge = this.GetItemNumber(al_row, "coil_coil_gauge", Primary!, FALSE)
lds_data.Temper = this.GetItemString(al_row, "coil_coil_temper", Primary!, FALSE)
lds_data.net_wt = this.GetItemNumber(al_row, "coil_net_wt", Primary!, FALSE)
lds_data.net_balance = this.GetItemNumber(al_row, "coil_net_wt_balance", Primary!, FALSE)
lds_data.width = this.GetItemNumber(al_row, "coil_coil_width", Primary!, FALSE)
lds_data.date_received = this.GetItemDateTime(al_row, "coil_date_received", Primary!, FALSE)
lds_data.location = this.GetItemString(al_row, "coil_coil_location", Primary!, FALSE)
lds_data.status = this.GetItemNumber(al_row, "coil_coil_status", Primary!, FALSE)
lds_data.notes = this.GetItemString(al_row, "coil_coil_notes", Primary!, FALSE)
lds_data.coil_from_cust_id = this.GetItemNumber(al_row, "coil_coil_from_cust_id", Primary!, FALSE)

li_status = lds_data.status
OpenWithParm(w_coil_detail_2, lds_data)
IF li_status <> 0 THEN 
	lds_data = message.PowerObjectParm

	//this.SetItem(al_row, "customer_id",lds_data.customer_id)
	//this.SetItem(al_row, "coil_abc_num", lds_data.ab_coil_num )
	this.SetItem(al_row, "coil_coil_org_num",lds_data.coil_orig_num  )
	this.SetItem(al_row, "coil_coil_mid_num",lds_data.coil_alt_num)
	this.SetItem(al_row, "coil_lot_num", lds_data.lot_num   )
	this.SetItem(al_row, "coil_pieces_per_case", lds_data.pieces)
	this.SetItem(al_row, "coil_coil_line_num", lds_data.coil_line_num)
	this.SetItem(al_row, "coil_icra", lds_data.icra )
	this.SetItem(al_row, "coil_coil_alloy2", lds_data.alloy)
	this.SetItem(al_row, "coil_coil_gauge",lds_data.gauge )
	this.SetItem(al_row, "coil_coil_temper",lds_data.Temper )
	this.SetItem(al_row, "coil_net_wt",lds_data.net_wt )
	this.SetItem(al_row, "coil_net_wt_balance", lds_data.net_balance)
	this.SetItem(al_row, "coil_coil_width",lds_data.width )
	this.SetItem(al_row, "coil_date_received", lds_data.date_received)
	this.SetItem(al_row, "coil_coil_location", lds_data.location )
	this.SetItem(al_row, "coil_coil_status",lds_data.status )
	this.SetItem(al_row, "coil_coil_notes", lds_data.notes )
	this.SetItem(al_row, "coil_coil_from_cust_id",lds_data.coil_from_cust_id)
END IF	

RETURN 1
end event

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
SetTransObject(SQLCA)

DataWindowChild ldddw_cni
IF this.GetChild("coil_coil_from_cust_id", ldddw_cni) = -1 THEN Return -1
this.Event pfc_PopulateDDDW("coil_coil_from_cust_id", ldddw_cni)



end event

event doubleclicked;IF (row < 1) OR IsNULL(row) THEN Return 0

cb_detail.Event Clicked()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

event pfc_addrow;call super::pfc_addrow;long ll_row_coil,ll_c_id, ll_new_id

ll_row_coil = this.GetRow()

ll_c_id = wf_get_customerid()
IF ll_c_id <= 0 THEN
	MessageBox("Error", "No customer specified above!" )
	this.Event pfc_deleterow()
	Return 0
END IF

SetItem(ll_row_coil, "coil_customer_id", ll_c_id)
ll_new_id = f_get_next_value("coil_abc_num_seq")
SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
SetItem(ll_row_coil,"order_coil_coil_abc_num", ll_new_id )
setItem(ll_row_coil, "coil_coil_entry_date", Today() )
setItem(ll_row_coil, "coil_coil_status", 5 )  //coming but not availiable new coil
setItem(ll_row_coil, "coil_net_wt", 0 )

Return ll_new_id
end event

event losefocus;this.AcceptText()
wf_show_coil_wt()
end event

event pfc_populatedddw;call super::pfc_populatedddw;If adwc_obj.SetTransObject(SQLCA) = -1 THEN
	RETURN -1
ELSE
	RETURN adwc_obj.Retrieve()
END IF
end event

type cb_get from u_cb within w_order_entry_coil_list
int X=172
int Y=1402
int Height=83
int TabOrder=50
boolean BringToTop=true
string Text="&Get"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;long ll_row, ll_customer_id, ll_order_id, ll_coil

ll_customer_id = wf_get_customerid()
IF ll_customer_id > 0 THEN
	OpenWithParm(w_cust_coil_list, ll_customer_id)
	ll_coil = Message.DoubleParm
	IF ll_coil > 0 THEN 
		dw_order_entry_coil.Event ue_add_existing_coil(ll_coil)
		dw_order_coil.Event pfc_addrow()
	END IF
ELSE
	MessageBox("Warning", "NO customer specified")
END IF
wf_show_coil_wt()

end event

type cb_del from u_cb within w_order_entry_coil_list
int X=1342
int Y=1402
int Height=83
int TabOrder=70
boolean BringToTop=true
string Text="&Remove"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;IF MessageBox("Question","Remove this coil for this order?",Question!,OKCancel!, 1) = 2 THEN RETURN 0

Long ll_row, ll_coil, ll_delrow

ll_row = dw_order_entry_coil.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Info", "Select a coil first.")
	RETURN 0
END IF

ll_coil = dw_order_entry_coil.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)

Window lw_parent

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	IF lw_Parent.Event Dynamic ue_coil_delable(ll_coil) < 0 THEN RETURN -1
END IF

ll_delrow = dw_del_coil.InsertRow(0)
dw_del_coil.SetItem(ll_delrow, "coil_abc_num", ll_coil)

dw_order_entry_coil.DeleteRow(ll_row)

wf_show_coil_wt()



end event

type cb_finish from u_cb within w_order_entry_coil_list
int X=1927
int Y=1402
int Height=83
int TabOrder=40
boolean BringToTop=true
string Text="&Ok"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Long ll_id
Window lw_parent
Long ll_row, ll_i
Real lr_gauge, lr_width
Long ll_wt, ll_coil

dw_order_entry_coil.AcceptText()
dw_del_coil.AcceptText()
dw_order_coil.AcceptText()

ll_row = dw_order_entry_coil.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		ll_coil = dw_order_entry_coil.GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE)
		lr_gauge = dw_order_entry_coil.GetItemNumber(ll_i, "coil_coil_gauge", Primary!, FALSE)
		ll_wt = dw_order_entry_coil.GetItemNumber(ll_i, "coil_net_wt_balance", Primary!, FALSE)
		lr_width = dw_order_entry_coil.GetItemNumber(ll_i, "coil_coil_width", Primary!, FALSE)
		IF (lr_gauge >= 0.1) AND (ll_wt / lr_width <= 100.0) THEN
			MessageBox("Warning", "Heavy gauge, small OD coil#" + String(ll_coil))
		END IF
	NEXT
END IF

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
IF IsValid(lw_parent) THEN
	IF lw_Parent.Event Dynamic ue_del_coil(dw_del_coil) < 0 THEN RETURN -1
	IF lw_Parent.Event Dynamic ue_add_coil(dw_order_entry_coil,dw_order_coil) < 0 THEN RETURN -2
END IF

dw_order_entry_coil.ResetUpdate()
dw_del_coil.resetUpdate()
dw_order_coil.ResetUpdate()

Close(Parent)

end event

type dw_order_coil from u_dw within w_order_entry_coil_list
int X=18
int Y=1392
int Width=102
int Height=35
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
string DataObject="d_coil_per_order"
boolean HScrollBar=true
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

event pfc_addrow;call super::pfc_addrow;Long ll_coil_row, ll_coil_num, ll_this_row

ll_this_row = this.GetRow()
ll_coil_row = dw_order_entry_coil.Getrow()
IF ll_coil_row > 0 THEN
	ll_coil_num = dw_order_entry_coil.GetItemNumber(ll_coil_row,"coil_abc_num", Primary!, FALSE)
	IF ll_coil_num > 0 THEN
		this.SetItem(ll_this_row, "coil_abc_num", ll_coil_num)
		this.SetItem(ll_this_row, "order_abc_num",  il_order )
	END IF
END IF
Return ll_this_row

end event

type dw_del_coil from u_dw within w_order_entry_coil_list
int X=22
int Y=1434
int Width=121
int Height=42
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="d_coil_per_order"
boolean HScrollBar=true
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type st_1 from statictext within w_order_entry_coil_list
int X=1584
int Y=1325
int Width=362
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Number of Coils:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_order_entry_coil_list
int X=2275
int Y=1325
int Width=223
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text="Total WT:"
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

type st_totalcoil from statictext within w_order_entry_coil_list
int X=1953
int Y=1325
int Width=315
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text=" "
Alignment Alignment=Center!
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

type st_totalwt from statictext within w_order_entry_coil_list
int X=2491
int Y=1325
int Width=494
int Height=61
boolean Enabled=false
boolean BringToTop=true
string Text=" "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_order_entry_coil_list
int X=26
int Y=1328
int Width=351
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="Color indication:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_order_entry_coil_list
int X=369
int Y=1328
int Width=150
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="Done"
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_order_entry_coil_list
int X=505
int Y=1328
int Width=252
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="InProcess"
boolean FocusRectangle=false
long TextColor=32768
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_order_entry_coil_list
int X=757
int Y=1328
int Width=113
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="New"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_order_entry_coil_list
int X=892
int Y=1328
int Width=205
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="Rejected"
boolean FocusRectangle=false
long TextColor=255
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_order_entry_coil_list
int X=1108
int Y=1328
int Width=187
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="OnHold"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_order_entry_coil_list
int X=1309
int Y=1328
int Width=190
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="InTransit"
boolean FocusRectangle=false
long TextColor=16711935
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

