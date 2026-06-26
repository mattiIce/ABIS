$PBExportHeader$w_dt_change_job_reminder.srw
forward
global type w_dt_change_job_reminder from w_popup
end type
type cb_ok from u_cb within w_dt_change_job_reminder
end type
type cb_cancel from u_cb within w_dt_change_job_reminder
end type
type st_2 from statictext within w_dt_change_job_reminder
end type
type st_1 from statictext within w_dt_change_job_reminder
end type
type st_3 from statictext within w_dt_change_job_reminder
end type
end forward

global type w_dt_change_job_reminder from w_popup
integer x = 0
integer y = 0
integer width = 1752
integer height = 787
string title = "Change Job Reminder"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 65535
boolean center = true
boolean ib_isupdateable = false
cb_ok cb_ok
cb_cancel cb_cancel
st_2 st_2
st_1 st_1
st_3 st_3
end type
global w_dt_change_job_reminder w_dt_change_job_reminder

type variables
//u_coil iu_coil
w_da_sheet iw_sheet
end variables

on w_dt_change_job_reminder.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_3
end on

on w_dt_change_job_reminder.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
end on

event open;call super::open;//iu_coil = message.powerobjectparm
//il_shift_id = iu_dt_instance.of_get_shift( ).get_shift_id( )
//ii_seconds = 60
//ii_line_id = iu_dt_instance.of_get_shift( ).ii_line_id
//Timer(1)

iw_sheet = this.parentWindow( )
//MessageBox( "",string(this.parentWindow( ).classname( )) )
end event

type cb_ok from u_cb within w_dt_change_job_reminder
integer x = 256
integer y = 486
integer width = 439
integer height = 131
integer taborder = 20
integer textsize = -12
string facename = "Arial"
string text = "OK"
end type

event clicked;call super::clicked;iw_sheet.ii_event_id = 4
iw_sheet.postevent("ue_open_operation_penal")
Close(parent)
end event

type cb_cancel from u_cb within w_dt_change_job_reminder
integer x = 1013
integer y = 486
integer width = 439
integer height = 131
integer taborder = 10
integer textsize = -12
string facename = "Arial"
string text = "Cancel"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_2 from statictext within w_dt_change_job_reminder
integer x = 176
integer y = 285
integer width = 1360
integer height = 83
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "Do you want to change job for current coil?"
boolean focusrectangle = false
end type

type st_1 from statictext within w_dt_change_job_reminder
integer x = 176
integer y = 182
integer width = 1232
integer height = 99
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "It appeared you are doing new Job setup"
boolean focusrectangle = false
end type

type st_3 from statictext within w_dt_change_job_reminder
integer x = 1847
integer y = 26
integer width = 358
integer height = 106
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
string text = "seconds."
boolean focusrectangle = false
end type

