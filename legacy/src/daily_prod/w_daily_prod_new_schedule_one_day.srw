$PBExportHeader$w_daily_prod_new_schedule_one_day.srw
$PBExportComments$list options for each day's shift settings.
forward
global type w_daily_prod_new_schedule_one_day from w_sheet
end type
type dw_schedule from u_dw within w_daily_prod_new_schedule_one_day
end type
type cb_apply from u_cb within w_daily_prod_new_schedule_one_day
end type
type cb_cancel from u_cb within w_daily_prod_new_schedule_one_day
end type
type st_1 from statictext within w_daily_prod_new_schedule_one_day
end type
type st_2 from statictext within w_daily_prod_new_schedule_one_day
end type
type dw_profile from u_dw within w_daily_prod_new_schedule_one_day
end type
end forward

global type w_daily_prod_new_schedule_one_day from w_sheet
int X=859
int Y=342
int Width=2300
int Height=1219
WindowType WindowType=response!
boolean TitleBar=true
string Title="New shift schedule "
long BackColor=80269524
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_schedule dw_schedule
cb_apply cb_apply
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
dw_profile dw_profile
end type
global w_daily_prod_new_schedule_one_day w_daily_prod_new_schedule_one_day

type variables
s_new_daily_prod_info istr_q
uo_schedule iu_schedule
end variables

on w_daily_prod_new_schedule_one_day.create
int iCurrent
call super::create
this.dw_schedule=create dw_schedule
this.cb_apply=create cb_apply
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_2=create st_2
this.dw_profile=create dw_profile
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_schedule
this.Control[iCurrent+2]=this.cb_apply
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_profile
end on

on w_daily_prod_new_schedule_one_day.destroy
call super::destroy
destroy(this.dw_schedule)
destroy(this.cb_apply)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_profile)
end on

event open;call super::open;Int li_row, li_c, li_i
Datetime ldt_s, ldt_e

istr_q = Message.PowerObjectParm
this.title = string(istr_q.prod_date) + " "  + istr_q.line_desc
//dw_schedule.Retrieve(istr_q.prod_date, istr_q.line_id, istr_q.schedule_type)
dw_profile.Retrieve( istr_q.line_id)
iu_schedule = Create uo_schedule
iu_schedule.update_all_shifts(istr_q.prod_date, istr_q.line_id)

for li_i = 1 to iu_schedule.get_schedule_count()
	dw_schedule.insertRow(0)
	dw_schedule.setitem(li_i, "schedule_type", iu_schedule.get_type_by_id(li_i))
	dw_schedule.setitem(li_i, "shift_starting_time", iu_schedule.get_start_by_id(li_i))
	dw_schedule.setitem(li_i, "shift_ending_time", iu_schedule.get_end_by_id(li_i))
	dw_schedule.setitem(li_i, "shift_cancelled", iu_schedule.get_status_by_id(li_i))
	dw_schedule.setitem(li_i, "shift_schedule_date", istr_q.prod_date)
	dw_schedule.setitem(li_i, "line_num", istr_q.line_id)
next

RETURN 1
end event
type dw_schedule from u_dw within w_daily_prod_new_schedule_one_day
int X=790
int Y=26
int Width=1412
int Height=669
int TabOrder=40
string DataObject="d_schedule_shift_date"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;This.SetTransObject(sqlca)

end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

event clicked;call super::clicked;return 0
//int li_row, li_i
//if row < 1 then
//	return 0
//end if
//li_row = dw_shift_schedule.RowCount()
//For li_i = li_row to 1 step -1
//	dw_shift_schedule.DeleteRow(li_i)
//next
//
////dw_shift_schedule.insertRow(0)
//dw_shift_schedule.insertRow(0)
//	dw_shift_schedule.setitem(1, "schedule_type", 1)
//	dw_shift_schedule.setitem(1, "shift_starting_time", dw_schedule.getitemdatetime(row,  "first_shift_start"))
//	dw_shift_schedule.setitem(1, "shift_ending_time", dw_schedule.getitemdatetime(row,  "first_shift_end"))
//	dw_shift_schedule.setitem(1, "shift_cancelled", dw_schedule.getitemnumber(row,  "first_shift_off"))
//	dw_shift_schedule.setitem(1, "shift_schedule_date", istr_q.prod_date)
//	dw_shift_schedule.setitem(1, "line_num", istr_q.line_id)
//dw_shift_schedule.insertRow(0)
//	dw_shift_schedule.setitem(2, "schedule_type", 2)
//	dw_shift_schedule.setitem(2, "shift_starting_time", dw_schedule.getitemdatetime(row,  "second_shift_start"))
//	dw_shift_schedule.setitem(2, "shift_ending_time", dw_schedule.getitemdatetime(row,  "second_shift_end"))
//	dw_shift_schedule.setitem(2, "shift_cancelled", dw_schedule.getitemnumber(row,  "second_shift_off"))
//	dw_shift_schedule.setitem(2, "shift_schedule_date", istr_q.prod_date)
//	dw_shift_schedule.setitem(2, "line_num", istr_q.line_id)
//dw_shift_schedule.insertRow(0)
//	dw_shift_schedule.setitem(3, "schedule_type", 3)
//	dw_shift_schedule.setitem(3, "shift_starting_time", dw_schedule.getitemdatetime(row,  "third_shift_start"))
//	dw_shift_schedule.setitem(3, "shift_ending_time", dw_schedule.getitemdatetime(row,  "third_shift_end"))
//	dw_shift_schedule.setitem(3, "shift_cancelled", dw_schedule.getitemnumber(row,  "third_shift_off"))
//	dw_shift_schedule.setitem(3, "shift_schedule_date", istr_q.prod_date)
//	dw_shift_schedule.setitem(3, "line_num", istr_q.line_id)
//

end event

type cb_apply from u_cb within w_daily_prod_new_schedule_one_day
int X=863
int Y=925
int Width=486
int Height=128
int TabOrder=10
boolean BringToTop=true
string Text="&Apply"
int TextSize=-12
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;int li_rc
  DELETE FROM "SHIFT_SCHEDULE"  
   WHERE ( TRUNC("SHIFT_SCHEDULE"."SHIFT_SCHEDULE_DATE") = :istr_q.prod_date ) AND  
         ( "SHIFT_SCHEDULE"."LINE_NUM" = :istr_q.line_id )   ;

li_rc = dw_schedule.Update(true, true)
IF li_rc >= 1 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox("Error", "Error saving shift info.")
	ROLLBACK USING SQLCA;
	RETURN -11
END IF


CloseWithReturn(Parent, 1)
RETURN 1


end event

type cb_cancel from u_cb within w_daily_prod_new_schedule_one_day
int X=1558
int Y=925
int Width=486
int Height=128
int TabOrder=30
string Tag="Close without printing"
string Text="&Cancel"
int TextSize=-12
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_schedule.ResetUpdate()
CloseWithReturn(Parent, 0)
RETURN 0

end event

type st_1 from statictext within w_daily_prod_new_schedule_one_day
int X=794
int Y=710
int Width=1488
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Please highlight schedule on the left, varify on the right."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80269524
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_daily_prod_new_schedule_one_day
int X=794
int Y=803
int Width=1046
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Click Apply to make the change."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80269524
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_profile from u_dw within w_daily_prod_new_schedule_one_day
int X=48
int Y=26
int Width=720
int Height=1078
int TabOrder=20
string DataObject="d_schedule_profile"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event clicked;call super::clicked;int li_row, li_i
if row < 1 then
	return 0
end if
li_row = dw_schedule.RowCount()
For li_i = li_row to 1 step -1
	dw_schedule.DeleteRow(li_i)
next

//dw_schedule.insertRow(0)
dw_schedule.insertRow(0)
	dw_schedule.setitem(1, "schedule_type", 1)
	dw_schedule.setitem(1, "shift_starting_time", DateTime(istr_q.prod_date, Time(dw_profile.getitemdatetime(row,  "first_shift_start"))))
	dw_schedule.setitem(1, "shift_ending_time", DateTime(istr_q.prod_date, Time(dw_profile.getitemdatetime(row,  "first_shift_end"))))
	dw_schedule.setitem(1, "shift_cancelled", dw_profile.getitemnumber(row,  "first_shift_off"))
	dw_schedule.setitem(1, "shift_schedule_date", istr_q.prod_date)
	dw_schedule.setitem(1, "line_num", istr_q.line_id)
dw_schedule.insertRow(0)
	dw_schedule.setitem(2, "schedule_type", 2)
	dw_schedule.setitem(2, "shift_starting_time", DateTime(istr_q.prod_date, Time(dw_profile.getitemdatetime(row,  "second_shift_start"))))
	dw_schedule.setitem(2, "shift_ending_time", DateTime(istr_q.prod_date, Time(dw_profile.getitemdatetime(row,  "second_shift_end"))))
	dw_schedule.setitem(2, "shift_cancelled", dw_profile.getitemnumber(row,  "second_shift_off"))
	dw_schedule.setitem(2, "shift_schedule_date", istr_q.prod_date)
	dw_schedule.setitem(2, "line_num", istr_q.line_id)
dw_schedule.insertRow(0)
	dw_schedule.setitem(3, "schedule_type", 3)
	dw_schedule.setitem(3, "shift_starting_time", DateTime(istr_q.prod_date, Time(dw_profile.getitemdatetime(row,  "third_shift_start"))))
	dw_schedule.setitem(3, "shift_ending_time", DateTime(RelativeDate(istr_q.prod_date, 1), Time(dw_profile.getitemdatetime(row,  "third_shift_end"))))
	dw_schedule.setitem(3, "shift_cancelled", dw_profile.getitemnumber(row,  "third_shift_off"))
	dw_schedule.setitem(3, "shift_schedule_date", istr_q.prod_date)
	dw_schedule.setitem(3, "line_num", istr_q.line_id)


end event
event constructor;This.SetTransObject(sqlca)

end event

