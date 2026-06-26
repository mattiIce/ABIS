$PBExportHeader$w_operation_panel.srw
forward
global type w_operation_panel from w_popup
end type
type cb_shift_summary from u_cb within w_operation_panel
end type
type cb_change_job from u_cb within w_operation_panel
end type
type cb_login from u_cb within w_operation_panel
end type
type cb_new_coil from u_cb within w_operation_panel
end type
type tab_op from u_tab within w_operation_panel
end type
type tab_op from u_tab within w_operation_panel
end type
type cb_job_sheet from u_cb within w_operation_panel
end type
type cb_shift from u_cb within w_operation_panel
end type
type cb_dt_summary from u_cb within w_operation_panel
end type
type cb_dt_log from u_cb within w_operation_panel
end type
type cb_cancel from commandbutton within w_operation_panel
end type
type cb_end_coil from u_cb within w_operation_panel
end type
end forward

global type w_operation_panel from w_popup
string tag = "operation panel"
integer x = 0
integer y = 0
integer width = 3741
integer height = 2182
boolean maxbox = false
boolean resizable = false
boolean clientedge = true
event ue_operation_finish ( )
event ue_login_changed ( )
event ue_login_finish ( )
event ue_offline_finish ( )
event ue_same_coil_change_job ( )
event ue_same_coil_change_job_back ( )
cb_shift_summary cb_shift_summary
cb_change_job cb_change_job
cb_login cb_login
cb_new_coil cb_new_coil
tab_op tab_op
cb_job_sheet cb_job_sheet
cb_shift cb_shift
cb_dt_summary cb_dt_summary
cb_dt_log cb_dt_log
cb_cancel cb_cancel
cb_end_coil cb_end_coil
end type
global w_operation_panel w_operation_panel

type variables
w_da_sheet iw_da_sheet
uo_shift iuo_shift
w_override iw_override
u_tabpg_new_coil iu_tabpg_new_coil
u_tabpg_end_coil iu_tabpg_end_coil
//u_tabpg_end_coil_no_scrap_skid iu_tabpg_end_coil
u_tabpg_change_job_same_coil iu_tabpg_change_job_same_coil
u_tabpg_login iu_tabpg_login
u_tabpg_offline iu_tabpg_offline
u_tabpg_job_sheet iu_tabpg_job_sheet
u_tabpg_downtime_log iu_tabpg_downtime_log
u_tabpg_downtime_summary iu_tabpg_downtime_summary
u_tabpg_print_shift_summary iu_tabpg_print_shift_summary
integer ii_login_mode
string is_coil_org_id_same_coil
long il_coil_id_same_coil, il_old_job_id_same_coil
end variables

event ue_operation_finish();Close(this)
end event

event ue_login_changed();
choose case ii_login_mode
	case 1
		cb_shift.enabled = true
	case 2
//		cb_offline.enabled = true
		iw_da_sheet.cb_exit.enabled = true
	case 3
		if isValid(iu_tabpg_end_coil) then

			iu_tabpg_end_coil.em_coil_wt.enabled = true
			iu_tabpg_end_coil.pb_coil_wt.enabled = true
//			iu_tabpg_end_coil_no_scrap_skid.cb_ok.enabled = true
//			iu_tabpg_end_coil_no_scrap_skid.ii_super = 1
			tab_op.selecttab( iu_tabpg_end_coil )
		end if
		
	case else
		//		
end choose


end event

event ue_login_finish();if isValid(iu_tabpg_login) then
	tab_op.closetab( iu_tabpg_login )
	tab_op.selecttab( 1 )
end if
end event

event ue_offline_finish();if isValid( iu_tabpg_offline ) then
	tab_op.closetab( iu_tabpg_offline )
end if
tab_op.selecttab( 1 )
//tab_op.opentabwithparm( /*ref userobject o*/, /*powerobject a*/, 0 )
end event

event ue_same_coil_change_job();if isValid( iu_tabpg_end_coil ) then
	is_coil_org_id_same_coil = iu_tabpg_end_coil.iu_coil.get_coil_org_id( )
	il_coil_id_same_coil = iu_tabpg_end_coil.iu_coil.get_coil_abc_id( )
	il_old_job_id_same_coil = iu_tabpg_end_coil.iu_coil.get_current_job( )
	iu_tabpg_end_coil.visible = false
	tab_op.opentabwithparm(iu_tabpg_change_job_same_coil,this, 0)
	iu_tabpg_change_job_same_coil.visible = true
	tab_op.selecttab( iu_tabpg_change_job_same_coil )
else
	if isValid( iw_da_sheet.iu_current_coil ) then
		is_coil_org_id_same_coil = iw_da_sheet.iu_current_coil.get_coil_org_id( )
		il_coil_id_same_coil =iw_da_sheet.iu_current_coil.get_coil_abc_id( )
		il_old_job_id_same_coil =iw_da_sheet.iu_current_coil.get_current_job( )
		tab_op.opentabwithparm(iu_tabpg_change_job_same_coil,this, 0)
		iu_tabpg_change_job_same_coil.visible = true
		tab_op.selecttab( iu_tabpg_change_job_same_coil )
	end if
	
end if
end event

event ue_same_coil_change_job_back();if isValid( iu_tabpg_end_coil) then
	iu_tabpg_end_coil.visible = true
	tab_op.selecttab( iu_tabpg_end_coil)
	if isValid( iu_tabpg_change_job_same_coil ) then
		tab_op.closetab( iu_tabpg_change_job_same_coil )
	end if
end if
end event

event open;call super::open;iw_da_sheet = message.powerobjectparm
int li_op_id
li_op_id = iw_da_sheet.ii_event_id


if gi_screen = 2 then
	if gi_dual_mode = 2 then
		//dual and up down mode
		
		this.x = 200
		this.y = 3420
//		messagebox(string(this.x),string(this.y))
	else
		this.x = 6200
		this.y = 200
	end if
//		messagebox(string(this.x),string(this.y))
end if


choose case li_op_id
	case 1
		cb_new_coil.event clicked( )
		cb_new_coil.enabled = true
	case 2
		cb_end_coil.event clicked( )
		cb_end_coil.enabled = true
	case 4
		cb_change_job.event clicked( )
		cb_change_job.enabled = true
	case 0 
		if not isValid(iw_da_sheet.iu_current_coil) then
			cb_new_coil.enabled = true
		end if
		if isValid(iw_da_sheet.iu_current_coil) and (not iw_da_sheet.ib_coilinfeeder) then
			cb_end_coil.enabled = true
		end if
end choose


//tab_op.opentab(iu_tabpg_new_coil, 0)

//tab_op.opentab(iu_tabpg_new_job, 0)

end event

on w_operation_panel.create
int iCurrent
call super::create
this.cb_shift_summary=create cb_shift_summary
this.cb_change_job=create cb_change_job
this.cb_login=create cb_login
this.cb_new_coil=create cb_new_coil
this.tab_op=create tab_op
this.cb_job_sheet=create cb_job_sheet
this.cb_shift=create cb_shift
this.cb_dt_summary=create cb_dt_summary
this.cb_dt_log=create cb_dt_log
this.cb_cancel=create cb_cancel
this.cb_end_coil=create cb_end_coil
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_shift_summary
this.Control[iCurrent+2]=this.cb_change_job
this.Control[iCurrent+3]=this.cb_login
this.Control[iCurrent+4]=this.cb_new_coil
this.Control[iCurrent+5]=this.tab_op
this.Control[iCurrent+6]=this.cb_job_sheet
this.Control[iCurrent+7]=this.cb_shift
this.Control[iCurrent+8]=this.cb_dt_summary
this.Control[iCurrent+9]=this.cb_dt_log
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_end_coil
end on

on w_operation_panel.destroy
call super::destroy
destroy(this.cb_shift_summary)
destroy(this.cb_change_job)
destroy(this.cb_login)
destroy(this.cb_new_coil)
destroy(this.tab_op)
destroy(this.cb_job_sheet)
destroy(this.cb_shift)
destroy(this.cb_dt_summary)
destroy(this.cb_dt_log)
destroy(this.cb_cancel)
destroy(this.cb_end_coil)
end on

event close;call super::close;if isValid(iw_override ) then
	close( iw_override )
end if
end event

type cb_shift_summary from u_cb within w_operation_panel
integer x = 1123
integer y = 13
integer width = 366
integer height = 112
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "End Shift"
end type

event clicked;call super::clicked;double end_shift_status = 1;


if IsValid(iw_da_sheet.iuo_shift) then	
	
	// Check if the shift is ending early and display warning
	if DateTime( Today( ) , Now() ) < iw_da_sheet.iuo_shift.get_schedule_end_time() then
		end_shift_status = 0;
		Open(w_end_shift_warning)
		end_shift_status = Message.DoubleParm
	end if
end if

if end_shift_status = 1 then
		// End the shift.
	if isValid(iu_tabpg_change_job_same_coil ) then
		iu_tabpg_change_job_same_coil.visible = false
	end if

	if isValid(iu_tabpg_end_coil ) then
		iu_tabpg_end_coil.visible = false
	end if

	if isValid(iu_tabpg_new_coil ) then
		iu_tabpg_new_coil.visible = false
	end if

	if isValid(iu_tabpg_login ) then
		iu_tabpg_login.visible = false
	end if

	if isValid(iu_tabpg_job_sheet ) then
		iu_tabpg_job_sheet.visible = false
	end if

	if isValid(iu_tabpg_downtime_summary ) then
		iu_tabpg_downtime_summary.visible = false
	end if

	if isValid(iu_tabpg_downtime_log ) then
		iu_tabpg_downtime_log.visible = false
	//	tab_op.selecttab( iu_tabpg_downtime_log )
	//else
	//	tab_op.opentabwithparm(iu_tabpg_downtime_log, parent, 0)
	//	tab_op.selecttab(iu_tabpg_downtime_log)
	end if

	if isValid(iu_tabpg_print_shift_summary ) then
		tab_op.closetab( iu_tabpg_print_shift_summary )
		tab_op.opentabwithparm(iu_tabpg_print_shift_summary, parent, 0)
	else
		tab_op.opentabwithparm(iu_tabpg_print_shift_summary, parent, 0)
		tab_op.selecttab(iu_tabpg_print_shift_summary)
	end if
	this.underline = true
	cb_cancel.underline = false
	cb_change_job.underline = false
	cb_dt_log.underline = false
	cb_dt_summary.underline = false
	cb_end_coil.underline = false
	cb_job_sheet.underline = false
	cb_login.underline = false
	cb_shift.underline = false
	//cb_shift_summary.underline = false
	cb_new_coil.underline = false
end if
end event

type cb_change_job from u_cb within w_operation_panel
integer x = 1492
integer y = 13
integer width = 366
integer height = 112
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Change Job"
end type

event clicked;call super::clicked;long ll_rc
if isValid( iw_da_sheet.iu_current_coil ) then
//	if isValid(iw_da_sheet.iu_current_coil.of_get_skid_offline_tab_page( ) ) then
//		//offline mode
//		ll_rc = iw_da_sheet.iu_current_coil.of_get_skid_offline_tab_page( ).dw_current_edit.rowcount( )
//	else //online mode
//		ll_rc = iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_current_edit.rowcount( )
//	end if
//	
//		if ll_rc > 0 then
//			MessageBox("Change job", "Current skid not saved, save it first!")
//			return 1
//		end if
//	iw_da_sheet.iu_current_coil.of_update_from_skid_scrap( )
//	parent.cb_end_coil.event clicked( )
//	if isValid( iu_tabpg_end_coil) then
//		iu_tabpg_end_coil.rb_inprocess.checked = true
//		iu_tabpg_end_coil.rb_inprocess.event clicked( )
//		iu_tabpg_end_coil.cb_ok.event clicked( )
//	end if
	
	//DAS_STAGE1
//	iw_da_sheet.iu_current_coil.finish( 1, iw_da_sheet.iu_current_coil.get_nw_bal( ) )
	//DAS_STAGE1
	//DAS_STAGE1 Need user enter new coil weight for new job
	
	parent.event ue_same_coil_change_job( )
	this.underline = true
	cb_cancel.underline = false
//	cb_change_job.underline = false
	cb_dt_log.underline = false
	cb_dt_summary.underline = false
	cb_end_coil.underline = false
	cb_job_sheet.underline = false
	cb_login.underline = false
	cb_shift.underline = false
	cb_shift_summary.underline = false
	cb_new_coil.underline = false
	
	
else
	MessageBox("No coil", "Please load new coil!")
	return 1
end if

end event

type cb_login from u_cb within w_operation_panel
integer x = 2970
integer y = 13
integer width = 366
integer height = 112
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Setup"
end type

event clicked;call super::clicked;if isValid(iu_tabpg_change_job_same_coil ) then
	iu_tabpg_change_job_same_coil.visible = false
end if

if isValid(iu_tabpg_end_coil ) then
	iu_tabpg_end_coil.visible = false
end if

if isValid(iu_tabpg_new_coil ) then
	iu_tabpg_new_coil.visible = false
end if

if isValid(iu_tabpg_login ) then
	iu_tabpg_login.visible = false
end if

if isValid(iu_tabpg_job_sheet ) then
	iu_tabpg_job_sheet.visible = false
end if

if isValid(iu_tabpg_downtime_log ) then
//	tab_op.closetab( iu_tabpg_downtime_log )
	iu_tabpg_downtime_log.visible = false
end if
//if isValid(iu_tabpg_login ) then
//	tab_op.closetab( iu_tabpg_login )
//end if

if iw_da_sheet.wf_super_validation( ) = 1 then
	if isValid(iu_tabpg_login) then
		iu_tabpg_login.visible = true
		tab_op.selecttab( iu_tabpg_login )
	else
		tab_op.opentabwithparm(iu_tabpg_login, parent, 0)
		tab_op.selecttab( iu_tabpg_login )
	end if
	this.underline = true
	cb_cancel.underline = false
	cb_change_job.underline = false
	cb_dt_log.underline = false
	cb_dt_summary.underline = false
	cb_end_coil.underline = false
	cb_job_sheet.underline = false
//	cb_login.underline = false
	cb_shift.underline = false
	cb_shift_summary.underline = false
	cb_new_coil.underline = false

	

end if	
end event

type cb_new_coil from u_cb within w_operation_panel
integer x = 15
integer y = 13
integer width = 366
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "New coil"
end type

event clicked;call super::clicked;if isValid(iu_tabpg_change_job_same_coil ) then
//	tab_op.closetab( iu_tabpg_change_job_same_coil )
	iu_tabpg_change_job_same_coil.visible = false
end if

if isValid(iu_tabpg_end_coil) then
//	tab_op.closetab( iu_tabpg_end_coil )
	iu_tabpg_end_coil.visible = false
end if

//if isValid(iu_tabpg_new_coil ) then
//	iu_tabpg_new_coil.visible = false
//end if
//
if isValid(iu_tabpg_login ) then
//	tab_op.closetab( iu_tabpg_login )
	iu_tabpg_login.visible = false
end if

if isValid(iu_tabpg_job_sheet ) then
//	tab_op.closetab( iu_tabpg_job_sheet )
	iu_tabpg_job_sheet.visible = false
end if

if isValid(iu_tabpg_downtime_log ) then
//	tab_op.closetab( iu_tabpg_downtime_log )
	iu_tabpg_downtime_log.visible = false
end if

if isValid(iu_tabpg_downtime_summary ) then
//	tab_op.closetab( iu_tabpg_downtime_summary )
	iu_tabpg_downtime_summary.visible = false
end if
//parent.height = 934
//tab_op.height = 803

if isValid(iu_tabpg_new_coil) then
	iu_tabpg_new_coil.visible = true
	tab_op.selecttab( iu_tabpg_new_coil )
else
	tab_op.opentabwithparm(iu_tabpg_new_coil, parent, 0)
	tab_op.selecttab( iu_tabpg_new_coil )
end if
this.underline = true
cb_cancel.underline = false
cb_change_job.underline = false
cb_dt_log.underline = false
cb_dt_summary.underline = false
cb_end_coil.underline = false
cb_job_sheet.underline = false
cb_login.underline = false
cb_shift.underline = false
cb_shift_summary.underline = false
//cb_new_coil.underline = false




end event

type tab_op from u_tab within w_operation_panel
integer y = 128
integer width = 3716
integer height = 1971
integer taborder = 40
integer textsize = -1
string facename = "Arial"
boolean underline = true
tabposition tabposition = tabsonleft!
end type

type cb_job_sheet from u_cb within w_operation_panel
integer x = 1861
integer y = 13
integer width = 366
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Job sheet"
end type

event clicked;call super::clicked;if isValid(iu_tabpg_change_job_same_coil ) then
	iu_tabpg_change_job_same_coil.visible = false
end if

if isValid(iu_tabpg_end_coil ) then
	iu_tabpg_end_coil.visible = false
//	tab_op.selecttab( iu_tabpg_end_coil )
//else
//	tab_op.opentabwithparm( iu_tabpg_end_coil, parent, 0)
end if

if isValid(iu_tabpg_new_coil ) then
//	tab_op.closetab( iu_tabpg_new_coil )
	iu_tabpg_new_coil.visible = false
end if

if isValid(iu_tabpg_login ) then
//	tab_op.closetab( iu_tabpg_login )
	iu_tabpg_login.visible = false
end if

//if isValid(iu_tabpg_job_sheet ) then
//	iu_tabpg_job_sheet.visible = true
//	tab_op.selecttab( iu_tabpg_job_sheet )
//else
//	tab_op.opentabwithparm( iu_tabpg_job_sheet, parent, 0)
//	tab_op.selecttab( iu_tabpg_job_sheet)
//end if

if isValid(iu_tabpg_downtime_log ) then
//	tab_op.closetab( iu_tabpg_downtime_log )
	iu_tabpg_downtime_log.visible = false
end if

if isValid(iu_tabpg_downtime_summary ) then
//	tab_op.closetab( iu_tabpg_downtime_summary )
	iu_tabpg_downtime_summary.visible = false
end if







if isValid(iu_tabpg_job_sheet ) then
	iu_tabpg_job_sheet.visible = true
	tab_op.selecttab( iu_tabpg_job_sheet )
else
	tab_op.opentabwithparm(iu_tabpg_job_sheet, parent, 0)
	tab_op.selecttab( iu_tabpg_job_sheet )
	iu_tabpg_job_sheet.visible = true
	iu_tabpg_job_sheet.of_show_job_sheet( )
end if

this.underline = true
cb_cancel.underline = false
cb_change_job.underline = false
cb_dt_log.underline = false
cb_dt_summary.underline = false
cb_end_coil.underline = false
//cb_job_sheet.underline = false
cb_login.underline = false
cb_shift.underline = false
cb_shift_summary.underline = false
cb_new_coil.underline = false

end event

type cb_shift from u_cb within w_operation_panel
integer x = 753
integer y = 13
integer width = 366
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Change shift"
end type

event clicked;call super::clicked;if isValid(iu_tabpg_job_sheet ) then
	tab_op.closetab( iu_tabpg_job_sheet )
end if

if isValid(iu_tabpg_downtime_log ) then
	tab_op.closetab( iu_tabpg_downtime_log )
end if

if isValid(iu_tabpg_downtime_summary ) then
	tab_op.closetab( iu_tabpg_downtime_summary )
end if

this.underline = true
cb_cancel.underline = false
cb_change_job.underline = false
cb_dt_log.underline = false
cb_dt_summary.underline = false
cb_end_coil.underline = false
cb_job_sheet.underline = false
cb_login.underline = false
//cb_shift.underline = false
cb_shift_summary.underline = false
cb_new_coil.underline = false



iw_da_sheet.wf_shift_override( )
//Close(parent)
end event

type cb_dt_summary from u_cb within w_operation_panel
integer x = 2600
integer y = 13
integer width = 366
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "DT summary"
end type

event clicked;call super::clicked;
if isValid(iu_tabpg_change_job_same_coil ) then
	iu_tabpg_change_job_same_coil.visible = false
end if

if isValid(iu_tabpg_end_coil ) then
	iu_tabpg_end_coil.visible = false
end if

if isValid(iu_tabpg_new_coil ) then
	iu_tabpg_new_coil.visible = false
end if

if isValid(iu_tabpg_login ) then
	iu_tabpg_login.visible = false
end if

if isValid(iu_tabpg_job_sheet ) then
	iu_tabpg_job_sheet.visible = false
end if

if isValid(iu_tabpg_downtime_log ) then
//	tab_op.closetab( iu_tabpg_downtime_log )
	iu_tabpg_downtime_log.visible = false
end if

//if isValid(iu_tabpg_downtime_summary ) then
//	iu_tabpg_downtime_summary.visible = false
//end if


if isValid(iu_tabpg_downtime_summary ) then
	tab_op.selecttab( iu_tabpg_downtime_summary )
	iu_tabpg_downtime_summary.visible = true
else
	tab_op.opentabwithparm(iu_tabpg_downtime_summary, parent, 0)
	tab_op.selecttab( iu_tabpg_downtime_summary )
	iu_tabpg_downtime_summary.visible = true
end if
this.underline = true
cb_cancel.underline = false
cb_change_job.underline = false
cb_dt_log.underline = false
//cb_dt_summary.underline = false
cb_end_coil.underline = false
cb_job_sheet.underline = false
cb_login.underline = false
cb_shift.underline = false
cb_shift_summary.underline = false
cb_new_coil.underline = false

end event

type cb_dt_log from u_cb within w_operation_panel
integer x = 2231
integer y = 13
integer width = 366
integer height = 112
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Downtime log"
end type

event clicked;call super::clicked;//if isValid(iu_tabpg_job_sheet ) then
//	tab_op.closetab( iu_tabpg_job_sheet )
//end if
//
//if isValid(iu_tabpg_downtime_summary ) then
//	tab_op.closetab( iu_tabpg_downtime_summary )
//end if
//


if isValid(iu_tabpg_change_job_same_coil ) then
	iu_tabpg_change_job_same_coil.visible = false
end if

if isValid(iu_tabpg_end_coil ) then
	iu_tabpg_end_coil.visible = false
//	tab_op.selecttab( iu_tabpg_end_coil )
//else
//	tab_op.opentabwithparm( iu_tabpg_end_coil, parent, 0)
end if

if isValid(iu_tabpg_new_coil ) then
	iu_tabpg_new_coil.visible = false
end if

if isValid(iu_tabpg_login ) then
	iu_tabpg_login.visible = false
end if

if isValid(iu_tabpg_job_sheet ) then
	iu_tabpg_job_sheet.visible = false
end if

//if isValid(iu_tabpg_downtime_log ) then
//	tab_op.closetab( iu_tabpg_downtime_log )
//	iu_tabpg_downtime_log.visible = false
//end if
//
if isValid(iu_tabpg_downtime_summary ) then
	iu_tabpg_downtime_summary.visible = false
end if


if isValid(iu_tabpg_downtime_log ) then
	iu_tabpg_downtime_log.visible = true
	tab_op.selecttab( iu_tabpg_downtime_log )
else
	tab_op.opentabwithparm(iu_tabpg_downtime_log, parent, 0)
	tab_op.selecttab(iu_tabpg_downtime_log)
end if

this.underline = true
cb_cancel.underline = false
cb_change_job.underline = false
//cb_dt_log.underline = false
cb_dt_summary.underline = false
cb_end_coil.underline = false
cb_job_sheet.underline = false
cb_login.underline = false
cb_shift.underline = false
cb_shift_summary.underline = false
cb_new_coil.underline = false

end event

type cb_cancel from commandbutton within w_operation_panel
integer x = 3339
integer y = 13
integer width = 366
integer height = 112
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;//messagebox( "w_sheet", string( iuo_shift.classname() ))
Close(parent)
end event

type cb_end_coil from u_cb within w_operation_panel
integer x = 384
integer y = 13
integer width = 366
integer height = 112
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "End coil"
end type

event clicked;call super::clicked;if isValid(iu_tabpg_change_job_same_coil ) then
	iu_tabpg_change_job_same_coil.visible = false
end if

//if isValid(iu_tabpg_end_coil_no_scrap_skid ) then
//	iu_tabpg_end_coil_no_scrap_skid.visible = true
//	tab_op.selecttab( iu_tabpg_end_coil_no_scrap_skid )
//else
//	if isValid( iw_da_sheet.iu_current_coil ) then
//		tab_op.opentabwithparm( iu_tabpg_end_coil_no_scrap_skid, parent, 0)
//		tab_op.selecttab( iu_tabpg_end_coil_no_scrap_skid)
//	end if
//end if




if isValid(iu_tabpg_end_coil ) then
	iu_tabpg_end_coil.visible = true
	tab_op.selecttab( iu_tabpg_end_coil )
else
	if isValid( iw_da_sheet.iu_current_coil ) then
		tab_op.opentabwithparm( iu_tabpg_end_coil, parent, 0)
		tab_op.selecttab( iu_tabpg_end_coil)
	end if
end if




if isValid(iu_tabpg_new_coil ) then
//	tab_op.closetab( iu_tabpg_new_coil )
	iu_tabpg_new_coil.visible = false
end if

if isValid(iu_tabpg_login ) then
//	tab_op.closetab( iu_tabpg_login )
	iu_tabpg_login.visible = false
end if

if isValid(iu_tabpg_job_sheet ) then
//	tab_op.closetab( iu_tabpg_job_sheet )
	iu_tabpg_job_sheet.visible = false
end if

if isValid(iu_tabpg_downtime_log ) then
//	tab_op.closetab( iu_tabpg_downtime_log )
	iu_tabpg_downtime_log.visible = false
end if

if isValid(iu_tabpg_downtime_summary ) then
//	tab_op.closetab( iu_tabpg_downtime_summary )
	iu_tabpg_downtime_summary.visible = false
end if

this.underline = true
cb_cancel.underline = false
cb_change_job.underline = false
cb_dt_log.underline = false
cb_dt_summary.underline = false
//cb_end_coil.underline = false
cb_job_sheet.underline = false
cb_login.underline = false
cb_shift.underline = false
cb_shift_summary.underline = false
cb_new_coil.underline = false




//parent.height = 934
//tab_op.height = 803

//if isValid(iu_tabpg_new_coil) then
//	iu_tabpg_new_coil.visible = true
//	tab_op.selecttab( iu_tabpg_new_coil )
//else
//	tab_op.opentabwithparm(iu_tabpg_new_coil, parent, 0)
//end if
//


//if not isValid( iw_da_sheet.iu_current_coil ) then
//	return
//end if
//
//if isValid(iu_tabpg_change_job_same_coil ) then
//	tab_op.closetab( iu_tabpg_change_job_same_coil )
//end if
//
//if isValid(iu_tabpg_end_coil ) then
//	tab_op.closetab( iu_tabpg_end_coil )
//end if
//
//if isValid(iu_tabpg_new_coil ) then
//	tab_op.closetab( iu_tabpg_new_coil )
//end if
//
//if isValid(iu_tabpg_login ) then
//	tab_op.closetab( iu_tabpg_login )
//end if
//
//if isValid(iu_tabpg_job_sheet ) then
//	tab_op.closetab( iu_tabpg_job_sheet )
//end if
//
//if isValid(iu_tabpg_downtime_log ) then
//	tab_op.closetab( iu_tabpg_downtime_log )
//end if
//
//if isValid(iu_tabpg_downtime_summary ) then
//	tab_op.closetab( iu_tabpg_downtime_summary )
//end if
//
//tab_op.opentabwithparm(iu_tabpg_end_coil,parent, 0)



end event

