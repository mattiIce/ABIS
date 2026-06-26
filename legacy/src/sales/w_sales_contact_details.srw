$PBExportHeader$w_sales_contact_details.srw
$PBExportComments$contact details inherited from w_child
forward
global type w_sales_contact_details from w_child
end type
type pb_1 from u_pb within w_sales_contact_details
end type
type pb_5 from u_pb within w_sales_contact_details
end type
type cb_close from u_cb within w_sales_contact_details
end type
type pb_4 from u_pb within w_sales_contact_details
end type
type pb_8 from u_pb within w_sales_contact_details
end type
type pb_3 from u_pb within w_sales_contact_details
end type
type dw_contact_list from u_dw within w_sales_contact_details
end type
type dw_customer_list from u_dw within w_sales_contact_details
end type
type dw_sales from u_dw within w_sales_contact_details
end type
type gb_1 from groupbox within w_sales_contact_details
end type
type gb_2 from groupbox within w_sales_contact_details
end type
type gb_4 from groupbox within w_sales_contact_details
end type
end forward

global type w_sales_contact_details from w_child
integer width = 3423
integer height = 1914
string title = "Customer Details"
long backcolor = 134217752
pb_1 pb_1
pb_5 pb_5
cb_close cb_close
pb_4 pb_4
pb_8 pb_8
pb_3 pb_3
dw_contact_list dw_contact_list
dw_customer_list dw_customer_list
dw_sales dw_sales
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
end type
global w_sales_contact_details w_sales_contact_details

on w_sales_contact_details.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_5=create pb_5
this.cb_close=create cb_close
this.pb_4=create pb_4
this.pb_8=create pb_8
this.pb_3=create pb_3
this.dw_contact_list=create dw_contact_list
this.dw_customer_list=create dw_customer_list
this.dw_sales=create dw_sales
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_5
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.pb_4
this.Control[iCurrent+5]=this.pb_8
this.Control[iCurrent+6]=this.pb_3
this.Control[iCurrent+7]=this.dw_contact_list
this.Control[iCurrent+8]=this.dw_customer_list
this.Control[iCurrent+9]=this.dw_sales
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_4
end on

on w_sales_contact_details.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_5)
destroy(this.cb_close)
destroy(this.pb_4)
destroy(this.pb_8)
destroy(this.pb_3)
destroy(this.dw_contact_list)
destroy(this.dw_customer_list)
destroy(this.dw_sales)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
end on

event open;call super::open;// customer list
dw_customer_list.of_SetLinkage(TRUE)

//contact list
dw_contact_list.of_SetLinkage( TRUE ) 
dw_contact_list.inv_Linkage.of_SetMaster(dw_customer_list)
IF NOT dw_contact_list.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked customer & contact list!" )
ELSE
	dw_contact_list.inv_Linkage.of_Register( "customer_id", "customer_id" ) 
	dw_contact_list.inv_Linkage.of_SetStyle( 2 ) 
END IF

//sales list
dw_sales.of_SetLinkage( TRUE ) 
dw_sales.inv_Linkage.of_SetMaster(dw_contact_list)
IF NOT dw_sales.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to linked contact & sales!" )
ELSE
	dw_sales.inv_Linkage.of_Register( "contact_id", "al_contact" ) 
	dw_sales.inv_Linkage.of_SetStyle( 2 ) 
END IF

dw_customer_list.inv_Linkage.of_SetTransObject(sqlca) 

IF dw_customer_list.inv_linkage.of_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_sales_contact_details:open" )
ELSE
	SQLCA.of_Commit()
	dw_customer_list.SetFocus()
End IF
end event

type pb_1 from u_pb within w_sales_contact_details
integer x = 3185
integer y = 61
integer width = 80
integer height = 70
integer taborder = 40
string text = ""
string picturename = "AddWatch5!"
string powertiptext = "Add"
end type

event clicked;call super::clicked;Long ll_row
s_quote_data lds_q

ll_row = dw_customer_list.GetRow()
IF ll_row > 0 THEN
	lds_q.customer_id = dw_customer_list.GetItemNumber(ll_row, "customer_id")
ELSE
	lds_q.customer_id = 0
END IF

ll_row = dw_contact_list.GetRow()
IF ll_row > 0 THEN
	lds_q.contact_id = dw_contact_list.GetItemNumber(ll_row, "contact_id")
ELSE
	lds_q.contact_id = 0
END IF

RETURN OpenWithParm(w_new_quote, lds_q)
end event

type pb_5 from u_pb within w_sales_contact_details
integer x = 3280
integer y = 61
integer width = 80
integer height = 70
integer taborder = 50
string text = ""
boolean originalsize = false
string picturename = "Next!"
string powertiptext = "Open"
end type

event clicked;call super::clicked;Long ll_row
s_quote_data lds_s

If dw_sales.RowCount() <= 0 THEN RETURN 0
ll_row = 0
ll_row = dw_sales.GetRow()
IF ll_row <= 0 THEN RETURN 0

lds_s.revision_id = dw_sales.GetItemNumber(ll_row, "sales_quote_quote_revision_id")
lds_s.quote_id = dw_sales.GetItemNumber(ll_row, "sales_quote_quote_id")
lds_s.contact_id = dw_sales.GetItemNumber(ll_row, "sales_quote_contact_id")

OpenWithParm(w_edit_quote, lds_s)

RETURN 1
end event

type cb_close from u_cb within w_sales_contact_details
integer x = 3028
integer y = 1722
integer width = 351
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "Exit"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_4 from u_pb within w_sales_contact_details
integer x = 1346
integer y = 1046
integer width = 80
integer height = 70
integer taborder = 60
string text = ""
boolean originalsize = false
string picturename = "Custom072!"
string powertiptext = "Edit"
end type

type pb_8 from u_pb within w_sales_contact_details
integer x = 1251
integer y = 1046
integer width = 80
integer height = 70
integer taborder = 50
string text = ""
string picturename = "Custom091!"
string powertiptext = "Cut"
end type

type pb_3 from u_pb within w_sales_contact_details
integer x = 1156
integer y = 1046
integer width = 80
integer height = 70
integer taborder = 40
string text = ""
string picturename = "AddWatch5!"
string powertiptext = "Add"
end type

type dw_contact_list from u_dw within w_sales_contact_details
integer x = 18
integer y = 1123
integer width = 1415
integer height = 570
integer taborder = 30
string dataobject = "d_sales_contact_list"
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetRowFocusIndicator(Hand!)
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type dw_customer_list from u_dw within w_sales_contact_details
integer x = 18
integer y = 80
integer width = 1419
integer height = 877
integer taborder = 30
string dataobject = "d_sales_customer_list"
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetBase(TRUE)
SetRowFocusIndicator(Hand!)

end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type dw_sales from u_dw within w_sales_contact_details
integer x = 1492
integer y = 141
integer width = 1876
integer height = 1552
integer taborder = 30
string dataobject = "d_sales_history_per_contact"
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type gb_1 from groupbox within w_sales_contact_details
integer y = 6
integer width = 1452
integer height = 982
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Customer"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_sales_contact_details
integer y = 998
integer width = 1448
integer height = 714
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217729
string text = "Contacts"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_sales_contact_details
integer x = 1463
integer y = 6
integer width = 1920
integer height = 1702
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Sales History"
borderstyle borderstyle = styleraised!
end type

