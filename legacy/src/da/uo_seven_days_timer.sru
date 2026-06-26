$PBExportHeader$uo_seven_days_timer.sru
forward
global type uo_seven_days_timer from nonvisualobject
end type
end forward

global type uo_seven_days_timer from nonvisualobject
end type
global uo_seven_days_timer uo_seven_days_timer

type variables
uo_timing_scheduler_1 iuo_timer1
uo_timing_scheduler_2 iuo_timer2
Integer ii_day_num
Time it_schedule_time
PowerObject io_object
String is_event

end variables

forward prototypes
public subroutine of_register (powerobject ao_object, string as_event, integer ai_daynum, time at_time)
public subroutine of_unregister ()
end prototypes

public subroutine of_register (powerobject ao_object, string as_event, integer ai_daynum, time at_time);long ll_interval
int li_days
io_object = ao_object
is_event = as_event
it_schedule_time = at_time
ii_day_num = ai_daynum
//ll_interval = SecondsAfterabs(now(),at_time)

iuo_timer2.init( ao_object , as_event  )
iuo_timer1.init( ao_object , as_event, 604800, iuo_timer2 )


li_days = ai_daynum - DayNumber(Today())

if li_days = 0 then
	ll_interval = SecondsAfter(now(),at_time)
	if ll_interval = 0 then
		iuo_timer2.start( 604800)
	elseif ll_interval < 0 then
		iuo_timer1.start(  604800 + ll_interval )
	else
		iuo_timer1.start(  ll_interval )
	end if
elseif li_days < 0 then
	ll_interval = (7 + li_days ) * 86400 + secondsafter(now(), at_time)
	iuo_timer1.start(  ll_interval )
else // > 0
	ll_interval = li_days * 86400 + secondsafter(now(), at_time)
	iuo_timer1.start(  ll_interval )
end if

end subroutine

public subroutine of_unregister ();if iuo_timer1.running then
	iuo_timer1.stop( )
end if

if iuo_timer2.running then
	iuo_timer2.stop( )
end if

end subroutine

event constructor;//
iuo_timer1 = create uo_timing_scheduler_1
iuo_timer2 = create uo_timing_scheduler_2
end event

on uo_seven_days_timer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_seven_days_timer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

