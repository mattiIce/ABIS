$PBExportHeader$u_da_shift_coils_tabpg.sru
forward
global type u_da_shift_coils_tabpg from u_tabpg
end type
type st_15 from statictext within u_da_shift_coils_tabpg
end type
type st_14 from statictext within u_da_shift_coils_tabpg
end type
type st_13 from statictext within u_da_shift_coils_tabpg
end type
type st_12 from statictext within u_da_shift_coils_tabpg
end type
type st_11 from statictext within u_da_shift_coils_tabpg
end type
type st_10 from statictext within u_da_shift_coils_tabpg
end type
type dw_shift_coil from u_dw within u_da_shift_coils_tabpg
end type
type dw_process_coil from u_dw within u_da_shift_coils_tabpg
end type
end forward

global type u_da_shift_coils_tabpg from u_tabpg
integer width = 3727
integer height = 1702
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
dw_shift_coil dw_shift_coil
dw_process_coil dw_process_coil
end type
global u_da_shift_coils_tabpg u_da_shift_coils_tabpg

type variables
string is_title
end variables

on u_da_shift_coils_tabpg.create
int iCurrent
call super::create
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.dw_shift_coil=create dw_shift_coil
this.dw_process_coil=create dw_process_coil
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_15
this.Control[iCurrent+2]=this.st_14
this.Control[iCurrent+3]=this.st_13
this.Control[iCurrent+4]=this.st_12
this.Control[iCurrent+5]=this.st_11
this.Control[iCurrent+6]=this.st_10
this.Control[iCurrent+7]=this.dw_shift_coil
this.Control[iCurrent+8]=this.dw_process_coil
end on

on u_da_shift_coils_tabpg.destroy
call super::destroy
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.dw_shift_coil)
destroy(this.dw_process_coil)
end on

event constructor;call super::constructor;dw_process_coil.of_settransobject( sqlca)
dw_shift_coil.of_settransobject( sqlca)
end event

type st_15 from statictext within u_da_shift_coils_tabpg
integer x = 731
integer y = 678
integer width = 190
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 67108864
string text = "Done"
boolean focusrectangle = false
end type

type st_14 from statictext within u_da_shift_coils_tabpg
integer x = 731
integer y = 589
integer width = 190
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711935
long backcolor = 67108864
string text = "Onhold"
boolean focusrectangle = false
end type

type st_13 from statictext within u_da_shift_coils_tabpg
integer x = 731
integer y = 512
integer width = 249
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Rebanded"
boolean focusrectangle = false
end type

type st_12 from statictext within u_da_shift_coils_tabpg
integer x = 731
integer y = 422
integer width = 190
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "Reject"
boolean focusrectangle = false
end type

type st_11 from statictext within u_da_shift_coils_tabpg
integer x = 731
integer y = 333
integer width = 205
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65280
long backcolor = 67108864
string text = "Running"
boolean focusrectangle = false
end type

type st_10 from statictext within u_da_shift_coils_tabpg
integer x = 731
integer y = 243
integer width = 190
integer height = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Waiting"
boolean focusrectangle = false
end type

type dw_shift_coil from u_dw within u_da_shift_coils_tabpg
integer y = 934
integer width = 1024
integer height = 755
integer taborder = 40
string dataobject = "d_shift_coil"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//this.of_setdropdowncalculator( true)
//this.iuo_calculator.of_register("shift_coil_coil_end_wt", this.iuo_calculator.none )
//this.iuo_calculator.of_setcloseonclick( true)
//this.iuo_calculator.of_setinitialvalue( true)
this.of_settransobject( sqlca)

end event

event clicked;call super::clicked;if row > 0 then
	this.selectrow( 0, false)
	this.selectrow( row, true)
end if
end event

event itemchanged;call super::itemchanged;//if row > 0 then
//	if dwo.Name = "shift_coil_coil_end_wt" then
//		long ll_end_wt, ll_process_wt, ll_init_wt, ll_shift
//		int li_run
//		ll_end_wt = Long(data)
//		ll_init_wt = this.object.shift_coil_coil_begin_wt[row]		
//		ll_process_wt = ll_init_wt - ll_end_wt
//		ll_shift = this.object.shift_coil_shift_num[row]
//		li_run = this.object.shift_coil_coil_run_num[row]
//		  
//		  UPDATE "SHIFT_COIL"  
//     		SET "COIL_BEGIN_WT" = :ll_init_wt,   
//         "COIL_END_WT" = :ll_end_wt,   
//         "PROCESS_WT" = :ll_process_wt  
//   WHERE ( "SHIFT_COIL"."SHIFT_NUM" = :ll_shift ) AND  
//         ( "SHIFT_COIL"."COIL_RUN_NUM" =:li_run  )   ;
//		if sqlca.sqlcode <> 0 then
//			sqlca.of_rollback( )
//			return 1
//		else
//			sqlca.of_commit( )
//		end if
//		this.object.shift_coil_process_wt[row] = ll_process_wt
//			return 0
//	else
//		return 1
//	end if
//end if
end event

type dw_process_coil from u_dw within u_da_shift_coils_tabpg
integer y = 102
integer width = 644
integer height = 819
integer taborder = 30
string dataobject = "d_process_coil"
end type

