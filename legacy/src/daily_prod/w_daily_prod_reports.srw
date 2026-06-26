$PBExportHeader$w_daily_prod_reports.srw
$PBExportComments$<Response> daily production reports based on line
forward
global type w_daily_prod_reports from w_response
end type
type gb_line from u_gb within w_daily_prod_reports
end type
type cb_show from u_cb within w_daily_prod_reports
end type
type cb_close from u_cb within w_daily_prod_reports
end type
type rb_dtpw from u_rb within w_daily_prod_reports
end type
type em_dtpw_start from u_em within w_daily_prod_reports
end type
type em_dtpw_end from u_em within w_daily_prod_reports
end type
type st_1 from statictext within w_daily_prod_reports
end type
type rb_dtpwps from u_rb within w_daily_prod_reports
end type
type em_dtpwps_start from u_em within w_daily_prod_reports
end type
type em_dtpwps_end from u_em within w_daily_prod_reports
end type
type st_2 from statictext within w_daily_prod_reports
end type
type rb_alph from u_rb within w_daily_prod_reports
end type
type em_alph_start from u_em within w_daily_prod_reports
end type
type st_3 from statictext within w_daily_prod_reports
end type
type em_alph_end from u_em within w_daily_prod_reports
end type
type rb_ds from u_rb within w_daily_prod_reports
end type
type rb_dpr from u_rb within w_daily_prod_reports
end type
type rb_dptpwpl from u_rb within w_daily_prod_reports
end type
type st_title1 from statictext within w_daily_prod_reports
end type
type st_title2 from statictext within w_daily_prod_reports
end type
type p_dtpw_end from picture within w_daily_prod_reports
end type
type p_dtpw_start from picture within w_daily_prod_reports
end type
type p_dtpwps_start from picture within w_daily_prod_reports
end type
type p_dtpwps_end from picture within w_daily_prod_reports
end type
type p_alph_start from picture within w_daily_prod_reports
end type
type p_alph_end from picture within w_daily_prod_reports
end type
type rb_msr from u_rb within w_daily_prod_reports
end type
type rb_ysrfal from u_rb within w_daily_prod_reports
end type
type st_title3 from statictext within w_daily_prod_reports
end type
type rb_walph from u_rb within w_daily_prod_reports
end type
type em_walph_start from u_em within w_daily_prod_reports
end type
type p_walph_start from picture within w_daily_prod_reports
end type
end forward

global type w_daily_prod_reports from w_response
integer x = 819
integer y = 291
integer width = 1792
integer height = 1562
string title = "Shift reports"
long backcolor = 80269524
event type integer ue_reset ( )
gb_line gb_line
cb_show cb_show
cb_close cb_close
rb_dtpw rb_dtpw
em_dtpw_start em_dtpw_start
em_dtpw_end em_dtpw_end
st_1 st_1
rb_dtpwps rb_dtpwps
em_dtpwps_start em_dtpwps_start
em_dtpwps_end em_dtpwps_end
st_2 st_2
rb_alph rb_alph
em_alph_start em_alph_start
st_3 st_3
em_alph_end em_alph_end
rb_ds rb_ds
rb_dpr rb_dpr
rb_dptpwpl rb_dptpwpl
st_title1 st_title1
st_title2 st_title2
p_dtpw_end p_dtpw_end
p_dtpw_start p_dtpw_start
p_dtpwps_start p_dtpwps_start
p_dtpwps_end p_dtpwps_end
p_alph_start p_alph_start
p_alph_end p_alph_end
rb_msr rb_msr
rb_ysrfal rb_ysrfal
st_title3 st_title3
rb_walph rb_walph
em_walph_start em_walph_start
p_walph_start p_walph_start
end type
global w_daily_prod_reports w_daily_prod_reports

type variables
s_new_daily_prod_info istr_q
end variables

event ue_reset;em_dtpw_start.enabled = FALSE
em_dtpw_end.enabled = FALSE
em_dtpwps_start.enabled = FALSE
em_dtpwps_end.enabled = FALSE
em_alph_start.enabled = FALSE
em_alph_end.enabled = FALSE
em_walph_start.enabled = FALSE

RETURN 1

end event

on w_daily_prod_reports.create
int iCurrent
call super::create
this.gb_line=create gb_line
this.cb_show=create cb_show
this.cb_close=create cb_close
this.rb_dtpw=create rb_dtpw
this.em_dtpw_start=create em_dtpw_start
this.em_dtpw_end=create em_dtpw_end
this.st_1=create st_1
this.rb_dtpwps=create rb_dtpwps
this.em_dtpwps_start=create em_dtpwps_start
this.em_dtpwps_end=create em_dtpwps_end
this.st_2=create st_2
this.rb_alph=create rb_alph
this.em_alph_start=create em_alph_start
this.st_3=create st_3
this.em_alph_end=create em_alph_end
this.rb_ds=create rb_ds
this.rb_dpr=create rb_dpr
this.rb_dptpwpl=create rb_dptpwpl
this.st_title1=create st_title1
this.st_title2=create st_title2
this.p_dtpw_end=create p_dtpw_end
this.p_dtpw_start=create p_dtpw_start
this.p_dtpwps_start=create p_dtpwps_start
this.p_dtpwps_end=create p_dtpwps_end
this.p_alph_start=create p_alph_start
this.p_alph_end=create p_alph_end
this.rb_msr=create rb_msr
this.rb_ysrfal=create rb_ysrfal
this.st_title3=create st_title3
this.rb_walph=create rb_walph
this.em_walph_start=create em_walph_start
this.p_walph_start=create p_walph_start
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_line
this.Control[iCurrent+2]=this.cb_show
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.rb_dtpw
this.Control[iCurrent+5]=this.em_dtpw_start
this.Control[iCurrent+6]=this.em_dtpw_end
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.rb_dtpwps
this.Control[iCurrent+9]=this.em_dtpwps_start
this.Control[iCurrent+10]=this.em_dtpwps_end
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.rb_alph
this.Control[iCurrent+13]=this.em_alph_start
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.em_alph_end
this.Control[iCurrent+16]=this.rb_ds
this.Control[iCurrent+17]=this.rb_dpr
this.Control[iCurrent+18]=this.rb_dptpwpl
this.Control[iCurrent+19]=this.st_title1
this.Control[iCurrent+20]=this.st_title2
this.Control[iCurrent+21]=this.p_dtpw_end
this.Control[iCurrent+22]=this.p_dtpw_start
this.Control[iCurrent+23]=this.p_dtpwps_start
this.Control[iCurrent+24]=this.p_dtpwps_end
this.Control[iCurrent+25]=this.p_alph_start
this.Control[iCurrent+26]=this.p_alph_end
this.Control[iCurrent+27]=this.rb_msr
this.Control[iCurrent+28]=this.rb_ysrfal
this.Control[iCurrent+29]=this.st_title3
this.Control[iCurrent+30]=this.rb_walph
this.Control[iCurrent+31]=this.em_walph_start
this.Control[iCurrent+32]=this.p_walph_start
end on

on w_daily_prod_reports.destroy
call super::destroy
destroy(this.gb_line)
destroy(this.cb_show)
destroy(this.cb_close)
destroy(this.rb_dtpw)
destroy(this.em_dtpw_start)
destroy(this.em_dtpw_end)
destroy(this.st_1)
destroy(this.rb_dtpwps)
destroy(this.em_dtpwps_start)
destroy(this.em_dtpwps_end)
destroy(this.st_2)
destroy(this.rb_alph)
destroy(this.em_alph_start)
destroy(this.st_3)
destroy(this.em_alph_end)
destroy(this.rb_ds)
destroy(this.rb_dpr)
destroy(this.rb_dptpwpl)
destroy(this.st_title1)
destroy(this.st_title2)
destroy(this.p_dtpw_end)
destroy(this.p_dtpw_start)
destroy(this.p_dtpwps_start)
destroy(this.p_dtpwps_end)
destroy(this.p_alph_start)
destroy(this.p_alph_end)
destroy(this.rb_msr)
destroy(this.rb_ysrfal)
destroy(this.st_title3)
destroy(this.rb_walph)
destroy(this.em_walph_start)
destroy(this.p_walph_start)
end on

event open;call super::open;String ls_month, ls_year
istr_q = Message.PowerObjectParm

st_title2.TEXT = "Daily summary reports " + String(istr_q.Prod_date)
st_title3.TEXT = "Misc. reports - year" + String(Year(istr_q.Prod_date))

IF istr_q.line_id > 0 THEN
	st_title1.Text = istr_q.line_desc
	em_dtpw_start.Text = String(istr_q.Prod_date)
	em_dtpw_end.Text = String(istr_q.Prod_date)
	em_dtpwps_start.Text = String(istr_q.Prod_date)
	em_dtpwps_end.Text = String(istr_q.Prod_date)
	em_alph_start.Text = String(istr_q.Prod_date)
	em_alph_end.Text = String(istr_q.Prod_date)
	em_walph_start.Text = String(istr_q.Prod_date)
	CHOOSE CASE istr_q.schedule_type
		CASE 1
			rb_ds.Text = "Shift summary - " + String(istr_q.Prod_date) + " 1st Shift:"
		CASE 2
			rb_ds.Text = "Shift summary - " +String(istr_q.Prod_date) + " 2nd Shift:"
		CASE 3
			rb_ds.Text = "Shift summary - " +String(istr_q.Prod_date) + " 3rd Shift:"
		CASE ELSE
			rb_ds.Text = "Shift summary - " +String(istr_q.Prod_date) + " ___ Shift:"
	END CHOOSE	
	CHOOSE CASE Month(istr_q.Prod_date )
		CASE 1
			ls_month = 'Jan'
		CASE 2
			ls_month = 'Feb'
		CASE 3
			ls_month = 'Mar'
		CASE 4
			ls_month = 'Apr'
		CASE 5
			ls_month = 'May'
		CASE 6
			ls_month = 'Jun'
		CASE 7
			ls_month = 'Jul'
		CASE 8
			ls_month = 'Aug'
		CASE 9
			ls_month = 'Sep'
		CASE 10
			ls_month = 'Oct'
		CASE 11
			ls_month = 'Nov'
		CASE 12
			ls_month = 'Dec'
	END CHOOSE
	ls_year = String(Year(istr_q.Prod_date))
	rb_msr.Text = "Monthly summary - " + ls_month + '/' + ls_year
ELSE
	rb_dtpw.Enabled = FALSE
	rb_dtpwps.Enabled = FALSE
	rb_alph.Enabled = FALSE
	rb_ds.Enabled = FALSE
	rb_msr.Enabled = FALSE
	rb_walph.Enabled = FALSE
END IF


end event

type gb_line from u_gb within w_daily_prod_reports
integer x = 59
integer y = 48
integer width = 1649
integer height = 1274
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = ""
end type

type cb_show from u_cb within w_daily_prod_reports
integer x = 380
integer y = 1334
integer width = 351
integer height = 93
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Show"
end type

event clicked;SetPointer(HourGlass!)

If rb_dtpw.Checked Then 
	istr_q.start_date = date(em_dtpw_start.Text)
	istr_q.end_date = date(em_dtpw_end.Text)
	IF DaysAfter(istr_q.start_date, istr_q.end_date) < 0 THEN
		MessageBox("Warning", "Invalid ending date.")
		RETURN -1
	END IF	
	Openwithparm(w_daily_prod_report_dtpw, istr_q)
	Return 1
END IF

If rb_alph.Checked Then 
	istr_q.start_date = date(em_alph_start.Text)
	istr_q.end_date = date(em_alph_end.Text)
	IF DaysAfter(istr_q.start_date, istr_q.end_date) < 0 THEN
		MessageBox("Warning", "Invalid ending date.")
		RETURN -1
	END IF	
	Openwithparm(w_daily_prod_report_alph, istr_q)
	Return 1
END IF

If rb_dtpwps.Checked Then 
	istr_q.start_date = date(em_dtpwps_start.Text)
	istr_q.end_date = date(em_dtpwps_end.Text)
	IF DaysAfter(istr_q.start_date, istr_q.end_date) < 0 THEN
		MessageBox("Warning", "Invalid ending date.")
		RETURN -1
	END IF	
	Openwithparm(w_daily_prod_report_dtpwps, istr_q)
	Return 1
END IF

If rb_ds.Checked Then 
	Openwithparm(w_daily_prod_report_ds, istr_q)
	Return 1
END IF

If rb_dpr.Checked Then 
	OpenwithParm(w_daily_prod_report_summary, String(istr_q.prod_date))
	RETURN 1
END IF

IF rb_dptpwpl.Checked THEN
	OpenwithParm(w_daily_prod_report_general, String(istr_q.prod_date))
	RETURN 1
END IF

IF rb_msr.Checked THEN
	OpenwithParm(w_daily_prod_report_msr, istr_q)
	RETURN 1
END IF

IF rb_ysrfal.Checked THEN
	//OpenwithParm(w_daily_prod_report_ysrfal, istr_q)
	RETURN 1
END IF

If rb_walph.Checked Then 
	istr_q.start_date = date(em_walph_start.Text)
	Openwithparm(w_daily_prod_report_weekly_alph, istr_q)
	Return 1
END IF




end event

type cb_close from u_cb within w_daily_prod_reports
integer x = 1061
integer y = 1334
integer width = 351
integer height = 90
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;CLOSE(Parent)
end event

type rb_dtpw from u_rb within w_daily_prod_reports
integer x = 132
integer y = 538
integer width = 538
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Daily processed WT "
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_dtpw_start.enabled = TRUE
	em_dtpw_end.enabled = TRUE
END IF
RETURN 1
end event

type em_dtpw_start from u_em within w_daily_prod_reports
integer x = 647
integer y = 534
integer width = 289
integer height = 70
integer taborder = 70
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

type em_dtpw_end from u_em within w_daily_prod_reports
integer x = 1090
integer y = 534
integer width = 289
integer height = 70
integer taborder = 60
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

type st_1 from statictext within w_daily_prod_reports
integer x = 998
integer y = 534
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

type rb_dtpwps from u_rb within w_daily_prod_reports
integer x = 132
integer y = 365
integer width = 629
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Daily shift processed WT"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_dtpwps_start.enabled = TRUE
	em_dtpwps_end.enabled = TRUE
end if
RETURN 1
end event

type em_dtpwps_start from u_em within w_daily_prod_reports
integer x = 750
integer y = 362
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

type em_dtpwps_end from u_em within w_daily_prod_reports
integer x = 1192
integer y = 362
integer width = 289
integer height = 70
integer taborder = 50
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

type st_2 from statictext within w_daily_prod_reports
integer x = 1112
integer y = 362
integer width = 84
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

type rb_alph from u_rb within w_daily_prod_reports
integer x = 132
integer y = 451
integer width = 662
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Daily average LBs per hour"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_alph_start.enabled = TRUE
	em_alph_end.enabled = TRUE
end if
RETURN 1
end event

type em_alph_start from u_em within w_daily_prod_reports
integer x = 786
integer y = 448
integer width = 289
integer height = 70
integer taborder = 30
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

type st_3 from statictext within w_daily_prod_reports
integer x = 1148
integer y = 448
integer width = 95
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

type em_alph_end from u_em within w_daily_prod_reports
integer x = 1240
integer y = 448
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

type rb_ds from u_rb within w_daily_prod_reports
integer x = 132
integer y = 189
integer width = 1083
integer height = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Shift summary  -  Shift / Date"
end type

event clicked;Parent.Event ue_reset()
RETURN 1
end event

type rb_dpr from u_rb within w_daily_prod_reports
integer x = 128
integer y = 906
integer width = 731
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Daily Production report."
end type

type rb_dptpwpl from u_rb within w_daily_prod_reports
integer x = 128
integer y = 989
integer width = 965
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
boolean enabled = false
string text = "Daily production processed WT per line."
end type

type st_title1 from statictext within w_daily_prod_reports
integer x = 124
integer y = 112
integer width = 1521
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
string text = "Production line"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_title2 from statictext within w_daily_prod_reports
integer x = 132
integer y = 752
integer width = 1521
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
string text = "Daily summary reports"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_dtpw_end from picture within w_daily_prod_reports
integer x = 1379
integer y = 538
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_dtpw_end.Enabled THEN
	Open(w_calendar)
	em_dtpw_end.Text = Message.StringParm
END IF
end event

type p_dtpw_start from picture within w_daily_prod_reports
integer x = 940
integer y = 538
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_dtpw_start.Enabled THEN
	Open(w_calendar)
	em_dtpw_start.Text = Message.StringParm
END IF
end event

type p_dtpwps_start from picture within w_daily_prod_reports
integer x = 1042
integer y = 362
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_dtpwps_start.Enabled THEN
	Open(w_calendar)
	em_dtpwps_start.Text = Message.StringParm
END IF
end event

type p_dtpwps_end from picture within w_daily_prod_reports
integer x = 1485
integer y = 362
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_dtpwps_end.Enabled THEN
	Open(w_calendar)
	em_dtpwps_end.Text = Message.StringParm
END IF
end event

type p_alph_start from picture within w_daily_prod_reports
integer x = 1075
integer y = 451
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_alph_start.Enabled THEN
	Open(w_calendar)
	em_alph_start.Text = Message.StringParm
END IF
end event

type p_alph_end from picture within w_daily_prod_reports
integer x = 1529
integer y = 451
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_alph_end.Enabled THEN
	Open(w_calendar)
	em_alph_end.Text = Message.StringParm
END IF
end event

type rb_msr from u_rb within w_daily_prod_reports
integer x = 132
integer y = 826
integer width = 764
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Monthly summary  -  Month/Year"
end type

type rb_ysrfal from u_rb within w_daily_prod_reports
integer x = 128
integer y = 1181
integer width = 965
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
boolean enabled = false
string text = "Yearly summary report for all lines."
end type

type st_title3 from statictext within w_daily_prod_reports
integer x = 132
integer y = 1094
integer width = 1521
integer height = 86
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
string text = "Misc. reports"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_walph from u_rb within w_daily_prod_reports
integer x = 132
integer y = 278
integer width = 903
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Weekly average LBs per hour. Starting"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_walph_start.enabled = TRUE
end if
RETURN 1
end event

type em_walph_start from u_em within w_daily_prod_reports
integer x = 1020
integer y = 278
integer width = 289
integer height = 70
integer taborder = 90
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

type p_walph_start from picture within w_daily_prod_reports
integer x = 1317
integer y = 278
integer width = 66
integer height = 48
boolean bringtotop = true
boolean originalsize = true
string picturename = "calendar.jpg"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;IF em_walph_start.Enabled THEN
	Open(w_calendar)
	em_walph_start.Text = Message.StringParm
END IF
end event

