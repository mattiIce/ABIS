$PBExportHeader$w_select_job.srw
forward
global type w_select_job from w_response
end type
type cb_cancel from u_cb within w_select_job
end type
type cb_ok from u_cb within w_select_job
end type
type st_1 from statictext within w_select_job
end type
type pb_job from u_pb within w_select_job
end type
type em_job from u_em within w_select_job
end type
end forward

global type w_select_job from w_response
integer x = 214
integer width = 1126
integer height = 1056
string title = "Enter job number"
boolean controlmenu = false
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
pb_job pb_job
em_job em_job
end type
global w_select_job w_select_job

on w_select_job.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.pb_job=create pb_job
this.em_job=create em_job
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.pb_job
this.Control[iCurrent+5]=this.em_job
end on

on w_select_job.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.pb_job)
destroy(this.em_job)
end on

type cb_cancel from u_cb within w_select_job
integer x = 278
integer y = 742
integer width = 527
integer height = 128
integer taborder = 40
integer textsize = -12
string facename = "Arial"
string text = "Cancel"
end type

event clicked;call super::clicked;CloseWithReturn( parent, -1 )
end event

type cb_ok from u_cb within w_select_job
integer x = 278
integer y = 499
integer width = 527
integer height = 128
integer taborder = 30
integer textsize = -12
string facename = "Arial"
string text = "OK"
end type

event clicked;call super::clicked;long ll_temp
ll_temp = Long( em_job.text )

if ll_temp < 10000 then
	MessageBox("Error", "Invalid Job number!!", Stopsign!)
	return 1
end if

  SELECT "AB_JOB"."AB_JOB_NUM"  
    INTO :ll_temp  
    FROM "AB_JOB"  
   WHERE "AB_JOB"."AB_JOB_NUM" = :ll_temp   
           ;
	if sqlca.sqlcode <> 0 then
		MessageBox("Error", "Invalid Job number!!", Stopsign!)
		return 1
	end if

CloseWithReturn(parent, ll_temp)

end event

type st_1 from statictext within w_select_job
integer x = 132
integer y = 102
integer width = 848
integer height = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please enter job number"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_job from u_pb within w_select_job
integer x = 688
integer y = 282
integer width = 132
integer height = 102
integer taborder = 20
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;em_job.Event pfc_DDCalculator( )
end event

type em_job from u_em within w_select_job
integer x = 278
integer y = 282
integer width = 417
integer height = 102
integer taborder = 10
integer textsize = -12
string facename = "Arial"
string text = "0000"
string mask = "#####"
string minmax = "10000~~99999"
end type

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
end event

