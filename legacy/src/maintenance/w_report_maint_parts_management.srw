$PBExportHeader$w_report_maint_parts_management.srw
$PBExportComments$<PopUp> standard report preview window inherited form pfemain/w_sheet
forward
global type w_report_maint_parts_management from w_sheet
end type
type dw_report from u_dw within w_report_maint_parts_management
end type
type cb_print from u_cb within w_report_maint_parts_management
end type
type cb_close from u_cb within w_report_maint_parts_management
end type
end forward

global type w_report_maint_parts_management from w_sheet
integer x = 614
integer y = 528
integer width = 3134
integer height = 1578
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
dw_report dw_report
cb_print cb_print
cb_close cb_close
end type
global w_report_maint_parts_management w_report_maint_parts_management

on w_report_maint_parts_management.create
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

on w_report_maint_parts_management.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
end on

event open;call super::open;dw_report.Retrieve(message.doubleparm)
this.title = "Printing Parts # :  " + String(message.doubleparm)
dw_report.SetFocus()

dw_report.SetFocus()
end event

type dw_report from u_dw within w_report_maint_parts_management
integer x = 7
integer y = 13
integer width = 3109
integer height = 1382
integer taborder = 40
string dataobject = "d_report_parts_details"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

type cb_print from u_cb within w_report_maint_parts_management
integer x = 940
integer y = 1395
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cb_close from u_cb within w_report_maint_parts_management
string tag = "Close without printing"
integer x = 1785
integer y = 1395
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

