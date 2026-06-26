$PBExportHeader$w_daily_prod_report_ds.srw
$PBExportComments$<PopUp> daily_production downtime  report preview window inherited form pfemain/w_sheet
forward
global type w_daily_prod_report_ds from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_ds
end type
type cb_setzoom from u_cb within w_daily_prod_report_ds
end type
type cb_print from u_cb within w_daily_prod_report_ds
end type
type cb_close from u_cb within w_daily_prod_report_ds
end type
end forward

global type w_daily_prod_report_ds from w_sheet
integer y = 218
integer width = 3346
integer height = 1792
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cb_close cb_close
end type
global w_daily_prod_report_ds w_daily_prod_report_ds

type variables

end variables

forward prototypes
public function real wf_efficiency (long al_shift)
public function real wf_total_dt (long al_shift_id)
end prototypes

public function real wf_efficiency (long al_shift);DateTime ldt_s, ldt_e
Long ll_dt_total, ll_worktime
Real lr_efficiency, lr_dt

SELECT start_time, end_time, dt_total
INTO :ldt_s, :ldt_e, :ll_dt_total
FROM shift
WHERE shift_num = :al_shift
USING SQLCA;
ll_worktime = f_hoursafter(ldt_s,ldt_e) * 3600

IF ll_dt_total > 0 THEN
	lr_efficiency = (ll_worktime - ll_dt_total)/ll_worktime
	RETURN lr_efficiency * 100
END IF

SELECT SUM((ending_time - starting_time)*3600*24)
INTO :lr_dt
FROM dt_instance
WHERE shift_num = :al_shift
USING SQLCA;
IF lr_dt > 0 THEN
	lr_efficiency = (ll_worktime - lr_dt)/ll_worktime
	RETURN lr_efficiency * 100
END IF
 
SELECT SUM(duration)
INTO :ll_dt_total
FROM dt_summary
WHERE shift_num = :al_shift
USING SQLCA;
IF ll_dt_total > 0 THEN
	lr_efficiency = (ll_worktime - ll_dt_total)/ll_worktime
	RETURN lr_efficiency * 100
END IF

RETURN 0.0

end function

public function real wf_total_dt (long al_shift_id);long ll_dt
Real lr_dt_total

lr_dt_total = 0.0

SELECT dt_total
INTO :ll_dt
FROM shift
WHERE shift_num = :al_shift_id
USING SQLCA;

IF ll_dt > 0 THEN
	lr_dt_total = ll_dt / 3600
	RETURN lr_dt_total
END IF

SELECT SUM((ending_time - starting_time) * 24)
INTO :lr_dt_total
FROM dt_instance
WHERE shift_num = :al_shift_id
USING SQLCA;
IF lr_dt_total > 0 THEN
	RETURN lr_dt_total
END IF
 
SELECT SUM(duration)
INTO :ll_dt
FROM dt_summary
WHERE shift_num = :al_shift_id
USING SQLCA;
IF ll_dt > 0 THEN
	lr_dt_total = ll_dt / 3600
	RETURN lr_dt_total
END IF

RETURN 0.0

end function

on w_daily_prod_report_ds.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_close
end on

on w_daily_prod_report_ds.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cb_close)
end on

event open;call super::open;s_new_daily_prod_info lstr_q
Long ll_shift
Datetime ldt_s, ldt_e
Real lr_efficiency, lr_dt_total

lstr_q= Message.PowerObjectParm

SELECT shift_num, start_time, end_time INTO :ll_shift, :ldt_s, :ldt_e
FROM SHIFT
WHERE Line_num = :lstr_q.line_id AND schedule_type = :lstr_q.schedule_type AND To_Date(start_Time) = :lstr_q.prod_date
USING SQLCA;

IF IsNULL(ll_shift) or IsNULL(ldt_s) or IsNULL(ldt_e) THEN
	MessageBox("Warning", "Invalid information.")
	RETURN -1
END IF

lr_efficiency = wf_efficiency(ll_shift)
lr_dt_total = wf_total_dt(ll_shift)

dw_Report.SetTransObject(sqlca)
//dw_report.Retrieve(ll_shift, lstr_q.line_id, ldt_s, ldt_e, lr_efficiency, lr_dt_total)
dw_report.Retrieve(ll_shift)

RETURN 1




end event

type dw_report from u_dw within w_daily_prod_report_ds
integer x = 11
integer y = 13
integer width = 3310
integer height = 1555
integer taborder = 40
string dataobject = "d_daily_prod_dt_total"
boolean hscrollbar = true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type cb_setzoom from u_cb within w_daily_prod_report_ds
integer x = 914
integer y = 1584
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_ds
integer x = 1543
integer y = 1584
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

type cb_close from u_cb within w_daily_prod_report_ds
string tag = "Close without printing"
integer x = 2172
integer y = 1584
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

