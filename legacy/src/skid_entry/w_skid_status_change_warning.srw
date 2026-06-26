$PBExportHeader$w_skid_status_change_warning.srw
forward
global type w_skid_status_change_warning from window
end type
type st_4 from statictext within w_skid_status_change_warning
end type
type st_sheet_skid_num from statictext within w_skid_status_change_warning
end type
type st_3 from statictext within w_skid_status_change_warning
end type
type st_2 from statictext within w_skid_status_change_warning
end type
type cb_no from commandbutton within w_skid_status_change_warning
end type
type cb_yes from commandbutton within w_skid_status_change_warning
end type
type p_1 from picture within w_skid_status_change_warning
end type
type p_2 from picture within w_skid_status_change_warning
end type
type st_1 from statictext within w_skid_status_change_warning
end type
type r_1 from rectangle within w_skid_status_change_warning
end type
end forward

global type w_skid_status_change_warning from window
integer width = 4765
integer height = 1907
windowtype windowtype = response!
long backcolor = 255
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
st_4 st_4
st_sheet_skid_num st_sheet_skid_num
st_3 st_3
st_2 st_2
cb_no cb_no
cb_yes cb_yes
p_1 p_1
p_2 p_2
st_1 st_1
r_1 r_1
end type
global w_skid_status_change_warning w_skid_status_change_warning

type variables

end variables

on w_skid_status_change_warning.create
this.st_4=create st_4
this.st_sheet_skid_num=create st_sheet_skid_num
this.st_3=create st_3
this.st_2=create st_2
this.cb_no=create cb_no
this.cb_yes=create cb_yes
this.p_1=create p_1
this.p_2=create p_2
this.st_1=create st_1
this.r_1=create r_1
this.Control[]={this.st_4,&
this.st_sheet_skid_num,&
this.st_3,&
this.st_2,&
this.cb_no,&
this.cb_yes,&
this.p_1,&
this.p_2,&
this.st_1,&
this.r_1}
end on

on w_skid_status_change_warning.destroy
destroy(this.st_4)
destroy(this.st_sheet_skid_num)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_no)
destroy(this.cb_yes)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.st_1)
destroy(this.r_1)
end on

event open;Long	ll_skid_sheet_num

ll_skid_sheet_num = Message.doubleparm

st_sheet_skid_num.Text = st_sheet_skid_num.Text + String(ll_skid_sheet_num)
end event

type st_4 from statictext within w_skid_status_change_warning
integer x = 1481
integer y = 1405
integer width = 1624
integer height = 275
integer textsize = -45
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217857
string text = "?"
alignment alignment = center!
long bordercolor = 255
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_sheet_skid_num from statictext within w_skid_status_change_warning
integer x = 179
integer y = 1126
integer width = 4436
integer height = 275
integer textsize = -45
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217857
string text = "for skid "
alignment alignment = center!
long bordercolor = 255
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_skid_status_change_warning
integer x = 179
integer y = 848
integer width = 4436
integer height = 275
integer textsize = -45
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217857
string text = "you want to change status"
alignment alignment = center!
long bordercolor = 255
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_skid_status_change_warning
integer x = 179
integer y = 570
integer width = 4436
integer height = 275
integer textsize = -45
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217857
string text = "Are you sure"
alignment alignment = center!
long bordercolor = 255
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_no from commandbutton within w_skid_status_change_warning
integer x = 2359
integer y = 1709
integer width = 355
integer height = 134
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "No"
end type

event clicked;CloseWithReturn(Parent, "NO")
end event

type cb_yes from commandbutton within w_skid_status_change_warning
integer x = 1891
integer y = 1709
integer width = 355
integer height = 134
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Yes"
end type

event clicked;CloseWithReturn(Parent, "YES")
end event

type p_1 from picture within w_skid_status_change_warning
integer x = 3306
integer y = 1408
integer width = 892
integer height = 246
string picturename = "I:\abis\Back412a.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_skid_status_change_warning
integer x = 336
integer y = 1408
integer width = 892
integer height = 246
string picturename = "I:\abis\For412a.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within w_skid_status_change_warning
integer x = 263
integer y = 118
integer width = 4290
integer height = 390
integer textsize = -72
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "SKID IS GONE!!!"
alignment alignment = center!
long bordercolor = 255
boolean focusrectangle = false
end type

type r_1 from rectangle within w_skid_status_change_warning
integer linethickness = 3
long fillcolor = 65535
integer x = 176
integer y = 58
integer width = 4436
integer height = 506
end type

