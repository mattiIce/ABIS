$PBExportHeader$w_net_wt_warning.srw
forward
global type w_net_wt_warning from window
end type
type p_1 from picture within w_net_wt_warning
end type
type cb_no from commandbutton within w_net_wt_warning
end type
type sle_3 from singlelineedit within w_net_wt_warning
end type
type p_2 from picture within w_net_wt_warning
end type
type cb_yes from commandbutton within w_net_wt_warning
end type
type sle_2 from singlelineedit within w_net_wt_warning
end type
type sle_1 from singlelineedit within w_net_wt_warning
end type
type st_1 from statictext within w_net_wt_warning
end type
type r_1 from rectangle within w_net_wt_warning
end type
end forward

global type w_net_wt_warning from window
integer width = 4765
integer height = 1907
windowtype windowtype = response!
long backcolor = 65280
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
p_1 p_1
cb_no cb_no
sle_3 sle_3
p_2 p_2
cb_yes cb_yes
sle_2 sle_2
sle_1 sle_1
st_1 st_1
r_1 r_1
end type
global w_net_wt_warning w_net_wt_warning

type variables

end variables

on w_net_wt_warning.create
this.p_1=create p_1
this.cb_no=create cb_no
this.sle_3=create sle_3
this.p_2=create p_2
this.cb_yes=create cb_yes
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_1=create st_1
this.r_1=create r_1
this.Control[]={this.p_1,&
this.cb_no,&
this.sle_3,&
this.p_2,&
this.cb_yes,&
this.sle_2,&
this.sle_1,&
this.st_1,&
this.r_1}
end on

on w_net_wt_warning.destroy
destroy(this.p_1)
destroy(this.cb_no)
destroy(this.sle_3)
destroy(this.p_2)
destroy(this.cb_yes)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.r_1)
end on

event open;//Long	ll_packing_list
//
//ll_packing_list = Message.doubleparm
//
//sle_packing_list.Text = "  " + String(ll_packing_list)
end event

type p_1 from picture within w_net_wt_warning
integer x = 3829
integer y = 1514
integer width = 479
integer height = 275
string picturename = "C:\abis\quest.bmp"
boolean focusrectangle = false
end type

type cb_no from commandbutton within w_net_wt_warning
integer x = 2450
integer y = 1696
integer width = 501
integer height = 134
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "No"
end type

event clicked;CloseWithReturn(Parent, "NO")

//In the calling script:
//ls_answer = Message.StringParm
end event

type sle_3 from singlelineedit within w_net_wt_warning
integer x = 1748
integer y = 1181
integer width = 1221
integer height = 355
integer taborder = 30
integer textsize = -40
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65280
string text = "Continue?"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type p_2 from picture within w_net_wt_warning
integer x = 395
integer y = 1514
integer width = 479
integer height = 275
string picturename = "C:\abis\quest.bmp"
boolean focusrectangle = false
end type

type cb_yes from commandbutton within w_net_wt_warning
integer x = 1759
integer y = 1696
integer width = 501
integer height = 134
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Yes"
end type

event clicked;CloseWithReturn(Parent, "YES")

//In the calling script:
//ls_answer = Message.StringParm
end event

type sle_2 from singlelineedit within w_net_wt_warning
integer x = 59
integer y = 858
integer width = 4593
integer height = 355
integer taborder = 20
integer textsize = -40
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65280
string text = "  is greater than coil beginning weight"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_net_wt_warning
integer x = 205
integer y = 560
integer width = 4436
integer height = 355
integer taborder = 10
integer textsize = -40
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65280
string text = "            Coil net sheet weight"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_net_wt_warning
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
string text = "ARE YOU SURE?"
alignment alignment = center!
long bordercolor = 255
boolean focusrectangle = false
end type

type r_1 from rectangle within w_net_wt_warning
integer linethickness = 3
long fillcolor = 65535
integer x = 176
integer y = 58
integer width = 4436
integer height = 506
end type

