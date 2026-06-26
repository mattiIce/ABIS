$PBExportHeader$u_line_button.sru
forward
global type u_line_button from userobject
end type
type st_1 from statictext within u_line_button
end type
type p_1 from picture within u_line_button
end type
end forward

global type u_line_button from userobject
integer width = 523
integer height = 67
long backcolor = 16777215
string text = "none"
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event clicked ( )
event selectionchanged ( )
st_1 st_1
p_1 p_1
end type
global u_line_button u_line_button

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
//p_1.picturename = "playH.jpg"
st_1.borderstyle = StyleLowered!

end subroutine

public subroutine set_no_selected ();//ib_selected = false
//p_1.visible = ib_selected
////p_1.picturename = "stopD.jpg"
//st_1.borderstyle = StyleRaised!
//
end subroutine

public function boolean is_selected ();return ib_selected
end function

on u_line_button.create
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.st_1,&
this.p_1}
end on

on u_line_button.destroy
destroy(this.st_1)
destroy(this.p_1)
end on

event constructor;//ib_selected = false
//ii_downtime_reason_id = 0
//p_1.visible = ib_selected
//p_1.picturename = "

p_1.visible = this.is_selected( )

st_1.text = "     " + caption
st_1.x = 0
st_1.y = 0
st_1.width = This.width
st_1.height = This.height
//st_1.width = cb_1.width
//st_1.height = cb_1.height
//p_1.x = 0
//p_1.y = 0
//p_1.x = This.width / 20
//p_1.y = This.height / 10

if ib_selected then
	st_1.borderstyle = StyleLowered!
else
	st_1.borderstyle = StyleRaised!
end if



//il_duration = 0//
//If This.Enabled = False then
// cb_1.Enabled = False
// p_1.Enabled = False
//End if

end event

type st_1 from statictext within u_line_button
integer x = 59
integer width = 468
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "ABC"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

type p_1 from picture within u_line_button
integer x = 4
integer width = 64
integer height = 64
boolean bringtotop = true
string picturename = "C:\PB9\DA\GreenLight.gif"
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

