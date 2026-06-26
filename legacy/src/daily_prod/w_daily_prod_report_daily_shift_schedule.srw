$PBExportHeader$w_daily_prod_report_daily_shift_schedule.srw
$PBExportComments$<PopUp>daily shift schedule report preview window inherited form pfemain/w_sheet
forward
global type w_daily_prod_report_daily_shift_schedule from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_daily_shift_schedule
end type
type cb_setzoom from u_cb within w_daily_prod_report_daily_shift_schedule
end type
type cb_print from u_cb within w_daily_prod_report_daily_shift_schedule
end type
type cbx_setpreview from u_cbx within w_daily_prod_report_daily_shift_schedule
end type
type cb_close from u_cb within w_daily_prod_report_daily_shift_schedule
end type
end forward

global type w_daily_prod_report_daily_shift_schedule from w_sheet
int Y=218
int Width=3090
int Height=1776
WindowType WindowType=response!
boolean TitleBar=true
string Title="Print"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
cb_close cb_close
end type
global w_daily_prod_report_daily_shift_schedule w_daily_prod_report_daily_shift_schedule

type variables

end variables

on w_daily_prod_report_daily_shift_schedule.create
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

on w_daily_prod_report_daily_shift_schedule.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
end on

event open;call super::open;SetPointer(HourGlass!)

Long ll_row, ll_line, ll_shift
Int li_c, li_def_c, li_rc, li_j, li_default
DateTime ldt_s, ldt_e
DateTime ldt_def_s, ldt_def_e
String ls_dur, ls_s, ls_line
String ls_date, ls_wd_s, ls_wd_e, ls_wd_c
Date ld_date
DataStore lds_default

ld_date = Date(Message.StringParm)
dw_Report.SetTransObject(sqlca)
dw_Report.Modify("t_title.Text=' " + "Daily Shift Schedule. Date: " + Message.StringParm +  "' ")

lds_default = CREATE datastore
lds_default.dataobject = "d_daily_prod_default_schedule"
lds_default.SetTransObject(SQLCA)
li_rc = lds_default.Retrieve()

FOR li_j = 1 TO li_rc
	ll_row = dw_report.InsertRow(0)
	
	ll_line = lds_default.GetItemNumber(li_j, "line_num")
	ll_shift = lds_default.GetItemNumber(li_j, "schedule_type")
	ls_line = lds_default.GetItemString(li_j, "line_line_desc")
	
	CHOOSE CASE Upper(DayName(ld_date))
		CASE "MONDAY"
			ls_wd_s = "mon_start"
			ls_wd_e = "mon_end"
			ls_wd_c = "mon_cancel"
		CASE "TUESDAY"
			ls_wd_s = "tue_start"
			ls_wd_e = "tue_end"
			ls_wd_c = "tue_cancel"
		CASE "WEDNESDAY"
			ls_wd_s = "wed_start"
			ls_wd_e = "wed_end"
			ls_wd_c = "wed_cancel"
		CASE "THURSDAY"
			ls_wd_s = "thu_start"
			ls_wd_e = "thu_end"
			ls_wd_c = "thu_cancel"
		CASE "FRIDAY"
			ls_wd_s = "fri_start"
			ls_wd_e = "fri_end"
			ls_wd_c = "fri_cancel"
		CASE "SATURDAY"
			ls_wd_s = "sat_start"
			ls_wd_e = "sat_end"
			ls_wd_c = "sat_cancel"
		CASE "SUNDAY"
			ls_wd_s = "sun_start"
			ls_wd_e = "sun_end"
			ls_wd_c = "sun_cancel"
	END CHOOSE
	
	CHOOSE CASE ll_shift
		CASE 1
			ls_s = "1ST"
		CASE 2
			ls_s = "2ND"
		CASE 3
			ls_s = "3RD"
		CASE ELSE
			ls_s = "Other"
	END CHOOSE		

	ldt_def_s = lds_default.GetItemDateTime(li_j, ls_wd_s)
	ldt_def_e = lds_default.GetItemDateTime(li_j, ls_wd_e)
	li_def_c = lds_default.GetItemNumber(li_j, ls_wd_c)
	

		SetNULL(ldt_s)
		SetNULL(ldt_e)
		SetNULL(li_c)
		SELECT Shift_starting_time, shift_ending_time, shift_cancelled
		INTO :ldt_s, :ldt_e,  :li_c
		FROM Shift_schedule
		WHERE (Shift_schedule_date =:ld_date) AND (line_num = :ll_line) and (schedule_type = :ll_shift) 
		USING SQLCA;
		li_default = 0
	
		IF isNULL(ldt_s) THEN 
			ldt_s = ldt_def_s
			li_default = 1
		END IF
		IF isNULL(ldt_e) THEN 
			ldt_e = ldt_def_e
			li_default = 1
		END IF
		IF isNULL(li_c) THEN 
			li_c = li_def_c
			li_default = 1
		END IF
		
		dw_report.SetItem(ll_row,"line", ls_line) 
		dw_report.SetItem(ll_row,"cancel", li_c) 
		dw_report.SetItem(ll_row,"start",String(Time(ldt_s))) 
		dw_report.SetItem(ll_row,"end",String(Time(ldt_e)))
		dw_report.SetItem(ll_row,"shift",ls_s)
		dw_report.SetItem(ll_row,"default",li_default)

		IF IsNULL(ldt_e) THEN 
			SetNULL(ls_dur) 
		ELSE 
			ls_dur = String(f_hoursafter(ldt_s,ldt_e), "##.#")
		END IF
		dw_report.SetItem(ll_row,"duration",ls_dur)
		
NEXT

DESTROY lds_default
dw_report.ResetUpdate()



end event

type dw_report from u_dw within w_daily_prod_report_daily_shift_schedule
int X=11
int Y=3
int Width=3032
int Height=1568
int TabOrder=40
string DataObject="d_daily_prod_report_shift_schedule_daily"
boolean HScrollBar=true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type cb_setzoom from u_cb within w_daily_prod_report_daily_shift_schedule
int X=585
int Y=1584
int TabOrder=10
string Text="&SetZoom"
int TextSize=-11
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_daily_shift_schedule
int X=1265
int Y=1584
int TabOrder=20
boolean BringToTop=true
string Text="&Print"
int TextSize=-11
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_daily_prod_report_daily_shift_schedule
int X=2626
int Y=1597
int Width=366
string Text="SetPreview"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_daily_prod_report_daily_shift_schedule
int X=1946
int Y=1584
int TabOrder=30
string Tag="Close without printing"
string Text="&Close"
int TextSize=-11
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;call super::clicked;Close(Parent)
end event

