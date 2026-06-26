$PBExportHeader$w_office_entry_open.srw
$PBExportComments$<Response>initial window for user open a production order inherited from pfemain/w_sheet
forward
global type w_office_entry_open from w_sheet
end type
type sle_order# from u_sle within w_office_entry_open
end type
type st_1 from u_st within w_office_entry_open
end type
type cb_ok from u_cb within w_office_entry_open
end type
type cb_cancel from u_cb within w_office_entry_open
end type
type p_1 from u_p within w_office_entry_open
end type
end forward

global type w_office_entry_open from w_sheet
integer x = 1009
integer y = 656
integer width = 1704
integer height = 438
string title = "open a production order"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
sle_order# sle_order#
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
p_1 p_1
end type
global w_office_entry_open w_office_entry_open

type variables
integer il_active
end variables

on w_office_entry_open.create
int iCurrent
call super::create
this.sle_order#=create sle_order#
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_order#
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.p_1
end on

on w_office_entry_open.destroy
call super::destroy
destroy(this.sle_order#)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.p_1)
end on

event key;IF KeyDown(KeyEnter!) THEN 
	CHOOSE CASE il_active
		CASE IS <= 2
			SetPointer(HourGlass!)
			cb_ok.TriggerEvent(Clicked!)
		CASE 3
			cb_cancel.TriggerEvent(Clicked!)
	END CHOOSE
END IF
end event

type sle_order# from u_sle within w_office_entry_open
string tag = "production order number"
integer x = 355
integer y = 147
integer width = 900
integer height = 173
integer taborder = 10
integer textsize = -26
integer weight = 700
string facename = "Arial"
end type

event getfocus;call super::getfocus;il_active = 1
end event

type st_1 from u_st within w_office_entry_open
integer x = 7
integer width = 1829
integer height = 112
integer textsize = -20
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Select a production order:"
end type

type cb_ok from u_cb within w_office_entry_open
integer x = 1302
integer y = 128
integer width = 351
integer height = 93
integer taborder = 20
integer textsize = -12
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean italic = true
string text = "&Open"
end type

event clicked;Long ll_order
Int li_order_match

ll_order = Long(sle_order#.Text)
li_order_match = 0
SELECT COUNT(ab_job_num) INTO :li_order_match
FROM ab_job
WHERE ab_job_num = :ll_order
USING SQLCA;

IF li_order_match <= 0 THEN
	MessageBox("Error: Order no found", "Please input a valid job number", StopSign!)
	Return 
END IF
	
CloseWithReturn(Parent, ll_order)

end event

event getfocus;call super::getfocus;il_active = 2
end event

type cb_cancel from u_cb within w_office_entry_open
string tag = "exit"
integer x = 1302
integer y = 234
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean italic = true
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent, 0)
end event

event getfocus;call super::getfocus;il_active = 3
end event

type p_1 from u_p within w_office_entry_open
integer x = 26
integer y = 125
integer width = 274
integer height = 211
string picturename = "openprod.jpg"
end type

