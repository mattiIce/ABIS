$PBExportHeader$u_da_dt_summary_tabpg.sru
forward
global type u_da_dt_summary_tabpg from u_tabpg
end type
type dw_shift_summary from u_dw within u_da_dt_summary_tabpg
end type
end forward

global type u_da_dt_summary_tabpg from u_tabpg
integer width = 3727
integer height = 1702
dw_shift_summary dw_shift_summary
end type
global u_da_dt_summary_tabpg u_da_dt_summary_tabpg

type variables
string is_title
w_da_sheet iw_sheet
end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
end prototypes

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
end subroutine

on u_da_dt_summary_tabpg.create
int iCurrent
call super::create
this.dw_shift_summary=create dw_shift_summary
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shift_summary
end on

on u_da_dt_summary_tabpg.destroy
call super::destroy
destroy(this.dw_shift_summary)
end on

event constructor;call super::constructor;dw_shift_summary.of_settransobject( sqlca)
dw_shift_summary.of_setupdateable( false)
end event

type dw_shift_summary from u_dw within u_da_dt_summary_tabpg
integer x = 15
integer y = 16
integer width = 3639
integer height = 1658
integer taborder = 10
string dataobject = "d_report_shift_downtime_summary"
end type

