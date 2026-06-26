$PBExportHeader$u_coil.sru
forward
global type u_coil from nonvisualobject
end type
end forward

shared variables
//int si_coil_count
end variables

global type u_coil from nonvisualobject
event ue_length_cutting ( )
event ue_reject_cutting ( )
event ue_1_min_timing ( )
event ue_station2_stack_start ( )
event ue_station1_stack_start ( )
event ue_station1_stack_complete ( )
event ue_station2_stack_complete ( )
event ue_stacker2_count ( )
event ue_stacker1_count ( )
end type
global u_coil u_coil

type variables
w_dt_change_job_reminder iw_dt_change_job_reminder
Private:
long il_coil_abc_num, il_customer_id
long il_ab_job_num, il_order_num
int ii_order_item_num
string is_coil_org_num, is_customer_name, is_alloy, is_temper, is_sheet_type, is_scrap_type, is_orig_cust_po
//string is_coil_status
int ii_coil_status_old
int ii_coil_status, ii_coil_finish_percent, ii_coil_finish_percent_update
int ii_coil_process_seq
long il_coil_nw, il_coil_begin_wt_from_shift /*** il_coil_nw is coil orgin wt ***/
//*****il_coil_begin_wt_from_shift is coil begin wt for this shift
long il_coil_nw_bal, il_init_wt   /*    */
//*****il_coil_nw_bal is coil current wt, il_init_wt is coil initial wt for this job*****//
long il_coil_process_wt
long il_scrap_wt, il_skid_wt
Datetime idt_online
Datetime idt_offline
long il_shift_id
long il_feed_pieces, il_reject_pieces
w_da_sheet iw_sheet
//w_dt_change_job_reminder iw_dt_change_job_reminder
//u_da_skid_scrap_tabpg iu_da_skid_scrap_tabpg

//DAS_STAGE1
u_da_skid_tabpg iu_da_skid_tabpg
u_da_scrap_tabpg iu_da_scrap_tabpg
//u_da_offline_skid_tabpg iu_da_offline_skid_tabpg
//u_da_offline_scrap_tabpg iu_da_offline_scrap_tabpg
//DAS_STAGE1

//DAS_STAGE1
u_da_coil_job_tabpg iu_da_coil_job_tabpg
//DAS_STAGE1
Real ir_hl_percent
/*
coil_shift_status
0	not queued (virgin)
1	just queued (queued still virgin)
2	ran (dirty)
3	saved
*/
int ii_coil_shift_status
Real ir_density, ir_width, ir_gauge, ir_feed_length, ir_reject_length, ir_current_theo_piece_wt, ir_part_width, ir_part_length

//Timing object for updating coil % -- testing

n_tmg itmg_1_min


//End of coil % testing...

end variables

forward prototypes
public function integer save ()
public subroutine finish (integer status, long wt)
public function long get_nw_bal ()
public function integer get_new_status ()
public function integer get_old_status ()
public function integer get_old_nw ()
public subroutine set_coil_shift_status (integer status)
public function string get_coil_org_id ()
public function long get_coil_abc_id ()
public subroutine set_coil_nw (long nw)
public function integer drop_it ()
public function integer split_and_save (integer new_status, long new_wt, long new_job_num)
public function integer get_coil_shift_status ()
public function long get_current_job ()
public function integer init (long al_coil_abc_num, long al_ab_job_num, long al_shift_id)
public function datetime get_on_time ()
public function datetime get_off_time ()
public subroutine of_set_new_shift_id (long al_shift)
public function integer of_get_finish_percent ()
public subroutine of_update_feed_lenght (real ar_feed)
public subroutine of_update_reject_length (real ar_reject)
public function real of_get_densit ()
public function real of_get_feedlength ()
public function real of_get_rejectlength ()
public function real of_get_width ()
public function real of_get_gauge ()
public function integer of_open_skid_scrap_tabpg ()
public function real of_get_theo_piece_wt ()
public function integer of_get_order_item ()
public function long of_get_order_num ()
public function w_da_sheet of_get_sheet_window ()
public function string of_get_customer_name ()
public function long of_get_init_wt ()
public function long of_get_customer_id ()
public function string of_get_alloy ()
public function string of_get_temper ()
public function real of_get_part_width ()
public function real of_get_part_length ()
public subroutine of_update (boolean ab_feed, integer ai_pcs_changed)
public function long of_get_shift_id ()
public function integer of_save_at_shift_end ()
public function integer of_recap_process_coil ()
public subroutine of_set_coil_origin_wt (long al_wt)
public function double of_get_yield ()
public subroutine of_select_coil_job_tabpg ()
public function u_da_coil_job_tabpg of_get_coi_job_tabpg ()
public subroutine of_update_from_skid_scrap ()
public function u_da_skid_tabpg of_get_skid_tab_page ()
public function u_da_scrap_tabpg of_get_scrap_tab_page ()
public subroutine of_select_skid_tabpg ()
public subroutine of_select_scrap_tabpg ()
public subroutine of_set_hl_percent (real ar_hl)
public function real of_get_hl_percent ()
public function integer of_get_scrap_type ()
public function string of_get_orig_cust_po ()
end prototypes

event ue_length_cutting();int li_changes
li_changes = il_feed_pieces
il_feed_pieces = message.longparm
li_changes = il_feed_pieces - li_changes

of_update(true, li_changes )


//DAS_STAGE1
if isValid(iu_da_skid_tabpg) and isValid( iu_da_scrap_tabpg ) then
	if iw_sheet.ib_good_part_as_reject then
//		of_select_scrap_tabpg( )
		iu_da_scrap_tabpg.of_add_current_scrap_pieces( li_changes )
	else
//		of_select_skid_tabpg( )
		iu_da_skid_tabpg.of_add_current_skid_pieces( li_changes )
	end if
end if
//DAS_STAGE1

end event

event ue_reject_cutting();int li_changes
li_changes = il_reject_pieces
il_reject_pieces = message.longparm
li_changes = il_reject_pieces - li_changes
of_update(false, li_changes )

//DAS_STAGE1
if isValid(iu_da_skid_tabpg) and isValid(iu_da_scrap_tabpg) then
	if iw_sheet.ib_good_part_as_reject then
//		of_select_skid_tabpg( )
		iu_da_skid_tabpg.of_add_current_skid_pieces( li_changes )
	else
//		of_select_scrap_tabpg( )
		iu_da_scrap_tabpg.of_add_current_scrap_pieces( li_changes )
	end if
end if
//DAS_STAGE1
end event

event ue_1_min_timing();if ii_coil_finish_percent = ii_coil_finish_percent_update then return

  int li_line
  li_line = iw_sheet.ii_line_id
//  UPDATE "LINE_CURRENT_STATUS"  
//     SET "COIL_PROCESS_RATE" = :ii_coil_finish_percent  
//   WHERE ( "LINE_CURRENT_STATUS"."LINE_NUM" = :li_line ) AND  
//         ( "LINE_CURRENT_STATUS"."COIL_ABC_NUM" = :il_coil_abc_num )   
//           ;
	if sqlca.sqlcode <> 0 then
		sqlca.of_rollback( )
		return
	else
		sqlca.of_commit( )
	end if

ii_coil_finish_percent_update = ii_coil_finish_percent
end event

event ue_station2_stack_start();if iw_sheet.ib_sendblanktosta2 then //and (not iw_sheet.ib_slavesta2tosta1) then
//	MessageBox("stacker 2", "stacker 2 stacking started")
	if isValid(iu_da_skid_tabpg) and isValid( iu_da_scrap_tabpg ) then
		
		//if iu_da_skid_tabpg.dw_current_edit.enabled and iu_da_skid_tabpg.dw_current_edit.object.stacker[iu_da_skid_tabpg.dw_current_edit.getrow( )] = 2  then
		if iu_da_skid_tabpg.dw_current_edit.enabled   then
		
//			MessageBox("Current skid", "Current skid not done, please done it first!", StopSign!)
//			return
		end if
		
		iu_da_skid_tabpg.of_stacker_new_skid( 2 )
		
	end if
end if
	
end event

event ue_station1_stack_start();if iw_sheet.ib_sendblanktosta1 then
//		MessageBox("stacker 1", "stacker 1 stacking started")
	if isValid(iu_da_skid_tabpg) and isValid( iu_da_scrap_tabpg ) then
		
		//if iu_da_skid_tabpg.dw_current_edit.enabled and iu_da_skid_tabpg.dw_current_edit.object.stacker[iu_da_skid_tabpg.dw_current_edit.getrow( )] = 1 then
		if iu_da_skid_tabpg.dw_current_edit.enabled then

//			MessageBox("Current skid", "Current skid not done, please done it first!", StopSign!)
//			return
		end if
		
		iu_da_skid_tabpg.of_stacker_new_skid( 1 )
		
	end if
end if
end event

event ue_station1_stack_complete();if not iw_sheet.ib_sendblanktosta1 then
//		MessageBox("stacker 1", "stacker 1 stacking completeed")
	if isValid(iu_da_skid_tabpg) and isValid( iu_da_scrap_tabpg ) then
		
//		if iu_da_skid_tabpg.dw_current_edit.enabled then
//			MessageBox("Current skid", "Current skid not done, please done it first!", StopSign!)
			iu_da_skid_tabpg.of_stacker_complete( 1 )
			//return
//		end if
		
//		iu_da_skid_tabpg.of_stacker_new_skid( 1 )
		
	end if
end if
end event

event ue_station2_stack_complete();if not iw_sheet.ib_sendblanktosta2 then //and (not iw_sheet.ib_slavesta2tosta1) then
//		MessageBox("stacker 1", "stacker 1 stacking started")
	if isValid(iu_da_skid_tabpg) and isValid( iu_da_scrap_tabpg ) then
		
//		if iu_da_skid_tabpg.dw_current_edit.enabled then
//			MessageBox("Current skid", "Current skid not done, please done it first!", StopSign!)
			iu_da_skid_tabpg.of_stacker_complete( 2 )
			//return
//		end if
		
//		iu_da_skid_tabpg.of_stacker_new_skid( 1 )
		
	end if
end if
end event

event ue_stacker2_count();long ll_count
int li_count
ll_count = message.longparm
li_count = ll_count
if isValid(iu_da_skid_tabpg) and isValid( iu_da_scrap_tabpg ) then
		of_select_skid_tabpg( )
		iu_da_skid_tabpg.of_stacker2_count( li_count )
end if
end event

event ue_stacker1_count();long ll_count
ll_count = message.longparm

if isValid(iu_da_skid_tabpg) and isValid( iu_da_scrap_tabpg ) then
		of_select_skid_tabpg( )
		iu_da_skid_tabpg.of_stacker1_count( ll_count )
end if
end event

public function integer save ();long ll_process_wt
datetime ld_on_time,ldt_now
int li_coil_run

//ll_process_wt = il_coil_begin_wt_from_shift - il_coil_nw_bal

ll_process_wt = il_init_wt - il_coil_nw_bal

if ll_process_wt > 0 then
				ld_on_time = idt_online
				//connect using sqlca;
			  sqlca.of_connect( )
			  ldt_now = DateTime( today(), now() )
			  
	UPDATE "SHIFT_COIL"  
   SET "COIL_END_STATUS" = :ii_coil_status,   
   "COIL_END_WT" = :il_coil_nw_bal,   
   "COIL_END_TIME" = :ldt_now,   
   "PROCESS_WT" = :ll_process_wt  
   WHERE ( "SHIFT_COIL"."AB_JOB_NUM" = :il_ab_job_num ) AND  
   		( "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_num ) AND
			( "SHIFT_COIL"."SHIFT_NUM" = :il_shift_id )
      ;

		if sqlca.sqlnrows < 1 then //No coils in shift coil table
		  select NVL(MAX("COIL_RUN_NUM"),0) into :li_coil_run from "SHIFT_COIL" where
			  "SHIFT_NUM" = :il_shift_id
			  ;
			  li_coil_run = li_coil_run + 1
			  
			  	ll_process_wt = il_coil_begin_wt_from_shift - il_coil_nw_bal
				if ll_process_wt < 1 then ll_process_wt = 0
				INSERT INTO "SHIFT_COIL"  
         	( "SHIFT_NUM",   
           	"COIL_RUN_NUM",   
           	"AB_JOB_NUM",   
           	"COIL_ABC_NUM",   
           	"COIL_BEGIN_STATUS",   
           	"COIL_END_STATUS",   
           	"COIL_BEGIN_WT",   
           	"COIL_END_WT",   
           	"COIL_BEGIN_TIME",   
           	"COIL_END_TIME",   
           	"NOTE",   
           	"PROCESS_WT" )  
  				VALUES ( :il_shift_id,   
           	:li_coil_run,   
           	:il_ab_job_num,   
           	:il_coil_abc_num,   
           	:ii_coil_status_old,
				:ii_coil_status,
           	:il_coil_begin_wt_from_shift ,   
           	:il_coil_nw_bal,   
           	:ld_on_time,   
           		:ldt_now,   
           	null,   
           	:ll_process_wt )  ;
			  	//COMMIT;
		end if
				if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
				end if
				
				UPDATE "PROCESS_COIL"  
     				SET "SHIFT_PROCESS_STATUS" = :ii_coil_status, "CURRENT_WT" = :il_coil_nw_bal //, "PROCESS_END_WT" =:il_coil_nw_bal
   					WHERE ( "COIL_ABC_NUM" = :il_coil_abc_num ) AND  
         				( "AB_JOB_NUM" = :il_ab_job_num )   
           ;
			  
			  if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
				end if
			  
			   
//				 UPDATE "SHIFT_COIL_JOB"  
//     				SET "STATUS" = 2  
//   			WHERE ( "SHIFT_COIL_JOB"."SHIFT_NUM" = :il_shift_id  ) AND  
//         			( "SHIFT_COIL_JOB"."AB_JOB_NUM" = :il_ab_job_num ) AND  
//         			( "SHIFT_COIL_JOB"."COIL_ABC_NUM" = :il_coil_abc_num )   
//           			;
//
//			  if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//				end if
//			  
			  UPDATE "COIL"  
     			SET "COIL_STATUS_FROM_LINE" = :ii_coil_status,  "COIL_STATUS" = :ii_coil_status,
         	"NET_WT_BALANCE_FROM_LINE" = :il_coil_nw_bal, "NET_WT_BALANCE" = :il_coil_nw_bal
				WHERE "COIL_ABC_NUM" = :il_coil_abc_num;
				
				if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
				end if
				
				sqlca.of_commit( )
				
				if ir_hl_percent <= 0.5 then
					//Disable to fix daily production report
//					sqlca.update_shift_coil( il_coil_abc_num , il_shift_id )
				end if
				
				if sqlca.sqlcode <> 0 then
					messageBox("Error", sqlca.sqlerrtext )
				end if
				
				int li_coil_count
				
				SELECT COUNT(*)  
    			INTO :li_coil_count  
    			FROM "PROCESS_COIL"  
   			WHERE "PROCESS_COIL"."AB_JOB_NUM" = :il_ab_job_num and
						("PROCESS_COIL"."CURRENT_WT" is null or "PROCESS_COIL"."CURRENT_WT" <> 0)
           ;
			  
			  if li_coil_count < 1 then
					// Job done
					  
					    UPDATE "AB_JOB"  
     						SET "TIME_DATE_FINISHED" = :ldt_now   
        					 //"JOB_DONE_TIME" = null  
  							 WHERE "AB_JOB"."AB_JOB_NUM" = :il_ab_job_num   
           				;
					  if sqlca.sqlcode <> 0 then
							sqlca.of_rollback( )
							return 1
						end if
					  
					  UPDATE "LINE_PRIORITY"  
     					SET "STATUS" = 0  
   					WHERE "LINE_PRIORITY"."AB_JOB_NUM" = :il_ab_job_num   
           			;
						  if sqlca.sqlcode <> 0 then
							sqlca.of_rollback( )
							else 
								sqlca.of_commit( )
							end if
				end if

				
				
end if //end if ll_process_wt > 0				
				
return 0
end function

public subroutine finish (integer status, long wt);if wt <= il_coil_nw then
	ii_coil_status_old = ii_coil_status
	ii_coil_status = status
	il_coil_nw_bal = wt
	il_coil_process_wt = il_coil_nw - il_coil_nw_bal
end if
//it_offline = now()
end subroutine

public function long get_nw_bal ();return il_coil_nw_bal
end function

public function integer get_new_status ();return ii_coil_status
end function

public function integer get_old_status ();return ii_coil_status_old
end function

public function integer get_old_nw ();return il_coil_nw
end function

public subroutine set_coil_shift_status (integer status);ii_coil_shift_status = status
end subroutine

public function string get_coil_org_id ();return is_coil_org_num
end function

public function long get_coil_abc_id ();return il_coil_abc_num
end function

public subroutine set_coil_nw (long nw);il_coil_nw = nw
end subroutine

public function integer drop_it ();//if gnv_connect.of_connectdb( ) <> 0 then
//	return -1
//end if
					UPDATE "PROCESS_COIL"  
     				SET "SHIFT_PROCESS_STATUS" = :ii_coil_status_old  
   					WHERE ( "COIL_ABC_NUM" = :il_coil_abc_num ) AND  
         				( "AB_JOB_NUM" = :il_ab_job_num )   
           		;
			  		COMMIT;
//gnv_connect.of_disconnectdb( )
return 0
end function

public function integer split_and_save (integer new_status, long new_wt, long new_job_num);//******************************************************************************
//***Function used for DAS online when job changeD with same coil***************
//***Set new job# new status and new wt*****************************************
//******************************************************************************
int li_coil_run
datetime ld_on_time, ldt_now
long ll_process_wt
ldt_now = DateTime(Today()  , Now() )
				//Changed by tony Oct 31 08
				ll_process_wt = il_init_wt - new_wt
				ld_on_time = idt_online
				//connect using sqlca;
			  
		if ll_process_wt > 0 then
			  	il_coil_nw_bal = new_wt
				ii_coil_status = new_status
				sqlca.of_connect( )
	
		UPDATE "SHIFT_COIL"  
   	SET 	"COIL_END_STATUS" = :ii_coil_status,   
   			"COIL_END_WT" = :il_coil_nw_bal,   
   			"COIL_END_TIME" = :ldt_now,   
   			"PROCESS_WT" = :ll_process_wt  
   	WHERE ( "SHIFT_COIL"."AB_JOB_NUM" = :il_ab_job_num ) AND  
   			( "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_num ) AND
				( "SHIFT_COIL"."SHIFT_NUM" = :il_shift_id )
      		;

			if sqlca.sqlnrows < 1 then //No coils in shift coil table
			  select NVL(MAX("COIL_RUN_NUM"),0) into :li_coil_run from "SHIFT_COIL" where
			  "SHIFT_NUM" = :il_shift_id
			  ;
			  li_coil_run = li_coil_run + 1
			  
			  	ll_process_wt = il_coil_begin_wt_from_shift - il_coil_nw_bal
				if ll_process_wt < 1 then ll_process_wt = 0
		  
				INSERT INTO "SHIFT_COIL"  
         	( "SHIFT_NUM",   
           	"COIL_RUN_NUM",   
           	"AB_JOB_NUM",   
           	"COIL_ABC_NUM",   
           	"COIL_BEGIN_STATUS",   
           	"COIL_END_STATUS",   
           	"COIL_BEGIN_WT",   
           	"COIL_END_WT",   
           	"COIL_BEGIN_TIME",   
           	"COIL_END_TIME",   
           	"NOTE",   
           	"PROCESS_WT" )  
  				VALUES ( :il_shift_id,   
           	:li_coil_run,   
           	:il_ab_job_num,   
           	:il_coil_abc_num,   
           	:ii_coil_status_old,
				:ii_coil_status,
	           :il_coil_begin_wt_from_shift ,   
//           	:il_init_wt,
				  :il_coil_nw_bal,   
           	:ld_on_time,   
           		:ldt_now,   
           	null,   
           	:ll_process_wt )  ;
			  	//COMMIT;
		end if
				if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
				end if
	
	/*
	select NVL(MAX("COIL_RUN_NUM"),0) into :li_coil_run from "SHIFT_COIL" where
			  "SHIFT_NUM" = :il_shift_id;
			  li_coil_run = li_coil_run + 1
			  			  
				INSERT INTO "SHIFT_COIL"  
         	( "SHIFT_NUM",   
           	"COIL_RUN_NUM",   
           	"AB_JOB_NUM",   
           	"COIL_ABC_NUM",   
           	"COIL_BEGIN_STATUS",   
           	"COIL_END_STATUS",   
           	"COIL_BEGIN_WT",   
           	"COIL_END_WT",   
           	"COIL_BEGIN_TIME",   
           	"COIL_END_TIME",   
           	"NOTE",   
           	"PROCESS_WT" )  
  				VALUES ( :il_shift_id,   
           	:li_coil_run,   
           	:il_ab_job_num,   
           	:il_coil_abc_num,   
           	:ii_coil_status_old,
				:ii_coil_status,              	   
           	:il_init_wt ,   
           	:il_coil_nw_bal,   
           	:ld_on_time,   
           		:ldt_now,   
           	null,   
           	:ll_process_wt )  ;
			  	if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
				else
					sqlca.of_commit( )
				end if
				
*/

				UPDATE "PROCESS_COIL"  
     				SET "SHIFT_PROCESS_STATUS" = 1, "CURRENT_WT" = :new_wt//, "PROCESS_END_WT"=:new_wt  
   					WHERE ( "COIL_ABC_NUM" = :il_coil_abc_num ) AND  
         				( "AB_JOB_NUM" = :il_ab_job_num )   
           ;
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				return 1
			else
				sqlca.of_commit( )
			end if		
			
			//*************Change by tony**********
			//il_coil_nw = new_wt			  
			//*************************************
		ii_coil_status_old = new_status
		il_init_wt = il_coil_nw_bal
	
		long ll_db_init_wt
	
		int li_coil_count
				
				SELECT COUNT(*)  
    			INTO :li_coil_count  
    			FROM "PROCESS_COIL"  
   			WHERE "PROCESS_COIL"."AB_JOB_NUM" = :il_ab_job_num and
						("PROCESS_COIL"."CURRENT_WT" is null or "PROCESS_COIL"."CURRENT_WT" <> 0)
           ;
			  
			  if li_coil_count < 1 then
					// Job done
					  
					  UPDATE "AB_JOB"  
     						SET "TIME_DATE_FINISHED" = :ldt_now   
        					 //"JOB_DONE_TIME" = null  
  							 WHERE "AB_JOB"."AB_JOB_NUM" = :il_ab_job_num   
           				;
					  if sqlca.sqlcode <> 0 then
							sqlca.of_rollback( )
							return 1
						end if
					  
					  UPDATE "LINE_PRIORITY"  
     					SET "STATUS" = 0  
   					WHERE "LINE_PRIORITY"."AB_JOB_NUM" = :il_ab_job_num   
           			;
						  	if sqlca.sqlcode <> 0 then
								sqlca.of_rollback( )
							else
								sqlca.of_commit( )
							end if
				end if
	
//		UPDATE "PROCESS_COIL"  
//     	SET "PROCESS_QUANTITY" = :il_init_wt ,   
//         "CURRENT_WT" = :il_init_wt  
//   	WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :il_coil_abc_num ) AND  
//         ( "PROCESS_COIL"."AB_JOB_NUM" = :il_ab_job_num )   ;
//	
//		if sqlca.sqlcode <> 0 then
//			sqlca.of_rollback( )
//			return 1
//		end if
		
		
		 
		 
		 
		 
		 
//		 UPDATE "SHIFT_COIL_JOB"  
//     				SET "STATUS" = 2  
//   			WHERE ( "SHIFT_COIL_JOB"."SHIFT_NUM" = :il_shift_id  ) AND  
//         			( "SHIFT_COIL_JOB"."AB_JOB_NUM" = :il_ab_job_num ) AND  
//         			( "SHIFT_COIL_JOB"."COIL_ABC_NUM" = :il_coil_abc_num )   
//           			;
//			if sqlca.sqlcode <> 0 then
//				sqlca.of_rollback( )
//			else
//				sqlca.of_commit( )
//			end if
		
		
		
		
	
end if //end if ll_process_wt > 0
	
	il_ab_job_num = new_job_num
	idt_online = DateTime(today(),now())
	
  	SELECT "AB_JOB"."ORDER_ITEM_NUM",   
         "AB_JOB"."ORDER_ABC_NUM"  
    INTO :ii_order_item_num,   
         :il_order_num  
    FROM "AB_JOB"
	 WHERE "AB_JOB"."AB_JOB_NUM" = :il_ab_job_num ;

	SELECT "METAL_DENSITY"."METAL_DENSITY"  
    INTO :ir_density  
    FROM "AB_JOB",   
         "ORDER_ITEM",   
         "METAL_DENSITY"  
   WHERE ( "ORDER_ITEM"."ORDER_ITEM_NUM" = "AB_JOB"."ORDER_ITEM_NUM" ) and  
         ( "ORDER_ITEM"."ORDER_ABC_NUM" = "AB_JOB"."ORDER_ABC_NUM" ) and  
         ( "ORDER_ITEM"."ALLOY2" = "METAL_DENSITY"."METAL_ALLOY" ) and  
         ( ( "AB_JOB"."AB_JOB_NUM" = :il_ab_job_num )   
         )   ;
	
//	SELECT "CUSTOMER_ORDER"."SCRAP_HANDING_TYPE"  
//    INTO :is_scrap_type  
//    FROM "CUSTOMER_ORDER"  
//   WHERE "CUSTOMER_ORDER"."ORDER_ABC_NUM" = :il_order_num ;
	
	SELECT "CUSTOMER_ORDER"."SCRAP_HANDING_TYPE",   "CUSTOMER_ORDER"."ORIG_CUSTOMER_PO"
    INTO :is_scrap_type, :is_orig_cust_po
    FROM "CUSTOMER_ORDER"  
   WHERE "CUSTOMER_ORDER"."ORDER_ABC_NUM" = :il_order_num ;
	
	
	
	if not isNull(is_scrap_type) then is_scrap_type = Trim(is_scrap_type)
	
	SELECT order_item.theoretical_unit_wt, order_item.sheet_type INTO :ir_current_theo_piece_wt, :is_sheet_type
		FROM order_item
	WHERE order_abc_num = :il_order_num AND order_item_num = :ii_order_item_num;
	
	CHOOSE CASE Upper(Trim(is_sheet_type))
		CASE "RECTANGLE"
			SELECT "RECTANGLE"."RT_LENGTH",   
         "RECTANGLE"."RT_WIDTH"  
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    	FROM "RECTANGLE"  
   	WHERE ( "RECTANGLE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         ( "RECTANGLE"."ORDER_ABC_NUM" = :il_order_num )   ;
			//MessageBox(string(ir_part_length ), string( ir_part_width ))
		CASE "CHEVRON"
			SELECT "CHEVRON"."CH_LENGTH",
	      	"CHEVRON"."CH_WIDTH"
	 		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "CHEVRON"  
   		WHERE ( "CHEVRON"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "CHEVRON"."ORDER_ABC_NUM" = :il_order_num  )   
           ;
		case "CIRCLE"
			SELECT "CIRCLE"."C_DIAMETER",   
         	"CIRCLE"."C_DIAMETER"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "CIRCLE"  
   		WHERE ( "CIRCLE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "CIRCLE"."ORDER_ABC_NUM" = :il_order_num  )   
           	;
		case "FENDER"
			SELECT "FENDER"."FE_LENGTH", 
	       			 "FENDER"."FE_SIDE"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "FENDER"  
   		WHERE ( "FENDER"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "FENDER"."ORDER_ABC_NUM" = :il_order_num  ) ;
	
	case "LIFTGATE"
		SELECT "LIFTGATE_SHAPE"."LI_LENGTH",
         	"LIFTGATE_SHAPE"."LI_WIDTH"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "LIFTGATE_SHAPE"  
   		WHERE ( "LIFTGATE_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "LIFTGATE_SHAPE"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "OTHER"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "PARALLELOGRAM"
		SELECT "PARALLELOGRAM"."P_LENGTH",
         	"PARALLELOGRAM"."P_WIDTH" 
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "PARALLELOGRAM"  
   		WHERE ( "PARALLELOGRAM"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "PARALLELOGRAM"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "REINFORCEMENT"
		SELECT "REINFORCEMENT"."RE_LENGTH",
        		 "REINFORCEMENT"."RE_WIDTH"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "REINFORCEMENT"  
   		WHERE ( "REINFORCEMENT"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "REINFORCEMENT"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "TRAPEZOID"
		SELECT "TRAPEZOID"."TR_LONG_LENGTH",
         	"TRAPEZOID"."TR_WIDTH"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "TRAPEZOID"  
   		WHERE ( "TRAPEZOID"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "TRAPEZOID"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "X SHAPE"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :il_order_num  ) ;

//-----------------------------------------------------------------------

	END CHOOSE	

	
		Int li_coils_count
			  SELECT COUNT(*)  
    			INTO :li_coils_count 
    			FROM "SHIFT_COIL"  
   				WHERE ( "SHIFT_COIL"."AB_JOB_NUM" = :il_ab_job_num ) AND  
         		( "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_num ) AND
					( "SHIFT_COIL"."SHIFT_NUM" = :il_shift_id );
		if li_coils_count < 1 then
			
			select NVL(MAX("COIL_RUN_NUM"),0) into :li_coil_run from "SHIFT_COIL" where
			  "SHIFT_NUM" = :il_shift_id
			  ;
			  li_coil_run = li_coil_run + 1
			  
			  			  
				INSERT INTO "SHIFT_COIL"  
         	( "SHIFT_NUM",   
           	"COIL_RUN_NUM",   
           	"AB_JOB_NUM",   
           	"COIL_ABC_NUM",   
           	"COIL_BEGIN_STATUS",   
           	"COIL_BEGIN_WT",   
           	"COIL_BEGIN_TIME",   
           	"NOTE" )
  				VALUES ( :il_shift_id,   
           	:li_coil_run,   
           	:il_ab_job_num,   
           	:il_coil_abc_num,   
           	:new_status,
           	:new_wt ,   
           	:ldt_now,   
           	null   
           	 );
					if sqlca.sqlcode <> 0 then
						sqlca.of_rollback( )
					else
						sqlca.of_commit( )
					end if
		
		end if
		
//		sqlca.of_commit( )
	
	
//	if isValid( iu_da_skid_tabpg ) and isValid( iu_da_scrap_tabpg ) then
////		iu_da_skid_tabpg.of_init( iw_sheet )
////		iu_da_scrap_tabpg.of_init( iw_sheet )
//
//	end if
//
//	if isValid( iu_da_coil_job_tabpg  ) then
//		iu_da_coil_job_tabpg.cb_reverse.enabled = false
//	end if
return 0
end function

public function integer get_coil_shift_status ();return ii_coil_shift_status
end function

public function long get_current_job ();return il_ab_job_num
end function

public function integer init (long al_coil_abc_num, long al_ab_job_num, long al_shift_id);long ll_nw, ll_cust_id
int li_status,li_coil_run
  //connect using sqlca;
  sqlca.of_connect( )
  il_shift_id = al_shift_id
  SELECT "COIL"."COIL_ORG_NUM",   
         "COIL"."COIL_STATUS",   
         "COIL"."NET_WT",
			"COIL"."COIL_WIDTH",
			"COIL"."COIL_GAUGE",
			"COIL"."CUSTOMER_ID",
			"COIL"."COIL_ALLOY2",
			"COIL"."COIL_TEMPER",
			"COIL"."NET_WT_BALANCE"
    INTO :is_coil_org_num,   
         :li_status,   
         :ll_nw,
			:ir_width,
			:ir_gauge,
			:ll_cust_id,
			:is_alloy,
			:is_temper,
			:il_coil_nw_bal
    FROM "COIL"  
   WHERE "COIL"."COIL_ABC_NUM" = :al_coil_abc_num   
           ;

IF SQLCA.SQLCode <> 0 THEN 
		  return -1
	else
/*
	 SELECT NVL("METAL_DENSITY"."METAL_DENSITY", 0.098)  
    INTO :ir_density  
    FROM "COIL",   
         "METAL_DENSITY"  
   WHERE ( "COIL"."COIL_ALLOY2" = "METAL_DENSITY"."METAL_ALLOY" (+) ) and  
         ( ( "COIL"."COIL_ABC_NUM" = :al_coil_abc_num )   
         )   ;
	*/	  
	
//	MessageBox(string( ll_nw ), string( il_coil_nw_bal ))
	
	if ll_nw < 1 then
		return -1
	end if
	
	if il_coil_nw_bal < 1 then
		return -1
	end if
	
//	MessageBox("", "")
	
	 SELECT "METAL_DENSITY"."METAL_DENSITY"  
    INTO :ir_density  
    FROM "AB_JOB",   
         "ORDER_ITEM",   
         "METAL_DENSITY"  
   WHERE ( "ORDER_ITEM"."ORDER_ITEM_NUM" = "AB_JOB"."ORDER_ITEM_NUM" ) and  
         ( "ORDER_ITEM"."ORDER_ABC_NUM" = "AB_JOB"."ORDER_ABC_NUM" ) and  
         ( "ORDER_ITEM"."ALLOY2" = "METAL_DENSITY"."METAL_ALLOY" ) and  
         ( ( "AB_JOB"."AB_JOB_NUM" = :al_ab_job_num )   
         )   ;

		IF SQLCA.SQLCode <> 0 and SQLCA.SQLCode <> 100 THEN  return -1
		
		if SQLCA.SQLCode = 100 or isNull(ir_density) or ir_density = 0 then
			ir_density = 0.098
		end if
		  
	  
			
	  
	  SELECT "CUSTOMER"."CUSTOMER_SHORT_NAME"  
    	INTO :is_customer_name  
    	FROM "CUSTOMER"  
   	WHERE "CUSTOMER"."CUSTOMER_ID" = :ll_cust_id   
           ;
		  IF SQLCA.SQLCode <> 0 THEN  return -1
//		  SELECT "PROCESS_COIL"."SHIFT_PROCESS_STATUS",   
//         "PROCESS_COIL"."CURRENT_WT",  "PROCESS_COIL"."PROCESS_QUANTITY"
//    		INTO :ii_coil_status ,  
//         		:il_coil_nw_bal,
//					:il_init_wt
//    		FROM "PROCESS_COIL"  
//   		WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :al_coil_abc_num ) AND  
//         	( "PROCESS_COIL"."AB_JOB_NUM" = :al_ab_job_num )   ;
		  SELECT "PROCESS_COIL"."PROCESS_QUANTITY","PROCESS_COIL"."CURRENT_WT"
    		INTO 	:il_init_wt, :il_coil_begin_wt_from_shift
    		FROM "PROCESS_COIL"  
   		WHERE ( "PROCESS_COIL"."COIL_ABC_NUM" = :al_coil_abc_num ) AND  
         	( "PROCESS_COIL"."AB_JOB_NUM" = :al_ab_job_num )   ;
			
			
			IF SQLCA.SQLCode <> 0 THEN  return -1
//		if isNull(ii_coil_status) then
			ii_coil_status = li_status
//		end if
//		if isNull(il_coil_nw_bal) then 
//			il_coil_nw = ll_nw
//			il_coil_nw_bal = ll_nw
//		end if
		
		if (not isNull( il_coil_begin_wt_from_shift )) and il_coil_begin_wt_from_shift < il_coil_nw_bal then
			il_coil_nw_bal = il_coil_begin_wt_from_shift
		end if
		
		il_coil_nw = il_coil_nw_bal
		il_coil_nw = ll_nw
		if isNull( il_coil_begin_wt_from_shift ) then il_coil_begin_wt_from_shift = il_coil_nw_bal
		
		if il_init_wt > il_coil_nw_bal then
			il_init_wt = il_coil_nw_bal
		end if
		
		il_coil_abc_num = al_coil_abc_num
		ii_coil_status_old = ii_coil_status
//		il_coil_nw = il_coil_nw_bal
//		il_coil_begin_wt_from_shift = il_coil_nw_bal
//		il_coil_nw_bal = il_coil_begin_wt_from_shift
		idt_online = DateTime(today(),now())
		ii_coil_shift_status = 0
		il_ab_job_num = al_ab_job_num
		il_customer_id = ll_cust_id
		UPDATE "PROCESS_COIL"  
     				SET "SHIFT_PROCESS_STATUS" = 1  
   					WHERE ( "COIL_ABC_NUM" = :il_coil_abc_num ) AND  
         				( "AB_JOB_NUM" = :il_ab_job_num )   
           ;
			
			IF SQLCA.SQLCode <> 0 THEN
				sqlca.of_rollback( )
				return -1
			end if
		
		Int li_coils_count
			  SELECT COUNT(*)  
    			INTO :li_coils_count 
    			FROM "SHIFT_COIL"  
   				WHERE ( "SHIFT_COIL"."AB_JOB_NUM" = :il_ab_job_num ) AND  
         		( "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_num ) AND
					( "SHIFT_COIL"."SHIFT_NUM" = :il_shift_id );
		if li_coils_count < 1 then
			
			select NVL(MAX("COIL_RUN_NUM"),0) into :li_coil_run from "SHIFT_COIL" where
			  "SHIFT_NUM" = :il_shift_id
			  ;
			  li_coil_run = li_coil_run + 1
			  
			  			  
				INSERT INTO "SHIFT_COIL"  
         	( "SHIFT_NUM",   
           	"COIL_RUN_NUM",   
           	"AB_JOB_NUM",   
           	"COIL_ABC_NUM",   
           	"COIL_BEGIN_STATUS",   
           	"COIL_BEGIN_WT",   
           	"COIL_BEGIN_TIME",   
           	"NOTE" )
  				VALUES ( :il_shift_id,   
           	:li_coil_run,   
           	:il_ab_job_num,   
           	:il_coil_abc_num,   
           	:ii_coil_status_old,
           	:il_coil_begin_wt_from_shift ,   
           	:idt_online,   
           	null   
           	 );
		
		end if
		
		sqlca.of_commit( )
//		  INSERT INTO "SHIFT_COIL_JOB"  
//         ( "SHIFT_NUM",   
//           "AB_JOB_NUM",   
//           "COIL_ABC_NUM",   
//           "STATUS" )  
//  			VALUES ( :il_shift_id,   
//           :il_ab_job_num ,   
//           :il_coil_abc_num,   
//           1 )  ;
//			  if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//				else
//					sqlca.of_commit( )
//				end if
			  
	

END If
	
	  SELECT "AB_JOB"."ORDER_ITEM_NUM",   
         "AB_JOB"."ORDER_ABC_NUM"  
    INTO :ii_order_item_num,   
         :il_order_num  
    FROM "AB_JOB"
	 WHERE "AB_JOB"."AB_JOB_NUM" = :il_ab_job_num ;

	SELECT "CUSTOMER_ORDER"."SCRAP_HANDING_TYPE",   "CUSTOMER_ORDER"."ORIG_CUSTOMER_PO"
    INTO :is_scrap_type, :is_orig_cust_po
    FROM "CUSTOMER_ORDER"  
   WHERE "CUSTOMER_ORDER"."ORDER_ABC_NUM" = :il_order_num ;
	
	if not isNull(is_scrap_type) then is_scrap_type = Trim(is_scrap_type)
	
	SELECT order_item.theoretical_unit_wt, order_item.sheet_type INTO :ir_current_theo_piece_wt, :is_sheet_type
		FROM order_item
	WHERE order_abc_num = :il_order_num AND order_item_num = :ii_order_item_num;
	
	//MessageBox(Upper(is_sheet_type), string(il_order_num) + " " + string(ii_order_item_num )  )
	
	CHOOSE CASE Upper(Trim(is_sheet_type))
		CASE "RECTANGLE"
			SELECT "RECTANGLE"."RT_LENGTH",   
         "RECTANGLE"."RT_WIDTH"  
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    	FROM "RECTANGLE"  
   	WHERE ( "RECTANGLE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         ( "RECTANGLE"."ORDER_ABC_NUM" = :il_order_num )   ;
			//MessageBox(string(ir_part_length ), string( ir_part_width ))
		CASE "CHEVRON"
			SELECT "CHEVRON"."CH_LENGTH",
	      	"CHEVRON"."CH_WIDTH"
	 		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "CHEVRON"  
   		WHERE ( "CHEVRON"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "CHEVRON"."ORDER_ABC_NUM" = :il_order_num  )   
           ;
		case "CIRCLE"
			SELECT "CIRCLE"."C_DIAMETER",   
         	"CIRCLE"."C_DIAMETER"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "CIRCLE"  
   		WHERE ( "CIRCLE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "CIRCLE"."ORDER_ABC_NUM" = :il_order_num  )   
           	;
		case "FENDER"
			SELECT "FENDER"."FE_LENGTH", 
	       			 "FENDER"."FE_SIDE"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "FENDER"  
   		WHERE ( "FENDER"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "FENDER"."ORDER_ABC_NUM" = :il_order_num  ) ;
	
	case "LIFTGATE"
		SELECT "LIFTGATE_SHAPE"."LI_LENGTH",
         	"LIFTGATE_SHAPE"."LI_WIDTH"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "LIFTGATE_SHAPE"  
   		WHERE ( "LIFTGATE_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "LIFTGATE_SHAPE"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "OTHER"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "PARALLELOGRAM"
		SELECT "PARALLELOGRAM"."P_LENGTH",
         	"PARALLELOGRAM"."P_WIDTH" 
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "PARALLELOGRAM"  
   		WHERE ( "PARALLELOGRAM"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "PARALLELOGRAM"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "REINFORCEMENT"
		SELECT "REINFORCEMENT"."RE_LENGTH",
        		 "REINFORCEMENT"."RE_WIDTH"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "REINFORCEMENT"  
   		WHERE ( "REINFORCEMENT"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "REINFORCEMENT"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "TRAPEZOID"
		SELECT "TRAPEZOID"."TR_LONG_LENGTH",
         	"TRAPEZOID"."TR_WIDTH"
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "TRAPEZOID"  
   		WHERE ( "TRAPEZOID"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "TRAPEZOID"."ORDER_ABC_NUM" = :il_order_num  ) ;
	case "X SHAPE"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO 	:ir_part_length,   
         		:ir_part_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item_num ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :il_order_num  ) ;

//-----------------------------------------------------------------------

	END CHOOSE	
	
//	if Upper(is_sheet_type) = "RECTANGLE" then
//		  
//	end if
	
	il_feed_pieces = 0
	il_reject_pieces = 0
	of_open_skid_scrap_tabpg( )
	iw_sheet.cb_end_coil.enabled = false
	iw_sheet.cb_end_coil.visible = false
	itmg_1_min = create n_tmg
	itmg_1_min.of_setsingle( true)
	itmg_1_min.inv_single.of_register( this, "ue_1_min_timing", 60)
	//iu_da_skid_scrap_tabpg.of_init( iw_sheet )
	
return 0


end function

public function datetime get_on_time ();return idt_online
end function

public function datetime get_off_time ();return idt_offline
end function

public subroutine of_set_new_shift_id (long al_shift);il_shift_id = al_shift
idt_online = DateTime( Today(), Now() )
il_coil_begin_wt_from_shift  = il_coil_nw_bal
end subroutine

public function integer of_get_finish_percent ();return MIN(ii_coil_finish_percent, 100)
end function

public subroutine of_update_feed_lenght (real ar_feed);ir_feed_length = ar_feed
//ir_reject_length = ar_reject
end subroutine

public subroutine of_update_reject_length (real ar_reject);ir_reject_length = ar_reject
end subroutine

public function real of_get_densit ();return ir_density
end function

public function real of_get_feedlength ();return ir_feed_length
end function

public function real of_get_rejectlength ();return ir_reject_length
end function

public function real of_get_width ();return ir_width
end function

public function real of_get_gauge ();return ir_gauge
end function

public function integer of_open_skid_scrap_tabpg ();int li_rc
li_rc = 0
//if not ( isValid(iu_da_coil_job_tabpg)) then
//	iu_da_coil_job_tabpg = create u_da_coil_job_tabpg
//	li_rc = iw_sheet.tab_da.opentab( iu_da_coil_job_tabpg , 1)
//	iu_da_coil_job_tabpg.of_init( iw_sheet )
//end if

//DAS_STAGE1
//if not iw_sheet.ib_offline_mode then
	if not (isValid(iu_da_skid_tabpg) and isValid(iu_da_scrap_tabpg))  then
		iu_da_scrap_tabpg = create u_da_scrap_tabpg
		iu_da_skid_tabpg = create u_da_skid_tabpg
		li_rc = iw_sheet.tab_da.opentab( iu_da_skid_tabpg , 1)
		li_rc = iw_sheet.tab_da.opentab( iu_da_scrap_tabpg , 2)
		iu_da_scrap_tabpg.of_init( iw_sheet )
		iu_da_skid_tabpg.of_init( iw_sheet )
	end if
//	if iw_sheet.ib_feedreject then
//		iw_sheet.tab_da.selecttab( iu_da_skid_tabpg )
//	else
//		iw_sheet.tab_da.selecttab( iu_da_scrap_tabpg )
//	end if
//	of_update_from_skid_scrap( )
//else //offline mode
//	if not (isValid(iu_da_offline_scrap_tabpg) and isValid(iu_da_offline_skid_tabpg)) then
//		iu_da_offline_scrap_tabpg = create u_da_offline_scrap_tabpg
//		iu_da_offline_skid_tabpg = create u_da_offline_skid_tabpg
//		iw_sheet.tab_da.opentab( iu_da_offline_skid_tabpg , 1)
//		iw_sheet.tab_da.opentab( iu_da_offline_scrap_tabpg , 2)
//		iu_da_offline_scrap_tabpg.of_init( iw_sheet )
//		iu_da_offline_skid_tabpg.of_init( iw_sheet )
//		iw_sheet.tab_da.selecttab( iu_da_offline_skid_tabpg)
//	end if
//	of_update_from_skid_scrap( )
//end if
//
//DAS_STAGE1
return li_rc
end function

public function real of_get_theo_piece_wt ();return ir_current_theo_piece_wt
end function

public function integer of_get_order_item ();return ii_order_item_num
end function

public function long of_get_order_num ();return il_order_num
end function

public function w_da_sheet of_get_sheet_window ();return iw_sheet
end function

public function string of_get_customer_name ();return is_customer_name
end function

public function long of_get_init_wt ();return il_init_wt
end function

public function long of_get_customer_id ();return il_customer_id
end function

public function string of_get_alloy ();return is_alloy
end function

public function string of_get_temper ();return is_temper
end function

public function real of_get_part_width ();return ir_part_width
end function

public function real of_get_part_length ();return ir_part_length
end function

public subroutine of_update (boolean ab_feed, integer ai_pcs_changed);long ll_nw_before

ll_nw_before = il_coil_nw_bal

if ab_feed then
	il_coil_nw_bal = il_coil_nw_bal - ir_density * ir_width * ir_gauge * ir_feed_length * ai_pcs_changed
else
	il_coil_nw_bal = il_coil_nw_bal - ir_density * ir_width * ir_gauge * ir_reject_length * ai_pcs_changed
end if
//il_coil_nw_bal = il_coil_nw - (ir_density * ir_width * ir_gauge * ir_feed_length * il_feed_pieces ) &
//	- (ir_density * ir_width * ir_gauge * ir_reject_length * il_reject_pieces )
//

if il_coil_nw_bal < 10 then
	ii_coil_status = 0
	il_coil_process_wt = il_coil_nw
	il_coil_nw_bal = 0
else
	il_coil_process_wt = il_coil_nw - il_coil_nw_bal
end if

if il_coil_nw <> 0 then
	ii_coil_finish_percent = (il_coil_process_wt / il_coil_nw ) * 100
else
	ii_coil_finish_percent = 100
end if

IF ii_coil_finish_percent > 100 then
	ii_coil_finish_percent = 100
end if

if isValid(this.of_get_scrap_tab_page( )) then
	if this.of_get_scrap_tab_page( ).dw_current_quality_scrap.rowcount( ) = 1 then
		if ii_coil_finish_percent > 50 then
			this.of_get_scrap_tab_page( ).dw_current_quality_scrap.object.scrap_item_od[1] = 0
		else
			this.of_get_scrap_tab_page( ).dw_current_quality_scrap.object.scrap_item_od[1] = 1
		end if
	end if
end if
end subroutine

public function long of_get_shift_id ();return il_shift_id
end function

public function integer of_save_at_shift_end ();//return 0 if good, 1 if failed
long ll_process_wt
datetime ld_on_time,ldt_now
int li_coil_run

//of_update_from_skid_scrap( )

IF IsValid( iu_da_skid_tabpg ) then
	iu_da_skid_tabpg.of_save( )
end if


if isValid(iu_da_scrap_tabpg ) then
	iu_da_scrap_tabpg.of_save( )
end if
	
//ll_process_wt = il_coil_begin_wt_from_shift - il_coil_nw_bal
ll_process_wt = MIN((il_coil_begin_wt_from_shift - il_coil_nw_bal) , (il_init_wt - il_coil_nw_bal))

if ll_process_wt >= 0 then
				ld_on_time = idt_online
				//connect using sqlca;
			  sqlca.of_connect( )
			  //Changed by Tony
			  	ldt_now = DateTime( today(), now() )
			
				
				  UPDATE "SHIFT_COIL"  
     				SET "COIL_END_STATUS" = :ii_coil_status,   
         			"COIL_END_WT" = :il_coil_nw_bal,   
         			"COIL_END_TIME" = :ldt_now,   
         			"PROCESS_WT" = :ll_process_wt  
   				WHERE ( "SHIFT_COIL"."AB_JOB_NUM" = :il_ab_job_num ) AND  
         			( "SHIFT_COIL"."COIL_ABC_NUM" = :il_coil_abc_num ) AND
						( "SHIFT_COIL"."SHIFT_NUM" = :il_shift_id )
           			;

					if sqlca.sqlnrows < 1 then //No coils in shift coil table
						
						select NVL(MAX("COIL_RUN_NUM"),0) into :li_coil_run from "SHIFT_COIL" where
			  				"SHIFT_NUM" = :il_shift_id
			  				;
			  			li_coil_run = li_coil_run + 1
			  						  			  
						INSERT INTO "SHIFT_COIL"  
         			( "SHIFT_NUM",   
           			"COIL_RUN_NUM",   
           			"AB_JOB_NUM",   
           			"COIL_ABC_NUM",   
           			"COIL_BEGIN_STATUS",   
           			"COIL_END_STATUS",   
           			"COIL_BEGIN_WT",   
           			"COIL_END_WT",   
           			"COIL_BEGIN_TIME",   
           			"COIL_END_TIME",   
           			"NOTE",   
           			"PROCESS_WT" )  
  						VALUES ( :il_shift_id,   
           			:li_coil_run,   
           			:il_ab_job_num,   
           			:il_coil_abc_num,   
           			:ii_coil_status_old,
						:ii_coil_status,
           			:il_coil_begin_wt_from_shift ,   
           			:il_coil_nw_bal,   
           			:ld_on_time,   
           			:ldt_now,   
           			null,   
           			:ll_process_wt )  ;
					end if
				if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
				end if
				
				UPDATE "PROCESS_COIL"  
     				SET "SHIFT_PROCESS_STATUS" = :ii_coil_status, "CURRENT_WT" = :il_coil_nw_bal 
   					WHERE ( "COIL_ABC_NUM" = :il_coil_abc_num ) AND  
         				( "AB_JOB_NUM" = :il_ab_job_num )   
           ;
			  
			  if sqlca.sqlcode <> 0 then
					sqlca.of_rollback( )
					return 1
				end if
			  
				


//			  UPDATE "COIL"  
//     			SET "COIL_STATUS" = :ii_coil_status,   
//         	"NET_WT_BALANCE" = :il_coil_nw_bal
//				WHERE "COIL_ABC_NUM" = :il_coil_abc_num;
//				
//				if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				end if
				
				sqlca.of_commit( )
end if //end if ll_process_wt > 0				
				
//return 0
return 0
end function

public function integer of_recap_process_coil ();//return 0
datastore lds_process_coil_skid_scrap
long ll_rc
lds_process_coil_skid_scrap = create datastore
lds_process_coil_skid_scrap.dataobject = "d_process_coil_skid_scrap_union_4_recap"
lds_process_coil_skid_scrap.settransobject( sqlca)
lds_process_coil_skid_scrap.retrieve( il_coil_abc_num )
ll_rc = lds_process_coil_skid_scrap.rowcount( )
MessageBox("processcoil count", string( ll_rc ))

return ll_rc
end function

public subroutine of_set_coil_origin_wt (long al_wt);il_coil_nw = al_wt
end subroutine

public function double of_get_yield ();//return percentage xx.xx ie. 99.00
double ld_yield
//of_update_from_skid_scrap( )

ld_yield = (1- (il_scrap_wt / get_old_nw ())) * 100
//ld_yield = ( 1- il )
ld_yield = Round(ld_yield, 2 )
//if ld_yield >= 99.99 then
//	ld_yield = 99.99
//end if
return ld_yield
//return 99.99
end function

public subroutine of_select_coil_job_tabpg ();//if isValid( iu_da_coil_job_tabpg ) then
//	iw_sheet.tab_da.selecttab( iu_da_coil_job_tabpg )
//end if
end subroutine

public function u_da_coil_job_tabpg of_get_coi_job_tabpg ();return iu_da_coil_job_tabpg

end function

public subroutine of_update_from_skid_scrap ();long ll_nw_before, ll_scrap_wt, ll_skid_wt

//ll_nw_before = il_coil_nw_bal

ll_scrap_wt = 0
ll_skid_wt = 0

if iw_sheet.ib_offline_mode then //offline mode
// 	if isValid( iu_da_offline_scrap_tabpg ) and isValid( iu_da_offline_skid_tabpg ) then
//		if iu_da_offline_scrap_tabpg.dw_scrap.rowcount( ) < 1 then
//			ll_scrap_wt = 0
//		else
//			ll_scrap_wt = iu_da_offline_scrap_tabpg.dw_scrap.object.compute_1[1]
//		end if
//		if iu_da_offline_skid_tabpg.dw_skid_item.rowcount( ) < 1 then
//			ll_skid_wt = 0
//		else
//			ll_skid_wt = iu_da_offline_skid_tabpg.dw_skid_item.object.compute_sum_item_nw[1]
//		end if
//	end if
else //online mode
	if isValid( iu_da_skid_tabpg ) and isValid( iu_da_scrap_tabpg ) then
		if iu_da_scrap_tabpg.dw_scrap.rowcount( ) < 1 then
			ll_scrap_wt = 0
		else
			ll_scrap_wt = iu_da_scrap_tabpg.dw_scrap.object.compute_1[1]
		end if
		if iu_da_skid_tabpg.dw_skid_item.rowcount( ) < 1 then
			ll_skid_wt = 0
		else
//			ll_skid_wt = iu_da_skid_tabpg.dw_skid_item.object.compute_sum_item_nw[1]
			ll_skid_wt = iu_da_skid_tabpg.dw_skid_item.object.compute_item_theo_wt[1]
		end if
 	end if
end if

if ll_scrap_wt < 9 and ll_skid_wt < 9 then return


il_coil_nw_bal = il_coil_nw - ll_scrap_wt - ll_skid_wt

il_scrap_wt = ll_scrap_wt
il_skid_wt = ll_skid_wt

//if ab_feed then
//	il_coil_nw_bal = il_coil_nw_bal - ir_density * ir_width * ir_gauge * ir_feed_length * ai_pcs_changed
//else
//	il_coil_nw_bal = il_coil_nw_bal - ir_density * ir_width * ir_gauge * ir_reject_length * ai_pcs_changed
//end if
//il_coil_nw_bal = il_coil_nw - (ir_density * ir_width * ir_gauge * ir_feed_length * il_feed_pieces ) &
//	- (ir_density * ir_width * ir_gauge * ir_reject_length * il_reject_pieces )
//

if il_coil_nw_bal < 5 then
	ii_coil_status = 0
	il_coil_process_wt = il_coil_nw
	il_coil_nw_bal = 0
else
	il_coil_process_wt = il_coil_nw - il_coil_nw_bal
end if

if il_coil_nw <> 0 then
	ii_coil_finish_percent = (il_coil_process_wt / il_coil_nw ) * 100
else
	ii_coil_finish_percent = 100
end if

IF ii_coil_finish_percent > 100 then
	ii_coil_finish_percent = 100
end if
end subroutine

public function u_da_skid_tabpg of_get_skid_tab_page ();return iu_da_skid_tabpg
end function

public function u_da_scrap_tabpg of_get_scrap_tab_page ();return iu_da_scrap_tabpg
end function

public subroutine of_select_skid_tabpg ();if isValid( iu_da_skid_tabpg ) then
	if iw_sheet.tab_da.selectedtab <> 1 then &
	iw_sheet.tab_da.selecttab( iu_da_skid_tabpg )
end if
end subroutine

public subroutine of_select_scrap_tabpg ();if isValid( iu_da_scrap_tabpg ) then
	if iw_sheet.tab_da.selectedtab <> 2 then &
	iw_sheet.tab_da.selecttab( iu_da_scrap_tabpg )
end if
end subroutine

public subroutine of_set_hl_percent (real ar_hl);ir_hl_percent = ar_hl
end subroutine

public function real of_get_hl_percent ();return ir_hl_percent
end function

public function integer of_get_scrap_type ();int li_scrap_type
if IsNull(is_scrap_type) then return 3
choose case Trim(is_scrap_type)
	case "Scrap Credit"
		li_scrap_type = 3
	case "Hold Scrap"
		li_scrap_type = 3
	case "Trailer"
		li_scrap_type = 2
	case "Return Scrap"
		li_scrap_type = 3
	case "Scrap Credit"
		li_scrap_type = 3
	case "Accumulated"
		li_scrap_type = 2
	case else
		li_scrap_type = 3
end choose
return li_scrap_type

end function

public function string of_get_orig_cust_po ();//if IsNull( is_orig_cust_po ) then return ""
return is_orig_cust_po
end function

on u_coil.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_coil.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//DAS_STAGE1
if isValid(iu_da_skid_tabpg) then
	iw_sheet.tab_da.closetab( iu_da_skid_tabpg )
	iw_sheet.tab_da.selecttab( 1 )
end if

if isValid(iu_da_scrap_tabpg) then
	iw_sheet.tab_da.closetab( iu_da_scrap_tabpg )
	iw_sheet.tab_da.selecttab( 1 )
end if
//
//if isValid(iu_da_offline_skid_tabpg) then
//	iw_sheet.tab_da.closetab( iu_da_offline_skid_tabpg )
//	iw_sheet.tab_da.selecttab( 1 )
//end if
//
//if isValid(iu_da_offline_scrap_tabpg) then
//	iw_sheet.tab_da.closetab( iu_da_offline_scrap_tabpg )
//	iw_sheet.tab_da.selecttab( 1 )
//end if
//DAS_STAGE1

if isValid(itmg_1_min ) then
	destroy itmg_1_min
end if

if isValid(iu_da_coil_job_tabpg ) then
	iw_sheet.tab_da.closetab( iu_da_coil_job_tabpg )
	iw_sheet.tab_da.selecttab( 1 )
end if

if isValid(iw_dt_change_job_reminder) then
	Close(iw_dt_change_job_reminder)
end if

end event

event constructor;iw_sheet = gnv_app.of_getframe( ).getactivesheet( )
	
end event

