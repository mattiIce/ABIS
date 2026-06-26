$PBExportHeader$w_recorder.srw
forward
global type w_recorder from w_popup
end type
type p_1 from picture within w_recorder
end type
type st_recording from statictext within w_recorder
end type
type cb_stoprc from commandbutton within w_recorder
end type
end forward

global type w_recorder from w_popup
integer x = 800
integer y = 800
integer width = 2191
integer height = 483
string title = "Recording"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
p_1 p_1
st_recording st_recording
cb_stoprc cb_stoprc
end type
global w_recorder w_recorder

on w_recorder.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_recording=create st_recording
this.cb_stoprc=create cb_stoprc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_recording
this.Control[iCurrent+3]=this.cb_stoprc
end on

on w_recorder.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_recording)
destroy(this.cb_stoprc)
end on

event open;call super::open;String ls_filename

ls_filename = Message.StringParm
st_recording.Text = "Your voice message is being recorded as file " + ls_filename + "."



end event

type p_1 from picture within w_recorder
integer x = 55
integer y = 48
integer width = 205
integer height = 301
string picturename = "C:\Dev\silverdome9\Equalizer.gif"
boolean focusrectangle = false
end type

type st_recording from statictext within w_recorder
integer x = 318
integer y = 112
integer width = 1843
integer height = 67
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Your voice message is being recorded as file  mp3."
boolean focusrectangle = false
end type

type cb_stoprc from commandbutton within w_recorder
integer x = 867
integer y = 246
integer width = 494
integer height = 125
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stop Recording"
end type

event clicked;ClosewithReturn(Parent, 1)
end event

