$PBExportHeader$u_causes.sru
forward
global type u_causes from nonvisualobject
end type
end forward

global type u_causes from nonvisualobject
event ue_dt_interval ( )
event ue_log_start ( )
event ue_log_end ( )
end type
global u_causes u_causes

type variables
Private:
int ii_cause_count
int ii_cause_id[]
string is_cause_name[]
int ii_cause_min[]
string is_cause_note[]
time it_cause_start[]
Datetime id_start_time
Datetime id_end_time
boolean ib_active[]
long il_shift_id, il_job_id
int ii_line_id
n_tmg itmg_dt_timing
w_dt_one_min_log iw_dt_log
u_dt_cause_tabpg iu_dt_tabpg
w_dt_production_resume iw_production_resume
int ii_status
uo_shift iuo_shift_ref
end variables

forward prototypes
public subroutine add_cause (integer min, string name, integer id)
public subroutine set_min (integer id, integer min)
public function integer save ()
public function integer get_cause_count ()
public subroutine set_start (date d, time t)
public subroutine set_end (date d, time t)
public function string get_name_by_index (integer index)
public subroutine set_min_by_index (integer index, integer min)
public subroutine set_note_by_index (integer index, string note)
public subroutine clear_causes ()
public function integer get_min_by_index (integer index)
public function string get_note_by_index (integer index)
public function boolean is_id_in_instance (integer id)
public function time get_start_time ()
public function time get_end_time ()
public function time get_cause_start_time_by_index (integer index)
public function time get_cause_start_time_by_id (integer id)
public subroutine end_cause_by_index (integer index)
public subroutine end_cause_by_id (integer id)
public function boolean delete_cause_by_index (integer index)
public function boolean is_cause_active_by_index (integer index)
public function boolean is_cause_id_active (integer id)
public function integer get_id_by_index (integer index)
public function integer get_index_by_id (integer id)
public subroutine add_cause (string name, integer id)
public subroutine add_cause (time start_time, string name, integer id)
public function boolean is_any_cause_active ()
public function datetime get_inst_end_datetime ()
public function datetime get_inst_start_datetime ()
public function date get_start_date ()
public function date get_end_date ()
public subroutine of_set_status (integer ii_s)
public function integer of_get_status ()
public subroutine init (integer ai_line, long al_job, readonly uo_shift auo_s)
public function uo_shift of_get_shift ()
public function integer of_open_dt_tabpg ()
public subroutine of_open_prodution_resume ()
public subroutine of_select_dt_tabpg ()
public function datetime get_instance_start ()
public function boolean is_any_other_cause_active_besides_this (integer ai_id)
public function long get_sec_from_inst_start_2_active_cause ()
end prototypes

event ue_dt_interval();ii_status = 1
if isValid(itmg_dt_timing) then
	itmg_dt_timing.stop( )
	itmg_dt_timing.inv_single.of_unregister( )
	//messageBox("timer", string(now()))
	//destroy itmg_dt_timing
end if
//iw_dt_log = create w_dt_one_min_log
//messageBox("timer", string(now()))
OpenWithParm(iw_dt_log, this, this.iuo_shift_ref.iw_sheet )

end event

event ue_log_end();if isValid(iu_dt_tabpg) then
	this.of_get_shift( ).of_get_w_sheet( ).tab_da.closetab( iu_dt_tabpg )
	this.of_get_shift( ).of_get_w_sheet( ).tab_da.selecttab( 1)
end if
//MessageBox("iu_dt_tabpg", string(isValid(iu_dt_tabpg)))
end event

public subroutine add_cause (integer min, string name, integer id);int li_index

if is_id_in_instance( id ) then
	li_index = get_index_by_id( id)
	ib_active[li_index] = true
else
	ii_cause_count = ii_cause_count +1
	ii_cause_id[ii_cause_count] = id
	ii_cause_min[ii_cause_count] = min
	is_cause_name[ii_cause_count] = name
	is_cause_note[ii_cause_count] = ""
	it_cause_start[ii_cause_count] = Now()
	ib_active[ii_cause_count] = true
end if
end subroutine

public subroutine set_min (integer id, integer min);int n
FOR n = 1 to ii_cause_count
	if ii_cause_id[n] = id then
		ii_cause_min[n] = min
	end if
NEXT


end subroutine

public function integer save ();long ll_seq
int i, cause_id, min, sec // min use as sec in u_causes
string ls_note, ls_bypass

if ii_cause_count <= 0 then
	return -1
end if


if isNull(id_end_time) then
	id_end_time = DateTime(today(), now())
end if

il_job_id = 0

if isValid( iuo_shift_ref ) then
	if isValid( iuo_shift_ref.of_get_w_sheet( ).iu_current_coil) then
		il_job_id = iuo_shift_ref.of_get_w_sheet( ).iu_current_coil.get_current_job( )
	end if
end if

if il_job_id < 1000 then
	setNull(il_job_id)
end if

SELECT dt_instance_seq.NEXTVAL INTO :ll_seq FROM DUAL;
	INSERT INTO "DT_INSTANCE"  
         ( "INSTANCE_NUM",   
           "AB_JOB_NUM",   
           "LINE_NUM",   
           "STARTING_TIME",   
           "ENDING_TIME",   
           "NOTE",
			  "SHIFT_NUM")  
  	VALUES ( :ll_seq,   
           :il_job_id,   
           :ii_line_id,   
           :id_start_time,   
           :id_end_time,   
           :ls_bypass,
			  :il_shift_id)  
	;
if sqlca.sqlcode = 0 then
	
	if not isNull( il_job_id ) then
		  	UPDATE "DT_INSTANCE"  
     			SET "AB_JOB_NUM" = :il_job_id  
   		WHERE "DT_INSTANCE"."SHIFT_NUM" = :il_shift_id and
			      "AB_JOB_NUM" IS NULL;
			if sqlca.sqlcode <> 0 then
				sqlca.of_rollback( )
				return sqlca.sqlcode
			end if
	end if
	
	for i=1 to ii_cause_count
		cause_id = ii_cause_id[i]
		if ib_active[i] then
			min = secondsafter(it_cause_start[i], now())
		else
			min = ii_cause_min[i]
		end if
		
		if min < 0 then
			min = 86400 + min
		end if
		
		ii_cause_min[i] = min
		
		ls_note = is_cause_note[i] 
		
		INSERT INTO "DT_INSTANCE_DETAIL"  
         ( "INSTANCE_NUM",   
           "INSTANCE_ITEM",   
           "ID",   
           "DURATION",   
           "NOTE" )  
   	VALUES ( :ll_seq,   
           :i,
           :cause_id,
           :min,
			  :ls_note )
		USING SQLCA;
	
		if sqlca.sqlcode <> 0 then
			SQLCA.of_rollback( );
			return sqlca.sqlcode
		end if

 	next
	
	else
	SQLCA.of_rollback( ) ;
	return sqlca.sqlcode
end if
	
		UPDATE "LINE_CURRENT_STATUS"  
     	SET "LINE_STATUS" = 0  
   	WHERE "LINE_CURRENT_STATUS"."LINE_NUM" = :ii_line_id   
           ;
		
		if sqlca.sqlcode <> 0 then
			sqlca.of_rollback( )
			MessageBox("Update line status", "Fail to update line status table!")
			return sqlca.sqlcode
		end if
 
//	SQLCA.of_commit( ) ;
 	sqlca.of_commit( )
	if isValid(iuo_shift_ref) then
		iuo_shift_ref.il_totol_downtime_sec = iuo_shift_ref.il_totol_downtime_sec + secondsafterabs( Time(id_start_time) , Time(id_end_time) )
	end if

return sqlca.sqlcode
end function

public function integer get_cause_count ();return this.ii_cause_count
end function

public subroutine set_start (date d, time t);id_start_time = datetime(d,t)
end subroutine

public subroutine set_end (date d, time t);id_end_time = datetime(d,t)
end subroutine

public function string get_name_by_index (integer index);return is_cause_name[index]
end function

public subroutine set_min_by_index (integer index, integer min);ii_cause_min[index] = min
end subroutine

public subroutine set_note_by_index (integer index, string note);is_cause_note[index] = note
end subroutine

public subroutine clear_causes ();ii_cause_count = 0
end subroutine

public function integer get_min_by_index (integer index);return ii_cause_min[index]
end function

public function string get_note_by_index (integer index);return is_cause_note[index]
end function

public function boolean is_id_in_instance (integer id);int i
boolean rt
rt = false
For i = 1 to ii_cause_count
	if ii_cause_id[i] = id then
		rt = true
		exit
	end if
Next
return rt
end function

public function time get_start_time ();return Time(id_start_time)
end function

public function time get_end_time ();return Time(id_end_time)
end function

public function time get_cause_start_time_by_index (integer index);return it_cause_start[index]
end function

public function time get_cause_start_time_by_id (integer id);int i
Time return_time

for i = 1 to ii_cause_count
	if ii_cause_id[i] = id then
		return_time = it_cause_start[i]
		exit
	end if
Next
return return_time




end function

public subroutine end_cause_by_index (integer index);int li_mins
li_mins = secondsafter(it_cause_start[index], now())
if li_mins < 0 then
	li_mins = 86400 + li_mins
end if
ii_cause_min[index] = li_mins
ib_active[index] = false
end subroutine

public subroutine end_cause_by_id (integer id);int li_mins, i //min used as sec in u_causes
for i = 1 to ii_cause_count
	if ii_cause_id[i] = id then
		li_mins = secondsafter(it_cause_start[i], now())
		if li_mins < 0 then
			li_mins = 86400 + li_mins
		end if
		ii_cause_min[i] = li_mins
		ib_active[i] = false
	end if
next
end subroutine

public function boolean delete_cause_by_index (integer index);boolean lb_rt
int i
lb_rt = false
if index > ii_cause_count or index < 1 then
	return lb_rt
end if

lb_rt  = true

if ii_cause_count <=1 then
	clear_causes( )
else
	for i = index to ii_cause_count - 1
		ii_cause_id[i] = ii_cause_id[ i + 1 ]
		ii_cause_id[i] = ii_cause_id[ i + 1 ]
		is_cause_name[i] = is_cause_name[ i + 1 ]
		ii_cause_min[i] = ii_cause_min[ i + 1 ]
		is_cause_note[i] = is_cause_note[ i + 1 ]
		it_cause_start[i] = it_cause_start[ i + 1 ]
		ib_active[i] = ib_active[ i+1 ]
	Next
	
	ii_cause_count = ii_cause_count - 1

end if

return lb_rt

end function

public function boolean is_cause_active_by_index (integer index);return ib_active[index]
end function

public function boolean is_cause_id_active (integer id);boolean lb_rt
int i
lb_rt = false

For i = 1 to ii_cause_count
	if ii_cause_id[i] = id then
		return ib_active[i]
	end if
Next
return lb_rt
end function

public function integer get_id_by_index (integer index);return ii_cause_id[index]
end function

public function integer get_index_by_id (integer id);int li_rt,i
li_rt = 0
for i = 1 to ii_cause_count
	if ii_cause_id[i] = id then
		li_rt = i
		exit
	end if
next
return li_rt
end function

public subroutine add_cause (string name, integer id);add_cause( 0, name, id)
end subroutine

public subroutine add_cause (time start_time, string name, integer id);int li_index

if is_id_in_instance( id ) then
	li_index = get_index_by_id( id)
	ib_active[li_index] = true
	it_cause_start[li_index] = start_time
else
	ii_cause_count = ii_cause_count +1
	ii_cause_id[ii_cause_count] = id
	ii_cause_min[ii_cause_count] = 0
	is_cause_name[ii_cause_count] = name
	is_cause_note[ii_cause_count] = ""
	it_cause_start[ii_cause_count] = start_time
	ib_active[ii_cause_count] = true
end if
end subroutine

public function boolean is_any_cause_active ();boolean lb_rt
int i
lb_rt = false
for i = 1 to ii_cause_count
	if ib_active[i] then
		lb_rt = true
		exit
	end if
next
return lb_rt
end function

public function datetime get_inst_end_datetime ();return id_end_time
end function

public function datetime get_inst_start_datetime ();return id_start_time
end function

public function date get_start_date ();return date(id_start_time)
end function

public function date get_end_date ();return date(id_end_time)
end function

public subroutine of_set_status (integer ii_s);ii_status = ii_s
end subroutine

public function integer of_get_status ();return ii_status
end function

public subroutine init (integer ai_line, long al_job, readonly uo_shift auo_s);ii_line_id = ai_line
il_job_id = al_job
iuo_shift_ref = auo_s
il_shift_id = iuo_shift_ref.get_shift_id( )
end subroutine

public function uo_shift of_get_shift ();return iuo_shift_ref
end function

public function integer of_open_dt_tabpg ();int li_rc
li_rc = 0
if not isValid(iu_dt_tabpg) then
	iu_dt_tabpg = create u_dt_cause_tabpg
	li_rc = this.of_get_shift( ).of_get_w_sheet( ).tab_da.opentab( iu_dt_tabpg, 0 )
	iu_dt_tabpg.of_init( this )
end if
//this.of_get_shift( ).of_get_w_sheet( ).tab_da.selecttab( iu_dt_tabpg )
return li_rc
end function

public subroutine of_open_prodution_resume ();if not isValid(iw_production_resume) then
	OpenWithParm(iw_production_resume, this, this.iuo_shift_ref.iw_sheet)
end if

end subroutine

public subroutine of_select_dt_tabpg ();if isValid(iu_dt_tabpg ) then
	iuo_shift_ref.of_Get_w_sheet( ).tab_da.selecttab( iu_dt_tabpg)
end if
end subroutine

public function datetime get_instance_start ();return id_start_time
end function

public function boolean is_any_other_cause_active_besides_this (integer ai_id);int li_i, li_index
boolean lb_rc
lb_rc = false
if ii_cause_count < 1 then return false
li_index = get_index_by_id( ai_id)
for li_i=1 to ii_cause_count
	if li_i = li_index then CONTINUE
	if ib_active[li_i] then lb_rc = true
next
return lb_rc
end function

public function long get_sec_from_inst_start_2_active_cause ();time lt_cause_start, lt_instance_start
int li_i
long ll_sec, ll_tmp
if ii_cause_count < 1 then return 0
if not is_any_cause_active( ) then return 0
ll_sec = 0
lt_instance_start = Time(id_start_time)

//iuo_shift_ref.iw_sheet.inv_datetime.

for li_i=1 to ii_cause_count
	if ib_active[li_i] then
		ll_sec = secondsafterabs(   lt_instance_start , it_cause_start[li_i] )
		EXIT
	end if
next

//messagebox("",string(ll_sec))

//lt_instance_start = Time(id_start_time)
//lt_cause_start = it_cause_start[1]
//ll_sec = 0
for li_i=1 to ii_cause_count
	if not ib_active[li_i] then continue
	ll_tmp = secondsafterabs(lt_instance_start , it_cause_start[li_i] )
	if   ll_tmp < ll_sec then 
		ll_sec = ll_tmp 
	end if
next

if ll_sec < 0 then return 0

return ll_sec
end function

on u_causes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_causes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ii_cause_count = 0
id_start_time = DateTime(today(), now())
setNull(id_end_time)
itmg_dt_timing = create n_tmg
itmg_dt_timing.of_setsingle( true)
itmg_dt_timing.inv_single.of_register( this, "ue_dt_interval", 30)
ii_status = 0
end event

event destructor;//save( )
if isValid(itmg_dt_timing) then
	destroy itmg_dt_timing
end if
if ii_status > 1 then
	save( )
end if
//MessageBox("status", string(ii_status ))
if isValid(iw_dt_log) then
	//MessageBox("log", "window valid")
	close(iw_dt_log)
	//destroy iw_dt_log
end if
//w_da_sheet lw_sheet
//lw_sheet = iuo_shift_ref.of_get_w_sheet
if isValid(iw_production_resume) then
	close(iw_production_resume)
end if
if isValid(iu_dt_tabpg) then
	//lw_sheet.tab_da.closetab( iu_dt_tabpg)
	this.of_get_shift( ).of_get_w_sheet( ).tab_da.closetab( iu_dt_tabpg )
	this.of_get_shift( ).of_get_w_sheet( ).tab_da.selecttab( 1 )
end if

end event

