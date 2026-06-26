$PBExportHeader$w_daily_prod_schedule_reports.srw
$PBExportComments$<Response> schedule reports based on line
forward
global type w_daily_prod_schedule_reports from w_response
end type
type gb_line from u_gb within w_daily_prod_schedule_reports
end type
type cb_close from u_cb within w_daily_prod_schedule_reports
end type
type st_title1 from statictext within w_daily_prod_schedule_reports
end type
type rb_ss from u_rb within w_daily_prod_schedule_reports
end type
type em_ss_start from u_em within w_daily_prod_schedule_reports
end type
type p_ss_start from picture within w_daily_prod_schedule_reports
end type
type st_4 from statictext within w_daily_prod_schedule_reports
end type
type em_ss_end from u_em within w_daily_prod_schedule_reports
end type
type p_ss_end from picture within w_daily_prod_schedule_reports
end type
type cb_show from u_cb within w_daily_prod_schedule_reports
end type
type ddlb_line from dropdownlistbox within w_daily_prod_schedule_reports
end type
type dw_line from u_dw within w_daily_prod_schedule_reports
end type
end forward

global type w_daily_prod_schedule_reports from w_response
integer x = 819
integer y = 291
integer width = 1792
integer height = 675
string title = "Shift schedule reports"
long backcolor = 80269524
event type integer ue_reset ( )
gb_line gb_line
cb_close cb_close
st_title1 st_title1
rb_ss rb_ss
em_ss_start em_ss_start
p_ss_start p_ss_start
st_4 st_4
em_ss_end em_ss_end
p_ss_end p_ss_end
cb_show cb_show
ddlb_line ddlb_line
dw_line dw_line
end type
global w_daily_prod_schedule_reports w_daily_prod_schedule_reports

type variables
s_new_daily_prod_info istr_q
Long il_line
String is_line
end variables

on w_daily_prod_schedule_reports.create
int iCurrent
call super::create
this.gb_line=create gb_line
this.cb_close=create cb_close
this.st_title1=create st_title1
this.rb_ss=create rb_ss
this.em_ss_start=create em_ss_start
this.p_ss_start=create p_ss_start
this.st_4=create st_4
this.em_ss_end=create em_ss_end
this.p_ss_end=create p_ss_end
this.cb_show=create cb_show
this.ddlb_line=create ddlb_line
this.dw_line=create dw_line
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_line
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.st_title1
this.Control[iCurrent+4]=this.rb_ss
this.Control[iCurrent+5]=this.em_ss_start
this.Control[iCurrent+6]=this.p_ss_start
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.em_ss_end
this.Control[iCurrent+9]=this.p_ss_end
this.Control[iCurrent+10]=this.cb_show
this.Control[iCurrent+11]=this.ddlb_line
this.Control[iCurrent+12]=this.dw_line
end on

on w_daily_prod_schedule_reports.destroy
call super::destroy
destroy(this.gb_line)
destroy(this.cb_close)
destroy(this.st_title1)
destroy(this.rb_ss)
destroy(this.em_ss_start)
destroy(this.p_ss_start)
destroy(this.st_4)
destroy(this.em_ss_end)
destroy(this.p_ss_end)
destroy(this.cb_show)
destroy(this.ddlb_line)
destroy(this.dw_line)
end on

event open;call super::open;Long ll_row, ll_i
ll_row = dw_line.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_line.AddItem(dw_line.GetItemString(ll_i, "line_desc"))
	NEXT
END IF

il_line = 0
is_line = ""

end event

type gb_line from u_gb within w_daily_prod_schedule_reports
integer x = 59
integer y = 48
integer width = 1649
integer height = 336
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = ""
end type

type cb_close from u_cb within w_daily_prod_schedule_reports
integer x = 1028
integer y = 445
integer width = 351
integer height = 90
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;CLOSE(Parent)
end event

type st_title1 from statictext within w_daily_prod_schedule_reports
integer x = 117
integer y = 112
integer width = 501
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "Production line:"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_ss from u_rb within w_daily_prod_schedule_reports
integer x = 139
integer y = 230
integer width = 505
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Shift schedule from"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_ss_start.enabled = TRUE
	em_ss_end.enabled = TRUE
END IF
RETURN 1
end event

type em_ss_start from u_em within w_daily_prod_schedule_reports
integer x = 651
integer y = 230
integer width = 289
integer height = 70
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type p_ss_start from picture within w_daily_prod_schedule_reports
integer x = 944
integer y = 230
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_ss_start.Enabled THEN
	Open(w_calendar)
	em_ss_start.Text = Message.StringParm
END IF
end event

type st_4 from statictext within w_daily_prod_schedule_reports
integer x = 1009
integer y = 234
integer width = 88
integer height = 70
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
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_ss_end from u_em within w_daily_prod_schedule_reports
integer x = 1093
integer y = 230
integer width = 289
integer height = 70
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type p_ss_end from picture within w_daily_prod_schedule_reports
integer x = 1386
integer y = 230
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_ss_end.Enabled THEN
	Open(w_calendar)
	em_ss_end.Text = Message.StringParm
END IF
end event

type cb_show from u_cb within w_daily_prod_schedule_reports
integer x = 347
integer y = 445
integer width = 351
integer height = 93
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Show"
end type

event clicked;SetPointer(HourGlass!)

If rb_ss.Checked Then 
	IF il_line = 0 THEN
		MessageBox("Warning", "Please select one prioduction line first.")
		RETURN -1
	END IF			
	istr_q.line_id = il_line
	istr_q.line_desc = is_line
	istr_q.start_date = date(em_ss_start.Text)
	istr_q.end_date = date(em_ss_end.Text)
	IF DaysAfter(istr_q.start_date, istr_q.end_date) < 0 THEN
		MessageBox("Warning", "Invalid ending date.")
		RETURN -1
	END IF	
	Openwithparm(w_daily_prod_report_shift_schedule, istr_q)
	Return 1
END IF


end event

type ddlb_line from dropdownlistbox within w_daily_prod_schedule_reports
integer x = 585
integer y = 99
integer width = 486
integer height = 362
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Long ll_row, ll_i

is_line = Text(index)
ll_row = dw_line.RowCount()
	FOR ll_i = 1 TO ll_row
		IF dw_line.GetItemString(ll_i, "line_desc") = is_line THEN
				dw_line.Event RowFocusChanged(ll_i)
				dw_line.SelectRow(0, False)
				dw_line.SelectRow(ll_i, True)
				il_line = dw_line.GetItemNumber(ll_i, "line_num")
		END IF
	NEXT
	

end event

type dw_line from u_dw within w_daily_prod_schedule_reports
boolean visible = false
integer x = 1126
integer y = 118
integer height = 35
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_daily_prod_line_info"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
Retrieve()

end event

