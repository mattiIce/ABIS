$PBExportHeader$w_enter_num.srw
forward
global type w_enter_num from w_response
end type
type sle_num from singlelineedit within w_enter_num
end type
type cb_d_7 from commandbutton within w_enter_num
end type
type cb_d_4 from commandbutton within w_enter_num
end type
type cb_d_1 from commandbutton within w_enter_num
end type
type cb_d_2 from commandbutton within w_enter_num
end type
type cb_d_5 from commandbutton within w_enter_num
end type
type cb_d_8 from commandbutton within w_enter_num
end type
type cb_d_3 from commandbutton within w_enter_num
end type
type cb_d_6 from commandbutton within w_enter_num
end type
type cb_d_9 from commandbutton within w_enter_num
end type
type cb_d_0 from commandbutton within w_enter_num
end type
type cb_clear from commandbutton within w_enter_num
end type
type cb_ok from commandbutton within w_enter_num
end type
end forward

global type w_enter_num from w_response
integer x = 0
integer y = 0
integer width = 783
integer height = 1197
boolean ib_isupdateable = false
sle_num sle_num
cb_d_7 cb_d_7
cb_d_4 cb_d_4
cb_d_1 cb_d_1
cb_d_2 cb_d_2
cb_d_5 cb_d_5
cb_d_8 cb_d_8
cb_d_3 cb_d_3
cb_d_6 cb_d_6
cb_d_9 cb_d_9
cb_d_0 cb_d_0
cb_clear cb_clear
cb_ok cb_ok
end type
global w_enter_num w_enter_num

on w_enter_num.create
int iCurrent
call super::create
this.sle_num=create sle_num
this.cb_d_7=create cb_d_7
this.cb_d_4=create cb_d_4
this.cb_d_1=create cb_d_1
this.cb_d_2=create cb_d_2
this.cb_d_5=create cb_d_5
this.cb_d_8=create cb_d_8
this.cb_d_3=create cb_d_3
this.cb_d_6=create cb_d_6
this.cb_d_9=create cb_d_9
this.cb_d_0=create cb_d_0
this.cb_clear=create cb_clear
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_num
this.Control[iCurrent+2]=this.cb_d_7
this.Control[iCurrent+3]=this.cb_d_4
this.Control[iCurrent+4]=this.cb_d_1
this.Control[iCurrent+5]=this.cb_d_2
this.Control[iCurrent+6]=this.cb_d_5
this.Control[iCurrent+7]=this.cb_d_8
this.Control[iCurrent+8]=this.cb_d_3
this.Control[iCurrent+9]=this.cb_d_6
this.Control[iCurrent+10]=this.cb_d_9
this.Control[iCurrent+11]=this.cb_d_0
this.Control[iCurrent+12]=this.cb_clear
this.Control[iCurrent+13]=this.cb_ok
end on

on w_enter_num.destroy
call super::destroy
destroy(this.sle_num)
destroy(this.cb_d_7)
destroy(this.cb_d_4)
destroy(this.cb_d_1)
destroy(this.cb_d_2)
destroy(this.cb_d_5)
destroy(this.cb_d_8)
destroy(this.cb_d_3)
destroy(this.cb_d_6)
destroy(this.cb_d_9)
destroy(this.cb_d_0)
destroy(this.cb_clear)
destroy(this.cb_ok)
end on

event open;call super::open;s_position ls_position

ls_position = Message.PowerObjectParm
this.x = ls_position.x + 168
this.y = ls_position.y + 110
//messageBox(string(this.x),string(this.y))


if gi_screen = 2 then
	if gi_dual_mode = 2 then
		this.x = 1200
		this.y = 4000
	else
		this.x = 7000
		this.y = 600
	end if
else
	this.x = 1200
	this.y = 600
end if
end event

type sle_num from singlelineedit within w_enter_num
integer x = 33
integer y = 35
integer width = 684
integer height = 118
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type cb_d_7 from commandbutton within w_enter_num
integer x = 37
integer y = 186
integer width = 197
integer height = 154
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "7"
end type

event clicked;sle_num.text = sle_num.text + '7'
end event

type cb_d_4 from commandbutton within w_enter_num
integer x = 44
integer y = 371
integer width = 197
integer height = 154
integer taborder = 30
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "4"
end type

event clicked;sle_num.text = sle_num.text + '4'
end event

type cb_d_1 from commandbutton within w_enter_num
integer x = 44
integer y = 557
integer width = 197
integer height = 154
integer taborder = 40
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "1"
end type

event clicked;sle_num.text = sle_num.text + '1'
end event

type cb_d_2 from commandbutton within w_enter_num
integer x = 282
integer y = 557
integer width = 197
integer height = 154
integer taborder = 40
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "2"
end type

event clicked;sle_num.text = sle_num.text + '2'
end event

type cb_d_5 from commandbutton within w_enter_num
integer x = 282
integer y = 371
integer width = 197
integer height = 154
integer taborder = 30
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "5"
end type

event clicked;sle_num.text = sle_num.text + '5'
end event

type cb_d_8 from commandbutton within w_enter_num
integer x = 282
integer y = 186
integer width = 197
integer height = 154
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "8"
end type

event clicked;sle_num.text = sle_num.text + '8'
end event

type cb_d_3 from commandbutton within w_enter_num
integer x = 527
integer y = 557
integer width = 197
integer height = 154
integer taborder = 30
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "3"
end type

event clicked;sle_num.text = sle_num.text + '3'
end event

type cb_d_6 from commandbutton within w_enter_num
integer x = 527
integer y = 371
integer width = 197
integer height = 154
integer taborder = 20
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "6"
end type

event clicked;sle_num.text = sle_num.text + '6'
end event

type cb_d_9 from commandbutton within w_enter_num
integer x = 527
integer y = 186
integer width = 197
integer height = 154
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "9"
end type

event clicked;sle_num.text = sle_num.text + '9'
end event

type cb_d_0 from commandbutton within w_enter_num
integer x = 48
integer y = 742
integer width = 197
integer height = 154
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
end type

event clicked;sle_num.text = sle_num.text + '0'
end event

type cb_clear from commandbutton within w_enter_num
integer x = 285
integer y = 742
integer width = 435
integer height = 154
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear"
end type

event clicked;sle_num.text = ""
end event

type cb_ok from commandbutton within w_enter_num
integer x = 51
integer y = 925
integer width = 669
integer height = 154
integer taborder = 10
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Enter"
end type

event clicked;CloseWithReturn(parent, sle_num.text)

end event

