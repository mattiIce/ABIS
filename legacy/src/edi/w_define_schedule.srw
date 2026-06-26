$PBExportHeader$w_define_schedule.srw
forward
global type w_define_schedule from w_response
end type
type cb_1 from u_cb within w_define_schedule
end type
type cb_2 from u_cb within w_define_schedule
end type
type cb_3 from u_cb within w_define_schedule
end type
type cb_4 from u_cb within w_define_schedule
end type
type cbx_mon from u_cbx within w_define_schedule
end type
type cbx_tues from u_cbx within w_define_schedule
end type
type cbx_wed from u_cbx within w_define_schedule
end type
type cbx_thur from u_cbx within w_define_schedule
end type
type cbx_sat from u_cbx within w_define_schedule
end type
type cbx_sun from u_cbx within w_define_schedule
end type
type cbx_fri from u_cbx within w_define_schedule
end type
type gb_5 from u_gb within w_define_schedule
end type
type gb_4 from u_gb within w_define_schedule
end type
type cbx_jan from u_cbx within w_define_schedule
end type
type cbx_feb from u_cbx within w_define_schedule
end type
type cbx_mar from u_cbx within w_define_schedule
end type
type cbx_apr from u_cbx within w_define_schedule
end type
type cbx_may from u_cbx within w_define_schedule
end type
type cbx_jun from u_cbx within w_define_schedule
end type
type cbx_jul from u_cbx within w_define_schedule
end type
type cbx_aug from u_cbx within w_define_schedule
end type
type cbx_sep from u_cbx within w_define_schedule
end type
type cbx_oct from u_cbx within w_define_schedule
end type
type cbx_nov from u_cbx within w_define_schedule
end type
type cbx_dec from u_cbx within w_define_schedule
end type
type em_time from u_em within w_define_schedule
end type
type cb_6 from u_cb within w_define_schedule
end type
type cb_7 from u_cb within w_define_schedule
end type
type cb_8 from u_cb within w_define_schedule
end type
type gb_1 from u_gb within w_define_schedule
end type
type rb_1 from u_rb within w_define_schedule
end type
type rb_2 from u_rb within w_define_schedule
end type
type rb_3 from u_rb within w_define_schedule
end type
type sle_1 from u_sle within w_define_schedule
end type
type dw_schedule_list_name from u_dw within w_define_schedule
end type
type dw_list from u_dw within w_define_schedule
end type
type gb_3 from u_gb within w_define_schedule
end type
type gb_2 from u_gb within w_define_schedule
end type
type cb_close from u_cb within w_define_schedule
end type
end forward

global type w_define_schedule from w_response
int X=257
int Y=391
int Width=2319
int Height=1236
boolean TitleBar=true
string Title="Schedule "
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cbx_mon cbx_mon
cbx_tues cbx_tues
cbx_wed cbx_wed
cbx_thur cbx_thur
cbx_sat cbx_sat
cbx_sun cbx_sun
cbx_fri cbx_fri
gb_5 gb_5
gb_4 gb_4
cbx_jan cbx_jan
cbx_feb cbx_feb
cbx_mar cbx_mar
cbx_apr cbx_apr
cbx_may cbx_may
cbx_jun cbx_jun
cbx_jul cbx_jul
cbx_aug cbx_aug
cbx_sep cbx_sep
cbx_oct cbx_oct
cbx_nov cbx_nov
cbx_dec cbx_dec
em_time em_time
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
sle_1 sle_1
dw_schedule_list_name dw_schedule_list_name
dw_list dw_list
gb_3 gb_3
gb_2 gb_2
cb_close cb_close
end type
global w_define_schedule w_define_schedule

on w_define_schedule.create
int iCurrent
call w_response::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cbx_mon=create cbx_mon
this.cbx_tues=create cbx_tues
this.cbx_wed=create cbx_wed
this.cbx_thur=create cbx_thur
this.cbx_sat=create cbx_sat
this.cbx_sun=create cbx_sun
this.cbx_fri=create cbx_fri
this.gb_5=create gb_5
this.gb_4=create gb_4
this.cbx_jan=create cbx_jan
this.cbx_feb=create cbx_feb
this.cbx_mar=create cbx_mar
this.cbx_apr=create cbx_apr
this.cbx_may=create cbx_may
this.cbx_jun=create cbx_jun
this.cbx_jul=create cbx_jul
this.cbx_aug=create cbx_aug
this.cbx_sep=create cbx_sep
this.cbx_oct=create cbx_oct
this.cbx_nov=create cbx_nov
this.cbx_dec=create cbx_dec
this.em_time=create em_time
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.sle_1=create sle_1
this.dw_schedule_list_name=create dw_schedule_list_name
this.dw_list=create dw_list
this.gb_3=create gb_3
this.gb_2=create gb_2
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_1
this.Control[iCurrent+2]=cb_2
this.Control[iCurrent+3]=cb_3
this.Control[iCurrent+4]=cb_4
this.Control[iCurrent+5]=cbx_mon
this.Control[iCurrent+6]=cbx_tues
this.Control[iCurrent+7]=cbx_wed
this.Control[iCurrent+8]=cbx_thur
this.Control[iCurrent+9]=cbx_sat
this.Control[iCurrent+10]=cbx_sun
this.Control[iCurrent+11]=cbx_fri
this.Control[iCurrent+12]=gb_5
this.Control[iCurrent+13]=gb_4
this.Control[iCurrent+14]=cbx_jan
this.Control[iCurrent+15]=cbx_feb
this.Control[iCurrent+16]=cbx_mar
this.Control[iCurrent+17]=cbx_apr
this.Control[iCurrent+18]=cbx_may
this.Control[iCurrent+19]=cbx_jun
this.Control[iCurrent+20]=cbx_jul
this.Control[iCurrent+21]=cbx_aug
this.Control[iCurrent+22]=cbx_sep
this.Control[iCurrent+23]=cbx_oct
this.Control[iCurrent+24]=cbx_nov
this.Control[iCurrent+25]=cbx_dec
this.Control[iCurrent+26]=em_time
this.Control[iCurrent+27]=cb_6
this.Control[iCurrent+28]=cb_7
this.Control[iCurrent+29]=cb_8
this.Control[iCurrent+30]=gb_1
this.Control[iCurrent+31]=rb_1
this.Control[iCurrent+32]=rb_2
this.Control[iCurrent+33]=rb_3
this.Control[iCurrent+34]=sle_1
this.Control[iCurrent+35]=dw_schedule_list_name
this.Control[iCurrent+36]=dw_list
this.Control[iCurrent+37]=gb_3
this.Control[iCurrent+38]=gb_2
this.Control[iCurrent+39]=cb_close
end on

on w_define_schedule.destroy
call w_response::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cbx_mon)
destroy(this.cbx_tues)
destroy(this.cbx_wed)
destroy(this.cbx_thur)
destroy(this.cbx_sat)
destroy(this.cbx_sun)
destroy(this.cbx_fri)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.cbx_jan)
destroy(this.cbx_feb)
destroy(this.cbx_mar)
destroy(this.cbx_apr)
destroy(this.cbx_may)
destroy(this.cbx_jun)
destroy(this.cbx_jul)
destroy(this.cbx_aug)
destroy(this.cbx_sep)
destroy(this.cbx_oct)
destroy(this.cbx_nov)
destroy(this.cbx_dec)
destroy(this.em_time)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.sle_1)
destroy(this.dw_schedule_list_name)
destroy(this.dw_list)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.cb_close)
end on

type cb_1 from u_cb within w_define_schedule
int X=43
int Y=903
int Width=342
int TabOrder=160
string Text="Add"
int Weight=700
end type

type cb_2 from u_cb within w_define_schedule
int X=1352
int Y=794
int Width=221
int Height=68
int TabOrder=150
boolean BringToTop=true
string Text="Hour +"
end type

type cb_3 from u_cb within w_define_schedule
int X=36
int Y=1012
int Width=342
int TabOrder=140
boolean BringToTop=true
string Text="Apply"
int Weight=700
end type

type cb_4 from u_cb within w_define_schedule
int X=395
int Y=903
int Width=342
int TabOrder=130
boolean BringToTop=true
string Text="Delete"
int Weight=700
end type

type cbx_mon from u_cbx within w_define_schedule
int X=1387
int Y=311
int Width=285
string Text="1 Monday"
boolean Checked=true
end type

type cbx_tues from u_cbx within w_define_schedule
int X=1387
int Y=385
int Width=303
boolean BringToTop=true
string Text="2 Tuesday"
boolean Checked=true
end type

type cbx_wed from u_cbx within w_define_schedule
int X=1387
int Y=465
int Width=374
boolean BringToTop=true
string Text="3 Wednesday"
boolean Checked=true
end type

type cbx_thur from u_cbx within w_define_schedule
int X=1387
int Y=538
int Width=313
boolean BringToTop=true
string Text="4 Thursday"
boolean Checked=true
end type

type cbx_sat from u_cbx within w_define_schedule
int X=1921
int Y=388
int Width=328
boolean BringToTop=true
string Text="6 Saturday"
boolean Checked=true
end type

type cbx_sun from u_cbx within w_define_schedule
int X=1921
int Y=461
int Width=274
boolean BringToTop=true
string Text="7 Sunday"
end type

type cbx_fri from u_cbx within w_define_schedule
int X=1921
int Y=314
int Width=246
boolean BringToTop=true
string Text="5 Friday"
boolean Checked=true
end type

type gb_5 from u_gb within w_define_schedule
int X=783
int Y=33
int Width=498
int Height=1069
int TabOrder=110
string Text="Month of the Year"
int Weight=700
end type

type gb_4 from u_gb within w_define_schedule
int X=1313
int Y=234
int Width=946
int Height=397
int TabOrder=120
string Text="Days of  Week"
int Weight=700
end type

type cbx_jan from u_cbx within w_define_schedule
int X=822
int Y=106
int Width=360
boolean BringToTop=true
string Text="1 January"
boolean Checked=true
end type

type cbx_feb from u_cbx within w_define_schedule
int X=822
int Y=193
int Width=303
boolean BringToTop=true
string Text="2 February"
boolean Checked=true
end type

type cbx_mar from u_cbx within w_define_schedule
int X=822
int Y=273
int Width=242
boolean BringToTop=true
string Text="3 March"
boolean Checked=true
end type

type cbx_apr from u_cbx within w_define_schedule
int X=822
int Y=356
boolean BringToTop=true
string Text="4 April"
boolean Checked=true
end type

type cbx_may from u_cbx within w_define_schedule
int X=822
int Y=439
boolean BringToTop=true
string Text="5 May"
boolean Checked=true
end type

type cbx_jun from u_cbx within w_define_schedule
int X=822
int Y=522
boolean BringToTop=true
string Text="6 June"
boolean Checked=true
end type

type cbx_jul from u_cbx within w_define_schedule
int X=822
int Y=605
boolean BringToTop=true
string Text="7 July"
boolean Checked=true
end type

type cbx_aug from u_cbx within w_define_schedule
int X=822
int Y=692
int Width=257
boolean BringToTop=true
string Text="8 August"
boolean Checked=true
end type

type cbx_sep from u_cbx within w_define_schedule
int X=822
int Y=772
int Width=349
boolean BringToTop=true
string Text="9 September"
boolean Checked=true
end type

type cbx_oct from u_cbx within w_define_schedule
int X=822
int Y=855
int Width=306
boolean BringToTop=true
string Text="10 October"
boolean Checked=true
end type

type cbx_nov from u_cbx within w_define_schedule
int X=822
int Y=938
int Width=363
boolean BringToTop=true
string Text="11 November"
boolean Checked=true
end type

type cbx_dec from u_cbx within w_define_schedule
int X=822
int Y=1021
int Width=363
boolean BringToTop=true
string Text="12 December"
boolean Checked=true
end type

type em_time from u_em within w_define_schedule
int X=1593
int Y=794
int Width=335
int Height=151
int TabOrder=90
string Mask="hh:mm"
MaskDataType MaskDataType=TimeMask!
string DisplayData=""
double Increment=0
string MinMax=""
boolean DisplayOnly=true
long TextColor=65280
long BackColor=33554432
int TextSize=-18
int Weight=700
end type

type cb_6 from u_cb within w_define_schedule
int X=1352
int Y=877
int Width=221
int Height=68
int TabOrder=80
boolean BringToTop=true
string Text="Hour -"
end type

type cb_7 from u_cb within w_define_schedule
int X=1953
int Y=794
int Width=221
int Height=68
int TabOrder=70
boolean BringToTop=true
string Text="Minute +"
end type

type cb_8 from u_cb within w_define_schedule
int X=1953
int Y=874
int Width=221
int Height=68
int TabOrder=60
boolean BringToTop=true
string Text="Minute -"
end type

type gb_1 from u_gb within w_define_schedule
int X=1313
int Y=705
int Width=953
int Height=388
int TabOrder=100
string Text="Scheduled Time"
int Weight=700
end type

type rb_1 from u_rb within w_define_schedule
int X=1398
int Y=989
int Width=264
boolean BringToTop=true
string Text="24 hour"
boolean Checked=true
end type

type rb_2 from u_rb within w_define_schedule
int X=1704
int Y=986
int Width=257
boolean BringToTop=true
string Text="AM"
end type

type rb_3 from u_rb within w_define_schedule
int X=1985
int Y=986
int Width=189
boolean BringToTop=true
string Text="PM"
end type

type sle_1 from u_sle within w_define_schedule
int X=1362
int Y=90
int Width=825
int TabOrder=40
string Text="*"
int Weight=700
end type

type dw_schedule_list_name from u_dw within w_define_schedule
int X=72
int Y=97
int Width=616
int Height=721
int TabOrder=20
string DataObject="d_schedule_list_name"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

type dw_list from u_dw within w_define_schedule
int X=1995
int Y=605
int Width=249
int Height=161
int TabOrder=10
boolean Visible=false
string DataObject="d_schedule_list"
end type

type gb_3 from u_gb within w_define_schedule
int X=43
int Y=33
int Width=687
int Height=829
int TabOrder=30
string Text="Schedule Name"
int Weight=700
end type

type gb_2 from u_gb within w_define_schedule
int X=1309
int Y=26
int Width=943
int Height=167
int TabOrder=50
string Text="Day of the Month"
int Weight=700
end type

type cb_close from u_cb within w_define_schedule
int X=395
int Y=1012
int Width=342
int TabOrder=141
boolean BringToTop=true
string Text="Close"
int Weight=700
end type

event clicked;call super::clicked;close(parent)
end event

