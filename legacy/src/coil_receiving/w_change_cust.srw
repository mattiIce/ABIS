$PBExportHeader$w_change_cust.srw
forward
global type w_change_cust from window
end type
type st_4 from statictext within w_change_cust
end type
type st_3 from statictext within w_change_cust
end type
type st_customer_to from statictext within w_change_cust
end type
type st_customer_from from statictext within w_change_cust
end type
type st_2 from statictext within w_change_cust
end type
type st_coil_abc_num from statictext within w_change_cust
end type
type st_1 from statictext within w_change_cust
end type
type cb_cancel from commandbutton within w_change_cust
end type
type cb_ok from commandbutton within w_change_cust
end type
type dw_general_customer from datawindow within w_change_cust
end type
end forward

global type w_change_cust from window
integer width = 1423
integer height = 1136
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_4 st_4
st_3 st_3
st_customer_to st_customer_to
st_customer_from st_customer_from
st_2 st_2
st_coil_abc_num st_coil_abc_num
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_general_customer dw_general_customer
end type
global w_change_cust w_change_cust

type variables
//Long	il_customer_id

Long 			il_customer_id_from, il_customer_id_to, il_coil_abc_num
String		is_customer_short_name_from, is_customer_short_name_to
DataWindow	idw_coil_list //Alex Gerlants. 02/25/2021. 1108_Change_Coil_Customer_on_Receiving_Screen
end variables

on w_change_cust.create
this.st_4=create st_4
this.st_3=create st_3
this.st_customer_to=create st_customer_to
this.st_customer_from=create st_customer_from
this.st_2=create st_2
this.st_coil_abc_num=create st_coil_abc_num
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_general_customer=create dw_general_customer
this.Control[]={this.st_4,&
this.st_3,&
this.st_customer_to,&
this.st_customer_from,&
this.st_2,&
this.st_coil_abc_num,&
this.st_1,&
this.cb_cancel,&
this.cb_ok,&
this.dw_general_customer}
end on

on w_change_cust.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_customer_to)
destroy(this.st_customer_from)
destroy(this.st_2)
destroy(this.st_coil_abc_num)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_general_customer)
end on

event open;Long 						ll_customer_id_from, ll_customer_id_to, ll_coil_abc_num, ll_row, ll_i
Integer					li_rtn
DataWindowChild		ldwc
String					ls_customer_short_name_from, ls_customer_short_name_to
str_all_data_types	lstr_all_data_types

lstr_all_data_types = Message.PowerObjectParm

//idw_coil_list = lstr_all_data_types.datawindow_var[1]
il_coil_abc_num = lstr_all_data_types.long_var[2]
ll_customer_id_from = lstr_all_data_types.long_var[1]
is_customer_short_name_from = lstr_all_data_types.string_var[1]

st_coil_abc_num.Text = String(il_coil_abc_num)
st_customer_from.Text = is_customer_short_name_from

li_rtn = dw_general_customer.GetChild("customer_id", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	ll_row = ldwc.Retrieve()
End If
end event

type st_4 from statictext within w_change_cust
integer x = 48
integer y = 16
integer width = 497
integer height = 67
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "New Customer:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_change_cust
integer x = 48
integer y = 662
integer width = 457
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Change Customer To"
boolean focusrectangle = false
end type

type st_customer_to from statictext within w_change_cust
integer x = 48
integer y = 733
integer width = 1309
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_customer_from from statictext within w_change_cust
integer x = 44
integer y = 557
integer width = 1309
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_change_cust
integer x = 44
integer y = 486
integer width = 516
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Change Customer From"
boolean focusrectangle = false
end type

type st_coil_abc_num from statictext within w_change_cust
integer x = 48
integer y = 381
integer width = 512
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_change_cust
integer x = 48
integer y = 314
integer width = 384
integer height = 67
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coil ABC Number"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_change_cust
integer x = 746
integer y = 893
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;str_all_data_types	lstr_all_data_types

lstr_all_data_types.string_var[1] = "cancel"

CloseWithReturn(Parent, lstr_all_data_types)
end event

type cb_ok from commandbutton within w_change_cust
integer x = 285
integer y = 893
integer width = 322
integer height = 90
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;str_all_data_types	lstr_all_data_types

lstr_all_data_types.long_var[1] = il_customer_id_to
lstr_all_data_types.string_var[1] = is_customer_short_name_to
//lstr_all_data_types.string_var[1] = is_customer_short_name_from

CloseWithReturn(Parent, lstr_all_data_types)
end event

type dw_general_customer from datawindow within w_change_cust
integer x = 48
integer y = 86
integer width = 709
integer height = 83
integer taborder = 10
string title = "none"
string dataobject = "d_general_customer"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.InsertRow(0)
end event

event itemchanged;String					ls_cust, ls_find_string
Long						ll_cust, ll_found_row
Integer					li_rtn
DataWindowChild		ldwc

ls_cust = data

If IsNumber(ls_cust) Then
	il_customer_id_to = Long(ls_cust)
End If

li_rtn = dw_general_customer.GetChild("customer_id", ldwc)

If li_rtn = 1 Then //OK

	ls_find_string = "customer_id = " + String(il_customer_id_to)
	ll_found_row = ldwc.Find(ls_find_string, 1, ldwc.RowCount())
	
	If ll_found_row > 0 Then
		is_customer_short_name_to = ldwc.GetItemString(ll_found_row, "customer_short_name")
		st_customer_to.Text = is_customer_short_name_to
	End If
End If
end event

