$PBExportHeader$u_tabpg_downtime_summary.sru
forward
global type u_tabpg_downtime_summary from u_tabpg
end type
type dw_shift_summary from u_dw within u_tabpg_downtime_summary
end type
end forward

global type u_tabpg_downtime_summary from u_tabpg
integer width = 3599
integer height = 1946
long backcolor = 134217752
boolean ib_isupdateable = false
dw_shift_summary dw_shift_summary
end type
global u_tabpg_downtime_summary u_tabpg_downtime_summary

type variables
w_operation_panel iw_operation_panel
end variables

on u_tabpg_downtime_summary.create
int iCurrent
call super::create
this.dw_shift_summary=create dw_shift_summary
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shift_summary
end on

on u_tabpg_downtime_summary.destroy
call super::destroy
destroy(this.dw_shift_summary)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
//em_password.of_setdropdowncalculator( true)
//em_password.iuo_calculator.of_setcloseonclick( true)
//em_password.iuo_calculator.of_setinitialvalue( true)

if not isValid(iw_operation_panel.iw_da_sheet.iuo_shift) then
	return
end if
w_please_wait lw_wait

open(lw_wait)
	dw_shift_summary.SetTransObject(sqlca)
	dw_shift_summary.Retrieve( iw_operation_panel.iw_da_sheet.iuo_shift.get_shift_id( ) )
close(lw_wait)
end event

type dw_shift_summary from u_dw within u_tabpg_downtime_summary
integer width = 3599
integer height = 1920
integer taborder = 10
string dataobject = "d_report_shift_downtime_summary"
boolean resizable = true
end type

