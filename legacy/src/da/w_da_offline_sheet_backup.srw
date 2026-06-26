$PBExportHeader$w_da_offline_sheet_backup.srw
forward
global type w_da_offline_sheet_backup from w_da_sheet
end type
end forward

global type w_da_offline_sheet_backup from w_da_sheet
end type
global w_da_offline_sheet_backup w_da_offline_sheet_backup

type variables
int ii_i
end variables

on w_da_offline_sheet_backup.create
int iCurrent
call super::create
end on

on w_da_offline_sheet_backup.destroy
call super::destroy
end on

event pfc_postopen;// HHib_good_part_as_reject = false
ib_shift_ending = false
ib_coil_ending = false
ib_offline_mode = true
string ls_devicename, ls_line
int li_line_width
long ll_value, ll_shift
//Real lr_feedlength, lr_rejectlength
If not isValid(iw_please_wait) then
	open(iw_please_wait, this)
end if

is_remotehost = ProfileString(gs_downtime_ini_file,"OPCItems","RemoteHost","localhost")
ls_devicename = ProfileString(gs_downtime_ini_file,"OPCItems","DeviceName","PLC5-BL110.")
ls_line = ProfileString(gs_downtime_ini_file,"DataBase","LogId","bl110")
li_line_width = integer(mid(ls_line,3))
sqlca.of_connect( )	 	
		SELECT "LINE"."LINE_NUM"  
    		INTO :ii_line_id  
    	FROM "LINE"  
   	WHERE "LINE"."MAX_WIDTH" = :li_line_width;
if sqlca.sqlcode <> 0 then
	uo_sql.set_select( false)
	MessageBox("Database", "Error finding line id!")
else
	uo_sql.set_select( true)
	
end if

//Add OPC item in this section
is_coil = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_coil","abcoil")
is_job = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_job","abjob")
is_override = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_override","abshiftoverride")
is_shift = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_shift","abshift")
is_noauto = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_noauto","noauto-t")
is_automode = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_automode","automode")
is_autorunning = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_autorunning","autorunning")
is_coilinfeeder = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_coilinfeeder","coilinfeeder")
is_feedlength = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_feedlength","feedlength")
is_goodpartcnt = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_goodpartcnt","goodpartcnt")
is_rejectpartcnt = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_rejectpartcnt","rejectpartcnt")
is_rejectlength = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_rejectlength","rejectlength")
is_partno = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_partno","partno")
is_strokes = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_strokes","strokecnt")
is_skid= ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_skid","abskid")
is_feedreject= ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_feedreject","feedreject")
is_plc_fault = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_plc_fault","activefault")
is_opc_error = ls_devicename + ProfileString(gs_downtime_ini_file,"OPCItems","is_opc_error","Attributes._ErrorCode")

ole_1.object.RemoteHost = is_remotehost
ole_1.object.Items.RemoveAll
ole_1.object.Items.AddItem(is_shift)
ole_1.object.Items.AddItem(is_coil)
ole_1.object.Items.AddItem(is_job)
ole_1.object.Items.AddItem(is_override)
ole_1.object.Items.AddItem(is_opc_error )
ole_1.object.Items.AddItem(is_plc_fault )
ole_1.object.Items.AddItem(is_skid)
//ole_1.object.Items.AddItem(is_noauto)
//ole_1.object.Items.AddItem(is_automode)
//ole_1.object.Items.AddItem(is_autorunning)
//ole_1.object.Items.AddItem(is_coilinfeeder)
//ole_1.object.Items.AddItem(is_feedlength)
//ole_1.object.Items.AddItem(is_goodpartcnt)
//ole_1.object.Items.AddItem(is_rejectpartcnt)
//ole_1.object.Items.AddItem(is_rejectlength)
//ole_1.object.Items.AddItem(is_partno)
//ole_1.object.Items.AddItem(is_strokes)
//ole_1.object.Items.AddItem(is_feedreject)
//
//End of OPC item section


is_scale_com_port = ProfileString(gs_downtime_ini_file,"OPCItems","scale_com_port","5")
ii_com_port = Integer( is_scale_com_port ) - 1
is_maintenance_password = ProfileString(gs_downtime_ini_file,"OPCItems","is_maintenance_password","5678")
is_prod_control_password = ProfileString(gs_downtime_ini_file,"OPCItems","is_prod_control_password","2345")
is_shift_super_password = ProfileString(gs_downtime_ini_file,"OPCItems","is_shift_super_password","1234")


if ole_1.object.Connect = false then
	MessageBox( "OPC connect", "Fail to connect opc server!", StopSign!, OK!)
	HALT CLOSE
end if
ole_1.object.Refresh
sleep(3)
ole_1.object.Refresh


tab_queue.tabpage_coil_queue.dw_coil_queue.of_settransobject(sqlca)
//tab_queue.tabpage_job_queue.dw_job_queue.settransobject(sqlca)


	il_abjob = ole_1.object.items(is_job ).value
	st_job.text = string( il_abjob )
	
//	ib_feedreject = ole_1.object.items(is_feedreject).value
//		
//ib_automode = ole_1.object.items(is_automode ).value
//uo_automode.set_select(ib_automode)
//		
//ib_autorunning = ole_1.object.items(is_autorunning ).value
//uo_autorunning.set_select(ib_autorunning)
//
//
//ib_coilinfeeder = ole_1.object.items(is_coilinfeeder ).value
//uo_coilinfeeder.set_select( ib_coilinfeeder )
//
//
//		if ii_line_id = 7 then
//			lr_feedlength = Real(ole_1.object.items(is_feedlength ).value) / 100
//		else
//			lr_feedlength = Real(ole_1.object.items(is_feedlength ).value)
//		end if
//		em_feed_length.text = string( lr_feedlength )
//
il_override = ole_1.object.items(is_override ).value

//il_goodpartcnt = ole_1.object.items(is_goodpartcnt ).value
//st_goodpartcnt.text = string( il_goodpartcnt )
//
//il_partno = ole_1.object.items(is_partno ).value
//st_partno.text = string( il_partno )
//
//
//		if ii_line_id = 7 then
//			lr_rejectlength = Real(ole_1.object.items(is_rejectlength ).value) / 100
//		else
//			lr_rejectlength = Real(ole_1.object.items(is_rejectlength ).value)
//		end if
//		em_reject_length.text = string( lr_rejectlength )
//
//		il_rejectpartcnt = ole_1.object.items(is_rejectpartcnt ).value
//		st_scrapcnt.text = string( il_rejectpartcnt )
//		
//il_strokes = ole_1.object.items(is_strokes ).value
//st_stroke.text = string( il_strokes )
//
		il_abcoil = ole_1.object.items(is_coil ).value
		st_coil.text = string(ll_value )
		
//		ib_noauto = ole_1.object.items(is_noauto ).value
//		uo_noauto.set_select( not ib_noauto )
		
		il_opc_error = ole_1.object.items(is_opc_error).value
		if il_opc_error > 0  then 
			uo_opc.set_select( false)
		else
			uo_opc.set_select( true)
		end if
		
		ii_plc_fault = ole_1.object.items(is_plc_fault ).value
		if ii_plc_fault > 0 then
			uo_plc.set_select( false)
		else
			uo_plc.set_select( true)
		end if
		//MessageBox(string( il_opc_error ), string(ii_plc_fault ))
//	ll_shift = ole_1.object.items(is_shift).value
//		if ll_shift > 5000 then
//			if wf_new_shift( ll_shift ) <> 0 then
//				MessageBox("Database", " No shift availabe! ")
//				HALT CLOSE
//			end if
//		END IF		

iuo_db = create uo_seven_days_timer
iuo_db.of_register( this, "ue_reset_db", 1, 16:40:00)
itmg_refresh_display = create n_tmg
itmg_refresh_display.of_setsingle( true)
itmg_refresh_display.inv_single.of_register( this, "ue_refresh_display", 10)

gb_1.enabled = false
rb_feed.enabled = false
rb_reject.enabled = false
em_feed_length.enabled = false
em_reject_length.enabled = false
pb_feedlength.enabled = false
pb_rejectlength.enabled = false

If isValid(iw_please_wait) then
	close( iw_please_wait )
end if

iuo_timing_get_shift = create uo_timing_get_shift
iuo_timing_get_shift.init(this)

iuo_timing_get_shift.start(120)
iuo_timing_get_shift.event timer( )

st_msg.text = "Connection on line"
ib_post_open = true

end event

event ue_refresh_display;st_time.text = string(now())
if isValid( iuo_shift ) then
	long ll_shift_run_time
	ll_shift_run_time = secondsafterabs( Time(iuo_shift.idt_shift_start), now())
	st_efficiency.text =  String(Int(((ll_shift_run_time - iuo_shift.il_totol_downtime_sec) / ll_shift_run_time) * 100)) + "%"
	
	if wf_is_db_alive( ) then
		uo_sql.set_select( true)
	else
		uo_sql.set_select( false)
	end if
	
	if isValid( iu_current_coil ) then
		st_coil_finish_percent.text = string( iu_current_coil.of_get_finish_percent( ) ) + "%"
		st_coil.text = iu_current_coil.get_coil_org_id( )
//		if not ib_coilinfeeder and ( Long(iu_current_coil.of_get_scrap_tab_page( ).em_scrap_pcs.text) > 0 or &
//			iu_current_coil.of_get_skid_tab_page( ).dw_current_skid.rowcount( ) > 0 )then
//			ii_event_id = endcoil
//			wf_open_operation_panel( )
//		end if
	else
		st_coil_finish_percent.text = "None"
		st_coil.text = "None"
//		if ib_coilinfeeder  and iuo_shift.il_coil_id < 1000 and iuo_shift.of_is_init_done( ) then
//			ii_event_id = 1
//			wf_open_operation_panel( )
//		end if

//		if ib_coilinfeeder  and iuo_shift.of_is_init_done( ) then
//			ii_event_id = newcoil
//			wf_open_operation_panel( )
//		end if

	end if
	
	//Check shift end time
	
	if DateTime(Today(), Now()) > iuo_shift.get_schedule_end_time( ) then
		wf_end_shift( )
	end if
else
	st_efficiency.text = "0%"
	st_coil_finish_percent.text = "0%"
end if



end event

type uo_mtlb4feed from w_da_sheet`uo_mtlb4feed within w_da_offline_sheet_backup
end type

type hpb_coil from w_da_sheet`hpb_coil within w_da_offline_sheet_backup
end type

type cb_exit from w_da_sheet`cb_exit within w_da_offline_sheet_backup
end type

type ole_1 from w_da_sheet`ole_1 within w_da_offline_sheet_backup
end type

event ole_1::ondatachanged;if not ib_post_open then
	return
end if
int li_count, li_i, li_temp
long ll_value
boolean lb_value
string ls_tag
//Real lr_feedlength, lr_rejectlength
li_count = changeditems.count
//Time lt_data_change_time
for li_i= 0 to li_count - 1
	ls_tag = changeditems.item(li_i).ItemId
	
	choose case ls_tag
		case is_coil
			il_abcoil = changeditems.item(li_i).value
			parent.st_coil.text = string(ll_value )
		case is_job
			il_abjob = changeditems.item(li_i).value
			parent.st_job.text = string( il_abjob )
//		case is_automode
//			ib_automode = changeditems.item(li_i).value
//			uo_automode.set_select(ib_automode)
//		case is_autorunning
//			lb_value = changeditems.item(li_i).value
//			if isValid(iuo_shift) then
//		 		if lb_value then 
//					iuo_shift.postevent( "ue_line_running")
//				else
//					iuo_shift.postevent( "ue_line_idle")
//				end if
//			end if
//			ib_autorunning = lb_value
//			uo_autorunning.set_select(ib_autorunning)
//		case is_coilinfeeder
//			ib_coilinfeeder = changeditems.item(li_i).value
//			uo_coilinfeeder.set_select(ib_coilinfeeder)
			//------- auto end/start coil, may not work well!!
//			if not ib_coilinfeeder then
//				cb_end_coil.event clicked( )
//			else
//				cb_change_coil.event clicked( )
//			end if
			//------end auto end/start, may not work well!! 
//		case is_feedlength
//			if ii_line_id = 7 then
//				lr_feedlength = Real(changeditems.item(li_i).value) / 100
//			else
//				lr_feedlength = Real(changeditems.item(li_i).value)
//			end if
//			parent.em_feed_length.text = string( lr_feedlength )
//			parent.em_feed_length.event modified( )
//	
//		case is_goodpartcnt
//			il_goodpartcnt = changeditems.item(li_i).value
//			parent.st_goodpartcnt.text = string( il_goodpartcnt )
//			if isValid( iu_current_coil ) then 
//				iu_current_coil.postevent( "ue_length_cutting", 0, il_goodpartcnt )
//			end if
		case is_override
			il_override = changeditems.item(li_i).value
//		case is_partno
//			il_partno = changeditems.item(li_i).value
//			parent.st_partno.text = string( il_partno )
//		case is_rejectlength
//			if ii_line_id = 7 then
//				lr_rejectlength = Real(changeditems.item(li_i).value) / 100
//			else
//				lr_rejectlength = Real(changeditems.item(li_i).value)
//			end if
//			parent.em_reject_length.text = string( lr_rejectlength )
//			em_reject_length.event modified( )
//		case is_rejectpartcnt
//			il_rejectpartcnt = changeditems.item(li_i).value
//			parent.st_scrapcnt.text = string( il_rejectpartcnt )
//			if isValid( iu_current_coil ) then 
//				iu_current_coil.postevent( "ue_reject_cutting", 0, il_rejectpartcnt )
//			end if



//		case is_shift
//			ll_value = changeditems.item(li_i).value
//			if ll_value > 1000 and ll_value > il_abshift then
//				if wf_new_shift( ll_value ) <> 0 then
//					MessageBox("Database", " No shift availabe! ")
//					continue
//				end if
//			elseif ll_value = -1 and il_abshift > 1000 then
//				wf_end_shift( )
//			else
//				// do nothing
//			end if







//		case is_strokes
//			il_strokes = changeditems.item(li_i).value
//			parent.st_stroke.text = string( il_strokes )
//		case is_noauto
//			ib_noauto = changeditems.item(li_i).value
//			if isValid(iuo_shift) then
//				if ib_noauto then
//					iuo_shift.postevent( "ue_noauto_set")
//				else
//					iuo_shift.postevent( "ue_noauto_clear")
//				end if
//			end if
//			uo_noauto.set_select(not ib_noauto)
//		case is_feedreject
//			ib_feedreject = changeditems.item(li_i).value
//			if isValid( iu_current_coil ) then
//				if ib_feedreject then
//					iu_current_coil.of_select_skid_tabpg( )
//				else
//					iu_current_coil.of_select_scrap_tabpg( )
//				end if
//			end if
		case is_opc_error
			il_opc_error = changeditems.item(li_i).value
			if il_opc_error = 0 then
				uo_opc.set_select( true )
			else
				uo_opc.set_select( false)
			end if
		case is_plc_fault
			ii_plc_fault = changeditems.item(li_i).value
			if ii_plc_fault = 0 then
				uo_plc.set_select( true)
			else
				uo_plc.set_select( false)
			end if
			
		case else
		//OPC error handling
	end choose
next

end event

type st_4 from w_da_sheet`st_4 within w_da_offline_sheet_backup
end type

type st_time from w_da_sheet`st_time within w_da_offline_sheet_backup
end type

type st_msg from w_da_sheet`st_msg within w_da_offline_sheet_backup
end type

type cb_operatioin from w_da_sheet`cb_operatioin within w_da_offline_sheet_backup
end type

type tab_queue from w_da_sheet`tab_queue within w_da_offline_sheet_backup
end type

type tabpage_coil_queue from w_da_sheet`tabpage_coil_queue within tab_queue
end type

type dw_coil_queue from w_da_sheet`dw_coil_queue within tabpage_coil_queue
end type

type cb_change_coil from w_da_sheet`cb_change_coil within w_da_offline_sheet_backup
end type

type cb_1 from w_da_sheet`cb_1 within w_da_offline_sheet_backup
end type

type st_efficiency from w_da_sheet`st_efficiency within w_da_offline_sheet_backup
end type

type st_3 from w_da_sheet`st_3 within w_da_offline_sheet_backup
end type

type rb_reject from w_da_sheet`rb_reject within w_da_offline_sheet_backup
end type

type rb_feed from w_da_sheet`rb_feed within w_da_offline_sheet_backup
end type

type pb_rejectlength from w_da_sheet`pb_rejectlength within w_da_offline_sheet_backup
end type

type pb_feedlength from w_da_sheet`pb_feedlength within w_da_offline_sheet_backup
end type

type em_reject_length from w_da_sheet`em_reject_length within w_da_offline_sheet_backup
end type

type em_feed_length from w_da_sheet`em_feed_length within w_da_offline_sheet_backup
end type

type uo_coilinfeeder from w_da_sheet`uo_coilinfeeder within w_da_offline_sheet_backup
end type

type uo_noauto from w_da_sheet`uo_noauto within w_da_offline_sheet_backup
end type

type uo_autorunning from w_da_sheet`uo_autorunning within w_da_offline_sheet_backup
end type

type uo_automode from w_da_sheet`uo_automode within w_da_offline_sheet_backup
end type

type st_goodpartcnt from w_da_sheet`st_goodpartcnt within w_da_offline_sheet_backup
boolean enabled = false
string text = ""
end type

type st_scrapcnt from w_da_sheet`st_scrapcnt within w_da_offline_sheet_backup
boolean enabled = false
string text = ""
end type

type st_partno from w_da_sheet`st_partno within w_da_offline_sheet_backup
boolean enabled = false
string text = ""
end type

type st_stroke from w_da_sheet`st_stroke within w_da_offline_sheet_backup
boolean enabled = false
string text = ""
end type

type st_10 from w_da_sheet`st_10 within w_da_offline_sheet_backup
end type

type st_9 from w_da_sheet`st_9 within w_da_offline_sheet_backup
end type

type st_8 from w_da_sheet`st_8 within w_da_offline_sheet_backup
end type

type st_7 from w_da_sheet`st_7 within w_da_offline_sheet_backup
end type

type st_6 from w_da_sheet`st_6 within w_da_offline_sheet_backup
end type

type st_5 from w_da_sheet`st_5 within w_da_offline_sheet_backup
end type

type st_1 from w_da_sheet`st_1 within w_da_offline_sheet_backup
end type

type tab_da from w_da_sheet`tab_da within w_da_offline_sheet_backup
end type

type gb_1 from w_da_sheet`gb_1 within w_da_offline_sheet_backup
end type

type st_2 from w_da_sheet`st_2 within w_da_offline_sheet_backup
end type

type st_shift from w_da_sheet`st_shift within w_da_offline_sheet_backup
end type

type uo_sql from w_da_sheet`uo_sql within w_da_offline_sheet_backup
end type

type uo_opc from w_da_sheet`uo_opc within w_da_offline_sheet_backup
end type

type uo_plc from w_da_sheet`uo_plc within w_da_offline_sheet_backup
end type

type st_job from w_da_sheet`st_job within w_da_offline_sheet_backup
end type

type st_coil from w_da_sheet`st_coil within w_da_offline_sheet_backup
end type

type dw_shift_coil from w_da_sheet`dw_shift_coil within w_da_offline_sheet_backup
end type

type cb_end_coil from w_da_sheet`cb_end_coil within w_da_offline_sheet_backup
end type

type st_yield from w_da_sheet`st_yield within w_da_offline_sheet_backup
end type

type st_coil_finish_percent from w_da_sheet`st_coil_finish_percent within w_da_offline_sheet_backup
end type

