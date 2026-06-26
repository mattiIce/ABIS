$PBExportHeader$w_downtime_shift_downtime_prod_ratio.srw
$PBExportComments$<Child> display downtime/production ratio based each shift
forward
global type w_downtime_shift_downtime_prod_ratio from w_child
end type
type cb_close from u_cb within w_downtime_shift_downtime_prod_ratio
end type
type cb_print from u_cb within w_downtime_shift_downtime_prod_ratio
end type
type cb_email from u_cb within w_downtime_shift_downtime_prod_ratio
end type
type cb_save from u_cb within w_downtime_shift_downtime_prod_ratio
end type
type gr_1 from u_gr within w_downtime_shift_downtime_prod_ratio
end type
end forward

global type w_downtime_shift_downtime_prod_ratio from w_child
int X=395
int Y=278
int Width=3397
int Height=1866
WindowType WindowType=response!
boolean TitleBar=true
string Title="Downtime/Production ratio based  on one shift's work"
string Tag="detail downtime/production ratio information based on one shift's work"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_close cb_close
cb_print cb_print
cb_email cb_email
cb_save cb_save
gr_1 gr_1
end type
global w_downtime_shift_downtime_prod_ratio w_downtime_shift_downtime_prod_ratio

type variables
Integer ii_series, ii_data
s_downtime_info is_info
end variables

on w_downtime_shift_downtime_prod_ratio.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_email=create cb_email
this.cb_save=create cb_save
this.gr_1=create gr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_email
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.gr_1
end on

on w_downtime_shift_downtime_prod_ratio.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_email)
destroy(this.cb_save)
destroy(this.gr_1)
end on

event open;call super::open;Real lr_minutes, lr_prod_minutes
is_info = message.PowerObjectParm
DateTime ldt_s, ldt_e, ldt_shift_end, ldt_shift_start
Long ll_shift_id, ll_prod
Integer li_series
Time lt_t

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
SELECT Shift_num, Start_time, END_TIME INTO :ll_shift_id, :ldt_shift_start, :ldt_shift_end
FROM SHIFT
WHERE Start_time >= :ldt_s and Start_time <= :ldt_e and line_num = :is_info.line_id;
IF IsNULL(ll_shift_id) OR ll_shift_id = 0 THEN 
	MessageBox("Warning", "Shift infomation not available.")
	this.Event Close()
	Return -1
END IF

IF isNULL(ldt_shift_end) THEN //default 8 hours
	lt_t = Time(ldt_shift_start)
	ldt_shift_end = DateTime(Date(ldt_shift_start), Time(String(Hour(lt_t) + 8) + ":" + String(Minute(lt_t)) + ":" + String(Second(lt_t)) ))
END IF

SELECT SUM(DT_INSTANCE_DETAIL.DURATION)/60  
INTO :lr_minutes
FROM DT_INSTANCE, DT_INSTANCE_DETAIL,SHIFT  
WHERE ( DT_INSTANCE_DETAIL.INSTANCE_NUM = DT_INSTANCE.INSTANCE_NUM ) and  
         ( SHIFT.SHIFT_NUM = DT_INSTANCE.SHIFT_NUM ) and  
         ( SHIFT.SHIFT_NUM = :ll_shift_id) AND  
         ( DT_INSTANCE.STARTING_TIME >= SHIFT.START_TIME) AND  
         ( DT_INSTANCE.STARTING_TIME <= :ldt_shift_end);
			
lr_prod_minutes = secondsafter(Time(ldt_shift_start), Time(ldt_shift_end))/60 - lr_minutes

gr_1.Title = is_info.line_desc + " " + "downtime/production ratio by " + is_info.shift_name + " shift " + String(is_info.daily_from)

li_series = gr_1.AddSeries("ratio")
gr_1.AddCategory("Production")
IF li_series <> -1 THEN gr_1.AddData(li_series, lr_prod_minutes, "Production")
gr_1.AddCategory("Downtime")
IF li_series <> -1 THEN gr_1.AddData(li_series, lr_minutes, "Downtime")

end event

type cb_close from u_cb within w_downtime_shift_downtime_prod_ratio
event clicked pbm_bnclicked
int X=2992
int Y=915
int Height=74
int TabOrder=40
string Tag="Close"
string Text="&Close"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_print from u_cb within w_downtime_shift_downtime_prod_ratio
int X=2992
int Y=454
int Height=74
int TabOrder=10
string Tag="Print"
string Text="&Print"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_email from u_cb within w_downtime_shift_downtime_prod_ratio
int X=2992
int Y=608
int Height=74
int TabOrder=20
string Tag="Email"
string Text="Email"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type cb_save from u_cb within w_downtime_shift_downtime_prod_ratio
int X=2992
int Y=762
int Height=74
int TabOrder=30
string Tag="Save"
string Text="&Save"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;Close(parent)
end event

type gr_1 from u_gr within w_downtime_shift_downtime_prod_ratio
int X=4
int Y=6
int Width=2962
int Height=1757
boolean BringToTop=true
grGraphType GraphType=PieGraph!
grLegendType Legend=AtLeft!
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long BackColor=16777215
end type

on gr_1.create
call super::create
LegendDispAttr.DisplayExpression="category"
end on

