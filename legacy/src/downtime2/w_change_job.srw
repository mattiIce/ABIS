$PBExportHeader$w_change_job.srw
forward
global type w_change_job from w_response
end type
type cb_select from commandbutton within w_change_job
end type
type cb_cancel from commandbutton within w_change_job
end type
type dw_job_schedule from datawindow within w_change_job
end type
type pb_page_up from picturebutton within w_change_job
end type
type pb_page_down from picturebutton within w_change_job
end type
type cb_renew from commandbutton within w_change_job
end type
end forward

global type w_change_job from w_response
integer x = 0
integer y = 0
integer width = 2659
integer height = 2230
string title = "Select Job number"
boolean controlmenu = false
boolean center = true
cb_select cb_select
cb_cancel cb_cancel
dw_job_schedule dw_job_schedule
pb_page_up pb_page_up
pb_page_down pb_page_down
cb_renew cb_renew
end type
global w_change_job w_change_job

type variables
uo_shift iuo_shift
end variables

on w_change_job.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
this.dw_job_schedule=create dw_job_schedule
this.pb_page_up=create pb_page_up
this.pb_page_down=create pb_page_down
this.cb_renew=create cb_renew
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.dw_job_schedule
this.Control[iCurrent+4]=this.pb_page_up
this.Control[iCurrent+5]=this.pb_page_down
this.Control[iCurrent+6]=this.cb_renew
end on

on w_change_job.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_cancel)
destroy(this.dw_job_schedule)
destroy(this.pb_page_up)
destroy(this.pb_page_down)
destroy(this.cb_renew)
end on

event open;call super::open;iuo_shift = message.powerobjectparm
sqlca.of_connect( )
dw_job_schedule.settransobject( SQLCA)
dw_job_schedule.retrieve( iuo_shift.of_get_line_id() )

end event

type cb_select from commandbutton within w_change_job
integer x = 95
integer y = 1846
integer width = 1653
integer height = 173
integer taborder = 20
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Change to"
boolean default = true
end type

event clicked;//dw_job_schedule.
long ll_job
ll_job = Long(Trim(Mid(this.text, 11)))
if ll_job = 0 or isNull(ll_job) then
	Messagebox("Change Job Num", "Please select the Job#!!!", StopSign!)
	return 0
end if
iuo_shift.of_set_job_id(ll_job)
close(parent)
end event

type cb_cancel from commandbutton within w_change_job
boolean visible = false
integer x = 2428
integer y = 1686
integer width = 132
integer height = 138
integer taborder = 20
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;close(parent)
//dw_job_schedule.s
end event

type dw_job_schedule from datawindow within w_change_job
integer x = 62
integer y = 64
integer width = 2271
integer height = 1734
integer taborder = 10
string title = "none"
string dataobject = "d_job_schedule"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	this.selectrow( 0, false)
	this.selectrow( row, true)
	parent.cb_select.text = "Change to " + string(this.getitemnumber( row, "line_priority_ab_job_num"))
end if
end event

type pb_page_up from picturebutton within w_change_job
integer x = 2359
integer y = 192
integer width = 238
integer height = 214
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = ".\arrow_green_up.bmp"
alignment htextalign = left!
end type

event clicked;parent.dw_job_schedule.scrollpriorpage( )
end event

type pb_page_down from picturebutton within w_change_job
integer x = 2359
integer y = 1286
integer width = 238
integer height = 214
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = ".\arrow_green_down.bmp"
alignment htextalign = left!
end type

event clicked;parent.dw_job_schedule.scrollnextpage( )
end event

type cb_renew from commandbutton within w_change_job
integer x = 1861
integer y = 1846
integer width = 709
integer height = 173
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;dw_job_schedule.settransobject( SQLCA)
dw_job_schedule.retrieve( iuo_shift.of_get_line_id() )

end event

