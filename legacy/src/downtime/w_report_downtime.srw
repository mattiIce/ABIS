$PBExportHeader$w_report_downtime.srw
$PBExportComments$down time report tools
forward
global type w_report_downtime from w_sheet
end type
type gb_main from u_gb within w_report_downtime
end type
type cb_retrieve from u_cb within w_report_downtime
end type
type cb_close from u_cb within w_report_downtime
end type
type cb_reset from u_cb within w_report_downtime
end type
type ddlb_line from u_ddlb within w_report_downtime
end type
type st_1 from u_st within w_report_downtime
end type
type rb_job from radiobutton within w_report_downtime
end type
type rb_jobs from radiobutton within w_report_downtime
end type
type rb_daily from radiobutton within w_report_downtime
end type
type rb_month from radiobutton within w_report_downtime
end type
type rb_year from radiobutton within w_report_downtime
end type
type rb_instance from radiobutton within w_report_downtime
end type
type rb_instancestarting from radiobutton within w_report_downtime
end type
type rb_day from radiobutton within w_report_downtime
end type
type rb_shift from radiobutton within w_report_downtime
end type
type rb_operator from radiobutton within w_report_downtime
end type
type rb_coil from radiobutton within w_report_downtime
end type
type rb_customer from radiobutton within w_report_downtime
end type
type em_job from u_em within w_report_downtime
end type
type st_3 from statictext within w_report_downtime
end type
type st_4 from statictext within w_report_downtime
end type
type em_jobss from u_em within w_report_downtime
end type
type em_jobse from u_em within w_report_downtime
end type
type em_day from u_em within w_report_downtime
end type
type em_dailys from u_em within w_report_downtime
end type
type st_2 from statictext within w_report_downtime
end type
type em_dailye from u_em within w_report_downtime
end type
type em_iss from u_em within w_report_downtime
end type
type em_ise from u_em within w_report_downtime
end type
type em_issf from u_em within w_report_downtime
end type
type ddlb_monthly from u_ddlb within w_report_downtime
end type
type ddlb_yearly from u_ddlb within w_report_downtime
end type
type p_1 from picture within w_report_downtime
end type
type p_2 from picture within w_report_downtime
end type
type p_3 from picture within w_report_downtime
end type
type p_4 from picture within w_report_downtime
end type
type p_5 from picture within w_report_downtime
end type
type p_6 from picture within w_report_downtime
end type
type p_7 from picture within w_report_downtime
end type
type p_8 from picture within w_report_downtime
end type
type rb_comjob from radiobutton within w_report_downtime
end type
type st_5 from statictext within w_report_downtime
end type
type em_comjoba from u_em within w_report_downtime
end type
type em_comjobb from u_em within w_report_downtime
end type
type rb_cat_daily from radiobutton within w_report_downtime
end type
type st_6 from statictext within w_report_downtime
end type
type em_cat_daily_to from u_em within w_report_downtime
end type
type em_cat_daily_from from u_em within w_report_downtime
end type
type st_7 from statictext within w_report_downtime
end type
type ddlb_cat_daily from u_ddlb within w_report_downtime
end type
type p_9 from picture within w_report_downtime
end type
type p_10 from picture within w_report_downtime
end type
type st_8 from statictext within w_report_downtime
end type
type st_9 from statictext within w_report_downtime
end type
type em_issm from u_em within w_report_downtime
end type
type ddlb_shift from u_ddlb within w_report_downtime
end type
type st_10 from statictext within w_report_downtime
end type
type em_shiftdate from u_em within w_report_downtime
end type
type cbx_d_shift from u_cbx within w_report_downtime
end type
type cbx_c_shift from u_cbx within w_report_downtime
end type
type p_11 from picture within w_report_downtime
end type
type rb_partid from radiobutton within w_report_downtime
end type
type em_partid from u_em within w_report_downtime
end type
type p_12 from picture within w_report_downtime
end type
type dw_line from u_dw within w_report_downtime
end type
end forward

global type w_report_downtime from w_sheet
string tag = "downtime report"
integer x = 44
integer y = 61
integer width = 2776
integer height = 1725
string title = "ABCO Production downtime report"
boolean maxbox = false
boolean resizable = false
long backcolor = 80269524
event type string ue_whoami ( )
event type integer ue_retrieve ( )
event type integer ue_reset ( )
gb_main gb_main
cb_retrieve cb_retrieve
cb_close cb_close
cb_reset cb_reset
ddlb_line ddlb_line
st_1 st_1
rb_job rb_job
rb_jobs rb_jobs
rb_daily rb_daily
rb_month rb_month
rb_year rb_year
rb_instance rb_instance
rb_instancestarting rb_instancestarting
rb_day rb_day
rb_shift rb_shift
rb_operator rb_operator
rb_coil rb_coil
rb_customer rb_customer
em_job em_job
st_3 st_3
st_4 st_4
em_jobss em_jobss
em_jobse em_jobse
em_day em_day
em_dailys em_dailys
st_2 st_2
em_dailye em_dailye
em_iss em_iss
em_ise em_ise
em_issf em_issf
ddlb_monthly ddlb_monthly
ddlb_yearly ddlb_yearly
p_1 p_1
p_2 p_2
p_3 p_3
p_4 p_4
p_5 p_5
p_6 p_6
p_7 p_7
p_8 p_8
rb_comjob rb_comjob
st_5 st_5
em_comjoba em_comjoba
em_comjobb em_comjobb
rb_cat_daily rb_cat_daily
st_6 st_6
em_cat_daily_to em_cat_daily_to
em_cat_daily_from em_cat_daily_from
st_7 st_7
ddlb_cat_daily ddlb_cat_daily
p_9 p_9
p_10 p_10
st_8 st_8
st_9 st_9
em_issm em_issm
ddlb_shift ddlb_shift
st_10 st_10
em_shiftdate em_shiftdate
cbx_d_shift cbx_d_shift
cbx_c_shift cbx_c_shift
p_11 p_11
rb_partid rb_partid
em_partid em_partid
p_12 p_12
dw_line dw_line
end type
global w_report_downtime w_report_downtime

type variables
Long il_line
String is_line
end variables

event ue_whoami;RETURN "w_report_downtime"
end event

event ue_retrieve;s_downtime_info s_info

//Reports not based on line ID.

If rb_job.Checked Then 
	//verify em_job.text
	Openwithparm(w_downtime_detail_per_job, Long(em_job.text))
	Return 1
END IF

If rb_jobs.Checked Then 
	//verify em_jobs.text
	s_info.ab_start_job = date(em_jobss.Text)
	s_info.ab_end_job = date(em_jobse.Text)
	Openwithparm(w_downtime_detail_jobs, s_info)
	Return 1
END IF

If rb_comjob.Checked Then 
	//verify em_jobs.text
	s_info.comjob_a = Long(em_comjoba.Text)
	s_info.comjob_b = Long(em_comjobb.Text)
	Openwithparm(w_downtime_detail_comjobs, s_info)
	Return 1
END IF

If rb_partid.Checked Then 
	//verify em_partid.text
	s_info.part_num = em_partid.Text
	s_info.line_id = il_line
	s_info.line_desc = is_line
	Openwithparm(w_downtime_detail_partid, s_info)
	Return 1
END IF

//Reports based on line ID

IF il_line = 0 THEN
	MessageBox("Warning", "Please select a production line.")
	RETURN 0
END IF

If rb_day.Checked Then 
	//verify em_day.text
	s_info.day = date(em_day.Text)
	s_info.line_id = il_line
	s_info.line_desc = is_line
	Openwithparm(w_downtime_detail_day, s_info)
	Return 1
END IF

If rb_daily.Checked Then 
	//verify em_daily.text
	s_info.daily_from = date(em_dailys.Text)
	s_info.daily_to = date(em_dailye.Text)
	s_info.line_id = il_line
	s_info.line_desc = is_line
	Openwithparm(w_downtime_detail_daily, s_info)
	Return 1
END IF

If rb_month.Checked Then 
	s_info.line_id = il_line
	s_info.line_desc = is_line
	OpenwithParm(w_downtime_detail_monthly, s_info)
	Return 1
END IF

If rb_year.Checked Then 
	s_info.line_id = il_line
	s_info.line_desc = is_line
	OpenwithParm(w_downtime_detail_yearly, s_info)
	Return 1
END IF

If rb_instance.Checked Then 
	s_info.instance_from = f_datetime(em_iss.text)
	s_info.instance_to = f_datetime(em_ise.text)
	s_info.line_id = il_line
	s_info.line_desc = is_line
	OpenwithParm(w_downtime_detail_instance1, s_info)
	Return 1
END IF

If rb_instancestarting.Checked Then 
	//verify em_issm.text
	s_info.instance_starting = f_datetime(em_issf.text)
	s_info.issm = Integer(em_issm.text)
	s_info.line_id = il_line
	s_info.line_desc = is_line
	OpenwithParm(w_downtime_detail_instance2, s_info)
	Return 1
END IF

If rb_cat_daily.Checked Then 
	//verify em_daily.text
	s_info.daily_from = date(em_cat_daily_from.Text)
	s_info.daily_to = date(em_cat_daily_to.Text)
	s_info.dt_source = ddlb_cat_daily.Text
	s_info.line_id = il_line
	s_info.line_desc = is_line
	Openwithparm(w_downtime_detail_daily_per_cat, s_info)
	Return 1
END IF

If rb_shift.Checked Then 
	//verify em_daily.text
	s_info.daily_from = date(em_shiftdate.Text)
	s_info.shift_name = ddlb_shift.Text
	s_info.line_id = il_line
	s_info.line_desc = is_line
	IF cbx_d_shift.Checked Then 
		Openwithparm(w_downtime_detail_shift, s_info)
		Return 1
	END IF
	IF cbx_c_shift.Checked Then 
		Openwithparm(w_downtime_shift_downtime_prod_ratio, s_info)
		Return 1
	END IF	
END IF

RETURN 0
end event

event ue_reset;em_job.Enabled = FALSE
em_jobss.Enabled = FALSE
em_jobse.Enabled = FALSE
em_day.Enabled = FALSE
em_dailys.Enabled = FALSE
em_dailye.Enabled = FALSE
ddlb_monthly.Enabled = FALSE
ddlb_yearly.Enabled = FALSE
em_iss.Enabled = FALSE
em_ise.Enabled = FALSE
em_issf.Enabled = FALSE
em_cat_daily_from.Enabled = FALSE
em_cat_daily_to.Enabled = FALSE
ddlb_cat_daily.Enabled = FALSE
em_comjoba.Enabled = FALSE
em_comjobb.Enabled = FALSE
em_issm.Enabled = FALSE
em_shiftdate.enabled = FALSE
ddlb_shift.Enabled = FALSE
cbx_d_shift.Enabled = FALSE
cbx_c_shift.Enabled = FALSE
em_partid.Enabled = FALSE

RETURN 1
end event

on w_report_downtime.create
int iCurrent
call super::create
this.gb_main=create gb_main
this.cb_retrieve=create cb_retrieve
this.cb_close=create cb_close
this.cb_reset=create cb_reset
this.ddlb_line=create ddlb_line
this.st_1=create st_1
this.rb_job=create rb_job
this.rb_jobs=create rb_jobs
this.rb_daily=create rb_daily
this.rb_month=create rb_month
this.rb_year=create rb_year
this.rb_instance=create rb_instance
this.rb_instancestarting=create rb_instancestarting
this.rb_day=create rb_day
this.rb_shift=create rb_shift
this.rb_operator=create rb_operator
this.rb_coil=create rb_coil
this.rb_customer=create rb_customer
this.em_job=create em_job
this.st_3=create st_3
this.st_4=create st_4
this.em_jobss=create em_jobss
this.em_jobse=create em_jobse
this.em_day=create em_day
this.em_dailys=create em_dailys
this.st_2=create st_2
this.em_dailye=create em_dailye
this.em_iss=create em_iss
this.em_ise=create em_ise
this.em_issf=create em_issf
this.ddlb_monthly=create ddlb_monthly
this.ddlb_yearly=create ddlb_yearly
this.p_1=create p_1
this.p_2=create p_2
this.p_3=create p_3
this.p_4=create p_4
this.p_5=create p_5
this.p_6=create p_6
this.p_7=create p_7
this.p_8=create p_8
this.rb_comjob=create rb_comjob
this.st_5=create st_5
this.em_comjoba=create em_comjoba
this.em_comjobb=create em_comjobb
this.rb_cat_daily=create rb_cat_daily
this.st_6=create st_6
this.em_cat_daily_to=create em_cat_daily_to
this.em_cat_daily_from=create em_cat_daily_from
this.st_7=create st_7
this.ddlb_cat_daily=create ddlb_cat_daily
this.p_9=create p_9
this.p_10=create p_10
this.st_8=create st_8
this.st_9=create st_9
this.em_issm=create em_issm
this.ddlb_shift=create ddlb_shift
this.st_10=create st_10
this.em_shiftdate=create em_shiftdate
this.cbx_d_shift=create cbx_d_shift
this.cbx_c_shift=create cbx_c_shift
this.p_11=create p_11
this.rb_partid=create rb_partid
this.em_partid=create em_partid
this.p_12=create p_12
this.dw_line=create dw_line
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_main
this.Control[iCurrent+2]=this.cb_retrieve
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_reset
this.Control[iCurrent+5]=this.ddlb_line
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rb_job
this.Control[iCurrent+8]=this.rb_jobs
this.Control[iCurrent+9]=this.rb_daily
this.Control[iCurrent+10]=this.rb_month
this.Control[iCurrent+11]=this.rb_year
this.Control[iCurrent+12]=this.rb_instance
this.Control[iCurrent+13]=this.rb_instancestarting
this.Control[iCurrent+14]=this.rb_day
this.Control[iCurrent+15]=this.rb_shift
this.Control[iCurrent+16]=this.rb_operator
this.Control[iCurrent+17]=this.rb_coil
this.Control[iCurrent+18]=this.rb_customer
this.Control[iCurrent+19]=this.em_job
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.st_4
this.Control[iCurrent+22]=this.em_jobss
this.Control[iCurrent+23]=this.em_jobse
this.Control[iCurrent+24]=this.em_day
this.Control[iCurrent+25]=this.em_dailys
this.Control[iCurrent+26]=this.st_2
this.Control[iCurrent+27]=this.em_dailye
this.Control[iCurrent+28]=this.em_iss
this.Control[iCurrent+29]=this.em_ise
this.Control[iCurrent+30]=this.em_issf
this.Control[iCurrent+31]=this.ddlb_monthly
this.Control[iCurrent+32]=this.ddlb_yearly
this.Control[iCurrent+33]=this.p_1
this.Control[iCurrent+34]=this.p_2
this.Control[iCurrent+35]=this.p_3
this.Control[iCurrent+36]=this.p_4
this.Control[iCurrent+37]=this.p_5
this.Control[iCurrent+38]=this.p_6
this.Control[iCurrent+39]=this.p_7
this.Control[iCurrent+40]=this.p_8
this.Control[iCurrent+41]=this.rb_comjob
this.Control[iCurrent+42]=this.st_5
this.Control[iCurrent+43]=this.em_comjoba
this.Control[iCurrent+44]=this.em_comjobb
this.Control[iCurrent+45]=this.rb_cat_daily
this.Control[iCurrent+46]=this.st_6
this.Control[iCurrent+47]=this.em_cat_daily_to
this.Control[iCurrent+48]=this.em_cat_daily_from
this.Control[iCurrent+49]=this.st_7
this.Control[iCurrent+50]=this.ddlb_cat_daily
this.Control[iCurrent+51]=this.p_9
this.Control[iCurrent+52]=this.p_10
this.Control[iCurrent+53]=this.st_8
this.Control[iCurrent+54]=this.st_9
this.Control[iCurrent+55]=this.em_issm
this.Control[iCurrent+56]=this.ddlb_shift
this.Control[iCurrent+57]=this.st_10
this.Control[iCurrent+58]=this.em_shiftdate
this.Control[iCurrent+59]=this.cbx_d_shift
this.Control[iCurrent+60]=this.cbx_c_shift
this.Control[iCurrent+61]=this.p_11
this.Control[iCurrent+62]=this.rb_partid
this.Control[iCurrent+63]=this.em_partid
this.Control[iCurrent+64]=this.p_12
this.Control[iCurrent+65]=this.dw_line
end on

on w_report_downtime.destroy
call super::destroy
destroy(this.gb_main)
destroy(this.cb_retrieve)
destroy(this.cb_close)
destroy(this.cb_reset)
destroy(this.ddlb_line)
destroy(this.st_1)
destroy(this.rb_job)
destroy(this.rb_jobs)
destroy(this.rb_daily)
destroy(this.rb_month)
destroy(this.rb_year)
destroy(this.rb_instance)
destroy(this.rb_instancestarting)
destroy(this.rb_day)
destroy(this.rb_shift)
destroy(this.rb_operator)
destroy(this.rb_coil)
destroy(this.rb_customer)
destroy(this.em_job)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_jobss)
destroy(this.em_jobse)
destroy(this.em_day)
destroy(this.em_dailys)
destroy(this.st_2)
destroy(this.em_dailye)
destroy(this.em_iss)
destroy(this.em_ise)
destroy(this.em_issf)
destroy(this.ddlb_monthly)
destroy(this.ddlb_yearly)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.p_4)
destroy(this.p_5)
destroy(this.p_6)
destroy(this.p_7)
destroy(this.p_8)
destroy(this.rb_comjob)
destroy(this.st_5)
destroy(this.em_comjoba)
destroy(this.em_comjobb)
destroy(this.rb_cat_daily)
destroy(this.st_6)
destroy(this.em_cat_daily_to)
destroy(this.em_cat_daily_from)
destroy(this.st_7)
destroy(this.ddlb_cat_daily)
destroy(this.p_9)
destroy(this.p_10)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.em_issm)
destroy(this.ddlb_shift)
destroy(this.st_10)
destroy(this.em_shiftdate)
destroy(this.cbx_d_shift)
destroy(this.cbx_c_shift)
destroy(this.p_11)
destroy(this.rb_partid)
destroy(this.em_partid)
destroy(this.p_12)
destroy(this.dw_line)
end on

event close;call super::close;Close(this)
f_display_app()
end event

event open;call super::open;IF f_security_door("Downtime report") < 0 THEN
	Close(this)
	RETURN 0
END IF

Long ll_row, ll_i
ll_row = dw_line.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_line.AddItem(dw_line.GetItemString(ll_i, "line_desc"))
	NEXT
END IF

il_line = 0
is_line = ""


end event

type gb_main from u_gb within w_report_downtime
string tag = "downtime report"
integer x = 33
integer y = 118
integer width = 2315
integer height = 1498
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Based on following category:"
end type

type cb_retrieve from u_cb within w_report_downtime
integer x = 2373
integer y = 160
integer width = 351
integer height = 93
integer taborder = 250
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;Return Parent.Event ue_retrieve()
end event

type cb_close from u_cb within w_report_downtime
integer x = 2373
integer y = 458
integer width = 351
integer height = 93
integer taborder = 240
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Return Parent.Event Close()
end event

type cb_reset from u_cb within w_report_downtime
integer x = 2373
integer y = 310
integer width = 351
integer height = 93
integer taborder = 230
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Re&set"
end type

event clicked;Return Parent.Event ue_reset()
end event

type ddlb_line from u_ddlb within w_report_downtime
integer x = 852
integer y = 19
integer width = 344
integer height = 678
integer taborder = 220
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean sorted = false
integer limit = 8
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

type st_1 from u_st within w_report_downtime
integer x = 55
integer y = 29
integer width = 764
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Downtime report for line #"
end type

type rb_job from radiobutton within w_report_downtime
integer x = 179
integer y = 234
integer width = 549
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Production Order"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then em_job.enabled = TRUE
end event

type rb_jobs from radiobutton within w_report_downtime
integer x = 187
integer y = 419
integer width = 1163
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Production orders by date starting from "
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_jobss.enabled = TRUE
	em_jobse.Enabled = TRUE
END IF
end event

type rb_daily from radiobutton within w_report_downtime
integer x = 187
integer y = 605
integer width = 362
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Daily from"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_dailys.enabled = TRUE
	em_dailye.enabled = TRUE
END IF
end event

type rb_month from radiobutton within w_report_downtime
integer x = 187
integer y = 698
integer width = 293
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Monthly"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then ddlb_monthly.enabled = TRUE
end event

type rb_year from radiobutton within w_report_downtime
integer x = 187
integer y = 790
integer width = 260
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Yearly"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then ddlb_yearly.enabled = TRUE
end event

type rb_instance from radiobutton within w_report_downtime
integer x = 187
integer y = 883
integer width = 453
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Instance from"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_iss.enabled = TRUE
	em_ise.enabled = TRUE
END If
end event

type rb_instancestarting from radiobutton within w_report_downtime
integer x = 187
integer y = 973
integer width = 666
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Instance starting from"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_issf.enabled = TRUE
	em_issm.enabled = TRUE
End If
end event

type rb_day from radiobutton within w_report_downtime
integer x = 187
integer y = 512
integer width = 223
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Day"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then em_day.enabled = TRUE
end event

type rb_shift from radiobutton within w_report_downtime
integer x = 187
integer y = 1152
integer width = 340
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Based on"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_shiftdate.enabled = TRUE
	ddlb_shift.Enabled = TRUE
	cbx_d_shift.Enabled = TRUE
	cbx_c_shift.Enabled = TRUE
	cbx_d_shift.Checked = TRUE
END IF
end event

type rb_operator from radiobutton within w_report_downtime
integer x = 187
integer y = 1331
integer width = 322
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "Operator"
end type

type rb_coil from radiobutton within w_report_downtime
integer x = 187
integer y = 1421
integer width = 238
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "Coil"
end type

type rb_customer from radiobutton within w_report_downtime
integer x = 187
integer y = 1510
integer width = 344
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "Customer"
end type

type em_job from u_em within w_report_downtime
integer x = 768
integer y = 230
integer width = 366
integer taborder = 210
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string mask = "########"
double increment = 0
string minmax = ""
end type

type st_3 from statictext within w_report_downtime
integer x = 1686
integer y = 419
integer width = 95
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_report_downtime
integer x = 1214
integer y = 883
integer width = 95
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_jobss from u_em within w_report_downtime
integer x = 1353
integer y = 416
integer width = 325
integer taborder = 200
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(Today(),"mm/dd/yyyy")
end event

type em_jobse from u_em within w_report_downtime
integer x = 1777
integer y = 416
integer width = 325
integer taborder = 190
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;This.Text =String(Today(), 'mm/dd/yyyy')
end event

type em_day from u_em within w_report_downtime
integer x = 399
integer y = 509
integer width = 325
integer taborder = 180
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(Today(),"mm/dd/yyyy")
end event

type em_dailys from u_em within w_report_downtime
integer x = 596
integer y = 602
integer width = 325
integer taborder = 170
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(Today(),"mm/dd/yyyy")
end event

type st_2 from statictext within w_report_downtime
integer x = 936
integer y = 605
integer width = 95
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_dailye from u_em within w_report_downtime
integer x = 1028
integer y = 602
integer width = 325
integer taborder = 160
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(Today(),"mm/dd/yyyy")
end event

type em_iss from u_em within w_report_downtime
integer x = 655
integer y = 880
integer width = 556
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy hh:mm:ss"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(DateTime(Today(), Now()))
end event

type em_ise from u_em within w_report_downtime
integer x = 1309
integer y = 880
integer width = 556
integer taborder = 140
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy hh:mm:ss"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(DateTime(Today(), Now()))
end event

type em_issf from u_em within w_report_downtime
integer x = 859
integer y = 973
integer width = 556
integer taborder = 130
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy hh:mm:ss"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(DateTime(Today(), Now()))
end event

type ddlb_monthly from u_ddlb within w_report_downtime
integer x = 512
integer y = 698
integer width = 344
integer height = 250
integer taborder = 120
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
string item[] = {"2004","2005","2006"}
end type

type ddlb_yearly from u_ddlb within w_report_downtime
integer x = 512
integer y = 790
integer width = 344
integer height = 250
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
string item[] = {"2004","2005","2006"}
end type

type p_1 from picture within w_report_downtime
integer x = 80
integer y = 237
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p2.jpg"
boolean focusrectangle = false
end type

type p_2 from picture within w_report_downtime
integer x = 80
integer y = 422
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p1.jpg"
boolean focusrectangle = false
end type

type p_3 from picture within w_report_downtime
integer x = 80
integer y = 515
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p2.jpg"
boolean focusrectangle = false
end type

type p_4 from picture within w_report_downtime
integer x = 80
integer y = 608
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p1.jpg"
boolean focusrectangle = false
end type

type p_5 from picture within w_report_downtime
integer x = 80
integer y = 701
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p1.jpg"
boolean focusrectangle = false
end type

type p_6 from picture within w_report_downtime
integer x = 80
integer y = 794
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p1.jpg"
boolean focusrectangle = false
end type

type p_7 from picture within w_report_downtime
integer x = 80
integer y = 886
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p3.jpg"
boolean focusrectangle = false
end type

type p_8 from picture within w_report_downtime
integer x = 80
integer y = 979
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p3.jpg"
boolean focusrectangle = false
end type

type rb_comjob from radiobutton within w_report_downtime
integer x = 179
integer y = 326
integer width = 794
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Compare production order"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_comjoba.enabled = TRUE
	em_comjobb.enabled = TRUE
END IF
end event

type st_5 from statictext within w_report_downtime
integer x = 1349
integer y = 326
integer width = 113
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "and"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_comjoba from u_em within w_report_downtime
integer x = 976
integer y = 323
integer width = 366
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string mask = "########"
double increment = 0
string minmax = ""
end type

type em_comjobb from u_em within w_report_downtime
integer x = 1474
integer y = 323
integer width = 366
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string mask = "########"
double increment = 0
string minmax = ""
end type

type rb_cat_daily from radiobutton within w_report_downtime
integer x = 187
integer y = 1062
integer width = 567
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Daily downtime by "
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_cat_daily_from.enabled = TRUE
	em_cat_daily_to.Enabled = TRUE
	ddlb_cat_daily.Enabled = TRUE
END IF
end event

type st_6 from statictext within w_report_downtime
integer x = 1807
integer y = 1072
integer width = 84
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cat_daily_to from u_em within w_report_downtime
integer x = 1883
integer y = 1069
integer width = 322
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(Today(),"mm/dd/yyyy")
end event

type em_cat_daily_from from u_em within w_report_downtime
integer x = 1488
integer y = 1069
integer width = 325
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;This.Text = String(Today(),"mm/dd/yyyy")
end event

type st_7 from statictext within w_report_downtime
integer x = 1353
integer y = 1072
integer width = 135
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "from"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_cat_daily from u_ddlb within w_report_downtime
integer x = 757
integer y = 1069
integer width = 603
integer height = 250
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
string item[] = {"MAINTENANCE","QUALITY","BREAK","MISCELLANEOUS"}
end type

type p_9 from picture within w_report_downtime
integer x = 80
integer y = 330
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p1.jpg"
boolean focusrectangle = false
end type

type p_10 from picture within w_report_downtime
integer x = 80
integer y = 1069
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p1.jpg"
boolean focusrectangle = false
end type

type st_8 from statictext within w_report_downtime
integer x = 1430
integer y = 976
integer width = 165
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "every "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_report_downtime
integer x = 1792
integer y = 976
integer width = 263
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "minute(s)"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_issm from u_em within w_report_downtime
string tag = "minutes"
integer x = 1602
integer y = 973
integer width = 165
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
string mask = "##"
double increment = 0
string minmax = ""
end type

type ddlb_shift from u_ddlb within w_report_downtime
integer x = 534
integer y = 1158
integer width = 344
integer height = 250
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
boolean enabled = false
string item[] = {"1ST","2ND","3RD"}
end type

type st_10 from statictext within w_report_downtime
integer x = 881
integer y = 1152
integer width = 190
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "shift at"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_shiftdate from u_em within w_report_downtime
integer x = 1079
integer y = 1149
integer width = 325
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

type cbx_d_shift from u_cbx within w_report_downtime
integer x = 1426
integer y = 1158
integer width = 395
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Downtime only"
end type

event clicked;IF This.checked THEN cbx_c_shift.Checked = FALSE
end event

type cbx_c_shift from u_cbx within w_report_downtime
integer x = 1810
integer y = 1158
integer width = 516
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 80269524
string text = "Downtime/Production"
end type

event clicked;IF This.checked THEN cbx_d_shift.Checked = FALSE
end event

type p_11 from picture within w_report_downtime
integer x = 80
integer y = 1158
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p2.jpg"
boolean focusrectangle = false
end type

type rb_partid from radiobutton within w_report_downtime
integer x = 187
integer y = 1242
integer width = 647
integer height = 77
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Enduser part number"
end type

event clicked;Parent.Event ue_reset()
If this.Enabled Then 
	em_partid.enabled = TRUE
END IF
end event

type em_partid from u_em within w_report_downtime
integer x = 845
integer y = 1238
integer width = 984
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
maskdatatype maskdatatype = stringmask!
string mask = ""
double increment = 0
string minmax = ""
end type

type p_12 from picture within w_report_downtime
integer x = 80
integer y = 1245
integer width = 91
integer height = 70
boolean bringtotop = true
boolean enabled = false
string picturename = "dt_p2.jpg"
boolean focusrectangle = false
end type

type dw_line from u_dw within w_report_downtime
boolean visible = false
integer x = 1276
integer y = 35
integer width = 172
integer height = 45
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dowmtime_line_info"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)
Retrieve()

end event

