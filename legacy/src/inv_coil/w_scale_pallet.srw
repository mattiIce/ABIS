$PBExportHeader$w_scale_pallet.srw
$PBExportComments$<Child>Pallet weight information retrieving from scale
forward
global type w_scale_pallet from w_child
end type
type st_msg from statictext within w_scale_pallet
end type
type sle_input from u_sle within w_scale_pallet
end type
type st_prod from statictext within w_scale_pallet
end type
type st_1 from statictext within w_scale_pallet
end type
type p_1 from picture within w_scale_pallet
end type
type pb_scale from u_pb within w_scale_pallet
end type
type st_3 from statictext within w_scale_pallet
end type
type st_2 from statictext within w_scale_pallet
end type
type em_gross from u_em within w_scale_pallet
end type
type cb_save from u_cb within w_scale_pallet
end type
type cb_new from u_cb within w_scale_pallet
end type
type cb_exit from u_cb within w_scale_pallet
end type
end forward

global type w_scale_pallet from w_child
string tag = " pallet weight"
integer x = 350
integer y = 100
integer width = 2929
integer height = 1734
string title = "PALLET WEIGHT"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event type long ue_next ( )
event type long ue_readscale ( )
event ue_display_message ( string as_msg )
st_msg st_msg
sle_input sle_input
st_prod st_prod
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
global w_scale_pallet w_scale_pallet

type variables
Long il_job
Boolean ib_isvalid, ib_simulate_mode
end variables

event type long ue_next();st_prod.Text = "ID"
em_gross.Text='0'
sle_input.Text = ""
setNULL(il_job)
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

event ue_display_message(string as_msg);st_msg.Visible = TRUE
st_msg.Text = as_msg
Timer(5)

end event

on w_scale_pallet.create
int iCurrent
call super::create
this.st_msg=create st_msg
this.sle_input=create sle_input
this.st_prod=create st_prod
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
this.Control[iCurrent+1]=this.st_msg
this.Control[iCurrent+2]=this.sle_input
this.Control[iCurrent+3]=this.st_prod
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.pb_scale
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.em_gross
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.cb_new
this.Control[iCurrent+12]=this.cb_exit
end on

on w_scale_pallet.destroy
call super::destroy
destroy(this.st_msg)
destroy(this.sle_input)
destroy(this.st_prod)
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
String ls_inifile, ls_simulate

ls_inifile = gnv_app.of_getappinifile( )
ls_simulate = ProfileString(ls_inifile,"SCALE","Scale_mode","simulate")
IF Upper(Trim(ls_simulate)) = "REAL" THEN
	ib_simulate_mode = FALSE
ELSE
	ib_simulate_mode = TRUE
END IF
st_msg.Visible = FALSE
end event

event pfc_save;Long ll_tare
Boolean lb_update

lb_update = FALSE

sle_input.SetFocus()

IF IsNULL(il_job) THEN
	this.Event ue_display_message("Warning : Invalid Production Order.")
	RETURN 0
END IF

IF NOT(ib_isvalid) THEN
	this.Event ue_display_message("Warning : Invalid Production Order.")
	RETURN 0
END IF

ll_tare = Long(em_gross.Text)
IF ll_tare <= 1 THEN
	this.Event ue_display_message("Warning : Invalid Pallet WT.")
	RETURN -1
END IF

UPDATE ab_job
SET job_tare_wt = :ll_tare
WHERE ab_job_num = :il_job
USING SQLCA;

lb_update = TRUE

IF lb_update THEN
	IF SQLCA.SQLCode >= 0 THEN
		COMMIT USING SQLCA;
		st_prod.Text = "ID"
		em_gross.Text='0'
		sle_input.Text = ""
		setNULL(il_job)
		ib_isvalid = FALSE
	ELSE
		MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
		Rollback using SQLCA;
	END IF
END IF

this.Event ue_display_message("Data saved!")

this.Event ue_next()

RETURN 1

end event

event timer;call super::timer;st_msg.Text = ""
st_msg.Visible = FALSE
end event

type st_msg from statictext within w_scale_pallet
integer x = 37
integer y = 1546
integer width = 2860
integer height = 86
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_input from u_sle within w_scale_pallet
integer x = 2172
integer y = 800
integer width = 574
integer taborder = 10
string facename = "Arial"
end type

event modified;call super::modified;String ls_input, ls_pre
Long ll_exist

ls_input = This.Text
This.Text = ""
ls_input = RightTrim(LeftTrim(ls_input))
IF Len(ls_input) <= 2 OR ISNULL(ls_input) THEN RETURN 0

ls_pre = Left(ls_input, 1)
	IF UPPER(ls_pre) = 'P' THEN
		st_prod.Text = " "
		il_job = Long(Mid(ls_input, 2, (Len(ls_input) - 1)))
		IF il_job <= 0 OR IsNULL(il_job) THEN
			Parent.Event ue_display_message("Warning: Invalid Production Order.")
			Return -1
		END IF
		SELECT count(ab_job_num) INTO :ll_exist
		FROM ab_job
		WHERE ab_job_num = :il_job
		USING SQLCA;
		IF ll_exist = 1 THEN 
			ib_isvalid = TRUE
			st_prod.Text = String(il_job)
			em_gross.Text = ""
		ELSE
			Parent.Event ue_display_message("Warning:Production Order does not exist.")
			Return -2			
		END IF
	END IF	
				
ls_pre = Left(ls_input, 2)
CHOOSE CASE Upper(ls_pre)
	CASE "1A" //save
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "SAVE" THEN RETURN Parent.Event pfc_save()
	CASE "2A" //reset
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

type st_prod from statictext within w_scale_pallet
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_scale_pallet
integer x = 51
integer y = 253
integer width = 1624
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "PRODUCTION ORDER:"
boolean focusrectangle = false
end type

type p_1 from picture within w_scale_pallet
integer x = 2213
integer y = 208
integer width = 658
integer height = 560
boolean originalsize = true
string picturename = "scale_pallet.JPG"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_scale from u_pb within w_scale_pallet
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

type st_3 from statictext within w_scale_pallet
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
string text = "---PALLET WEIGHT INFORMATION---"
alignment alignment = center!
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_2 from statictext within w_scale_pallet
integer x = 62
integer y = 787
integer width = 1777
integer height = 144
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "PALLET WEIGHT / EACH"
boolean focusrectangle = false
end type

type em_gross from u_em within w_scale_pallet
integer x = 55
integer y = 941
integer width = 2136
integer height = 285
integer taborder = 0
integer textsize = -52
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33554432
string text = "0"
alignment alignment = center!
boolean displayonly = true
string mask = "#########"
end type

type cb_save from u_cb within w_scale_pallet
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

type cb_new from u_cb within w_scale_pallet
string tag = "Reset"
integer x = 1178
integer y = 1299
integer width = 585
integer height = 182
integer taborder = 40
integer textsize = -26
string facename = "Arial"
string text = "&Reset"
end type

event clicked;call super::clicked;sle_input.SetFocus()

RETURN Parent.Event ue_next()

end event

type cb_exit from u_cb within w_scale_pallet
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

