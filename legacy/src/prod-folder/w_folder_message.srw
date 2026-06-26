$PBExportHeader$w_folder_message.srw
$PBExportComments$<Popup> message widow inherited from w_popup
forward
global type w_folder_message from w_popup
end type
type st_msg from statictext within w_folder_message
end type
type cb_ok from u_cb within w_folder_message
end type
type p_2 from picture within w_folder_message
end type
type p_1 from picture within w_folder_message
end type
end forward

global type w_folder_message from w_popup
string tag = "warning message"
integer x = 214
integer width = 1488
integer height = 410
string title = "Warning"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
st_msg st_msg
cb_ok cb_ok
p_2 p_2
p_1 p_1
end type
global w_folder_message w_folder_message

on w_folder_message.create
int iCurrent
call super::create
this.st_msg=create st_msg
this.cb_ok=create cb_ok
this.p_2=create p_2
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_msg
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.p_2
this.Control[iCurrent+4]=this.p_1
end on

on w_folder_message.destroy
call super::destroy
destroy(this.st_msg)
destroy(this.cb_ok)
destroy(this.p_2)
destroy(this.p_1)
end on

event open;call super::open;st_msg.Text = Message.StringParm
end event

type st_msg from statictext within w_folder_message
integer x = 161
integer y = 19
integer width = 1192
integer height = 189
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = Center!
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_folder_message
integer x = 523
integer y = 237
integer width = 351
integer height = 93
integer taborder = 10
string facename = "Arial"
string text = "OK"
end type

event clicked;call super::clicked;Close(Parent)
end event

type p_2 from picture within w_folder_message
integer x = 1382
integer y = 3
integer width = 95
integer height = 90
string picturename = "NotFound!"
boolean focusrectangle = false
end type

type p_1 from picture within w_folder_message
integer x = 33
integer y = 3
integer width = 95
integer height = 90
string picturename = "NotFound!"
boolean focusrectangle = false
end type

