$PBExportHeader$w_daily_prod_job_detail_display.srw
$PBExportComments$<Response> list prod order detail in w_daily_production inherited from pfemain/w_child
forward
global type w_daily_prod_job_detail_display from w_child
end type
type dw_job_detail from u_dw within w_daily_prod_job_detail_display
end type
type cb_close from u_cb within w_daily_prod_job_detail_display
end type
end forward

global type w_daily_prod_job_detail_display from w_child
string tag = "detail information of an production order"
integer x = 1104
integer y = 499
integer width = 1459
integer height = 499
string title = "Production Order Information"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
dw_job_detail dw_job_detail
cb_close cb_close
end type
global w_daily_prod_job_detail_display w_daily_prod_job_detail_display

on w_daily_prod_job_detail_display.create
int iCurrent
call super::create
this.dw_job_detail=create dw_job_detail
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_job_detail
this.Control[iCurrent+2]=this.cb_close
end on

on w_daily_prod_job_detail_display.destroy
call super::destroy
destroy(this.dw_job_detail)
destroy(this.cb_close)
end on

event open;call super::open;dw_job_detail.SetTransObject(sqlca)
dw_job_detail.Retrieve(message.doubleparm)

this.title = "Job:  " + String(message.doubleparm)

end event

type dw_job_detail from u_dw within w_daily_prod_job_detail_display
string tag = "Detail information of an job"
integer x = 48
integer y = 10
integer width = 1357
integer height = 294
integer taborder = 20
string dataobject = "d_daily_prod_job_details_display"
boolean vscrollbar = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

type cb_close from u_cb within w_daily_prod_job_detail_display
event clicked pbm_bnclicked
string tag = "Close"
integer x = 549
integer y = 317
integer width = 351
integer height = 80
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;RETURN Close(parent)
end event

