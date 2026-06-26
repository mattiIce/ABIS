$PBExportHeader$w_report_uptime.srw
$PBExportComments$up time report tools
forward
global type w_report_uptime from w_sheet
end type
type dw_84_yearly from u_dw within w_report_uptime
end type
type dw_84_daily from u_dw within w_report_uptime
end type
type dw_110_yearly from u_dw within w_report_uptime
end type
type dw_110_daily from u_dw within w_report_uptime
end type
type dw_84_monthly from u_dw within w_report_uptime
end type
type dw_110_monthly from u_dw within w_report_uptime
end type
type cb_close from u_cb within w_report_uptime
end type
type cb_retrieve from u_cb within w_report_uptime
end type
end forward

global type w_report_uptime from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 4528
integer height = 1795
string title = "Production Line Up Time Report"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
dw_84_yearly dw_84_yearly
dw_84_daily dw_84_daily
dw_110_yearly dw_110_yearly
dw_110_daily dw_110_daily
dw_84_monthly dw_84_monthly
dw_110_monthly dw_110_monthly
cb_close cb_close
cb_retrieve cb_retrieve
end type
global w_report_uptime w_report_uptime

type variables

end variables

forward prototypes
public subroutine wf_settitle ()
end prototypes

event type string ue_whoami();RETURN "w_report_uptime"
end event

public subroutine wf_settitle ();


end subroutine

on w_report_uptime.create
int iCurrent
call super::create
this.dw_84_yearly=create dw_84_yearly
this.dw_84_daily=create dw_84_daily
this.dw_110_yearly=create dw_110_yearly
this.dw_110_daily=create dw_110_daily
this.dw_84_monthly=create dw_84_monthly
this.dw_110_monthly=create dw_110_monthly
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_84_yearly
this.Control[iCurrent+2]=this.dw_84_daily
this.Control[iCurrent+3]=this.dw_110_yearly
this.Control[iCurrent+4]=this.dw_110_daily
this.Control[iCurrent+5]=this.dw_84_monthly
this.Control[iCurrent+6]=this.dw_110_monthly
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_retrieve
end on

on w_report_uptime.destroy
call super::destroy
destroy(this.dw_84_yearly)
destroy(this.dw_84_daily)
destroy(this.dw_110_yearly)
destroy(this.dw_110_daily)
destroy(this.dw_84_monthly)
destroy(this.dw_110_monthly)
destroy(this.cb_close)
destroy(this.cb_retrieve)
end on

event close;call super::close;f_display_app()
end event

type dw_84_yearly from u_dw within w_report_uptime
event ue_specs ( )
event ue_retrieve ( )
integer x = 3408
integer y = 848
integer width = 1097
integer height = 726
integer taborder = 70
string dataobject = "d_report_daily_uptime"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_fromyear, ll_toyear, ll_y
Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup
Date ldt_s, ldt_e
String ls_shift
Long ll_row

this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Yearly Uptime Summary for BL84"


ll_toyear = Long(String(Today(), 'yyyy'))
ll_fromyear = 2004

ll_id = 0

FOR ll_y = ll_fromyear TO ll_toyear

			
			ldt_s = Date(String(ll_y) +"/01/01") 
			ldt_e = Date(String(ll_y) + "/12/31") 
			ll_id = ll_id + 1
			
			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				

			 		SELECT SUM(NVL(dt_total,0)), SUM((end_time - start_time)*24*60*60) INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = 7 and operator_initial is not NULL
			 		USING SQLCA;				
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ll_y))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT
	
this.ResetUpdate()

end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event clicked;call super::clicked;OpenWithParm(w_report_uptime_per_line, '7 yearly')
RETURN 1
end event

type dw_84_daily from u_dw within w_report_uptime
event ue_specs ( )
event ue_retrieve ( )
integer x = 2256
integer y = 848
integer width = 1148
integer height = 726
integer taborder = 60
string dataobject = "d_report_daily_uptime"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup, lr_r
Boolean lb_found
Date ldt_s, ldt_e, ldt_temp, ldt_starting
Long ll_m, ll_y
String ls_shift, ls_day
Long ll_row

this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Daily Uptime Summary for BL84"

ldt_e = Today()
lb_found = FALSE
FOR ll_m = 14	to 0 STEP -1
	lr_r = -1 * ll_m
	ldt_temp = RelativeDate(ldt_e, lr_r)
	IF (DayName(ldt_temp) = 'Monday') AND NOT(lb_found) THEN 
		ldt_starting = ldt_temp
		lb_found = TRUE
	END IF
NEXT

ll_id = 0

ll_m = DaysAfter(ldt_starting, ldt_e)
FOR ll_y = 0 TO ll_m
	
		
			ldt_s = RelativeDate(ldt_starting, ll_y) 
			ls_day = String(ldt_s, 'yyyy/mm/dd')

			ll_id = ll_id + 1
			
			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				
            ll_totaldt = 0
				ll_totalup = 0
				
			 		SELECT NVL(dt_total,0), (end_time - start_time)*24*60*60 INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE TO_Char(start_time, 'yyyy/mm/dd') = :ls_day  AND schedule_type = :ll_whichshift AND line_num = 7 and operator_initial is not NULL
			 		USING SQLCA;
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mm/dd"))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT
	
this.ResetUpdate()

end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event clicked;call super::clicked;OpenWithParm(w_report_uptime_per_line, '7 daily')
RETURN 1
end event

type dw_110_yearly from u_dw within w_report_uptime
event ue_specs ( )
event ue_retrieve ( )
integer x = 1152
integer y = 848
integer width = 1097
integer height = 726
integer taborder = 50
string dataobject = "d_report_daily_uptime"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_fromyear, ll_toyear, ll_y
Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup
Date ldt_s, ldt_e
String ls_shift
Long ll_row

this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Yearly Uptime Summary for BL110"


ll_toyear = Long(String(Today(), 'yyyy'))
ll_fromyear = 2004

ll_id = 0

FOR ll_y = ll_fromyear TO ll_toyear

			
			ldt_s = Date(String(ll_y) +"/01/01") 
			ldt_e = Date(String(ll_y) + "/12/31") 
			ll_id = ll_id + 1
			
			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				

			 		SELECT SUM(NVL(dt_total,0)), SUM((end_time - start_time)*24*60*60) INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = 6 and operator_initial is not NULL
			 		USING SQLCA;				
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ll_y))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT
	
this.ResetUpdate()

end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event clicked;call super::clicked;OpenWithParm(w_report_uptime_per_line, '6 yearly')
RETURN 1
end event

type dw_110_daily from u_dw within w_report_uptime
event ue_specs ( )
event ue_retrieve ( )
integer y = 848
integer width = 1148
integer height = 726
integer taborder = 70
string dataobject = "d_report_daily_uptime"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup, lr_r
Boolean lb_found
Date ldt_s, ldt_e, ldt_temp, ldt_starting
Long ll_m, ll_y
String ls_shift, ls_day
Long ll_row

this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Daily Uptime Summary for BL110"

ldt_e = Today()
lb_found = FALSE
FOR ll_m = 14	to 0 STEP -1
	lr_r = -1 * ll_m
	ldt_temp = RelativeDate(ldt_e, lr_r)
	IF (DayName(ldt_temp) = 'Monday') AND NOT(lb_found) THEN 
		ldt_starting = ldt_temp
		lb_found = TRUE
	END IF
NEXT

ll_id = 0

ll_m = DaysAfter(ldt_starting, ldt_e)
FOR ll_y = 0 TO ll_m
	
		
			ldt_s = RelativeDate(ldt_starting, ll_y) 
			ls_day = String(ldt_s, 'yyyy/mm/dd')

			ll_id = ll_id + 1
			
			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				
            ll_totaldt = 0
				ll_totalup = 0
				
			 		SELECT NVL(dt_total,0), (end_time - start_time)*24*60*60 INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE TO_Char(start_time, 'yyyy/mm/dd') = :ls_day  AND schedule_type = :ll_whichshift AND line_num = 6 and operator_initial is not NULL
			 		USING SQLCA;
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mm/dd"))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT
	
this.ResetUpdate()

end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event clicked;call super::clicked;OpenWithParm(w_report_uptime_per_line, '6 daily')
RETURN 1
end event

type dw_84_monthly from u_dw within w_report_uptime
event ue_specs ( )
event ue_retrieve ( )
integer x = 2256
integer y = 10
integer width = 2249
integer height = 835
integer taborder = 20
string dataobject = "d_report_daily_uptime"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_fromyear, ll_toyear, ll_tomonth, ll_y, ll_m, ll_yt, ll_mt
Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup
Date ldt_s, ldt_e
String ls_shift
Long ll_row
DataStore lds_data


this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Monthly Uptime Summary for BL84"


ll_toyear = Long(String(Today(), 'yyyy'))
ll_fromyear = ll_toyear - 1
ll_tomonth = Long(String(Today(), 'mm'))

lds_data = Create DataStore
lds_data.DataObject = "d_shift_uptime_data_per_line"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve(Date(String(ll_m) + "/01/" + String(ll_y)), Today(), 7)

ll_id = 0

ll_y = ll_fromyear
FOR ll_m = 1 TO 12
	
			IF ll_m = 12 THEN 
				ll_mt = 1
				ll_yt = ll_y + 1
			ELSE
				ll_mt = ll_m + 1
				ll_yt = ll_y
			END IF
			
			ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			ll_id = ll_id + 1
			
			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				

			 		SELECT SUM(NVL(dt_total,0)), SUM((end_time - start_time)*24*60*60) INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = 7 and operator_initial is not NULL
			 		USING SQLCA;				
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT
	
ll_y = ll_toyear
FOR ll_m = 1 TO ll_tomonth
		
			IF ll_m = 12 THEN 
				ll_mt = 1
				ll_yt = ll_y + 1
			ELSE
				ll_mt = ll_m + 1
				ll_yt = ll_y
			END IF
			
			ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			ll_id = ll_id + 1

			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				

			 		SELECT SUM(NVL(dt_total,0)), SUM((end_time - start_time)*24*60*60) INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = 7 and operator_initial is not NULL
			 		USING SQLCA;				
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT	

DESTROY lds_data

this.ResetUpdate()

end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event clicked;call super::clicked;OpenWithParm(w_report_uptime_per_line, '7 monthly')
RETURN 1
end event

type dw_110_monthly from u_dw within w_report_uptime
event ue_specs ( )
event ue_retrieve ( )
integer y = 10
integer width = 2249
integer height = 835
integer taborder = 10
string dataobject = "d_report_daily_uptime"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_fromyear, ll_toyear, ll_tomonth, ll_y, ll_m, ll_yt, ll_mt
Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup
Date ldt_s, ldt_e
String ls_shift
Long ll_row
DataStore lds_data


this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Monthly Uptime Summary for BL110"


ll_toyear = Long(String(Today(), 'yyyy'))
ll_fromyear = ll_toyear - 1
ll_tomonth = Long(String(Today(), 'mm'))

lds_data = Create DataStore
lds_data.DataObject = "d_shift_uptime_data_per_line"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve(Date(String(ll_m) + "/01/" + String(ll_y)), Today(), 6)

ll_id = 0

ll_y = ll_fromyear
FOR ll_m = 1 TO 12
	
			IF ll_m = 12 THEN 
				ll_mt = 1
				ll_yt = ll_y + 1
			ELSE
				ll_mt = ll_m + 1
				ll_yt = ll_y
			END IF
			
			ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			ll_id = ll_id + 1
			
			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				

			 		SELECT SUM(NVL(dt_total,0)), SUM((end_time - start_time)*24*60*60) INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = 6 and operator_initial is not NULL
			 		USING SQLCA;				
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT
	
ll_y = ll_toyear
FOR ll_m = 1 TO ll_tomonth
		
			IF ll_m = 12 THEN 
				ll_mt = 1
				ll_yt = ll_y + 1
			ELSE
				ll_mt = ll_m + 1
				ll_yt = ll_y
			END IF
			
			ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
			ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
			ll_id = ll_id + 1

			FOR ll_whichshift = 1 TO 3
				CHOOSE CASE ll_whichshift
					CASE 1
						ls_shift = "1st Shift"
					CASE 2
						ls_shift = "2nd Shift"
					CASE 3
						ls_shift = "3rd Shift"
				END CHOOSE
				

			 		SELECT SUM(NVL(dt_total,0)), SUM((end_time - start_time)*24*60*60) INTO :ll_totaldt, :ll_totalup
			 		FROM shift
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = 6 and operator_initial is not NULL
			 		USING SQLCA;				
			   
				lr_totalup = 1.0 * (ll_totalup - ll_totaldt) / 3600
				
				ll_newrow = this.InsertRow(0)
				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
				this.SetItem(ll_newrow, "Series_set", ls_shift)
				this.SetItem(ll_newrow, "data_set", lr_totalup)
				this.SetItem(ll_newrow, "ID", ll_id)
			NEXT
	NEXT	

DESTROY lds_data

this.ResetUpdate()

end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

event constructor;of_SetBase(TRUE)
of_SetPrintPreview(TRUE)
of_SetFilter(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)

SetTransObject(SQLCA)

end event

event clicked;call super::clicked;OpenWithParm(w_report_uptime_per_line, '6 monthly')
RETURN 1
end event

type cb_close from u_cb within w_report_uptime
string tag = "Exit"
integer x = 3588
integer y = 1629
integer width = 322
integer height = 74
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_retrieve from u_cb within w_report_uptime
integer x = 3141
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_110_monthly.Event ue_retrieve()
dw_110_daily.Event ue_retrieve()
dw_110_yearly.Event ue_retrieve()
dw_84_monthly.Event ue_retrieve()
dw_84_daily.Event ue_retrieve()
dw_84_yearly.Event ue_retrieve()
Return 1
end event

