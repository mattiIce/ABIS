$PBExportHeader$uo_one_hour_timer.sru
forward
global type uo_one_hour_timer from nonvisualobject
end type
end forward

global type uo_one_hour_timer from nonvisualobject
end type
global uo_one_hour_timer uo_one_hour_timer

type variables
//n_tmg itmg_timer
//n_tmg itmg_scheduler

uo_timing_scheduler_1 iuo_timer1
uo_timing_scheduler_2 iuo_timer2

//Time it_schedule_time
PowerObject io_object
String is_event
//constant int sundaya = 0
end variables

forward prototypes
public function integer of_register (readonly powerobject ao_object, string as_event, integer at_min, integer at_sec)
end prototypes

public function integer of_register (readonly powerobject ao_object, string as_event, integer at_min, integer at_sec);//
long ll_interval
Time lt_1, lt_2
int li_min, li_sec
io_object = ao_object
is_event = as_event

li_min = Minute(now())
li_sec = Second(now())
//it_schedule_time = at_time

lt_1 = Time(00, li_min, li_sec )
lt_2 = Time(00, at_min, at_sec)

ll_interval = SecondsAfter(lt_1, lt_2 )

iuo_timer2.init( ao_object , as_event  )
iuo_timer1.init( ao_object , as_event, 3600, iuo_timer2 )

if ll_interval = 0 then
	iuo_timer2.start( 3600)
elseif ll_interval > 0 then
	iuo_timer1.start( ll_interval )
else
	iuo_timer1.start( ll_interval + 3600 )
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

on uo_one_hour_timer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_one_hour_timer.destroy
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

