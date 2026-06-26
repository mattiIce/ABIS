$PBExportHeader$w_downtime_detail_day.srw
$PBExportComments$<Child> display downtime details based each day
forward
global type w_downtime_detail_day from w_child
end type
type dw_report from u_dw within w_downtime_detail_day
end type
type cb_close from u_cb within w_downtime_detail_day
end type
type cb_print from u_cb within w_downtime_detail_day
end type
type cb_email from u_cb within w_downtime_detail_day
end type
type cb_save from u_cb within w_downtime_detail_day
end type
type dw_detail from u_dw within w_downtime_detail_day
end type
type st_1 from statictext within w_downtime_detail_day
end type
type cbx_rotate from u_cbx within w_downtime_detail_day
end type
end forward

global type w_downtime_detail_day from w_child
int X=91
int Y=112
int Width=3562
int Height=2301
WindowType WindowType=response!
boolean TitleBar=true
string Title="Downtime details based  on one day's work"
string Tag="detail downtime information based on one day's work"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_stoptimer ( )
event ue_starttimer ( )
dw_report dw_report
cb_close cb_close
cb_print cb_print
cb_email cb_email
cb_save cb_save
dw_detail dw_detail
st_1 st_1
cbx_rotate cbx_rotate
end type
global w_downtime_detail_day w_downtime_detail_day

type variables
Integer ii_series, ii_data
s_downtime_info is_info
Integer ii_direction
Long il_color
end variables

event ue_stoptimer;Timer(0)
end event

event ue_starttimer;Timer(1)
end event

on w_downtime_detail_day.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_email=create cb_email
this.cb_save=create cb_save
this.dw_detail=create dw_detail
this.st_1=create st_1
this.cbx_rotate=create cbx_rotate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_email
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cbx_rotate
end on

on w_downtime_detail_day.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_email)
destroy(this.cb_save)
destroy(this.dw_detail)
destroy(this.st_1)
destroy(this.cbx_rotate)
end on

event open;call super::open;Real lr_minutes
is_info = message.PowerObjectParm
dw_report.Retrieve(is_info.day, is_info.line_id)

SELECT SUM(DT_INSTANCE_DETAIL.DURATION)/60  
INTO :lr_minutes
FROM DT_CAUSE,DT_INSTANCE,DT_INSTANCE_DETAIL  
WHERE ( DT_INSTANCE_DETAIL.INSTANCE_NUM = DT_INSTANCE.INSTANCE_NUM ) and  
      ( DT_INSTANCE_DETAIL.ID = DT_CAUSE.ID ) and  
      ( DT_INSTANCE.LINE_NUM = :is_info.line_id ) and  
      ( To_Date( DT_INSTANCE.STARTING_TIME) = :is_info.day); 

dw_report.Object.gr_1.Title = "Downtime by Date(" + String(is_info.day) + ", " + is_info.line_desc + ", " + String(lr_minutes, "########") +" mins)"

ii_direction = 1
Timer(1)

end event

event timer;String ls_mod
Integer li_rotate

li_rotate = Integer(dw_report.Describe("gr_1.Rotation"))
//rotate right
IF li_rotate < 90 THEN
	IF  ii_direction = 1 THEN
		li_rotate = li_rotate + 10
		ls_mod = "gr_1.Rotation=" + "'" + String(li_rotate) + "'"
		dw_report.Modify(ls_mod)
		RETURN 1
	END IF
ELSE 
	ii_direction = -1
END IF

//Rotate left
IF li_rotate > -90 THEN
	IF ii_direction = -1 THEN
		li_rotate = li_rotate - 10
		ls_mod = "gr_1.Rotation=" + "'" + String(li_rotate) + "'"
		dw_report.Modify(ls_mod)
		RETURN -1
	END IF
ELSE 
	ii_direction = 1
END IF

RETURN 0

	

end event

type dw_report from u_dw within w_downtime_detail_day
int X=4
int Y=0
int Width=3182
int Height=2202
int TabOrder=10
string Tag="Detail downtime information of  each day"
string DataObject="d_report_downtime_details_daily"
boolean VScrollBar=false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event doubleclicked;Integer li_series, li_data, li_percent
Long ll_sec, ll_pos
String ls_cat
GrObjectType clicked_object

clicked_object = this.ObjectAtPointer("gr_1", li_series, li_data)

This.SetRedraw(FALSE)

If ii_series <> 0 and ii_data <> 0 then
	If li_series = ii_series and ii_data = li_data then
		This.SetRedraw(TRUE)
		Return
	Else
		This.SetDataPieExplode("gr_1", ii_series, ii_data, 0)
	End If
End IF
IF clicked_object = TypeData! then
	This.GetDataStyle("gr_1", li_series, li_data, Foreground!, il_color)
	This.GetDataPieExplode("gr_1", li_series, li_data, li_percent)
	If li_percent = 0 then
		This.SetDataPieExplode("gr_1", li_series, li_data, 50)
		ii_series = li_series
		ii_data = li_data
		ls_cat = This.CategoryName("gr_1", li_data)
		ls_cat = Reverse(ls_cat)
		ll_pos = Pos(ls_cat, '-')
		ls_cat = Reverse(Right(ls_cat, (Len(ls_cat) - ll_pos)))
		
		dw_detail.SetRedraw(FALSE)
		dw_detail.Retrieve(is_info.day, ls_cat)
		
		SELECT SUM(DT_INSTANCE_DETAIL.DURATION) 
		INTO :ll_sec
		FROM DT_CAUSE,DT_INSTANCE,DT_INSTANCE_DETAIL  
		WHERE ( DT_INSTANCE_DETAIL.INSTANCE_NUM = DT_INSTANCE.INSTANCE_NUM ) and  
  		    	( DT_INSTANCE_DETAIL.ID = DT_CAUSE.ID ) and  
    		  	( To_Date( DT_INSTANCE.STARTING_TIME) = :is_info.day) and
				( DT_CAUSE.CAUSE_NAME = :ls_cat); 

		dw_detail.Object.gr_1.Title="Downtime by " + ls_cat + "-" + String(ll_sec) + " Seconds"
//		dw_detail.Show()
		this.Height = 1542
	Else
		This.SetDataPieExplode("gr_1", li_series, li_data, 0)
		//dw_detail.Hide()
		this.Height = 2208
		dw_detail.Reset()
		ii_series = 0
		ii_data = 0
	End If
Else
	//dw_detail.Hide()
	this.Height = 2208
	MessageBox("Not a Category", "Please click on a category first.")
END IF
		
This.SetRedraw(TRUE)
dw_detail.SetRedraw(TRUE)
dw_detail.Event ue_changecolor()




end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(sqlca)


end event

type cb_close from u_cb within w_downtime_detail_day
event clicked pbm_bnclicked
int X=3189
int Y=483
int Height=74
int TabOrder=60
string Tag="Close"
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_print from u_cb within w_downtime_detail_day
int X=3189
int Y=22
int Height=74
int TabOrder=30
string Tag="Print"
string Text="&Print"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_email from u_cb within w_downtime_detail_day
int X=3189
int Y=176
int Height=74
int TabOrder=40
string Tag="Email"
string Text="Email"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_save from u_cb within w_downtime_detail_day
int X=3189
int Y=330
int Height=74
int TabOrder=50
string Tag="Save"
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type dw_detail from u_dw within w_downtime_detail_day
event ue_changecolor ( )
int X=4
int Y=1546
int Width=3182
int Height=653
int TabOrder=20
string Tag="Detail downtime information per category"
string DataObject="d_report_downtime_details_daily_per_cat"
boolean VScrollBar=false
end type

event ue_changecolor;String ls_series
this.SetRedraw(FALSE)
//change color
ls_series = this.SeriesName("gr_1", 1)
this.SetSeriesStyle("gr_1", ls_series, ForeGround!, il_color)
this.SetRedraw(TRUE)

end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(sqlca)


end event

event clicked;call super::clicked;Integer li_series, li_data
String ls_series
//determine if the clicked is a data
If This.ObjectAtPointer("gr_1", li_series, li_data) = TypeData! THEN
	this.SetRedraw(FALSE)
	//change color
	ls_series = this.SeriesName("gr_1", li_series)
	this.SetSeriesStyle("gr_1", ls_series, ForeGround!, il_color)
	this.SetRedraw(TRUE)
END IF
end event

type st_1 from statictext within w_downtime_detail_day
int X=3193
int Y=2013
int Width=333
int Height=186
boolean Enabled=false
boolean BringToTop=true
string Text="double-click on each section for more details"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80269524
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_rotate from u_cbx within w_downtime_detail_day
int X=3237
int Y=1875
string Tag="Rotate the graph"
boolean BringToTop=true
string Text="Rotate"
boolean Checked=true
long BackColor=80269524
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;IF this.Checked THEN
	Parent.Event ue_starttimer()
ELSE
	Parent.Event ue_stoptimer()
END IF


end event

