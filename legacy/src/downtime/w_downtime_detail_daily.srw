$PBExportHeader$w_downtime_detail_daily.srw
$PBExportComments$<Child> display downtime details based on daily info
forward
global type w_downtime_detail_daily from w_child
end type
type dw_report from u_dw within w_downtime_detail_daily
end type
type cb_close from u_cb within w_downtime_detail_daily
end type
type cb_print from u_cb within w_downtime_detail_daily
end type
type cb_email from u_cb within w_downtime_detail_daily
end type
type cb_save from u_cb within w_downtime_detail_daily
end type
end forward

global type w_downtime_detail_daily from w_child
int X=395
int Y=278
int Width=2992
int Height=1696
WindowType WindowType=response!
boolean TitleBar=true
string Title="Downtime summary based  on few days"
string Tag="Daily based downtime summary"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_report dw_report
cb_close cb_close
cb_print cb_print
cb_email cb_email
cb_save cb_save
end type
global w_downtime_detail_daily w_downtime_detail_daily

type variables
Integer ii_prior_series, ii_prior_data
end variables

on w_downtime_detail_daily.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_email=create cb_email
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_email
this.Control[iCurrent+5]=this.cb_save
end on

on w_downtime_detail_daily.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_email)
destroy(this.cb_save)
end on

event open;call super::open;s_downtime_info as_info

as_info = message.PowerObjectParm
dw_report.Retrieve(as_info.daily_from, as_info.daily_to, as_info.line_id)
dw_report.object.gr_1.title = as_info.line_desc + " " + "daily downtime from " +  String(as_info.daily_from, "mm/dd/yyyy") + " to " + String(as_info.daily_to, "mm/dd/yyyy")


end event

type dw_report from u_dw within w_downtime_detail_daily
int X=7
int Y=6
int Width=2944
int Height=1475
int TabOrder=10
string Tag="Daily detailed downtime information"
string DataObject="d_report_downtime_daily"
boolean VScrollBar=false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event doubleclicked;Integer li_series, li_data, li_min 
Date ld_date
GrObjectType clicked_object

clicked_object = this.ObjectAtPointer("gr_1", li_series, li_data)

This.SetRedraw(FALSE)


end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(sqlca)

end event

event clicked;call super::clicked;Integer li_series, li_data
//determine if the clicked is a data
If This.ObjectAtPointer("gr_1", li_series, li_data) = TypeData! THEN
	this.SetRedraw(FALSE)
	//reset the color
	this.ResetDataColors("gr_1",ii_prior_series, ii_prior_data)
	//change color
	this.SetDataStyle("gr_1", li_series, li_data, ForeGround!, 16711680)
	//store prior color
	ii_prior_series = li_series
	ii_prior_data = li_data
	this.SetRedraw(TRUE)
ELSE
	this.ResetDataColors("gr_1",ii_prior_series, ii_prior_data)	
END IF
end event

type cb_close from u_cb within w_downtime_detail_daily
event clicked pbm_bnclicked
int X=1997
int Y=1507
int Height=74
int TabOrder=50
string Tag="Close"
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_print from u_cb within w_downtime_detail_daily
int X=560
int Y=1507
int Height=74
int TabOrder=20
string Tag="Print"
string Text="&Print"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_email from u_cb within w_downtime_detail_daily
int X=1039
int Y=1507
int Height=74
int TabOrder=30
string Tag="Email"
string Text="Email"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_save from u_cb within w_downtime_detail_daily
int X=1518
int Y=1507
int Height=74
int TabOrder=40
string Tag="Save"
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

