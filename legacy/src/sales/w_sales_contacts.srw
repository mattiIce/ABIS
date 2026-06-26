$PBExportHeader$w_sales_contacts.srw
$PBExportComments$contact list for sales app
forward
global type w_sales_contacts from w_child
end type
type cbx_quote from u_cbx within w_sales_contacts
end type
type dw_1 from u_dw within w_sales_contacts
end type
type pb_9 from u_pb within w_sales_contacts
end type
type em_1 from editmask within w_sales_contacts
end type
type ddlb_2 from dropdownlistbox within w_sales_contacts
end type
type ddlb_1 from dropdownlistbox within w_sales_contacts
end type
type st_1 from statictext within w_sales_contacts
end type
type pb_8 from u_pb within w_sales_contacts
end type
type pb_7 from u_pb within w_sales_contacts
end type
type pb_6 from u_pb within w_sales_contacts
end type
type pb_5 from u_pb within w_sales_contacts
end type
type pb_3 from u_pb within w_sales_contacts
end type
type pb_2 from u_pb within w_sales_contacts
end type
type pb_1 from u_pb within w_sales_contacts
end type
type gb_1 from groupbox within w_sales_contacts
end type
end forward

global type w_sales_contacts from w_child
integer width = 3032
integer height = 1760
string title = "Contact List"
boolean resizable = false
long backcolor = 134217752
cbx_quote cbx_quote
dw_1 dw_1
pb_9 pb_9
em_1 em_1
ddlb_2 ddlb_2
ddlb_1 ddlb_1
st_1 st_1
pb_8 pb_8
pb_7 pb_7
pb_6 pb_6
pb_5 pb_5
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
gb_1 gb_1
end type
global w_sales_contacts w_sales_contacts

on w_sales_contacts.create
int iCurrent
call super::create
this.cbx_quote=create cbx_quote
this.dw_1=create dw_1
this.pb_9=create pb_9
this.em_1=create em_1
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_quote
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.pb_9
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.ddlb_2
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.pb_8
this.Control[iCurrent+9]=this.pb_7
this.Control[iCurrent+10]=this.pb_6
this.Control[iCurrent+11]=this.pb_5
this.Control[iCurrent+12]=this.pb_3
this.Control[iCurrent+13]=this.pb_2
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.gb_1
end on

on w_sales_contacts.destroy
call super::destroy
destroy(this.cbx_quote)
destroy(this.dw_1)
destroy(this.pb_9)
destroy(this.em_1)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.gb_1)
end on

type cbx_quote from u_cbx within w_sales_contacts
integer x = 2008
integer y = 1616
integer width = 1002
integer weight = 700
string facename = "Arial"
long backcolor = 15793151
string text = "Show only contacts with active quotes"
boolean checked = true
end type

type dw_1 from u_dw within w_sales_contacts
integer x = 11
integer y = 170
integer width = 3003
integer height = 1440
integer taborder = 120
end type

type pb_9 from u_pb within w_sales_contacts
integer x = 1872
integer y = 54
integer width = 99
integer height = 80
integer taborder = 120
string text = ""
boolean originalsize = false
string picturename = "Custom026!"
end type

type em_1 from editmask within w_sales_contacts
integer x = 1225
integer y = 61
integer width = 633
integer height = 77
integer taborder = 110
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type ddlb_2 from dropdownlistbox within w_sales_contacts
integer x = 881
integer y = 61
integer width = 336
integer height = 339
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"contains","is","like",""}
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_sales_contacts
integer x = 252
integer y = 61
integer width = 622
integer height = 339
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Company name","Person first name","Person last name","Title"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_sales_contacts
integer x = 84
integer y = 70
integer width = 161
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Show "
long bordercolor = 134217752
boolean focusrectangle = false
end type

type pb_8 from u_pb within w_sales_contacts
integer x = 2278
integer y = 77
integer width = 99
integer height = 80
integer taborder = 80
string text = ""
boolean originalsize = false
string picturename = "Custom091!"
string powertiptext = "Cut"
end type

type pb_7 from u_pb within w_sales_contacts
integer x = 2776
integer y = 77
integer width = 99
integer height = 80
integer taborder = 70
string text = ""
boolean originalsize = false
string picturename = "Custom065!"
string powertiptext = "Search"
end type

type pb_6 from u_pb within w_sales_contacts
integer x = 2900
integer y = 77
integer width = 99
integer height = 80
integer taborder = 60
string text = ""
boolean originalsize = false
string picturename = "Exit!"
string powertiptext = "Exit"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_5 from u_pb within w_sales_contacts
integer x = 2651
integer y = 77
integer width = 99
integer height = 80
integer taborder = 50
string text = ""
boolean originalsize = false
string picturename = "Custom074!"
string powertiptext = "Print"
end type

type pb_3 from u_pb within w_sales_contacts
integer x = 2527
integer y = 77
integer width = 99
integer height = 80
integer taborder = 30
string text = ""
boolean originalsize = false
string picturename = "Next!"
string powertiptext = "Open"
end type

type pb_2 from u_pb within w_sales_contacts
integer x = 2403
integer y = 77
integer width = 99
integer height = 80
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "Custom072!"
string powertiptext = "Edit"
end type

type pb_1 from u_pb within w_sales_contacts
integer x = 2154
integer y = 77
integer width = 99
integer height = 80
integer taborder = 10
string text = ""
boolean originalsize = false
string picturename = "AddWatch5!"
string powertiptext = "Add"
end type

type gb_1 from groupbox within w_sales_contacts
integer x = 11
integer y = 6
integer width = 1997
integer height = 141
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Filter"
borderstyle borderstyle = styleraised!
end type

