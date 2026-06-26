$PBExportHeader$w_recap.srw
forward
global type w_recap from w_popup
end type
type cb_print from commandbutton within w_recap
end type
type cb_cancel from commandbutton within w_recap
end type
type st_1 from statictext within w_recap
end type
type rb_done from radiobutton within w_recap
end type
type rb_rebanded from radiobutton within w_recap
end type
type rb_onhold from radiobutton within w_recap
end type
type rb_inprocess from radiobutton within w_recap
end type
type rb_reject from radiobutton within w_recap
end type
type pb_new_coil_wt from u_pb within w_recap
end type
type st_2 from statictext within w_recap
end type
type pb_coil_wt from u_pb within w_recap
end type
type em_coil_wt from u_em within w_recap
end type
type st_5 from statictext within w_recap
end type
type st_wt_prompt from statictext within w_recap
end type
type st_3 from statictext within w_recap
end type
type st_4 from statictext within w_recap
end type
type st_coil_org_num from statictext within w_recap
end type
type st_6 from statictext within w_recap
end type
type st_7 from statictext within w_recap
end type
type st_8 from statictext within w_recap
end type
type st_skid_wt from statictext within w_recap
end type
type st_scrap_wt from statictext within w_recap
end type
type st_hl from statictext within w_recap
end type
type st_percent from statictext within w_recap
end type
type st_9 from statictext within w_recap
end type
type cb_refresh from commandbutton within w_recap
end type
type cb_ok from commandbutton within w_recap
end type
type gb_status from groupbox within w_recap
end type
type em_new_coil_wt from u_em within w_recap
end type
end forward

global type w_recap from w_popup
integer x = 0
integer y = 0
integer width = 3738
integer height = 570
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 16776960
cb_print cb_print
cb_cancel cb_cancel
st_1 st_1
rb_done rb_done
rb_rebanded rb_rebanded
rb_onhold rb_onhold
rb_inprocess rb_inprocess
rb_reject rb_reject
pb_new_coil_wt pb_new_coil_wt
st_2 st_2
pb_coil_wt pb_coil_wt
em_coil_wt em_coil_wt
st_5 st_5
st_wt_prompt st_wt_prompt
st_3 st_3
st_4 st_4
st_coil_org_num st_coil_org_num
st_6 st_6
st_7 st_7
st_8 st_8
st_skid_wt st_skid_wt
st_scrap_wt st_scrap_wt
st_hl st_hl
st_percent st_percent
st_9 st_9
cb_refresh cb_refresh
cb_ok cb_ok
gb_status gb_status
em_new_coil_wt em_new_coil_wt
end type
global w_recap w_recap

type variables
long il_old_nt
long il_new_nt
int ii_old_status
int ii_new_status
w_enter_num iw_enter_num
u_coil iu_coil
long il_skid_total, il_scrap_total, il_hl
Real ir_hl_percent
w_production_control_validation iw_production_control_validation
end variables

forward prototypes
public function long of_get_reject_wt ()
public function long of_get_reband_wt ()
public function double of_get_coil_yield ()
end prototypes

public function long of_get_reject_wt ();long ll_reject_wt

if this.rb_reject.checked then
	ll_reject_wt = Long( this.em_new_coil_wt )
else
	ll_reject_wt = 0
end if

return ll_reject_wt

end function

public function long of_get_reband_wt ();long ll_reband_wt

if this.rb_rebanded.checked then
	ll_reband_wt = Long( this.em_new_coil_wt )
else
	ll_reband_wt = 0
end if

return ll_reband_wt

end function

public function double of_get_coil_yield ();double ld_yield

ld_yield = (this.il_skid_total / (this.il_old_nt - this.of_get_reband_wt( ))) * 100
ld_yield = Round(ld_yield, 2 )

return ld_yield
end function

on w_recap.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.rb_done=create rb_done
this.rb_rebanded=create rb_rebanded
this.rb_onhold=create rb_onhold
this.rb_inprocess=create rb_inprocess
this.rb_reject=create rb_reject
this.pb_new_coil_wt=create pb_new_coil_wt
this.st_2=create st_2
this.pb_coil_wt=create pb_coil_wt
this.em_coil_wt=create em_coil_wt
this.st_5=create st_5
this.st_wt_prompt=create st_wt_prompt
this.st_3=create st_3
this.st_4=create st_4
this.st_coil_org_num=create st_coil_org_num
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_skid_wt=create st_skid_wt
this.st_scrap_wt=create st_scrap_wt
this.st_hl=create st_hl
this.st_percent=create st_percent
this.st_9=create st_9
this.cb_refresh=create cb_refresh
this.cb_ok=create cb_ok
this.gb_status=create gb_status
this.em_new_coil_wt=create em_new_coil_wt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.rb_done
this.Control[iCurrent+5]=this.rb_rebanded
this.Control[iCurrent+6]=this.rb_onhold
this.Control[iCurrent+7]=this.rb_inprocess
this.Control[iCurrent+8]=this.rb_reject
this.Control[iCurrent+9]=this.pb_new_coil_wt
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.pb_coil_wt
this.Control[iCurrent+12]=this.em_coil_wt
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.st_wt_prompt
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.st_coil_org_num
this.Control[iCurrent+18]=this.st_6
this.Control[iCurrent+19]=this.st_7
this.Control[iCurrent+20]=this.st_8
this.Control[iCurrent+21]=this.st_skid_wt
this.Control[iCurrent+22]=this.st_scrap_wt
this.Control[iCurrent+23]=this.st_hl
this.Control[iCurrent+24]=this.st_percent
this.Control[iCurrent+25]=this.st_9
this.Control[iCurrent+26]=this.cb_refresh
this.Control[iCurrent+27]=this.cb_ok
this.Control[iCurrent+28]=this.gb_status
this.Control[iCurrent+29]=this.em_new_coil_wt
end on

on w_recap.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.rb_done)
destroy(this.rb_rebanded)
destroy(this.rb_onhold)
destroy(this.rb_inprocess)
destroy(this.rb_reject)
destroy(this.pb_new_coil_wt)
destroy(this.st_2)
destroy(this.pb_coil_wt)
destroy(this.em_coil_wt)
destroy(this.st_5)
destroy(this.st_wt_prompt)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_coil_org_num)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_skid_wt)
destroy(this.st_scrap_wt)
destroy(this.st_hl)
destroy(this.st_percent)
destroy(this.st_9)
destroy(this.cb_refresh)
destroy(this.cb_ok)
destroy(this.gb_status)
destroy(this.em_new_coil_wt)
end on

event open;call super::open;iu_coil = message.powerobjectparm
this.title = "Coil " + iu_coil.get_coil_org_id( )
st_coil_org_num.text = iu_coil.get_coil_org_id( )
il_old_nt = iu_coil.of_get_init_wt( )
em_coil_wt.text = string(il_old_nt )
em_new_coil_wt.text = "0"
em_new_coil_wt.enabled = false
il_new_nt = 0
ii_new_status = 0
il_hl =  il_skid_total + il_scrap_total + il_new_nt - il_old_nt
ir_hl_percent = Round(ABS(il_hl / il_old_nt ),4) * 100
st_skid_wt.text = string( il_skid_total  )
st_scrap_wt.text = string( il_scrap_total )
st_hl.text = string( il_hl )
st_percent.text = string( ir_hl_percent )

end event

event close;call super::close;if isValid( iw_enter_num ) then
	close(iw_enter_num)
end if

if isValid( iw_production_control_validation  ) then
	close(iw_production_control_validation)
end if

end event

type cb_print from commandbutton within w_recap
integer x = 3343
integer y = 19
integer width = 377
integer height = 106
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print Eval"
end type

event clicked;Datastore lds_eval
parent.cb_refresh.event clicked( )
long ll_job, ll_coil, ll_shift,ll_reband_wt,ll_reject_wt
double ld_yield
		lds_eval = create datastore
		lds_eval.dataobject = "d_coil_evaluation"
		lds_eval.settransobject( sqlca)
		ll_job = parent.iu_coil.get_current_job( )
		ll_coil = parent.iu_coil.get_coil_abc_id( )
		ll_shift = parent.iu_coil.of_get_shift_id( )
		
		ll_reband_wt = parent.of_get_reband_wt( )
		ll_reject_wt = parent.of_get_reject_wt( )
		ld_yield = parent.of_get_coil_yield( )
		
		lds_eval.retrieve(ll_shift, ll_coil, ll_job )
		
		//Set reject reband info
		lds_eval.object.t_reject_wt.text = string( ll_reject_wt )
		lds_eval.object.t_reband_wt.text = string( ll_reband_wt )
		lds_eval.object.t_coil_yield.text = string( ld_yield ) + "%"
		lds_eval.print( )
end event

type cb_cancel from commandbutton within w_recap
integer x = 3343
integer y = 154
integer width = 377
integer height = 106
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_recap
integer x = 3204
integer y = 429
integer width = 124
integer height = 83
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "LB."
boolean focusrectangle = false
end type

type rb_done from radiobutton within w_recap
integer x = 73
integer y = 419
integer width = 271
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 16776960
string text = "Done"
boolean checked = true
end type

event clicked;parent.st_wt_prompt.text = "Done Coil"
//parent.st_new_wt.text = "0"
//parent.st_new_wt.enabled = false
em_new_coil_wt.text = "0"
em_new_coil_wt.enabled = false
pb_new_coil_wt.enabled = false
parent.ii_new_status = 0
parent.il_new_nt = 0
parent.cb_refresh.event clicked( )


end event

type rb_rebanded from radiobutton within w_recap
integer x = 410
integer y = 419
integer width = 450
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16776960
string text = "Rebanded"
end type

event clicked;parent.st_wt_prompt.text = "Rebandeded Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true

parent.ii_new_status = 7

end event

type rb_onhold from radiobutton within w_recap
integer x = 1317
integer y = 419
integer width = 369
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 16776960
string text = "On Hold"
end type

event clicked;parent.st_wt_prompt.text = "OnHold Weight"
//parent.st_wt_prompt.text = "Rejected Weight"
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
//parent.st_new_wt.enabled = true
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 4
end event

type rb_inprocess from radiobutton within w_recap
integer x = 1755
integer y = 419
integer width = 783
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 16776960
string text = "Same coil change job"
end type

event clicked;st_wt_prompt.text = "Unprocess Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 1

end event

type rb_reject from radiobutton within w_recap
integer x = 929
integer y = 419
integer width = 322
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16776960
string text = "Reject"
end type

event clicked;parent.st_wt_prompt.text = "Rejected Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 3

end event

type pb_new_coil_wt from u_pb within w_recap
integer x = 3054
integer y = 400
integer width = 154
integer height = 96
integer taborder = 50
boolean enabled = false
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;//em_new_coil_wt.Event pfc_DDCalculator( )
s_position ls_p
ls_p.x = x - 300
ls_p.y = y
OpenWithParm(iw_enter_num, ls_p, parent)
if not isValid( this ) then
	return 0
end if
em_new_coil_wt.text = Message.StringParm
em_new_coil_wt.event modified( )

end event

type st_2 from statictext within w_recap
integer x = 40
integer y = 90
integer width = 135
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "Coil"
boolean focusrectangle = false
end type

type pb_coil_wt from u_pb within w_recap
integer x = 969
integer y = 77
integer width = 135
integer height = 96
integer taborder = 40
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;//em_new_coil_wt.Event pfc_DDCalculator( )
//s_position ls_p
//ls_p.x = x
//ls_p.y = y
//OpenWithParm(iw_enter_num, ls_p, parent)
//if not isValid( this ) then
//	return 0
//end if
//em_coil_wt.text = Message.StringParm
long ll_rc
	OpenWithParm(iw_production_control_validation, iu_coil.of_get_sheet_window( ).is_prod_control_password , parent)
	ll_rc = message.doubleparm
	if not isValid( this ) then
		return 1
	end if
	if ll_rc = 1 then
		em_coil_wt.enabled = true
	else
		em_coil_wt.enabled = false
	end if
end event

type em_coil_wt from u_em within w_recap
integer x = 614
integer y = 77
integer width = 358
integer height = 96
integer taborder = 30
integer textsize = -12
boolean enabled = false
string text = "0000"
string mask = "#####"
boolean spin = true
string minmax = "0~~50000"
end type

event constructor;call super::constructor;//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_setcloseonclick( true)
//this.iuo_calculator.of_setinitialvalue( true)
end event

event modified;call super::modified;long ll_coil_init_wt
long ll_coil, ll_job
ll_coil_init_wt = Long(this.text)
ll_coil = iu_coil.get_coil_abc_id( )
ll_job = iu_coil.get_current_job( )
if ll_coil_init_wt <> il_old_nt then
	//init coil weight changed
			
	  UPDATE "PROCESS_COIL"  
     	SET "PROCESS_QUANTITY" = :ll_coil_init_wt  
   	WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :ll_coil ) AND  
         ( "PROCESS_COIL"."AB_JOB_NUM" = :ll_job )   
           ;
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			return 0
		else
			sqlca.of_commit( )
		end if
			
	il_old_nt = ll_coil_init_wt
	cb_refresh.event clicked( )
end if
end event

type st_5 from statictext within w_recap
integer x = 2626
integer y = 83
integer width = 135
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "and"
boolean focusrectangle = false
end type

type st_wt_prompt from statictext within w_recap
integer x = 2794
integer y = 83
integer width = 483
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "Coil weight"
boolean focusrectangle = false
end type

type st_3 from statictext within w_recap
integer x = 1104
integer y = 83
integer width = 121
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "LB."
boolean focusrectangle = false
end type

type st_4 from statictext within w_recap
integer x = 1232
integer y = 83
integer width = 1382
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "had been processed, please update status"
end type

type st_coil_org_num from statictext within w_recap
integer x = 183
integer y = 83
integer width = 406
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16776960
string text = "none"
boolean focusrectangle = false
end type

type st_6 from statictext within w_recap
integer x = 26
integer y = 221
integer width = 527
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "Good skid tatal:"
boolean focusrectangle = false
end type

type st_7 from statictext within w_recap
integer x = 1006
integer y = 221
integer width = 391
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "Scrap tatal:"
boolean focusrectangle = false
end type

type st_8 from statictext within w_recap
integer x = 1807
integer y = 221
integer width = 805
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "Heavy/Light Discrepancy"
boolean focusrectangle = false
end type

type st_skid_wt from statictext within w_recap
integer x = 563
integer y = 221
integer width = 263
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16776960
string text = "none"
boolean focusrectangle = false
end type

type st_scrap_wt from statictext within w_recap
integer x = 1401
integer y = 221
integer width = 278
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16776960
string text = "none"
boolean focusrectangle = false
end type

type st_hl from statictext within w_recap
integer x = 2629
integer y = 221
integer width = 256
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16776960
string text = "none"
boolean focusrectangle = false
end type

type st_percent from statictext within w_recap
integer x = 2896
integer y = 221
integer width = 179
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 16776960
string text = "none"
boolean focusrectangle = false
end type

type st_9 from statictext within w_recap
integer x = 3087
integer y = 221
integer width = 102
integer height = 77
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 16776960
string text = "%"
boolean focusrectangle = false
end type

type cb_refresh from commandbutton within w_recap
integer x = 3343
integer y = 288
integer width = 377
integer height = 106
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Refresh"
end type

event clicked;if not isValid( iu_coil) then
	return 1
end if
//	iu_coil.of_get_tab_page( ).dw_skid_item.accepttext( )
//	iu_coil.of_get_tab_page( ).dw_scrap.accepttext( )
//	
//if iu_coil.of_get_tab_page( ).dw_skid_item.rowcount( ) < 1 then
//	il_skid_total = 0
//else
//	il_skid_total = iu_coil.of_get_tab_page( ).dw_skid_item.object.compute_sum_item_nw[1]
//end if
//	
//if iu_coil.of_get_tab_page( ).dw_scrap.rowcount( ) < 1 then
//	il_scrap_total = 0
//else
//	il_scrap_total = iu_coil.of_get_tab_page( ).dw_scrap.object.compute_1[1]
//end if

//il_old_nt = Long( em_coil_wt.text )
il_hl = il_skid_total + il_scrap_total + il_new_nt - il_old_nt
ir_hl_percent = Round(ABS(il_hl / il_old_nt ),4) * 100
st_skid_wt.text = string( il_skid_total  )
st_scrap_wt.text = string( il_scrap_total )
st_hl.text = string( il_hl )
st_percent.text = string( ir_hl_percent )

end event

type cb_ok from commandbutton within w_recap
integer x = 3343
integer y = 422
integer width = 377
integer height = 106
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;//if iu_coil.get_coil_shift_status( ) = 2 then
//	
//	choose case ii_new_status
//		case 0	//done
//			iu_coil.finish( 0, 0)
//		case 4	//onhold
//			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) < iu_coil.get_old_nw( ) then
//				iu_coil.finish( 4, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt and > 0!"
//				return 0
//			end if
//		case 1	//inProcess
//			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) < iu_coil.get_old_nw( ) then
//				iu_coil.finish( 1, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt and > 0!"
//				return 0
//			end if
//		case else
//			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) < iu_coil.get_old_nw( ) then
//				iu_coil.finish( ii_new_status, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt and >0!"
//				return 0
//			end if
//	end choose
//else
//		choose case ii_new_status
//		case 0	//done
//			iu_coil.finish( 0, 0)
//		case 4	//onhold
//			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) <= iu_coil.get_old_nw( ) then
//				iu_coil.finish( 4, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt and > 0!"
//				return 0
//			end if
//		case 1	//inProcess
//			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) <= iu_coil.get_old_nw( ) then
//				iu_coil.finish( 1, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt and > 0!"
//				return 0
//			end if
//		case else
//			if Long(st_new_wt.text) > 0 and Long(st_new_wt.text) <= iu_coil.get_old_nw( ) then
//				iu_coil.finish( ii_new_status, Long(st_new_wt.text))
//			else 
//				st_warning.text = "Weight must be less than old wt and > 0!"
//				return 0
//			end if
//	end choose	
//	
//end if
//

cb_refresh.event clicked( )
if ir_hl_percent > 0.5 then
		//not balance
		MessageBox("Coil discrepancy", "Please re-check and change skid or scrap weight, and try again!", StopSign!)
		return 1
end if

parent.cb_print.event clicked( )

if ii_new_status <> 1 then
		iu_coil.finish( ii_new_status , il_new_nt )
		iu_coil.of_get_sheet_window( ).wf_done_coil( )
else //Same coil change job
	iu_coil.finish( ii_new_status , il_new_nt )
	iu_coil.of_get_sheet_window( ).wf_change_job_same_coil()
end if
close(parent)

//iu_coil.finish( 1, 0)
end event

type gb_status from groupbox within w_recap
integer x = 26
integer y = 330
integer width = 2626
integer height = 224
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
string text = "Coil Status after process"
end type

type em_new_coil_wt from u_em within w_recap
integer x = 2681
integer y = 403
integer width = 377
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
string text = "0000"
string mask = "#####"
boolean spin = true
string minmax = "0~~50000"
end type

event constructor;call super::constructor;//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_setcloseonclick( true)
//this.iuo_calculator.of_setinitialvalue( true)
end event

event modified;call super::modified;il_new_nt = Long( this.text )
cb_refresh.event clicked( )
end event

