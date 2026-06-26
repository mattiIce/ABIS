$PBExportHeader$uo_timing_downtime.sru
forward
global type uo_timing_downtime from timing
end type
end forward

global type uo_timing_downtime from timing
end type
global uo_timing_downtime uo_timing_downtime

type variables
//Private uo_shift iu_shift
Private powerobject ipo_obj
String is_event
end variables

forward prototypes
public subroutine init (readonly powerobject au_obj, string as_event)
end prototypes

public subroutine init (readonly powerobject au_obj, string as_event);//iu_shift = au_shift
ipo_obj = au_obj
is_event = as_event

end subroutine

on uo_timing_downtime.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_timing_downtime.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;//if this.running then
//	this.stop( )
//end if
ipo_obj.postevent( is_event )
//if not ipo_obj.postevent( is_event ) then
	//gnv_app.inv_error.of_message( "Postevent", ipo_obj.classname( ) + " " +is_event , StopSign!, OK!, 1, 5, true, true)
//end if
	
end event

