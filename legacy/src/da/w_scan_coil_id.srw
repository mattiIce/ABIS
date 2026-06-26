$PBExportHeader$w_scan_coil_id.srw
forward
global type w_scan_coil_id from w_response
end type
type st_actual_wt from statictext within w_scan_coil_id
end type
type em_coil_abc_wt from editmask within w_scan_coil_id
end type
type st_abc_id from statictext within w_scan_coil_id
end type
type st_coil from statictext within w_scan_coil_id
end type
type st_warning from statictext within w_scan_coil_id
end type
type cb_enter from u_cb within w_scan_coil_id
end type
type cb_confirm from u_cb within w_scan_coil_id
end type
type cb_cancel from commandbutton within w_scan_coil_id
end type
type st_1 from statictext within w_scan_coil_id
end type
type em_coil from u_em within w_scan_coil_id
end type
end forward

global type w_scan_coil_id from w_response
integer x = 214
integer width = 1232
integer height = 966
st_actual_wt st_actual_wt
em_coil_abc_wt em_coil_abc_wt
st_abc_id st_abc_id
st_coil st_coil
st_warning st_warning
cb_enter cb_enter
cb_confirm cb_confirm
cb_cancel cb_cancel
st_1 st_1
em_coil em_coil
end type
global w_scan_coil_id w_scan_coil_id

type variables
long il_coil_id, il_row
u_tabpg_new_coil iu_tabpg_new_coil
boolean ib_no_look
string is_previous_id = ""
end variables

forward prototypes
public function long wf_lookup (string as_id)
end prototypes

public function long wf_lookup (string as_id);//return 0

//MessageBox("", this.text )
String ls_id
long ll_pos
ls_id = as_id
//ls_id = Upper(Trim(em_coil.text))
ls_id= Upper(Trim(ls_id ))
ll_pos = POS(ls_id, "2S")
ib_no_look = false
n_cst_string ln_func
if as_id = is_previous_id then return 0
if ll_pos > 0 then
	ls_id = Mid(ls_id , ll_pos + 2)
	ib_no_look = true
end if


//ls_id = Mid(this.text, 3)
//ls_id = Trim(ls_id)
long ll_rc
//MessageBox("", ls_id )

if IsNull(ls_id) or (not isNumber( ls_id )) or ( not ln_func.of_isalphanum( ls_id )) then 
//	em_coil.text = ls_id
	cb_confirm.enabled = false
	st_coil.visible = false
	st_warning.visible = true
	st_abc_id.visible = false
	st_actual_wt.visible = false
	em_coil_abc_wt.visible = false
	em_coil.setfocus( )
	em_coil.selecttext( 1, Len(em_coil.text ))
	is_previous_id = ls_id
	return 0
end if

ll_rc = iu_tabpg_new_coil.dw_coils.find( "process_coil_coil_abc_num=" + ls_id, 1, iu_tabpg_new_coil.dw_coils.rowcount( ) ) 


//if ib_no_look then
//	em_coil.text = ls_id
//end if

if ll_rc > 0 and ll_rc < 999 then
//	CloseWithReturn(parent, ll_rc)
	il_row = ll_rc
	cb_confirm.enabled = true
	
	st_coil.text = "Coil No :" + string(iu_tabpg_new_coil.dw_coils.object.coil_coil_org_num[il_row]) + &
				"  Gauge: " + string( iu_tabpg_new_coil.dw_coils.object.coil_coil_gauge[il_row] ) + &
				"  Weight: " + string( iu_tabpg_new_coil.dw_coils.object.coil_net_wt_balance[il_row] ) +"LB"
	
	st_abc_id.text ="Coil AB Id: " + string( iu_tabpg_new_coil.dw_coils.object.process_coil_coil_abc_num[il_row] )   
	st_coil.visible = true
	st_warning.visible = false
//	em_coil.text = ""
	em_coil.text = ls_id
	st_abc_id.visible = true
	st_actual_wt.visible = true
	em_coil_abc_wt.visible = true
	em_coil.setfocus( )
	em_coil.selecttext( 1, Len(em_coil.text ))
else
//if Long(ls_id ) = il_coil_id then
//	CloseWithReturn(parent, 1)
//else
	em_coil.text = ls_id
	cb_confirm.enabled = false
	st_coil.visible = false
	st_warning.visible = true
	st_abc_id.visible = false
	st_actual_wt.visible = false
	em_coil_abc_wt.visible = false
	em_coil.setfocus( )
	em_coil.selecttext( 1, Len(em_coil.text ))
end if
is_previous_id = ls_id
return 0
end function

on w_scan_coil_id.create
int iCurrent
call super::create
this.st_actual_wt=create st_actual_wt
this.em_coil_abc_wt=create em_coil_abc_wt
this.st_abc_id=create st_abc_id
this.st_coil=create st_coil
this.st_warning=create st_warning
this.cb_enter=create cb_enter
this.cb_confirm=create cb_confirm
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.em_coil=create em_coil
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_actual_wt
this.Control[iCurrent+2]=this.em_coil_abc_wt
this.Control[iCurrent+3]=this.st_abc_id
this.Control[iCurrent+4]=this.st_coil
this.Control[iCurrent+5]=this.st_warning
this.Control[iCurrent+6]=this.cb_enter
this.Control[iCurrent+7]=this.cb_confirm
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.em_coil
end on

on w_scan_coil_id.destroy
call super::destroy
destroy(this.st_actual_wt)
destroy(this.em_coil_abc_wt)
destroy(this.st_abc_id)
destroy(this.st_coil)
destroy(this.st_warning)
destroy(this.cb_enter)
destroy(this.cb_confirm)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.em_coil)
end on

event pfc_postopen;call super::pfc_postopen;em_coil.setfocus( )
//em_coil.visible = false
end event

event open;call super::open;//if gi_screen = 2 then
//	this.x = 7000
//	this.y = 600
//end if

if gi_screen = 2 then
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

type st_actual_wt from statictext within w_scan_coil_id
boolean visible = false
integer x = 51
integer y = 589
integer width = 669
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
string text = "Actual coil weight (if known)"
boolean focusrectangle = false
end type

type em_coil_abc_wt from editmask within w_scan_coil_id
boolean visible = false
integer x = 768
integer y = 576
integer width = 413
integer height = 96
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_abc_id from statictext within w_scan_coil_id
boolean visible = false
integer x = 44
integer y = 410
integer width = 1141
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
string text = "Coil ABC ID:"
boolean focusrectangle = false
end type

type st_coil from statictext within w_scan_coil_id
boolean visible = false
integer x = 44
integer y = 496
integer width = 1141
integer height = 67
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
string text = "Coil No."
boolean focusrectangle = false
end type

type st_warning from statictext within w_scan_coil_id
boolean visible = false
integer x = 55
integer y = 154
integer width = 505
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "No coil found"
boolean focusrectangle = false
end type

type cb_enter from u_cb within w_scan_coil_id
integer x = 896
integer y = 243
integer width = 267
integer height = 122
integer taborder = 0
integer textsize = -12
string text = "Enter"
end type

event clicked;call super::clicked;//em_coil.accept
//em_coil.text = em_enter.text
//em_coil.event modified( )
//MessageBox("",em_coil.text )
wf_lookup( em_coil.text)  
//
em_coil.setfocus( )
em_coil.selecttext( 1, Len(em_coil.text))
end event

type cb_confirm from u_cb within w_scan_coil_id
integer x = 37
integer y = 710
integer width = 516
integer height = 141
integer taborder = 0
integer textsize = -12
boolean enabled = false
string text = "Confirm"
end type

event clicked;call super::clicked;if il_row > 0 then
	long ll_coil, ll_wt
	if IsNumber(em_coil_abc_wt.text) and Long(em_coil_abc_wt.text) > 100 and Long(em_coil_abc_wt.text) < 99999 then
		ll_wt = Long(em_coil_abc_wt.text)
		ll_coil = iu_tabpg_new_coil.dw_coils.object.process_coil_coil_abc_num[il_row]	
		
		UPDATE "COIL"  
     	SET "ABCO_COIL_NET_WT" = :ll_wt  
   	WHERE "COIL"."COIL_ABC_NUM" = :ll_coil   
      ;
		if sqlca.sqlcode = 0 then
			sqlca.of_commit( )
		else
			sqlca.of_rollback( )
		end if
	end if
	
	CloseWithReturn(parent, il_row)
else
	this.enabled = false
end if
end event

type cb_cancel from commandbutton within w_scan_coil_id
integer x = 673
integer y = 714
integer width = 516
integer height = 141
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

type st_1 from statictext within w_scan_coil_id
integer x = 201
integer y = 42
integer width = 874
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please scan coil Bar-code"
boolean focusrectangle = false
end type

type em_coil from u_em within w_scan_coil_id
integer x = 51
integer y = 243
integer width = 805
integer height = 118
integer taborder = 10
integer textsize = -12
textcase textcase = upper!
maskdatatype maskdatatype = stringmask!
string mask = ""
end type

event constructor;call super::constructor;//il_coil_id = message.doubleparm
iu_tabpg_new_coil = message.powerobjectparm
ib_no_look = false
//il_coil_id = iu_tabpg_new_coil.il_coil
//MessageBox("", string(il_job))
//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_setcloseonclick( true)
//this.iuo_calculator.of_setinitialvalue( true)
//il_job = message.doubleparm
//MessageBox("", string(il_job))
end event

event modified;//if not ib_no_look then 
	return wf_lookup( this.text )
//else
//	ib_no_look = false
//	return 0
//end if

//String ls_id
//long ll_pos
//ls_id = Upper(Trim(em_coil.text))
//ll_pos = POS(ls_id, "2S")
//
//if ll_pos > 0 then
//	ls_id = Mid(ls_id , ll_pos + 2)
//end if
//
//
//long ll_rc
//
//if IsNull(ls_id) or (not isNumber( ls_id ))  then
//	cb_confirm.enabled = false
//	st_coil.visible = false
//	st_warning.visible = true
//	st_abc_id.visible = false
//	if Not isNull(ls_id) then
//		em_coil.setfocus( )
//		em_coil.selecttext( 1, Len(em_coil.text ))
//	end if
//	return 0
//end if
//
//
//ll_rc = iu_tabpg_new_coil.dw_coils.find( "process_coil_coil_abc_num=" + ls_id, 1, iu_tabpg_new_coil.dw_coils.rowcount( ) ) 
//
//if ll_rc > 0 and ll_rc < 999 then
//	il_row = ll_rc
//	cb_confirm.enabled = true
//	
//	st_coil.text = "Coil No :" + string(iu_tabpg_new_coil.dw_coils.object.coil_coil_org_num[il_row]) + &
//				"  Gauge: " + string( iu_tabpg_new_coil.dw_coils.object.coil_coil_gauge[il_row] ) + &
//				"  Weight: " + string( iu_tabpg_new_coil.dw_coils.object.coil_net_wt_balance[il_row] ) +"LB"
//	
//	st_abc_id.text ="Coil AB Id: " + string( iu_tabpg_new_coil.dw_coils.object.process_coil_coil_abc_num[il_row] )   
//	st_coil.visible = true
//	st_warning.visible = false
//	em_coil.text = ls_id
//	st_abc_id.visible = true
//	em_coil.setfocus( )
//	em_coil.selecttext( 1, Len(em_coil.text ))
//else
//	cb_confirm.enabled = false
//	st_coil.visible = false
//	st_warning.visible = true
//	st_abc_id.visible = false
//	em_coil.setfocus( )
//	em_coil.selecttext( 1, Len(em_coil.text ))
//end if
end event

