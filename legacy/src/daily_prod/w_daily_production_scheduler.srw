$PBExportHeader$w_daily_production_scheduler.srw
$PBExportComments$<Sheet>Schedule daily production's shift based line and date
forward
global type w_daily_production_scheduler from w_sheet
end type
type em_calendar from u_em within w_daily_production_scheduler
end type
type uo_calendar_1 from u_calendar within w_daily_production_scheduler
end type
type cb_close from u_cb within w_daily_production_scheduler
end type
type cb_report from u_cb within w_daily_production_scheduler
end type
type cb_modify from u_cb within w_daily_production_scheduler
end type
type gb_title from groupbox within w_daily_production_scheduler
end type
type st_1 from statictext within w_daily_production_scheduler
end type
type dw_schedule from u_dw within w_daily_production_scheduler
end type
type cb_print from u_cb within w_daily_production_scheduler
end type
type st_2 from statictext within w_daily_production_scheduler
end type
type st_3 from statictext within w_daily_production_scheduler
end type
type st_4 from statictext within w_daily_production_scheduler
end type
end forward

global type w_daily_production_scheduler from w_sheet
int X=461
int Y=259
int Width=3076
int Height=1971
WindowType WindowType=response!
boolean TitleBar=true
string Title="Daily Production - Scheduler"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
event type integer ue_date_changed ( )
event type integer ue_dw_info_refresh ( )
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
cb_close cb_close
cb_report cb_report
cb_modify cb_modify
gb_title gb_title
st_1 st_1
dw_schedule dw_schedule
cb_print cb_print
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_daily_production_scheduler w_daily_production_scheduler

type variables
String is_date
Date id_date

end variables

event ue_whoami;return "w_daily_production_scheduler"
end event

event ue_date_changed;dw_schedule.Reset()

//create new tree
is_date = em_calendar.Text
id_date = Date(is_date)
st_1.Text = "Date: " + is_date

IF f_hoursafter(DateTime(Today(), Now()),DateTime(Date(is_Date),Now())) >= 0 THEN 
	cb_modify.Enabled = TRUE
ELSE
	cb_modify.Enabled = FALSE
END IF

RETURN this.Event ue_dw_info_refresh()


end event

event ue_dw_info_refresh;dw_schedule.Reset()

Long ll_row, ll_line, ll_shift
Int li_c, li_def_c, li_rc, li_j, li_default
DateTime ldt_s, ldt_e
DateTime ldt_def_s, ldt_def_e
String ls_dur, ls_s, ls_line
String ls_date, ls_wd_s, ls_wd_e, ls_wd_c
DataStore lds_default

lds_default = CREATE datastore
lds_default.dataobject = "d_daily_prod_default_schedule"
lds_default.SetTransObject(SQLCA)
li_rc = lds_default.Retrieve()

FOR li_j = 1 TO li_rc
	ll_row = dw_schedule.InsertRow(0)
	
	ll_line = lds_default.GetItemNumber(li_j, "line_num")
	ll_shift = lds_default.GetItemNumber(li_j, "schedule_type")
	ls_line = lds_default.GetItemString(li_j, "line_line_desc")
	
	CHOOSE CASE Upper(DayName(id_date))
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
		WHERE (Shift_schedule_date =:id_date) AND (line_num = :ll_line) and (schedule_type = :ll_shift) 
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
		
		dw_schedule.SetItem(ll_row,"line", ls_line) 
		dw_schedule.SetItem(ll_row,"cancel", li_c) 
		dw_schedule.SetItem(ll_row,"start",String(Time(ldt_s))) 
		dw_schedule.SetItem(ll_row,"end",String(Time(ldt_e)))
		dw_schedule.SetItem(ll_row,"shift",ls_s)
		dw_schedule.SetItem(ll_row,"default",li_default)

		IF IsNULL(ldt_e) THEN 
			SetNULL(ls_dur) 
		ELSE 
			ls_dur = String(f_hoursafter(ldt_s,ldt_e), "##.#")
		END IF
		dw_schedule.SetItem(ll_row,"duration",ls_dur)
		
NEXT

DESTROY lds_default
dw_schedule.ResetUpdate()

RETURN 1
end event

on w_daily_production_scheduler.create
int iCurrent
call super::create
this.em_calendar=create em_calendar
this.uo_calendar_1=create uo_calendar_1
this.cb_close=create cb_close
this.cb_report=create cb_report
this.cb_modify=create cb_modify
this.gb_title=create gb_title
this.st_1=create st_1
this.dw_schedule=create dw_schedule
this.cb_print=create cb_print
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_calendar
this.Control[iCurrent+2]=this.uo_calendar_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_report
this.Control[iCurrent+5]=this.cb_modify
this.Control[iCurrent+6]=this.gb_title
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.dw_schedule
this.Control[iCurrent+9]=this.cb_print
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
end on

on w_daily_production_scheduler.destroy
call super::destroy
destroy(this.em_calendar)
destroy(this.uo_calendar_1)
destroy(this.cb_close)
destroy(this.cb_report)
destroy(this.cb_modify)
destroy(this.gb_title)
destroy(this.st_1)
destroy(this.dw_schedule)
destroy(this.cb_print)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

event open;call super::open;Date ld_today


ld_today = Today()
em_calendar.Text =  String(ld_today, "mm/dd/yyyy")
is_date = em_calendar.Text
st_1.Text = "Date: " + is_date

RETURN this.Event ue_dw_info_refresh()








end event

event close;call super::close;f_display_app()
end event

type em_calendar from u_em within w_daily_production_scheduler
int X=128
int Y=861
int Width=428
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateMask!
double Increment=0
string MinMax=""
FontCharSet FontCharSet=Ansi!
end type

event constructor;//this.of_SetDropDownCalendar(TRUE)
//this.iuo_calendar.of_SetAlwaysRedraw(TRUE)
//this.iuo_calendar.of_SetinitialValue(TRUE)
//
//this.iuo_calendar.of_SetSaturdayBold(TRUE)
//this.iuo_calendar.of_SetSaturdayColor(RGB(0, 255, 0)) 
//this.iuo_calendar.of_SetSundayBold(TRUE) 
//this.iuo_calendar.of_SetSundayColor(RGB(0, 255, 0))
//
//
//this.iuo_calendar.of_SetCloseonClick(TRUE)

uo_calendar_1.of_SetRequestor(this)
end event

event modified;//RETURN Parent.Event ue_date_changed()
end event

event other;IF em_calendar.Text <>  is_date Then 
	//MessageBox("", "hello")
	RETURN Parent.Event ue_date_changed()
ELSE
	RETURN 0
END IF
end event

type uo_calendar_1 from u_calendar within w_daily_production_scheduler
int X=18
int Y=157
int Width=706
int Height=659
int TabOrder=10
boolean BringToTop=true
long BackColor=80269524
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type cb_close from u_cb within w_daily_production_scheduler
int X=2586
int Y=1715
int Height=122
int TabOrder=60
boolean BringToTop=true
string Text="&Close"
int TextSize=-11
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_schedule.ResetUpdate()
Close(parent)
end event

type cb_report from u_cb within w_daily_production_scheduler
int X=1997
int Y=1715
int Height=122
int TabOrder=50
string Tag="shift report"
boolean BringToTop=true
string Text="&Reports"
int TextSize=-11
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;s_new_daily_prod_info lstr_q


OpenwithParm(w_daily_prod_schedule_reports, lstr_q)

RETURN 1

end event

type cb_modify from u_cb within w_daily_production_scheduler
int X=819
int Y=1715
int Height=122
int TabOrder=40
string Tag="modify shift info"
boolean BringToTop=true
string Text="&Modify"
int TextSize=-11
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Int li_temp

IF Today() > id_date THEN
	MessageBox("Warning", "You may only schedule future shifts.")
	RETURN -1
END IF

OpenwithParm(w_daily_production_modify_schedule, is_date)
li_temp = Message.DoubleParm

IF li_temp > 0 THEN Parent.Event ue_dw_info_refresh()
RETURN 1


end event

type gb_title from groupbox within w_daily_production_scheduler
int X=757
int Y=16
int Width=2238
int Height=1677
int TabOrder=80
string Text="Shift Info"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=80269524
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_daily_production_scheduler
int X=44
int Y=32
int Width=647
int Height=77
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80269524
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_schedule from u_dw within w_daily_production_scheduler
int X=797
int Y=86
int Width=2143
int Height=1565
int TabOrder=30
boolean BringToTop=true
string DataObject="d_daily_prod_shift_schedule_daily"
end type

event constructor;This.SetTransObject(sqlca)

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type cb_print from u_cb within w_daily_production_scheduler
int X=1408
int Y=1715
int Height=122
int TabOrder=20
string Tag="print current shift list"
boolean BringToTop=true
string Text="&Print"
int TextSize=-11
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;OpenwithParm(w_daily_prod_report_daily_shift_schedule, is_date)

end event

type st_2 from statictext within w_daily_production_scheduler
int X=33
int Y=870
int Width=684
int Height=128
boolean Enabled=false
boolean BringToTop=true
string Text="*Default - Shift is using default schedule."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_daily_production_scheduler
int X=33
int Y=1014
int Width=695
int Height=179
boolean Enabled=false
boolean BringToTop=true
string Text="*Scheduled - Shift was scheduled by operation management."
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_daily_production_scheduler
int X=33
int Y=1219
int Width=691
int Height=179
boolean Enabled=false
boolean BringToTop=true
string Text="*Cancelled - Shift has been cancelled."
boolean FocusRectangle=false
long TextColor=255
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

