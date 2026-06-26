$PBExportHeader$w_dimensional_check_new_skid.srw
forward
global type w_dimensional_check_new_skid from w_popup
end type
type cb_save from commandbutton within w_dimensional_check_new_skid
end type
type st_1 from statictext within w_dimensional_check_new_skid
end type
type cb_cancel from commandbutton within w_dimensional_check_new_skid
end type
type cb_ok from commandbutton within w_dimensional_check_new_skid
end type
type dw_dim from u_dw within w_dimensional_check_new_skid
end type
end forward

global type w_dimensional_check_new_skid from w_popup
integer width = 1872
integer height = 1162
cb_save cb_save
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_dim dw_dim
end type
global w_dimensional_check_new_skid w_dimensional_check_new_skid

type variables
//long il_skid_num
//long il_shift_id
//u_da_skid_scrap_tabpg iu_da_skid_scrap_tabpg
s_dim_check istr_dim_check
end variables

on w_dimensional_check_new_skid.create
int iCurrent
call super::create
this.cb_save=create cb_save
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_dim=create dw_dim
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_save
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.dw_dim
end on

on w_dimensional_check_new_skid.destroy
call super::destroy
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_dim)
end on

event open;call super::open;//il_skid_num = 200000
//dw_dim.of_retrieve( )

//iu_da_skid_scrap_tabpg = message.powerobjectparm
//if iu_da_skid_scrap_tabpg.ids_dim_check.rowcount( ) = 1 then
//	// istr_dim_check = iu_da_skid_scrap_tabpt.ids_dim_check.object.data[1]
//	 //dw_dim.insertrow( 0 )
//	 //dw_dim.object.data[1] = istr_dim_check
//	 iu_da_skid_scrap_tabpg.ids_dim_check.sharedata( dw_dim )
//end if
end event

type cb_save from commandbutton within w_dimensional_check_new_skid
integer x = 55
integer y = 701
integer width = 600
integer height = 128
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;//IF dw_dim.Event pfc_Update &
//(TRUE, TRUE) = 1 THEN
//SQLCA.of_Commit()
//ELSE
//SQLCA.of_Rollback()
//END IF
//if isValid( iu_da_skid_scrap_tabpg ) then
//	if isValid( iu_da_skid_scrap_tabpg.ids_dim_check ) then
//		istr_dim_check = dw_dim.object.Data[1]
//		iu_da_skid_scrap_tabpg.ids_dim_check.object.data[1] = istr_dim_check
//	end if
//end if

//dw_dim.accepttext( )
//iu_da_skid_scrap_tabpg.dw_current_skid.object.dim_check_status[ 1 ] = &
//dw_dim.object.in_spec[ 1 ]
//

end event

type st_1 from statictext within w_dimensional_check_new_skid
integer x = 37
integer y = 19
integer width = 1200
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please enter Dimensional check data"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_dimensional_check_new_skid
integer x = 1145
integer y = 701
integer width = 600
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Close( parent )
end event

type cb_ok from commandbutton within w_dimensional_check_new_skid
integer x = 55
integer y = 902
integer width = 1693
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;//if isValid( iu_da_skid_scrap_tabpg ) then
//	if isValid( iu_da_skid_scrap_tabpg.ids_dim_check ) then
//		istr_dim_check = dw_dim.object.Data[1]
//		iu_da_skid_scrap_tabpg.ids_dim_check.object.data[1] = istr_dim_check
//	end if
//end if
//dw_dim.accepttext( )
//iu_da_skid_scrap_tabpg.dw_current_skid.object.dim_check_status[ 1 ] = &
//dw_dim.object.in_spec[ 1 ]
//
Close(parent)
end event

type dw_dim from u_dw within w_dimensional_check_new_skid
integer x = 22
integer y = 128
integer width = 1796
integer height = 512
integer taborder = 10
string dataobject = "d_skid_dim_check"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalculator(TRUE)
this.iuo_calculator.of_Register("gauge", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("width", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("square", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("length_oper", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("length_drive", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("head_dimension", &
this.iuo_calculator.NONE)

this.iuo_calculator.of_SetCloseOnClick(True)
this.iuo_calculator.of_SetInitialValue(TRUE)
this.of_setbase( true)
//this.of_settransobject( sqlca)

end event

