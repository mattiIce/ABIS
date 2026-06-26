$PBExportHeader$w_scale_coil.srw
$PBExportComments$<Child> coil weight information retrieving from scale
forward
global type w_scale_coil from w_child
end type
type sle_input from u_sle within w_scale_coil
end type
type st_coil from statictext within w_scale_coil
end type
type st_1 from statictext within w_scale_coil
end type
type p_1 from picture within w_scale_coil
end type
type pb_scale from u_pb within w_scale_coil
end type
type st_3 from statictext within w_scale_coil
end type
type st_2 from statictext within w_scale_coil
end type
type em_gross from u_em within w_scale_coil
end type
type cb_save from u_cb within w_scale_coil
end type
type cb_new from u_cb within w_scale_coil
end type
type cb_exit from u_cb within w_scale_coil
end type
end forward

global type w_scale_coil from w_child
string tag = "Coil weight"
integer x = 878
integer y = 486
integer width = 2889
integer height = 1642
string title = "COIL WEIGHT"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type long ue_next ( )
event type long ue_readscale ( )
sle_input sle_input
st_coil st_coil
st_1 st_1
p_1 p_1
pb_scale pb_scale
st_3 st_3
st_2 st_2
em_gross em_gross
cb_save cb_save
cb_new cb_new
cb_exit cb_exit
end type
global w_scale_coil w_scale_coil

type variables
Long il_coil, il_net
Boolean ib_isvalid, ib_simulate_mode, ib_newcoil
end variables

event type long ue_next();st_coil.Text = "COIL ID"
em_gross.Text='0'
sle_input.Text = ""
setNULL(il_coil)
ib_isvalid = FALSE

IF ib_simulate_mode THEN 
	//nothing
ELSE
	f_reset_scale()
END IF

sle_input.SetFocus()

RETURN 1
end event

event type long ue_readscale();IF ib_simulate_mode THEN 
	em_gross.Text = String(Rand(32765))
ELSE
	em_gross.Text = String(f_read_scale())
END IF

sle_input.SetFocus()

RETURN 1
end event

on w_scale_coil.create
int iCurrent
call super::create
this.sle_input=create sle_input
this.st_coil=create st_coil
this.st_1=create st_1
this.p_1=create p_1
this.pb_scale=create pb_scale
this.st_3=create st_3
this.st_2=create st_2
this.em_gross=create em_gross
this.cb_save=create cb_save
this.cb_new=create cb_new
this.cb_exit=create cb_exit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_input
this.Control[iCurrent+2]=this.st_coil
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.pb_scale
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_gross
this.Control[iCurrent+9]=this.cb_save
this.Control[iCurrent+10]=this.cb_new
this.Control[iCurrent+11]=this.cb_exit
end on

on w_scale_coil.destroy
call super::destroy
destroy(this.sle_input)
destroy(this.st_coil)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.pb_scale)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_gross)
destroy(this.cb_save)
destroy(this.cb_new)
destroy(this.cb_exit)
end on

event open;call super::open;ib_isvalid = FALSE
ib_newcoil = FALSE
il_net = 0

String ls_inifile, ls_simulate

ls_inifile = gnv_app.of_getappinifile( )
ls_simulate = ProfileString(ls_inifile,"SCALE","Scale_mode","simulate")
IF Upper(Trim(ls_simulate)) = "REAL" THEN
	ib_simulate_mode = FALSE
ELSE
	ib_simulate_mode = TRUE
END IF

end event

event pfc_save;Long ll_coil_wt
Boolean lb_update

lb_update = FALSE

sle_input.SetFocus()

IF IsNULL(il_coil) THEN
	MessageBox("Warning", "Invalid coil ID.")
	RETURN 0
END IF

IF NOT(ib_isvalid) THEN
	MessageBox("Warning", "Invalid coil ID.")
	RETURN 0
END IF

ll_coil_wt = Long(em_gross.Text)
IF ll_coil_wt <= 0 THEN
	MessageBox("Warning", "Invalid coil gross WT.")
	RETURN -1
END IF

IF ib_newcoil THEN 
	IF ABS(1000 * ((ll_coil_wt - il_net)/il_net)) > 5 THEN  //if there is 0.5% difference between coil wt and scale wt
		//send email
		UPDATE coil
		SET net_wt_balance = :ll_coil_wt, net_wt = :ll_coil_wt 
		WHERE coil_abc_num = :il_coil
		USING SQLCA;
		lb_update = TRUE
	END IF
ELSE //current wt only
	UPDATE coil
	SET net_wt_balance = :ll_coil_wt
	WHERE coil_abc_num = :il_coil
	USING SQLCA;
	lb_update = TRUE
END IF
IF lb_update THEN
	IF SQLCA.SQLCode >= 0 THEN
		COMMIT USING SQLCA;
		st_coil.Text = "COIL ID"
		em_gross.Text='0'
		sle_input.Text = ""
		setNULL(il_coil)
		ib_isvalid = FALSE
	ELSE
		MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
		Rollback using SQLCA;
	END IF
END IF

RETURN 1

end event

type sle_input from u_sle within w_scale_coil
integer x = 1488
integer y = 790
integer width = 574
integer taborder = 10
string facename = "Arial"
end type

event modified;call super::modified;String ls_input, ls_pre, ls_coil_id
Int li_status
Long ll_net_balance

ll_net_balance = 0

ls_input = This.Text
This.Text = ""
ls_input = LeftTrim(ls_input)
ls_input = RightTrim(ls_input)
IF Len(ls_input) <= 2 OR ISNULL(ls_input) THEN RETURN 0

ls_pre = Left(ls_input, 2)
CHOOSE CASE Upper(ls_pre)
	CASE "2S"
		st_coil.Text = " "
		il_coil = Long(Mid(ls_input, 3))
		IF il_coil <= 0 OR IsNULL(il_coil) THEN
			MessageBox("Warning", "Invalid coil ID.")
			Return -1
		END IF
		SetNULL(ls_coil_id)
		SELECT coil_org_num, coil_status, net_wt, net_wt_balance INTO :ls_coil_id, :li_status, :il_net, :ll_net_balance
		FROM coil
		WHERE coil_abc_num = :il_coil
		USING SQLCA;
		IF NOT(ISNULL(ls_coil_id)) THEN 
			ib_isvalid = TRUE
			st_coil.Text = ls_coil_id
			em_gross.Text = ""
			IF li_status = 0 OR li_status = 10 THEN 
				MessageBox("Warning", "This coil is done or shipped away. Please verify.")
				ib_isvalid = FALSE
				RETURN -2
			END IF
			IF  NOT(IsNULL(ll_net_balance)) AND NOT(IsNULL(il_net)) AND (il_net = ll_net_balance)  THEN 
				ib_newcoil = TRUE
			ELSE
				ib_newcoil = FALSE
			END IF
		END IF
	CASE "1A" //save
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "SAVE" THEN RETURN Parent.Event pfc_save()
	CASE "2A" //next
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "NEXT" THEN RETURN Parent.Event ue_next()
	CASE "3A" //exit
		Close(Parent)
	CASE "4A" //read
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "READ" THEN RETURN Parent.Event ue_readscale()
END CHOOSE
		
RETURN 1

end event

event constructor;call super::constructor;this.Visible = FALSE
end event

type st_coil from statictext within w_scale_coil
integer x = 55
integer y = 422
integer width = 2136
integer height = 285
integer textsize = -48
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 134217734
boolean enabled = false
string text = "ID"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_scale_coil
integer x = 51
integer y = 253
integer width = 1481
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CUSTOMER COIL ID:"
boolean focusrectangle = false
end type

type p_1 from picture within w_scale_coil
integer x = 2205
integer y = 208
integer width = 658
integer height = 576
boolean originalsize = true
string picturename = "scale_coil.JPG"
boolean focusrectangle = false
end type

type pb_scale from u_pb within w_scale_coil
integer x = 2253
integer y = 915
integer width = 567
integer height = 307
integer taborder = 20
integer textsize = -20
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

type st_3 from statictext within w_scale_coil
integer x = 51
integer width = 2820
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 65535
long backcolor = 67108864
string text = "---COIL WEIGHT INFORMATION---"
alignment alignment = center!
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_2 from statictext within w_scale_coil
integer x = 62
integer y = 787
integer width = 1232
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "COIL WEIGHT:"
boolean focusrectangle = false
end type

type em_gross from u_em within w_scale_coil
integer x = 55
integer y = 941
integer width = 2136
integer height = 285
integer taborder = 0
integer textsize = -52
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33554432
string text = "123456"
alignment alignment = center!
boolean displayonly = true
string mask = "#########"
end type

type cb_save from u_cb within w_scale_coil
string tag = "Save skid weight info"
integer x = 380
integer y = 1299
integer width = 611
integer height = 182
integer taborder = 30
integer textsize = -26
string facename = "Arial"
string text = "&Save"
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN parent.Event pfc_save()
end event

type cb_new from u_cb within w_scale_coil
string tag = "Next Skid"
integer x = 1178
integer y = 1299
integer width = 585
integer height = 182
integer taborder = 40
integer textsize = -26
string facename = "Arial"
string text = "&Next"
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN Parent.Event ue_next()

end event

type cb_exit from u_cb within w_scale_coil
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 1949
integer y = 1299
integer width = 585
integer height = 182
integer taborder = 50
integer textsize = -26
string facename = "Arial"
string text = "&EXIT"
end type

event clicked;call super::clicked;Close(Parent)
end event

