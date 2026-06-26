$PBExportHeader$w_qa_summary_selection.srw
forward
global type w_qa_summary_selection from window
end type
type cb_cancel from commandbutton within w_qa_summary_selection
end type
type cb_ok from commandbutton within w_qa_summary_selection
end type
type st_1 from statictext within w_qa_summary_selection
end type
type cbx_shopfloor_skid_coil_report from checkbox within w_qa_summary_selection
end type
type cbx_shopfloor_skid_report from checkbox within w_qa_summary_selection
end type
type cbx_job_summary_report from checkbox within w_qa_summary_selection
end type
end forward

global type w_qa_summary_selection from window
integer width = 995
integer height = 944
boolean titlebar = true
string title = "Summary Selection"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
cbx_shopfloor_skid_coil_report cbx_shopfloor_skid_coil_report
cbx_shopfloor_skid_report cbx_shopfloor_skid_report
cbx_job_summary_report cbx_job_summary_report
end type
global w_qa_summary_selection w_qa_summary_selection

on w_qa_summary_selection.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.cbx_shopfloor_skid_coil_report=create cbx_shopfloor_skid_coil_report
this.cbx_shopfloor_skid_report=create cbx_shopfloor_skid_report
this.cbx_job_summary_report=create cbx_job_summary_report
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.st_1,&
this.cbx_shopfloor_skid_coil_report,&
this.cbx_shopfloor_skid_report,&
this.cbx_job_summary_report}
end on

on w_qa_summary_selection.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.cbx_shopfloor_skid_coil_report)
destroy(this.cbx_shopfloor_skid_report)
destroy(this.cbx_job_summary_report)
end on

type cb_cancel from commandbutton within w_qa_summary_selection
integer x = 585
integer y = 701
integer width = 201
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;str_all_data_types	lstr_all_data_types

lstr_all_data_types.integer_var[1] = -99

CloseWithReturn(Parent, lstr_all_data_types)
end event

type cb_ok from commandbutton within w_qa_summary_selection
integer x = 135
integer y = 701
integer width = 201
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;str_all_data_types	lstr_all_data_types

lstr_all_data_types.integer_var[1] = 0
lstr_all_data_types.integer_var[2] = 0
lstr_all_data_types.integer_var[3] = 0

if cbx_job_summary_report.Checked Then
	lstr_all_data_types.integer_var[1] = 1
End If

if cbx_shopfloor_skid_report.Checked Then
	lstr_all_data_types.integer_var[2] = 1
End If

if cbx_shopfloor_skid_coil_report.Checked Then
	lstr_all_data_types.integer_var[3] = 1
End If

CloseWithReturn(Parent, lstr_all_data_types)
end event

type st_1 from statictext within w_qa_summary_selection
integer x = 154
integer y = 32
integer width = 757
integer height = 86
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please Select"
boolean focusrectangle = false
end type

type cbx_shopfloor_skid_coil_report from checkbox within w_qa_summary_selection
integer x = 146
integer y = 496
integer width = 699
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shopfloor Skid Coil Report"
end type

type cbx_shopfloor_skid_report from checkbox within w_qa_summary_selection
integer x = 146
integer y = 336
integer width = 699
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shopfloor Skid Report"
end type

type cbx_job_summary_report from checkbox within w_qa_summary_selection
integer x = 146
integer y = 186
integer width = 699
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Job Summary Report"
end type

