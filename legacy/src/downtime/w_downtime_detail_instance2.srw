$PBExportHeader$w_downtime_detail_instance2.srw
$PBExportComments$<Child> display downtime details based each instance
forward
global type w_downtime_detail_instance2 from w_child
end type
type dw_report from u_dw within w_downtime_detail_instance2
end type
type cb_close from u_cb within w_downtime_detail_instance2
end type
type cb_print from u_cb within w_downtime_detail_instance2
end type
type cb_email from u_cb within w_downtime_detail_instance2
end type
type cb_save from u_cb within w_downtime_detail_instance2
end type
type cb_previous from u_cb within w_downtime_detail_instance2
end type
type cb_next from u_cb within w_downtime_detail_instance2
end type
end forward

global type w_downtime_detail_instance2 from w_child
int X=395
int Y=278
int Width=3354
int Height=1696
WindowType WindowType=response!
boolean TitleBar=true
string Title="Downtime details based  on each instance"
string Tag="detail downtime information based on instance"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_report dw_report
cb_close cb_close
cb_print cb_print
cb_email cb_email
cb_save cb_save
cb_previous cb_previous
cb_next cb_next
end type
global w_downtime_detail_instance2 w_downtime_detail_instance2

type variables
Datetime idt_s, idt_e
Integer ii_every
Long il_line
String is_line
end variables

on w_downtime_detail_instance2.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_email=create cb_email
this.cb_save=create cb_save
this.cb_previous=create cb_previous
this.cb_next=create cb_next
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_email
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_previous
this.Control[iCurrent+7]=this.cb_next
end on

on w_downtime_detail_instance2.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_email)
destroy(this.cb_save)
destroy(this.cb_previous)
destroy(this.cb_next)
end on

event open;call super::open;s_downtime_info as_info
DateTime ldt_end
Date ld_date
Time lt_time

as_info = message.PowerObjectParm
ld_date = date(as_info.instance_starting)
lt_time = time(as_info.instance_starting)
lt_time  = RelativeTime(lt_time, as_info.issm * 60)
ldt_end = DateTime(ld_date, lt_time)
dw_report.Retrieve(as_info.instance_starting,ldt_end, as_info.line_id )
dw_report.object.gr_1.title = as_info.line_desc + " " + "downtime details from " + String(as_info.instance_starting, "mm/dd/yyyy hh:mm:ss") + " to " + String(ldt_end, "mm/dd/yyyy hh:mm:ss")

ii_every = as_info.issm
idt_s = as_info.instance_starting
idt_e = ldt_end
il_line = as_info.line_id
is_line = as_info.line_desc

end event

type dw_report from u_dw within w_downtime_detail_instance2
int X=278
int Y=6
int Width=2783
int Height=1482
int TabOrder=10
string Tag="detailed downtime information based on each instance"
string DataObject="d_report_downtime_case"
boolean VScrollBar=false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event constructor;dw_Report.SetTransObject(sqlca)

end event

type cb_close from u_cb within w_downtime_detail_instance2
event clicked pbm_bnclicked
int X=2198
int Y=1494
int Height=74
int TabOrder=60
string Tag="Close"
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_print from u_cb within w_downtime_detail_instance2
int X=735
int Y=1494
int Height=74
int TabOrder=30
string Tag="Print"
string Text="&Print"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_email from u_cb within w_downtime_detail_instance2
int X=1225
int Y=1494
int Height=74
int TabOrder=40
string Tag="Email"
string Text="Email"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_save from u_cb within w_downtime_detail_instance2
int X=1712
int Y=1494
int Height=74
int TabOrder=50
string Tag="Save"
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_previous from u_cb within w_downtime_detail_instance2
int X=18
int Y=518
int Width=230
int Height=128
int TabOrder=20
string Text="&Previous"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;DateTime ldt_end, ldt_start
Date ld_date
Time lt_time

ldt_end = idt_s
ld_date = date(ldt_end)
lt_time = time(ldt_end)
lt_time  = RelativeTime(lt_time, ii_every * (-60))
ldt_start = DateTime(ld_date, lt_time)
dw_report.Retrieve(ldt_start,ldt_end, il_line)
dw_report.object.gr_1.title = is_line + " " + "downtime details from " + String(ldt_start) + "to " + String(ldt_end)

idt_s = ldt_start
idt_e = ldt_end

end event

type cb_next from u_cb within w_downtime_detail_instance2
int X=3090
int Y=518
int Width=230
int Height=128
int TabOrder=11
string Text="&Next"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;DateTime ldt_end, ldt_start
Date ld_date
Time lt_time

ldt_start = idt_e
ld_date = date(ldt_start)
lt_time = time(ldt_start)
lt_time  = RelativeTime(lt_time, ii_every * 60)
ldt_end = DateTime(ld_date, lt_time)
dw_report.Retrieve(ldt_start,ldt_end, il_line)
dw_report.object.gr_1.title = is_line + " " + "downtime details from " + String(ldt_start) + "to " + String(ldt_end)

idt_s = ldt_start
idt_e = ldt_end

end event

