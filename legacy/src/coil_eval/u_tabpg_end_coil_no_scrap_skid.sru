$PBExportHeader$u_tabpg_end_coil_no_scrap_skid.sru
forward
global type u_tabpg_end_coil_no_scrap_skid from u_tabpg
end type
type cb_ok from commandbutton within u_tabpg_end_coil_no_scrap_skid
end type
type st_7 from statictext within u_tabpg_end_coil_no_scrap_skid
end type
type st_coil_org_num from statictext within u_tabpg_end_coil_no_scrap_skid
end type
type st_4 from statictext within u_tabpg_end_coil_no_scrap_skid
end type
type st_3 from statictext within u_tabpg_end_coil_no_scrap_skid
end type
type em_coil_wt from u_em within u_tabpg_end_coil_no_scrap_skid
end type
type pb_coil_wt from u_pb within u_tabpg_end_coil_no_scrap_skid
end type
type st_2 from statictext within u_tabpg_end_coil_no_scrap_skid
end type
type cb_cancel from commandbutton within u_tabpg_end_coil_no_scrap_skid
end type
type st_wt_prompt from statictext within u_tabpg_end_coil_no_scrap_skid
end type
type rb_reject from radiobutton within u_tabpg_end_coil_no_scrap_skid
end type
type rb_inprocess from radiobutton within u_tabpg_end_coil_no_scrap_skid
end type
type rb_onhold from radiobutton within u_tabpg_end_coil_no_scrap_skid
end type
type rb_rebanded from radiobutton within u_tabpg_end_coil_no_scrap_skid
end type
type rb_done from radiobutton within u_tabpg_end_coil_no_scrap_skid
end type
type em_new_coil_wt from u_em within u_tabpg_end_coil_no_scrap_skid
end type
type pb_new_coil_wt from u_pb within u_tabpg_end_coil_no_scrap_skid
end type
type gb_4 from groupbox within u_tabpg_end_coil_no_scrap_skid
end type
type gb_status from groupbox within u_tabpg_end_coil_no_scrap_skid
end type
end forward

global type u_tabpg_end_coil_no_scrap_skid from u_tabpg
integer width = 3602
integer height = 1946
long backcolor = 134217752
boolean ib_isupdateable = false
cb_ok cb_ok
st_7 st_7
st_coil_org_num st_coil_org_num
st_4 st_4
st_3 st_3
em_coil_wt em_coil_wt
pb_coil_wt pb_coil_wt
st_2 st_2
cb_cancel cb_cancel
st_wt_prompt st_wt_prompt
rb_reject rb_reject
rb_inprocess rb_inprocess
rb_onhold rb_onhold
rb_rebanded rb_rebanded
rb_done rb_done
em_new_coil_wt em_new_coil_wt
pb_new_coil_wt pb_new_coil_wt
gb_4 gb_4
gb_status gb_status
end type
global u_tabpg_end_coil_no_scrap_skid u_tabpg_end_coil_no_scrap_skid

type variables
w_operation_panel  iw_operation_panel
long il_old_nt
long il_new_nt
int ii_old_status
int ii_new_status
w_enter_num iw_enter_num
u_coil iu_coil
long il_skid_total, il_scrap_total, il_hl
Real ir_hl_percent
int ii_super = 0
//w_production_control_validation iw_production_control_validation
//u_da_recap_scrap_tabpg iu_da_recap_scrap_tabpg
//u_da_recap_skid_tabpg iu_da_recap_skid_tabpg
//w_report_eval iw_report_eval
end variables

forward prototypes
public function double of_get_coil_yield ()
public function long of_get_reject_wt ()
public function long of_get_reband_wt ()
public function integer of_transfer_worksheet_2_eval ()
end prototypes

public function double of_get_coil_yield ();double ld_yield

ld_yield = (1- (this.il_scrap_total / iu_coil.get_old_nw ())) * 100
//ld_yield = ( 1- il )
ld_yield = Round(ld_yield, 2 )
//if ld_yield >= 99.99 then
//	ld_yield = 99.99
//end if
return ld_yield
end function

public function long of_get_reject_wt ();long ll_reject_wt

if this.rb_reject.checked then
	ll_reject_wt = Long( this.em_new_coil_wt.text )
else
	ll_reject_wt = 0
end if

return ll_reject_wt

end function

public function long of_get_reband_wt ();long ll_reband_wt

if this.rb_rebanded.checked then
	ll_reband_wt = Long( this.em_new_coil_wt.text )
else
	ll_reband_wt = 0
end if

return ll_reband_wt

end function

public function integer of_transfer_worksheet_2_eval ();
sqlca.update_scrap_from_worksheet( iu_coil.get_coil_abc_id( ) )
return sqlca.sqlcode
end function

on u_tabpg_end_coil_no_scrap_skid.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.st_7=create st_7
this.st_coil_org_num=create st_coil_org_num
this.st_4=create st_4
this.st_3=create st_3
this.em_coil_wt=create em_coil_wt
this.pb_coil_wt=create pb_coil_wt
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.st_wt_prompt=create st_wt_prompt
this.rb_reject=create rb_reject
this.rb_inprocess=create rb_inprocess
this.rb_onhold=create rb_onhold
this.rb_rebanded=create rb_rebanded
this.rb_done=create rb_done
this.em_new_coil_wt=create em_new_coil_wt
this.pb_new_coil_wt=create pb_new_coil_wt
this.gb_4=create gb_4
this.gb_status=create gb_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.st_7
this.Control[iCurrent+3]=this.st_coil_org_num
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.em_coil_wt
this.Control[iCurrent+7]=this.pb_coil_wt
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.st_wt_prompt
this.Control[iCurrent+11]=this.rb_reject
this.Control[iCurrent+12]=this.rb_inprocess
this.Control[iCurrent+13]=this.rb_onhold
this.Control[iCurrent+14]=this.rb_rebanded
this.Control[iCurrent+15]=this.rb_done
this.Control[iCurrent+16]=this.em_new_coil_wt
this.Control[iCurrent+17]=this.pb_new_coil_wt
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.gb_status
end on

on u_tabpg_end_coil_no_scrap_skid.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.st_7)
destroy(this.st_coil_org_num)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_coil_wt)
destroy(this.pb_coil_wt)
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.st_wt_prompt)
destroy(this.rb_reject)
destroy(this.rb_inprocess)
destroy(this.rb_onhold)
destroy(this.rb_rebanded)
destroy(this.rb_done)
destroy(this.em_new_coil_wt)
destroy(this.pb_new_coil_wt)
destroy(this.gb_4)
destroy(this.gb_status)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm

if isValid( iw_operation_panel.iw_da_sheet.iu_current_coil ) then
	iu_coil = iw_operation_panel.iw_da_sheet.iu_current_coil
//	iu_coil.of_update_from_skid_scrap( )
	//DAS_STAGE1 Add coil update function here
end if
//this.title = "Coil " + iu_coil.get_coil_org_id( )
st_coil_org_num.text = iu_coil.get_coil_org_id( )
//il_old_nt = iu_coil.of_get_init_wt( )
il_old_nt = iu_coil.get_old_nw( )
em_coil_wt.text = string(il_old_nt )
gb_status.text = "1) Change Coil (" + string(il_old_nt) + "LB) Status/Weight to"
em_new_coil_wt.text = "0"
em_new_coil_wt.enabled = false
il_new_nt = 0
ii_new_status = 0
il_hl =  il_skid_total + il_scrap_total + il_new_nt - il_old_nt
ir_hl_percent = Round(ABS(il_hl / il_old_nt ),4) * 100
//st_skid_wt.text = string( il_skid_total  )
//st_scrap_wt.text = string( il_scrap_total )
//st_hl.text = string( il_hl )
//st_percent.text = string( ir_hl_percent )

//tab_recap.opentab( iu_da_recap_skid_tabpg , 0)
//tab_recap.opentab( iu_da_recap_scrap_tabpg , 0)
////iu_da_recap_skid_tabpg.of_init( iu_coil, this )
////iu_da_recap_scrap_tabpg.of_init( iu_coil, this )
//dw_1.settransobject(sqlca)
////dw_1.retrieve(iu_coil.get_coil_abc_id( ))
//cb_refresh_job.event clicked( )
//this.postevent( "ue_refresh")
//cb_refresh.event clicked( )
//
end event

event destructor;call super::destructor;//if isValid( iw_enter_num ) then
//	close(iw_enter_num)
//end if
//
//if isValid( iw_production_control_validation  ) then
//	close(iw_production_control_validation)
//end if
end event

type cb_ok from commandbutton within u_tabpg_end_coil_no_scrap_skid
integer x = 549
integer y = 1472
integer width = 2425
integer height = 138
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "End Coil"
end type

event clicked;long ll_coil_id, ll_reject_wt, ll_reband_wt, ll_new_wt
double ld_yield
int li_rc2
//em_new_coil_wt.acc
//cb_refresh.event clicked( )
//if ir_hl_percent > 0.5 and ii_super = 0  then
//		//not balance
//		MessageBox("Coil discrepancy", "Please re-check and change skid or scrap weight, and try again! Or ask your shift supervisor override it!", StopSign!)
//		return 1
//end if

ll_coil_id = iu_coil.get_coil_abc_id( )
//if isValid(iu_coil.of_get_scrap_tab_page( )) then
//	li_rc2 = iu_coil.of_get_scrap_tab_page( ).of_update_scrap_skid_item()
//	
//else
//	li_rc2 = iu_coil.of_get_scrap_offline_tab_page( ).of_update_scrap_skid_item()
//end if
//
//if li_rc2 <> 0 then
//	MessageBox("Save failed", "Failed at saving scrap. Try again later!", StopSign!)
//	return 1
//end if


//if isValid(iu_coil.of_get_skid_tab_page( )) then
//	li_rc2 = iu_coil.of_get_skid_tab_page( ).of_save()
//else
//	li_rc2 = iu_coil.of_get_skid_offline_tab_page( ).of_save( )
//end if
//
//if li_rc2 <> 0 then
//	MessageBox("Save failed", "Failed at saving skids, Try again later!", StopSign!)
//	return 1
//end if

//parent.of_transfer_worksheet_2_eval( )
if ii_new_status <> 1 then
		
		ll_new_wt = Long( em_new_coil_wt.text  )
		
		if isNull(ll_new_wt) then ll_new_wt = 0
		
		if ll_new_wt >= iu_coil.of_get_init_wt( ) or ll_new_wt < 0 then
			MessageBox("New weight error", "Coil new weight must be between 0 and " + string(iu_coil.of_get_init_wt( )) + " LB!")
			return 1
		end if
		
		if ii_new_status = 0 and ll_new_wt <> 0 then
			MessageBox("New weight error", "Done coil weight must be 0!")
			return 1
		end if
		
//		if ii_new_status = 0 and ll_new_wt
		il_new_nt = ll_new_wt
		iu_coil.finish( ii_new_status , il_new_nt )
		int li_rc
		ll_reband_wt = of_get_reband_wt( )
		ll_reject_wt = of_get_reject_wt( )
		ld_yield = of_get_coil_yield( )
		
		if ld_yield > 99.99 then
			ld_yield = 99.99
		end if
		
		li_rc = iu_coil.of_get_sheet_window( ).wf_done_coil( )
		
		
		if li_rc = 0 then
			
//			UPDATE "COIL"  
//     		SET "REBAND_WT" = :ll_reband_wt,   
//         	"REJECT_WT" = :ll_reject_wt,   
//         	"RECOVERY_RATE" = :ld_yield  
//   		WHERE "COIL"."COIL_ABC_NUM" = :ll_coil_id
//           ;
//			if sqlca.sqlcode <> 0 then
//				sqlca.of_rollback( )
//				MessageBox("DB Error", "Can not update coil!")
//			else
				sqlca.of_commit( )
//			end if
		end if
		
		
//		if ii_new_status <> 0 then
//			Datastore lds_coil
//			lds_coil = create datastore
//			lds_coil.dataobject = "d_report_coil_barcode_zebra"
//			lds_coil.settransobject( sqlca)
//			lds_coil.retrieve( ll_coil_id )
//			lds_coil.print( )
//		end if
				
		iw_operation_panel.postevent("ue_operation_finish")
else //Same coil change job
	iu_coil.finish( ii_new_status , il_new_nt )
	iw_operation_panel.postevent( "ue_same_coil_change_job" )
end if

end event

type st_7 from statictext within u_tabpg_end_coil_no_scrap_skid
integer x = 4074
integer y = 906
integer width = 66
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "/"
boolean focusrectangle = false
end type

type st_coil_org_num from statictext within u_tabpg_end_coil_no_scrap_skid
integer x = 208
integer y = 134
integer width = 263
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
string text = "none"
boolean focusrectangle = false
end type

type st_4 from statictext within u_tabpg_end_coil_no_scrap_skid
integer x = 1130
integer y = 134
integer width = 644
integer height = 77
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217752
string text = "had been processed."
end type

type st_3 from statictext within u_tabpg_end_coil_no_scrap_skid
integer x = 998
integer y = 134
integer width = 121
integer height = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "LB."
boolean focusrectangle = false
end type

type em_coil_wt from u_em within u_tabpg_end_coil_no_scrap_skid
integer x = 486
integer y = 122
integer width = 358
integer height = 96
integer taborder = 20
integer textsize = -12
boolean enabled = false
string text = "0000"
string mask = "#####"
boolean spin = true
string minmax = "0~~50000"
end type

event constructor;call super::constructor;this.of_setdropdowncalculator( true)
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
end event

event modified;call super::modified;long ll_coil_init_wt
long ll_coil, ll_job
ll_coil_init_wt = Long(this.text)
ll_coil = iu_coil.get_coil_abc_id( )
ll_job = iu_coil.get_current_job( )
if ll_coil_init_wt <> il_old_nt then
	//init coil weight changed
			
//	  UPDATE "PROCESS_COIL"  
//     	SET "PROCESS_QUANTITY" = :ll_coil_init_wt  
//   	WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :ll_coil ) AND  
//         ( "PROCESS_COIL"."AB_JOB_NUM" = :ll_job )   
//           ;
//		
			
	  UPDATE "COIL"  
     SET "NET_WT" = :ll_coil_init_wt  
   WHERE "COIL"."COIL_ABC_NUM" = :ll_coil   
           ;
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			return 0
		end if
	
	  UPDATE "PROCESS_COIL"  
     SET "PROCESS_QUANTITY" = :ll_coil_init_wt  
   WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :ll_coil) AND  
         ( "PROCESS_COIL"."PROCESS_QUANTITY" = :il_old_nt )   
           ;

	if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			return 0
	end if
	
	sqlca.of_commit( )
	iu_coil.of_set_coil_origin_wt( ll_coil_init_wt )
	
	il_old_nt = ll_coil_init_wt
//	cb_refresh.event clicked( )
end if
end event

type pb_coil_wt from u_pb within u_tabpg_end_coil_no_scrap_skid
boolean visible = false
integer x = 837
integer y = 122
integer width = 132
integer height = 90
integer taborder = 20
integer textsize = -10
string facename = "Arial"
boolean enabled = false
string text = "Change"
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;em_new_coil_wt.Event pfc_DDCalculator( )
//s_position ls_p
//ls_p.x = x
//ls_p.y = y
//OpenWithParm(iw_enter_num, ls_p, parent)
//if not isValid( this ) then
//	return 0
//end if
//em_coil_wt.text = Message.StringParm

//long ll_rc
//	OpenWithParm(iw_production_control_validation, iu_coil.of_get_sheet_window( ).is_prod_control_password)// , parent)
//	ll_rc = message.doubleparm
//	if not isValid( this ) then
//		return 1
//	end if
//	if ll_rc = 1 then
//		em_coil_wt.enabled = true
//	else
//		em_coil_wt.enabled = false
//	end if
end event

type st_2 from statictext within u_tabpg_end_coil_no_scrap_skid
integer x = 77
integer y = 134
integer width = 135
integer height = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217752
string text = "Coil"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within u_tabpg_end_coil_no_scrap_skid
boolean visible = false
integer x = 549
integer y = 1318
integer width = 571
integer height = 138
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;iw_operation_panel.postevent( "ue_operation_finish")
end event

type st_wt_prompt from statictext within u_tabpg_end_coil_no_scrap_skid
integer x = 797
integer y = 742
integer width = 750
integer height = 86
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "New Weight:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_reject from radiobutton within u_tabpg_end_coil_no_scrap_skid
integer x = 1364
integer y = 477
integer width = 322
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12639424
string text = "Reject"
end type

event clicked;parent.st_wt_prompt.text = "Rejected Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 3
il_new_nt = iu_coil.get_nw_bal( )
//parent.cb_refresh.event clicked( )
end event

type rb_inprocess from radiobutton within u_tabpg_end_coil_no_scrap_skid
boolean visible = false
integer x = 2341
integer y = 477
integer width = 761
integer height = 90
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12639424
boolean enabled = false
string text = "InProcess (change job)"
end type

event clicked;st_wt_prompt.text = "Unprocess Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
parent.ii_new_status = 1
il_new_nt = iu_coil.get_nw_bal( )
//parent.cb_refresh.event clicked( )
end event

type rb_onhold from radiobutton within u_tabpg_end_coil_no_scrap_skid
integer x = 1829
integer y = 477
integer width = 369
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 12639424
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
il_new_nt = iu_coil.get_nw_bal( )
//parent.cb_refresh.event clicked( )
end event

type rb_rebanded from radiobutton within u_tabpg_end_coil_no_scrap_skid
integer x = 772
integer y = 477
integer width = 450
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12639424
string text = "Rebanded"
end type

event clicked;parent.st_wt_prompt.text = "Rebandeded Weight"
//parent.st_new_wt.enabled = true
//parent.st_new_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.text = string(iu_coil.get_nw_bal( ))
em_new_coil_wt.enabled = true
pb_new_coil_wt.enabled = true
il_new_nt = iu_coil.get_nw_bal( )
parent.ii_new_status = 7
//parent.cb_refresh.event clicked( )
end event

type rb_done from radiobutton within u_tabpg_end_coil_no_scrap_skid
integer x = 358
integer y = 477
integer width = 271
integer height = 93
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 12639424
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
//parent.cb_refresh.event clicked( )


end event

type em_new_coil_wt from u_em within u_tabpg_end_coil_no_scrap_skid
integer x = 1558
integer y = 733
integer width = 432
integer height = 112
integer taborder = 40
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
//cb_refresh.event clicked( )
end event

type pb_new_coil_wt from u_pb within u_tabpg_end_coil_no_scrap_skid
integer x = 1993
integer y = 733
integer width = 132
integer height = 112
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;//em_new_coil_wt.Event pfc_DDCalculator( )
s_position ls_p
ls_p.x = x - 300
ls_p.y = y
OpenWithParm(iw_enter_num, ls_p)// parent)
if not isValid( this ) then
	return 0
end if
em_new_coil_wt.text = Message.StringParm
em_new_coil_wt.event modified( )

end event

type gb_4 from groupbox within u_tabpg_end_coil_no_scrap_skid
integer x = 55
integer y = 1123
integer width = 3522
integer height = 755
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "2) Finish"
end type

type gb_status from groupbox within u_tabpg_end_coil_no_scrap_skid
integer x = 59
integer y = 262
integer width = 3522
integer height = 826
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "1) Change Coil (10000LB) Status/Weight to"
end type

