$PBExportHeader$w_downtime_detail_shift.srw
$PBExportComments$<Child> display downtime details based each shift
forward
global type w_downtime_detail_shift from w_child
end type
type dw_report from u_dw within w_downtime_detail_shift
end type
type cb_close from u_cb within w_downtime_detail_shift
end type
type cb_print from u_cb within w_downtime_detail_shift
end type
type cb_email from u_cb within w_downtime_detail_shift
end type
type cb_save from u_cb within w_downtime_detail_shift
end type
type dw_detail from u_dw within w_downtime_detail_shift
end type
end forward

global type w_downtime_detail_shift from w_child
int X=395
int Y=278
int Width=3397
int Height=1866
WindowType WindowType=response!
boolean TitleBar=true
string Title="Downtime details based  on one shift's work"
string Tag="detail downtime information based on one shift's work"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_report dw_report
cb_close cb_close
cb_print cb_print
cb_email cb_email
cb_save cb_save
dw_detail dw_detail
end type
global w_downtime_detail_shift w_downtime_detail_shift

type variables
Integer ii_series, ii_data
s_downtime_info is_info
end variables

on w_downtime_detail_shift.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_email=create cb_email
this.cb_save=create cb_save
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_email
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.dw_detail
end on

on w_downtime_detail_shift.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_email)
destroy(this.cb_save)
destroy(this.dw_detail)
end on

event open;call super::open;Real lr_minutes
is_info = message.PowerObjectParm
DateTime ldt_s, ldt_e
Long ll_shift_id

CHOOSE CASE is_info.shift_name
	CASE "1ST"
		ldt_s = DateTime(is_info.daily_from,Time("1:00:00"))
		ldt_e = DateTime(is_info.daily_from,Time("11:59:00"))
	CASE "2ND"
		ldt_s = DateTime(is_info.daily_from,Time("13:00:00"))
		ldt_e = DateTime(is_info.daily_from,Time("16:59:00"))
	CASE "3RD"
		ldt_s = DateTime(is_info.daily_from,Time("17:00:00"))
		ldt_e = DateTime(is_info.daily_from,Time("23:59:00"))
END CHOOSE

ll_shift_id = 0
SELECT Shift_num INTO :ll_shift_id
FROM SHIFT
WHERE Start_time >= :ldt_s and Start_time <= :ldt_e and line_num = :is_info.line_id
USING SQLCA;
IF IsNULL(ll_shift_id) OR ll_shift_id = 0 THEN 
	MessageBox("Warning", "Shift infomation not available.")
	this.Event Close()
	Return -1
END IF


dw_report.Retrieve(ll_shift_id)

SELECT SUM(DT_INSTANCE_DETAIL.DURATION)/60  
INTO :lr_minutes
FROM DT_INSTANCE, DT_INSTANCE_DETAIL,SHIFT  
WHERE ( DT_INSTANCE_DETAIL.INSTANCE_NUM = DT_INSTANCE.INSTANCE_NUM ) and  
         ( SHIFT.SHIFT_NUM = DT_INSTANCE.SHIFT_NUM ) and  
         ( SHIFT.SHIFT_NUM = :ll_shift_id) AND  
         ( DT_INSTANCE.STARTING_TIME >= SHIFT.START_TIME) AND  
         ( DT_INSTANCE.STARTING_TIME <= SHIFT.END_TIME);

dw_report.Object.gr_1.Title = is_info.line_desc + " " + "downtime by " + is_info.shift_name + " shift " + String(is_info.daily_from) + " " + String(lr_minutes, "########") +" mins)"


end event

type dw_report from u_dw within w_downtime_detail_shift
int X=11
int Y=0
int Width=2944
int Height=1741
int TabOrder=10
string Tag="Detail downtime information of  each shift"
string DataObject="d_report_downtime_daily_per_shift"
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

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(sqlca)


end event

type cb_close from u_cb within w_downtime_detail_shift
event clicked pbm_bnclicked
int X=2995
int Y=502
int Height=74
int TabOrder=60
string Tag="Close"
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_print from u_cb within w_downtime_detail_shift
int X=2995
int Y=42
int Height=74
int TabOrder=30
string Tag="Print"
string Text="&Print"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_email from u_cb within w_downtime_detail_shift
int X=2995
int Y=195
int Height=74
int TabOrder=40
string Tag="Email"
string Text="Email"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_save from u_cb within w_downtime_detail_shift
int X=2995
int Y=349
int Height=74
int TabOrder=50
string Tag="Save"
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type dw_detail from u_dw within w_downtime_detail_shift
int X=11
int Y=1078
int Width=2944
int Height=659
int TabOrder=20
string Tag="Detail downtime information per category"
string DataObject="d_report_downtime_details_daily_per_cat"
boolean VScrollBar=false
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(sqlca)


end event

