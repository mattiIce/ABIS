$PBExportHeader$u_fault_status_button.sru
forward
global type u_fault_status_button from userobject
end type
type st_1 from statictext within u_fault_status_button
end type
type p_2 from picture within u_fault_status_button
end type
type p_1 from picture within u_fault_status_button
end type
end forward

global type u_fault_status_button from userobject
integer width = 453
integer height = 64
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event clicked ( )
event selectionchanged ( )
st_1 st_1
p_2 p_2
p_1 p_1
end type
global u_fault_status_button u_fault_status_button

type variables
boolean ib_selected
//int ii_downtime_reason_id
string caption
//int il_duration
end variables

forward prototypes
public function boolean is_selected ()
public subroutine set_select (boolean ab_set)
end prototypes

public function boolean is_selected ();return ib_selected
end function

public subroutine set_select (boolean ab_set);ib_selected = ab_set
p_1.visible = ib_selected
p_2.visible = not ib_selected
//p_1.picturename = "playH.jpg"
//if ab_set then
//	st_1.borderstyle = StyleLowered!
//else
//	st_1.borderstyle = StyleRaised!
//end if
//
end subroutine

on u_fault_status_button.create
this.st_1=create st_1
this.p_2=create p_2
this.p_1=create p_1
this.Control[]={this.st_1,&
this.p_2,&
this.p_1}
end on

on u_fault_status_button.destroy
destroy(this.st_1)
destroy(this.p_2)
destroy(this.p_1)
end on

event constructor;//ib_selected = false
//ii_downtime_reason_id = 0
//p_1.visible = ib_selected
//p_1.picturename = "

p_1.visible = is_selected( )
p_2.visible = not ib_selected
st_1.text = "    " + caption
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

//if ib_selected then
//	st_1.borderstyle = StyleLowered!
//else
//	st_1.borderstyle = StyleRaised!
//end if



//il_duration = 0//
//If This.Enabled = False then
// cb_1.Enabled = False
// p_1.Enabled = False
//End if

end event

type st_1 from statictext within u_fault_status_button
integer x = 88
integer width = 366
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Abc"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

type p_2 from picture within u_fault_status_button
integer x = 4
integer y = 6
integer width = 66
integer height = 61
string picturename = ".\RedLight.gif"
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

type p_1 from picture within u_fault_status_button
integer x = 4
integer y = 6
integer width = 66
integer height = 61
string picturename = ".\GreenLight.gif"
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

