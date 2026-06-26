$PBExportHeader$w_maintenance.srw
forward
global type w_maintenance from w_popup
end type
type cb_close from commandbutton within w_maintenance
end type
type st_1 from statictext within w_maintenance
end type
type cb_enable from commandbutton within w_maintenance
end type
type cb_disable from commandbutton within w_maintenance
end type
end forward

global type w_maintenance from w_popup
integer x = 214
integer width = 1456
integer height = 707
string title = "Maintenance"
boolean center = true
cb_close cb_close
st_1 st_1
cb_enable cb_enable
cb_disable cb_disable
end type
global w_maintenance w_maintenance

type variables
w_da_sheet iw_sheet
end variables

on w_maintenance.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_1=create st_1
this.cb_enable=create cb_enable
this.cb_disable=create cb_disable
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_enable
this.Control[iCurrent+4]=this.cb_disable
end on

on w_maintenance.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.cb_enable)
destroy(this.cb_disable)
end on

event open;call super::open;iw_sheet = message.powerobjectparm

end event

type cb_close from commandbutton within w_maintenance
integer x = 128
integer y = 442
integer width = 1189
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close me"
end type

event clicked;Close(parent)
end event

type st_1 from statictext within w_maintenance
integer x = 77
integer y = 93
integer width = 1280
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Click to enable or disable line auto-able"
boolean focusrectangle = false
end type

type cb_enable from commandbutton within w_maintenance
integer x = 132
integer y = 227
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Enable Auto"
end type

event clicked;iw_sheet.ole_1.object.items( iw_sheet.is_noauto ).value = false
iw_sheet.ole_1.object.update
end event

type cb_disable from commandbutton within w_maintenance
integer x = 845
integer y = 224
integer width = 472
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Disable Auto"
end type

event clicked;iw_sheet.ole_1.object.items( iw_sheet.is_noauto ).value = true
iw_sheet.ole_1.object.update
end event

