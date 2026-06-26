$PBExportHeader$uo_schedule.sru
forward
global type uo_schedule from nonvisualobject
end type
end forward

global type uo_schedule from nonvisualobject
end type
global uo_schedule uo_schedule

type variables
Private:
Date id_schedule_date
Time it_schedule_start[]
Time it_schedule_stop[]
int ii_schedule_count
int ii_shedule_type[]
int ii_status[]
int ii_line_id
 DECLARE icur_line_default CURSOR FOR  
  SELECT "LINE_DEFAULT_SCHEDULE"."SCHEDULE_TYPE",   
         "LINE_DEFAULT_SCHEDULE"."MON_START",   
         "LINE_DEFAULT_SCHEDULE"."MON_END",   
         "LINE_DEFAULT_SCHEDULE"."MON_CANCEL",   
         "LINE_DEFAULT_SCHEDULE"."TUE_START",   
         "LINE_DEFAULT_SCHEDULE"."TUE_END",   
         "LINE_DEFAULT_SCHEDULE"."TUE_CANCEL",   
         "LINE_DEFAULT_SCHEDULE"."WED_START",   
         "LINE_DEFAULT_SCHEDULE"."WED_END",   
         "LINE_DEFAULT_SCHEDULE"."WED_CANCEL",   
         "LINE_DEFAULT_SCHEDULE"."THU_START",   
         "LINE_DEFAULT_SCHEDULE"."THU_END",   
         "LINE_DEFAULT_SCHEDULE"."THU_CANCEL",   
         "LINE_DEFAULT_SCHEDULE"."FRI_START",   
         "LINE_DEFAULT_SCHEDULE"."FRI_END",   
         "LINE_DEFAULT_SCHEDULE"."FRI_CANCEL",   
         "LINE_DEFAULT_SCHEDULE"."SAT_START",   
         "LINE_DEFAULT_SCHEDULE"."SAT_END",   
         "LINE_DEFAULT_SCHEDULE"."SAT_CANCEL",   
         "LINE_DEFAULT_SCHEDULE"."SUN_START",   
         "LINE_DEFAULT_SCHEDULE"."SUN_END",   
         "LINE_DEFAULT_SCHEDULE"."SUN_CANCEL"  
    FROM "LINE_DEFAULT_SCHEDULE"  
   WHERE "LINE_DEFAULT_SCHEDULE"."LINE_NUM" = :ii_line_id
           
ORDER BY "LINE_DEFAULT_SCHEDULE"."SCHEDULE_TYPE" ASC  ;

end variables
forward prototypes
public function time get_endtime_by_type (integer ai_type)
public function integer get_id_by_type (integer ai_type)
public function time get_starttime_by_type (integer ai_type)
public function integer update_all_shifts (date ad_date, integer ai_line)
public function integer get_schedule_count ()
public function time get_start_by_id (integer ai_id)
public function time get_end_by_id (integer ai_id)
public function integer get_type_by_id (integer ai_id)
public function integer get_status_by_id (integer ai_id)
end prototypes

public function time get_endtime_by_type (integer ai_type);//return now()
return it_schedule_stop[get_id_by_type( ai_type)]
end function

public function integer get_id_by_type (integer ai_type);int li_i
for li_i=1 to ii_schedule_count
	if ii_shedule_type[li_i] = ai_type then
		return li_i
	end if
next
return 0

end function

public function time get_starttime_by_type (integer ai_type);return it_schedule_start[get_id_by_type( ai_type)]
end function

public function integer update_all_shifts (date ad_date, integer ai_line);DateTime ldt_today, ldt_schedule_date,ldt_day_before, ldt_default_s, ldt_default_e, ldt_mon_s, ldt_mon_e
DateTime ldt_tue_s, ldt_tue_e, ldt_wed_s, ldt_wed_e, ldt_thu_s, ldt_thu_e, ldt_fri_s, ldt_fri_e
DateTime ldt_sat_s, ldt_sat_e, ldt_sun_s, ldt_sun_e
Time lt_default_s, lt_default_e
int li_type, li_cancel, li_mon_cancel, li_tue_cancel, li_wed_cancel, li_thu_cancel, li_fri_cancel, li_sat_cancel, li_sun_cancel, li_i
Date ld_schedule_day, ld_day_before

//ldt_today = DateTime(today())
id_schedule_date = ad_date
ldt_schedule_date = DateTime(ad_date)
ii_line_id = ai_line
ld_schedule_day = ad_date
ld_day_before = RelativeDate(ld_schedule_day, -1)
ii_schedule_count = 0
li_i =1

OPEN icur_line_default;
FETCH icur_line_default into :li_type, :ldt_mon_s, :ldt_mon_e, :li_mon_cancel, :ldt_tue_s, :ldt_tue_e, :li_tue_cancel,
									:ldt_wed_s, :ldt_wed_e, :li_wed_cancel, :ldt_thu_s, :ldt_thu_e, :li_thu_cancel,
									:ldt_fri_s, :ldt_fri_e, :li_fri_cancel, :ldt_sat_s, :ldt_sat_e, :li_sat_cancel,
									:ldt_sun_s, :ldt_sun_e, :li_sun_cancel;
DO WHILE SQLCA.sqlcode = 0
	SELECT "SHIFT_SCHEDULE"."SHIFT_STARTING_TIME",   
         					"SHIFT_SCHEDULE"."SHIFT_ENDING_TIME",   
         					"SHIFT_SCHEDULE"."SHIFT_CANCELLED"  
    					INTO :ldt_default_s,	:ldt_default_e,   :li_cancel  
    					FROM "SHIFT_SCHEDULE"  
   					WHERE ( TRUNC("SHIFT_SCHEDULE"."SHIFT_SCHEDULE_DATE") = :ldt_schedule_date ) AND  
         					( "SHIFT_SCHEDULE"."LINE_NUM" = :ii_line_id ) AND  
         					( "SHIFT_SCHEDULE"."SCHEDULE_TYPE" = :li_type );
	CHOOSE CASE DayNumber(ld_schedule_day)
			CASE 2 //Monday
					  IF SQLca.SQLcode = 0 THEN
								it_schedule_start[li_i] = Time(ldt_default_s)
								it_schedule_stop[li_i] = Time(ldt_default_e)
								ii_shedule_type[li_i] = li_type
									ii_status[li_i] = li_cancel
								ii_schedule_count = ii_schedule_count + 1
						ELSE
							// use default
								it_schedule_start[li_i] = Time(ldt_mon_s)
								it_schedule_stop[li_i] = Time(ldt_mon_e)
								ii_shedule_type[li_i] = li_type
									ii_status[li_i] = li_mon_cancel
								ii_schedule_count = ii_schedule_count + 1
						END IF
	
			CASE 3	//Tuesday
						IF SQLca.SQLcode = 0 THEN
								it_schedule_start[li_i] = Time(ldt_default_s)
								it_schedule_stop[li_i] = Time(ldt_default_e)
								ii_shedule_type[li_i] = li_type
									ii_status[li_i] = li_cancel
								ii_schedule_count = ii_schedule_count + 1
							ELSE
							// use default
								it_schedule_start[li_i] = Time(ldt_tue_s)
								it_schedule_stop[li_i] = Time(ldt_tue_e)
								ii_shedule_type[li_i] = li_type
									ii_status[li_i] = li_tue_cancel
								ii_schedule_count = ii_schedule_count + 1
							END IF

			CASE 4	//Wed
				IF SQLca.SQLcode = 0 THEN
								it_schedule_start[li_i] = Time(ldt_default_s)
								it_schedule_stop[li_i] = Time(ldt_default_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_cancel
								ii_schedule_count = ii_schedule_count + 1
						ELSE
							// use default
								it_schedule_start[li_i] = Time(ldt_wed_s)
								it_schedule_stop[li_i] = Time(ldt_wed_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_wed_cancel
								ii_schedule_count = ii_schedule_count + 1
						END IF

			CASE 5	//Thursday
				IF SQLca.SQLcode = 0 THEN
								it_schedule_start[li_i] = Time(ldt_default_s)
								it_schedule_stop[li_i] = Time(ldt_default_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_cancel
								ii_schedule_count = ii_schedule_count + 1
							
						ELSE
							// use default
								it_schedule_start[li_i] = Time(ldt_thu_s)
								it_schedule_stop[li_i] = Time(ldt_thu_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_thu_cancel
								ii_schedule_count = ii_schedule_count + 1
						END IF
		
			CASE 6	//Friday
				IF SQLca.SQLcode = 0 THEN
								it_schedule_start[li_i] = Time(ldt_default_s)
								it_schedule_stop[li_i] = Time(ldt_default_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_cancel
								ii_schedule_count = ii_schedule_count + 1
							ELSE
							// use default
								it_schedule_start[li_i] = Time(ldt_fri_s)
								it_schedule_stop[li_i] = Time(ldt_fri_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_fri_cancel
								ii_schedule_count = ii_schedule_count + 1
							END IF

			CASE 7	//Saturday
			 	IF SQLca.SQLcode = 0 THEN
								it_schedule_start[li_i] = Time(ldt_default_s)
								it_schedule_stop[li_i] = Time(ldt_default_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_cancel
								ii_schedule_count = ii_schedule_count + 1
							ELSE
							// use default
								it_schedule_start[li_i] = Time(ldt_sat_s)
								it_schedule_stop[li_i] = Time(ldt_sat_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_sat_cancel
								ii_schedule_count = ii_schedule_count + 1
							END IF

			CASE 1	//Sunday
				IF SQLca.SQLcode = 0 THEN
								it_schedule_start[li_i] = Time(ldt_default_s)
								it_schedule_stop[li_i] = Time(ldt_default_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_cancel
								ii_schedule_count = ii_schedule_count + 1
							ELSE
							// use default
								it_schedule_start[li_i] = Time(ldt_sun_s)
								it_schedule_stop[li_i] = Time(ldt_sun_e)
								ii_shedule_type[li_i] = li_type
								ii_status[li_i] = li_sun_cancel
								ii_schedule_count = ii_schedule_count + 1
							END IF

		END CHOOSE
		li_i = li_i + 1
	FETCH icur_line_default into :li_type, :ldt_mon_s, :ldt_mon_e, :li_mon_cancel, :ldt_tue_s, :ldt_tue_e, :li_tue_cancel,
									:ldt_wed_s, :ldt_wed_e, :li_wed_cancel, :ldt_thu_s, :ldt_thu_e, :li_thu_cancel,
									:ldt_fri_s, :ldt_fri_e, :li_fri_cancel, :ldt_sat_s, :ldt_sat_e, :li_sat_cancel,
									:ldt_sun_s, :ldt_sun_e, :li_sun_cancel;
LOOP
CLOSE icur_line_default;
//ii_schedule_count = li_i - 1
//ii_schedule_id = 1
id_schedule_date = ld_schedule_day

return 0
end function
public function integer get_schedule_count ();return ii_schedule_count
end function

public function time get_start_by_id (integer ai_id);return it_schedule_start[ai_id]
end function

public function time get_end_by_id (integer ai_id);return it_schedule_stop[ai_id]
end function

public function integer get_type_by_id (integer ai_id);return ii_shedule_type[ai_id]
end function

public function integer get_status_by_id (integer ai_id);return ii_status[ai_id]
end function

on uo_schedule.create
TriggerEvent( this, "constructor" )
end on

on uo_schedule.destroy
TriggerEvent( this, "destructor" )
end on

