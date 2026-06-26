$PBExportHeader$w_daily_prod_report_shift_schedule.srw
$PBExportComments$Printout shift schedule between 2 date value
forward
global type w_daily_prod_report_shift_schedule from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_shift_schedule
end type
type cb_setzoom from u_cb within w_daily_prod_report_shift_schedule
end type
type cb_print from u_cb within w_daily_prod_report_shift_schedule
end type
type cbx_setpreview from u_cbx within w_daily_prod_report_shift_schedule
end type
type cb_close from u_cb within w_daily_prod_report_shift_schedule
end type
end forward

global type w_daily_prod_report_shift_schedule from w_sheet
integer width = 3346
integer height = 1820
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
cb_close cb_close
end type
global w_daily_prod_report_shift_schedule w_daily_prod_report_shift_schedule

type variables

end variables

on w_daily_prod_report_shift_schedule.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.cb_close
end on

on w_daily_prod_report_shift_schedule.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
end on

event open;call super::open;s_new_daily_prod_info lstr_q
Long ll_row
Date ld_d, ld_d_next
Int li_c, li_def_c, li_rc, li_i, li_k, li_shift_type
DateTime ldt_s, ldt_e
DateTime ldt_def_s, ldt_def_e
String ls_dur, ls_s
String ls_date, ls_wd_s, ls_wd_e, ls_wd_c
DataStore lds_default

lstr_q = Message.PowerObjectParm

dw_Report.SetTransObject(sqlca)
dw_Report.Modify("st_title.Text=' " + lstr_q.line_desc + " Shift Schedule ( " + String(lstr_q.start_date) + " - " + String(lstr_q.end_date) + " )' ")

lds_default = CREATE datastore
lds_default.dataobject = "d_shift_line_date"
lds_default.SetTransObject(SQLCA)

ld_d = lstr_q.start_date
DO WHILE ld_d <= lstr_q.end_date
	ld_d_next = RelativeDate(ld_d, 1)
	li_rc = lds_default.Retrieve(string(ld_d, "mm/dd/yyyy"), lstr_q.line_id)
	ll_row = dw_report.InsertRow(0)
	ls_date = String(ld_d) + "  " + DayName(ld_d)
	dw_report.SetItem(ll_row,"date",ls_date) 
	
	SetNULL(ldt_s)
	SetNULL(ldt_e)
	dw_report.SetItem(ll_row,"start_1", "OFF")
	dw_report.SetItem(ll_row,"start_2", "OFF")
	dw_report.SetItem(ll_row,"start_3", "OFF")
	
	FOR li_k = 1 TO li_rc		
		li_shift_type = lds_default.GetItemNumber(li_k, "schedule_type")
		ldt_s = lds_default.GetItemDateTime(li_k, "planned_starting_time")
		ldt_e = lds_default.GetItemDateTime(li_k, "planned_ending_time")
		dw_report.SetItem(ll_row,"start_"+String(li_shift_type),String(Time(ldt_s))) 
		dw_report.SetItem(ll_row,"end_"+String(li_shift_type),String(Time(ldt_e))) 
		ls_dur = String(f_hoursafter(ldt_s,ldt_e), "##.#")
		dw_report.SetItem(ll_row,"dur_"+String(li_shift_type),ls_dur)
	NEXT
	ld_d = ld_d_next
LOOP

DESTROY lds_default
dw_report.ResetUpdate()

RETURN 1


end event

type dw_report from u_dw within w_daily_prod_report_shift_schedule
integer x = 9
integer y = 8
integer width = 3319
integer height = 1600
integer taborder = 40
string dataobject = "d_daily_prod_shift_schedule_post"
boolean hscrollbar = true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type cb_setzoom from u_cb within w_daily_prod_report_shift_schedule
integer x = 677
integer y = 1616
integer taborder = 10
integer textsize = -11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_shift_schedule
integer x = 1285
integer y = 1616
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_daily_prod_report_shift_schedule
integer x = 2496
integer y = 1628
integer width = 366
integer height = 68
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_daily_prod_report_shift_schedule
string tag = "Close without printing"
integer x = 1893
integer y = 1616
integer taborder = 30
integer textsize = -11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

