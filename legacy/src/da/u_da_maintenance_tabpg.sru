$PBExportHeader$u_da_maintenance_tabpg.sru
forward
global type u_da_maintenance_tabpg from u_tabpg
end type
type cb_disable from commandbutton within u_da_maintenance_tabpg
end type
type cb_enable from commandbutton within u_da_maintenance_tabpg
end type
end forward

global type u_da_maintenance_tabpg from u_tabpg
integer width = 3727
integer height = 1702
cb_disable cb_disable
cb_enable cb_enable
end type
global u_da_maintenance_tabpg u_da_maintenance_tabpg

type variables
string is_title
w_da_sheet iw_sheet
end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
end prototypes

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
end subroutine

on u_da_maintenance_tabpg.create
int iCurrent
call super::create
this.cb_disable=create cb_disable
this.cb_enable=create cb_enable
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_disable
this.Control[iCurrent+2]=this.cb_enable
end on

on u_da_maintenance_tabpg.destroy
call super::destroy
destroy(this.cb_disable)
destroy(this.cb_enable)
end on

event constructor;call super::constructor;//this.text = is_title
end event

type cb_disable from commandbutton within u_da_maintenance_tabpg
integer x = 1587
integer y = 621
integer width = 472
integer height = 128
integer taborder = 20
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

type cb_enable from commandbutton within u_da_maintenance_tabpg
integer x = 874
integer y = 624
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

event clicked;iw_sheet.ole_1.object.items( iw_sheet.is_noauto ).value = false
iw_sheet.ole_1.object.update
end event

