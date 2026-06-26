$PBExportHeader$w_order_entry_pn_list_backup.srw
$PBExportComments$<Response> List customer parts and all information about each part, based on customer. Inherited from pfemain\w_sheet
forward
global type w_order_entry_pn_list_backup from w_sheet
end type
type st_4 from statictext within w_order_entry_pn_list_backup
end type
type st_3 from statictext within w_order_entry_pn_list_backup
end type
type st_2 from statictext within w_order_entry_pn_list_backup
end type
type dw_pn_list from u_dw within w_order_entry_pn_list_backup
end type
type dw_type from u_dw within w_order_entry_pn_list_backup
end type
type dw_pn from u_dw within w_order_entry_pn_list_backup
end type
type rb_showall from u_rb within w_order_entry_pn_list_backup
end type
type rb_activeonly from u_rb within w_order_entry_pn_list_backup
end type
type cb_select from u_cb within w_order_entry_pn_list_backup
end type
type dw_customer from u_dw within w_order_entry_pn_list_backup
end type
type cb_close from u_cb within w_order_entry_pn_list_backup
end type
type ddlb_customer from dropdownlistbox within w_order_entry_pn_list_backup
end type
type st_1 from statictext within w_order_entry_pn_list_backup
end type
type gb_display from u_gb within w_order_entry_pn_list_backup
end type
end forward

global type w_order_entry_pn_list_backup from w_sheet
integer x = 4
integer y = 3
integer width = 3544
integer height = 2090
string title = "Customer Part Number management"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
st_4 st_4
st_3 st_3
st_2 st_2
dw_pn_list dw_pn_list
dw_type dw_type
dw_pn dw_pn
rb_showall rb_showall
rb_activeonly rb_activeonly
cb_select cb_select
dw_customer dw_customer
cb_close cb_close
ddlb_customer ddlb_customer
st_1 st_1
gb_display gb_display
end type
global w_order_entry_pn_list_backup w_order_entry_pn_list_backup

type variables
Long il_id
String is_type
Integer ii_status
end variables

on w_order_entry_pn_list_backup.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_pn_list=create dw_pn_list
this.dw_type=create dw_type
this.dw_pn=create dw_pn
this.rb_showall=create rb_showall
this.rb_activeonly=create rb_activeonly
this.cb_select=create cb_select
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.gb_display=create gb_display
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_pn_list
this.Control[iCurrent+5]=this.dw_type
this.Control[iCurrent+6]=this.dw_pn
this.Control[iCurrent+7]=this.rb_showall
this.Control[iCurrent+8]=this.rb_activeonly
this.Control[iCurrent+9]=this.cb_select
this.Control[iCurrent+10]=this.dw_customer
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.ddlb_customer
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.gb_display
end on

on w_order_entry_pn_list_backup.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_pn_list)
destroy(this.dw_type)
destroy(this.dw_pn)
destroy(this.rb_showall)
destroy(this.rb_activeonly)
destroy(this.cb_select)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.gb_display)
end on

event open;call super::open;ii_status = 1  //active only

dw_customer.Visible = FALSE
dw_customer.SetTransObject(sqlca) 
IF dw_customer.retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_prod_num_management::open function" )
ELSE
	dw_customer.SelectRow(1,TRUE)
	dw_customer.SetFocus()
End IF

Long ll_row, ll_i, ll_id
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN
	ll_id = dw_customer.GetItemNumber(1, "customer_id")
	
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
	ddlb_customer.SelectItem(1)
	
	dw_pn_list.Retrieve(ll_id, ii_status)
	dw_pn_list.SelectRow(0, FALSE)
	dw_pn_list.SelectRow(1, TRUE)
	il_id = dw_pn_list.GetItemNumber(1, "part_num_id")
	is_type = dw_pn_list.GetItemString(1, "sheet_type")
	dw_pn.Retrieve(il_id)
	dw_type.Event ue_show_shape(il_id, is_type)

END IF

end event

type st_4 from statictext within w_order_entry_pn_list_backup
integer x = 933
integer y = 1520
integer width = 227
integer height = 45
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
string text = "Obsoleted"
boolean focusrectangle = false
end type

type st_3 from statictext within w_order_entry_pn_list_backup
integer x = 761
integer y = 1520
integer width = 157
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Active"
boolean focusrectangle = false
end type

type st_2 from statictext within w_order_entry_pn_list_backup
integer x = 399
integer y = 1520
integer width = 351
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Color Indication:"
boolean focusrectangle = false
end type

type dw_pn_list from u_dw within w_order_entry_pn_list_backup
event type long ue_show_only ( )
integer y = 176
integer width = 1554
integer height = 1331
integer taborder = 30
boolean titlebar = true
string dataobject = "d_pn_list_per_customer"
end type

event type long ue_show_only();Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN
	il_id = dw_customer.GetItemNumber(1, "customer_id")
	
	ddlb_customer.SelectItem(1)

	dw_pn_list.Retrieve(il_id, ii_status)
	dw_pn_list.SelectRow(0, FALSE)
	dw_pn_list.SelectRow(1, TRUE)
	IF dw_pn_list.RowCount() > 0 THEN 
		il_id = dw_pn_list.GetItemNumber(1, "part_num_id")
		is_type = dw_pn_list.GetItemString(1, "sheet_type")
	END IF
	dw_pn.Retrieve(il_id)
	dw_type.Event ue_show_shape(il_id, is_type)
ELSE
	RETURN 0
END IF

RETURN 1

end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_sort.of_SetUseDisplay(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)
SetTransObject(SQLCA)
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

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

event clicked;int li_rc, li_status

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

//my code

IF row <= 0 THEN return

this.selectrow(0, FALSE)
this.selectrow(row, TRUE)

il_id = this.GetItemNumber(row, "part_num_id")
IF il_id <= 0 THEN 
	MessageBox("Error", "Invalid part id!")
	Return 
END IF

is_type = this.GetItemString(row, "sheet_type")
IF IsNULL(is_type) THEN 
	MessageBox("Error", "Invalid sheet type")
	Return 
END IF

SetPointer(HourGlass!)

dw_pn.Retrieve(il_id)
dw_type.Event ue_show_shape(il_id,is_type)

RETURN

end event

type dw_type from u_dw within w_order_entry_pn_list_backup
event type long ue_show_shape ( long al_id,  string as_shape )
integer x = 1558
integer y = 1261
integer width = 1968
integer height = 618
integer taborder = 70
string dataobject = "d_pn_ltrapezoid_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event type long ue_show_shape(long al_id, string as_shape);CHOOSE CASE Upper(Trim(as_shape))
	CASE "RECTANGLE"
		this.DataObject = "d_pn_rectangle_display"
	CASE "PARALLELOGRAM"
		this.DataObject = "d_pn_parallelogram_display"
	CASE "FENDER"
		this.DataObject = "d_pn_fender_display"
	CASE "CHEVRON"
		this.DataObject = "d_pn_chevron_display"
	CASE "CIRCLE"
		this.DataObject = "d_pn_circle_display"
	CASE "TRAPEZOID"
		this.DataObject = "d_pn_trapezoid_display"
	CASE "L.TRAPEZOID"
		this.DataObject = "d_pn_ltrapezoid_display"
	CASE "R.TRAPEZOID"
		this.DataObject = "d_pn_rtrapezoid_display"
	CASE "REINFORCEMENT"
		this.DataObject = "d_pn_reinforcement_display"
	CASE "LIFTGATE"
		this.DataObject = "d_pn_liftgate_shape_display"	
	CASE ELSE
		this.DataObject = "d_pn_x1shape_display"
END CHOOSE
this.SetTransObject(SQLCA)
this.Retrieve(al_id)

RETURN 1
end event

type dw_pn from u_dw within w_order_entry_pn_list_backup
integer x = 1558
integer width = 1968
integer height = 1267
integer taborder = 60
string dataobject = "d_pn_item_detail_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;SetTransObject(SQLCA)

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

type rb_showall from u_rb within w_order_entry_pn_list_backup
integer x = 790
integer y = 1648
integer width = 315
string facename = "Arial"
string text = "Show All"
end type

event clicked;call super::clicked;ii_status = 0 //show all

RETURN dw_pn_list.Event ue_show_only()

end event

type rb_activeonly from u_rb within w_order_entry_pn_list_backup
integer x = 366
integer y = 1648
integer width = 322
string facename = "Arial"
string text = "Active Only"
boolean checked = true
end type

event clicked;call super::clicked;ii_status = 1 //active only

RETURN dw_pn_list.Event ue_show_only()
end event

type cb_select from u_cb within w_order_entry_pn_list_backup
integer x = 958
integer y = 1885
integer width = 340
integer height = 90
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;ClosewithReturn(Parent, il_id)
end event

type dw_customer from u_dw within w_order_entry_pn_list_backup
integer x = 655
integer y = 6
integer width = 95
integer height = 35
integer taborder = 0
string dataobject = "d_pn_customer_short_display"
boolean vscrollbar = false
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
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 


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

type cb_close from u_cb within w_order_entry_pn_list_backup
string tag = "Exit"
integer x = 1993
integer y = 1885
integer width = 340
integer height = 90
integer taborder = 80
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;ClosewithReturn(Parent, 0)
end event

type ddlb_customer from dropdownlistbox within w_order_entry_pn_list_backup
integer x = 55
integer y = 77
integer width = 1360
integer height = 995
integer taborder = 20
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

event selectionchanged;String ls_text, ls_type
Long ll_row, ll_i, ll_id, ll_pid

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		ll_id = dw_customer.GetItemNumber(ll_i, "customer_id")
		dw_pn_list.Retrieve(ll_id, ii_status)
		dw_pn_list.SelectRow(0, FALSE)
		dw_pn_list.SelectRow(1, TRUE)
		ll_pid = dw_pn_list.GetItemNumber(1, "part_num_id")
		ls_type = dw_pn_list.GetItemString(1, "sheet_type")
		dw_pn.Retrieve(ll_pid)
		dw_type.Event ue_show_shape(ll_pid, ls_type)
	END IF
NEXT

end event

type st_1 from statictext within w_order_entry_pn_list_backup
integer x = 55
integer y = 16
integer width = 424
integer height = 61
boolean bringtotop = true
integer textsize = -8
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

type gb_display from u_gb within w_order_entry_pn_list_backup
integer x = 271
integer y = 1587
integer width = 958
integer height = 154
integer taborder = 11
string facename = "Arial"
string text = "Display"
end type

