$PBExportHeader$w_daily_production.srw
$PBExportComments$<Sheet>Daily production coil and volume info
forward
global type w_daily_production from w_sheet
end type
type dw_abjob_details from u_dw within w_daily_production
end type
type dw_shift from u_dw within w_daily_production
end type
type em_calendar from u_em within w_daily_production
end type
type uo_calendar_1 from u_calendar within w_daily_production
end type
type tab_prod_details from tab within w_daily_production
end type
type tabpage_downtimesummary from userobject within tab_prod_details
end type
type dw_dts from u_dw within tabpage_downtimesummary
end type
type dw_dts_gr from u_dw within tabpage_downtimesummary
end type
type tabpage_downtime from userobject within tab_prod_details
end type
type dw_dt from u_dw within tabpage_downtime
end type
type tabpage_details from userobject within tab_prod_details
end type
type dw_production_info from u_dw within tabpage_details
end type
type tabpage_avg from userobject within tab_prod_details
end type
type gr_avg from u_gr within tabpage_avg
end type
type st_2 from statictext within tabpage_avg
end type
type st_3 from statictext within tabpage_avg
end type
type st_4 from statictext within tabpage_avg
end type
type st_5 from statictext within tabpage_avg
end type
type st_lbs from statictext within tabpage_avg
end type
type st_hrs from statictext within tabpage_avg
end type
type st_avg from statictext within tabpage_avg
end type
type st_goal from statictext within tabpage_avg
end type
type tabpage_spm from userobject within tab_prod_details
end type
type gr_spm from graph within tabpage_spm
end type
type tabpage_comment from userobject within tab_prod_details
end type
type mle_shift_comments from u_mle within tabpage_comment
end type
type cb_close from u_cb within w_daily_production
end type
type cb_report from u_cb within w_daily_production
end type
type cb_modify from u_cb within w_daily_production
end type
type gb_2 from groupbox within w_daily_production
end type
type gb_1 from groupbox within w_daily_production
end type
type dw_abjob_list from u_dw within w_daily_production
end type
type st_1 from statictext within w_daily_production
end type
type tv_line from u_tvs within w_daily_production
end type
type cb_new from u_cb within w_daily_production
end type
type dw_schedule from u_dw within w_daily_production
end type
type cb_print from u_cb within w_daily_production
end type
type tabpage_downtimesummary from userobject within tab_prod_details
dw_dts dw_dts
dw_dts_gr dw_dts_gr
end type
type tabpage_downtime from userobject within tab_prod_details
dw_dt dw_dt
end type
type tabpage_details from userobject within tab_prod_details
dw_production_info dw_production_info
end type
type tabpage_avg from userobject within tab_prod_details
gr_avg gr_avg
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_lbs st_lbs
st_hrs st_hrs
st_avg st_avg
st_goal st_goal
end type
type tabpage_spm from userobject within tab_prod_details
gr_spm gr_spm
end type
type tabpage_comment from userobject within tab_prod_details
mle_shift_comments mle_shift_comments
end type
type tab_prod_details from tab within w_daily_production
tabpage_downtimesummary tabpage_downtimesummary
tabpage_downtime tabpage_downtime
tabpage_details tabpage_details
tabpage_avg tabpage_avg
tabpage_spm tabpage_spm
tabpage_comment tabpage_comment
end type
end forward

global type w_daily_production from w_sheet
int X=113
int Y=128
int Width=3240
int Height=2070
WindowType WindowType=response!
boolean TitleBar=true
string Title="Daily Production - Shift Schedule/Shift Summary"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event type string ue_whoami ( )
event type integer ue_date_changed ( )
event type integer ue_dw_info_refresh ( )
event type integer ue_new_shift_info ( )
dw_abjob_details dw_abjob_details
dw_shift dw_shift
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
tab_prod_details tab_prod_details
cb_close cb_close
cb_report cb_report
cb_modify cb_modify
gb_2 gb_2
gb_1 gb_1
dw_abjob_list dw_abjob_list
st_1 st_1
tv_line tv_line
cb_new cb_new
dw_schedule dw_schedule
cb_print cb_print
end type
global w_daily_production w_daily_production

type variables
Long il_shift_id, il_job
Int ii_refresh_flag =0   //1: can trigger "refresh_treeview"
String is_date, is_line
Int ii_line, ii_schedule_type
end variables

forward prototypes
public function real wf_efficiency (long al_shift)
end prototypes

event ue_whoami;return "w_daily_production"
end event

event ue_date_changed;Date ld_day, ld_d
Integer li_rc, li_i, li_shiftcount, li_line
DateTime ldt_s, ldt_e

//delete current view

dw_shift.Reset()
dw_abjob_list.Reset()
dw_abjob_details.Reset()
dw_schedule.Reset()
tab_prod_details.tabpage_details.dw_production_info.Reset()
tab_prod_details.tabpage_downtime.dw_dt.Reset()
tab_prod_details.tabpage_downtimesummary.dw_dts.Reset()
tab_prod_details.tabpage_downtimesummary.dw_dts_gr.Reset()
tab_prod_details.tabpage_spm.gr_spm.Reset(ALL!)


//create new tree
ld_day = Date(em_calendar.Text)
is_date = em_calendar.Text
ii_refresh_flag = 1
st_1.Text = "Date: " + is_date

//refresh data
	il_shift_id = 0
	ld_d = Date(is_date)
 	SELECT shift_num, start_time, end_time INTO :il_shift_id, :ldt_s, :ldt_e
	FROM SHIFT
	WHERE Line_num = :ii_line AND schedule_type = :ii_schedule_type AND To_Date(start_Time) = :ld_d
	USING SQLCA;
	IF il_shift_id > 0 THEN
		IF IsNULL(ldt_s) OR isNULL(ldt_e) THEN
			MessageBox("Warning", "Invalid Date Info: Starting/Ending time is NULL.")
			il_shift_id = 0
			RETURN -1
		ELSE
			cb_new.Enabled = FALSE
			cb_print.Enabled = TRUE
			this.Event ue_dw_info_refresh()
		END IF
	ELSE
		IF ii_schedule_type > 0 THEN this.Event ue_new_shift_info()
		cb_new.Enabled = TRUE
		cb_print.Enabled = FALSE
		dw_schedule.Event ue_Retrieve()
	END IF	

RETURN 1


end event

event ue_dw_info_refresh;String ls_s
//reset dw
dw_shift.Reset()
dw_abjob_list.Reset()
dw_abjob_details.Reset()
dw_schedule.Reset()
tab_prod_details.tabpage_details.dw_production_info.Reset()
tab_prod_details.tabpage_downtime.dw_dt.Reset()
tab_prod_details.tabpage_downtimesummary.dw_dts.Reset()
tab_prod_details.tabpage_downtimesummary.dw_dts_gr.Reset()
tab_prod_details.tabpage_spm.gr_spm.Reset(ALL!)
tab_prod_details.tabpage_comment.mle_shift_comments.Text = ""
tab_prod_details.tabpage_avg.gr_avg.Reset(ALL!)
tab_prod_details.tabpage_avg.st_lbs.Text = ""
tab_prod_details.tabpage_avg.st_hrs.Text = ""
tab_prod_details.tabpage_avg.st_avg.Text = ""
tab_prod_details.tabpage_avg.st_goal.Text = ""

//retrieve
dw_shift.Retrieve(il_shift_id, wf_efficiency(il_shift_id))
dw_abjob_list.Retrieve(il_shift_id)
IF dw_abjob_list.Rowcount() > 0 THEN
	dw_abjob_details.Retrieve(dw_abjob_list.GetItemNumber(1, "ab_job_num"))
END IF
tab_prod_details.tabpage_details.dw_production_info.Retrieve(il_shift_id)
SELECT note INTO :ls_s
FROM SHIFT
WHERE SHIFT_NUM = :il_shift_id
USING SQLCA;
tab_prod_details.tabpage_downtimesummary.dw_dts.Retrieve(il_shift_id)
tab_prod_details.tabpage_downtimesummary.dw_dts_gr.Retrieve(il_shift_id)
tab_prod_details.tabpage_comment.mle_shift_comments.Text = ls_s
tab_prod_details.tabpage_downtime.dw_dt.Retrieve(il_shift_id)
tab_prod_details.tabpage_spm.Event ue_draw_spm(il_shift_id)
tab_prod_details.tabpage_avg.Event ue_show_data(il_shift_id)
dw_schedule.Event ue_Retrieve()
RETURN 1
end event

event ue_new_shift_info;//s_new_daily_prod_info lstr_q

//reset dw
dw_shift.Reset()
dw_abjob_list.Reset()
dw_abjob_details.Reset()
dw_schedule.Reset()
tab_prod_details.tabpage_details.dw_production_info.Reset()
tab_prod_details.tabpage_downtime.dw_dt.Reset()
tab_prod_details.tabpage_downtimesummary.dw_dts.Reset()
tab_prod_details.tabpage_downtimesummary.dw_dts_gr.Reset()
tab_prod_details.tabpage_spm.gr_spm.Reset(ALL!)
tab_prod_details.tabpage_comment.mle_shift_comments.Text = ""
tab_prod_details.tabpage_avg.gr_avg.Reset(ALL!)
tab_prod_details.tabpage_avg.st_lbs.Text = ""
tab_prod_details.tabpage_avg.st_hrs.Text = ""
tab_prod_details.tabpage_avg.st_avg.Text = ""
tab_prod_details.tabpage_avg.st_goal.Text = ""

//IF messagebox("New Shift Info", "Do you want to input shift information based on line " + is_line + "?",&
//             Question!, OkCancel!,1)<>1 then
//  		 Return 0
//ELSE
//	lstr_q.line_id = ii_line
//	lstr_q.line_desc = is_line
//	lstr_q.prod_date = Date(is_date)
//	lstr_q.schedule_type = ii_schedule_type
//	lstr_q.Cancel = TRUE
//
//	OpenwithParm(w_shift_info_new, lstr_q)
//	il_shift_id = Message.LongParm
//
//	IF il_shift_id > 0 THEN
//		this.Event ue_dw_info_refresh()
//	END IF
//END IF
RETURN 1

end event

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

on w_daily_production.create
int iCurrent
call super::create
this.dw_abjob_details=create dw_abjob_details
this.dw_shift=create dw_shift
this.em_calendar=create em_calendar
this.uo_calendar_1=create uo_calendar_1
this.tab_prod_details=create tab_prod_details
this.cb_close=create cb_close
this.cb_report=create cb_report
this.cb_modify=create cb_modify
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_abjob_list=create dw_abjob_list
this.st_1=create st_1
this.tv_line=create tv_line
this.cb_new=create cb_new
this.dw_schedule=create dw_schedule
this.cb_print=create cb_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_abjob_details
this.Control[iCurrent+2]=this.dw_shift
this.Control[iCurrent+3]=this.em_calendar
this.Control[iCurrent+4]=this.uo_calendar_1
this.Control[iCurrent+5]=this.tab_prod_details
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_report
this.Control[iCurrent+8]=this.cb_modify
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_abjob_list
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.tv_line
this.Control[iCurrent+14]=this.cb_new
this.Control[iCurrent+15]=this.dw_schedule
this.Control[iCurrent+16]=this.cb_print
end on

on w_daily_production.destroy
call super::destroy
destroy(this.dw_abjob_details)
destroy(this.dw_shift)
destroy(this.em_calendar)
destroy(this.uo_calendar_1)
destroy(this.tab_prod_details)
destroy(this.cb_close)
destroy(this.cb_report)
destroy(this.cb_modify)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_abjob_list)
destroy(this.st_1)
destroy(this.tv_line)
destroy(this.cb_new)
destroy(this.dw_schedule)
destroy(this.cb_print)
end on

event open;call super::open;Integer li_rc, li_i, li_shiftcount, li_line
Date ld_today


ld_today = Today()
em_calendar.Text =  String(ld_today, "mm/dd/yyyy")
ii_refresh_flag = 1
is_date = em_calendar.Text
st_1.Text = "Date: " + is_date







end event

event close;call super::close;f_display_app()
end event

event closequery;call super::closequery;ii_refresh_flag = 0 //prevent trigger date_changed
end event

type dw_abjob_details from u_dw within w_daily_production
int X=1075
int Y=413
int Width=1382
int Height=336
int TabOrder=130
string DataObject="d_daily_production_job_detail"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event rbuttondown;//override Ancestor script

end event

event rbuttonup;//override ancestor script
//read only
end event

event constructor;This.SetTransObject(sqlca)
//This.Retrieve(38940)
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	Return dddw_cni.Retrieve() 
END IF
end event

type dw_shift from u_dw within w_daily_production
int X=753
int Y=77
int Width=1686
int Height=147
int TabOrder=100
string DataObject="d_daily_prod_shift_info_display"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event rbuttondown;//override
end event

event rbuttonup;//override
end event

event constructor;This.SetTransObject(sqlca)

end event

type em_calendar from u_em within w_daily_production
int X=2692
int Y=1760
int Width=428
int TabOrder=150
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
	IF ii_refresh_flag = 1 THEN RETURN Parent.Event ue_date_changed()
ELSE
	RETURN 0
END IF
end event

type uo_calendar_1 from u_calendar within w_daily_production
int X=2487
int Y=64
int Width=706
int Height=659
int TabOrder=10
boolean BringToTop=true
long BackColor=80269524
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type tab_prod_details from tab within w_daily_production
int X=709
int Y=784
int Width=2472
int Height=1037
int TabOrder=140
boolean BringToTop=true
boolean PowerTips=true
boolean RaggedRight=true
boolean BoldSelectedText=true
Alignment Alignment=Center!
int SelectedTab=1
long BackColor=80269524
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_downtimesummary tabpage_downtimesummary
tabpage_downtime tabpage_downtime
tabpage_details tabpage_details
tabpage_avg tabpage_avg
tabpage_spm tabpage_spm
tabpage_comment tabpage_comment
end type

on tab_prod_details.create
this.tabpage_downtimesummary=create tabpage_downtimesummary
this.tabpage_downtime=create tabpage_downtime
this.tabpage_details=create tabpage_details
this.tabpage_avg=create tabpage_avg
this.tabpage_spm=create tabpage_spm
this.tabpage_comment=create tabpage_comment
this.Control[]={this.tabpage_downtimesummary,&
this.tabpage_downtime,&
this.tabpage_details,&
this.tabpage_avg,&
this.tabpage_spm,&
this.tabpage_comment}
end on

on tab_prod_details.destroy
destroy(this.tabpage_downtimesummary)
destroy(this.tabpage_downtime)
destroy(this.tabpage_details)
destroy(this.tabpage_avg)
destroy(this.tabpage_spm)
destroy(this.tabpage_comment)
end on

type tabpage_downtimesummary from userobject within tab_prod_details
int X=15
int Y=90
int Width=2443
int Height=934
long BackColor=12632256
string Text="Downtime Summary"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Custom073!"
dw_dts dw_dts
dw_dts_gr dw_dts_gr
end type

on tabpage_downtimesummary.create
this.dw_dts=create dw_dts
this.dw_dts_gr=create dw_dts_gr
this.Control[]={this.dw_dts,&
this.dw_dts_gr}
end on

on tabpage_downtimesummary.destroy
destroy(this.dw_dts)
destroy(this.dw_dts_gr)
end on

type dw_dts from u_dw within tabpage_downtimesummary
int X=0
int Y=0
int Width=1156
int Height=925
int TabOrder=11
boolean BringToTop=true
string DataObject="d_daily_prod_dt_summary_new"
end type

event constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 

This.SetTransObject(sqlca)


end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type dw_dts_gr from u_dw within tabpage_downtimesummary
int X=1156
int Y=0
int Width=1291
int Height=925
int TabOrder=11
boolean BringToTop=true
string DataObject="d_daily_prod_downtime_summary_per_shift"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(sqlca)

end event

event rbuttondown;//override
end event

event rbuttonup;//override
end event

type tabpage_downtime from userobject within tab_prod_details
int X=15
int Y=90
int Width=2443
int Height=934
long BackColor=12632256
string Text="Downtime Instances"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Having!"
dw_dt dw_dt
end type

on tabpage_downtime.create
this.dw_dt=create dw_dt
this.Control[]={this.dw_dt}
end on

on tabpage_downtime.destroy
destroy(this.dw_dt)
end on

type dw_dt from u_dw within tabpage_downtime
event type integer ue_delete_row ( )
int X=0
int Y=10
int Width=2439
int Height=912
int TabOrder=11
boolean BringToTop=true
string DataObject="d_daily_prod_dt_input"
boolean HScrollBar=true
end type

event ue_delete_row;//Long ll_row, ll_id, ll_i
//Int li_item
//
//this.AcceptText()
//ll_row = this.GetRow()
//IF ll_row > 0 THEN 
//	if messagebox("Delete", "About to delete this downtime instance.", Question!, OkCancel!,1)<>1 then
//  		 Return 0
//	else
//		ll_id = this.GetItemNumber(ll_row, "dt_instance_instance_num", Primary!, FALSE)
//		this.DeleteRow(ll_row)
//	end if
//ELSE
//	MessageBox("Warning", "No item specified")
//END IF
//
//ll_row = dw_dt_cause.Rowcount()
//FOR ll_i = ll_row TO 1 STEP -1
//	IF ll_id = dw_dt_cause.GetItemNumber(ll_i, "instance_num", Primary!, FALSE) THEN 
//		dw_dt_cause.DeleteRow(ll_i)
//	END IF
//NEXT

RETURN 1

end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	Return dddw_cni.Retrieve() 
END IF
end event

event pfc_addrow;call super::pfc_addrow;//long ll_new_id
//Long ll_row
//
//ll_new_id = f_get_next_value("dt_instance_seq")
//
//ll_row = GetRow()
//SetItem(ll_row,"dt_instance_instance_num", ll_new_id)
//SetItem(ll_row,"dt_instance_ab_job_num", il_job)
//SetItem(ll_row,"dt_instance_line_num", ii_line)
//SetItem(ll_row,"dt_instance_starting_time",Date(is_date) )
//SetItem(ll_row,"dt_instance_ending_time", Date(is_date) )
//SetItem(ll_row,"dt_instance_shift_num", il_shift_id)
//
//SetItem(ll_row,"dt_instance_detail_id", 23)
//
//this.Event GetFocus()
//
//ll_row = dw_dt_cause.InsertRow(0)
//dw_dt_cause.SetItem(ll_row, "instance_num", ll_new_id)
//dw_dt_cause.SetItem(ll_row, "instance_item", 1)
//
//Return ll_new_id
RETURN 1
end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

DataWindowChild ldddw_cni
IF this.GetChild("dt_instance_detail_id", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("dt_instance_detail_id", ldddw_cni)
END IF


end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type tabpage_details from userobject within tab_prod_details
int X=15
int Y=90
int Width=2443
int Height=934
long BackColor=12632256
string Text="Coils"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Paste!"
dw_production_info dw_production_info
end type

on tabpage_details.create
this.dw_production_info=create dw_production_info
this.Control[]={this.dw_production_info}
end on

on tabpage_details.destroy
destroy(this.dw_production_info)
end on

type dw_production_info from u_dw within tabpage_details
event type integer ue_process_wt ( )
int X=4
int Y=13
int Width=2439
int Height=909
int TabOrder=10
string DataObject="d_daily_prod_coil_info_display"
boolean LiveScroll=false
end type

event ue_process_wt;Int li_rc, li_i
Long ll_bw, ll_ew

this.AcceptText()
li_rc = this.RowCount()
IF li_rc > 0 THEN
	FOR li_i = 1 TO li_rc
		ll_bw = this.GetItemNumber(li_i, "coil_begin_wt", Primary!, FALSE) 
		ll_ew = this.GetItemNumber(li_i, "coil_end_wt", Primary!, FALSE)
		IF (ll_bw - ll_ew) < 0 THEN
			MessageBox("Warning", "Coil end weight is more than coil begin weight.")
			RETURN -1
		END IF
	NEXT
END IF
FOR li_i = 1 TO li_rc
	this.SetItem(li_i, "process_wt",(ll_bw - ll_ew))
NEXT
RETURN 1

end event

event constructor;//this.SetRowFocusIndicator(Hand!) 
this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.inv_sort.of_SetColumnHeader(TRUE)
this.inv_RowSelect.of_SetStyle ( 0 ) 

This.SetTransObject(sqlca)


end event

event rbuttondown;//override
end event

event rbuttonup;//override
end event

type tabpage_avg from userobject within tab_prod_details
event type integer ue_show_data ( long al_shift )
int X=15
int Y=90
int Width=2443
int Height=934
long BackColor=12632256
string Text="Avg. LBs"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="SetNextStatement!"
gr_avg gr_avg
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_lbs st_lbs
st_hrs st_hrs
st_avg st_avg
st_goal st_goal
end type

event ue_show_data;Long ll_alph, ll_wt
Int li_series
DateTime ldt_s, ldt_e
Real lr_hrs, lr_avg

SELECT avg_lb_per_hr INTO :ll_alph
FROM line
WHERE line_num = :ii_line
USING SQLCA;
st_goal.TEXT = String(ll_alph)

SELECT start_time, end_time INTO :ldt_s, :ldt_e
FROM SHIFT
WHERE shift_num = :al_shift
USING SQLCA;

lr_hrs = f_hoursafter(ldt_s, ldt_e)
IF lr_hrs <= 0 or IsNULL(lr_hrs) THEN
	MessageBox("Warning", "Invalid Date Info. Default = 8 hrs")
	lr_hrs = 8.0
END IF
IF lr_hrs >= 12.0 THEN
	MessageBox("Warning", "Long shift(more than 12 hours).")
END IF
st_hrs.Text = String(lr_hrs, "####.##")
		
SELECT SUM(process_wt) INTO :ll_wt
FROM SHIFT_COIL
WHERE Shift_num = :al_shift
USING SQLCA;
st_lbs.Text = String(ll_wt)

lr_avg = ll_wt/lr_hrs
st_avg.Text = String(lr_avg, "######")

li_series = tab_prod_details.tabpage_avg.gr_avg.AddSeries("This Shift")
tab_prod_details.tabpage_avg.gr_avg.AddCategory(is_date)
IF li_series <> -1 THEN tab_prod_details.tabpage_avg.gr_avg.AddData(li_series, lr_avg, is_date)

li_series = tab_prod_details.tabpage_avg.gr_avg.AddSeries("Goal")
tab_prod_details.tabpage_avg.gr_avg.AddCategory(is_date)
IF li_series <> -1 THEN tab_prod_details.tabpage_avg.gr_avg.AddData(li_series, ll_alph, is_date)

RETURN 1

end event

on tabpage_avg.create
this.gr_avg=create gr_avg
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_lbs=create st_lbs
this.st_hrs=create st_hrs
this.st_avg=create st_avg
this.st_goal=create st_goal
this.Control[]={this.gr_avg,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_5,&
this.st_lbs,&
this.st_hrs,&
this.st_avg,&
this.st_goal}
end on

on tabpage_avg.destroy
destroy(this.gr_avg)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_lbs)
destroy(this.st_hrs)
destroy(this.st_avg)
destroy(this.st_goal)
end on

type gr_avg from u_gr within tabpage_avg
int X=545
int Y=22
int Width=1861
int Height=886
boolean BringToTop=true
long BackColor=16777215
end type

on gr_avg.create
call super::create
TitleDispAttr.BackColor=553648127
Category.Label="Date"
Values.Label="Pounds"
Values.MajorGridLine=dot!
end on

type st_2 from statictext within tabpage_avg
int X=7
int Y=26
int Width=329
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Total Pounds:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_avg
int X=7
int Y=170
int Width=289
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Total Hours:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within tabpage_avg
int X=7
int Y=317
int Width=534
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Average LBs per Hour:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within tabpage_avg
int X=7
int Y=474
int Width=187
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Goal:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_lbs from statictext within tabpage_avg
int X=62
int Y=93
int Width=329
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_hrs from statictext within tabpage_avg
int X=62
int Y=240
int Width=329
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_avg from statictext within tabpage_avg
int X=62
int Y=387
int Width=329
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_goal from statictext within tabpage_avg
int X=66
int Y=538
int Width=329
int Height=77
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_spm from userobject within tab_prod_details
event type integer ue_draw_spm ( long al_shift )
int X=15
int Y=90
int Width=2443
int Height=934
long BackColor=12632256
string Text="SPM"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="InsertReturn!"
gr_spm gr_spm
end type

event ue_draw_spm;Int li_series, li_rc, li_i, li_line
Real lr_spm
String ls_time, ls_line
DateTime ldt_s, ldt_e
DataStore lds_data

SELECT line_num,start_time,end_time INTO :li_line, :ldt_s, :ldt_e
FROM SHIFT
WHERE shift_num = :al_shift
USING SQLCA;
IF (li_line <= 0) OR IsNULL(ldt_s) THEN RETURN -1
SELECT line_desc INTO :ls_line
FROM Line
WHERE line_num = :li_line
USING SQLCA;
gr_spm.Title = "SPM Report(" + ls_line + " from " + String(Time(ldt_s)) + " to " + String(Time(ldt_e)) + ")"

lds_data = CREATE datastore
lds_data.dataobject = "d_daily_prod_spm_pershift_dataonly"
lds_data.SetTransObject(SQLCA)
li_rc = lds_data.Retrieve(li_line, ldt_s, ldt_e)
IF li_rc < 1 THEN
	DESTROY lds_data
	RETURN -2
END IF

li_series = gr_spm.AddSeries("SPM")

ls_time = String(Time(ldt_s))
lr_spm = lds_data.GetItemNumber(1,"spm")
gr_spm.AddCategory(ls_time)
IF li_series <> -1 THEN gr_spm.AddData(li_series, lr_spm, ls_time)
FOR li_i = 1 to li_rc
	ls_time = String(Time(lds_data.GetItemDateTime(li_i, "datetime")))
	lr_spm = lds_data.GetItemNumber(li_i,"spm")
	IF li_i = 1 then gr_spm.AddCategory(ls_time)
	IF li_series <> -1 THEN gr_spm.AddData(li_series, lr_spm, ls_time)
	IF li_i < li_rc - 1 THEN
		//ls_time =String(RelativeTime(Time(lds_data.GetItemDateTime(li_i + 1, "datetime")), -1))
		ls_time =String(Time(lds_data.GetItemDateTime(li_i + 1, "datetime")))
		gr_spm.AddCategory(ls_time)
		IF li_series <> -1 THEN gr_spm.AddData(li_series, lr_spm, ls_time)
	END IF
NEXT
ls_time = String(Time(ldt_e))
lr_spm = lds_data.GetItemNumber(li_rc,"spm")
gr_spm.AddCategory(ls_time)
IF li_series <> -1 THEN gr_spm.AddData(li_series, lr_spm, ls_time)

DESTROY lds_data

RETURN 1
end event

on tabpage_spm.create
this.gr_spm=create gr_spm
this.Control[]={this.gr_spm}
end on

on tabpage_spm.destroy
destroy(this.gr_spm)
end on

type gr_spm from graph within tabpage_spm
int X=11
int Width=2406
int Height=928
boolean Enabled=false
boolean BringToTop=true
grLegendType Legend=AtBottom!
grSortType SeriesSort=Ascending!
grSortType CategorySort=Ascending!
string Title="SPM report"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
int Depth=100
int Elevation=20
boolean FocusRectangle=false
int Perspective=2
int Rotation=-20
int Spacing=100
long BackColor=16777215
long ShadeColor=6580330
end type

on gr_spm.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="Arial"
TitleDispAttr.FontCharSet=Ansi!
TitleDispAttr.FontFamily=Swiss!
TitleDispAttr.FontPitch=Variable!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=536870912
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
TitleDispAttr.AutoSize=true
Category.Label="Time"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="Arial"
Category.DispAttr.FontCharSet=Ansi!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="Arial"
Category.LabelDispAttr.FontCharSet=Ansi!
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=536870912
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="SPM"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Arial"
Values.DispAttr.FontCharSet=Ansi!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="Arial"
Values.LabelDispAttr.FontCharSet=Ansi!
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=536870912
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Arial"
Series.DispAttr.FontCharSet=Ansi!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Arial"
Series.LabelDispAttr.FontCharSet=Ansi!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=536870912
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="Arial"
LegendDispAttr.FontCharSet=Ansi!
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="Arial"
PieDispAttr.FontCharSet=Ansi!
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_spm.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

type tabpage_comment from userobject within tab_prod_details
int X=15
int Y=90
int Width=2443
int Height=934
long BackColor=12632256
string Text="Comments"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="DosEdit5!"
mle_shift_comments mle_shift_comments
end type

on tabpage_comment.create
this.mle_shift_comments=create mle_shift_comments
this.Control[]={this.mle_shift_comments}
end on

on tabpage_comment.destroy
destroy(this.mle_shift_comments)
end on

type mle_shift_comments from u_mle within tabpage_comment
int X=0
int Y=6
int Width=2432
int Height=912
int TabOrder=11
boolean BringToTop=true
boolean VScrollBar=true
string Text="This is comments about this shift and will be used in the report."
FontCharSet FontCharSet=Ansi!
end type

event rbuttondown;//override
end event

event rbuttonup;//override
end event

type cb_close from u_cb within w_daily_production
int X=2578
int Y=1837
int Width=322
int Height=106
int TabOrder=70
boolean BringToTop=true
string Text="&Close"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;close(parent)
end event

type cb_report from u_cb within w_daily_production
int X=2022
int Y=1837
int Width=322
int Height=106
int TabOrder=60
boolean BringToTop=true
string Text="&Reports"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;s_new_daily_prod_info lstr_q

lstr_q.line_id = ii_line
lstr_q.line_desc = is_line
lstr_q.prod_date = Date(is_date)
lstr_q.schedule_type = ii_schedule_type

OpenwithParm(w_daily_prod_reports, lstr_q)

RETURN 1

end event

type cb_modify from u_cb within w_daily_production
int X=340
int Y=1837
int Width=329
int Height=106
int TabOrder=30
boolean Enabled=false
string Tag="modify shift info"
boolean BringToTop=true
string Text="&Modify"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;s_new_daily_prod_info lstr_q
Int li_temp, li_autodata

IF il_shift_id <= 0 OR isNULL(il_shift_id) THEN
	MessageBox("Warning", "Shift information does NOT exist in database. Please use <New> to create data.")
	RETURN -1
END IF

SELECT auto_data_acquisition INTO :li_autodata
FROM Line
WHERE line_num = :ii_line
USING SQLCA;

IF li_autodata > 0 THEN
	MessageBox("Warning", "Shift information has been collected by auto data acquisition system. Please contact system administrator.")
	RETURN -1
END IF

lstr_q.line_id = ii_line
lstr_q.line_desc = is_line
lstr_q.prod_date = Date(is_date)
lstr_q.schedule_type = ii_schedule_type
lstr_q.Cancel = TRUE
lstr_q.shift_id = il_shift_id

OpenwithParm(w_daily_prod_shift_info_update, lstr_q)
li_temp = Message.DoubleParm

IF li_temp > 0 THEN Parent.Event ue_dw_info_refresh()

RETURN 1

end event

type gb_2 from groupbox within w_daily_production
int X=706
int Y=349
int Width=1766
int Height=422
int TabOrder=120
string Text="Production order for this shift"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_daily_production
int X=706
int Y=19
int Width=1763
int Height=317
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

type dw_abjob_list from u_dw within w_daily_production
int X=724
int Y=413
int Width=340
int Height=336
int TabOrder=90
boolean BringToTop=true
string DataObject="d_daily_prod_job_list"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

event clicked;// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;IF this.Rowcount() > 0 THEN
	il_job = this.GetItemNumber(currentRow, "ab_job_num")
	dw_abjob_details.Retrieve(il_job)
END IF

end event

type st_1 from statictext within w_daily_production
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

type tv_line from u_tvs within w_daily_production
int X=26
int Y=131
int Width=662
int Height=1686
int TabOrder=20
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
dw_shift.Reset()
dw_abjob_list.Reset()
dw_abjob_details.Reset()
dw_schedule.Reset()
tab_prod_details.tabpage_details.dw_production_info.Reset()
tab_prod_details.tabpage_downtime.dw_dt.Reset()
tab_prod_details.tabpage_spm.gr_spm.Reset(ALL!)
tab_prod_details.tabpage_comment.mle_shift_comments.Text = ""
tab_prod_details.tabpage_avg.gr_avg.Reset(ALL!)
tab_prod_details.tabpage_avg.st_lbs.Text = ""
tab_prod_details.tabpage_avg.st_hrs.Text = ""
tab_prod_details.tabpage_avg.st_avg.Text = ""
tab_prod_details.tabpage_avg.st_goal.Text = ""


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
	cb_new.Enabled = FALSE
	cb_print.Enabled = FALSE
else
 	ii_schedule_type = lds_datastore.GetItemNumber(ll_row,"schedule_type")
	 
	ll_parent = this.FindItem(ParentTreeItem!, ll_current)
	IF inv_levelsource.of_GetDataRow(ll_parent, lds_temp, ll_row_parent) = -1 THEN
		MessageBox("Error", "Error in of_GetDataRow", Exclamation!)
		RETURN -2
	END IF
 	ii_line = lds_temp.GetItemNumber(ll_row_parent,"line_schedule_line_num")
 	is_line = lds_temp.GetItemString(ll_row_parent,"line_line_desc")
	 
	il_shift_id = 0
	ld_d = Date(is_date)
 	SELECT shift_num, start_time, end_time INTO :il_shift_id, :ldt_s, :ldt_e
	FROM SHIFT
	WHERE Line_num = :ii_line AND schedule_type = :ii_schedule_type AND To_Date(start_Time) = :ld_d
	USING SQLCA;
	IF il_shift_id > 0 THEN
		IF IsNULL(ldt_s) OR isNULL(ldt_e) THEN
			MessageBox("Warning", "Invalid Date Info: Starting/Ending time is NULL.")
			il_shift_id = 0
			RETURN -1
		ELSE
			cb_new.Enabled = FALSE
			cb_modify.Enabled = TRUE
			cb_print.Enabled = TRUE
			Parent.Event ue_dw_info_refresh()
		END IF
	ELSE
		Parent.Event ue_new_shift_info()
		cb_new.Enabled = TRUE
		cb_modify.Enabled = FALSE
		cb_print.Enabled = FALSE
		dw_schedule.Event ue_Retrieve()
	END IF
end if
RETURN 1


end event
event clicked;Triggerevent ("sectionchanged")
end event

event rightclicked;//override
RETURN 1
end event

type cb_new from u_cb within w_daily_production
int X=903
int Y=1837
int Width=329
int Height=106
int TabOrder=40
boolean Enabled=false
string Tag="New shift info"
boolean BringToTop=true
string Text="&New"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;s_new_daily_prod_info lstr_q

IF il_shift_id > 0 THEN
	MessageBox("Warning", "Shift information already exists in database. Please use <Modify> to make changes.")
	RETURN -1
ELSE
	IF messagebox("New Shift Info", "Do you want to input shift information based on line " + is_line + "?",&
             Question!, OkCancel!,1)<>1 then
  		 Return 0
	ELSE
		lstr_q.line_id = ii_line
		lstr_q.line_desc = is_line
		lstr_q.prod_date = Date(is_date)
		lstr_q.schedule_type = ii_schedule_type
		lstr_q.Cancel = TRUE

		OpenwithParm(w_shift_info_new, lstr_q)
		il_shift_id = Message.LongParm
	
		IF il_shift_id > 0 THEN
			Parent.Event ue_dw_info_refresh()
		END IF
	END IF
END IF
RETURN 1
end event

type dw_schedule from u_dw within w_daily_production
event type integer ue_retrieve ( )
int X=753
int Y=227
int Width=1686
int Height=90
int TabOrder=110
boolean Enabled=false
boolean BringToTop=true
string DataObject="d_daily_prod_shift_schedule_display"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event ue_retrieve;Int li_row, li_c
DateTime ldt_s, ldt_e

li_row = this.Retrieve(Date(is_date), ii_line, ii_schedule_type)
IF li_row > 0 THEN RETURN 1

li_row = this.InsertRow(0)

IF li_row > 0 THEN
	
	CHOOSE CASE UPPER(DayName(Date(is_date)))
			CASE "MONDAY"
				SELECT mon_start, mon_end, mon_cancel 
				INTO :ldt_s, :ldt_e, :li_c
				FROM line_default_schedule
				WHERE (line_num = :ii_line) and (schedule_type = ii_schedule_type)
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
	this.SetItem(li_row, "shift_schedule_shift_cancelled", li_c)
	this.SetItem(li_row, "shift_schedule_shift_starting_time", DateTime(Date(is_date), Time(ldt_s)))
	IF ii_schedule_type = 3 THEN
		this.SetItem(li_row, "shift_schedule_shift_ending_time", DateTime(Relativedate(Date(is_date),1), Time(ldt_e)))
	ELSE
		this.SetItem(li_row, "shift_schedule_shift_ending_time", DateTime(Date(is_date), Time(ldt_e)))
	END IF
END IF
this.ResetUpdate()
RETURN 0

end event
event constructor;This.SetTransObject(sqlca)
end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type cb_print from u_cb within w_daily_production
int X=1467
int Y=1837
int Width=322
int Height=106
int TabOrder=50
boolean Enabled=false
boolean BringToTop=true
string Text="&Print"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;s_new_daily_prod_info lstr_q

lstr_q.line_id = ii_line
lstr_q.line_desc = is_line
lstr_q.prod_date = Date(is_date)
lstr_q.schedule_type = ii_schedule_type

Openwithparm(w_daily_prod_report_ds, lstr_q)
Return 1

end event

