$PBExportHeader$w_production_control_validation.srw
forward
global type w_production_control_validation from w_response
end type
type cb_ok from commandbutton within w_production_control_validation
end type
type cb_1 from commandbutton within w_production_control_validation
end type
type st_password from statictext within w_production_control_validation
end type
type st_2 from statictext within w_production_control_validation
end type
type st_super_name from statictext within w_production_control_validation
end type
type st_1 from statictext within w_production_control_validation
end type
type st_warning from statictext within w_production_control_validation
end type
end forward

global type w_production_control_validation from w_response
integer x = 0
integer y = 0
integer width = 1924
integer height = 1155
string title = "enter supervisor password"
boolean controlmenu = false
boolean center = true
boolean ib_isupdateable = false
cb_ok cb_ok
cb_1 cb_1
st_password st_password
st_2 st_2
st_super_name st_super_name
st_1 st_1
st_warning st_warning
end type
global w_production_control_validation w_production_control_validation

type variables
w_enter_num iw_enter_num
string password
end variables

on w_production_control_validation.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_1=create cb_1
this.st_password=create st_password
this.st_2=create st_2
this.st_super_name=create st_super_name
this.st_1=create st_1
this.st_warning=create st_warning
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_password
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_super_name
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_warning
end on

on w_production_control_validation.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_1)
destroy(this.st_password)
destroy(this.st_2)
destroy(this.st_super_name)
destroy(this.st_1)
destroy(this.st_warning)
end on

event close;call super::close;if isValid(iw_enter_num) then
	close(iw_enter_num)
end if
end event

event open;call super::open;password = message.stringparm
end event

type cb_ok from commandbutton within w_production_control_validation
integer x = 227
integer y = 810
integer width = 622
integer height = 166
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;if parent.st_password.text = password then
	CloseWithReturn(parent, 1)
else
	parent.st_warning.visible = true
end if
end event

type cb_1 from commandbutton within w_production_control_validation
integer x = 1119
integer y = 810
integer width = 622
integer height = 166
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;CloseWithReturn(parent, 0)
end event

type st_password from statictext within w_production_control_validation
string tag = "dt_min_1"
integer x = 684
integer y = 442
integer width = 574
integer height = 138
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;s_position ls_p
ls_p.x = x
ls_p.y = y
OpenWithParm(iw_enter_num, ls_p, parent)
if not isValid( this ) then
	return 0
end if
this.text = Message.StringParm


end event

type st_2 from statictext within w_production_control_validation
integer x = 59
integer y = 205
integer width = 1393
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Please enter your password:"
boolean focusrectangle = false
end type

type st_super_name from statictext within w_production_control_validation
integer x = 1317
integer y = 74
integer width = 545
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within w_production_control_validation
integer x = 62
integer y = 70
integer width = 1247
integer height = 102
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Production control supervisor"
boolean focusrectangle = false
end type

type st_warning from statictext within w_production_control_validation
boolean visible = false
integer x = 530
integer y = 630
integer width = 841
integer height = 102
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "Wrong password"
boolean focusrectangle = false
end type

