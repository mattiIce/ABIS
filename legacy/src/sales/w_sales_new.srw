$PBExportHeader$w_sales_new.srw
$PBExportComments$list of new objects inherited from w_response
forward
global type w_sales_new from w_response
end type
type cb_1 from commandbutton within w_sales_new
end type
type st_10 from statictext within w_sales_new
end type
type pb_10 from picturebutton within w_sales_new
end type
type st_8 from statictext within w_sales_new
end type
type pb_8 from picturebutton within w_sales_new
end type
type st_7 from statictext within w_sales_new
end type
type pb_7 from picturebutton within w_sales_new
end type
type st_6 from statictext within w_sales_new
end type
type pb_6 from picturebutton within w_sales_new
end type
type st_5 from statictext within w_sales_new
end type
type st_4 from statictext within w_sales_new
end type
type st_3 from statictext within w_sales_new
end type
type st_2 from statictext within w_sales_new
end type
type st_1 from statictext within w_sales_new
end type
type pb_5 from picturebutton within w_sales_new
end type
type pb_4 from picturebutton within w_sales_new
end type
type pb_3 from picturebutton within w_sales_new
end type
type pb_2 from picturebutton within w_sales_new
end type
type pb_1 from picturebutton within w_sales_new
end type
end forward

global type w_sales_new from w_response
integer width = 2150
integer height = 803
string title = "Select a new object"
long backcolor = 67108864
cb_1 cb_1
st_10 st_10
pb_10 pb_10
st_8 st_8
pb_8 pb_8
st_7 st_7
pb_7 pb_7
st_6 st_6
pb_6 pb_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
end type
global w_sales_new w_sales_new

on w_sales_new.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_10=create st_10
this.pb_10=create pb_10
this.st_8=create st_8
this.pb_8=create pb_8
this.st_7=create st_7
this.pb_7=create pb_7
this.st_6=create st_6
this.pb_6=create pb_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_10
this.Control[iCurrent+3]=this.pb_10
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.pb_8
this.Control[iCurrent+6]=this.st_7
this.Control[iCurrent+7]=this.pb_7
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.pb_6
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.pb_5
this.Control[iCurrent+16]=this.pb_4
this.Control[iCurrent+17]=this.pb_3
this.Control[iCurrent+18]=this.pb_2
this.Control[iCurrent+19]=this.pb_1
end on

on w_sales_new.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_10)
destroy(this.pb_10)
destroy(this.st_8)
destroy(this.pb_8)
destroy(this.st_7)
destroy(this.pb_7)
destroy(this.st_6)
destroy(this.pb_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
end on

type cb_1 from commandbutton within w_sales_new
integer x = 808
integer y = 608
integer width = 505
integer height = 93
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;ClosewithReturn(Parent, "")
end event

type st_10 from statictext within w_sales_new
integer x = 1781
integer y = 416
integer width = 347
integer height = 83
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Report"
boolean focusrectangle = false
end type

type pb_10 from picturebutton within w_sales_new
integer x = 1573
integer y = 387
integer width = 161
integer height = 141
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "CrossTab!"
vtextalign vtextalign = vcenter!
end type

type st_8 from statictext within w_sales_new
integer x = 1781
integer y = 64
integer width = 336
integer height = 83
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Catalog"
boolean focusrectangle = false
end type

type pb_8 from picturebutton within w_sales_new
integer x = 1573
integer y = 35
integer width = 161
integer height = 141
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "UserObject!"
vtextalign vtextalign = vcenter!
end type

type st_7 from statictext within w_sales_new
integer x = 991
integer y = 250
integer width = 402
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contact"
boolean focusrectangle = false
end type

type pb_7 from picturebutton within w_sales_new
integer x = 786
integer y = 211
integer width = 161
integer height = 141
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Properties!"
vtextalign vtextalign = vcenter!
end type

type st_6 from statictext within w_sales_new
integer x = 991
integer y = 67
integer width = 369
integer height = 77
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Customer"
boolean focusrectangle = false
end type

type pb_6 from picturebutton within w_sales_new
integer x = 786
integer y = 35
integer width = 161
integer height = 141
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Application!"
vtextalign vtextalign = vcenter!
end type

type st_5 from statictext within w_sales_new
integer x = 1781
integer y = 246
integer width = 325
integer height = 74
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quote"
boolean focusrectangle = false
end type

type st_4 from statictext within w_sales_new
integer x = 991
integer y = 416
integer width = 472
integer height = 83
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Appointment"
boolean focusrectangle = false
end type

type st_3 from statictext within w_sales_new
integer x = 201
integer y = 426
integer width = 402
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Memo"
boolean focusrectangle = false
end type

type st_2 from statictext within w_sales_new
integer x = 201
integer y = 243
integer width = 534
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Voice Message"
boolean focusrectangle = false
end type

type st_1 from statictext within w_sales_new
integer x = 201
integer y = 74
integer width = 322
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Email"
boolean focusrectangle = false
end type

type pb_5 from picturebutton within w_sales_new
integer x = 1573
integer y = 211
integer width = 161
integer height = 141
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Compute!"
vtextalign vtextalign = vcenter!
end type

event clicked;CloseWithReturn(Parent, "w_new_quote")
end event

type pb_4 from picturebutton within w_sales_new
integer x = 786
integer y = 387
integer width = 161
integer height = 141
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom023!"
vtextalign vtextalign = vcenter!
end type

type pb_3 from picturebutton within w_sales_new
integer x = 15
integer y = 387
integer width = 161
integer height = 141
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom070!"
vtextalign vtextalign = vcenter!
end type

type pb_2 from picturebutton within w_sales_new
integer x = 15
integer y = 211
integer width = 161
integer height = 141
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom011!"
vtextalign vtextalign = vcenter!
end type

type pb_1 from picturebutton within w_sales_new
integer x = 15
integer y = 35
integer width = 161
integer height = 141
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom002!"
vtextalign vtextalign = vcenter!
end type

