$PBExportHeader$w_restack_bl110.srw
forward
global type w_restack_bl110 from w_response
end type
type st_pcs from statictext within w_restack_bl110
end type
type st_4 from statictext within w_restack_bl110
end type
type st_coil from statictext within w_restack_bl110
end type
type st_2 from statictext within w_restack_bl110
end type
type rb_manual from radiobutton within w_restack_bl110
end type
type rb_a2 from radiobutton within w_restack_bl110
end type
type rb_a1 from radiobutton within w_restack_bl110
end type
type cb_confirm from u_cb within w_restack_bl110
end type
type cb_cancel from commandbutton within w_restack_bl110
end type
type st_1 from statictext within w_restack_bl110
end type
end forward

global type w_restack_bl110 from w_response
integer x = 214
integer width = 1664
integer height = 1005
string title = "Please select stacker to reload skid"
st_pcs st_pcs
st_4 st_4
st_coil st_coil
st_2 st_2
rb_manual rb_manual
rb_a2 rb_a2
rb_a1 rb_a1
cb_confirm cb_confirm
cb_cancel cb_cancel
st_1 st_1
end type
global w_restack_bl110 w_restack_bl110

type variables
//u_da_skid_tabpg iu_da_skid_tabpg
s_partial_skid is_skid

end variables

on w_restack_bl110.create
int iCurrent
call super::create
this.st_pcs=create st_pcs
this.st_4=create st_4
this.st_coil=create st_coil
this.st_2=create st_2
this.rb_manual=create rb_manual
this.rb_a2=create rb_a2
this.rb_a1=create rb_a1
this.cb_confirm=create cb_confirm
this.cb_cancel=create cb_cancel
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_pcs
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_coil
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.rb_manual
this.Control[iCurrent+6]=this.rb_a2
this.Control[iCurrent+7]=this.rb_a1
this.Control[iCurrent+8]=this.cb_confirm
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.st_1
end on

on w_restack_bl110.destroy
call super::destroy
destroy(this.st_pcs)
destroy(this.st_4)
destroy(this.st_coil)
destroy(this.st_2)
destroy(this.rb_manual)
destroy(this.rb_a2)
destroy(this.rb_a1)
destroy(this.cb_confirm)
destroy(this.cb_cancel)
destroy(this.st_1)
end on

event pfc_postopen;call super::pfc_postopen;st_coil.text = string(is_skid.partial_skid_num)
st_pcs.text = string(is_skid.partial_skid_pieces)
end event

event open;call super::open;//if gi_screen = 2 then
//	this.x = 7000
//	this.y = 600
//end if
is_skid = message.powerobjectparm
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

type st_pcs from statictext within w_restack_bl110
integer x = 1112
integer y = 67
integer width = 380
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_4 from statictext within w_restack_bl110
integer x = 783
integer y = 67
integer width = 315
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Skid pcs:"
boolean focusrectangle = false
end type

type st_coil from statictext within w_restack_bl110
integer x = 336
integer y = 67
integer width = 380
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_2 from statictext within w_restack_bl110
integer x = 117
integer y = 67
integer width = 219
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Skid # "
boolean focusrectangle = false
end type

type rb_manual from radiobutton within w_restack_bl110
integer x = 139
integer y = 550
integer width = 534
integer height = 99
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manual stack"
end type

event clicked;if not cb_confirm.enabled then cb_confirm.enabled = true
end event

type rb_a2 from radiobutton within w_restack_bl110
integer x = 874
integer y = 416
integer width = 607
integer height = 99
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Auto stacker #2"
end type

event clicked;if not cb_confirm.enabled then cb_confirm.enabled = true
end event

type rb_a1 from radiobutton within w_restack_bl110
integer x = 139
integer y = 416
integer width = 607
integer height = 99
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Auto stacker #1"
end type

event clicked;if not cb_confirm.enabled then cb_confirm.enabled = true
end event

type cb_confirm from u_cb within w_restack_bl110
integer x = 187
integer y = 704
integer width = 516
integer height = 141
integer taborder = 0
integer textsize = -12
boolean enabled = false
string text = "Confirm"
end type

event clicked;call super::clicked;if rb_a1.checked then
	CloseWithReturn(parent, 1)
elseif rb_a2.checked then
	CloseWithReturn(parent, 2)
elseif rb_manual.checked then
	CloseWithReturn(parent, 0)
else
	this.enabled = false
end if
end event

type cb_cancel from commandbutton within w_restack_bl110
integer x = 940
integer y = 704
integer width = 516
integer height = 141
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;Closewithreturn(parent, -1)
end event

type st_1 from statictext within w_restack_bl110
integer x = 263
integer y = 243
integer width = 1145
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please select stacker to reload"
boolean focusrectangle = false
end type

