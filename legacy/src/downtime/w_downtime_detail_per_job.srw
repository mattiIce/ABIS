$PBExportHeader$w_downtime_detail_per_job.srw
$PBExportComments$<Child> display downtime details based on ab job
forward
global type w_downtime_detail_per_job from w_child
end type
type dw_report from u_dw within w_downtime_detail_per_job
end type
type cb_close from u_cb within w_downtime_detail_per_job
end type
type cb_print from u_cb within w_downtime_detail_per_job
end type
type cb_email from u_cb within w_downtime_detail_per_job
end type
type cb_save from u_cb within w_downtime_detail_per_job
end type
end forward

global type w_downtime_detail_per_job from w_child
int X=395
int Y=278
int Width=2992
int Height=1696
WindowType WindowType=response!
boolean TitleBar=true
string Title="Downtime details per production order"
string Tag="detail downtime information per job"
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
global w_downtime_detail_per_job w_downtime_detail_per_job

type variables

end variables

on w_downtime_detail_per_job.create
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

on w_downtime_detail_per_job.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_email)
destroy(this.cb_save)
end on

event open;call super::open;dw_Report.SetTransObject(sqlca)
dw_report.Retrieve(message.doubleparm)
dw_report.object.gr_1.title = "Downtime details (Job#"  + String(message.doubleparm) 


end event

type dw_report from u_dw within w_downtime_detail_per_job
int X=7
int Y=6
int Width=2944
int Height=1475
int TabOrder=10
string Tag="Detail downtime information of a job"
string DataObject="d_report_downtime_details_per_job"
boolean VScrollBar=false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event doubleclicked;//Integer li_series, li_data, li_percent
//Long ll_sec
//String ls_cat
//GrObjectType clicked_object
//
//clicked_object = this.ObjectAtPointer("gr_1", li_series, li_data)
//
//This.SetRedraw(FALSE)
//
//If ii_series <> 0 and ii_data <> 0 then
//	If li_series = ii_series and ii_data = li_data then
//		This.SetRedraw(TRUE)
//		Return
//	Else
//		This.SetDataPieExplode("gr_1", ii_series, ii_data, 0)
//	End If
//End IF
//IF clicked_object = TypeData! then
//	This.GetDataPieExplode("gr_1", li_series, li_data, li_percent)
//	If li_percent = 0 then
//		This.SetDataPieExplode("gr_1", li_series, li_data, 50)
//		ii_series = li_series
//		ii_data = li_data
//		ls_cat = This.CategoryName("gr_1", li_data)
//		dw_detail.SetRedraw(FALSE)
//		dw_detail.Retrieve(is_info.day, ls_cat)
//		
//		SELECT SUM(DT_INSTANCE_DETAIL.DURATION) 
//		INTO :ll_sec
//		FROM DT_CAUSE,DT_INSTANCE,DT_INSTANCE_DETAIL  
//		WHERE ( DT_INSTANCE_DETAIL.INSTANCE_NUM = DT_INSTANCE.INSTANCE_NUM ) and  
//  		    	( DT_INSTANCE_DETAIL.ID = DT_CAUSE.ID ) and  
//    		  	( To_Date( DT_INSTANCE.STARTING_TIME) = :is_info.day) and
//				( DT_CAUSE.CAUSE_NAME = :ls_cat); 
//
//		dw_detail.Object.gr_1.Title="Downtime by " + ls_cat + "-" + String(ll_sec) + " Seconds"
////		dw_detail.Show()
//		this.Height = 1080
//	Else
//		This.SetDataPieExplode("gr_1", li_series, li_data, 0)
//		//dw_detail.Hide()
//		this.Height = 1740
//		dw_detail.Reset()
//		ii_series = 0
//		ii_data = 0
//	End If
//Else
//	//dw_detail.Hide()
//	this.Height = 1740
//	MessageBox("Not a Category", "Please click on a category first.")
//END IF
//		
//This.SetRedraw(TRUE)
//dw_detail.SetRedraw(TRUE)
//
//
//
//
end event

type cb_close from u_cb within w_downtime_detail_per_job
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

type cb_print from u_cb within w_downtime_detail_per_job
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

type cb_email from u_cb within w_downtime_detail_per_job
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

type cb_save from u_cb within w_downtime_detail_per_job
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

