$PBExportHeader$w_daily_prod_report_weekly_alph.srw
$PBExportComments$Average lbs per hour report (weekly)
forward
global type w_daily_prod_report_weekly_alph from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_weekly_alph
end type
type cb_setzoom from u_cb within w_daily_prod_report_weekly_alph
end type
type cb_print from u_cb within w_daily_prod_report_weekly_alph
end type
type cbx_setpreview from u_cbx within w_daily_prod_report_weekly_alph
end type
type cb_close from u_cb within w_daily_prod_report_weekly_alph
end type
end forward

global type w_daily_prod_report_weekly_alph from w_sheet
int X=121
int Y=102
int Width=3533
int Height=1792
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
global w_daily_prod_report_weekly_alph w_daily_prod_report_weekly_alph

type variables

end variables

on w_daily_prod_report_weekly_alph.create
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

on w_daily_prod_report_weekly_alph.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
end on

event open;call super::open;s_new_daily_prod_info lstr_q

Int li_rcs, li_i, li_d, li_rc
Long ll_shift, ll_alph, ll_wt, ll_totalwt_day, ll_totalwt, ll_row 
Real lr_hrs, lr_totalhrs_day, lr_totalhrs, lr_totalavg_day, lr_totalavg
DateTime ldt_s, ldt_e
Date ld_1, ld_2, ld_3, ld_4, ld_5, ld_6, ld_7, ld_end, ld_d
Long la_1, la_2, la_3, la_4, la_5, la_6, la_7
String ls_shift
DataStore lds_shift


lstr_q = Message.PowerObjectParm

ld_end = RelativeDate(lstr_q.start_date, 6)

lds_shift = CREATE datastore
lds_shift.dataobject = "d_daily_prod_shift_info_alph"
lds_shift.SetTransObject(SQLCA)
li_rcs = lds_shift.Retrieve(lstr_q.line_id, lstr_q.start_date, ld_end)

IF  li_rcs <= 0 THEN
	MessageBox("Warning", "No valid data available.")
	DESTROY lds_shift
	Close(this)
	RETURN -1
END IF

dw_Report.SetTransObject(sqlca)
dw_Report.Modify("t_title.Text=' " + lstr_q.line_desc + " Average LBs per Hr starting " + String(lstr_q.start_date) + "' ")

SELECT avg_lb_per_hr INTO :ll_alph
FROM line
WHERE line_num = :lstr_q.line_id
USING SQLCA;


ll_totalwt = 0
lr_totalavg = 0.0
lr_totalhrs = 0.0

FOR li_d = 0 TO 6
	ld_d = RelativeDate(lstr_q.start_date, li_d)
	ll_totalwt_day = 0
	lr_totalavg_day = 0.0
	lr_totalhrs_day = 0.0
	FOR li_i = 1 TO li_rcs
		ldt_s = lds_shift.GetItemDateTime(li_i, "start_time")
		IF Date(ldt_s) = ld_d THEN
			ll_shift = lds_shift.GetItemNumber(li_i, "shift_num")
			ldt_e = lds_shift.GetItemDateTime(li_i, "shift_end_time")
			ls_shift = lds_shift.GetItemString(li_i, "shift_display")
			lr_hrs = f_hoursafter(ldt_s,ldt_e)
			lr_hrs = f_hoursafter(ldt_s,ldt_e)
			IF lr_hrs <= 0 or IsNULL(lr_hrs) THEN
				MessageBox("Warning", "Invalid Date Info - " + String(ld_d))
				dw_report.Reset()
				DESTROY lds_shift
				Close(this)
				RETURN -2
			END IF
			lr_totalhrs = lr_totalhrs + lr_hrs
			lr_totalhrs_day = lr_totalhrs_day + lr_hrs
			SELECT SUM(process_wt) INTO :ll_wt
			FROM SHIFT_COIL
			WHERE Shift_num = :ll_shift
			USING SQLCA;
			IF isNULL(ll_wt) THEN ll_wt = 0;
			ll_totalwt_day = ll_totalwt_day + ll_wt
			ll_totalwt = ll_totalwt + ll_wt
		END IF
	NEXT
	IF ll_totalwt_day > 0 THEN
		lr_totalavg_day = ll_totalwt_day/lr_totalhrs_day
	ELSE
		lr_totalavg_day = 0
	END IF
	CHOOSE CASE li_d 
		CASE 0
			ld_1 = ld_d
			la_1 = Long(lr_totalavg_day)
		CASE 1
			ld_2 = ld_d
			la_2 = Long(lr_totalavg_day)
		CASE 2
			ld_3 = ld_d
			la_3 = Long(lr_totalavg_day)
		CASE 3
			ld_4 = ld_d
			la_4 = Long(lr_totalavg_day)
		CASE 4
			ld_5 = ld_d
			la_5 = Long(lr_totalavg_day)
		CASE 5
			ld_6 = ld_d
			la_6 = Long(lr_totalavg_day)
		CASE 6
			ld_7 = ld_d
			la_7 = Long(lr_totalavg_day)
	END CHOOSE
NEXT

lr_totalavg = ll_totalwt/lr_totalhrs

li_rc = dw_report.InsertRow(0)
dw_report.SetItem(li_rc, "d1", ld_1)
dw_report.SetItem(li_rc, "d2", ld_2)
dw_report.SetItem(li_rc, "d3", ld_3)
dw_report.SetItem(li_rc, "d4", ld_4)
dw_report.SetItem(li_rc, "d5", ld_5)
dw_report.SetItem(li_rc, "d6", ld_6)
dw_report.SetItem(li_rc, "d7", ld_7)
dw_report.SetItem(li_rc, "d1_avg", la_1)
dw_report.SetItem(li_rc, "d2_avg", la_2)
dw_report.SetItem(li_rc, "d3_avg", la_3)
dw_report.SetItem(li_rc, "d4_avg", la_4)
dw_report.SetItem(li_rc, "d5_avg", la_5)
dw_report.SetItem(li_rc, "d6_avg", la_6)
dw_report.SetItem(li_rc, "d7_avg", la_7)
dw_report.SetItem(li_rc, "goal", ll_alph)
dw_report.SetItem(li_rc, "avg", Long(lr_totalavg))

dw_report.ResetUpdate()

DESTROY lds_shift
RETURN 1




end event

type dw_report from u_dw within w_daily_prod_report_weekly_alph
int X=0
int Y=0
int Width=3504
int Height=1555
int TabOrder=40
string DataObject="d_daily_prod_report_weekly_avg"
boolean HScrollBar=true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event rbuttondown;RETURN 1
end event
event rbuttonup;RETURN 1
end event
type cb_setzoom from u_cb within w_daily_prod_report_weekly_alph
int X=724
int Y=1584
int TabOrder=10
string Text="&SetZoom"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_weekly_alph
int X=1357
int Y=1584
int TabOrder=20
boolean BringToTop=true
string Text="&Print"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_daily_prod_report_weekly_alph
int X=2615
int Y=1597
int Width=366
string Text="SetPreview"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_daily_prod_report_weekly_alph
int X=1986
int Y=1584
int TabOrder=30
string Tag="Close without printing"
string Text="&Close"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

