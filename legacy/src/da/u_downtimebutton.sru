$PBExportHeader$u_downtimebutton.sru
forward
global type u_downtimebutton from userobject
end type
type p_1 from picture within u_downtimebutton
end type
type cb_1 from commandbutton within u_downtimebutton
end type
end forward

global type u_downtimebutton from userobject
integer width = 706
integer height = 122
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event clicked ( )
p_1 p_1
cb_1 cb_1
end type
global u_downtimebutton u_downtimebutton

type variables
boolean ib_selected
int ii_downtime_reason_id
string caption
//int il_duration
end variables

forward prototypes
public subroutine set_select ()
public subroutine set_no_selected ()
public function boolean is_selected ()
end prototypes

public subroutine set_select ();ib_selected = true
p_1.visible = ib_selected
end subroutine

public subroutine set_no_selected ();ib_selected = false
p_1.visible = ib_selected
end subroutine

public function boolean is_selected ();return ib_selected
end function

on u_downtimebutton.create
this.p_1=create p_1
this.cb_1=create cb_1
this.Control[]={this.p_1,&
this.cb_1}
end on

on u_downtimebutton.destroy
destroy(this.p_1)
destroy(this.cb_1)
end on

event constructor;//ib_selected = false
//ii_downtime_reason_id = 0
p_1.visible = ib_selected
cb_1.text = caption
cb_1.x = 0
cb_1.y = 0
cb_1.width = This.width
cb_1.height = This.height
p_1.x = This.width / 22
p_1.y = This.height / 11
//il_duration = 0//
If This.Enabled = False then
 cb_1.Enabled = False
 p_1.Enabled = False
End if

end event

type p_1 from picture within u_downtimebutton
integer x = 7
integer y = 3
integer width = 117
integer height = 99
string picturename = ".\playH.jpg"
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

type cb_1 from commandbutton within u_downtimebutton
integer x = 146
integer width = 556
integer height = 115
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;//ib_selected = not ib_selected
//	p_1.visible = ib_selected
parent.postevent("clicked")


end event

