$PBExportHeader$u_tabpg_downtime_log.sru
forward
global type u_tabpg_downtime_log from u_tabpg
end type
type dw_downtime_log from u_dw within u_tabpg_downtime_log
end type
end forward

global type u_tabpg_downtime_log from u_tabpg
integer width = 3599
integer height = 1946
long backcolor = 134217752
boolean ib_isupdateable = false
dw_downtime_log dw_downtime_log
end type
global u_tabpg_downtime_log u_tabpg_downtime_log

type variables
w_operation_panel iw_operation_panel
end variables

on u_tabpg_downtime_log.create
int iCurrent
call super::create
this.dw_downtime_log=create dw_downtime_log
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_downtime_log
end on

on u_tabpg_downtime_log.destroy
call super::destroy
destroy(this.dw_downtime_log)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
//dw_downtime_log
//em_password.of_setdropdowncalculator( true)
//em_password.iuo_calculator.of_setcloseonclick( true)
//em_password.iuo_calculator.of_setinitialvalue( true)

//if not isValid(iuo_shift) then
//	return
//end if

//w_please_wait lw_wait

//open(lw_wait, this)
long ll_shift_id

if not isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
	return 0
else
	ll_shift_id = iw_operation_panel.iw_da_sheet.iuo_shift.get_shift_id( )
end if

dw_downtime_log.SetTransObject(sqlca)
dw_downtime_log.Retrieve( ll_shift_id )

//close(lw_wait)

end event

type dw_downtime_log from u_dw within u_tabpg_downtime_log
integer width = 3599
integer height = 1920
integer taborder = 10
string dataobject = "d_report_shift_downtime_log"
boolean resizable = true
boolean ib_isupdateable = false
end type

