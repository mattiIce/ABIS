$PBExportHeader$w_dt_summary_offline.srw
$PBExportComments$<Response> show downtime summary, inherited from pfemain/w_sheet
forward
global type w_dt_summary_offline from w_sheet
end type
type dw_report from u_dw within w_dt_summary_offline
end type
type cb_print from u_cb within w_dt_summary_offline
end type
type cb_close from u_cb within w_dt_summary_offline
end type
end forward

global type w_dt_summary_offline from w_sheet
integer x = 318
integer y = 144
integer width = 1295
integer height = 1770
string title = "DownTime Summary"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_report dw_report
cb_print cb_print
cb_close cb_close
end type
global w_dt_summary_offline w_dt_summary_offline

type variables
Int ii_sheettype
end variables

on w_dt_summary_offline.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
end on

on w_dt_summary_offline.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_shift 

ll_shift = message.DoubleParm

dw_report.SetTransObject(sqlca)
dw_report.Retrieve(ll_shift)
dw_report.SetFocus()


end event

type dw_report from u_dw within w_dt_summary_offline
integer x = 22
integer y = 13
integer width = 1232
integer height = 1546
integer taborder = 30
string dataobject = "d_report_shift_downtime_summary_print"
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

type cb_print from u_cb within w_dt_summary_offline
integer x = 132
integer y = 1574
integer width = 351
integer height = 102
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;Window lw_parent

PrintSetup()

lw_parent = gnv_app.of_GetFrame().GetActiveSheet()

IF IsValid(lw_parent) THEN
	IF lw_Parent.Dynamic wf_set_sketch_file() < 0 THEN RETURN 0
END IF	

dw_report.print()
end event

type cb_close from u_cb within w_dt_summary_offline
string tag = "Close without printing"
integer x = 772
integer y = 1574
integer width = 351
integer height = 102
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

