$PBExportHeader$w_tare.srw
forward
global type w_tare from w_response
end type
type st_2 from statictext within w_tare
end type
type pb_feedlength from u_pb within w_tare
end type
type cb_cancel from commandbutton within w_tare
end type
type cb_ok from commandbutton within w_tare
end type
type st_1 from statictext within w_tare
end type
type em_tare from u_em within w_tare
end type
end forward

global type w_tare from w_response
integer width = 1309
integer height = 998
string title = "Tare and packing"
boolean controlmenu = false
st_2 st_2
pb_feedlength pb_feedlength
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
em_tare em_tare
end type
global w_tare w_tare

type variables
long il_job
end variables

on w_tare.create
int iCurrent
call super::create
this.st_2=create st_2
this.pb_feedlength=create pb_feedlength
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.em_tare=create em_tare
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.pb_feedlength
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_tare
end on

on w_tare.destroy
call super::destroy
destroy(this.st_2)
destroy(this.pb_feedlength)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.em_tare)
end on

event open;call super::open;if gi_screen = 2 then
	if gi_dual_mode = 2 then
		this.x = 1200
		this.y = 4000
	else
		this.x = 7000
		this.y = 600
	end if
else
	this.x = 1200
	this.y = 600
end if
end event

type st_2 from statictext within w_tare
integer x = 911
integer y = 192
integer width = 135
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "LB."
boolean focusrectangle = false
end type

type pb_feedlength from u_pb within w_tare
integer x = 753
integer y = 173
integer width = 135
integer height = 118
integer taborder = 20
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;em_tare.Event pfc_DDCalculator( )
end event

type cb_cancel from commandbutton within w_tare
integer x = 336
integer y = 637
integer width = 633
integer height = 141
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;Closewithreturn(parent, -1)
end event

type cb_ok from commandbutton within w_tare
integer x = 336
integer y = 419
integer width = 633
integer height = 141
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ok"
end type

event clicked;//em_tare.accepttext()
long ll_tare, ll_avg_tare
ll_tare = long(em_tare.text)

if ll_tare < 1 or ll_tare > 5700 then
	MessageBox("Warning", "Invalid tare weight")
	return 1
end if

//SELECT AVG("SHEET_TARE_WT") INTO :ll_avg_tare
//FROM "SHEET_SKID"
//WHERE "AB_JOB_NUM" = :il_job;
//
//if (not isNull(ll_avg_tare)) or ( ll_avg_tare <> 0 )  then
//	if ABS( ll_tare - ll_avg_tare ) > (ll_avg_tare * 0.15) then
//		if MessageBox("Warning", "Tare weight should be within 15% of " + string( ll_avg_tare ) + ", Please recheck and change all tare weight for same job! Do you want to continue?", Exclamation!, YesNo!) = 2 then
//			return 1
//		end if
//	end if
//end if

CloseWithReturn(parent, ll_tare  )
end event

type st_1 from statictext within w_tare
integer x = 161
integer y = 32
integer width = 1075
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Enter Skid tare including packing:"
boolean focusrectangle = false
end type

type em_tare from u_em within w_tare
integer x = 336
integer y = 173
integer width = 413
integer height = 118
integer taborder = 10
integer textsize = -12
string mask = "####"
end type

event constructor;call super::constructor;il_job = message.doubleparm
//MessageBox("", string(il_job))
parent.title = "Job " + string(il_job) + " Tare and packing"
this.of_setdropdowncalculator( true)
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
//il_job = message.doubleparm
//MessageBox("", string(il_job))
end event

