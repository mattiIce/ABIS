$PBExportHeader$u_tabpg_offline.sru
forward
global type u_tabpg_offline from u_tabpg
end type
type cb_offline from commandbutton within u_tabpg_offline
end type
type cb_online from commandbutton within u_tabpg_offline
end type
type cb_disable from commandbutton within u_tabpg_offline
end type
type cb_enable from commandbutton within u_tabpg_offline
end type
type cb_close from commandbutton within u_tabpg_offline
end type
end forward

global type u_tabpg_offline from u_tabpg
integer width = 3599
integer height = 800
long backcolor = 134217752
string text = "Off-line"
long tabbackcolor = 134217752
cb_offline cb_offline
cb_online cb_online
cb_disable cb_disable
cb_enable cb_enable
cb_close cb_close
end type
global u_tabpg_offline u_tabpg_offline

type variables
w_operation_panel iw_operation_panel
end variables

on u_tabpg_offline.create
int iCurrent
call super::create
this.cb_offline=create cb_offline
this.cb_online=create cb_online
this.cb_disable=create cb_disable
this.cb_enable=create cb_enable
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_offline
this.Control[iCurrent+2]=this.cb_online
this.Control[iCurrent+3]=this.cb_disable
this.Control[iCurrent+4]=this.cb_enable
this.Control[iCurrent+5]=this.cb_close
end on

on u_tabpg_offline.destroy
call super::destroy
destroy(this.cb_offline)
destroy(this.cb_online)
destroy(this.cb_disable)
destroy(this.cb_enable)
destroy(this.cb_close)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
//em_password.of_setdropdowncalculator( true)
//em_password.iuo_calculator.of_setcloseonclick( true)
//em_password.iuo_calculator.of_setinitialvalue( true)
end event

type cb_offline from commandbutton within u_tabpg_offline
integer x = 1829
integer y = 102
integer width = 472
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Off-line"
end type

type cb_online from commandbutton within u_tabpg_offline
integer x = 1112
integer y = 102
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "On-Line"
end type

type cb_disable from commandbutton within u_tabpg_offline
integer x = 1829
integer y = 307
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

event clicked;iw_operation_panel.iw_da_sheet.ole_1.object.items( iw_operation_panel.iw_da_sheet.is_noauto ).value = true
iw_operation_panel.iw_da_sheet.ole_1.object.update
end event

type cb_enable from commandbutton within u_tabpg_offline
integer x = 1112
integer y = 307
integer width = 457
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Enable Auto"
end type

event clicked;iw_operation_panel.iw_da_sheet.ole_1.object.items( iw_operation_panel.iw_da_sheet.is_noauto ).value = false
iw_operation_panel.iw_da_sheet.ole_1.object.update
end event

type cb_close from commandbutton within u_tabpg_offline
integer x = 1112
integer y = 525
integer width = 1189
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;iw_operation_panel.postevent( "ue_offline_finish")
end event

