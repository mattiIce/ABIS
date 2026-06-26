$PBExportHeader$uo_timing_get_shift.sru
forward
global type uo_timing_get_shift from timing
end type
end forward

global type uo_timing_get_shift from timing
end type
global uo_timing_get_shift uo_timing_get_shift

type variables
w_da_sheet iw_da_sheet
end variables

forward prototypes
public subroutine of_end_shift ()
public subroutine init (readonly w_da_sheet aw_sheet)
end prototypes

public subroutine of_end_shift ();//
end subroutine

public subroutine init (readonly w_da_sheet aw_sheet);iw_da_sheet = aw_sheet
end subroutine

on uo_timing_get_shift.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_timing_get_shift.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;long ll_rc
Date ld_today
Time lt_now 
ld_today = today()
lt_now = now()

if isValid( iw_da_sheet.iuo_shift ) then 
		return
end if

if iw_da_sheet.inv_datetime.of_dayofweek( ld_today ) = 7  and (lt_now > 15:58:00 and lt_now < 16:30:00)  then
	return
end if

ll_rc = iw_da_sheet.wf_get_shift_id(DateTime( ld_today, lt_now ))
if  ll_rc > 1001 then
	iw_da_sheet.wf_new_shift( ll_rc )
end if
end event

