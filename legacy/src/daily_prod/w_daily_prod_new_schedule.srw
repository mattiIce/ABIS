$PBExportHeader$w_daily_prod_new_schedule.srw
$PBExportComments$<Response>User input new schedule info for a new shift
forward
global type w_daily_prod_new_schedule from w_sheet
end type
type dw_schedule from u_dw within w_daily_prod_new_schedule
end type
type cb_apply from u_cb within w_daily_prod_new_schedule
end type
type cb_cancel from u_cb within w_daily_prod_new_schedule
end type
end forward

global type w_daily_prod_new_schedule from w_sheet
integer x = 859
integer y = 342
integer width = 1232
integer height = 685
string title = "New shift schedule "
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
dw_schedule dw_schedule
cb_apply cb_apply
cb_cancel cb_cancel
end type
global w_daily_prod_new_schedule w_daily_prod_new_schedule

type variables
s_new_daily_prod_info istr_q

end variables

on w_daily_prod_new_schedule.create
int iCurrent
call super::create
this.dw_schedule=create dw_schedule
this.cb_apply=create cb_apply
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_schedule
this.Control[iCurrent+2]=this.cb_apply
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_daily_prod_new_schedule.destroy
call super::destroy
destroy(this.dw_schedule)
destroy(this.cb_apply)
destroy(this.cb_cancel)
end on

event open;call super::open;Int li_row, li_c
Datetime ldt_s, ldt_e

istr_q = Message.PowerObjectParm
dw_schedule.Retrieve(istr_q.prod_date, istr_q.line_id, istr_q.schedule_type)

IF dw_schedule.RowCount() > 0 THEN RETURN 0
 
li_row = dw_schedule.InsertRow(0)

IF li_row > 0 THEN
	
//	SELECT standard_starting_time, standard_ending_time 
//	INTO :ldt_s, :ldt_e
//	FROM line_schedule
//	WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
//	USING SQLCA;
		CHOOSE CASE UPPER(DayName(istr_q.prod_date))
			CASE "MONDAY"
				SELECT mon_start, mon_end, mon_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
				USING SQLCA;
			CASE "TUESDAY"
				SELECT tue_start, tue_end, tue_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
				USING SQLCA;
			CASE "WEDNESDAY"
				SELECT wed_start, wed_end, wed_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
				USING SQLCA;
			CASE "THURSDAY"
				SELECT thu_start, thu_end, thu_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
				USING SQLCA;
			CASE "FRIDAY"
				SELECT fri_start, fri_end, fri_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
				USING SQLCA;
			CASE "SATURDAY"
				SELECT sat_start, sat_end, sat_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
				USING SQLCA;
			CASE "SUNDAY"
				SELECT sun_start, sun_end, sun_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :istr_q.schedule_type)
				USING SQLCA;
		END CHOOSE	
	dw_schedule.SetItem(li_row, "shift_schedule_shift_schedule_date", istr_q.prod_date)
	dw_schedule.SetItem(li_row, "shift_schedule_line_num", istr_q.line_id)
	dw_schedule.SetItem(li_row, "shift_schedule_schedule_type", istr_q.schedule_type)
	dw_schedule.SetItem(li_row, "shift_schedule_shift_cancelled", li_c)
	dw_schedule.SetItem(li_row, "shift_schedule_shift_starting_time", DateTime(istr_q.prod_date, Time(ldt_s)))
	IF istr_q.schedule_type = 3 THEN
		dw_schedule.SetItem(li_row, "shift_schedule_shift_ending_time", DateTime(Relativedate(istr_q.prod_date,1), Time(ldt_e)))
	ELSE
		dw_schedule.SetItem(li_row, "shift_schedule_shift_ending_time", DateTime(istr_q.prod_date, Time(ldt_e)))
	END IF
END IF

RETURN 1
end event

type dw_schedule from u_dw within w_daily_prod_new_schedule
integer x = 15
integer y = 6
integer width = 1185
integer height = 429
integer taborder = 30
string dataobject = "d_daily_prod_shift_schedule_new"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;This.SetTransObject(sqlca)

end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type cb_apply from u_cb within w_daily_prod_new_schedule
integer x = 187
integer y = 458
integer width = 351
integer height = 93
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Apply"
end type

event clicked;Int li_rc, li_shift, li_next_cancel, li_pre_cancel
DateTime ldt_s, ldt_e, ldt_next_s, ldt_pre_e
Date ld_end, ld_start
long ll_cancel, ll_s, ll_e

dw_schedule.AcceptText()
li_rc = dw_schedule.Getrow()
IF li_rc <= 0 THEN
	MessageBox("Warning", "Invalid data. Please try again.")
	RETURN -2
END IF		
ldt_s = dw_schedule.GetItemDateTime(li_rc, "shift_schedule_shift_starting_time", Primary!, FALSE)
ldt_e = dw_schedule.GetItemDateTime(li_rc, "shift_schedule_shift_ending_time", Primary!, FALSE)
ll_cancel = dw_schedule.getitemnumber( li_rc, "shift_schedule_shift_cancelled", Primary!, FALSE)
IF ldt_s >= ldt_e THEN
	MessageBox("Warning", "Invalid date: ending time before starting time.")
	RETURN -3
END IF
IF Date(ldt_s) <> istr_q.prod_date THEN
	MessageBox("Warning", "Invalid starting date")
	RETURN -6
END IF
IF f_hoursafter(ldt_s, ldt_e) > 12 THEN
	MessageBox("Warning", "Shift lasts more than 12 hours")
	RETURN -7
END IF

//MessageBox("test", String(ldt_s))

if UPPER(DayName(Date(ldt_s))) = "SUNDAY" and ll_cancel < 1 then
	//MessageBox("Schedule", "No shift on sunday")
	
	ll_s = secondsafter(Time(ldt_s), 16:27:00)
	ll_e = secondsafter(15:58:59,Time(ldt_e))
	if ll_s > 0 and ll_e > 0 then
		MessageBox("Warning", "No shift on sunday between 15:59 and 16:27")
		return -7
	end if
end if

IF f_hoursafter(DateTime(Today(), Now()), ldt_e) < 0  THEN
	MessageBox("Warning", "Invalid ending time - please specify a future time.")
	RETURN -8
END IF
	
//next shift
li_shift = dw_schedule.GetItemNumber(li_rc, "shift_schedule_schedule_type", Primary!, FALSE)
IF li_shift < 3 THEN
	li_shift = li_shift + 1
	ld_end = istr_q.prod_date
ELSE
	li_shift = 1
	ld_end = Date(ldt_e)
END IF

	SetNULL(ldt_next_s)
	SetNULL(li_next_cancel)
	SELECT Shift_starting_time, shift_cancelled
	INTO :ldt_next_s, :li_next_cancel
	FROM Shift_schedule
	WHERE (Shift_schedule_date =:ld_end) AND (line_num = :istr_q.line_id) and (schedule_type = :li_shift) 
	USING SQLCA;
	IF isNULL(li_next_cancel) THEN	//default value
		CHOOSE CASE UPPER(DayName(ld_end))
			CASE "MONDAY"
				SELECT mon_start, mon_cancel 
				INTO :ldt_next_s, :li_next_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "TUESDAY"
				SELECT tue_start, tue_cancel 
				INTO :ldt_next_s, :li_next_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "WEDNESDAY"
				SELECT wed_start, wed_cancel 
				INTO :ldt_next_s, :li_next_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "THURSDAY"
				SELECT thu_start, thu_cancel 
				INTO :ldt_next_s, :li_next_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "FRIDAY"
				SELECT fri_start, fri_cancel 
				INTO :ldt_next_s, :li_next_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "SATURDAY"
				SELECT sat_start, sat_cancel 
				INTO :ldt_next_s, :li_next_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "SUNDAY"
				SELECT sun_start, sun_cancel 
				INTO :ldt_next_s, :li_next_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
		END CHOOSE
		IF isNULL(li_next_cancel) OR (li_next_cancel = 0) THEN
			IF SecondsAfter(Time(ldt_e),Time(ldt_next_s)) <= 0 THEN
				MessageBox("Warning", "Invalid date: ending time overlaps next shift's starting time.")
				RETURN -4
			END IF				
		END IF
	END IF
	IF li_next_cancel = 0 THEN  //not cancelled
		IF SecondsAfter(Time(ldt_e),Time(ldt_next_s)) <= 0 THEN
			MessageBox("Warning", "Invalid date: ending time overlaps next shift's starting time.")
			RETURN -5
		END IF						
	END IF

//previous shift
li_shift = dw_schedule.GetItemNumber(li_rc, "shift_schedule_schedule_type", Primary!, FALSE)
IF li_shift > 1 THEN
	li_shift = li_shift - 1
	ld_start = istr_q.prod_date
ELSE
	li_shift = 3
	ld_start = RelativeDate(Date(ldt_s), -1)
END IF

	SetNULL(ldt_pre_e)
	SetNULL(li_pre_cancel)
	SELECT Shift_ending_time, shift_cancelled
	INTO :ldt_pre_e, :li_pre_cancel
	FROM Shift_schedule
	WHERE (Shift_schedule_date =:ld_start) AND (line_num = :istr_q.line_id) and (schedule_type = :li_shift) 
	USING SQLCA;
	IF isNULL(li_pre_cancel) THEN	//default value
		CHOOSE CASE UPPER(DayName(ld_start))
			CASE "MONDAY"
				SELECT mon_end, mon_cancel 
				INTO :ldt_pre_e, :li_pre_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "TUESDAY"
				SELECT tue_end, tue_cancel 
				INTO :ldt_pre_e, :li_pre_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "WEDNESDAY"
				SELECT wed_end, wed_cancel 
				INTO :ldt_pre_e, :li_pre_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "THURSDAY"
				SELECT thu_end, thu_cancel 
				INTO :ldt_pre_e, :li_pre_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "FRIDAY"
				SELECT fri_end, fri_cancel 
				INTO :ldt_pre_e, :li_pre_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "SATURDAY"
				SELECT sat_end, sat_cancel 
				INTO :ldt_pre_e, :li_pre_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
			CASE "SUNDAY"
				SELECT sun_end, sun_cancel 
				INTO :ldt_pre_e, :li_pre_cancel
				FROM line_default_schedule
				WHERE (line_num = :istr_q.line_id) and (schedule_type = :li_shift)
				USING SQLCA;
		END CHOOSE
		IF isNULL(li_pre_cancel) OR (li_pre_cancel = 0) THEN
			IF SecondsAfter(Time(ldt_pre_e),Time(ldt_s)) <= 0 THEN
				MessageBox("Warning", "Invalid date: starting time overlaps previous shift's ending time.")
				RETURN -9
			END IF				
		END IF
	END IF
	IF li_pre_cancel = 0 THEN  //not cancelled
		IF SecondsAfter(Time(ldt_pre_e),Time(ldt_s)) <= 0 THEN
			MessageBox("Warning", "Invalid date: starting time overlaps previous shift's ending time.")
			RETURN -10
		END IF						
	END IF

li_rc = dw_schedule.Update()
IF li_rc = 1 THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox("Error", "Error saving shift info.")
	ROLLBACK USING SQLCA;
	RETURN -11
END IF

CloseWithReturn(Parent, 1)
RETURN 1

end event

type cb_cancel from u_cb within w_daily_prod_new_schedule
string tag = "Close without printing"
integer x = 709
integer y = 458
integer width = 351
integer height = 93
integer taborder = 20
integer textsize = -11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;dw_schedule.ResetUpdate()
CloseWithReturn(Parent, 0)
RETURN 0

end event

