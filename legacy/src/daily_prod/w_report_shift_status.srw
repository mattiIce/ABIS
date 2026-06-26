$PBExportHeader$w_report_shift_status.srw
$PBExportComments$ Current shift status based on production line based on different customers
forward
global type w_report_shift_status from w_sheet
end type
type tab_shift from tab within w_report_shift_status
end type
type tabpage_line from userobject within tab_shift
end type
type tv_84 from u_tvs within tabpage_line
end type
type dw_84 from u_dw within tabpage_line
end type
type st_84_3 from u_st within tabpage_line
end type
type st_84_1 from u_st within tabpage_line
end type
type st_84_2 from u_st within tabpage_line
end type
type st_24_1 from u_st within tabpage_line
end type
type st_24_2 from u_st within tabpage_line
end type
type tv_24 from u_tvs within tabpage_line
end type
type st_24_3 from u_st within tabpage_line
end type
type dw_24 from u_dw within tabpage_line
end type
type dw_36 from u_dw within tabpage_line
end type
type st_36_3 from u_st within tabpage_line
end type
type tv_36 from u_tvs within tabpage_line
end type
type st_36_1 from u_st within tabpage_line
end type
type st_36_2 from u_st within tabpage_line
end type
type st_60_1 from u_st within tabpage_line
end type
type st_60_2 from u_st within tabpage_line
end type
type tv_60 from u_tvs within tabpage_line
end type
type st_60_3 from u_st within tabpage_line
end type
type dw_60 from u_dw within tabpage_line
end type
type st_75_1 from u_st within tabpage_line
end type
type st_75_2 from u_st within tabpage_line
end type
type tv_75 from u_tvs within tabpage_line
end type
type st_75_3 from u_st within tabpage_line
end type
type dw_75 from u_dw within tabpage_line
end type
type st_108_1 from u_st within tabpage_line
end type
type st_108_2 from u_st within tabpage_line
end type
type tv_108 from u_tvs within tabpage_line
end type
type st_108_3 from u_st within tabpage_line
end type
type dw_108 from u_dw within tabpage_line
end type
type st_110_1 from u_st within tabpage_line
end type
type st_110_2 from u_st within tabpage_line
end type
type tv_110 from u_tvs within tabpage_line
end type
type st_110_3 from u_st within tabpage_line
end type
type dw_110 from u_dw within tabpage_line
end type
type gb_110 from u_gb within tabpage_line
end type
type gb_84 from u_gb within tabpage_line
end type
type gb_24 from u_gb within tabpage_line
end type
type gb_36 from u_gb within tabpage_line
end type
type gb_75 from u_gb within tabpage_line
end type
type gb_60 from u_gb within tabpage_line
end type
type gb_108 from u_gb within tabpage_line
end type
type tabpage_line from userobject within tab_shift
tv_84 tv_84
dw_84 dw_84
st_84_3 st_84_3
st_84_1 st_84_1
st_84_2 st_84_2
st_24_1 st_24_1
st_24_2 st_24_2
tv_24 tv_24
st_24_3 st_24_3
dw_24 dw_24
dw_36 dw_36
st_36_3 st_36_3
tv_36 tv_36
st_36_1 st_36_1
st_36_2 st_36_2
st_60_1 st_60_1
st_60_2 st_60_2
tv_60 tv_60
st_60_3 st_60_3
dw_60 dw_60
st_75_1 st_75_1
st_75_2 st_75_2
tv_75 tv_75
st_75_3 st_75_3
dw_75 dw_75
st_108_1 st_108_1
st_108_2 st_108_2
tv_108 tv_108
st_108_3 st_108_3
dw_108 dw_108
st_110_1 st_110_1
st_110_2 st_110_2
tv_110 tv_110
st_110_3 st_110_3
dw_110 dw_110
gb_110 gb_110
gb_84 gb_84
gb_24 gb_24
gb_36 gb_36
gb_75 gb_75
gb_60 gb_60
gb_108 gb_108
end type
type tabpage_details from userobject within tab_shift
end type
type st_11 from statictext within tabpage_details
end type
type st_10 from statictext within tabpage_details
end type
type st_8 from statictext within tabpage_details
end type
type st_7 from statictext within tabpage_details
end type
type st_6 from statictext within tabpage_details
end type
type st_5 from statictext within tabpage_details
end type
type st_4 from statictext within tabpage_details
end type
type st_3 from statictext within tabpage_details
end type
type st_2 from statictext within tabpage_details
end type
type cb_print from u_cb within tabpage_details
end type
type cb_summary from u_cb within tabpage_details
end type
type cb_details from u_cb within tabpage_details
end type
type dw_data from u_dw within tabpage_details
end type
type tabpage_details from userobject within tab_shift
st_11 st_11
st_10 st_10
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_print cb_print
cb_summary cb_summary
cb_details cb_details
dw_data dw_data
end type
type tab_shift from tab within w_report_shift_status
tabpage_line tabpage_line
tabpage_details tabpage_details
end type
type st_timer from statictext within w_report_shift_status
end type
type cb_close from u_cb within w_report_shift_status
end type
type cb_retrieve from u_cb within w_report_shift_status
end type
end forward

global type w_report_shift_status from w_sheet
string tag = "ABCO production shift status reports"
integer x = 4
integer y = 3
integer width = 3690
integer height = 2106
string title = "Shift Status Report"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
event type integer ue_populate_data ( )
tab_shift tab_shift
st_timer st_timer
cb_close cb_close
cb_retrieve cb_retrieve
end type
global w_report_shift_status w_report_shift_status

type variables
String is_line
String is_status
String is_cust
String is_enduser
String is_desc
end variables

event type string ue_whoami();RETURN "w_report_shift_status"
end event

event type integer ue_populate_data();Long ll_shift, ll_dt, ll_status, ll_row, ll_i, ll_line, ll_tvi
DateTime ldt_s, ldt_e
DataStore lds_shift

lds_shift = CREATE datastore  
lds_shift.DataObject = "d_current_shift_status_all_lines"  
lds_shift.SetTransObject (SQLCA)  
lds_shift.Retrieve()
ll_row = lds_shift.RowCount()

FOR ll_i = 1 TO ll_row
	SetNULL(ll_shift)
	ll_line = lds_shift.GetItemNumber(ll_i, "line_num")
	ll_shift = lds_shift.GetItemNumber(ll_i, "shift_num")
	ldt_s = lds_shift.GetItemDateTime(ll_i, "shift_planned_starting_time")
	ldt_e = lds_shift.GetItemDateTime(ll_i, "shift_planned_ending_time")
	ll_dt = lds_shift.GetItemNumber(ll_i, "shift_dt_total")
	ll_status = lds_shift.GetItemNumber(ll_i, "line_status")
	CHOOSE CASE ll_line
		CASE 1 //24 line
			IF IsNULL(ll_shift) OR ll_shift < 1 THEN
				tab_shift.tabpage_line.st_24_1.Text = "No shift running"
				tab_shift.tabpage_line.st_24_2.Text = ""
				tab_shift.tabpage_line.st_24_3.Text = ""
				tab_shift.tabpage_line.tv_24.Visible = FALSE
				tab_shift.tabpage_line.dw_24.Visible = FALSE
				tab_shift.tabpage_line.gb_24.TextColor = RGB(255,255,255)
			ELSE
				IF ISNULL(ldt_s) OR IsNULL(ldt_e) THEN
					tab_shift.tabpage_line.st_24_1.Text = "No start/end time"
				ELSE
					tab_shift.tabpage_line.st_24_1.Text = String(ldt_s, "hh:mm;'none'") + " -- " + String(ldt_e, "hh:mm;'none'")
				END IF
				IF IsNULL(ll_dt) THEN ll_dt = 0
				tab_shift.tabpage_line.st_24_2.Text = "DownTime(min): " + String(ll_dt)
				tab_shift.tabpage_line.st_24_3.Text = "Currently Running:"
				tab_shift.tabpage_line.tv_24.Visible = TRUE
				tab_shift.tabpage_line.dw_24.Visible = TRUE
				IF ll_status = 0 THEN
					tab_shift.tabpage_line.gb_24.Text = "BL 24 - Running"
					tab_shift.tabpage_line.gb_24.TextColor = RGB(0,255,0)
				ELSE
					tab_shift.tabpage_line.gb_24.Text = "BL 24 - Downtime"
					tab_shift.tabpage_line.gb_24.TextColor = RGB(255,0, 0)
				END IF	
			END IF
		CASE 2 //36 line
			IF IsNULL(ll_shift) OR ll_shift < 1 THEN
				tab_shift.tabpage_line.st_36_1.Text = "No shift running"
				tab_shift.tabpage_line.st_36_2.Text = ""
				tab_shift.tabpage_line.st_36_3.Text = ""
				tab_shift.tabpage_line.tv_36.Visible = FALSE
				tab_shift.tabpage_line.dw_36.Visible = FALSE
				tab_shift.tabpage_line.gb_36.TextColor = RGB(255,255,255)
			ELSE
				IF ISNULL(ldt_s) OR IsNULL(ldt_e) THEN
					tab_shift.tabpage_line.st_36_1.Text = "No start/end time"
				ELSE
					tab_shift.tabpage_line.st_36_1.Text = String(ldt_s, "hh:mm;'none'") + " -- " + String(ldt_e, "hh:mm;'none'")
				END IF
				IF IsNULL(ll_dt) THEN ll_dt = 0
				tab_shift.tabpage_line.st_36_2.Text = "DownTime(min): " + String(ll_dt)
				tab_shift.tabpage_line.st_36_3.Text = "Currently Running:"
				tab_shift.tabpage_line.tv_36.Visible = TRUE
				tab_shift.tabpage_line.dw_36.Visible = TRUE
				IF ll_status = 0 THEN
					tab_shift.tabpage_line.gb_36.Text = "BL 36 - Running"
					tab_shift.tabpage_line.gb_36.TextColor = RGB(0,255,0)
				ELSE
					tab_shift.tabpage_line.gb_36.Text = "BL 36 - Downtime"
					tab_shift.tabpage_line.gb_36.TextColor = RGB(255,0, 0)
				END IF	
			END IF
		CASE 3 //60 line
			IF IsNULL(ll_shift) OR ll_shift < 1 THEN
				tab_shift.tabpage_line.st_60_1.Text = "No shift running"
				tab_shift.tabpage_line.st_60_2.Text = ""
				tab_shift.tabpage_line.st_60_3.Text = ""
				tab_shift.tabpage_line.tv_60.Visible = FALSE
				tab_shift.tabpage_line.dw_60.Visible = FALSE
				tab_shift.tabpage_line.gb_60.TextColor = RGB(255,255,255)
			ELSE
				IF ISNULL(ldt_s) OR IsNULL(ldt_e) THEN
					tab_shift.tabpage_line.st_60_1.Text = "No start/end time"
				ELSE
					tab_shift.tabpage_line.st_60_1.Text = String(ldt_s, "hh:mm;'none'") + " -- " + String(ldt_e, "hh:mm;'none'")
				END IF
				IF IsNULL(ll_dt) THEN ll_dt = 0
				tab_shift.tabpage_line.st_60_2.Text = "DownTime(min): " + String(ll_dt)
				tab_shift.tabpage_line.st_60_3.Text = "Currently Running:"
				tab_shift.tabpage_line.tv_60.Visible = TRUE
				tab_shift.tabpage_line.dw_60.Visible = TRUE
				IF ll_status = 0 THEN
					tab_shift.tabpage_line.gb_60.Text = "BL 60 - Running"
					tab_shift.tabpage_line.gb_60.TextColor = RGB(0,255,0)
				ELSE
					tab_shift.tabpage_line.gb_60.Text = "BL 60 - Downtime"
					tab_shift.tabpage_line.gb_60.TextColor = RGB(255,0, 0)
				END IF	
			END IF
		CASE 4 //75 line
			IF IsNULL(ll_shift) OR ll_shift < 1 THEN
				tab_shift.tabpage_line.st_75_1.Text = "No shift running"
				tab_shift.tabpage_line.st_75_2.Text = ""
				tab_shift.tabpage_line.st_75_3.Text = ""
				tab_shift.tabpage_line.tv_75.Visible = FALSE
				tab_shift.tabpage_line.dw_75.Visible = FALSE
				tab_shift.tabpage_line.gb_75.TextColor = RGB(255,255,255)
			ELSE
				IF ISNULL(ldt_s) OR IsNULL(ldt_e) THEN
					tab_shift.tabpage_line.st_75_1.Text = "No start/end time"
				ELSE
					tab_shift.tabpage_line.st_75_1.Text = String(ldt_s, "hh:mm;'none'") + " -- " + String(ldt_e, "hh:mm;'none'")
				END IF
				IF IsNULL(ll_dt) THEN ll_dt = 0
				tab_shift.tabpage_line.st_75_2.Text = "DownTime(min): " + String(ll_dt)
				tab_shift.tabpage_line.st_75_3.Text = "Currently Running:"
				tab_shift.tabpage_line.tv_75.Visible = TRUE
				tab_shift.tabpage_line.dw_75.Visible = TRUE
				IF ll_status = 0 THEN
					tab_shift.tabpage_line.gb_75.Text = "BL 78 - Running"
					tab_shift.tabpage_line.gb_75.TextColor = RGB(0,255,0)
				ELSE
					tab_shift.tabpage_line.gb_75.Text = "BL 78 - Downtime"
					tab_shift.tabpage_line.gb_75.TextColor = RGB(255,0, 0)
				END IF	
			END IF
		CASE 5 //108 line
			IF IsNULL(ll_shift) OR ll_shift < 1 THEN
				tab_shift.tabpage_line.st_108_1.Text = "No shift running"
				tab_shift.tabpage_line.st_108_2.Text = ""
				tab_shift.tabpage_line.st_108_3.Text = ""
				tab_shift.tabpage_line.tv_108.Visible = FALSE
				tab_shift.tabpage_line.dw_108.Visible = FALSE
				tab_shift.tabpage_line.gb_108.TextColor = RGB(255,255,255)
			ELSE
				IF ISNULL(ldt_s) OR IsNULL(ldt_e) THEN
					tab_shift.tabpage_line.st_108_1.Text = "No start/end time"
				ELSE
					tab_shift.tabpage_line.st_108_1.Text = String(ldt_s, "hh:mm;'none'") + " -- " + String(ldt_e, "hh:mm;'none'")
				END IF
				IF IsNULL(ll_dt) THEN ll_dt = 0
				tab_shift.tabpage_line.st_108_2.Text = "DownTime(min): " + String(ll_dt)
				tab_shift.tabpage_line.st_108_3.Text = "Currently Running:"
				tab_shift.tabpage_line.tv_108.Visible = TRUE
				tab_shift.tabpage_line.dw_108.Visible = TRUE
				IF ll_status = 0 THEN
					tab_shift.tabpage_line.gb_108.Text = "BL 108 - Running"
					tab_shift.tabpage_line.gb_108.TextColor = RGB(0,255,0)
				ELSE
					tab_shift.tabpage_line.gb_108.Text = "BL 108 - Downtime"
					tab_shift.tabpage_line.gb_108.TextColor = RGB(255,0, 0)
				END IF	
			END IF
		CASE 6 //110 line
			IF IsNULL(ll_shift) OR ll_shift < 1 THEN
				tab_shift.tabpage_line.st_110_1.Text = "No shift running"
				tab_shift.tabpage_line.st_110_2.Text = ""
				tab_shift.tabpage_line.st_110_3.Text = ""
				tab_shift.tabpage_line.tv_110.Visible = FALSE
				tab_shift.tabpage_line.dw_110.Visible = FALSE
				tab_shift.tabpage_line.gb_110.TextColor = RGB(255,255,255)
			ELSE
				IF ISNULL(ldt_s) OR IsNULL(ldt_e) THEN
					tab_shift.tabpage_line.st_110_1.Text = "No start/end time"
				ELSE
					tab_shift.tabpage_line.st_110_1.Text = String(ldt_s, "hh:mm;'none'") + " -- " + String(ldt_e, "hh:mm;'none'")
				END IF
				IF IsNULL(ll_dt) THEN ll_dt = 0
				tab_shift.tabpage_line.st_110_2.Text = "DownTime(min): " + String(ll_dt)
				tab_shift.tabpage_line.st_110_3.Text = "Currently Running:"
				tab_shift.tabpage_line.tv_110.Visible = TRUE
				tab_shift.tabpage_line.dw_110.Visible = TRUE
				IF ll_status = 0 THEN
					tab_shift.tabpage_line.gb_110.Text = "BL 110 - Running"
					tab_shift.tabpage_line.gb_110.TextColor = RGB(0,255,0)
				ELSE
					tab_shift.tabpage_line.gb_110.Text = "BL 110 - Downtime"
					tab_shift.tabpage_line.gb_110.TextColor = RGB(255,0, 0)
				END IF	
			END IF
		CASE 7 //84 line
			IF IsNULL(ll_shift) OR ll_shift < 1 THEN
				tab_shift.tabpage_line.st_84_1.Text = "No shift running"
				tab_shift.tabpage_line.st_84_2.Text = ""
				tab_shift.tabpage_line.st_84_3.Text = ""
				tab_shift.tabpage_line.tv_84.Visible = FALSE
				tab_shift.tabpage_line.dw_84.Visible = FALSE
				tab_shift.tabpage_line.gb_84.TextColor = RGB(255,255,255)
			ELSE
				IF ISNULL(ldt_s) OR IsNULL(ldt_e) THEN
					tab_shift.tabpage_line.st_84_1.Text = "No start/end time"
				ELSE
					tab_shift.tabpage_line.st_84_1.Text = String(ldt_s, "hh:mm;'none'") + " -- " + String(ldt_e, "hh:mm;'none'")
				END IF
				IF IsNULL(ll_dt) THEN ll_dt = 0
				tab_shift.tabpage_line.st_84_2.Text = "DownTime(min): " + String(ll_dt)
				tab_shift.tabpage_line.st_84_3.Text = "Currently Running:"
				tab_shift.tabpage_line.tv_84.Visible = TRUE
				tab_shift.tabpage_line.dw_84.Visible = TRUE
				IF ll_status = 0 THEN
					tab_shift.tabpage_line.gb_84.Text = "BL 84 - Running"
					tab_shift.tabpage_line.gb_84.TextColor = RGB(0,255,0)
				ELSE
					tab_shift.tabpage_line.gb_84.Text = "BL 84 - Downtime"
					tab_shift.tabpage_line.gb_84.TextColor = RGB(255,0, 0)
				END IF	
			END IF
		CASE ELSE
			//nothing
	END CHOOSE
NEXT

DESTROY lds_shift

tab_shift.tabpage_line.dw_24.Reset()
tab_shift.tabpage_line.dw_24.Retrieve()
tab_shift.tabpage_line.tv_24.Event pfc_RefreshLevel(1)
ll_tvi = tab_shift.tabpage_line.tv_24.FindItem(RootTreeItem! , 0)
tab_shift.tabpage_line.tv_24.ExpandAll(ll_tvi)

tab_shift.tabpage_line.dw_36.Reset()
tab_shift.tabpage_line.dw_36.Retrieve()
tab_shift.tabpage_line.tv_36.Event pfc_RefreshLevel(1)
ll_tvi = tab_shift.tabpage_line.tv_36.FindItem(RootTreeItem! , 0)
tab_shift.tabpage_line.tv_36.ExpandAll(ll_tvi)

tab_shift.tabpage_line.dw_60.Reset()
tab_shift.tabpage_line.dw_60.Retrieve()
tab_shift.tabpage_line.tv_60.Event pfc_RefreshLevel(1)
ll_tvi = tab_shift.tabpage_line.tv_60.FindItem(RootTreeItem! , 0)
tab_shift.tabpage_line.tv_60.ExpandAll(ll_tvi)

tab_shift.tabpage_line.dw_75.Reset()
tab_shift.tabpage_line.dw_75.Retrieve()
tab_shift.tabpage_line.tv_75.Event pfc_RefreshLevel(1)
ll_tvi = tab_shift.tabpage_line.tv_75.FindItem(RootTreeItem! , 0)
tab_shift.tabpage_line.tv_75.ExpandAll(ll_tvi)

tab_shift.tabpage_line.dw_84.Reset()
tab_shift.tabpage_line.dw_84.Retrieve()
tab_shift.tabpage_line.tv_84.Event pfc_RefreshLevel(1)
ll_tvi = tab_shift.tabpage_line.tv_84.FindItem(RootTreeItem! , 0)
tab_shift.tabpage_line.tv_84.ExpandAll(ll_tvi)

tab_shift.tabpage_line.dw_108.Reset()
tab_shift.tabpage_line.dw_108.Retrieve()
tab_shift.tabpage_line.tv_108.Event pfc_RefreshLevel(1)
ll_tvi = tab_shift.tabpage_line.tv_108.FindItem(RootTreeItem! , 0)
tab_shift.tabpage_line.tv_108.ExpandAll(ll_tvi)

tab_shift.tabpage_line.dw_110.Reset()
tab_shift.tabpage_line.dw_110.Retrieve()
tab_shift.tabpage_line.tv_110.Event pfc_RefreshLevel(1)
ll_tvi = tab_shift.tabpage_line.tv_110.FindItem(RootTreeItem! , 0)
tab_shift.tabpage_line.tv_110.ExpandAll(ll_tvi)

tab_shift.tabpage_details.dw_data.Reset()
tab_shift.tabpage_details.dw_data.DataObject = "d_current_shift_job_coil_cust_report_sim"
tab_shift.tabpage_details.dw_data.SetTransObject(SQLCA)
tab_shift.tabpage_details.dw_data.Retrieve()

RETURN 1
end event

on w_report_shift_status.create
int iCurrent
call super::create
this.tab_shift=create tab_shift
this.st_timer=create st_timer
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_shift
this.Control[iCurrent+2]=this.st_timer
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_retrieve
end on

on w_report_shift_status.destroy
call super::destroy
destroy(this.tab_shift)
destroy(this.st_timer)
destroy(this.cb_close)
destroy(this.cb_retrieve)
end on

event close;call super::close;f_display_app()
end event

event pfc_postopen;call super::pfc_postopen;this.Event ue_populate_data()
Timer(900, this)

end event

event timer;call super::timer;st_timer.Text = "Refreshing"
st_timer.TextColor = RGB(255,0,0)
this.Event ue_populate_data()
st_timer.Text = "This screen refreshs every 15 minutes automatically." 
st_timer.TextColor = RGB(0,0,0)

end event

type tab_shift from tab within w_report_shift_status
integer x = 4
integer y = 6
integer width = 3668
integer height = 1872
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_line tabpage_line
tabpage_details tabpage_details
end type

on tab_shift.create
this.tabpage_line=create tabpage_line
this.tabpage_details=create tabpage_details
this.Control[]={this.tabpage_line,&
this.tabpage_details}
end on

on tab_shift.destroy
destroy(this.tabpage_line)
destroy(this.tabpage_details)
end on

type tabpage_line from userobject within tab_shift
integer x = 15
integer y = 96
integer width = 3639
integer height = 1763
long backcolor = 79741120
string text = "Current Shift per Line"
long tabtextcolor = 33554432
long tabbackcolor = 16776960
long picturemaskcolor = 536870912
tv_84 tv_84
dw_84 dw_84
st_84_3 st_84_3
st_84_1 st_84_1
st_84_2 st_84_2
st_24_1 st_24_1
st_24_2 st_24_2
tv_24 tv_24
st_24_3 st_24_3
dw_24 dw_24
dw_36 dw_36
st_36_3 st_36_3
tv_36 tv_36
st_36_1 st_36_1
st_36_2 st_36_2
st_60_1 st_60_1
st_60_2 st_60_2
tv_60 tv_60
st_60_3 st_60_3
dw_60 dw_60
st_75_1 st_75_1
st_75_2 st_75_2
tv_75 tv_75
st_75_3 st_75_3
dw_75 dw_75
st_108_1 st_108_1
st_108_2 st_108_2
tv_108 tv_108
st_108_3 st_108_3
dw_108 dw_108
st_110_1 st_110_1
st_110_2 st_110_2
tv_110 tv_110
st_110_3 st_110_3
dw_110 dw_110
gb_110 gb_110
gb_84 gb_84
gb_24 gb_24
gb_36 gb_36
gb_75 gb_75
gb_60 gb_60
gb_108 gb_108
end type

on tabpage_line.create
this.tv_84=create tv_84
this.dw_84=create dw_84
this.st_84_3=create st_84_3
this.st_84_1=create st_84_1
this.st_84_2=create st_84_2
this.st_24_1=create st_24_1
this.st_24_2=create st_24_2
this.tv_24=create tv_24
this.st_24_3=create st_24_3
this.dw_24=create dw_24
this.dw_36=create dw_36
this.st_36_3=create st_36_3
this.tv_36=create tv_36
this.st_36_1=create st_36_1
this.st_36_2=create st_36_2
this.st_60_1=create st_60_1
this.st_60_2=create st_60_2
this.tv_60=create tv_60
this.st_60_3=create st_60_3
this.dw_60=create dw_60
this.st_75_1=create st_75_1
this.st_75_2=create st_75_2
this.tv_75=create tv_75
this.st_75_3=create st_75_3
this.dw_75=create dw_75
this.st_108_1=create st_108_1
this.st_108_2=create st_108_2
this.tv_108=create tv_108
this.st_108_3=create st_108_3
this.dw_108=create dw_108
this.st_110_1=create st_110_1
this.st_110_2=create st_110_2
this.tv_110=create tv_110
this.st_110_3=create st_110_3
this.dw_110=create dw_110
this.gb_110=create gb_110
this.gb_84=create gb_84
this.gb_24=create gb_24
this.gb_36=create gb_36
this.gb_75=create gb_75
this.gb_60=create gb_60
this.gb_108=create gb_108
this.Control[]={this.tv_84,&
this.dw_84,&
this.st_84_3,&
this.st_84_1,&
this.st_84_2,&
this.st_24_1,&
this.st_24_2,&
this.tv_24,&
this.st_24_3,&
this.dw_24,&
this.dw_36,&
this.st_36_3,&
this.tv_36,&
this.st_36_1,&
this.st_36_2,&
this.st_60_1,&
this.st_60_2,&
this.tv_60,&
this.st_60_3,&
this.dw_60,&
this.st_75_1,&
this.st_75_2,&
this.tv_75,&
this.st_75_3,&
this.dw_75,&
this.st_108_1,&
this.st_108_2,&
this.tv_108,&
this.st_108_3,&
this.dw_108,&
this.st_110_1,&
this.st_110_2,&
this.tv_110,&
this.st_110_3,&
this.dw_110,&
this.gb_110,&
this.gb_84,&
this.gb_24,&
this.gb_36,&
this.gb_75,&
this.gb_60,&
this.gb_108}
end on

on tabpage_line.destroy
destroy(this.tv_84)
destroy(this.dw_84)
destroy(this.st_84_3)
destroy(this.st_84_1)
destroy(this.st_84_2)
destroy(this.st_24_1)
destroy(this.st_24_2)
destroy(this.tv_24)
destroy(this.st_24_3)
destroy(this.dw_24)
destroy(this.dw_36)
destroy(this.st_36_3)
destroy(this.tv_36)
destroy(this.st_36_1)
destroy(this.st_36_2)
destroy(this.st_60_1)
destroy(this.st_60_2)
destroy(this.tv_60)
destroy(this.st_60_3)
destroy(this.dw_60)
destroy(this.st_75_1)
destroy(this.st_75_2)
destroy(this.tv_75)
destroy(this.st_75_3)
destroy(this.dw_75)
destroy(this.st_108_1)
destroy(this.st_108_2)
destroy(this.tv_108)
destroy(this.st_108_3)
destroy(this.dw_108)
destroy(this.st_110_1)
destroy(this.st_110_2)
destroy(this.tv_110)
destroy(this.st_110_3)
destroy(this.dw_110)
destroy(this.gb_110)
destroy(this.gb_84)
destroy(this.gb_24)
destroy(this.gb_36)
destroy(this.gb_75)
destroy(this.gb_60)
destroy(this.gb_108)
end on

type tv_84 from u_tvs within tabpage_line
integer x = 1050
integer y = 259
integer width = 490
integer height = 1123
integer taborder = 260
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Custom015!","Custom050!","Parameter!","DosEdit5!","Database!","Update!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"shift_name", "", "d_line_current_status_84", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.shift_num", "d_shift_jobs", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.1.ab_job_num", "d_shift_job_coils", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		OpenWithParm(w_daily_prod_coil_detail_display, ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		OpenWithParm(w_daily_prod_job_detail_display, ll_job)
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type dw_84 from u_dw within tabpage_line
integer x = 1050
integer y = 1456
integer width = 497
integer height = 285
integer taborder = 300
boolean enabled = false
string dataobject = "d_line_current_status_84"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)


end event

event rbuttondown;//disabled
Return 0
end event

event rbuttonup;//disabled
Return 0
end event

type st_84_3 from u_st within tabpage_line
integer x = 1053
integer y = 1392
integer width = 402
integer height = 58
integer textsize = -7
string facename = "Arial"
string text = "Currently Running:"
end type

type st_84_1 from u_st within tabpage_line
integer x = 1053
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_84_2 from u_st within tabpage_line
integer x = 1053
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_24_1 from u_st within tabpage_line
integer x = 3127
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_24_2 from u_st within tabpage_line
integer x = 3127
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type tv_24 from u_tvs within tabpage_line
integer x = 3127
integer y = 259
integer width = 490
integer height = 1123
integer taborder = 290
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Custom015!","Custom050!","Parameter!","DosEdit5!","Database!","Update!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"shift_name", "", "d_line_current_status_24", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.shift_num", "d_shift_jobs", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.1.ab_job_num", "d_shift_job_coils", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		OpenWithParm(w_daily_prod_coil_detail_display, ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		OpenWithParm(w_daily_prod_job_detail_display, ll_job)
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type st_24_3 from u_st within tabpage_line
integer x = 3123
integer y = 1392
integer width = 402
integer height = 58
integer textsize = -7
string facename = "Arial"
string text = "Currently Running:"
end type

type dw_24 from u_dw within tabpage_line
integer x = 3123
integer y = 1456
integer width = 497
integer height = 285
integer taborder = 290
boolean enabled = false
string dataobject = "d_line_current_status_24"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

type dw_36 from u_dw within tabpage_line
integer x = 2611
integer y = 1456
integer width = 497
integer height = 285
integer taborder = 280
boolean enabled = false
string dataobject = "d_line_current_status_36"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

type st_36_3 from u_st within tabpage_line
integer x = 2619
integer y = 1392
integer width = 402
integer height = 58
integer textsize = -7
string facename = "Arial"
string text = "Currently Running:"
end type

type tv_36 from u_tvs within tabpage_line
integer x = 2611
integer y = 259
integer width = 490
integer height = 1123
integer taborder = 280
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Custom015!","Custom050!","Parameter!","DosEdit5!","Database!","Update!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"shift_name", "", "d_line_current_status_36", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.shift_num", "d_shift_jobs", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.1.ab_job_num", "d_shift_job_coils", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		OpenWithParm(w_daily_prod_coil_detail_display, ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		OpenWithParm(w_daily_prod_job_detail_display, ll_job)
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type st_36_1 from u_st within tabpage_line
integer x = 2611
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_36_2 from u_st within tabpage_line
integer x = 2611
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type st_60_1 from u_st within tabpage_line
integer x = 2092
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_60_2 from u_st within tabpage_line
integer x = 2092
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type tv_60 from u_tvs within tabpage_line
integer x = 2088
integer y = 259
integer width = 490
integer height = 1123
integer taborder = 270
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Custom015!","Custom050!","Parameter!","DosEdit5!","Database!","Update!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"shift_name", "", "d_line_current_status_60", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.shift_num", "d_shift_jobs", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.1.ab_job_num", "d_shift_job_coils", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		OpenWithParm(w_daily_prod_coil_detail_display, ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		OpenWithParm(w_daily_prod_job_detail_display, ll_job)
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type st_60_3 from u_st within tabpage_line
integer x = 2092
integer y = 1392
integer width = 402
integer height = 58
integer textsize = -7
string facename = "Arial"
string text = "Currently Running:"
end type

type dw_60 from u_dw within tabpage_line
integer x = 2088
integer y = 1456
integer width = 497
integer height = 285
integer taborder = 270
boolean enabled = false
string dataobject = "d_line_current_status_60"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

type st_75_1 from u_st within tabpage_line
integer x = 1576
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_75_2 from u_st within tabpage_line
integer x = 1576
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type tv_75 from u_tvs within tabpage_line
integer x = 1569
integer y = 259
integer width = 490
integer height = 1123
integer taborder = 260
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Custom015!","Custom050!","Parameter!","DosEdit5!","Database!","Update!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"shift_name", "", "d_line_current_status_75", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.shift_num", "d_shift_jobs", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.1.ab_job_num", "d_shift_job_coils", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		OpenWithParm(w_daily_prod_coil_detail_display, ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		OpenWithParm(w_daily_prod_job_detail_display, ll_job)
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type st_75_3 from u_st within tabpage_line
integer x = 1573
integer y = 1392
integer width = 402
integer height = 58
integer textsize = -7
string facename = "Arial"
string text = "Currently Running:"
end type

type dw_75 from u_dw within tabpage_line
integer x = 1569
integer y = 1456
integer width = 497
integer height = 285
integer taborder = 260
boolean enabled = false
string dataobject = "d_line_current_status_75"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

type st_108_1 from u_st within tabpage_line
integer x = 534
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_108_2 from u_st within tabpage_line
integer x = 534
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type tv_108 from u_tvs within tabpage_line
integer x = 530
integer y = 259
integer width = 490
integer height = 1123
integer taborder = 250
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Custom015!","Custom050!","Parameter!","DosEdit5!","Database!","Update!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"shift_name", "", "d_line_current_status_108", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.shift_num", "d_shift_jobs", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.1.ab_job_num", "d_shift_job_coils", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		OpenWithParm(w_daily_prod_coil_detail_display, ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		OpenWithParm(w_daily_prod_job_detail_display, ll_job)
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type st_108_3 from u_st within tabpage_line
integer x = 534
integer y = 1392
integer width = 402
integer height = 58
integer textsize = -7
string facename = "Arial"
string text = "Currently Running:"
end type

type dw_108 from u_dw within tabpage_line
integer x = 527
integer y = 1456
integer width = 497
integer height = 285
integer taborder = 250
boolean enabled = false
string dataobject = "d_line_current_status_108"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

type st_110_1 from u_st within tabpage_line
integer x = 15
integer y = 128
integer width = 490
integer height = 67
integer textsize = -7
string facename = "Arial"
string text = ""
alignment alignment = center!
end type

type st_110_2 from u_st within tabpage_line
integer x = 15
integer y = 192
integer width = 490
integer textsize = -7
string facename = "Arial"
string text = ""
end type

type tv_110 from u_tvs within tabpage_line
integer x = 15
integer y = 259
integer width = 490
integer height = 1123
integer taborder = 240
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Custom015!","Custom050!","Parameter!","DosEdit5!","Database!","Update!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"shift_name", "", "d_line_current_status_110", SQLCA, "")
this.inv_levelsource.of_Register(2, "display_t", ":parent.1.shift_num", "d_shift_jobs", SQLCA, "")
this.inv_levelsource.of_Register(3, "display_t",  &
  ":parent.1.ab_job_num", "d_shift_job_coils", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_coil, ll_job, ll_skid
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		ll_coil = lds_datastore.GetItemNumber(ll_row,"coil_abc_num")
		OpenWithParm(w_daily_prod_coil_detail_display, ll_coil)
	CASE 2	//job
 		ll_job = lds_datastore.GetItemNumber(ll_row,"ab_job_num")
		OpenWithParm(w_daily_prod_job_detail_display, ll_job)
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type st_110_3 from u_st within tabpage_line
integer x = 15
integer y = 1392
integer width = 402
integer height = 58
integer textsize = -7
string facename = "Arial"
string text = "Currently Running:"
end type

type dw_110 from u_dw within tabpage_line
integer x = 11
integer y = 1456
integer width = 497
integer height = 285
integer taborder = 240
boolean enabled = false
string dataobject = "d_line_current_status_110"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event rbuttondown;//override
RETURN 1
end event

event rbuttonup;//override
RETURN 1
end event

type gb_110 from u_gb within tabpage_line
integer y = 74
integer width = 519
integer height = 1680
integer taborder = 160
integer weight = 700
string facename = "Arial"
string text = "BL 110"
end type

type gb_84 from u_gb within tabpage_line
integer x = 1039
integer y = 74
integer width = 519
integer height = 1680
integer taborder = 170
integer weight = 700
string facename = "Arial"
long backcolor = 67108864
string text = "BL 84"
end type

type gb_24 from u_gb within tabpage_line
integer x = 3116
integer y = 74
integer width = 519
integer height = 1680
integer taborder = 180
integer weight = 700
string facename = "Arial"
string text = "BL 24"
end type

type gb_36 from u_gb within tabpage_line
integer x = 2597
integer y = 74
integer width = 519
integer height = 1680
integer taborder = 180
integer weight = 700
string facename = "Arial"
string text = "BL 36"
end type

type gb_75 from u_gb within tabpage_line
integer x = 1558
integer y = 74
integer width = 519
integer height = 1680
integer taborder = 180
integer weight = 700
string facename = "Arial"
string text = "BL 78"
end type

type gb_60 from u_gb within tabpage_line
integer x = 2077
integer y = 74
integer width = 519
integer height = 1680
integer taborder = 190
integer weight = 700
string facename = "Arial"
string text = "BL 60"
end type

type gb_108 from u_gb within tabpage_line
integer x = 519
integer y = 74
integer width = 519
integer height = 1680
integer taborder = 170
integer weight = 700
string facename = "Arial"
string text = "BL 108"
end type

type tabpage_details from userobject within tab_shift
integer x = 15
integer y = 96
integer width = 3639
integer height = 1763
long backcolor = 79741120
string text = "Current Job/Coil Details"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
long picturemaskcolor = 536870912
st_11 st_11
st_10 st_10
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_print cb_print
cb_summary cb_summary
cb_details cb_details
dw_data dw_data
end type

on tabpage_details.create
this.st_11=create st_11
this.st_10=create st_10
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_print=create cb_print
this.cb_summary=create cb_summary
this.cb_details=create cb_details
this.dw_data=create dw_data
this.Control[]={this.st_11,&
this.st_10,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_print,&
this.cb_summary,&
this.cb_details,&
this.dw_data}
end on

on tabpage_details.destroy
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_print)
destroy(this.cb_summary)
destroy(this.cb_details)
destroy(this.dw_data)
end on

type st_11 from statictext within tabpage_details
integer x = 2044
integer y = 1629
integer width = 128
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Retry"
boolean focusrectangle = false
end type

type st_10 from statictext within tabpage_details
integer x = 1781
integer y = 1635
integer width = 249
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 67108864
boolean enabled = false
string text = "Rebanded"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_details
integer x = 1573
integer y = 1635
integer width = 194
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 79741120
boolean enabled = false
string text = "InTransit"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_details
integer x = 1382
integer y = 1635
integer width = 176
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "OnHold"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_details
integer x = 1152
integer y = 1635
integer width = 216
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "Rejected"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_details
integer x = 1020
integer y = 1635
integer width = 117
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "New"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_details
integer x = 779
integer y = 1635
integer width = 227
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 79741120
boolean enabled = false
string text = "InProcess"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_details
integer x = 640
integer y = 1635
integer width = 124
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long backcolor = 79741120
boolean enabled = false
string text = "Done"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_details
integer x = 22
integer y = 1635
integer width = 600
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Coil Status Color Indication:"
boolean focusrectangle = false
end type

type cb_print from u_cb within tabpage_details
string tag = "Print current report"
integer x = 3259
integer y = 1651
integer width = 373
integer height = 90
integer taborder = 270
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;tab_shift.tabpage_details.dw_data.Event pfc_print()
end event

type cb_summary from u_cb within tabpage_details
string tag = "Showing summary report"
integer x = 2845
integer y = 1651
integer width = 373
integer height = 90
integer taborder = 260
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Show &Summary"
end type

event clicked;call super::clicked;tab_shift.tabpage_details.dw_data.Reset()
tab_shift.tabpage_details.dw_data.DataObject = "d_current_shift_job_coil_cust_report_sim"
tab_shift.tabpage_details.dw_data.SetTransObject(SQLCA)
tab_shift.tabpage_details.dw_data.Retrieve()

end event

type cb_details from u_cb within tabpage_details
string tag = "Showing detail report"
integer x = 2432
integer y = 1651
integer width = 373
integer height = 90
integer taborder = 250
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Show &Details"
end type

event clicked;call super::clicked;IF MessageBox("Question", "It may takes a long time to generate this report, continue?", Question!, YesNo!, 2) = 2 THEN
	RETURN 0
END IF
tab_shift.tabpage_details.dw_data.Reset()
tab_shift.tabpage_details.dw_data.DataObject = "d_current_shift_job_coil_cust_report"
tab_shift.tabpage_details.dw_data.SetTransObject(SQLCA)
tab_shift.tabpage_details.dw_data.Retrieve()



end event

type dw_data from u_dw within tabpage_details
event ue_specs ( )
event ue_retrieve ( )
event type long ue_fill_data ( )
integer x = 26
integer y = 10
integer width = 3613
integer height = 1619
integer taborder = 240
string dataobject = "d_current_shift_job_coil_cust_report_sim"
boolean livescroll = false
end type

event constructor;of_SetBase(TRUE)
of_SetFilter(TRUE)



end event

event rbuttondown;//disable
Return 0
end event

event rbuttonup;//disable
Return 0
end event

type st_timer from statictext within w_report_shift_status
integer x = 2531
integer y = 1888
integer width = 1130
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "This screen refreshs every 15 minutes automatically."
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_report_shift_status
string tag = "Exit"
integer x = 2158
integer y = 1901
integer width = 322
integer height = 99
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_retrieve from u_cb within w_report_shift_status
integer x = 1017
integer y = 1901
integer width = 307
integer height = 99
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Refresh"
end type

event clicked;RETURN parent.Event ue_populate_data()
end event

