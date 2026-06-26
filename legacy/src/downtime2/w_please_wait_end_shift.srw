$PBExportHeader$w_please_wait_end_shift.srw
forward
global type w_please_wait_end_shift from w_popup
end type
type st_msg from statictext within w_please_wait_end_shift
end type
type st_1 from statictext within w_please_wait_end_shift
end type
type p_1 from picture within w_please_wait_end_shift
end type
end forward

global type w_please_wait_end_shift from w_popup
integer x = 0
integer y = 0
integer width = 1397
integer height = 381
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean ib_isupdateable = false
st_msg st_msg
st_1 st_1
p_1 p_1
end type
global w_please_wait_end_shift w_please_wait_end_shift

on w_please_wait_end_shift.create
int iCurrent
call super::create
this.st_msg=create st_msg
this.st_1=create st_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_msg
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.p_1
end on

on w_please_wait_end_shift.destroy
call super::destroy
destroy(this.st_msg)
destroy(this.st_1)
destroy(this.p_1)
end on

event open;call super::open;st_msg.text = message.stringparm
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

type st_msg from statictext within w_please_wait_end_shift
integer x = 322
integer y = 51
integer width = 1031
integer height = 128
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shift ending in process"
boolean focusrectangle = false
end type

type st_1 from statictext within w_please_wait_end_shift
integer x = 322
integer y = 179
integer width = 852
integer height = 128
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please Wait ..."
boolean focusrectangle = false
end type

type p_1 from picture within w_please_wait_end_shift
integer x = 44
integer y = 64
integer width = 230
integer height = 202
string picturename = ".\kb_hdr_icon.jpg"
boolean focusrectangle = false
end type

