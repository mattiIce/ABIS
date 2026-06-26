$PBExportHeader$w_ff_data_4coil.srw
forward
global type w_ff_data_4coil from w_sheet
end type
type cb_close from commandbutton within w_ff_data_4coil
end type
type cb_print from commandbutton within w_ff_data_4coil
end type
type dw_ff_data_4coil from u_dw within w_ff_data_4coil
end type
end forward

global type w_ff_data_4coil from w_sheet
integer width = 3021
integer height = 2208
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_close cb_close
cb_print cb_print
dw_ff_data_4coil dw_ff_data_4coil
end type
global w_ff_data_4coil w_ff_data_4coil

on w_ff_data_4coil.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_ff_data_4coil=create dw_ff_data_4coil
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.dw_ff_data_4coil
end on

on w_ff_data_4coil.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_ff_data_4coil)
end on

event open;call super::open;Long	ll_coil_abc_num, ll_rows

ll_coil_abc_num = Message.DoubleParm

dw_ff_data_4coil.SetTransObject(sqlca)
ll_rows = dw_ff_data_4coil.Retrieve(ll_coil_abc_num)
end event

type cb_close from commandbutton within w_ff_data_4coil
integer x = 1715
integer y = 2006
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type cb_print from commandbutton within w_ff_data_4coil
integer x = 936
integer y = 2006
integer width = 322
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;dw_ff_data_4coil.Event pfc_print()
end event

type dw_ff_data_4coil from u_dw within w_ff_data_4coil
integer width = 2977
integer height = 1942
integer taborder = 10
string dataobject = "d_ff_data_4coil"
end type

event clicked;call super::clicked;String 	ls_old_sort, ls_column, ls_name
Char 		lc_sort

ls_name = dwo.Name

/* Check whether the user clicks on the column header */
If Right(ls_name, 2) = '_t' Then
	ls_column = Left(dwo.Name, Len(String(dwo.Name)) - 2)

	/* Get old sort, If any. */
	ls_old_sort = This.Describe("Datawindow.Table.sort")

	//Check whether previously sorted column and currently clicked column are same or not. 
	//If both are same, check for the sort order of previously sorted column (A - Asc, D - Des) and change it. 
	//If both are not same, simply sort it by Ascending order.
	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then 
		lc_sort = Right(ls_old_sort, 1)

		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		  
		This.SetSort(ls_column + " " + lc_sort)
	Else
		This.SetSort(ls_column + " A")
	End If

	This.Sort()
End If
end event

