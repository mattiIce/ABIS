$PBExportHeader$w_dt_causes_other.srw
forward
global type w_dt_causes_other from w_popup
end type
type uo_17 from u_downtimebutton within w_dt_causes_other
end type
type uo_16 from u_downtimebutton within w_dt_causes_other
end type
type uo_14 from u_downtimebutton within w_dt_causes_other
end type
type uo_13 from u_downtimebutton within w_dt_causes_other
end type
type uo_12 from u_downtimebutton within w_dt_causes_other
end type
type uo_11 from u_downtimebutton within w_dt_causes_other
end type
type uo_10 from u_downtimebutton within w_dt_causes_other
end type
type uo_9 from u_downtimebutton within w_dt_causes_other
end type
type uo_8 from u_downtimebutton within w_dt_causes_other
end type
type uo_7 from u_downtimebutton within w_dt_causes_other
end type
type uo_6 from u_downtimebutton within w_dt_causes_other
end type
type uo_5 from u_downtimebutton within w_dt_causes_other
end type
type uo_4 from u_downtimebutton within w_dt_causes_other
end type
type uo_3 from u_downtimebutton within w_dt_causes_other
end type
type uo_2 from u_downtimebutton within w_dt_causes_other
end type
type uo_1 from u_downtimebutton within w_dt_causes_other
end type
type uo_15 from u_downtimebutton within w_dt_causes_other
end type
type pb_cancel from u_pb within w_dt_causes_other
end type
end forward

global type w_dt_causes_other from w_popup
integer x = 214
integer width = 2289
integer height = 931
string title = "Scrap type selection"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean ib_isupdateable = false
uo_17 uo_17
uo_16 uo_16
uo_14 uo_14
uo_13 uo_13
uo_12 uo_12
uo_11 uo_11
uo_10 uo_10
uo_9 uo_9
uo_8 uo_8
uo_7 uo_7
uo_6 uo_6
uo_5 uo_5
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
uo_15 uo_15
pb_cancel pb_cancel
end type
global w_dt_causes_other w_dt_causes_other

type variables
int ii_scrap_type
//u_da_scrap_tabpg iu_da_scrap_tabpg
u_dt_cause_tabpg iu_dt_cause_tabpg
end variables

event open;call super::open;//ii_scrap_type = message.doubleparm
iu_dt_cause_tabpg = message.powerobjectparm
if gi_screen = 2 then
	if gi_dual_mode = 2 then
		this.x = 600
		this.y = 4000
	else
		this.x = 6500
		this.y = 600
	end if
else
	this.x = iu_dt_cause_tabpg.uo_15.x - this.width /4
	this.y = iu_dt_cause_tabpg.uo_15.y - 50
end if
//uo_type.of_set_defect_id( iu_da_scrap_tabpg.ii_scrap_type )
//ii_scrap_type = iu_dt_cause_tabpg.ii_scrap_type

int li_control_count, i, j, li_cause_count, li_p_index
u_downtimebutton lu_temp
li_control_count = UpperBound(control)


if not isValid(iu_dt_cause_tabpg.iu_causes ) then
	return
elseif iu_dt_cause_tabpg.iu_causes.get_cause_count( ) > 0 then
	
	li_cause_count = iu_dt_cause_tabpg.iu_causes.get_cause_count( )
		For i = 1 to li_control_count
		if control[i].tag = "dt" then
			lu_temp = control[i]
			if iu_dt_cause_tabpg.iu_causes.is_cause_id_active(lu_temp.ii_downtime_reason_id) then
				lu_temp.set_select( )
			end if
		end if
	Next
	
else 
	//
end if

end event

on w_dt_causes_other.create
int iCurrent
call super::create
this.uo_17=create uo_17
this.uo_16=create uo_16
this.uo_14=create uo_14
this.uo_13=create uo_13
this.uo_12=create uo_12
this.uo_11=create uo_11
this.uo_10=create uo_10
this.uo_9=create uo_9
this.uo_8=create uo_8
this.uo_7=create uo_7
this.uo_6=create uo_6
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
this.uo_15=create uo_15
this.pb_cancel=create pb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_17
this.Control[iCurrent+2]=this.uo_16
this.Control[iCurrent+3]=this.uo_14
this.Control[iCurrent+4]=this.uo_13
this.Control[iCurrent+5]=this.uo_12
this.Control[iCurrent+6]=this.uo_11
this.Control[iCurrent+7]=this.uo_10
this.Control[iCurrent+8]=this.uo_9
this.Control[iCurrent+9]=this.uo_8
this.Control[iCurrent+10]=this.uo_7
this.Control[iCurrent+11]=this.uo_6
this.Control[iCurrent+12]=this.uo_5
this.Control[iCurrent+13]=this.uo_4
this.Control[iCurrent+14]=this.uo_3
this.Control[iCurrent+15]=this.uo_2
this.Control[iCurrent+16]=this.uo_1
this.Control[iCurrent+17]=this.uo_15
this.Control[iCurrent+18]=this.pb_cancel
end on

on w_dt_causes_other.destroy
call super::destroy
destroy(this.uo_17)
destroy(this.uo_16)
destroy(this.uo_14)
destroy(this.uo_13)
destroy(this.uo_12)
destroy(this.uo_11)
destroy(this.uo_10)
destroy(this.uo_9)
destroy(this.uo_8)
destroy(this.uo_7)
destroy(this.uo_6)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.uo_15)
destroy(this.pb_cancel)
end on

type uo_17 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 1499
integer y = 557
integer width = 713
integer height = 115
integer taborder = 100
integer ii_downtime_reason_id = 40
string caption = "       STENCIL"
end type

on uo_17.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_16 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 1499
integer y = 426
integer width = 713
integer height = 115
integer taborder = 90
integer ii_downtime_reason_id = 37
string caption = "        MTL QUALITY"
end type

on uo_16.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_14 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 1499
integer y = 294
integer width = 713
integer height = 115
integer taborder = 80
integer ii_downtime_reason_id = 34
string caption = "        REBAND"
end type

on uo_14.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_13 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 1499
integer y = 163
integer width = 713
integer height = 115
integer taborder = 70
integer ii_downtime_reason_id = 31
string caption = "        SYSTEMS"
end type

on uo_13.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_12 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 1499
integer y = 32
integer width = 713
integer height = 115
integer taborder = 60
integer ii_downtime_reason_id = 28
string caption = "        WOODROOM"
end type

on uo_12.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_11 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 779
integer y = 32
integer width = 713
integer height = 115
integer taborder = 50
integer ii_downtime_reason_id = 27
string caption = "        MANPOWER"
end type

on uo_11.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_10 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 779
integer y = 163
integer width = 713
integer height = 115
integer taborder = 60
integer ii_downtime_reason_id = 30
string caption = "        PROD CONTROL"
end type

on uo_10.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_9 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 779
integer y = 294
integer width = 713
integer height = 115
integer taborder = 70
integer ii_downtime_reason_id = 33
string caption = "       MEETING"
end type

on uo_9.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_8 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 779
integer y = 426
integer width = 713
integer height = 115
integer taborder = 80
integer ii_downtime_reason_id = 36
string caption = "        CUST SERVICE"
end type

on uo_8.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_7 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 779
integer y = 557
integer width = 713
integer height = 115
integer taborder = 90
integer ii_downtime_reason_id = 39
string caption = "        SHORT PCS"
end type

on uo_7.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_6 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 779
integer y = 688
integer width = 713
integer height = 115
integer taborder = 100
integer ii_downtime_reason_id = 42
string caption = "        STACKING"
end type

on uo_6.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_5 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 62
integer y = 688
integer width = 713
integer height = 115
integer taborder = 90
integer ii_downtime_reason_id = 41
string caption = "        PACKAGING ON LINE"
end type

on uo_5.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_4 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 62
integer y = 557
integer width = 713
integer height = 115
integer taborder = 80
integer ii_downtime_reason_id = 38
string caption = "        PWR OUTAGE"
end type

on uo_4.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_3 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 62
integer y = 426
integer width = 713
integer height = 115
integer taborder = 70
integer ii_downtime_reason_id = 35
string caption = "        DEFECT SUPPLIES"
end type

on uo_3.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_2 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 62
integer y = 294
integer width = 713
integer height = 115
integer taborder = 60
integer ii_downtime_reason_id = 32
string caption = "        HOUSEKEEPING"
end type

on uo_2.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_1 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 62
integer y = 163
integer width = 713
integer height = 115
integer taborder = 50
integer ii_downtime_reason_id = 29
string caption = "        SHIPPING/REC"
end type

on uo_1.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type uo_15 from u_downtimebutton within w_dt_causes_other
event destroy ( )
string tag = "dt"
integer x = 62
integer y = 32
integer width = 713
integer height = 115
integer taborder = 40
integer ii_downtime_reason_id = 26
string caption = "        INSPECTION"
end type

on uo_15.destroy
call u_downtimebutton::destroy
end on

event clicked;call super::clicked;iu_dt_cause_tabpg.f_dt_process(this)
Close(parent)
end event

type pb_cancel from u_pb within w_dt_causes_other
integer x = 1499
integer y = 688
integer width = 713
integer height = 115
integer taborder = 110
integer textsize = -12
string facename = "Arial"
string text = "Cancel"
end type

event clicked;call super::clicked;Close(parent)
end event

