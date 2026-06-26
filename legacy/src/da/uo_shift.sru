$PBExportHeader$uo_shift.sru
forward
global type uo_shift from nonvisualobject
end type
end forward

global type uo_shift from nonvisualobject
event ue_line_idle ( )
event ue_line_running ( )
event ue_job_changed ( )
event ue_coil_changed ( )
event ue_noauto_set ( )
event ue_noauto_clear ( )
event ue_coil_offline ( )
event ue_coil_online ( )
event ue_1_min_timing ( )
event ue_drop_current_coil ( )
end type
global uo_shift uo_shift

type variables
Date id_shift_date
DateTime idt_shift_start
DateTime idt_shift_stop
DateTime idt_shift_schedule_start
DateTime idt_shift_schedule_stop
Long il_shift_id, il_totol_downtime_sec
int ii_shift_type, ii_line_id
//uo_timing_end_shift iu_timer_stop
//uo_timing_nag_show iu_timer_nag_flash
//uo_timing_nag_start iu_timer_nag_start
//uo_timing_update_shift_schedule iu_timer_update_schedule
//uo_schedule iu_schedule
boolean ib_end_overrided, ib_init_done, ib_coil_ending
n_tmg itmg_1_min
int ii_timing_min = 3
int ii_min
long il_job_id, il_coil_id
//u_coil iu_current_coil
u_causes iu_current_downtime
w_da_sheet iw_sheet
//w_change_job iw_change_job
w_noauto_warning iw_noauto_warning
//w_change_coil iw_change_coil
//w_finish_coil iw_finish_coil
//w_change_job_same_coil iw_change_job_same_coil
//w_done_coil iw_done_coil
u_da_offline_downtime_tabpg iu_da_offline_downtime_tabpg
end variables

forward prototypes
public function integer get_shift_type ()
public function boolean get_override ()
public subroutine set_shift_id (long al_id)
public function long get_shift_id ()
public function u_coil get_current_coil ()
public function u_causes get_current_downtime ()
public function long get_current_job ()
public function datetime get_schedule_end_time ()
public function datetime get_schedule_start_time ()
public subroutine of_print ()
public subroutine of_enable_line (boolean ab_1)
public function w_da_sheet of_get_w_sheet ()
public function integer of_get_line_id ()
public subroutine of_set_job_id (long al_job)
public subroutine of_open_w_change_job ()
public subroutine of_set_opc_abjob (long al_job)
public subroutine of_set_opc_abcoil (long al_coil)
public function boolean of_is_init_done ()
public subroutine of_open_w_change_job_same_coil ()
public function boolean of_get_coil_ending ()
public subroutine of_coil_online ()
public subroutine of_set_coil_id (long al_coil)
public function integer init (long al_shift_id, integer ai_line_id, long al_job, readonly w_da_sheet aw_1)
public subroutine of_set_schedule_end_time (datetime adt_et)
public function integer of_set_job_id_same_coil (long al_job, long al_nw)
public function integer of_drop_current_coil ()
end prototypes

event ue_line_idle();if not isValid(iu_current_downtime) then
	iu_current_downtime = create u_causes
	iu_current_downtime.init( ii_line_id , il_job_id , this )
	
//	  UPDATE "LINE_CURRENT_STATUS"  
//     	SET "LINE_STATUS" = 1  
//   	WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :ii_line_id   
//           ;
//		
//		if sqlca.sqlcode <> 0 then
//			sqlca.of_rollback( )
//			MessageBox("Update line status", "Fail to update line status table!")
//			return
//		else
//			sqlca.of_commit( )
//		end if
	
else
	//
end if

end event

event ue_line_running();if isValid(iu_current_downtime) then
	if iu_current_downtime.of_get_status( ) <> 2 then
		destroy iu_current_downtime
	end if
end if
end event

event ue_job_changed();of_set_opc_abjob(il_job_id)
iw_sheet.tab_queue.tabpage_coil_queue.dw_coil_queue.of_retrieve( )
//iw_sheet.tab_queue.tabpage_job_queue.dw_job_queue.retrieve( iw_sheet.ii_line_id )
iw_sheet.dw_shift_coil.of_retrieve( )
iw_sheet.tab_queue.selecttab( 1 )
end event

event ue_coil_changed();if isValid(iw_sheet.iu_current_coil) then
	//of_set_opc_abcoil( iu_current_coil.get_coil_abc_id( ) ) 
//	iw_sheet.ole_1.object.items( iw_sheet.is_coil).value = iw_sheet.iu_current_coil.get_coil_abc_id( )
	if not iw_sheet.ib_offline_mode then
		iw_sheet.ole_1.object.items( iw_sheet.is_goodpartcnt ).value = 0
		iw_sheet.ole_1.object.items( iw_sheet.is_rejectpartcnt ).value = 0
	end if
	
//	iw_sheet.ole_1.object.update
	iw_sheet.wf_set_opc_abcoil( iw_sheet.iu_current_coil.get_coil_abc_id( ) )
	
end if
end event

event ue_noauto_set();if not isValid(iw_noauto_warning) then
	//open(iw_noauto_warning, iw_sheet )
	openwithparm(iw_noauto_warning, iw_sheet, iw_sheet)
end if
end event

event ue_noauto_clear();//
if isValid(iw_noauto_warning) then
	close(iw_noauto_warning)
end if
end event

event ue_coil_offline();//if ib_coil_ending then
//	return
//end if
//if isValid( iw_sheet.iu_current_coil ) then
//	ib_coil_ending = true
//	OpenWithParm(iw_done_coil, iw_sheet.iu_current_coil, iw_sheet )
//	if iw_sheet.iu_current_coil.get_new_status( ) <> 1 then
//		iw_sheet.iu_current_coil.save( )
//		iw_sheet.wf_show_dw_process_status( )
//		iw_sheet.wf_show_shift_coil( )
//			of_set_opc_abcoil( -1 )
//		destroy iw_sheet.iu_current_coil
//	end if
//	ib_coil_ending = false
//end if
end event

event ue_coil_online();//OpenWithParm( iw_change_coil, this, iw_sheet )
end event

event ue_1_min_timing();//messagebox("","1 minute up")
if ii_min < ii_timing_min then
	ii_min++
	return
end if
	
	iw_sheet.tab_queue.tabpage_coil_queue.dw_coil_queue.of_retrieve( )
	ii_min = 0
	return
end event

event ue_drop_current_coil();if of_drop_current_coil( ) <> 0 then
	MessageBox("Error", "Error reversing current coil!")
end if
end event

public function integer get_shift_type ();return ii_shift_type
end function

public function boolean get_override ();return ib_end_overrided
end function

public subroutine set_shift_id (long al_id);il_shift_id = al_id
end subroutine

public function long get_shift_id ();return il_shift_id
end function

public function u_coil get_current_coil ();return iw_sheet.iu_current_coil
end function

public function u_causes get_current_downtime ();return iu_current_downtime
end function

public function long get_current_job ();return il_job_id
end function

public function datetime get_schedule_end_time ();return idt_shift_schedule_stop
end function

public function datetime get_schedule_start_time ();return idt_shift_schedule_start
end function

public subroutine of_print ();datastore lds_print
	lds_print = create Datastore
	//ls_efficiency	= "t_efficiency.TEXT= ~"" + "99%" + "~""
	
	lds_print.dataobject = "d_daily_prod_dt_total"
	lds_print.SetTransObject(sqlca)
	lds_print.retrieve(il_shift_id )
	
	//lds_print.modify( ls_efficiency )
	lds_print.print()
	lds_print.print()

end subroutine

public subroutine of_enable_line (boolean ab_1);iw_sheet.enable_press( ab_1)
end subroutine

public function w_da_sheet of_get_w_sheet ();return iw_sheet
end function

public function integer of_get_line_id ();return ii_line_id
end function

public subroutine of_set_job_id (long al_job);long ll_job
ll_job = il_job_id
il_job_id = al_job
if ll_job <> al_job then
datetime ldt_now
ldt_now = DateTime(Today(), Now())
	  UPDATE "AB_JOB"  
     SET "TIME_DATE_STARTED" = :ldt_now
   WHERE ("AB_JOB"."AB_JOB_NUM" = :al_job) AND 
			(( "AB_JOB"."TIME_DATE_STARTED" is null ) OR  
         ( "AB_JOB"."TIME_DATE_STARTED" <= "AB_JOB"."CREATE_DATE" )   )
           ;
end if
	
	if sqlca.sqlcode <> 0 then
		sqlca.of_rollback( )
		return
	else
		sqlca.of_commit( )
	end if

//if ll_job <> al_job then
	this.postevent("ue_job_changed")
//end if

end subroutine

public subroutine of_open_w_change_job ();//if not isValid(iw_change_job) then
//	OpenWithParm(iw_change_job, this, iw_sheet )
//end if
end subroutine

public subroutine of_set_opc_abjob (long al_job);iw_sheet.wf_set_opc_abjob(al_job)
end subroutine

public subroutine of_set_opc_abcoil (long al_coil);iw_sheet.wf_set_opc_abcoil(al_coil)
end subroutine

public function boolean of_is_init_done ();return ib_init_done
end function

public subroutine of_open_w_change_job_same_coil ();//if not isValid(iw_change_job_same_coil) then
//	OpenWithParm(iw_change_job_same_coil, this)
//end if
end subroutine

public function boolean of_get_coil_ending ();return ib_coil_ending
end function

public subroutine of_coil_online ();//OpenWithParm( iw_change_coil, this, iw_sheet )
end subroutine

public subroutine of_set_coil_id (long al_coil);long ll_coil
Real lr_feedlength, lr_rejectlength
if isValid( iw_sheet.iu_current_coil ) then
	ll_coil = iw_sheet.iu_current_coil.get_coil_abc_id( )
else
	ll_coil = -1
end if

if ll_coil = al_coil then
	il_coil_id = al_coil
	return
end if


lr_feedlength = Real(iw_sheet.em_feed_length.text)
lr_rejectlength = Real(iw_sheet.em_reject_length.text)

if not isValid(iw_sheet.iu_current_coil) then //adding new coil
	iw_sheet.iu_current_coil = create u_coil
	if iw_sheet.iu_current_coil.init( al_coil , il_job_id , il_shift_id ) <> 0 then
		MessageBox("Error", "Load coil failed!, Please call system support!")
		destroy iw_sheet.iu_current_coil
		return
	end if
	
	iw_sheet.iu_current_coil.of_update_feed_lenght( lr_feedlength )
	iw_sheet.iu_current_coil.of_update_reject_length( lr_rejectlength )
	iw_sheet.wf_show_dw_process_status( )
	iw_sheet.wf_show_shift_coil( )
	
else   // handle old coil and add new coil
//	MessageBox(iw_sheet.iu_current_coil.get_coil_org_id( ), "coil status and weight needed!")
//	OpenWithParm( iw_done_coil, iw_sheet.iu_current_coil, iw_sheet )
//	if iw_sheet.iu_current_coil.get_new_status( ) <> 1 then
//		iw_sheet.iu_current_coil.save( )
//		destroy iw_sheet.iu_current_coil
//	else
//		MessageBox("Coil# " + iw_sheet.iu_current_coil.get_coil_org_id( ), "You didn't change coil!")
//		il_coil_id = al_coil
//		return
//	end if
//	iw_sheet.iu_current_coil = create u_coil
//	iw_sheet.iu_current_coil.init( al_coil , il_job_id , il_shift_id )
//	iw_sheet.iu_current_coil.of_update_feed_lenght( lr_feedlength )
//	iw_sheet.iu_current_coil.of_update_reject_length( lr_rejectlength )
//	iw_sheet.wf_show_dw_process_status( )
//	iw_sheet.wf_show_shift_coil( )
//	il_coil_id = al_coil
end if

il_coil_id = al_coil
if ll_coil <> al_coil then
	this.postevent("ue_coil_changed")
end if
end subroutine

public function integer init (long al_shift_id, integer ai_line_id, long al_job, readonly w_da_sheet aw_1);long ll_pre_shift, ll_pre_coil, ll_pre_job
boolean lb_continue_pre_coil
long ll_pre_length_pcs, ll_pre_reject_pcs
il_shift_id = al_shift_id
ii_line_id = ai_line_id
il_job_id = al_job
iw_sheet = aw_1
il_totol_downtime_sec = 0

//  	if isValid( iw_sheet.iu_current_coil ) then
//		iw_sheet.iu_current_coil.of_set_new_shift_id( il_shift_id )
//	end if
	lb_continue_pre_coil = false
  SELECT "SHIFT"."START_TIME",   
         "SHIFT"."PLANNED_STARTING_TIME",   
         "SHIFT"."PLANNED_ENDING_TIME",   
         "SHIFT"."SCHEDULE_TYPE"  
    INTO :idt_shift_start,   
         :idt_shift_schedule_start,   
         :idt_shift_schedule_stop,   
         :ii_shift_type  
    FROM "SHIFT"  
   WHERE "SHIFT"."SHIFT_NUM" = :al_shift_id   
           ;
			  
			IF SQLCA.SQLCode <> 0 then
				return sqlca.sqlcode
			else
				
				if isNull( idt_shift_start ) then
					idt_shift_start = DateTime( Today( ) , Now() )
				end if
				
				select sum(dt_instance.ending_time - dt_instance.starting_time) * 86400
				into :il_totol_downtime_sec
				from dt_instance
				where dt_instance.shift_num = :il_shift_id
				;
				
				if isNull( il_totol_downtime_sec ) or il_totol_downtime_sec < 1  then
					il_totol_downtime_sec = 0
				end if
					
				iw_sheet.st_shift.text = "Shift " + string(ii_shift_type ) &
				+ " started " + string( Time( idt_shift_start )) &
				+ " ending " + string( Time( idt_shift_schedule_stop ))

				
				
				if isValid( iw_sheet.iu_current_coil ) then // set new shift id if coil runs across shifts
					iw_sheet.iu_current_coil.of_set_new_shift_id( il_shift_id )
				
				else //No coil check previou coil from line_curent_status table
					
						  SELECT "LINE_CURRENT_STATUS"."SHIFT_NUM",   
         				"LINE_CURRENT_STATUS"."AB_JOB_NUM",   
         				"LINE_CURRENT_STATUS"."COIL_ABC_NUM"  
    						INTO :ll_pre_shift,   
         						:ll_pre_job,   
         						:ll_pre_coil  
    						FROM "LINE_CURRENT_STATUS"  
   						WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :ai_line_id   
           				;
			
					if (not isNull( ll_pre_shift )) and ll_pre_shift = al_shift_id then
						if (not isNull( ll_pre_job )) and (not isNull( ll_pre_coil )) then
							
							
							ll_pre_length_pcs = iw_sheet.ole_1.object.items(iw_sheet.is_goodpartcnt ).value
							ll_pre_reject_pcs = iw_sheet.ole_1.object.items(iw_sheet.is_rejectpartcnt ).value
							lb_continue_pre_coil = true
							iw_sheet.il_pre_length_pcs = ll_pre_length_pcs
							iw_sheet.il_pre_reject_pcs = ll_pre_reject_pcs
							iw_sheet.ib_pre_coil_continue = true
							this.of_set_job_id( ll_pre_job )
							this.of_set_coil_id( ll_pre_coil )
							
							
						end if
					else //clean up previous shift job and coil
						  UPDATE "LINE_CURRENT_STATUS"  
     						SET "SCRAP_SKID_NUM" = null,   
         					"SHEET_SKID_NUM" = null,   
         					"COIL_ABC_NUM" = null,   
         					"AB_JOB_NUM" = null  
   						WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :ai_line_id   
           				;
							if sqlca.sqlcode <> 0 then
								sqlca.of_rollback( )
								return 1
							end if
					end if
					
				end if // set new shift id if coil runs across shifts
				
				
				
				
				if not iw_sheet.ib_offline_mode then
					if (not iw_sheet.ib_autorunning) and (not isValid( iu_current_downtime )) then
						iu_current_downtime = create u_causes
						iu_current_downtime.init( ii_line_id , il_job_id , this)
					end if
				
					if iw_sheet.ib_coilinfeeder and (not isValid( iw_sheet.iu_current_coil )) then
						iw_sheet.wf_set_operation_id( 1)
						iw_sheet.wf_open_operation_panel()
					end if
				else
					iw_sheet.tab_da.opentabwithparm( iu_da_offline_downtime_tabpg , this, 0 )
				end if
					id_shift_date = Date(idt_shift_start)
					
//				  DateTime ldt_now
//				  ldt_now = DateTime(Today(), Now())
				  UPDATE "SHIFT"  
     				SET "START_TIME" = :idt_shift_start
   				WHERE ( "SHIFT"."SHIFT_NUM" = :al_shift_id ) AND  
         		( "SHIFT"."START_TIME" IS NULL  )   ;
					
					if sqlca.sqlcode <> 0 then
						sqlca.of_rollback( )
						return 1
					else
						sqlca.of_commit( )
					end if
			
				iw_sheet.tab_queue.tabpage_coil_queue.dw_coil_queue.of_retrieve( )
				
				itmg_1_min = create n_tmg
				itmg_1_min.of_setsingle( true)
				itmg_1_min.inv_single.of_register( this, "ue_1_min_timing", 60)
				ii_min = 0
				
				
				ib_init_done = true
				
//				if lb_continue_pre_coil then
//					iw_sheet.ole_1.object.items( iw_sheet.is_goodpartcnt ).value = ll_pre_length_pcs
//					iw_sheet.ole_1.object.items( iw_sheet.is_rejectpartcnt ).value = ll_pre_reject_pcs
//					iw_sheet.ole_1.object.update
//				end if
				
				return 0
			end if

end function

public subroutine of_set_schedule_end_time (datetime adt_et);idt_shift_schedule_stop = adt_et
end subroutine

public function integer of_set_job_id_same_coil (long al_job, long al_nw);long ll_job
ll_job = il_job_id
il_job_id = al_job
if ll_job <> al_job then
DATETIME ldt_now
ldt_now = DateTime(Today(), Now())
	  UPDATE "AB_JOB"  
     SET "TIME_DATE_STARTED" = :ldt_now
   WHERE ("AB_JOB"."AB_JOB_NUM" = :al_job) AND 
			(( "AB_JOB"."TIME_DATE_STARTED" is null ) OR  
         ( "AB_JOB"."TIME_DATE_STARTED" <= "AB_JOB"."CREATE_DATE" )   )
           ;
	if sqlca.sqlcode<>0 then
		sqlca.of_rollback( )
		return -1
	else
		sqlca.of_commit( )
	end if
	
	if isValid( iw_sheet.iu_current_coil ) then	
		iw_sheet.iu_current_coil.split_and_save( 1, al_nw , al_job)
//		iw_sheet.iu_current_coil.of_get_coi_job_tabpg( ).of_retrieve_job( )
		this.postevent("ue_job_changed")
		return 1
	end if
	return 1
else
	return 0
end if

end function

public function integer of_drop_current_coil ();//return 0 if successful
//return 100 if no current coil
//return  200 if no current shift
//return 300 if no super validation
//else return sql error code

if not isValid( iw_sheet.iu_current_coil ) then
	return 100
end if

//if not isValid(  )

//if iw_sheet.wf_super_validation( ) <> 1 then
//	return 300
//end if



long ll_coil_id, ll_job_id

ll_coil_id = iw_sheet.iu_current_coil.get_coil_abc_id( )
ll_job_id = iw_sheet.iu_current_coil.get_current_job( )
int li_line_id
li_line_id = iw_sheet.ii_line_id
					UPDATE "PROCESS_COIL"  
     				SET "SHIFT_PROCESS_STATUS" = null
   					WHERE ( "COIL_ABC_NUM" = :ll_coil_id ) AND  
         				( "AB_JOB_NUM" = :ll_job_id )   
           ;
			
			IF SQLCA.SQLCode <> 0 THEN
				sqlca.of_rollback( )
				return -1
			end if
			
			
			  DELETE FROM "SHIFT_COIL"  
   			WHERE ( "SHIFT_COIL"."SHIFT_NUM" = :il_shift_id ) AND  
         ( "SHIFT_COIL"."AB_JOB_NUM" = :ll_job_id ) AND  
         ( "SHIFT_COIL"."COIL_ABC_NUM" = :ll_coil_id )   
           ;

				IF SQLCA.SQLCode <> 0 THEN
					sqlca.of_rollback( )
					return -1
				end if
				
			UPDATE "LINE_CURRENT_STATUS"  
     			SET "COIL_ABC_NUM" = null 
   		WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line_id
   		;
			
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				return -1
			end if
			
			UPDATE "COIL"  
     			SET "COIL_STATUS_FROM_LINE" = null  
   			WHERE "COIL"."COIL_ABC_NUM" = :ll_coil_id  
				;
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				return -1
			end if
		
			long li_err_seq
			SELECT ERROR_EVT_SEQ.NEXTVAL INTO :li_err_seq FROM DUAL;
			
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				return -1
			end if
			
			string ls_user
			ls_user = iw_sheet.is_user_name
//			lstr_user = iw_sheet.is
//			long ll_line_id
//			long ll_shift_id
			
			  INSERT INTO "ERROR_EVT"  
         ( "ERROR_EVT_ID",   
           "EVT_TIME",   
           "ERROR_TYPE_ID",   
           "ERROR_USER",   
           "ERROR_COMMENT",   
           "LINE_ID",   
           "SHIFT_ID",   
           "COIL_ABC_NUM",   
           "AB_JOB_NUM",   
           "SHEET_SKID_NUM",   
           "SCRAP_SKID_NUM",   
           "DT_INSTANCE_NUM",   
           "OPC_ITEM",   
           "TITLE",   
           "MESSAGE",   
           "SCRIPT",   
           "LINE_IN_SCRIPT",   
           "DB_ERROR_CODE",   
           "DB_ERROR_TEXT" )  
  VALUES ( :li_err_seq,   
           sysdate,   
           1,   
           :ls_user,   
           'operstor loaded wrong coil',   
           :li_line_id ,   
           :il_shift_id ,   
           :ll_coil_id,   
           :ll_job_id,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )  ;

			
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				return -1
			end if
			sqlca.of_commit( )
			
			
			
		iw_sheet.wf_set_opc_abcoil( -1 )
//		wf_set_opc_abjob( -1)
		destroy iw_sheet.iu_current_coil
		iw_sheet.tab_queue.tabpage_coil_queue.dw_coil_queue.of_retrieve( )
//		tab_queue.tabpage_job_queue.dw_job_queue.retrieve( ii_line_id )
		iw_sheet.wf_show_shift_coil( )
			
			
			

return 0
end function

on uo_shift.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_shift.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//string ls_efficiency
if isValid(iu_current_downtime) then
	destroy iu_current_downtime
end if

//if isValid( iw_sheet.iu_current_coil ) then
//	iw_sheet.iu_current_coil.save( )
//end if
//
//if isValid(iw_change_job) then
//	Close(iw_change_job)
//end if


if isValid(iw_noauto_warning) then
	Close(iw_noauto_warning)
end if

//if isValid(iw_change_coil) then
//	Close(iw_change_coil)
//end if
//if isValid(iw_finish_coil) then
//	Close(iw_finish_coil)
//end if
//
//if isValid(iw_done_coil) then
//	Close(iw_done_coil)
//end if
//

//if isValid(iw_change_job_same_coil) then
//	Close(iw_change_job_same_coil)
//end if
//

if isValid(iw_sheet.iw_override) then
	Close(iw_sheet.iw_override)
end if
//if isValid(iw_sheet.iw_super_validation ) then
//	Close(iw_sheet.iw_super_validation )
//end if

if isValid( iu_da_offline_downtime_tabpg ) then
	iw_sheet.tab_da.closetab( iu_da_offline_downtime_tabpg )
end if
end event

event constructor;ib_end_overrided = false
sqlca.of_connect( )
ib_init_done = false
ib_coil_ending = false

end event

