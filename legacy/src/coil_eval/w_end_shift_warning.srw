$PBExportHeader$w_end_shift_warning.srw
forward
global type w_end_shift_warning from window
end type
type cb_no from commandbutton within w_end_shift_warning
end type
type cb_yes from commandbutton within w_end_shift_warning
end type
type st_continue from statictext within w_end_shift_warning
end type
type st_das_warning from statictext within w_end_shift_warning
end type
type st_end_shift_warning from statictext within w_end_shift_warning
end type
end forward

global type w_end_shift_warning from window
integer width = 2765
integer height = 1152
boolean titlebar = true
string title = "End Scheduled Shift"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 65535
string icon = "AppIcon!"
boolean center = true
cb_no cb_no
cb_yes cb_yes
st_continue st_continue
st_das_warning st_das_warning
st_end_shift_warning st_end_shift_warning
end type
global w_end_shift_warning w_end_shift_warning

on w_end_shift_warning.create
this.cb_no=create cb_no
this.cb_yes=create cb_yes
this.st_continue=create st_continue
this.st_das_warning=create st_das_warning
this.st_end_shift_warning=create st_end_shift_warning
this.Control[]={this.cb_no,&
this.cb_yes,&
this.st_continue,&
this.st_das_warning,&
this.st_end_shift_warning}
end on

on w_end_shift_warning.destroy
destroy(this.cb_no)
destroy(this.cb_yes)
destroy(this.st_continue)
destroy(this.st_das_warning)
destroy(this.st_end_shift_warning)
end on

type cb_no from commandbutton within w_end_shift_warning
integer x = 1715
integer y = 778
integer width = 640
integer height = 195
integer taborder = 10
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;CloseWithReturn(w_end_shift_warning, -1)
end event

type cb_yes from commandbutton within w_end_shift_warning
integer x = 380
integer y = 778
integer width = 640
integer height = 195
integer taborder = 10
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "End Shift"
end type

event clicked;CloseWithReturn(w_end_shift_warning, 1)
end event

type st_continue from statictext within w_end_shift_warning
integer x = 439
integer y = 550
integer width = 1894
integer height = 112
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 65535
string text = "Are you sure you want to end the shift?"
boolean focusrectangle = false
end type

type st_das_warning from statictext within w_end_shift_warning
integer x = 252
integer y = 288
integer width = 2227
integer height = 157
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 134217857
long backcolor = 65535
string text = "DAS will be unavailable until the next shift."
boolean focusrectangle = false
end type

type st_end_shift_warning from statictext within w_end_shift_warning
integer x = 201
integer y = 96
integer width = 2322
integer height = 160
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 65535
string text = "The scheduled shift will be ended."
boolean focusrectangle = false
end type

