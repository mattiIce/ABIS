$PBExportHeader$w_report_uptime_per_line.srw
$PBExportComments$up time report tools for each line
forward
global type w_report_uptime_per_line from w_sheet
end type
type ddlb_toyear from u_ddlb within w_report_uptime_per_line
end type
type ddlb_fromyear from u_ddlb within w_report_uptime_per_line
end type
type ddlb_today from u_ddlb within w_report_uptime_per_line
end type
type ddlb_fromday from u_ddlb within w_report_uptime_per_line
end type
type st_6 from statictext within w_report_uptime_per_line
end type
type st_5 from statictext within w_report_uptime_per_line
end type
type rb_monthly from u_rb within w_report_uptime_per_line
end type
type ddlb_tomonth from u_ddlb within w_report_uptime_per_line
end type
type ddlb_frommonth from u_ddlb within w_report_uptime_per_line
end type
type st_4 from statictext within w_report_uptime_per_line
end type
type st_3 from statictext within w_report_uptime_per_line
end type
type st_2 from statictext within w_report_uptime_per_line
end type
type dw_report from u_dw within w_report_uptime_per_line
end type
type cb_print from u_cb within w_report_uptime_per_line
end type
type cb_close from u_cb within w_report_uptime_per_line
end type
type cb_setzoom from u_cb within w_report_uptime_per_line
end type
type gb_4 from u_gb within w_report_uptime_per_line
end type
type gb_2 from u_gb within w_report_uptime_per_line
end type
type rb_daily from u_rb within w_report_uptime_per_line
end type
type rb_yearly from u_rb within w_report_uptime_per_line
end type
type st_1 from statictext within w_report_uptime_per_line
end type
type cb_retrieve from u_cb within w_report_uptime_per_line
end type
end forward

global type w_report_uptime_per_line from w_sheet
string tag = "ABCO production reports"
integer x = 4
integer y = 3
integer width = 3950
integer height = 1792
string title = "Production Line Up Time Report"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
event type string ue_whoami ( )
ddlb_toyear ddlb_toyear
ddlb_fromyear ddlb_fromyear
ddlb_today ddlb_today
ddlb_fromday ddlb_fromday
st_6 st_6
st_5 st_5
rb_monthly rb_monthly
ddlb_tomonth ddlb_tomonth
ddlb_frommonth ddlb_frommonth
st_4 st_4
st_3 st_3
st_2 st_2
dw_report dw_report
cb_print cb_print
cb_close cb_close
cb_setzoom cb_setzoom
gb_4 gb_4
gb_2 gb_2
rb_daily rb_daily
rb_yearly rb_yearly
st_1 st_1
cb_retrieve cb_retrieve
end type
global w_report_uptime_per_line w_report_uptime_per_line

type variables
String is_line
Long il_line
String is_fromyear, is_toyear, is_frommonth, is_tomonth, is_fromday, is_today

end variables

forward prototypes
public subroutine wf_settitle ()
end prototypes

public subroutine wf_settitle ();IF rb_daily.Checked THEN 
	  dw_report.object.gr_1.title = "Daily Uptime Summary for " + is_line
END IF

IF rb_monthly.Checked THEN 
	  dw_report.object.gr_1.title = "Monthly Uptime Summary for " + is_line
END IF

IF rb_yearly.Checked THEN 
	  dw_report.object.gr_1.title = "Yearly Uptime Summary for " + is_line
END IF




end subroutine

on w_report_uptime_per_line.create
int iCurrent
call super::create
this.ddlb_toyear=create ddlb_toyear
this.ddlb_fromyear=create ddlb_fromyear
this.ddlb_today=create ddlb_today
this.ddlb_fromday=create ddlb_fromday
this.st_6=create st_6
this.st_5=create st_5
this.rb_monthly=create rb_monthly
this.ddlb_tomonth=create ddlb_tomonth
this.ddlb_frommonth=create ddlb_frommonth
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_report=create dw_report
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_setzoom=create cb_setzoom
this.gb_4=create gb_4
this.gb_2=create gb_2
this.rb_daily=create rb_daily
this.rb_yearly=create rb_yearly
this.st_1=create st_1
this.cb_retrieve=create cb_retrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_toyear
this.Control[iCurrent+2]=this.ddlb_fromyear
this.Control[iCurrent+3]=this.ddlb_today
this.Control[iCurrent+4]=this.ddlb_fromday
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.rb_monthly
this.Control[iCurrent+8]=this.ddlb_tomonth
this.Control[iCurrent+9]=this.ddlb_frommonth
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.dw_report
this.Control[iCurrent+14]=this.cb_print
this.Control[iCurrent+15]=this.cb_close
this.Control[iCurrent+16]=this.cb_setzoom
this.Control[iCurrent+17]=this.gb_4
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.rb_daily
this.Control[iCurrent+20]=this.rb_yearly
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.cb_retrieve
end on

on w_report_uptime_per_line.destroy
call super::destroy
destroy(this.ddlb_toyear)
destroy(this.ddlb_fromyear)
destroy(this.ddlb_today)
destroy(this.ddlb_fromday)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.rb_monthly)
destroy(this.ddlb_tomonth)
destroy(this.ddlb_frommonth)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_report)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_setzoom)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.rb_daily)
destroy(this.rb_yearly)
destroy(this.st_1)
destroy(this.cb_retrieve)
end on

event pfc_print;RETURN dw_report.Event pfc_print()
end event

event open;call super::open;String ls_parm, ls_month
Date ldt_e, ldt_s, ldt_temp
Boolean lb_found
Long ll_m
Real lr_r


ls_parm = Message.StringParm

IF Pos(ls_parm, '6') > 0 THEN
	is_line = 'BL 110'
	il_line = 6
ELSE
	is_line = 'BL 84'
	il_line = 7
END IF

IF Pos(ls_parm, 'daily') > 0 THEN 
	rb_daily.Checked = TRUE
	is_toyear = String(year(today())) 
	ddlb_toyear.SelectItem(ddlb_toyear.FindItem(is_toyear, 1))
	CHOOSE CASE month(today())
	CASE 1
		ls_month = 'January'
	CASE 2
		ls_month = 'February'
	CASE 3
		ls_month = 'March'
	CASE 4
		ls_month = 'April'
	CASE 5
		ls_month = 'May'
	CASE 6
		ls_month = 'June'
	CASE 7 
		ls_month = 'July'
	CASE 8
		ls_month = 'August'
	CASE 9
		ls_month = 'September'
	CASE 10
		ls_month = 'October'
	CASE 11
		ls_month = 'November'
	CASE 12
		ls_month = 'December'
	END CHOOSE
	is_tomonth = String(month(Today()))
	ddlb_tomonth.SelectItem(ddlb_tomonth.FindItem(ls_month, 1))	
	is_today = String(day(Today()))
	ddlb_today.SelectItem(ddlb_today.FindItem(is_today, 1))	
	
	ldt_e = Today()
	lb_found = FALSE
	FOR ll_m = 14	to 0 STEP -1
		lr_r = -1 * ll_m
		ldt_temp = RelativeDate(ldt_e, lr_r)
		IF (DayName(ldt_temp) = 'Monday') AND NOT(lb_found) THEN 
			ldt_s = ldt_temp
			lb_found = TRUE
		END IF
	NEXT
	is_fromyear = String(year(ldt_s))
	ddlb_fromyear.SelectItem(ddlb_fromyear.FindItem(is_fromyear, 1))
	CHOOSE CASE month(ldt_s)
	CASE 1
		ls_month = 'January'
	CASE 2
		ls_month = 'February'
	CASE 3
		ls_month = 'March'
	CASE 4
		ls_month = 'April'
	CASE 5
		ls_month = 'May'
	CASE 6
		ls_month = 'June'
	CASE 7 
		ls_month = 'July'
	CASE 8
		ls_month = 'August'
	CASE 9
		ls_month = 'September'
	CASE 10
		ls_month = 'October'
	CASE 11
		ls_month = 'November'
	CASE 12
		ls_month = 'December'
	END CHOOSE
	is_frommonth = String(month(ldt_s))
	ddlb_frommonth.SelectItem(ddlb_frommonth.FindItem(ls_month, 1))
	is_fromday = String(day(ldt_s))
	ddlb_fromday.SelectItem(ddlb_fromday.FindItem(is_fromday, 1))
	dw_report.Event ue_daily_retrieve()
END IF

IF Pos(ls_parm, 'monthly') > 0 THEN 
	rb_monthly.Checked = TRUE
	is_toyear = String(year(today()))
	ddlb_toyear.SelectItem(ddlb_toyear.FindItem(is_toyear, 1))
	is_fromyear = String(year(today()) - 1)
	ddlb_fromyear.SelectItem(ddlb_fromyear.FindItem(is_fromyear, 1))
	CHOOSE CASE month(today())
	CASE 1
		ls_month = 'January'
	CASE 2
		ls_month = 'February'
	CASE 3
		ls_month = 'March'
	CASE 4
		ls_month = 'April'
	CASE 5
		ls_month = 'May'
	CASE 6
		ls_month = 'June'
	CASE 7 
		ls_month = 'July'
	CASE 8
		ls_month = 'August'
	CASE 9
		ls_month = 'September'
	CASE 10
		ls_month = 'October'
	CASE 11
		ls_month = 'November'
	CASE 12
		ls_month = 'December'
	END CHOOSE
	is_tomonth = String(month(today()))
	ddlb_tomonth.SelectItem(ddlb_tomonth.FindItem(ls_month, 1))
	is_frommonth = '1'
	ddlb_frommonth.SelectItem(ddlb_frommonth.FindItem('January', 1))
	dw_report.Event ue_monthly_retrieve()
END IF

IF Pos(ls_parm, 'yearly') > 0 THEN 
	rb_yearly.Checked = TRUE
	is_toyear = String(year(today()))
	ddlb_toyear.SelectItem(ddlb_toyear.FindItem(is_toyear, 1))
	is_fromyear = '2006'
	ddlb_fromyear.SelectItem(ddlb_fromyear.FindItem('2006', 1))
	dw_report.Event ue_yearly_retrieve()
END IF

this.Title = "Production Line UpTime Report - " + is_line
end event

type ddlb_toyear from u_ddlb within w_report_uptime_per_line
integer x = 962
integer y = 131
integer width = 285
integer height = 595
integer taborder = 40
string facename = "Arial"
end type

event constructor;call super::constructor;Long ll_year, ll_c

ll_year = year(Today())
IF ll_year > 0 THEN 
	FOR ll_c = 2004 TO ll_year  //first downtime year
		this.AddItem(String(ll_c))
	NEXT
END IF
end event

event selectionchanged;call super::selectionchanged;is_toyear = Text(index)
RETURN 1
end event

type ddlb_fromyear from u_ddlb within w_report_uptime_per_line
integer x = 962
integer y = 51
integer width = 285
integer height = 595
integer taborder = 30
string facename = "Arial"
end type

event constructor;call super::constructor;Long ll_year, ll_c

ll_year = year(Today())
IF ll_year > 0 THEN 
	FOR ll_c = 2004 TO ll_year  //first downtime year
		this.AddItem(String(ll_c))
	NEXT
END IF
end event

event selectionchanged;call super::selectionchanged;is_fromyear = Text(index)
RETURN 1
end event

type ddlb_today from u_ddlb within w_report_uptime_per_line
integer x = 1971
integer y = 131
integer width = 194
integer height = 858
integer taborder = 20
string facename = "Arial"
boolean sorted = false
string item[] = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"}
end type

event selectionchanged;call super::selectionchanged;is_today = Text(index)
RETURN 1
end event

type ddlb_fromday from u_ddlb within w_report_uptime_per_line
integer x = 1971
integer y = 51
integer width = 194
integer height = 858
integer taborder = 20
string facename = "Arial"
boolean sorted = false
string item[] = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"}
end type

event selectionchanged;call super::selectionchanged;is_fromday = Text(index)
RETURN 1
end event

type st_6 from statictext within w_report_uptime_per_line
integer x = 1858
integer y = 144
integer width = 110
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Day"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_report_uptime_per_line
integer x = 1251
integer y = 144
integer width = 168
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Month"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_monthly from u_rb within w_report_uptime_per_line
integer x = 2392
integer y = 70
integer width = 252
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Monthly"
end type

event clicked;call super::clicked;wf_settitle()
dw_report.Event ue_retrieve()
RETURN 1
end event

type ddlb_tomonth from u_ddlb within w_report_uptime_per_line
integer x = 1423
integer y = 131
integer width = 432
integer height = 858
integer taborder = 170
string facename = "Arial"
boolean sorted = false
string item[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
end type

event selectionchanged;call super::selectionchanged;String ls_tomonth_w
ls_tomonth_w = Text(index)
CHOOSE CASE UPPER(ls_tomonth_w)
	CASE 'JANUARY'
		is_tomonth = '1'
	CASE 'FEBRUARY'
		is_tomonth = '2'
	CASE 'MARCH'
		is_tomonth = '3'
	CASE 'APRIL'
		is_tomonth = '4'
	CASE 'MAY'
		is_tomonth = '5'
	CASE 'JUNE'
		is_tomonth = '6'
	CASE 'JULY' 
		is_tomonth = '7'
	CASE 'AUGUST'
		is_tomonth = '8'
	CASE 'SEPTEMBER'
		is_tomonth = '9'
	CASE 'OCTOBER'
		is_tomonth = '10'
	CASE 'NOVEMBER'
		is_tomonth = '11'
	CASE 'DECEMBER'
		is_tomonth = '12'
END CHOOSE
RETURN 1
end event

type ddlb_frommonth from u_ddlb within w_report_uptime_per_line
integer x = 1423
integer y = 51
integer width = 432
integer height = 858
integer taborder = 170
string facename = "Arial"
boolean sorted = false
string item[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
end type

event selectionchanged;call super::selectionchanged;String ls_frommonth_w

ls_frommonth_w = Text(index)
CHOOSE CASE UPPER(ls_frommonth_w)
	CASE 'JANUARY'
		is_frommonth = '1'
	CASE 'FEBRUARY'
		is_frommonth = '2'
	CASE 'MARCH'
		is_frommonth = '3'
	CASE 'APRIL'
		is_frommonth = '4'
	CASE 'MAY'
		is_frommonth = '5'
	CASE 'JUNE'
		is_frommonth = '6'
	CASE 'JULY' 
		is_frommonth = '7'
	CASE 'AUGUST'
		is_frommonth = '8'
	CASE 'SEPTEMBER'
		is_frommonth = '9'
	CASE 'OCTOBER'
		is_frommonth = '10'
	CASE 'NOVEMBER'
		is_frommonth = '11'
	CASE 'DECEMBER'
		is_frommonth = '12'
END CHOOSE
RETURN 1
end event

type st_4 from statictext within w_report_uptime_per_line
integer x = 1858
integer y = 61
integer width = 113
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Day"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_report_uptime_per_line
integer x = 702
integer y = 131
integer width = 249
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "To: Year"
boolean focusrectangle = false
end type

type st_2 from statictext within w_report_uptime_per_line
integer x = 699
integer y = 64
integer width = 249
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "From: Year"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_report from u_dw within w_report_uptime_per_line
event ue_specs ( )
event ue_retrieve ( )
event ue_daily_retrieve ( )
event ue_monthly_retrieve ( )
event ue_yearly_retrieve ( )
integer x = 11
integer y = 224
integer width = 3902
integer height = 1389
integer taborder = 10
string dataobject = "d_report_daily_uptime"
boolean hscrollbar = true
end type

event ue_retrieve();Long ll_fromyear, ll_toyear, ll_frommonth, ll_tomonth, ll_y, ll_m, ll_yt, ll_mt
Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_total
Real lr_totalup
Date ldt_s, ldt_e
String ls_shift


this.Reset()

SetPointer(HourGlass!)

ll_fromyear = Long(is_fromyear)
ll_toyear = Long(is_toyear)

IF ll_fromyear > ll_toyear THEN
	MessageBox("Warning", "Ending year must be after begining year.")
	RETURN
END IF

ll_frommonth = Long(is_frommonth)
ll_tomonth = Long(is_tomonth)


IF ll_fromyear = ll_toyear AND ll_frommonth > ll_tomonth THEN
	MessageBox("Warning", "Ending month must be after begining month within a year.")
	RETURN
END IF


//IF ll_tomonth = 12 THEN
//	ll_yt = ll_toyear + 1
//	ll_mt = 1
//ELSE
//	ll_yt = ll_toyear
//	ll_mt = ll_tomonth + 1
//END IF
//
//ll_id = 1
//
//IF ll_fromyear = ll_toyear THEN
//	ll_y = ll_fromyear
//	FOR ll_m = ll_frommonth TO ll_tomonth
//		ll_total = 0
//			IF ll_m = 12 THEN 
//				ll_mt = 1
//				ll_yt = ll_y + 1
//			ELSE
//				ll_mt = ll_m + 1
//				ll_yt = ll_y
//			END IF
//			
//			ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
//			ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
//			FOR ll_whichshift = 1 TO 3
//				CHOOSE CASE ll_whichshift
//					CASE 1
//						ls_shift = "1st Shift"
//					CASE 2
//						ls_shift = "2nd Shift"
//					CASE 3
//						ls_shift = "3rd Shift"
//				END CHOOSE
//				
//
//				ll_newrow = this.InsertRow(0)
//				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
//				this.SetItem(ll_newrow, "Series_set", ls_shift)
//				this.SetItem(ll_newrow, "data_set", lr_totalup)
//			NEXT
//		ll_id = ll_id + 1
//	NEXT
//ELSE 
//	ll_y = ll_fromyear
//	FOR ll_m = ll_frommonth TO 12
//		ll_total = 0
//			IF ll_m = 12 THEN 
//				ll_mt = 1
//				ll_yt = ll_y + 1
//			ELSE
//				ll_mt = ll_m + 1
//				ll_yt = ll_y
//			END IF
//			
//			ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
//			ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
//			FOR ll_whichshift = 1 TO 3
//				CHOOSE CASE ll_whichshift
//					CASE 1
//						ls_shift = "1st Shift"
//					CASE 2
//						ls_shift = "2nd Shift"
//					CASE 3
//						ls_shift = "3rd Shift"
//				END CHOOSE
//				
//			 
//				ll_newrow = this.InsertRow(0)
//				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
//				this.SetItem(ll_newrow, "Series_set", ls_shift)
//				this.SetItem(ll_newrow, "data_set", lr_totalup)
//			NEXT
//		ll_id = ll_id + 1
//	NEXT
//	
//	ll_y = ll_y + 1
//	DO WHILE ll_y < ll_toyear
//		FOR ll_m = 1 TO 12
//			ll_total = 0
//				IF ll_m = 12 THEN 
//					ll_mt = 1
//					ll_yt = ll_y + 1
//				ELSE
//					ll_mt = ll_m + 1
//					ll_yt = ll_y
//				END IF
//				
//			 ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
//			 ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
//			FOR ll_whichshift = 1 TO 3
//				CHOOSE CASE ll_whichshift
//					CASE 1
//						ls_shift = "1st Shift"
//					CASE 2
//						ls_shift = "2nd Shift"
//					CASE 3
//						ls_shift = "3rd Shift"
//				END CHOOSE
//				
//
//				ll_newrow = this.InsertRow(0)
//				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
//				this.SetItem(ll_newrow, "Series_set", ls_shift)
//				this.SetItem(ll_newrow, "data_set", lr_totalup)
//			NEXT
//			ll_id = ll_id + 1
//		NEXT
//		ll_y = ll_y + 1
//	LOOP
//
//	ll_y = ll_toyear
//	FOR ll_m = 1 TO ll_tomonth
//		ll_total = 0
//			IF ll_m = 12 THEN 
//				ll_mt = 1
//				ll_yt = ll_y + 1
//			ELSE
//				ll_mt = ll_m + 1
//				ll_yt = ll_y
//			END IF
//			
//			 ldt_s = Date(String(ll_m) + "/01/" + String(ll_y)) 
//			 ldt_e = Date(String(ll_mt) + "/01/" + String(ll_yt)) 
//			FOR ll_whichshift = 1 TO 3
//				CHOOSE CASE ll_whichshift
//					CASE 1
//						ls_shift = "1st Shift"
//					CASE 2
//						ls_shift = "2nd Shift"
//					CASE 3
//						ls_shift = "3rd Shift"
//				END CHOOSE
//				
//
//			 
//				ll_newrow = this.InsertRow(0)
//				this.SetItem(ll_newrow, "Calendar", String(ldt_s, "mmmyy"))
//				this.SetItem(ll_newrow, "Series_set", ls_shift)
//				this.SetItem(ll_newrow, "data_set", lr_totalup)
//			NEXT
//		ll_id = ll_id + 1
//	NEXT
//END IF
//
IF rb_daily.Checked THEN this.Event ue_daily_retrieve()
IF rb_monthly.Checked THEN this.Event ue_monthly_retrieve()
IF rb_yearly.Checked THEN this.Event ue_yearly_retrieve()

this.ResetUpdate()

end event

event ue_daily_retrieve();Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup, lr_r
Date ldt_s, ldt_e, ldt_starting
Long ll_m, ll_y
String ls_shift, ls_day
Long ll_row

this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Daily Uptime Summary for " + is_line

ldt_starting = Date(is_frommonth + "/" + is_fromday + "/" + is_fromyear) 
ldt_e = Date(is_tomonth + "/" + is_today + "/" + is_toyear)

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
			 		WHERE TO_Char(start_time, 'yyyy/mm/dd') = :ls_day  AND schedule_type = :ll_whichshift AND line_num = :il_line and operator_initial is not NULL
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

event ue_monthly_retrieve();Long ll_fromyear, ll_toyear, ll_tomonth, ll_y, ll_m, ll_yt, ll_mt
Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup
Date ldt_s, ldt_e
String ls_shift
Long ll_row
DataStore lds_data


this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Monthly Uptime Summary for " + is_line


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
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = :il_line and operator_initial is not NULL
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
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = :il_line
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

event ue_yearly_retrieve();Long ll_fromyear, ll_toyear, ll_y
Long ll_id, ll_totaldt, ll_newrow, ll_whichshift, ll_totalup
Real lr_totalup
Date ldt_s, ldt_e
String ls_shift
Long ll_row

this.Reset()

SetPointer(HourGlass!)

this.object.gr_1.title = "Yearly Uptime Summary for " + is_line


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
			 		WHERE start_time >= :ldt_s AND end_time < :ldt_e AND schedule_type = :ll_whichshift AND line_num = :il_line and operator_initial is not NULL
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

type cb_print from u_cb within w_report_uptime_per_line
integer x = 3094
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 170
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;Parent.Event pfc_print()
end event

type cb_close from u_cb within w_report_uptime_per_line
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

type cb_setzoom from u_cb within w_report_uptime_per_line
integer x = 2600
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type gb_4 from u_gb within w_report_uptime_per_line
integer x = 2187
integer width = 728
integer height = 214
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Report Type"
end type

type gb_2 from u_gb within w_report_uptime_per_line
integer x = 666
integer width = 1507
integer height = 214
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Time Range"
end type

type rb_daily from u_rb within w_report_uptime_per_line
integer x = 2198
integer y = 74
integer width = 201
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Daily"
boolean checked = true
end type

event clicked;wf_settitle()
dw_report.Event ue_retrieve()
RETURN 1
end event

type rb_yearly from u_rb within w_report_uptime_per_line
integer x = 2648
integer y = 67
integer width = 252
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Yearly"
end type

event clicked;wf_settitle()
dw_report.Event ue_retrieve()
RETURN 1
end event

type st_1 from statictext within w_report_uptime_per_line
integer x = 1251
integer y = 61
integer width = 168
integer height = 67
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Month"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_retrieve from u_cb within w_report_uptime_per_line
integer x = 2107
integer y = 1629
integer width = 307
integer height = 74
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;dw_report.Event ue_retrieve()
Return 1
end event

