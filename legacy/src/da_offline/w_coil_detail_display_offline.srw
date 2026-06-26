$PBExportHeader$w_coil_detail_display_offline.srw
$PBExportComments$<Response> list coil detail in offline inherited from pfemain/w_child
forward
global type w_coil_detail_display_offline from w_child
end type
type dw_coil_detail from u_dw within w_coil_detail_display_offline
end type
type cb_close from u_cb within w_coil_detail_display_offline
end type
end forward

global type w_coil_detail_display_offline from w_child
string tag = "detail information of an coil"
integer x = 567
integer y = 518
integer width = 2619
integer height = 771
string title = "Coil Information"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_coil_detail dw_coil_detail
cb_close cb_close
end type
global w_coil_detail_display_offline w_coil_detail_display_offline

on w_coil_detail_display_offline.create
int iCurrent
call super::create
this.dw_coil_detail=create dw_coil_detail
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_detail
this.Control[iCurrent+2]=this.cb_close
end on

on w_coil_detail_display_offline.destroy
call super::destroy
destroy(this.dw_coil_detail)
destroy(this.cb_close)
end on

event open;call super::open;dw_coil_detail.SetTransObject(sqlca)
dw_coil_detail.Retrieve(message.doubleparm)

this.title = "Coil:  " + String(message.doubleparm)

end event

type dw_coil_detail from u_dw within w_coil_detail_display_offline
string tag = "Detail information of an coil"
integer x = 48
integer y = 10
integer width = 2509
integer height = 547
integer taborder = 20
string dataobject = "d_ab_job_coil_detail_display"
boolean vscrollbar = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

type cb_close from u_cb within w_coil_detail_display_offline
event clicked pbm_bnclicked
string tag = "Close"
integer x = 1145
integer y = 576
integer width = 351
integer height = 106
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(parent)
end event

