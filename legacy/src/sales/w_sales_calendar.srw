$PBExportHeader$w_sales_calendar.srw
$PBExportComments$<Sheet>sales calendar
forward
global type w_sales_calendar from w_sheet
end type
type st_msg from statictext within w_sales_calendar
end type
type pb_6 from u_pb within w_sales_calendar
end type
type pb_5 from u_pb within w_sales_calendar
end type
type pb_2 from u_pb within w_sales_calendar
end type
type pb_8 from u_pb within w_sales_calendar
end type
type pb_1 from u_pb within w_sales_calendar
end type
type st_1 from statictext within w_sales_calendar
end type
type em_calendar from u_em within w_sales_calendar
end type
type uo_calendar_1 from u_calendar within w_sales_calendar
end type
type gb_title from groupbox within w_sales_calendar
end type
type dw_schedule from u_dw within w_sales_calendar
end type
end forward

global type w_sales_calendar from w_sheet
integer x = 461
integer y = 259
integer width = 2194
integer height = 1670
string title = "Sales Remainder"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
event type integer ue_date_changed ( )
event type integer ue_dw_info_refresh ( )
st_msg st_msg
pb_6 pb_6
pb_5 pb_5
pb_2 pb_2
pb_8 pb_8
pb_1 pb_1
st_1 st_1
em_calendar em_calendar
uo_calendar_1 uo_calendar_1
gb_title gb_title
dw_schedule dw_schedule
end type
global w_sales_calendar w_sales_calendar

type variables
String is_date
Date id_date

end variables

event type integer ue_date_changed();dw_schedule.Reset()

//create new tree
is_date = em_calendar.Text
id_date = Date(is_date)
st_1.Text = "Date: " + is_date

RETURN this.Event ue_dw_info_refresh()


end event

event type integer ue_dw_info_refresh();dw_schedule.Visible = TRUE

dw_schedule.Retrieve(id_date)

IF dw_schedule.RowCount() > 0 THEN 
	RETURN 1
ELSE
	dw_schedule.Visible = FALSE
END IF

RETURN 0
end event

on w_sales_calendar.create
int iCurrent
call super::create
this.st_msg=create st_msg
this.pb_6=create pb_6
this.pb_5=create pb_5
this.pb_2=create pb_2
this.pb_8=create pb_8
this.pb_1=create pb_1
this.st_1=create st_1
this.em_calendar=create em_calendar
this.uo_calendar_1=create uo_calendar_1
this.gb_title=create gb_title
this.dw_schedule=create dw_schedule
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_msg
this.Control[iCurrent+2]=this.pb_6
this.Control[iCurrent+3]=this.pb_5
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.pb_8
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.em_calendar
this.Control[iCurrent+9]=this.uo_calendar_1
this.Control[iCurrent+10]=this.gb_title
this.Control[iCurrent+11]=this.dw_schedule
end on

on w_sales_calendar.destroy
call super::destroy
destroy(this.st_msg)
destroy(this.pb_6)
destroy(this.pb_5)
destroy(this.pb_2)
destroy(this.pb_8)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_calendar)
destroy(this.uo_calendar_1)
destroy(this.gb_title)
destroy(this.dw_schedule)
end on

event open;call super::open;Date ld_today


ld_today = Today()
em_calendar.Text =  String(ld_today, "mm/dd/yyyy")
is_date = em_calendar.Text
st_1.Text = "Date: " + is_date

RETURN this.Event ue_dw_info_refresh()








end event

type st_msg from statictext within w_sales_calendar
integer x = 936
integer y = 1478
integer width = 1035
integer height = 96
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "No Event Scheduled"
alignment alignment = Center!
boolean focusrectangle = false
end type

type pb_6 from u_pb within w_sales_calendar
integer x = 2066
integer y = 64
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

type pb_5 from u_pb within w_sales_calendar
integer x = 1968
integer y = 64
integer width = 80
integer height = 70
integer taborder = 110
string text = ""
boolean originalsize = false
string picturename = "Custom074!"
string powertiptext = "Print"
end type

type pb_2 from u_pb within w_sales_calendar
integer x = 1869
integer y = 64
integer width = 80
integer height = 70
integer taborder = 100
string text = ""
boolean originalsize = false
string picturename = "Custom072!"
string powertiptext = "Edit"
end type

type pb_8 from u_pb within w_sales_calendar
integer x = 1770
integer y = 64
integer width = 80
integer height = 70
integer taborder = 90
string text = ""
string picturename = "Custom091!"
string powertiptext = "Delete"
end type

type pb_1 from u_pb within w_sales_calendar
integer x = 1671
integer y = 64
integer width = 80
integer height = 70
integer taborder = 80
string text = ""
string picturename = "AddWatch5!"
string powertiptext = "New"
end type

type st_1 from statictext within w_sales_calendar
integer x = 22
integer y = 32
integer width = 658
integer height = 86
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
boolean focusrectangle = false
end type

type em_calendar from u_em within w_sales_calendar
boolean visible = false
integer x = 128
integer y = 861
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

type uo_calendar_1 from u_calendar within w_sales_calendar
integer x = 7
integer y = 141
integer height = 643
integer taborder = 10
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_calendar_1.destroy
call u_calendar::destroy
end on

type gb_title from groupbox within w_sales_calendar
integer x = 713
integer y = 6
integer width = 1463
integer height = 1584
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80269524
string text = "Things to do"
end type

type dw_schedule from u_dw within w_sales_calendar
integer x = 735
integer y = 144
integer width = 1423
integer height = 1430
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sales_calendar_event_list"
end type

event constructor;of_SetRowManager(TRUE)
of_SetBase(TRUE)
SetTransObject(SQLCA)
Retrieve(Today())

end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

