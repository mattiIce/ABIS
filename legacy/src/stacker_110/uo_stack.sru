$PBExportHeader$uo_stack.sru
forward
global type uo_stack from nonvisualobject
end type
end forward

global type uo_stack from nonvisualobject
end type
global uo_stack uo_stack

type variables
int ii_sta
string is_title
end variables

forward prototypes
public subroutine of_stack_complete (integer ai_sta)
end prototypes

public subroutine of_stack_complete (integer ai_sta);ii_sta = ai_sta
end subroutine

on uo_stack.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_stack.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

