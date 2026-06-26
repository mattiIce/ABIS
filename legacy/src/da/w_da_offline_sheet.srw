$PBExportHeader$w_da_offline_sheet.srw
$PBExportComments$<Sheet> Line application sheet window inheited from w_sheet
forward
global type w_da_offline_sheet from w_sheet
end type
type cb_modify_scrap from u_cb within w_da_offline_sheet
end type
type cb_modify_skid from u_cb within w_da_offline_sheet
end type
type tab_2 from tab within w_da_offline_sheet
end type
type tabpage_1 from userobject within tab_2
end type
type st_13 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_scrap_job from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_2
st_13 st_13
st_1 st_1
dw_scrap_job dw_scrap_job
end type
type tabpage_2 from userobject within tab_2
end type
type st_4 from statictext within tabpage_2
end type
type dw_scrap_total from u_dw within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_2
st_4 st_4
dw_scrap_total dw_scrap_total
st_3 st_3
end type
type tab_2 from tab within w_da_offline_sheet
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type tab_1 from tab within w_da_offline_sheet
end type
type tabpage_job from userobject within tab_1
end type
type dw_skid_job from u_dw within tabpage_job
end type
type st_2 from statictext within tabpage_job
end type
type tabpage_job from userobject within tab_1
dw_skid_job dw_skid_job
st_2 st_2
end type
type tabpage_shift from userobject within tab_1
end type
type st_12 from statictext within tabpage_shift
end type
type dw_shift_total from u_dw within tabpage_shift
end type
type tabpage_shift from userobject within tab_1
st_12 st_12
dw_shift_total dw_shift_total
end type
type tab_1 from tab within w_da_offline_sheet
tabpage_job tabpage_job
tabpage_shift tabpage_shift
end type
type uo_sql from u_fault_status_button within w_da_offline_sheet
end type
type cb_endskid from u_cb within w_da_offline_sheet
end type
type cb_loadskid from u_cb within w_da_offline_sheet
end type
type st_11 from statictext within w_da_offline_sheet
end type
type st_totalwaitingcoil from statictext within w_da_offline_sheet
end type
type cb_printscarp from u_cb within w_da_offline_sheet
end type
type cb_printskid from u_cb within w_da_offline_sheet
end type
type st_totaldonecoil from statictext within w_da_offline_sheet
end type
type st_totaldonejob from statictext within w_da_offline_sheet
end type
type st_shifttimee from statictext within w_da_offline_sheet
end type
type cb_refresh from u_cb within w_da_offline_sheet
end type
type st_10 from statictext within w_da_offline_sheet
end type
type st_9 from statictext within w_da_offline_sheet
end type
type st_8 from statictext within w_da_offline_sheet
end type
type st_7 from statictext within w_da_offline_sheet
end type
type st_6 from statictext within w_da_offline_sheet
end type
type st_5 from statictext within w_da_offline_sheet
end type
type cb_loadcoil from u_cb within w_da_offline_sheet
end type
type cb_endshift from u_cb within w_da_offline_sheet
end type
type cb_setup from u_cb within w_da_offline_sheet
end type
type cb_dtsummary from u_cb within w_da_offline_sheet
end type
type cb_chaneshift from u_cb within w_da_offline_sheet
end type
type cb_endcoil from u_cb within w_da_offline_sheet
end type
type cb_donejob from u_cb within w_da_offline_sheet
end type
type cb_loadjob from u_cb within w_da_offline_sheet
end type
type cb_downtime from u_cb within w_da_offline_sheet
end type
type dw_job_done from u_dw within w_da_offline_sheet
end type
type gb_job from groupbox within w_da_offline_sheet
end type
type dw_coil_processed from u_dw within w_da_offline_sheet
end type
type dw_coil_waiting_to_be_processed from u_dw within w_da_offline_sheet
end type
type gb_coil_to_be_process from groupbox within w_da_offline_sheet
end type
type cb_time from u_cb within w_da_offline_sheet
end type
type st_shifttimes from statictext within w_da_offline_sheet
end type
type cb_scrap from u_cb within w_da_offline_sheet
end type
type sle_scrap from singlelineedit within w_da_offline_sheet
end type
type cb_skid from u_cb within w_da_offline_sheet
end type
type sle_skid from singlelineedit within w_da_offline_sheet
end type
type cb_coil_details from u_cb within w_da_offline_sheet
end type
type sle_coil from singlelineedit within w_da_offline_sheet
end type
type cb_job_details from u_cb within w_da_offline_sheet
end type
type st_title from statictext within w_da_offline_sheet
end type
type st_scrap_title from statictext within w_da_offline_sheet
end type
type st_skid_title from statictext within w_da_offline_sheet
end type
type st_coil_title from statictext within w_da_offline_sheet
end type
type sle_job from singlelineedit within w_da_offline_sheet
end type
type st_job_title from statictext within w_da_offline_sheet
end type
type cb_close from u_cb within w_da_offline_sheet
end type
type gb_line from u_gb within w_da_offline_sheet
end type
type gb_coil_processed from groupbox within w_da_offline_sheet
end type
type gb_operation from u_gb within w_da_offline_sheet
end type
type gb_skid from groupbox within w_da_offline_sheet
end type
type gb_scrap from groupbox within w_da_offline_sheet
end type
type gb_shift from u_gb within w_da_offline_sheet
end type
end forward

global type w_da_offline_sheet from w_sheet
integer width = 3785
integer height = 2419
string title = "DAS Application-Offline"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowstate windowstate = maximized!
event type string ue_whoami ( )
event type long ue_load_job ( )
event type long ue_load_coil ( )
event type long ue_end_coil ( )
event type long ue_refresh ( )
event type long ue_load_skid ( long al_skid )
event type long ue_end_shift ( )
cb_modify_scrap cb_modify_scrap
cb_modify_skid cb_modify_skid
tab_2 tab_2
tab_1 tab_1
uo_sql uo_sql
cb_endskid cb_endskid
cb_loadskid cb_loadskid
st_11 st_11
st_totalwaitingcoil st_totalwaitingcoil
cb_printscarp cb_printscarp
cb_printskid cb_printskid
st_totaldonecoil st_totaldonecoil
st_totaldonejob st_totaldonejob
st_shifttimee st_shifttimee
cb_refresh cb_refresh
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
cb_loadcoil cb_loadcoil
cb_endshift cb_endshift
cb_setup cb_setup
cb_dtsummary cb_dtsummary
cb_chaneshift cb_chaneshift
cb_endcoil cb_endcoil
cb_donejob cb_donejob
cb_loadjob cb_loadjob
cb_downtime cb_downtime
dw_job_done dw_job_done
gb_job gb_job
dw_coil_processed dw_coil_processed
dw_coil_waiting_to_be_processed dw_coil_waiting_to_be_processed
gb_coil_to_be_process gb_coil_to_be_process
cb_time cb_time
st_shifttimes st_shifttimes
cb_scrap cb_scrap
sle_scrap sle_scrap
cb_skid cb_skid
sle_skid sle_skid
cb_coil_details cb_coil_details
sle_coil sle_coil
cb_job_details cb_job_details
st_title st_title
st_scrap_title st_scrap_title
st_skid_title st_skid_title
st_coil_title st_coil_title
sle_job sle_job
st_job_title st_job_title
cb_close cb_close
gb_line gb_line
gb_coil_processed gb_coil_processed
gb_operation gb_operation
gb_skid gb_skid
gb_scrap gb_scrap
gb_shift gb_shift
end type
global w_da_offline_sheet w_da_offline_sheet

type variables
Long il_shift, il_cur_job, il_cur_coil, il_cur_skid, il_cur_skiditem

Int ii_line_id
String is_line

w_super_validation_offline iw_super_validation
n_cst_datetime inv_datetime

string is_maintenance_password = "5678"
string is_prod_control_password = "2345"
string is_shift_super_password = "1234"

uo_seven_days_timer iuo_db
uo_timing_get_shift iuo_timing_get_shift
w_override iw_override
w_please_wait iw_please_wait
w_please_wait_end_shift iw_please_wait_end_shift
uo_shift iuo_shift





end variables

forward prototypes
public function integer wf_super_validation ()
public function long wf_get_shift_id (datetime adt_now)
public subroutine wf_print_shift_summary (long al_shift_id)
public function integer wf_new_shift (long al_shift_id)
public function integer wf_save_coil_when_shift_ends ()
end prototypes

event type string ue_whoami();RETURN "w_da_offline_sheet"
end event

event type long ue_load_job();RETURN 1
end event

event type long ue_load_coil();RETURN 1
end event

event type long ue_end_coil();RETURN 1
end event

event type long ue_refresh();RETURN 1
end event

event type long ue_load_skid(long al_skid);RETURN 1
end event

event type long ue_end_shift();if il_shift > 0 then
	st_title.text = "Shift ended at " + string(now())
	if il_cur_coil > 0 then
		wf_save_coil_when_shift_ends( )
	end if
	   
	DateTime ldt_dt
	ldt_dt = DateTime(today(), Now())

	long ll_shift_downtime	
		
	SELECT SUM(DT_INSTANCE.ENDING_TIME - DT_INSTANCE.STARTING_TIME) * 86400 INTO :ll_shift_downtime
	FROM DT_INSTANCE
	WHERE DT_INSTANCE.SHIFT_NUM = :il_shift
	USING SQLCA;
		
	UPDATE "SHIFT"  
  	SET "END_TIME" = :ldt_dt, "DT_TOTAL" = :ll_shift_downtime  
 	WHERE "SHIFT"."SHIFT_NUM" = :il_shift
 	USING SQLCA;
		
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			MessageBox("Shift end", "End shift failed!")
			return 1	
		end if
	
	UPDATE "LINE_CURRENT_STATUS"  
   SET "SHIFT_NUM" = null  
   WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :ii_line_id   
   USING SQLCA;
	
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			MessageBox("Shift end", "End shift failed!")
			return 1
		end if  
	
	
	
	sqlca.of_commit( )
	
	wf_print_shift_summary(il_shift)
ELSE
	MessageBox("Warning", "No shift to be ended here.")
	RETURN 0
end if

return 1
end event

public function integer wf_super_validation ();Int li_rc
if not isValid(iw_super_validation) then
		Open(iw_super_validation)
		li_rc = message.doubleparm
		return li_rc
end if
end function

public function long wf_get_shift_id (datetime adt_now);long ll_shift_id
int li_line

  SELECT "SHIFT"."SHIFT_NUM"  
    INTO :ll_shift_id  
    FROM "SHIFT"  
   WHERE ( "SHIFT"."LINE_NUM" = :ii_line_id ) AND  
         ( "SHIFT"."PLANNED_STARTING_TIME" <= :adt_now ) AND  
         ( "SHIFT"."PLANNED_ENDING_TIME" > :adt_now ) and
			( "SHIFT"."END_TIME" IS NULL);
if isNull(ll_shift_id) or ll_shift_id < 1000 then
	return -1
else
	return ll_shift_id
end if
end function

public subroutine wf_print_shift_summary (long al_shift_id);datastore lds_print
	
lds_print = create Datastore
lds_print.dataobject = "d_da_daily_prod_dt_total"
lds_print.SetTransObject(sqlca)
lds_print.retrieve(al_shift_id)
	
lds_print.print()
lds_print.print()
	
DESTROY lds_print

RETURN
end subroutine

public function integer wf_new_shift (long al_shift_id);int li_rc

if isValid(iuo_shift) then
	//wf_end_shift( )
end if

iuo_shift = create uo_shift

SELECT "LINE_CURRENT_STATUS"."AB_JOB_NUM"  INTO :il_cur_job  
FROM "LINE_CURRENT_STATUS"  
WHERE ( "LINE_CURRENT_STATUS"."LINE_NUM" = :ii_line_id ) AND  
         ( "LINE_CURRENT_STATUS"."SHIFT_NUM" = :al_shift_id )   
USING SQLCA;

if isNull(il_cur_job ) or il_cur_job < 1000 then
	//select new job for this shift
end if

//li_rc = iuo_shift.init( al_shift_id , ii_line_id, il_cur_job ,this )
if li_rc <> 0 then 
	return li_rc
end if


//	ole_1.object.items( is_shift ).value = al_shift_id
//	ole_1.object.update
//	
//	tab_queue.tabpage_coil_queue.dw_coil_queue.of_retrieve( )
////	tab_queue.tabpage_job_queue.dw_job_queue.retrieve( ii_line_id )
//	tab_queue.selecttab( 1 )
//	il_abshift = al_shift_id
//	wf_show_shift_coil( )
//	if not ib_offline_mode then
//		ole_1.object.items( is_strokes ).value = 0
//		ole_1.object.update
//	end if

return li_rc



end function

public function integer wf_save_coil_when_shift_ends ();long ll_process_wt
datetime ld_on_time,ldt_now
int li_coil_run

//ll_process_wt = il_coil_begin_wt_from_shift - il_coil_nw_bal
//if ll_process_wt > 0 then
//				ld_on_time = idt_online
//				//connect using sqlca;
//			  sqlca.of_connect( )
//			  select NVL(MAX("COIL_RUN_NUM"),0) into :li_coil_run from "SHIFT_COIL" where
//			  "SHIFT_NUM" = :il_shift_id
//			  ;
//			  li_coil_run = li_coil_run + 1
//			  ldt_now = DateTime( today(), now() )
//			  			  
//				INSERT INTO "SHIFT_COIL"  
//         	( "SHIFT_NUM",   
//           	"COIL_RUN_NUM",   
//           	"AB_JOB_NUM",   
//           	"COIL_ABC_NUM",   
//           	"COIL_BEGIN_STATUS",   
//           	"COIL_END_STATUS",   
//           	"COIL_BEGIN_WT",   
//           	"COIL_END_WT",   
//           	"COIL_BEGIN_TIME",   
//           	"COIL_END_TIME",   
//           	"NOTE",   
//           	"PROCESS_WT" )  
//  				VALUES ( :il_shift_id,   
//           	:li_coil_run,   
//           	:il_ab_job_num,   
//           	:il_coil_abc_num,   
//           	:ii_coil_status_old,
//				:ii_coil_status,
//           	:il_coil_begin_wt_from_shift ,   
//           	:il_coil_nw_bal,   
//           	:ld_on_time,   
//           		:ldt_now,   
//           	null,   
//           	:ll_process_wt )  ;
//			  	//COMMIT;
//				
//				if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				end if
//				
//				UPDATE "PROCESS_COIL"  
//     				SET "SHIFT_PROCESS_STATUS" = :ii_coil_status, "CURRENT_WT" = :il_coil_nw_bal 
//   					WHERE ( "COIL_ABC_NUM" = :il_coil_abc_num ) AND  
//         				( "AB_JOB_NUM" = :il_ab_job_num )   
//           ;
//			  
//			  if sqlca.sqlcode <> 0 then
//					sqlca.of_rollback( )
//					return 1
//				end if
//			  
//				
//
//
//
//				
//				sqlca.of_commit( )
//end if //end if ll_process_wt > 0				
				
return 0

end function

on w_da_offline_sheet.create
int iCurrent
call super::create
this.cb_modify_scrap=create cb_modify_scrap
this.cb_modify_skid=create cb_modify_skid
this.tab_2=create tab_2
this.tab_1=create tab_1
this.uo_sql=create uo_sql
this.cb_endskid=create cb_endskid
this.cb_loadskid=create cb_loadskid
this.st_11=create st_11
this.st_totalwaitingcoil=create st_totalwaitingcoil
this.cb_printscarp=create cb_printscarp
this.cb_printskid=create cb_printskid
this.st_totaldonecoil=create st_totaldonecoil
this.st_totaldonejob=create st_totaldonejob
this.st_shifttimee=create st_shifttimee
this.cb_refresh=create cb_refresh
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.cb_loadcoil=create cb_loadcoil
this.cb_endshift=create cb_endshift
this.cb_setup=create cb_setup
this.cb_dtsummary=create cb_dtsummary
this.cb_chaneshift=create cb_chaneshift
this.cb_endcoil=create cb_endcoil
this.cb_donejob=create cb_donejob
this.cb_loadjob=create cb_loadjob
this.cb_downtime=create cb_downtime
this.dw_job_done=create dw_job_done
this.gb_job=create gb_job
this.dw_coil_processed=create dw_coil_processed
this.dw_coil_waiting_to_be_processed=create dw_coil_waiting_to_be_processed
this.gb_coil_to_be_process=create gb_coil_to_be_process
this.cb_time=create cb_time
this.st_shifttimes=create st_shifttimes
this.cb_scrap=create cb_scrap
this.sle_scrap=create sle_scrap
this.cb_skid=create cb_skid
this.sle_skid=create sle_skid
this.cb_coil_details=create cb_coil_details
this.sle_coil=create sle_coil
this.cb_job_details=create cb_job_details
this.st_title=create st_title
this.st_scrap_title=create st_scrap_title
this.st_skid_title=create st_skid_title
this.st_coil_title=create st_coil_title
this.sle_job=create sle_job
this.st_job_title=create st_job_title
this.cb_close=create cb_close
this.gb_line=create gb_line
this.gb_coil_processed=create gb_coil_processed
this.gb_operation=create gb_operation
this.gb_skid=create gb_skid
this.gb_scrap=create gb_scrap
this.gb_shift=create gb_shift
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_modify_scrap
this.Control[iCurrent+2]=this.cb_modify_skid
this.Control[iCurrent+3]=this.tab_2
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.uo_sql
this.Control[iCurrent+6]=this.cb_endskid
this.Control[iCurrent+7]=this.cb_loadskid
this.Control[iCurrent+8]=this.st_11
this.Control[iCurrent+9]=this.st_totalwaitingcoil
this.Control[iCurrent+10]=this.cb_printscarp
this.Control[iCurrent+11]=this.cb_printskid
this.Control[iCurrent+12]=this.st_totaldonecoil
this.Control[iCurrent+13]=this.st_totaldonejob
this.Control[iCurrent+14]=this.st_shifttimee
this.Control[iCurrent+15]=this.cb_refresh
this.Control[iCurrent+16]=this.st_10
this.Control[iCurrent+17]=this.st_9
this.Control[iCurrent+18]=this.st_8
this.Control[iCurrent+19]=this.st_7
this.Control[iCurrent+20]=this.st_6
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.cb_loadcoil
this.Control[iCurrent+23]=this.cb_endshift
this.Control[iCurrent+24]=this.cb_setup
this.Control[iCurrent+25]=this.cb_dtsummary
this.Control[iCurrent+26]=this.cb_chaneshift
this.Control[iCurrent+27]=this.cb_endcoil
this.Control[iCurrent+28]=this.cb_donejob
this.Control[iCurrent+29]=this.cb_loadjob
this.Control[iCurrent+30]=this.cb_downtime
this.Control[iCurrent+31]=this.dw_job_done
this.Control[iCurrent+32]=this.gb_job
this.Control[iCurrent+33]=this.dw_coil_processed
this.Control[iCurrent+34]=this.dw_coil_waiting_to_be_processed
this.Control[iCurrent+35]=this.gb_coil_to_be_process
this.Control[iCurrent+36]=this.cb_time
this.Control[iCurrent+37]=this.st_shifttimes
this.Control[iCurrent+38]=this.cb_scrap
this.Control[iCurrent+39]=this.sle_scrap
this.Control[iCurrent+40]=this.cb_skid
this.Control[iCurrent+41]=this.sle_skid
this.Control[iCurrent+42]=this.cb_coil_details
this.Control[iCurrent+43]=this.sle_coil
this.Control[iCurrent+44]=this.cb_job_details
this.Control[iCurrent+45]=this.st_title
this.Control[iCurrent+46]=this.st_scrap_title
this.Control[iCurrent+47]=this.st_skid_title
this.Control[iCurrent+48]=this.st_coil_title
this.Control[iCurrent+49]=this.sle_job
this.Control[iCurrent+50]=this.st_job_title
this.Control[iCurrent+51]=this.cb_close
this.Control[iCurrent+52]=this.gb_line
this.Control[iCurrent+53]=this.gb_coil_processed
this.Control[iCurrent+54]=this.gb_operation
this.Control[iCurrent+55]=this.gb_skid
this.Control[iCurrent+56]=this.gb_scrap
this.Control[iCurrent+57]=this.gb_shift
end on

on w_da_offline_sheet.destroy
call super::destroy
destroy(this.cb_modify_scrap)
destroy(this.cb_modify_skid)
destroy(this.tab_2)
destroy(this.tab_1)
destroy(this.uo_sql)
destroy(this.cb_endskid)
destroy(this.cb_loadskid)
destroy(this.st_11)
destroy(this.st_totalwaitingcoil)
destroy(this.cb_printscarp)
destroy(this.cb_printskid)
destroy(this.st_totaldonecoil)
destroy(this.st_totaldonejob)
destroy(this.st_shifttimee)
destroy(this.cb_refresh)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.cb_loadcoil)
destroy(this.cb_endshift)
destroy(this.cb_setup)
destroy(this.cb_dtsummary)
destroy(this.cb_chaneshift)
destroy(this.cb_endcoil)
destroy(this.cb_donejob)
destroy(this.cb_loadjob)
destroy(this.cb_downtime)
destroy(this.dw_job_done)
destroy(this.gb_job)
destroy(this.dw_coil_processed)
destroy(this.dw_coil_waiting_to_be_processed)
destroy(this.gb_coil_to_be_process)
destroy(this.cb_time)
destroy(this.st_shifttimes)
destroy(this.cb_scrap)
destroy(this.sle_scrap)
destroy(this.cb_skid)
destroy(this.sle_skid)
destroy(this.cb_coil_details)
destroy(this.sle_coil)
destroy(this.cb_job_details)
destroy(this.st_title)
destroy(this.st_scrap_title)
destroy(this.st_skid_title)
destroy(this.st_coil_title)
destroy(this.sle_job)
destroy(this.st_job_title)
destroy(this.cb_close)
destroy(this.gb_line)
destroy(this.gb_coil_processed)
destroy(this.gb_operation)
destroy(this.gb_skid)
destroy(this.gb_scrap)
destroy(this.gb_shift)
end on

event close;call super::close;if isValid( iw_super_validation ) then
	Close(iw_super_validation )
end if

end event

event pfc_postopen;call super::pfc_postopen;Long li_line_width

If not isValid(iw_please_wait) then
	open(iw_please_wait, this)
end if

is_line = ProfileString(gs_downtime_ini_file,"DataBase","LogId","bl110")

li_line_width = integer(mid(is_line,3))
SQLCA.of_connect( )	 	
		SELECT "LINE"."LINE_NUM"  INTO :ii_line_id  
    	FROM "LINE"  
   	WHERE "LINE"."MAX_WIDTH" = :li_line_width
		USING SQLCA;
IF SQLCA.sqlcode <> 0 THEN
	uo_sql.set_select(false)
	MessageBox("Database", "Error finding line id!")
ELSE
	uo_sql.set_select( true)
END IF

is_maintenance_password = ProfileString(gs_downtime_ini_file,"OPCItems","is_maintenance_password","5678")
is_prod_control_password = ProfileString(gs_downtime_ini_file,"OPCItems","is_prod_control_password","2345")
is_shift_super_password = ProfileString(gs_downtime_ini_file,"OPCItems","is_shift_super_password","1234")

if this.inv_datetime.of_dayofweek( Today() ) = 7  and (Now() > 15:58:00 and Now() < 16:30:00)  then
	return
end if

il_shift = wf_get_shift_id(DateTime( Today(), Now() ))
if  il_shift > 1001 then
	wf_new_shift( il_shift )
else
	MessageBox("Warning", "No shift was sheduled for this line. Please contact production control office for details.")
	St_title.Text = Upper(is_line) + " --- NO SHIFT"
	St_title.TextColor = RGB(128, 0,0)
end if

If isValid(iw_please_wait) then
	close( iw_please_wait )
end if


end event

type cb_modify_scrap from u_cb within w_da_offline_sheet
integer x = 2593
integer y = 2214
integer width = 494
integer height = 93
integer taborder = 130
string facename = "Arial"
string text = "Modify Scrap"
end type

type cb_modify_skid from u_cb within w_da_offline_sheet
integer x = 2593
integer y = 1498
integer width = 494
integer height = 93
integer taborder = 140
string facename = "Arial"
string text = "Modify Skid"
end type

type tab_2 from tab within w_da_offline_sheet
integer x = 1083
integer y = 1664
integer width = 2008
integer height = 547
integer taborder = 130
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_2.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_2.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_2
integer x = 15
integer y = 96
integer width = 1979
integer height = 438
long backcolor = 79741120
string text = "Current Job"
long tabtextcolor = 32768
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_13 st_13
st_1 st_1
dw_scrap_job dw_scrap_job
end type

on tabpage_1.create
this.st_13=create st_13
this.st_1=create st_1
this.dw_scrap_job=create dw_scrap_job
this.Control[]={this.st_13,&
this.st_1,&
this.dw_scrap_job}
end on

on tabpage_1.destroy
destroy(this.st_13)
destroy(this.st_1)
destroy(this.dw_scrap_job)
end on

type st_13 from statictext within tabpage_1
integer x = 1108
integer y = 384
integer width = 845
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 80263581
string text = "Total:      Total Net WT:"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_1
integer x = 1093
integer y = 854
integer width = 845
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 80263581
string text = "Total:      Total Net WT:"
boolean focusrectangle = false
end type

type dw_scrap_job from u_dw within tabpage_1
integer width = 1975
integer height = 384
integer taborder = 60
string dataobject = "d_offline_scrap_job"
boolean livescroll = false
end type

type tabpage_2 from userobject within tab_2
integer x = 15
integer y = 96
integer width = 1979
integer height = 438
long backcolor = 79741120
string text = "Shift Summary"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_4 st_4
dw_scrap_total dw_scrap_total
st_3 st_3
end type

on tabpage_2.create
this.st_4=create st_4
this.dw_scrap_total=create dw_scrap_total
this.st_3=create st_3
this.Control[]={this.st_4,&
this.dw_scrap_total,&
this.st_3}
end on

on tabpage_2.destroy
destroy(this.st_4)
destroy(this.dw_scrap_total)
destroy(this.st_3)
end on

type st_4 from statictext within tabpage_2
integer x = 1214
integer y = 384
integer width = 742
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Total:      Total Net WT:"
boolean focusrectangle = false
end type

type dw_scrap_total from u_dw within tabpage_2
integer y = 3
integer width = 1960
integer height = 374
integer taborder = 10
string dataobject = "d_offline_scrap_total"
boolean livescroll = false
end type

type st_3 from statictext within tabpage_2
integer x = 1192
integer y = 851
integer width = 742
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Total:      Total Net WT:"
boolean focusrectangle = false
end type

type tab_1 from tab within w_da_offline_sheet
integer x = 1090
integer y = 438
integer width = 1997
integer height = 1056
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_job tabpage_job
tabpage_shift tabpage_shift
end type

on tab_1.create
this.tabpage_job=create tabpage_job
this.tabpage_shift=create tabpage_shift
this.Control[]={this.tabpage_job,&
this.tabpage_shift}
end on

on tab_1.destroy
destroy(this.tabpage_job)
destroy(this.tabpage_shift)
end on

type tabpage_job from userobject within tab_1
integer x = 15
integer y = 96
integer width = 1968
integer height = 947
long backcolor = 79741120
string text = "Current Job"
long tabtextcolor = 32768
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_skid_job dw_skid_job
st_2 st_2
end type

on tabpage_job.create
this.dw_skid_job=create dw_skid_job
this.st_2=create st_2
this.Control[]={this.dw_skid_job,&
this.st_2}
end on

on tabpage_job.destroy
destroy(this.dw_skid_job)
destroy(this.st_2)
end on

type dw_skid_job from u_dw within tabpage_job
integer width = 1968
integer height = 886
integer taborder = 20
string dataobject = "d_offline_skid_job"
boolean livescroll = false
end type

type st_2 from statictext within tabpage_job
integer x = 1101
integer y = 890
integer width = 845
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 80263581
string text = "Total:      Total Net WT:"
boolean focusrectangle = false
end type

type tabpage_shift from userobject within tab_1
integer x = 15
integer y = 96
integer width = 1968
integer height = 947
long backcolor = 79741120
string text = "Shift Summary"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_12 st_12
dw_shift_total dw_shift_total
end type

on tabpage_shift.create
this.st_12=create st_12
this.dw_shift_total=create dw_shift_total
this.Control[]={this.st_12,&
this.dw_shift_total}
end on

on tabpage_shift.destroy
destroy(this.st_12)
destroy(this.dw_shift_total)
end on

type st_12 from statictext within tabpage_shift
integer x = 1211
integer y = 864
integer width = 742
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Total:      Total Net WT:"
boolean focusrectangle = false
end type

type dw_shift_total from u_dw within tabpage_shift
integer width = 1957
integer height = 854
integer taborder = 50
string dataobject = "d_offline_skid_tatal"
boolean livescroll = false
end type

type uo_sql from u_fault_status_button within w_da_offline_sheet
integer x = 3536
integer y = 3
integer width = 234
integer height = 70
integer taborder = 10
string caption = "ORA"
end type

on uo_sql.destroy
call u_fault_status_button::destroy
end on

type cb_endskid from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 1418
integer width = 519
integer height = 109
integer taborder = 90
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "End Skid"
end type

event clicked;call super::clicked;Long ll_rc, ll_theo
s_skid_item lstr_t

IF (il_cur_skid < 1) OR (IsNULL(il_cur_skid)) THEN 
	MessageBox("Error", "Sorry, No skid.", StopSign! )
	RETURN -1
END IF

SELECT "ORDER_ITEM"."THEORETICAL_UNIT_WT"  
INTO :ll_theo
FROM "AB_JOB", "ORDER_ITEM"  
WHERE ( "ORDER_ITEM"."ORDER_ITEM_NUM" = "AB_JOB"."ORDER_ITEM_NUM" ) and  
         ( "ORDER_ITEM"."ORDER_ABC_NUM" = "AB_JOB"."ORDER_ABC_NUM" ) and  
         ( ( "AB_JOB"."AB_JOB_NUM" = :il_cur_job ) ) 
USING SQLCA;

lstr_t.skid_num = il_cur_skid
lstr_t.item_num = il_cur_skiditem
lstr_t.net = ll_theo

OpenWithParm(w_end_skid_offline, lstr_t)

ll_rc = Message.doubleParm
IF ll_rc > 0 THEN
	il_cur_skid = 0
	il_cur_skiditem = 0
	Parent.Event ue_refresh()
	RETURN 1
END IF

RETURN 0
end event

type cb_loadskid from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 1306
integer width = 519
integer height = 109
integer taborder = 80
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Load Skid"
end type

event clicked;call super::clicked;Long ll_rc
s_job_and_coil lstr_t
s_skid_item lstr_rc

IF (il_cur_coil < 1) OR (IsNULL(il_cur_coil)) THEN 
	MessageBox("Error", "Sorry, No coil.", StopSign! )
	RETURN -1
END IF
 
lstr_t.job_num = il_cur_job
lstr_t.coil_num = il_cur_coil

OpenWithParm(w_load_skid_offline, lstr_t)

lstr_rc = Message.PowerObjectParm
IF lstr_rc.skid_num > 0 THEN
	il_cur_skid = lstr_rc.skid_num
	il_cur_skiditem = lstr_rc.item_num
	Parent.Event ue_load_skid(il_cur_skid)
	Parent.Event ue_refresh()
	RETURN 1
END IF

RETURN 0
end event

type st_11 from statictext within w_da_offline_sheet
integer x = 3273
integer y = 1235
integer width = 366
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80263581
string text = "- - Skid - -"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_totalwaitingcoil from statictext within w_da_offline_sheet
integer x = 84
integer y = 1011
integer width = 845
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Total coil:        Total WT:               "
boolean focusrectangle = false
end type

type cb_printscarp from u_cb within w_da_offline_sheet
integer x = 1847
integer y = 2214
integer width = 494
integer height = 93
integer taborder = 120
string facename = "Arial"
string text = "Print Scrap Ticket"
end type

type cb_printskid from u_cb within w_da_offline_sheet
integer x = 1847
integer y = 1498
integer width = 494
integer height = 93
integer taborder = 130
string facename = "Arial"
string text = "Print Skid Ticket"
end type

type st_totaldonecoil from statictext within w_da_offline_sheet
integer x = 84
integer y = 1722
integer width = 845
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Total coil:        Total WT:               "
boolean focusrectangle = false
end type

type st_totaldonejob from statictext within w_da_offline_sheet
integer x = 574
integer y = 2240
integer width = 421
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Total:"
boolean focusrectangle = false
end type

type st_shifttimee from statictext within w_da_offline_sheet
integer x = 37
integer y = 461
integer width = 640
integer height = 61
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 80263581
string text = "End Time:  HH:MM"
boolean focusrectangle = false
end type

type cb_refresh from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 1894
integer width = 519
integer height = 109
integer taborder = 90
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Refresh"
end type

event clicked;call super::clicked;RETURN Parent.Event ue_refresh()
end event

type st_10 from statictext within w_da_offline_sheet
integer x = 3215
integer y = 1824
integer width = 483
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80263581
string text = "- - Refresh Data - -"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_da_offline_sheet
integer x = 3273
integer y = 2006
integer width = 366
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80263581
string text = "- - Setup - -"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_da_offline_sheet
integer x = 3273
integer y = 1530
integer width = 366
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80263581
string text = "- - Shift - -"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_da_offline_sheet
integer x = 3273
integer y = 941
integer width = 366
integer height = 67
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80263581
string text = "- - Coil  - -"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_da_offline_sheet
integer x = 3273
integer y = 656
integer width = 366
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80263581
string text = "- - Job - -"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_da_offline_sheet
integer x = 3240
integer y = 371
integer width = 432
integer height = 58
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80263581
string text = "- - Down Time - -"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_loadcoil from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 1011
integer width = 519
integer height = 109
integer taborder = 90
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Load Coil"
end type

event clicked;call super::clicked;Long ll_coil

IF (il_cur_job < 1) OR (IsNULL(il_cur_job)) THEN 
	MessageBox("Error", "Select a job first!", StopSign! )
	RETURN -1
END IF

OpenWithParm(w_coil_selection_offline, il_cur_job)

ll_coil = Message.DoubleParm
IF ll_coil > 0 THEN
	il_cur_coil = ll_coil
	Parent.Event ue_load_coil()
	Parent.Event ue_refresh()
END IF

RETURN 0
end event

type cb_endshift from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 1712
integer width = 519
integer height = 109
integer taborder = 110
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "End Shift"
end type

event clicked;call super::clicked;RETURN Parent.Event ue_end_shift()
end event

type cb_setup from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 2077
integer width = 519
integer height = 109
integer taborder = 100
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Setup"
end type

type cb_dtsummary from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 544
integer width = 519
integer height = 109
integer taborder = 90
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "DT Summary"
end type

event clicked;call super::clicked;RETURN OpenWithParm(w_dt_summary_offline, il_shift)
end event

type cb_chaneshift from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 1600
integer width = 519
integer height = 109
integer taborder = 70
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Change Shift"
end type

event clicked;call super::clicked;Long ll_old_shift

If not isValid(iw_please_wait) then
	open(iw_please_wait, parent)
end if

ll_old_shift = il_shift

il_shift = wf_get_shift_id(DateTime( Today(), Now() ))

IF ll_old_shift = il_shift THEN
	MessageBox("Warning", "Can't change currently running shift.")
	RETURN -1
END IF

if  (il_shift > 1001) then
	wf_new_shift( il_shift )
else
	MessageBox("Warning", "No shift was sheduled for this line. Please contact production control office for details.")
	St_title.Text = Upper(is_line) + " --- NO SHIFT"
	St_title.TextColor = RGB(128, 0,0)
end if

If isValid(iw_please_wait) then
	close( iw_please_wait )
end if


end event

type cb_endcoil from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 1123
integer width = 519
integer height = 109
integer taborder = 90
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "End Coil"
end type

event clicked;call super::clicked;Long ll_rc
s_job_and_coil lstr_t

IF (il_cur_coil < 1) OR (IsNULL(il_cur_coil)) THEN 
	MessageBox("Error", "Sorry, No coil.", StopSign! )
	RETURN -1
END IF
 
lstr_t.job_num = il_cur_job
lstr_t.coil_num = il_cur_coil

OpenWithParm(w_end_coil_offline, lstr_t)

ll_rc = Message.DoubleParm
IF ll_rc = 1 THEN
	Parent.Event ue_end_coil()
	Parent.Event ue_refresh()
	RETURN 1
END IF

RETURN 0
end event

type cb_donejob from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 829
integer width = 519
integer height = 109
integer taborder = 80
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "End Job"
end type

type cb_loadjob from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 717
integer width = 519
integer height = 109
integer taborder = 70
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Load Job"
end type

event clicked;call super::clicked;Long ll_job

OpenWithParm(w_job_selection_offline, ii_line_id)

ll_job = Message.DoubleParm
IF ll_job > 0 THEN
	il_cur_job = ll_job
	RETURN Parent.Event ue_load_job()
END IF

RETURN 0
end event

type cb_downtime from u_cb within w_da_offline_sheet
integer x = 3196
integer y = 432
integer width = 519
integer height = 109
integer taborder = 70
integer textsize = -12
integer weight = 700
string facename = "Arial"
string text = "Enter DT"
end type

event clicked;call super::clicked;Long ll_rc
s_shift_job_coil_skid lstr_t

IF (il_shift < 1) OR (IsNULL(il_shift)) THEN 
	MessageBox("Error", "Sorry, No shift running.", StopSign! )
	//RETURN -1
END IF
 
lstr_t.job_num = il_cur_job
lstr_t.shift_num = il_shift

OpenWithParm(w_dt_log_offline, lstr_t)

ll_rc = Message.DoubleParm
IF ll_rc > 0 THEN
	Parent.Event ue_refresh()
	RETURN 1
END IF
end event

type dw_job_done from u_dw within w_da_offline_sheet
integer x = 40
integer y = 1859
integer width = 984
integer height = 368
integer taborder = 90
string dataobject = "d_offline_job_done"
end type

type gb_job from groupbox within w_da_offline_sheet
integer x = 26
integer y = 1805
integer width = 1028
integer height = 506
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Job finished"
end type

type dw_coil_processed from u_dw within w_da_offline_sheet
integer x = 29
integer y = 1155
integer width = 1002
integer height = 560
integer taborder = 80
string dataobject = "d_offline_coil_processed"
end type

type dw_coil_waiting_to_be_processed from u_dw within w_da_offline_sheet
integer x = 33
integer y = 582
integer width = 1002
integer height = 416
integer taborder = 70
string dataobject = "d_offline_coil_waiting_to_be_processed"
end type

type gb_coil_to_be_process from groupbox within w_da_offline_sheet
integer x = 22
integer y = 525
integer width = 1028
integer height = 563
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Coils waiting to be processed"
end type

type cb_time from u_cb within w_da_offline_sheet
integer x = 680
integer y = 406
integer width = 322
integer height = 93
integer taborder = 50
string facename = "Arial"
string text = "Change Time"
end type

type st_shifttimes from statictext within w_da_offline_sheet
integer x = 37
integer y = 384
integer width = 640
integer height = 61
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 80263581
string text = "Start Time:  HH:MM"
boolean focusrectangle = false
end type

type cb_scrap from u_cb within w_da_offline_sheet
integer x = 3533
integer y = 173
integer width = 216
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "Edit"
end type

type sle_scrap from singlelineedit within w_da_offline_sheet
integer x = 3021
integer y = 176
integer width = 508
integer height = 83
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_skid from u_cb within w_da_offline_sheet
integer x = 2608
integer y = 173
integer width = 216
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "Edit"
end type

type sle_skid from singlelineedit within w_da_offline_sheet
integer x = 1924
integer y = 176
integer width = 673
integer height = 83
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_coil_details from u_cb within w_da_offline_sheet
integer x = 1375
integer y = 173
integer width = 216
integer height = 93
integer taborder = 40
string facename = "Arial"
string text = "Details"
end type

event clicked;call super::clicked;RETURN OpenWithParm(w_prod_order_details_offline, il_cur_coil)
end event

type sle_coil from singlelineedit within w_da_offline_sheet
integer x = 936
integer y = 176
integer width = 428
integer height = 83
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_job_details from u_cb within w_da_offline_sheet
integer x = 549
integer y = 173
integer width = 216
integer height = 93
integer taborder = 30
string facename = "Arial"
string text = "Details"
end type

event clicked;call super::clicked;RETURN OpenWithParm(w_prod_order_details_offline, il_cur_job)
end event

type st_title from statictext within w_da_offline_sheet
integer x = 998
integer y = 6
integer width = 1412
integer height = 96
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 80263581
string text = "BL 110 - RUNNING"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_scrap_title from statictext within w_da_offline_sheet
integer x = 2831
integer y = 186
integer width = 194
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Scrap:"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_skid_title from statictext within w_da_offline_sheet
integer x = 1595
integer y = 189
integer width = 336
integer height = 61
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Sheet Skid:"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_coil_title from statictext within w_da_offline_sheet
integer x = 761
integer y = 186
integer width = 172
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Coil:"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_job from singlelineedit within w_da_offline_sheet
integer x = 161
integer y = 176
integer width = 380
integer height = 83
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "none"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_job_title from statictext within w_da_offline_sheet
integer x = 7
integer y = 182
integer width = 150
integer height = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Job:"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_close from u_cb within w_da_offline_sheet
string tag = "Exit"
integer x = 3152
integer y = 2205
integer width = 607
integer height = 134
integer taborder = 40
integer textsize = -20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&EXIT"
end type

event clicked;call super::clicked;if this.of_messagebox( "id_Exit", "Confirm exit", "Do you want to exit?", Question!, YesNo!, 2) = 1 then
	if wf_super_validation( ) = 1 then
		parent.event pfc_close()
	end if
end if
end event

type gb_line from u_gb within w_da_offline_sheet
integer y = 99
integer width = 3763
integer height = 192
integer taborder = 10
integer textsize = -9
integer weight = 700
string facename = "Arial"
long textcolor = 32768
string text = "Current on the line:"
end type

type gb_coil_processed from groupbox within w_da_offline_sheet
integer x = 18
integer y = 1098
integer width = 1031
integer height = 701
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Coils processed"
end type

type gb_operation from u_gb within w_da_offline_sheet
integer x = 3145
integer y = 314
integer width = 618
integer height = 1882
integer taborder = 20
integer textsize = -9
integer weight = 700
string facename = "Arial"
long textcolor = 8388608
string text = "Operation"
end type

type gb_skid from groupbox within w_da_offline_sheet
integer x = 1068
integer y = 378
integer width = 2041
integer height = 1222
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Sheet Skid Information"
end type

type gb_scrap from groupbox within w_da_offline_sheet
integer x = 1068
integer y = 1606
integer width = 2041
integer height = 710
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Scrap Information"
end type

type gb_shift from u_gb within w_da_offline_sheet
integer y = 317
integer width = 3127
integer height = 2016
integer taborder = 20
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "Shift Information"
end type

