$PBExportHeader$uo_timing_end_shift.sru
forward
global type uo_timing_end_shift from timing
end type
end forward

global type uo_timing_end_shift from timing
end type
global uo_timing_end_shift uo_timing_end_shift

type variables
Private uo_shift iu_shift
end variables

forward prototypes
public subroutine of_end_shift ()
public subroutine init (readonly uo_shift au_shift)
end prototypes

public subroutine of_end_shift ();//
end subroutine

public subroutine init (readonly uo_shift au_shift);iu_shift = au_shift
end subroutine

on uo_timing_end_shift.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_timing_end_shift.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;//of_end_shift( )
//iu_shift.end_shift( )
end event

