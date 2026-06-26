$PBExportHeader$w_daily_prod_report_summary.srw
$PBExportComments$<PopUp> daily_production summary report preview window inherited form pfemain/w_sheet
forward
global type w_daily_prod_report_summary from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_summary
end type
type cb_setzoom from u_cb within w_daily_prod_report_summary
end type
type cb_print from u_cb within w_daily_prod_report_summary
end type
type cbx_setpreview from u_cbx within w_daily_prod_report_summary
end type
type cb_close from u_cb within w_daily_prod_report_summary
end type
end forward

global type w_daily_prod_report_summary from w_sheet
int Y=218
int Width=3346
int Height=1776
WindowType WindowType=popup!
boolean TitleBar=true
string Title="Daily production summary report"
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
global w_daily_prod_report_summary w_daily_prod_report_summary

type variables

end variables

on w_daily_prod_report_summary.create
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

on w_daily_prod_report_summary.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
end on

event open;call super::open;Date ld_d
DataStore lds_data, lds_coil
Int li_rc, li_i, li_line, li_type, li_coil_processed, li_temp, li_j
String ls_line, ls_date, ls_line_shift, ls_jobs, ls_rejected_coil, ls_comments, ls_jobid
Real lr_hrs, lr_total_hr, lr_total_line_hr
Long ll_lbs, ll_total_lbs, ll_row, ll_shift, ll_total_line_lbs
DateTime ldt_s, ldt_e

ls_date = Message.StringParm
ld_d = Date(ls_date)
dw_Report.SetTransObject(sqlca)

lds_data = CREATE datastore
lds_data.dataobject = "d_daily_prod_line_schedule"
lds_data.SetTransObject(SQLCA)
li_rc = lds_data.Retrieve()

lds_coil = CREATE datastore
lds_coil.dataobject = "d_daily_prod_summary_coil_info"
lds_coil.SetTransObject(SQLCA)
li_temp = lds_coil.Retrieve(ld_d)

lr_total_hr = 0.00
ll_total_lbs = 0
lr_total_line_hr = 0.00
ll_total_line_lbs = 0
FOR li_i = 1 to li_rc
	ls_jobs = ""
	ls_rejected_coil = ""
	li_type = lds_data.GetItemNumber(li_i, "schedule_type")
	li_line = lds_data.GetItemNumber(li_i, "line_num")
	ls_line = lds_data.GetItemString(li_i, "line_line_desc")
	ll_row = dw_report.InsertRow(0)
	CHOOSE CASE li_type
		CASE 1
			ls_line_shift = ls_line + " 1st Shift:"
		CASE 2
			ls_line_shift = ls_line + " 2nd Shift:"
		CASE 3
			ls_line_shift = ls_line + " 3rd Shift:"
		CASE ELSE
			ls_line_shift = ls_line + " ___ Shift:"
	END CHOOSE	
	ll_shift = 0
	SELECT shift_num, note, start_time, end_time INTO :ll_shift, :ls_comments, :ldt_s, :ldt_e
	FROM SHIFT
	WHERE To_Date(start_time) = :ld_d AND line_num = :li_line AND schedule_type = :li_type
	USING SQLCA;
	IF isNULL(ll_shift) OR (ll_shift = 0) THEN
		lr_hrs = 0.0
		ll_lbs = 0
		setNULL(li_coil_processed)
		ls_jobs = ""
		ls_rejected_coil = ""
		ls_comments = ""		
	ELSE
		lr_hrs = f_hoursafter(ldt_s,ldt_e)
		IF lr_hrs <= 0 or IsNULL(lr_hrs) THEN
			MessageBox("Warning", "Invalid DateTime Info: starting/ending time is NULL")
			dw_report.Reset()
			DESTROY lds_data
			DESTROY lds_coil
			Close(this)
			RETURN -2
		END IF
		SELECT COUNT(coil_abc_num),SUM(Process_wt) INTO :li_coil_processed, :ll_lbs
		FROM SHIFT_COIL
		WHERE shift_num = :ll_shift
		USING SQLCA;
		IF li_temp > 0 THEN
			FOR li_j = 1 TO li_temp
				IF lds_coil.GetItemNumber(li_j, "shift_coil_shift_num") = ll_shift THEN
					ls_jobid = String(lds_coil.GetItemNumber(li_j, "shift_coil_ab_job_num"))
					IF Pos(ls_jobs, ls_jobid) = 0 THEN ls_jobs = ls_jobs + "  " + ls_jobid  //no duplicate
					IF lds_coil.GetItemNumber(li_j, "shift_coil_coil_end_status") = 3 THEN //rejected
						ls_rejected_coil = ls_rejected_coil + "  " + String(lds_coil.GetItemNumber(li_j, "shift_coil_coil_abc_num"))
					END IF
				END IF
			NEXT
		END IF
	END IF
	lr_total_hr = lr_total_hr + lr_hrs
	ll_total_lbs = ll_total_lbs + ll_lbs
	lr_total_line_hr = lr_total_line_hr + lr_hrs
	ll_total_line_lbs = ll_total_line_lbs + ll_lbs
	
	dw_report.SetItem(ll_row, "line_shift", ls_line_shift)
	dw_report.SetItem(ll_row, "date", ls_date)
	dw_report.SetItem(ll_row, "Hrs", lr_hrs)
	dw_report.SetItem(ll_row, "LBs", ll_lbs)
	dw_report.SetItem(ll_row, "coil_processed", li_coil_processed)
	dw_report.SetItem(ll_row, "jobs", ls_jobs)
	dw_report.SetItem(ll_row, "Rejected_coil", ls_rejected_coil)
	dw_report.SetItem(ll_row, "comments", ls_comments)
	dw_report.SetItem(ll_row, "display", 0) //white background
	IF li_i + 1 <= li_rc THEN
		IF lds_data.GetItemNumber(li_i + 1, "line_num") <> li_line THEN
			ls_line_shift = ls_line + " TOTALS:"
			ll_row = dw_report.InsertRow(0)		
			dw_report.SetItem(ll_row, "line_shift", ls_line_shift)
			dw_report.SetItem(ll_row, "Hrs", lr_total_line_hr)
			dw_report.SetItem(ll_row, "LBs", ll_total_line_lbs)
			dw_report.SetItem(ll_row, "display", 1) //white background
			lr_total_line_hr = 0.00
			ll_total_line_lbs = 0
		END IF
	ELSE
		ls_line_shift = ls_line + " TOTALS:"
		ll_row = dw_report.InsertRow(0)		
		dw_report.SetItem(ll_row, "line_shift", ls_line_shift)
		dw_report.SetItem(ll_row, "Hrs", lr_total_line_hr)
		dw_report.SetItem(ll_row, "LBs", ll_total_line_lbs)
		dw_report.SetItem(ll_row, "display", 1) //white background
		dw_report.SetItem(ll_row, "total_hr", lr_total_hr)
		dw_report.SetItem(ll_row, "total_lbs", ll_total_lbs)
	END IF	
NEXT

dw_report.ResetUpdate()

DESTROY lds_data
DESTROY lds_coil


end event

type dw_report from u_dw within w_daily_prod_report_summary
int X=0
int Y=3
int Width=3324
int Height=1562
int TabOrder=40
string DataObject="d_daily_prod_summary"
boolean HScrollBar=true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event rbuttondown;RETURN 1
end event
event rbuttonup;RETURN 1
end event
type cb_setzoom from u_cb within w_daily_prod_report_summary
int X=618
int Y=1574
int TabOrder=10
string Text="&SetZoom"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_summary
int X=1295
int Y=1574
int TabOrder=20
boolean BringToTop=true
string Text="&Print"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_daily_prod_report_summary
int X=2648
int Y=1587
int Width=366
string Text="SetPreview"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_daily_prod_report_summary
int X=1971
int Y=1574
int TabOrder=30
string Tag="Close without printing"
string Text="&Close"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

