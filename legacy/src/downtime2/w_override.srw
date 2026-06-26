$PBExportHeader$w_override.srw
forward
global type w_override from w_response
end type
type cb_ok from commandbutton within w_override
end type
type cb_1 from commandbutton within w_override
end type
type rb_end_now from radiobutton within w_override
end type
type rb_600 from radiobutton within w_override
end type
type rb_1800 from radiobutton within w_override
end type
type rb_3600 from radiobutton within w_override
end type
type rb_7200 from radiobutton within w_override
end type
type gb_1 from groupbox within w_override
end type
end forward

global type w_override from w_response
integer x = 0
integer y = 0
integer width = 1273
integer height = 1430
string title = "Select shift override"
boolean controlmenu = false
cb_ok cb_ok
cb_1 cb_1
rb_end_now rb_end_now
rb_600 rb_600
rb_1800 rb_1800
rb_3600 rb_3600
rb_7200 rb_7200
gb_1 gb_1
end type
global w_override w_override

on w_override.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_1=create cb_1
this.rb_end_now=create rb_end_now
this.rb_600=create rb_600
this.rb_1800=create rb_1800
this.rb_3600=create rb_3600
this.rb_7200=create rb_7200
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.rb_end_now
this.Control[iCurrent+4]=this.rb_600
this.Control[iCurrent+5]=this.rb_1800
this.Control[iCurrent+6]=this.rb_3600
this.Control[iCurrent+7]=this.rb_7200
this.Control[iCurrent+8]=this.gb_1
end on

on w_override.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_1)
destroy(this.rb_end_now)
destroy(this.rb_600)
destroy(this.rb_1800)
destroy(this.rb_3600)
destroy(this.rb_7200)
destroy(this.gb_1)
end on

event open;call super::open;//if gi_screen =2 then
//	if gi_dual_mode = 2 then
//		//updown screen
//	end if
//	this.x = 6000
//	this.y = 600
//else
//	this.x = 600
//	this.y = 300
//end if

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

type cb_ok from commandbutton within w_override
integer x = 150
integer y = 995
integer width = 391
integer height = 147
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;if parent.rb_end_now.checked then
	CloseWithReturn(parent, -1)
elseif parent.rb_600.checked then
	CloseWithReturn(parent, 600)
elseif parent.rb_1800.checked then
	CloseWithReturn(parent, 1800)
elseif parent.rb_3600.checked then
	CloseWithReturn(parent, 3600)
elseif parent.rb_7200.checked then
	CloseWithReturn(parent, 7200)
else
	CloseWithReturn(parent, -1)
end if
				

//if parent.st_password.text = "1234" then
//	CloseWithReturn(parent, 1)
//else
//
//end if
end event

type cb_1 from commandbutton within w_override
integer x = 669
integer y = 995
integer width = 391
integer height = 147
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

type rb_end_now from radiobutton within w_override
integer x = 315
integer y = 192
integer width = 640
integer height = 115
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "End shift now"
boolean checked = true
end type

type rb_600 from radiobutton within w_override
integer x = 315
integer y = 323
integer width = 640
integer height = 115
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Extend 10 min."
end type

type rb_1800 from radiobutton within w_override
integer x = 315
integer y = 454
integer width = 640
integer height = 115
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Extend 30 min"
end type

type rb_3600 from radiobutton within w_override
integer x = 315
integer y = 586
integer width = 640
integer height = 115
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Extend 1 hour"
end type

type rb_7200 from radiobutton within w_override
integer x = 315
integer y = 717
integer width = 640
integer height = 115
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Extend 2 hour"
end type

type gb_1 from groupbox within w_override
integer x = 154
integer y = 70
integer width = 900
integer height = 854
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Override shift ending"
end type

