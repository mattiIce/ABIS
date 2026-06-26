$PBExportHeader$w_sales_quote_reminder.srw
$PBExportComments$<Sheet>reminder for a quote
forward
global type w_sales_quote_reminder from w_sheet
end type
type cb_save from u_cb within w_sales_quote_reminder
end type
type pb_3 from u_pb within w_sales_quote_reminder
end type
type mle_1 from u_mle within w_sales_quote_reminder
end type
type pb_6 from u_pb within w_sales_quote_reminder
end type
type pb_5 from u_pb within w_sales_quote_reminder
end type
type pb_2 from u_pb within w_sales_quote_reminder
end type
type pb_8 from u_pb within w_sales_quote_reminder
end type
type em_calendar from u_em within w_sales_quote_reminder
end type
type uo_calendar_1 from u_calendar within w_sales_quote_reminder
end type
type gb_title from groupbox within w_sales_quote_reminder
end type
type dw_schedule from u_dw within w_sales_quote_reminder
end type
end forward

global type w_sales_quote_reminder from w_sheet
integer x = 461
integer y = 259
integer width = 2194
integer height = 1670
string title = "Quote Reminder"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
event type integer ue_date_changed ( )
event type integer ue_dw_info_refresh ( )
cb_save cb_save
pb_3 pb_3
mle_1 mle_1
pb_6 pb_6
pb_5 pb_5
pb_2 pb_2
pb_8 pb_8
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
gb_title gb_title
dw_schedule dw_schedule
end type
global w_sales_quote_reminder w_sales_quote_reminder

type variables
String is_date
Date id_date
s_quote_data ids_q
end variables

event type integer ue_date_changed();//create new tree
is_date = em_calendar.Text
id_date = Date(is_date)

RETURN this.Event ue_dw_info_refresh()


end event

event type integer ue_dw_info_refresh();dw_schedule.Retrieve(ids_q.quote_id, ids_q.revision_id)

RETURN 0
end event

on w_sales_quote_reminder.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.pb_3=create pb_3
this.mle_1=create mle_1
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_2=create pb_2
this.pb_8=create pb_8
this.em_calendar=create em_calendar
this.uo_calendar_1=create uo_calendar_1
this.gb_title=create gb_title
this.dw_schedule=create dw_schedule
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.pb_3
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.pb_6
this.Control[iCurrent+5]=this.pb_5
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.pb_8
this.Control[iCurrent+8]=this.em_calendar
this.Control[iCurrent+9]=this.uo_calendar_1
this.Control[iCurrent+10]=this.gb_title
this.Control[iCurrent+11]=this.dw_schedule
end on

on w_sales_quote_reminder.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.pb_3)
destroy(this.mle_1)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_2)
destroy(this.pb_8)
destroy(this.em_calendar)
destroy(this.uo_calendar_1)
destroy(this.gb_title)
destroy(this.dw_schedule)
end on

event open;call super::open;Date ld_today

ids_q = Message.PowerObjectParm

ld_today = Today()
em_calendar.Text =  String(ld_today, "mm/dd/yyyy")
is_date = em_calendar.Text

RETURN this.Event ue_dw_info_refresh()








end event

type cb_save from u_cb within w_sales_quote_reminder
integer x = 1295
integer y = 1469
integer width = 351
integer height = 93
integer taborder = 30
string facename = "Arial"
string text = "&Save"
end type

type pb_3 from u_pb within w_sales_quote_reminder
integer x = 1671
integer y = 99
integer width = 80
integer height = 70
integer taborder = 40
string text = ""
string picturename = "AddWatch5!"
string powertiptext = "New"
end type

type mle_1 from u_mle within w_sales_quote_reminder
integer x = 783
integer y = 909
integer width = 1335
integer height = 557
integer taborder = 20
end type

type pb_6 from u_pb within w_sales_quote_reminder
integer x = 2066
integer y = 13
integer width = 80
integer height = 70
integer taborder = 120
string text = ""
boolean originalsize = false
string picturename = "Exit!"
string powertiptext = "Exit"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_5 from u_pb within w_sales_quote_reminder
integer x = 1968
integer y = 13
integer width = 80
integer height = 70
integer taborder = 110
string text = ""
boolean originalsize = false
string picturename = "Custom074!"
string powertiptext = "Print"
end type

type pb_2 from u_pb within w_sales_quote_reminder
integer x = 1869
integer y = 13
integer width = 80
integer height = 70
integer taborder = 100
string text = ""
boolean originalsize = false
string picturename = "Custom072!"
string powertiptext = "Edit"
end type

type pb_8 from u_pb within w_sales_quote_reminder
integer x = 1770
integer y = 13
integer width = 80
integer height = 70
integer taborder = 90
string text = ""
string picturename = "Custom091!"
string powertiptext = "Delete"
end type

type em_calendar from u_em within w_sales_quote_reminder
boolean visible = false
integer x = 944
integer y = 3
integer width = 428
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;//this.of_SetDropDownCalendar(TRUE)
//this.iuo_calendar.of_SetAlwaysRedraw(TRUE)
//this.iuo_calendar.of_SetinitialValue(TRUE)
//
//this.iuo_calendar.of_SetSaturdayBold(TRUE)
//this.iuo_calendar.of_SetSaturdayColor(RGB(0, 255, 0)) 
//this.iuo_calendar.of_SetSundayBold(TRUE) 
//this.iuo_calendar.of_SetSundayColor(RGB(0, 255, 0))
//
//
//this.iuo_calendar.of_SetCloseonClick(TRUE)

uo_calendar_1.of_SetRequestor(this)
end event

event modified;//RETURN Parent.Event ue_date_changed()
end event

event other;IF em_calendar.Text <>  is_date Then 
	//MessageBox("", "hello")
	RETURN Parent.Event ue_date_changed()
ELSE
	RETURN 0
END IF
end event

type uo_calendar_1 from u_calendar within w_sales_quote_reminder
integer x = 69
integer y = 909
integer width = 706
integer height = 653
integer taborder = 10
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type gb_title from groupbox within w_sales_quote_reminder
integer x = 26
integer y = 826
integer width = 2132
integer height = 752
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Remind Me:"
end type

type dw_schedule from u_dw within w_sales_quote_reminder
integer x = 29
integer y = 93
integer width = 2121
integer height = 714
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sales_quote_event_list"
end type

event constructor;of_SetRowManager(TRUE)
of_SetBase(TRUE)
SetTransObject(SQLCA)


end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

