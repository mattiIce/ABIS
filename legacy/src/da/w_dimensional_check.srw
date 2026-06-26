$PBExportHeader$w_dimensional_check.srw
forward
global type w_dimensional_check from w_popup
end type
type cb_2 from commandbutton within w_dimensional_check
end type
type st_1 from statictext within w_dimensional_check
end type
type cb_cancel from commandbutton within w_dimensional_check
end type
type cb_ok from commandbutton within w_dimensional_check
end type
type dw_dim from u_dw within w_dimensional_check
end type
end forward

global type w_dimensional_check from w_popup
integer width = 1851
integer height = 1164
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
cb_2 cb_2
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_dim dw_dim
end type
global w_dimensional_check w_dimensional_check

type variables
long il_skid_num
long il_shift_id
end variables

on w_dimensional_check.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_dim=create dw_dim
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.dw_dim
end on

on w_dimensional_check.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_dim)
end on

event open;call super::open;long ll_row
il_skid_num = message.doubleparm
dw_dim.of_retrieve( )
if dw_dim.rowcount( ) < 1 then
	ll_row = dw_dim.insertrow( 0 )
	dw_dim.object.sheet_skid_num[ ll_row ] = il_skid_num
	dw_dim.object.pc_number[ll_row] = 1
end if
end event

type cb_2 from commandbutton within w_dimensional_check
integer x = 50
integer y = 720
integer width = 731
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

event clicked;//MessageBox("validation", string(dw_dim.of_validation( )))
int li_rc
li_rc = dw_dim.of_validation( )
if li_rc = 1 then
	IF dw_dim.Event pfc_Update(TRUE, TRUE) = 1 THEN
		//MessageBox( "pfc_update", "return 1"  )
		SQLCA.of_Commit()
	ELSE
		//MessageBox( "pfc_update", "return else"  )
		SQLCA.of_Rollback()
	END IF
end if
end event

type st_1 from statictext within w_dimensional_check
integer x = 37
integer y = 20
integer width = 1202
integer height = 76
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

type cb_cancel from commandbutton within w_dimensional_check
integer x = 1061
integer y = 720
integer width = 731
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

event clicked;dw_dim.reset( )
dw_dim.resetupdate( )
Close(parent)
end event

type cb_ok from commandbutton within w_dimensional_check
integer x = 50
integer y = 924
integer width = 1746
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;int li_rc
li_rc = dw_dim.of_validation( )

if li_rc = 1 then

	IF dw_dim.Event pfc_Update(TRUE, TRUE) = 1 THEN
		SQLCA.of_Commit()
		//Close(parent)
	ELSE
		SQLCA.of_Rollback()
	END IF
	Close(parent)
end if
end event

type dw_dim from u_dw within w_dimensional_check
integer x = 23
integer y = 128
integer width = 1797
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
this.of_settransobject( sqlca)

end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_skid_num )
end event

