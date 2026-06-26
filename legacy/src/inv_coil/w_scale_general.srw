$PBExportHeader$w_scale_general.srw
$PBExportComments$<Child> weight information retrieving from scale
forward
global type w_scale_general from w_child
end type
type sle_input from u_sle within w_scale_general
end type
type cb_reset from u_cb within w_scale_general
end type
type pb_scale from u_pb within w_scale_general
end type
type st_3 from statictext within w_scale_general
end type
type em_gross from u_em within w_scale_general
end type
type cb_exit from u_cb within w_scale_general
end type
end forward

global type w_scale_general from w_child
string tag = "weight"
integer x = 878
integer y = 486
integer width = 3101
integer height = 1174
string title = "WEIGHT"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type integer ue_readscale ( )
event type integer ue_reset ( )
sle_input sle_input
cb_reset cb_reset
pb_scale pb_scale
st_3 st_3
em_gross em_gross
cb_exit cb_exit
end type
global w_scale_general w_scale_general

type variables
Boolean ib_simulate_mode
end variables

event type integer ue_readscale();IF ib_simulate_mode THEN 
	em_gross.Text = String(Rand(32765))
ELSE
	em_gross.Text = String(f_read_scale())
END IF

//sle_input.Text = ""
sle_input.SetFocus()

RETURN 1
end event

event type integer ue_reset();IF ib_simulate_mode THEN 
	//nothing
ELSE
	f_reset_scale()
END IF

em_gross.Text='0'

sle_input.SetFocus()

RETURN 1
end event

on w_scale_general.create
int iCurrent
call super::create
this.sle_input=create sle_input
this.cb_reset=create cb_reset
this.pb_scale=create pb_scale
this.st_3=create st_3
this.em_gross=create em_gross
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_input
this.Control[iCurrent+2]=this.cb_reset
this.Control[iCurrent+3]=this.pb_scale
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.em_gross
this.Control[iCurrent+6]=this.cb_exit
end on

on w_scale_general.destroy
call super::destroy
destroy(this.sle_input)
destroy(this.cb_reset)
destroy(this.pb_scale)
destroy(this.st_3)
destroy(this.em_gross)
destroy(this.cb_exit)
end on

event open;call super::open;String ls_inifile, ls_simulate

ls_inifile = gnv_app.of_getappinifile( )
ls_simulate = ProfileString(ls_inifile,"SCALE","Scale_mode","simulate")
IF Upper(Trim(ls_simulate)) = "REAL" THEN
	ib_simulate_mode = FALSE
ELSE
	ib_simulate_mode = TRUE
END IF
end event

type sle_input from u_sle within w_scale_general
integer x = 2582
integer y = 150
integer width = 501
integer taborder = 10
string facename = "Arial"
end type

event constructor;call super::constructor;this.Visible = FALSE
end event

event modified;call super::modified;String ls_input, ls_pre

ls_input = This.Text
This.Text = ""
ls_input = LeftTrim(ls_input)
ls_input = RightTrim(ls_input)
IF Len(ls_input) <= 2 OR ISNULL(ls_input) THEN RETURN 0

ls_pre = Left(ls_input, 2)
CHOOSE CASE Upper(ls_pre)
	CASE "2A" //next
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "NEXT" THEN RETURN Parent.Event ue_reset()
	CASE "3A" //exit
		Close(Parent)
	CASE "4A" //read
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "READ" THEN RETURN Parent.Event ue_readscale()
END CHOOSE
		
RETURN 1

end event

type cb_reset from u_cb within w_scale_general
string tag = "Close this window"
integer x = 636
integer y = 774
integer width = 859
integer height = 250
integer taborder = 30
integer textsize = -36
string facename = "Arial"
string text = "&RESET"
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN Parent.Event ue_reset()
end event

type pb_scale from u_pb within w_scale_general
integer x = 2597
integer y = 266
integer width = 453
integer height = 394
integer taborder = 20
integer textsize = -24
integer weight = 700
string facename = "Arial"
boolean underline = true
string text = "Read Scale"
boolean cancel = true
boolean originalsize = false
vtextalign vtextalign = multiline!
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN Parent.Event ue_readscale()
end event

type st_3 from statictext within w_scale_general
integer x = 15
integer y = 10
integer width = 3061
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "---WEIGHT INFORMATION---"
alignment alignment = center!
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean disabledlook = true
end type

type em_gross from u_em within w_scale_general
integer x = 15
integer y = 230
integer width = 2560
integer height = 464
integer taborder = 0
integer textsize = -72
string facename = "Arial"
long textcolor = 255
long backcolor = 33554432
string text = "123456789"
alignment alignment = center!
boolean displayonly = true
string mask = "#########"
end type

type cb_exit from u_cb within w_scale_general
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 1671
integer y = 774
integer width = 859
integer height = 250
integer taborder = 40
integer textsize = -36
string facename = "Arial"
string text = "&EXIT"
end type

event clicked;call super::clicked;Close(Parent)
end event

