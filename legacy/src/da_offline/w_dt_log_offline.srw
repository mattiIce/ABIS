$PBExportHeader$w_dt_log_offline.srw
$PBExportComments$<Response> show downtime details, inherited from pfemain/w_sheet
forward
global type w_dt_log_offline from w_sheet
end type
type cb_new from u_cb within w_dt_log_offline
end type
type dw_report from u_dw within w_dt_log_offline
end type
type cb_close from u_cb within w_dt_log_offline
end type
end forward

global type w_dt_log_offline from w_sheet
integer x = 318
integer y = 144
integer width = 2977
integer height = 1770
string title = "DownTime Details"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_new cb_new
dw_report dw_report
cb_close cb_close
end type
global w_dt_log_offline w_dt_log_offline

type variables
s_shift_job_coil_skid istr_t
end variables

on w_dt_log_offline.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.dw_report=create dw_report
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.cb_close
end on

on w_dt_log_offline.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.dw_report)
destroy(this.cb_close)
end on

event open;call super::open;istr_t = message.PowerobjectParm

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(istr_t.shift_num)
dw_report.SetFocus()


end event

type cb_new from u_cb within w_dt_log_offline
string tag = "New downtime events"
integer x = 889
integer y = 1562
integer width = 351
integer height = 102
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New"
end type

event clicked;call super::clicked;Int li_rc

OpenWithParm(w_dt_enter_offline, istr_t)

li_rc = Message.DoubleParm
IF li_rc > 0 THEN
	dw_report.Reset()
	dw_report.Retrieve(istr_t.shift_num)
	dw_report.SetFocus()
END IF
end event

type dw_report from u_dw within w_dt_log_offline
integer width = 2962
integer height = 1546
integer taborder = 30
string dataobject = "d_report_shift_downtime_log"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetPrintPreview(TRUE)

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

type cb_close from u_cb within w_dt_log_offline
string tag = "Close without printing"
integer x = 1675
integer y = 1562
integer width = 351
integer height = 102
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

