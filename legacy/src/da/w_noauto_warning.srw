$PBExportHeader$w_noauto_warning.srw
forward
global type w_noauto_warning from w_popup
end type
type cb_downtime from commandbutton within w_noauto_warning
end type
type st_msg from statictext within w_noauto_warning
end type
type cb_continue from commandbutton within w_noauto_warning
end type
end forward

global type w_noauto_warning from w_popup
integer x = 0
integer y = 0
integer width = 3734
integer height = 138
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 65535
cb_downtime cb_downtime
st_msg st_msg
cb_continue cb_continue
end type
global w_noauto_warning w_noauto_warning

type variables
boolean ib_flash = false
w_da_sheet iw_sheet
end variables

on w_noauto_warning.create
int iCurrent
call super::create
this.cb_downtime=create cb_downtime
this.st_msg=create st_msg
this.cb_continue=create cb_continue
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_downtime
this.Control[iCurrent+2]=this.st_msg
this.Control[iCurrent+3]=this.cb_continue
end on

on w_noauto_warning.destroy
call super::destroy
destroy(this.cb_downtime)
destroy(this.st_msg)
destroy(this.cb_continue)
end on

event open;call super::open;iw_sheet = message.powerobjectparm
Timer(1)
end event

event timer;call super::timer;	if ib_flash then
		st_msg.BackColor = RGB(255,255,0)
	else
		st_msg.BackColor = RGB(0,255,255)
	END IF
ib_flash = not ib_flash
end event

type cb_downtime from commandbutton within w_noauto_warning
integer x = 2619
integer y = 13
integer width = 640
integer height = 102
integer taborder = 20
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Open downtime"
end type

event clicked;if isValid( iw_sheet.iuo_shift.iu_current_downtime ) then
	iw_sheet.iuo_shift.iu_current_downtime.of_select_dt_tabpg( )
	//iw_sheet.tab_da.selecttab( 3 )
end if
end event

type st_msg from statictext within w_noauto_warning
integer x = 271
integer y = 26
integer width = 2300
integer height = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65280
string text = "Line auto disabled! Please check downtime cause to re-open line auto."
boolean focusrectangle = false
end type

type cb_continue from commandbutton within w_noauto_warning
integer x = 3350
integer y = 13
integer width = 322
integer height = 102
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)

end event

