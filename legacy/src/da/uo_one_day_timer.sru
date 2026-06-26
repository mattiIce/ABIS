$PBExportHeader$uo_one_day_timer.sru
forward
global type uo_one_day_timer from nonvisualobject
end type
end forward

global type uo_one_day_timer from nonvisualobject
end type
global uo_one_day_timer uo_one_day_timer

type variables
//n_tmg itmg_timer
//n_tmg itmg_scheduler

uo_timing_scheduler_1 iuo_timer1
uo_timing_scheduler_2 iuo_timer2

Time it_schedule_time
PowerObject io_object
String is_event
//constant int sundaya = 0
end variables

forward prototypes
public function integer of_register (readonly powerobject ao_object, string as_event, time at_time)
end prototypes

public function integer of_register (readonly powerobject ao_object, string as_event, time at_time);//
long ll_interval
io_object = ao_object
is_event = as_event
it_schedule_time = at_time
ll_interval = SecondsAfterabs(now(),at_time)

iuo_timer2.init( ao_object , as_event  )
iuo_timer1.init( ao_object , as_event, 86400, iuo_timer2 )

if ll_interval = 0 then
	iuo_timer2.start( 86400)
else
	iuo_timer1.start( ll_interval )
end if





//itmg_timer.of_setsingle( true)

//MessageBox("test", string(ll_interval))

/*

if ll_interval = 0 then
	//itmg_timer.of_setsingle( true)
	itmg_scheduler.inv_single.of_register( ao_object, as_event, 86400)
	//
else
	//itmg_timer.of_setmultiple( true)
	itmg_timer.inv_single.of_register( this, "ue_register", 180 )
end if
*/





return 0
end function

on uo_one_day_timer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_one_day_timer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*
itmg_timer = Create n_tmg
itmg_scheduler = Create n_tmg
itmg_timer.of_setsingle( true)
itmg_scheduler.of_setsingle( true)
*/
//itmg_timer.of_setmultiple( true)
//itmg_timer.inv_multiple.of_reg
iuo_timer1 = create uo_timing_scheduler_1
iuo_timer2 = create uo_timing_scheduler_2
end event

event destructor;//Destory itmg_timer
end event

