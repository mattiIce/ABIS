$PBExportHeader$w_daily_production_modify_schedule.srw
$PBExportComments$<popup>Change daily production's shift schedule based line and shift
forward
global type w_daily_production_modify_schedule from w_sheet
end type
type cb_close from u_cb within w_daily_production_modify_schedule
end type
type cb_modify from u_cb within w_daily_production_modify_schedule
end type
type gb_title from groupbox within w_daily_production_modify_schedule
end type
type st_1 from statictext within w_daily_production_modify_schedule
end type
type tv_line from u_tvs within w_daily_production_modify_schedule
end type
type dw_schedule from u_dw within w_daily_production_modify_schedule
end type
type st_default from statictext within w_daily_production_modify_schedule
end type
type dw_shift from u_dw within w_daily_production_modify_schedule
end type
end forward

global type w_daily_production_modify_schedule from w_sheet
int X=461
int Y=259
int Width=2341
int Height=1034
WindowType WindowType=response!
boolean TitleBar=true
string Title="Modify shifts info - date"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event type integer ue_dw_info_refresh ( )
event type integer ue_show_shift_schedule ( )
event type integer ue_show_daily_schedule ( )
cb_close cb_close
cb_modify cb_modify
gb_title gb_title
st_1 st_1
tv_line tv_line
dw_schedule dw_schedule
st_default st_default
dw_shift dw_shift
end type
global w_daily_production_modify_schedule w_daily_production_modify_schedule

type variables
Long il_shift_id
Int ii_refresh_flag =0   //1: can trigger "refresh_treeview"
String is_date, is_line
Date id_date
Int ii_line, ii_schedule_type, ii_modified
Int ii_data  //0 - line 1 -shift
end variables

forward prototypes
public function integer f_verify_shift_datetime ()
end prototypes

event ue_dw_info_refresh;dw_schedule.Reset()

RETURN 1
end event

event ue_show_shift_schedule;Int li_row, li_c
DateTime ldt_s, ldt_e

dw_schedule.Visible = FALSE
dw_shift.Visible = TRUE
li_row = dw_shift.Retrieve(id_date, ii_line, ii_schedule_type)

IF li_row > 0 THEN
	st_default.Text = ""
ELSE
	st_default.Text = "- Defaulted schedule"
	li_row = dw_shift.InsertRow(0)
	IF li_row > 0 THEN
	
		CHOOSE CASE UPPER(DayName(id_date))
			CASE "MONDAY"
				SELECT mon_start, mon_end, mon_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = :ii_schedule_type)
				USING SQLCA;
			CASE "TUESDAY"
				SELECT tue_start, tue_end, tue_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = :ii_schedule_type)
				USING SQLCA;
			CASE "WEDNESDAY"
				SELECT wed_start, wed_end, wed_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = :ii_schedule_type)
				USING SQLCA;
			CASE "THURSDAY"
				SELECT thu_start, thu_end, thu_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = :ii_schedule_type)
				USING SQLCA;
			CASE "FRIDAY"
				SELECT fri_start, fri_end, fri_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = :ii_schedule_type)
				USING SQLCA;
			CASE "SATURDAY"
				SELECT sat_start, sat_end, sat_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = :ii_schedule_type)
				USING SQLCA;
			CASE "SUNDAY"
				SELECT sun_start, sun_end, sun_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = :ii_schedule_type)
				USING SQLCA;
		END CHOOSE	
		dw_shift.SetItem(li_row, "shift_schedule_shift_schedule_date", id_date)
		dw_shift.SetItem(li_row, "shift_schedule_line_num", ii_line)
		dw_shift.SetItem(li_row, "shift_schedule_schedule_type", ii_schedule_type)
		dw_shift.SetItem(li_row, "shift_schedule_shift_cancelled", li_c)
		dw_shift.SetItem(li_row, "shift_schedule_shift_starting_time", DateTime(id_date, Time(ldt_s)))
		IF ii_schedule_type = 3 THEN
			dw_shift.SetItem(li_row, "shift_schedule_shift_ending_time", DateTime(Relativedate(id_date,1), Time(ldt_e)))
		ELSE
			dw_shift.SetItem(li_row, "shift_schedule_shift_ending_time", DateTime(id_date, Time(ldt_e)))
		END IF
		dw_shift.ResetUpdate()
	END IF
END IF

RETURN 1

end event

event ue_show_daily_schedule;dw_schedule.Visible = TRUE
dw_shift.Visible = FALSE
st_default.Text = ""
dw_schedule.Reset()

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
	ll_line = lds_default.GetItemNumber(li_j, "line_num")
	ll_shift = lds_default.GetItemNumber(li_j, "schedule_type")
	ls_line = lds_default.GetItemString(li_j, "line_line_desc")
	IF ll_line = ii_line THEN
		ll_row = dw_schedule.InsertRow(0)
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
	

		ldt_def_s = lds_default.GetItemDateTime(li_j, ls_wd_s)
		ldt_def_e = lds_default.GetItemDateTime(li_j, ls_wd_e)
		li_def_c = lds_default.GetItemNumber(li_j, ls_wd_c)
	
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
	END IF
NEXT

DESTROY lds_default
dw_schedule.ResetUpdate()

RETURN 1
end event

public function integer f_verify_shift_datetime ();//Int li_rc, li_pre_cancel, li_next_cancel, li_shift
//Date ld_start, ld_end
//DateTime ldt_s, ldt_e, ldt_next_s, ldt_pre_e
//
//dw_shift_schedule.AcceptText()
//li_rc = dw_shift_schedule.Getrow()
//IF li_rc <= 0 THEN
//	MessageBox("Warning", "Invalid data. Please try again.")
//	RETURN -2
//END IF		
//ldt_s = dw_shift_schedule.GetItemDateTime(li_rc, "shift_schedule_shift_starting_time", Primary!, FALSE)
//ldt_e = dw_shift_schedule.GetItemDateTime(li_rc, "shift_schedule_shift_ending_time", Primary!, FALSE)
//IF ldt_s >= ldt_e THEN
//	MessageBox("Warning", "Invalid date: ending time before starting time.")
//	RETURN -3
//END IF
//IF Date(ldt_s) <> id_date THEN
//	MessageBox("Warning", "Invalid starting date")
//	RETURN -6
//END IF
//IF f_hoursafter(ldt_s, ldt_e) > 12 THEN
//	MessageBox("Warning", "Shift lasts more than 12 hours")
//	RETURN -7
//END IF
//IF f_hoursafter(DateTime(Today(), Now()), ldt_e) < 0  THEN
//	MessageBox("Warning", "Invalid ending time - please specify a future time.")
//	RETURN -8
//END IF
//	
////next shift
//li_shift = dw_shift_schedule.GetItemNumber(li_rc, "shift_schedule_schedule_type", Primary!, FALSE)
//IF li_shift < 3 THEN
//	li_shift = li_shift + 1
//	ld_end = id_date
//ELSE
//	li_shift = 1
//	ld_end = Date(ldt_e)
//END IF
//
//	SetNULL(ldt_next_s)
//	SetNULL(li_next_cancel)
//	SELECT Shift_starting_time, shift_cancelled
//	INTO :ldt_next_s, :li_next_cancel
//	FROM Shift_schedule
//	WHERE (Shift_schedule_date =:ld_end) AND (line_num = :ii_line) and (schedule_type = :li_shift) 
//	USING SQLCA;
//	IF isNULL(li_next_cancel) THEN	//default value
//		CHOOSE CASE UPPER(DayName(ld_end))
//			CASE "MONDAY"
//				SELECT mon_start, mon_cancel 
//				INTO :ldt_next_s, :li_next_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "TUESDAY"
//				SELECT tue_start, tue_cancel 
//				INTO :ldt_next_s, :li_next_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "WEDNESDAY"
//				SELECT wed_start, wed_cancel 
//				INTO :ldt_next_s, :li_next_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "THURSDAY"
//				SELECT thu_start, thu_cancel 
//				INTO :ldt_next_s, :li_next_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "FRIDAY"
//				SELECT fri_start, fri_cancel 
//				INTO :ldt_next_s, :li_next_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "SATURDAY"
//				SELECT sat_start, sat_cancel 
//				INTO :ldt_next_s, :li_next_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "SUNDAY"
//				SELECT sun_start, sun_cancel 
//				INTO :ldt_next_s, :li_next_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//		END CHOOSE
//		IF isNULL(li_next_cancel) OR (li_next_cancel = 0) THEN
//			IF SecondsAfter(Time(ldt_e),Time(ldt_next_s)) < 0 THEN
//				MessageBox("Warning", "Invalid date: ending time overlaps next shift's starting time.")
//				RETURN -4
//			END IF				
//		END IF
//	END IF
//	IF li_next_cancel = 0 THEN  //not cancelled
//		IF SecondsAfter(Time(ldt_e),Time(ldt_next_s)) < 0 THEN
//			MessageBox("Warning", "Invalid date: ending time overlaps next shift's starting time.")
//			RETURN -5
//		END IF						
//	END IF
//
////previous shift
//li_shift = dw_shift_schedule.GetItemNumber(li_rc, "shift_schedule_schedule_type", Primary!, FALSE)
//IF li_shift > 1 THEN
//	li_shift = li_shift - 1
//	ld_start = id_date
//ELSE
//	li_shift = 3
//	ld_start = RelativeDate(Date(ldt_s), -1)
//END IF
//
//	SetNULL(ldt_pre_e)
//	SetNULL(li_pre_cancel)
//	SELECT Shift_ending_time, shift_cancelled
//	INTO :ldt_pre_e, :li_pre_cancel
//	FROM Shift_schedule
//	WHERE (Shift_schedule_date =:ld_start) AND (line_num = :ii_line) and (schedule_type = :li_shift) 
//	USING SQLCA;
//	IF isNULL(li_pre_cancel) THEN	//default value
//		CHOOSE CASE UPPER(DayName(ld_start))
//			CASE "MONDAY"
//				SELECT mon_end, mon_cancel 
//				INTO :ldt_pre_e, :li_pre_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "TUESDAY"
//				SELECT tue_end, tue_cancel 
//				INTO :ldt_pre_e, :li_pre_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "WEDNESDAY"
//				SELECT wed_end, wed_cancel 
//				INTO :ldt_pre_e, :li_pre_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "THURSDAY"
//				SELECT thu_end, thu_cancel 
//				INTO :ldt_pre_e, :li_pre_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "FRIDAY"
//				SELECT fri_end, fri_cancel 
//				INTO :ldt_pre_e, :li_pre_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "SATURDAY"
//				SELECT sat_end, sat_cancel 
//				INTO :ldt_pre_e, :li_pre_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//			CASE "SUNDAY"
//				SELECT sun_end, sun_cancel 
//				INTO :ldt_pre_e, :li_pre_cancel
//				FROM line_default_schedule
//				WHERE (line_num = :ii_line) and (schedule_type = :li_shift)
//				USING SQLCA;
//		END CHOOSE
//		IF isNULL(li_pre_cancel) OR (li_pre_cancel = 0) THEN
//			IF SecondsAfter(Time(ldt_pre_e),Time(ldt_s)) < 0 THEN
//				MessageBox("Warning", "Invalid date: starting time overlaps previous shift's ending time.")
//				RETURN -9
//			END IF				
//		END IF
//	END IF
//	IF li_pre_cancel = 0 THEN  //not cancelled
//		IF SecondsAfter(Time(ldt_pre_e),Time(ldt_s)) < 0 THEN
//			MessageBox("Warning", "Invalid date: starting time overlaps previous shift's ending time.")
//			RETURN -10
//		END IF						
//	END IF
//
RETURN 1
end function

on w_daily_production_modify_schedule.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_modify=create cb_modify
this.gb_title=create gb_title
this.st_1=create st_1
this.tv_line=create tv_line
this.dw_schedule=create dw_schedule
this.st_default=create st_default
this.dw_shift=create dw_shift
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_modify
this.Control[iCurrent+3]=this.gb_title
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.tv_line
this.Control[iCurrent+6]=this.dw_schedule
this.Control[iCurrent+7]=this.st_default
this.Control[iCurrent+8]=this.dw_shift
end on

on w_daily_production_modify_schedule.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_modify)
destroy(this.gb_title)
destroy(this.st_1)
destroy(this.tv_line)
destroy(this.dw_schedule)
destroy(this.st_default)
destroy(this.dw_shift)
end on

event open;call super::open;Date ld_today

is_date = Message.StringParm
id_date = Date(is_date)

ii_refresh_flag = 1
st_1.Text = "Date: " + is_date
This.Title = "Modify shifts info - " + is_date
ii_modified = -1


RETURN 1








end event

event closequery;call super::closequery;ii_refresh_flag = 0 //prevent trigger date_changed
end event

type cb_close from u_cb within w_daily_production_modify_schedule
int X=1730
int Y=720
int Height=141
int TabOrder=50
boolean BringToTop=true
string Text="&Close"
int TextSize=-12
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;dw_schedule.ResetUpdate()
ClosewithReturn(parent, ii_modified)
end event

type cb_modify from u_cb within w_daily_production_modify_schedule
int X=1035
int Y=720
int Width=358
int Height=141
int TabOrder=40
string Tag="modify shift info"
boolean BringToTop=true
string Text="C&hange"
int TextSize=-12
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;s_new_daily_prod_info lstr_q
Int li_temp, li_autodata

IF Today() > Date(is_Date) THEN
	MessageBox("Warning", "You may only schedule future shifts.")
	RETURN -2
END IF


CHOOSE  CASE ii_data
	CASE 0 //line
		IF il_shift_id > 0 THEN
			MessageBox("Warning", "Shift information already exists in database. Please use <Modify> to make changes.")
			RETURN -1
		END IF

		lstr_q.line_id = ii_line
		lstr_q.line_desc = is_line
		lstr_q.prod_date = Date(is_date)
		lstr_q.schedule_type = ii_schedule_type
		lstr_q.Cancel = TRUE

		OpenwithParm(w_daily_prod_new_schedule_one_day, lstr_q)
		li_temp = Message.DoubleParm

		IF li_temp > 0 THEN
			Parent.Event ue_show_daily_schedule()
			ii_modified = 1
		END IF
		
		
	CASE 1 //shift
	

		lstr_q.line_id = ii_line
		lstr_q.line_desc = is_line
		lstr_q.prod_date = Date(is_date)
		lstr_q.schedule_type = ii_schedule_type
		lstr_q.Cancel = TRUE

		OpenwithParm(w_daily_prod_new_schedule, lstr_q)
		li_temp = Message.DoubleParm

		IF li_temp > 0 THEN
			Parent.Event ue_show_shift_schedule()
			ii_modified = 1
		END IF
END CHOOSE

RETURN 1

end event

type gb_title from groupbox within w_daily_production_modify_schedule
int X=746
int Y=16
int Width=1547
int Height=637
int TabOrder=60
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

type st_1 from statictext within w_daily_production_modify_schedule
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

type tv_line from u_tvs within w_daily_production_modify_schedule
int X=29
int Y=134
int Width=691
int Height=746
int TabOrder=30
boolean BringToTop=true
string PictureName[]={"UnionReturn!",&
"Cascade!",&
"Custom015!",&
"Custom072!"}
long BackColor=1090519039
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"line_line_desc", "", "d_line_schedule_line_info", SQLCA, "")
this.inv_levelsource.of_Register(2, "display",  &
  ":parent.1.line_schedule_line_num", "d_line_schedule_shift_info", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")

this.event pfc_Populate(0)

end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

event selectionchanged;Long ll_current, ll_return, ll_row, ll_row_parent, ll_parent
TreeViewItem ltvi_item
n_ds lds_datastore, lds_temp
Date ld_d
DateTime ldt_s, ldt_e

//reset dw
dw_schedule.Reset()

// Get the DataStore and row for the new item
IF inv_levelsource.of_GetDataRow(newhandle, lds_datastore, ll_row) = -1 THEN
	MessageBox("Error", "Error in of_GetDataRow", Exclamation!)
	RETURN -1
END IF

ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)

if ltvi_item.level =1 then
 	ii_line = lds_datastore.GetItemNumber(ll_row,"line_schedule_line_num")
 	is_line = lds_datastore.GetItemString(ll_row,"line_line_desc")
	ii_schedule_type = 0
	ii_data = 0 //line
	Parent.Event ue_show_daily_schedule()
else
 	ii_schedule_type = lds_datastore.GetItemNumber(ll_row,"schedule_type")
	 
	ll_parent = this.FindItem(ParentTreeItem!, ll_current)
	IF inv_levelsource.of_GetDataRow(ll_parent, lds_temp, ll_row_parent) = -1 THEN
		MessageBox("Error", "Error in of_GetDataRow", Exclamation!)
		RETURN -2
	END IF
 	ii_line = lds_temp.GetItemNumber(ll_row_parent,"line_schedule_line_num")
 	is_line = lds_temp.GetItemString(ll_row_parent,"line_line_desc")
	ii_data = 1 //shift
	ld_d = Date(is_date)

	Parent.Event ue_show_shift_schedule()
end if
RETURN 1


end event

event clicked;Triggerevent ("sectionchanged")
end event

event rightclicked;//override
RETURN 1
end event

type dw_schedule from u_dw within w_daily_production_modify_schedule
int X=761
int Y=102
int Width=1514
int Height=451
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string DataObject="d_daily_prod_daily_shift_list"
boolean VScrollBar=false
end type

event constructor;This.SetTransObject(sqlca)

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

type st_default from statictext within w_daily_production_modify_schedule
int X=1744
int Y=570
int Width=468
int Height=70
boolean Enabled=false
boolean BringToTop=true
string Text="- Defaulted schedule"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_shift from u_dw within w_daily_production_modify_schedule
int X=892
int Y=90
int Width=1203
int Height=458
int TabOrder=10
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string DataObject="d_daily_prod_shift_schedule_list"
boolean VScrollBar=false
end type

event constructor;this.SetTransObject(SQLCA)
end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

