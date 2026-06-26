$PBExportHeader$u_da_dt_log_tabpg.sru
forward
global type u_da_dt_log_tabpg from u_tabpg
end type
type dw_downtime_log from u_dw within u_da_dt_log_tabpg
end type
end forward

global type u_da_dt_log_tabpg from u_tabpg
integer width = 3727
integer height = 1702
dw_downtime_log dw_downtime_log
end type
global u_da_dt_log_tabpg u_da_dt_log_tabpg

type variables
string is_title
w_da_sheet iw_sheet
end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
end prototypes

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
end subroutine

on u_da_dt_log_tabpg.create
int iCurrent
call super::create
this.dw_downtime_log=create dw_downtime_log
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_downtime_log
end on

on u_da_dt_log_tabpg.destroy
call super::destroy
destroy(this.dw_downtime_log)
end on

event constructor;call super::constructor;dw_downtime_log.of_settransobject( sqlca)
dw_downtime_log.of_setupdateable( false)
end event

type dw_downtime_log from u_dw within u_da_dt_log_tabpg
integer x = 7
integer y = 13
integer width = 3700
integer height = 1667
integer taborder = 10
string dataobject = "d_report_shift_downtime_log"
end type

