$PBExportHeader$u_scrap_type_button.sru
forward
global type u_scrap_type_button from userobject
end type
type st_1 from statictext within u_scrap_type_button
end type
type p_1 from picture within u_scrap_type_button
end type
end forward

global type u_scrap_type_button from userobject
string tag = "scrap_type"
integer width = 779
integer height = 118
long backcolor = 67108864
string text = "none"
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event clicked ( )
event selectionchanged ( )
st_1 st_1
p_1 p_1
end type
global u_scrap_type_button u_scrap_type_button

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

public subroutine set_no_selected ();ib_selected = false
p_1.visible = ib_selected
//p_1.picturename = "stopD.jpg"
st_1.borderstyle = StyleRaised!

end subroutine

public function boolean is_selected ();return ib_selected
end function

on u_scrap_type_button.create
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.st_1,&
this.p_1}
end on

on u_scrap_type_button.destroy
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

type st_1 from statictext within u_scrap_type_button
integer x = 113
integer width = 662
integer height = 118
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "tttt"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

type p_1 from picture within u_scrap_type_button
integer x = 4
integer y = 16
integer width = 102
integer height = 90
boolean bringtotop = true
string picturename = ".\playH.jpg"
boolean focusrectangle = false
end type

event clicked;parent.postevent( "clicked")
end event

