$PBExportHeader$w_coil_qa_status_change.srw
forward
global type w_coil_qa_status_change from w_child
end type
type dw_coil_modify from u_dw within w_coil_qa_status_change
end type
type cb_save from u_cb within w_coil_qa_status_change
end type
type cb_cancel from u_cb within w_coil_qa_status_change
end type
end forward

global type w_coil_qa_status_change from w_child
integer x = 214
integer width = 1225
integer height = 1053
string title = "Coil QA Status Change"
dw_coil_modify dw_coil_modify
cb_save cb_save
cb_cancel cb_cancel
end type
global w_coil_qa_status_change w_coil_qa_status_change

on w_coil_qa_status_change.create
int iCurrent
call super::create
this.dw_coil_modify=create dw_coil_modify
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil_modify
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_coil_qa_status_change.destroy
call super::destroy
destroy(this.dw_coil_modify)
destroy(this.cb_save)
destroy(this.cb_cancel)
end on

type dw_coil_modify from u_dw within w_coil_qa_status_change
integer x = 29
integer y = 51
integer width = 1083
integer height = 742
integer taborder = 10
string dataobject = "d_coil_detail_qa_editor"
end type

type cb_save from u_cb within w_coil_qa_status_change
integer x = 234
integer y = 845
integer width = 307
integer height = 77
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Save"
end type

type cb_cancel from u_cb within w_coil_qa_status_change
integer x = 644
integer y = 845
integer width = 307
integer height = 77
integer taborder = 10
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

