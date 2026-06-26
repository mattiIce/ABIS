$PBExportHeader$u_da_offline_downtime_tabpg.sru
forward
global type u_da_offline_downtime_tabpg from u_tabpg
end type
type cb_retrieve from u_cb within u_da_offline_downtime_tabpg
end type
type cb_save from u_cb within u_da_offline_downtime_tabpg
end type
type cb_delete from u_cb within u_da_offline_downtime_tabpg
end type
type cb_add from u_cb within u_da_offline_downtime_tabpg
end type
type st_1 from statictext within u_da_offline_downtime_tabpg
end type
type dw_downtime from u_dw within u_da_offline_downtime_tabpg
end type
type st_4 from statictext within u_da_offline_downtime_tabpg
end type
end forward

global type u_da_offline_downtime_tabpg from u_tabpg
integer width = 2765
integer height = 1626
long backcolor = 8421376
string text = "DOWNTIME"
long tabbackcolor = 8421376
boolean ib_isupdateable = false
cb_retrieve cb_retrieve
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
st_1 st_1
dw_downtime dw_downtime
st_4 st_4
end type
global u_da_offline_downtime_tabpg u_da_offline_downtime_tabpg

type variables
//u_causes iu_causes
//powerobject ipo_handler
//time it_window_open_time
//int ii_min
//n_tmg itmg_1_min
//w_da_offline_sheet  iw_sheet
uo_shift iu_shift
long il_shift_id, il_job_id
end variables

on u_da_offline_downtime_tabpg.create
int iCurrent
call super::create
this.cb_retrieve=create cb_retrieve
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.st_1=create st_1
this.dw_downtime=create dw_downtime
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_retrieve
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_downtime
this.Control[iCurrent+7]=this.st_4
end on

on u_da_offline_downtime_tabpg.destroy
call super::destroy
destroy(this.cb_retrieve)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.st_1)
destroy(this.dw_downtime)
destroy(this.st_4)
end on

event constructor;call super::constructor;//MessageBox("cause page", "constructor")
//this.text = "Downtime causes"
//itmg_1_min = create n_tmg
//itmg_1_min.of_setsingle( true)
//itmg_1_min.inv_single.of_register( this, "ue_1_min_timing", 60)
//ii_min = 0
iu_shift = message.powerobjectparm

dw_downtime.of_SetDropDownCalculator(TRUE)
dw_downtime.iuo_calculator.of_Register("count", &
dw_downtime.iuo_calculator.NONE)
dw_downtime.iuo_calculator.of_Register("compute_0006", &
dw_downtime.iuo_calculator.NONE)

dw_downtime.iuo_calculator.of_SetCloseOnClick(True)
dw_downtime.iuo_calculator.of_SetInitialValue(TRUE)
dw_downtime.of_setbase( true)
dw_downtime.of_settransobject( sqlca)
dw_downtime.of_retrieve( )
dw_downtime.inv_base.of_populatedddw( )


end event

event destructor;call super::destructor;//destroy itmg_1_min
////ipo_handler.postevent("ue_downtime_processing", 0, 0)
if dw_downtime.of_updatespending( ) = 1 then
	if MessageBox("Downtime", "Data changed, Save it?", Exclamation!, YesNo!, 2) = 2 then
				dw_downtime.resetupdate( )
				return 0
	end if
	cb_save.event clicked( )
end if
return 0
end event

type cb_retrieve from u_cb within u_da_offline_downtime_tabpg
integer x = 1507
integer y = 1485
integer width = 351
integer height = 93
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;call super::clicked;dw_downtime.of_retrieve( )
end event

type cb_save from u_cb within u_da_offline_downtime_tabpg
integer x = 2063
integer y = 1485
integer width = 351
integer height = 93
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Save"
end type

event clicked;call super::clicked;long ll_rc
dw_downtime.accepttext( )
//ll_rc = dw_downtime.of_update( true, true)

ll_rc = dw_downtime.event pfc_update( true, true)

if ll_rc = 1 then
	sqlca.of_commit( )
else
	sqlca.of_rollback( )
	messageBox("sqlca", "Update failed " + string(ll_rc))
end if
end event

type cb_delete from u_cb within u_da_offline_downtime_tabpg
integer x = 951
integer y = 1485
integer width = 351
integer height = 93
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Delete"
end type

event clicked;call super::clicked;long ll_row
ll_row = dw_downtime.getrow( )
if ll_row > 0 then
	dw_downtime.deleterow( ll_row)
end if
end event

type cb_add from u_cb within u_da_offline_downtime_tabpg
integer x = 395
integer y = 1485
integer width = 351
integer height = 93
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Add"
end type

event clicked;call super::clicked;long ll_row, ll_job
ll_job = iu_shift.get_current_job( )
if isNull( ll_job ) or ll_job < 1000 then
	of_messagebox( "id_no_job", "Add downtime cause", "No job number, please load coil first!", StopSign!, OK!, 1)
	return 1
end if
ll_row = dw_downtime.insertrow( 0 )
dw_downtime.object.shift_num[ll_row] = iu_shift.get_shift_id( )
dw_downtime.object.ab_job_num[ll_row] = ll_job
dw_downtime.object.count[ll_row] = 1
return 1
end event

type st_1 from statictext within u_da_offline_downtime_tabpg
integer x = 834
integer y = 26
integer width = 1039
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 8421376
string text = "Downtime instance for current Job"
boolean focusrectangle = false
end type

type dw_downtime from u_dw within u_da_offline_downtime_tabpg
integer x = 15
integer y = 115
integer width = 2736
integer height = 1318
integer taborder = 10
string dataobject = "d_downtime_offline"
end type

event pfc_retrieve;call super::pfc_retrieve;long ll_shift
ll_shift = iu_shift.get_shift_id()
return retrieve( ll_shift )
end event

event itemchanged;call super::itemchanged;long ll_value, ll_job, ll_i, ll_rc

choose case dwo.Name
	case "compute_0006"
		ll_value = Long(data)
		this.object.duration[row] = ll_value * 60
	case "id"
		ll_value = Long(data)
		ll_job = this.object.ab_job_num[row]
		ll_rc = this.rowcount( )
		for ll_i=1 to ll_rc
			if this.object.ab_job_num[ll_i] = ll_job and this.object.id[ll_i] = ll_value then
					MessageBox("Error", "Downtime cause already exist, please choose different cause!")
					return 1
			end if
		next
end choose

return 0

//if dwo.Name = "compute_0006" then 
//	
////	MessageBox("v", string(this.object.duration[row]))
//end if
end event

event clicked;call super::clicked;if row > 0 then
	this.selectrow( 0, false)
	this.selectrow( row, true)
end if
end event

event sqlpreview;call super::sqlpreview;//MessageBox(string(request),string(sqltype) + "-" + string(sqlsyntax) + "-" + string(buffer) + "-"+ string(row)   )
sleep(1)
end event

event pfc_update;CALL SUPER::pfc_update
return ancestorReturnValue
end event

event itemerror;call super::itemerror;return 1
end event

type st_4 from statictext within u_da_offline_downtime_tabpg
integer x = 5665
integer y = 1811
integer width = 293
integer height = 90
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15780518
string text = "Ended"
boolean focusrectangle = false
end type

