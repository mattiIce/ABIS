$PBExportHeader$uo_timing_scheduler_2.sru
forward
global type uo_timing_scheduler_2 from timing
end type
end forward

global type uo_timing_scheduler_2 from timing
end type
global uo_timing_scheduler_2 uo_timing_scheduler_2

type variables
powerobject ipo_obj
String is_event
//uo_timing_scheduler_1 iuo_timer_1
//long il_interval
end variables

forward prototypes
public subroutine init (readonly powerobject ao_obj, string as_event)
end prototypes

public subroutine init (readonly powerobject ao_obj, string as_event);ipo_obj = ao_obj
is_event = as_event
//il_interval =  al_interval
//iuo_timer_1 = auo_t
end subroutine

event timer;////
ipo_obj.postevent( is_event )
//if not ipo_obj.postevent( is_event ) then
//	gnv_app.inv_error.of_message( "Postevent", ipo_obj.classname( ) + " " + is_event , StopSign!, OK!, 1, 5, true, true)
//end if

end event

on uo_timing_scheduler_2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_timing_scheduler_2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

