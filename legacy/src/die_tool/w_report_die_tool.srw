$PBExportHeader$w_report_die_tool.srw
forward
global type w_report_die_tool from w_sheet
end type
type cb_close from u_cb within w_report_die_tool
end type
type cb_print from u_cb within w_report_die_tool
end type
type cb_retrieve from u_cb within w_report_die_tool
end type
type dw_report from u_dw within w_report_die_tool
end type
type cbx_gone from checkbox within w_report_die_tool
end type
type cbx_obsolete from checkbox within w_report_die_tool
end type
type cbx_active from checkbox within w_report_die_tool
end type
type rb_status_select from u_rb within w_report_die_tool
end type
type rb_status_all from u_rb within w_report_die_tool
end type
type gb_1 from u_gb within w_report_die_tool
end type
end forward

global type w_report_die_tool from w_sheet
integer x = 214
integer width = 3686
integer height = 2013
string title = "Inventory report - Die Tool"
boolean resizable = false
cb_close cb_close
cb_print cb_print
cb_retrieve cb_retrieve
dw_report dw_report
cbx_gone cbx_gone
cbx_obsolete cbx_obsolete
cbx_active cbx_active
rb_status_select rb_status_select
rb_status_all rb_status_all
gb_1 gb_1
end type
global w_report_die_tool w_report_die_tool

on w_report_die_tool.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_retrieve=create cb_retrieve
this.dw_report=create dw_report
this.cbx_gone=create cbx_gone
this.cbx_obsolete=create cbx_obsolete
this.cbx_active=create cbx_active
this.rb_status_select=create rb_status_select
this.rb_status_all=create rb_status_all
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_retrieve
this.Control[iCurrent+4]=this.dw_report
this.Control[iCurrent+5]=this.cbx_gone
this.Control[iCurrent+6]=this.cbx_obsolete
this.Control[iCurrent+7]=this.cbx_active
this.Control[iCurrent+8]=this.rb_status_select
this.Control[iCurrent+9]=this.rb_status_all
this.Control[iCurrent+10]=this.gb_1
end on

on w_report_die_tool.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_retrieve)
destroy(this.dw_report)
destroy(this.cbx_gone)
destroy(this.cbx_obsolete)
destroy(this.cbx_active)
destroy(this.rb_status_select)
destroy(this.rb_status_all)
destroy(this.gb_1)
end on

event open;call super::open;dw_report.Event ue_retrieve()
end event

type cb_close from u_cb within w_report_die_tool
integer x = 2311
integer y = 1798
integer width = 351
integer height = 93
integer taborder = 100
string text = "&Close"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_print from u_cb within w_report_die_tool
integer x = 1595
integer y = 1798
integer width = 351
integer height = 93
integer taborder = 90
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.event pfc_print()
end event

type cb_retrieve from u_cb within w_report_die_tool
integer x = 878
integer y = 1798
integer width = 351
integer height = 93
integer taborder = 80
string text = "&Retrieve"
end type

event clicked;call super::clicked;dw_report.event ue_retrieve()
end event

type dw_report from u_dw within w_report_die_tool
event type integer ue_retrieve ( )
integer x = 66
integer y = 307
integer width = 3551
integer height = 1405
integer taborder = 70
string dataobject = "d_die_print"
end type

event type integer ue_retrieve();string ls_status
int li_status

this.reset()
ls_status = ""

IF rb_status_all.Checked = FALSE THEN
	IF rb_status_select.Checked THEN
		ls_status = ""
		IF cbx_active.Checked THEN li_status = 1
			IF Len(ls_status) < 3 THEN
				ls_status = "( " + "status = " + String(li_status)
			ELSE
				ls_status = ls_status + " OR " + "status = " + String(li_status)
		END IF
		IF cbx_obsolete.Checked THEN li_status = 0
			IF Len(ls_status) < 3 THEN
					ls_status = "( " + "status = " + String(li_status)
			ELSE
					ls_status = ls_status + " OR " + "status = " + String(li_status)
		END IF
		IF cbx_gone.Checked THEN li_status = 2
			IF Len(ls_status) < 3 THEN
					ls_status = "( " + "status = " + String(li_status)
			ELSE
					ls_status = ls_status + " OR " + "status = " + String(li_status)
		END IF
		
		IF Pos(ls_status, "(") > 0 THEN
			ls_status = ls_status + " )"
		END IF
	END IF
END IF

dw_report.inv_filter.of_SetFilter(ls_status)
dw_report.inv_filter.of_Filter()
this.retrieve()

return 1
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

type cbx_gone from checkbox within w_report_die_tool
integer x = 1156
integer y = 166
integer width = 278
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Gone"
end type

type cbx_obsolete from checkbox within w_report_die_tool
integer x = 753
integer y = 166
integer width = 278
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Obsolete"
end type

type cbx_active from checkbox within w_report_die_tool
integer x = 432
integer y = 166
integer width = 263
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Active"
boolean checked = true
end type

type rb_status_select from u_rb within w_report_die_tool
integer x = 117
integer y = 166
integer width = 252
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select"
boolean checked = true
end type

event clicked;call super::clicked;IF this.Checked THEN
	cbx_active.Enabled = TRUE
	cbx_active.Checked = TRUE
	cbx_obsolete.Enabled = TRUE
	cbx_obsolete.Checked = FALSE
	cbx_gone.Enabled = TRUE
	cbx_gone.Checked = FALSE
END IF
RETURN 1
end event

type rb_status_all from u_rb within w_report_die_tool
integer x = 117
integer y = 99
integer width = 172
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "All"
end type

event clicked;IF this.Checked THEN
	cbx_active.Enabled = FALSE
	cbx_active.Checked = TRUE
	cbx_obsolete.Enabled = FALSE
	cbx_obsolete.Checked = TRUE
	cbx_gone.Enabled = FALSE
	cbx_gone.Checked = TRUE
END IF
RETURN 1

end event

type gb_1 from u_gb within w_report_die_tool
integer x = 99
integer y = 48
integer width = 1379
integer height = 205
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Status"
end type

