$PBExportHeader$w_shift_info_new.srw
$PBExportComments$<Child> shift info entry window inherited from w_child
forward
global type w_shift_info_new from w_child
end type
type cb_ok from u_cb within w_shift_info_new
end type
type cb_cancel from u_cb within w_shift_info_new
end type
type st_1 from statictext within w_shift_info_new
end type
type st_3 from statictext within w_shift_info_new
end type
type st_4 from statictext within w_shift_info_new
end type
type em_end from u_em within w_shift_info_new
end type
type dw_1 from u_dw within w_shift_info_new
end type
type cb_save from u_cb within w_shift_info_new
end type
type em_start from u_em within w_shift_info_new
end type
type cb_time from u_cb within w_shift_info_new
end type
type tab_shift from tab within w_shift_info_new
end type
type tabpage_details from userobject within tab_shift
end type
type gb_coil from u_gb within tabpage_details
end type
type gb_job from u_gb within tabpage_details
end type
type dw_list from u_dw within tabpage_details
end type
type dw_coil from u_dw within tabpage_details
end type
type cb_coildetails from u_cb within tabpage_details
end type
type cb_jobdetails from u_cb within tabpage_details
end type
type cb_1 from u_cb within tabpage_details
end type
type em_job from u_em within tabpage_details
end type
type cb_2 from u_cb within tabpage_details
end type
type cb_3 from u_cb within tabpage_details
end type
type st_5 from statictext within tabpage_details
end type
type tabpage_comments from userobject within tab_shift
end type
type mle_note from u_mle within tabpage_comments
end type
type tabpage_dt from userobject within tab_shift
end type
type dw_dt from u_dw within tabpage_dt
end type
type cb_dtadd from u_cb within tabpage_dt
end type
type cb_dtdelete from u_cb within tabpage_dt
end type
type tabpage_details from userobject within tab_shift
gb_coil gb_coil
gb_job gb_job
dw_list dw_list
dw_coil dw_coil
cb_coildetails cb_coildetails
cb_jobdetails cb_jobdetails
cb_1 cb_1
em_job em_job
cb_2 cb_2
cb_3 cb_3
st_5 st_5
end type
type tabpage_comments from userobject within tab_shift
mle_note mle_note
end type
type tabpage_dt from userobject within tab_shift
dw_dt dw_dt
cb_dtadd cb_dtadd
cb_dtdelete cb_dtdelete
end type
type tab_shift from tab within w_shift_info_new
tabpage_details tabpage_details
tabpage_comments tabpage_comments
tabpage_dt tabpage_dt
end type
end forward

global type w_shift_info_new from w_child
int X=187
int Y=227
int Width=3449
int Height=1821
WindowType WindowType=response!
boolean TitleBar=true
string Title="Enter Shift Information"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event type integer ue_save ( )
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
st_3 st_3
st_4 st_4
em_end em_end
dw_1 dw_1
cb_save cb_save
em_start em_start
cb_time cb_time
tab_shift tab_shift
end type
global w_shift_info_new w_shift_info_new

type variables
s_new_daily_prod_info istr_q
Long il_shift_id
end variables

event ue_save;DateTime ldt_s, ldt_e
Long ll_shift, ll_bw, ll_ew, ll_coil, ll_netwt_balance
Int li_rc, li_i, li_run, li_status

ldt_s = f_datetime(em_start.Text)
ldt_e = f_datetime(em_end.Text)
IF f_hoursafter(ldt_s,ldt_e) < 0 THEN
	MessageBox("Warning", "Shift ending time is before starting time.")
	RETURN -1
END IF

tab_shift.tabpage_details.dw_coil.AcceptText()
li_rc = tab_shift.tabpage_details.dw_coil.RowCount()
IF li_rc > 0 THEN
	FOR li_i = li_rc TO 1 STEP -1
		li_run = tab_shift.tabpage_details.dw_coil.GetItemNumber(li_i, "coil_run_num", Primary!, FALSE) 
		IF IsNULL(li_run) OR li_run <= 0 THEN tab_shift.tabpage_details.dw_coil.DeleteRow(li_i)
	NEXT
END IF
li_rc = tab_shift.tabpage_details.dw_coil.RowCount()
IF li_rc > 0 THEN
	FOR li_i = 1 TO li_rc
		ll_bw = tab_shift.tabpage_details.dw_coil.GetItemNumber(li_i, "coil_begin_wt", Primary!, FALSE) 
		ll_ew = tab_shift.tabpage_details.dw_coil.GetItemNumber(li_i, "coil_end_wt", Primary!, FALSE)
		IF (ll_bw - ll_ew) < 0 THEN
			MessageBox("Warning", "Coil end weight is more than coil begin weight.")
			RETURN -2
		END IF
	NEXT
END IF

IF tab_shift.tabpage_dt.dw_dt.Event ue_verify_data() < 0 THEN RETURN -6

ll_shift = f_get_next_value("shift_num_seq")

FOR li_i = 1 TO li_rc
	tab_shift.tabpage_details.dw_coil.SetItem(li_i, "shift_num",ll_shift)
	tab_shift.tabpage_details.dw_coil.SetItem(li_i, "process_wt",(ll_bw - ll_ew))
NEXT

li_rc = tab_shift.tabpage_dt.dw_dt.RowCount()
IF li_rc > 0 THEN
	FOR li_i = 1 TO li_rc
		tab_shift.tabpage_dt.dw_dt.SetItem(li_i, "shift_num",ll_shift)
	NEXT
END IF

INSERT INTO SHIFT (shift_num, start_time, end_time, note, line_num, schedule_type)
VALUES (:ll_shift, :ldt_s, :ldt_e, :tab_shift.tabpage_comments.mle_note.Text, :istr_q.line_id, :istr_q.schedule_type)
USING SQLCA;
IF SQLCA.SQLCode <> 0 then
	ROLLBACK USING SQLCA;
	Messagebox("DBError", "Insert function: shift table" )
	RETURN -3
END IF

li_rc = tab_shift.tabpage_dt.dw_dt.Update()
IF li_rc = 1 AND SQLCA.SQLNRows > 0 THEN
	//COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -4
END IF

li_rc = tab_shift.tabpage_details.dw_coil.RowCount()
IF li_rc > 0 THEN
	FOR li_i = 1 TO li_rc
		ll_coil = tab_shift.tabpage_details.dw_coil.GetItemNumber(li_i, "coil_abc_num", Primary!, FALSE) 
		li_status = tab_shift.tabpage_details.dw_coil.GetItemNumber(li_i, "coil_end_status", Primary!, FALSE)
		ll_netwt_balance = tab_shift.tabpage_details.dw_coil.GetItemNumber(li_i, "coil_end_wt", Primary!, FALSE)
		UPDATE Coil
		SET coil_status = :li_status, net_wt_balance = :ll_netwt_balance
		WHERE coil_abc_num = :ll_coil
		USING SQLCA;
		IF SQLCA.SQLCode <> 0 then
			ROLLBACK USING SQLCA;
			Messagebox("DBError", "Update function: coil table" )
			RETURN -6
		END IF
	NEXT
END IF

li_rc = tab_shift.tabpage_details.dw_coil.Update()
IF li_rc = 1 AND SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	RETURN -5
END IF

RETURN ll_shift
end event

on w_shift_info_new.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.em_end=create em_end
this.dw_1=create dw_1
this.cb_save=create cb_save
this.em_start=create em_start
this.cb_time=create cb_time
this.tab_shift=create tab_shift
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.em_end
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.em_start
this.Control[iCurrent+10]=this.cb_time
this.Control[iCurrent+11]=this.tab_shift
end on

on w_shift_info_new.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_end)
destroy(this.dw_1)
destroy(this.cb_save)
destroy(this.em_start)
destroy(this.cb_time)
destroy(this.tab_shift)
end on

event open;call super::open;DateTime ldt_s, ldt_e
String ls_type

dw_1.Visible = FALSE

istr_q = Message.PowerObjectParm

SetNULL(ldt_s)
SetNULL(ldt_e)
SELECT shift_starting_time, shift_ending_time
INTO :ldt_s, :ldt_e
FROM shift_schedule
WHERE (line_num = :istr_q.line_id) AND 
		(schedule_type = :istr_q.schedule_type) AND
		(To_Date(shift_schedule_date) = :istr_q.Prod_date)
USING SQLCA;

IF isNULL(ldt_s) OR isNULL(ldt_e) THEN
	SELECT planned_starting_time, planned_ending_time
	INTO :ldt_s, :ldt_e
	FROM line_schedule
	WHERE line_num = :istr_q.line_id AND schedule_type = :istr_q.schedule_type
	USING SQLCA;
END IF
ldt_s = DateTime(istr_q.prod_date, Time(ldt_s))
ldt_e = DateTime(istr_q.prod_date, Time(ldt_e))

CHOOSE CASE istr_q.schedule_type
	CASE 1
		ls_type = "1ST"
	CASE 2
		ls_type = "2ND"
	CASE 3
		ls_type = "3RD"
	CASE ELSE
		ls_type = "OTHER"
END CHOOSE

st_1.Text = "Date: " + String(istr_q.prod_date) + " Line: " + istr_q.line_desc + " Shift: " + ls_type
em_start.Text = String(ldt_s)
em_end.Text = String(ldt_e)

end event

type cb_ok from u_cb within w_shift_info_new
int X=1543
int Y=1578
int TabOrder=60
boolean Enabled=false
boolean BringToTop=true
string Text="&Ok"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;CloseWithReturn(Parent, il_shift_id)
RETURN 1

end event

type cb_cancel from u_cb within w_shift_info_new
int X=2235
int Y=1578
int TabOrder=70
boolean BringToTop=true
string Text="&Cancel"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;CloseWithReturn(Parent, 0)
RETURN 1

end event

type st_1 from statictext within w_shift_info_new
int X=7
int Y=10
int Width=1148
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Date: 10/20/2004. Line : BL 78  Shift: 1ST"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80269524
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_shift_info_new
int X=7
int Y=102
int Width=523
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Shift Starting Time:"
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

type st_4 from statictext within w_shift_info_new
int X=1145
int Y=102
int Width=505
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Shift Ending Time:"
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

type em_end from u_em within w_shift_info_new
int X=1671
int Y=102
int Width=589
int Height=74
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Mask="mm/dd/yyyy hh:mm:ss"
MaskDataType MaskDataType=DateTimeMask!
double Increment=0
string MinMax=""
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type dw_1 from u_dw within w_shift_info_new
int X=3065
int Y=1584
int Width=80
int Height=35
int TabOrder=0
boolean BringToTop=true
string DataObject="d_daily_prod_process_coil"
end type

event constructor;of_SetBase(TRUE)
SetRowFocusIndicator(FocusRect!) 
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

type cb_save from u_cb within w_shift_info_new
int X=852
int Y=1578
int TabOrder=30
boolean BringToTop=true
string Text="&Save"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;If Parent.Event ue_save() > 0 THEN
	em_start.Enabled = FALSE
	em_end.Enabled = FALSE
	tab_shift.tabpage_details.em_job.Enabled = FALSE
	tab_shift.tabpage_details.dw_list.Enabled = FALSE
	tab_shift.tabpage_details.dw_coil.Enabled = FALSE
	tab_shift.tabpage_comments.mle_note.Enabled = FALSE
	cb_ok.Enabled = TRUE
END IF
RETURN 1
end event

type em_start from u_em within w_shift_info_new
int X=523
int Y=102
int Width=589
int Height=74
int TabOrder=50
boolean Enabled=false
boolean BringToTop=true
string Mask="mm/dd/yyyy hh:mm:ss"
MaskDataType MaskDataType=DateTimeMask!
double Increment=0
string MinMax=""
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cb_time from u_cb within w_shift_info_new
int X=2308
int Y=99
int Width=355
int Height=74
int TabOrder=20
boolean BringToTop=true
string Text="&Change Time"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;IF MessageBox("Warning","About to change shift start/ending time, are you sure?", Question!, OKCancel!, 2) = 1 THEN
	em_start.Enabled = TRUE
	em_end.Enabled = TRUE
END IF

end event

type tab_shift from tab within w_shift_info_new
event create ( )
event destroy ( )
int X=7
int Y=221
int Width=3397
int Height=1328
int TabOrder=10
boolean BringToTop=true
boolean BoldSelectedText=true
Alignment Alignment=Center!
int SelectedTab=1
long BackColor=80269524
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_details tabpage_details
tabpage_comments tabpage_comments
tabpage_dt tabpage_dt
end type

on tab_shift.create
this.tabpage_details=create tabpage_details
this.tabpage_comments=create tabpage_comments
this.tabpage_dt=create tabpage_dt
this.Control[]={this.tabpage_details,&
this.tabpage_comments,&
this.tabpage_dt}
end on

on tab_shift.destroy
destroy(this.tabpage_details)
destroy(this.tabpage_comments)
destroy(this.tabpage_dt)
end on

type tabpage_details from userobject within tab_shift
event type integer ue_jobdetails ( )
event type integer ue_coildetails ( )
event type integer ue_addjobs ( )
event type integer ue_removejobs ( )
int X=15
int Y=90
int Width=3368
int Height=1226
long BackColor=80269524
string Text="Details"
long TabBackColor=80269524
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Paste!"
gb_coil gb_coil
gb_job gb_job
dw_list dw_list
dw_coil dw_coil
cb_coildetails cb_coildetails
cb_jobdetails cb_jobdetails
cb_1 cb_1
em_job em_job
cb_2 cb_2
cb_3 cb_3
st_5 st_5
end type

event ue_jobdetails;Long ll_row, ll_job

ll_Row = tab_shift.tabpage_details.dw_list.GetRow()

IF ll_row < 1 THEN RETURN 0

ll_job = tab_shift.tabpage_details.dw_list.GetItemNumber(ll_row, "ab_job_num", Primary!, FALSE)

IF ll_job < 1 THEN RETURN -1

OpenwithParm(w_daily_prod_job_detail_display, ll_job)

RETURN 1
end event

event ue_coildetails;Long ll_row, ll_coil

ll_Row = tab_shift.tabpage_details.dw_coil.GetRow()

IF ll_row < 1 THEN RETURN 0

ll_coil = tab_shift.tabpage_details.dw_coil.GetItemNumber(ll_row, "coil_abc_num", Primary!, FALSE)

IF ll_coil < 1 THEN RETURN -1

OpenwithParm(w_daily_prod_coil_detail_display, ll_coil)

RETURN 1
end event

event ue_addjobs;Long ll_job, ll_rc, ll_newcoil, ll_coil_abc_num, ll_job2
Int li_i, li_j, li_line
String ls_line2

ll_job = Long(em_job.Text)
ll_job2 = 0

Select ab_job.line_num, ab_job.ab_job_num ,line.line_desc
Into :li_line, :ll_job2, :ls_line2
From ab_job, line
Where (ab_job.line_num = line.line_num ) AND  (ab_job.ab_job_num = :ll_job)
USING SQLCA;


IF isNULL(ll_job2) OR ll_job2 = 0 THEN 
	MessageBox("warning", "Invalid production order #" + em_job.Text + ".")
	Return -1
END IF

ll_rc = tab_shift.tabpage_details.dw_list.RowCount()
IF ll_rc > 0 THEN
	For li_i = 1 to ll_rc 
		IF ll_job = tab_shift.tabpage_details.dw_list.GetItemNumber(li_i,"ab_job_num") THEN
			MessageBox("warning", "Production order #" + em_job.Text + " has already been added.")
			Return -2
		END IF
	NEXT
END IF

IF li_line > 0 AND li_line <> istr_q.line_id THEN 
	IF messagebox("Warning", "Production order #" + em_job.Text + " has been assigned to line "  + ls_line2 + ". Continue?",&
             Question!, OkCancel!,1)<>1 then Return -2
END IF

ll_rc = tab_shift.tabpage_details.dw_list.InsertRow (0) 
tab_shift.tabpage_details.dw_list.SetItem(ll_rc, "ab_job_num", ll_job)

dw_1.Retrieve(ll_job)
ll_rc = dw_1.RowCount()
IF ll_rc = 0 THEN Return 0
FOR li_i = 1 TO ll_rc
	ll_newcoil = tab_shift.tabpage_details.dw_coil.InsertRow(0)
	tab_shift.tabpage_details.dw_coil.SetItem(ll_newcoil, "ab_job_num", ll_job)
	tab_shift.tabpage_details.dw_coil.SetItem(ll_newcoil, "coil_abc_num", dw_1.GetItemNumber(li_i, "coil_coil_abc_num"))
	tab_shift.tabpage_details.dw_coil.SetItem(ll_newcoil, "coil_begin_status", dw_1.GetItemNumber(li_i,"coil_coil_status"))
	tab_shift.tabpage_details.dw_coil.SetItem(ll_newcoil, "coil_begin_wt", dw_1.GetItemNumber(li_i,"coil_net_wt_balance"))
	//tab_shift.tabpage_details.dw_coil.SetItem(ll_newcoil, "coil_begin_time", istr_q.Prod_date)
	//tab_shift.tabpage_details.dw_coil.SetItem(ll_newcoil, "coil_end_time", istr_q.prod_date)
NEXT

RETURN 1
end event

event ue_removejobs;Long ll_job, ll_rc, ll_newcoil, ll_coil_abc_num
Int li_i, li_j, li_jobrow
Boolean lb_exist

ll_job = Long(em_job.Text)

lb_exist = FALSE
ll_rc = tab_shift.tabpage_details.dw_list.RowCount()
IF ll_rc > 0 THEN
	For li_i = 1 to ll_rc 
		IF ll_job = tab_shift.tabpage_details.dw_list.GetItemNumber(li_i,"ab_job_num") THEN
			li_jobrow = li_i
			lb_exist = TRUE
		END IF
	NEXT
END IF
IF Not(lb_exist) THEN
	MessageBox("warning", "Production order #" + em_job.Text + " is not on the list.")
	Return -2
END IF

ll_rc = tab_shift.tabpage_details.dw_list.DeleteRow(li_jobrow) 

ll_rc = tab_shift.tabpage_details.dw_coil.RowCount()
IF ll_rc = 0 THEN Return 0
FOR li_i = ll_rc TO 1 STEP -1	
	IF ll_job = tab_shift.tabpage_details.dw_coil.GetItemNumber(li_i,"ab_job_num") THEN
		tab_shift.tabpage_details.dw_coil.DeleteRow(li_i)
	END IF
NEXT

RETURN 1
end event

on tabpage_details.create
this.gb_coil=create gb_coil
this.gb_job=create gb_job
this.dw_list=create dw_list
this.dw_coil=create dw_coil
this.cb_coildetails=create cb_coildetails
this.cb_jobdetails=create cb_jobdetails
this.cb_1=create cb_1
this.em_job=create em_job
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_5=create st_5
this.Control[]={this.gb_coil,&
this.gb_job,&
this.dw_list,&
this.dw_coil,&
this.cb_coildetails,&
this.cb_jobdetails,&
this.cb_1,&
this.em_job,&
this.cb_2,&
this.cb_3,&
this.st_5}
end on

on tabpage_details.destroy
destroy(this.gb_coil)
destroy(this.gb_job)
destroy(this.dw_list)
destroy(this.dw_coil)
destroy(this.cb_coildetails)
destroy(this.cb_jobdetails)
destroy(this.cb_1)
destroy(this.em_job)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_5)
end on

type gb_coil from u_gb within tabpage_details
int X=457
int Y=179
int Width=2904
int Height=912
int TabOrder=11
string Text="Coils"
long BackColor=80269524
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type gb_job from u_gb within tabpage_details
int X=4
int Y=179
int Width=443
int Height=912
int TabOrder=20
string Text="Production Order"
long BackColor=80269524
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type dw_list from u_dw within tabpage_details
int X=26
int Y=243
int Width=399
int Height=800
int TabOrder=11
boolean BringToTop=true
string DataObject="d_ab_job_input_list"
end type

event constructor;of_SetBase(TRUE)
SetRowFocusIndicator(FocusRect!) 
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)


end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//em_job.Text = String(this.GetItemNumber(li_row, "ab_job_num"))

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 1
end event

type dw_coil from u_dw within tabpage_details
int X=475
int Y=240
int Width=2871
int Height=800
int TabOrder=11
boolean BringToTop=true
string DataObject="d_daily_prod_coil_input"
end type

event constructor;of_SetBase(TRUE)
SetRowFocusIndicator(FocusRect!) 
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 )
SetTransObject(SQLCA)


end event

event rbuttondown;return 1
end event

event rbuttonup;RETURN 1
end event

type cb_coildetails from u_cb within tabpage_details
int X=995
int Y=1107
int Width=358
int TabOrder=11
boolean BringToTop=true
string Text="C&oil Details"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;RETURN parent.Event ue_coildetails()
end event

type cb_jobdetails from u_cb within tabpage_details
int X=1986
int Y=1107
int TabOrder=11
boolean BringToTop=true
string Text="&Job Details"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;RETURN Parent.Event ue_jobdetails()
end event

type cb_1 from u_cb within tabpage_details
int X=987
int Y=58
int Width=358
int Height=83
int TabOrder=11
boolean BringToTop=true
string Text="&Enter"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Return Parent.Event ue_addjobs()
end event

type em_job from u_em within tabpage_details
int X=527
int Y=58
int Width=446
int TabOrder=11
boolean BringToTop=true
Alignment Alignment=Center!
string Mask="########"
double Increment=0
string MinMax=""
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type cb_2 from u_cb within tabpage_details
int X=1360
int Y=58
int Width=358
int Height=83
int TabOrder=11
boolean BringToTop=true
string Text="&Remove"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Return Parent.Event ue_removejobs()
end event

type cb_3 from u_cb within tabpage_details
int X=1733
int Y=58
int Width=358
int Height=83
int TabOrder=11
boolean BringToTop=true
string Text="&Reset"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;em_job.Text = ""
end event

type st_5 from statictext within tabpage_details
int X=29
int Y=61
int Width=483
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="Production Order"
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

type tabpage_comments from userobject within tab_shift
event create ( )
event destroy ( )
int X=15
int Y=90
int Width=3368
int Height=1226
long BackColor=80269524
string Text="Comments"
long TabBackColor=80269524
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="DosEdit5!"
mle_note mle_note
end type

on tabpage_comments.create
this.mle_note=create mle_note
this.Control[]={this.mle_note}
end on

on tabpage_comments.destroy
destroy(this.mle_note)
end on

type mle_note from u_mle within tabpage_comments
int X=11
int Y=16
int Width=3343
int Height=1133
int TabOrder=10
boolean BringToTop=true
boolean HideSelection=false
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type tabpage_dt from userobject within tab_shift
int X=15
int Y=90
int Width=3368
int Height=1226
long BackColor=80269524
string Text="Downtime"
long TabBackColor=80269524
long TabTextColor=33554432
long PictureMaskColor=553648127
string PictureName="Where!"
dw_dt dw_dt
cb_dtadd cb_dtadd
cb_dtdelete cb_dtdelete
end type

on tabpage_dt.create
this.dw_dt=create dw_dt
this.cb_dtadd=create cb_dtadd
this.cb_dtdelete=create cb_dtdelete
this.Control[]={this.dw_dt,&
this.cb_dtadd,&
this.cb_dtdelete}
end on

on tabpage_dt.destroy
destroy(this.dw_dt)
destroy(this.cb_dtadd)
destroy(this.cb_dtdelete)
end on

type dw_dt from u_dw within tabpage_dt
event type integer ue_verify_data ( )
int X=40
int Y=35
int Width=3291
int Height=1050
int TabOrder=11
boolean BringToTop=true
string DataObject="d_daily_prod_new_dt_info"
end type

event ue_verify_data;Long ll_row1, ll_i, ll_row2, ll_j, ll_job
Boolean lb_exist

ll_row1 = this.Rowcount()
IF ll_row1 = 0 THEN RETURN 1

ll_Row2 = tab_shift.tabpage_details.dw_list.RowCount()
IF ll_row2 <= 0 THEN
	MessageBox("Warning", "No production order specified on Details page.")
	RETURN -1
END IF

FOR ll_i = 1 TO ll_row1
	ll_job = this.GetItemNumber(ll_i, "ab_job_num", Primary!, FALSE)
	lb_exist = FALSE
	FOR ll_j = 1 TO ll_row2
		IF tab_shift.tabpage_details.dw_list.GetItemNumber(ll_j, "ab_job_num", Primary!, FALSE) = ll_job THEN
			lb_exist = TRUE
		END IF
	NEXT
	IF NOT(lb_exist) THEN
		MessageBox("Warning", "Production order " + String(ll_job) + " has not been assigned to this shift.")
		RETURN -2
	END IF		
NEXT

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
IF this.GetChild("id", ldddw_cni) = -1 THEN 
	Return -1
ELSE
	this.Event pfc_PopulateDDDW("id", ldddw_cni)
END IF


end event

event pfc_addrow;call super::pfc_addrow;Long ll_row, ll_job

ll_Row = tab_shift.tabpage_details.dw_list.GetRow()

IF ll_row < 1 THEN RETURN 0

ll_job = tab_shift.tabpage_details.dw_list.GetItemNumber(ll_row, "ab_job_num", Primary!, FALSE)

IF ll_job < 1 THEN RETURN -1
ll_row = GetRow()
SetItem(ll_row,"ab_job_num", ll_job)

Return ll_job

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

type cb_dtadd from u_cb within tabpage_dt
int X=987
int Y=1101
int TabOrder=11
boolean BringToTop=true
string Text="&Add"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;RETURN dw_dt.Event Pfc_addrow()
end event

type cb_dtdelete from u_cb within tabpage_dt
int X=2015
int Y=1101
int TabOrder=11
boolean BringToTop=true
string Text="&Delete"
int TextSize=-9
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;RETURN dw_dt.Event pfc_deleterow()
end event

