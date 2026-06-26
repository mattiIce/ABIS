$PBExportHeader$w_bol.srw
forward
global type w_bol from w_sheet
end type
type st_1 from statictext within w_bol
end type
type cb_coil from commandbutton within w_bol
end type
type cb_print from commandbutton within w_bol
end type
type cb_close from commandbutton within w_bol
end type
type dw_bol from u_dw within w_bol
end type
end forward

global type w_bol from w_sheet
integer x = 366
integer y = 179
integer width = 1573
integer height = 1373
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 82042848
event type integer ue_showcoil ( )
st_1 st_1
cb_coil cb_coil
cb_print cb_print
cb_close cb_close
dw_bol dw_bol
end type
global w_bol w_bol

type variables
long il_customer_id
end variables

event type integer ue_showcoil();Int li_cr, li_return, li_r
Long ll_edi_file_id
String ls_bol
s_edi_file_id_and_bol lds_edi_file_id_and_bol

li_cr = dw_bol.GetRow()
IF li_cr <= 0 THEN return 0
ll_edi_file_id = dw_bol.GetItemNumber(li_cr, 'edi_file_id', Primary!, FALSE)
ls_bol = dw_bol.GetItemString(li_cr, 'bol', Primary!, FALSE)
lds_edi_file_id_and_bol.edi_file_id = ll_edi_file_id
lds_edi_file_id_and_bol.bol = ls_bol
lds_edi_file_id_and_bol.customer_id = il_customer_id

OpenWithParm(w_coil_list_by_bol, lds_edi_file_id_and_bol)
dw_bol.Retrieve(il_customer_id)

dw_bol.SetFocus()
dw_bol.ScrollToRow(1)
return 1

end event

on w_bol.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_coil=create cb_coil
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_bol=create dw_bol
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_coil
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_bol
end on

on w_bol.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_coil)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_bol)
end on

event open;call super::open;il_customer_id = Message.DoubleParm

SetPointer(HourGlass!)
dw_bol.SetTransObject(sqlca)

dw_bol.Retrieve(il_customer_id)

end event

event pfc_close;call super::pfc_close;CloseWithReturn(this, 1)
end event

type st_1 from statictext within w_bol
integer x = 154
integer y = 35
integer width = 450
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Available BOL list:"
boolean focusrectangle = false
end type

type cb_coil from commandbutton within w_bol
integer x = 1097
integer y = 294
integer width = 289
integer height = 93
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Show Coil"
end type

event clicked;parent.event ue_showcoil()
end event

type cb_print from commandbutton within w_bol
integer x = 1104
integer y = 560
integer width = 274
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Print"
end type

event clicked;dw_bol.event pfc_print()
end event

type cb_close from commandbutton within w_bol
integer x = 1097
integer y = 819
integer width = 274
integer height = 93
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;parent.event pfc_close()
end event

type dw_bol from u_dw within w_bol
integer x = 154
integer y = 138
integer width = 724
integer height = 986
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bol"
boolean hscrollbar = true
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event doubleclicked;/*
s_edi_file_id_and_bol lds_edi_file_id_and_bol
String ls_bol
Long ll_edi_file_id
Int li_return

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

ls_bol = this.GetItemString(row, "bol", Primary!, FALSE)
ll_edi_file_id = dw_bol.GetItemNumber(row, 'edi_file_id', Primary!, FALSE)
lds_edi_file_id_and_bol.edi_file_id = ll_edi_file_id
lds_edi_file_id_and_bol.bol = ls_bol

/*
transaction dboconnect
dboconnect = create transaction
dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
dboconnect.LogID = gs_LogID
dboconnect.LogPass = gs_LogPass
connect using dboconnect;
if dboconnect.SQLCode<0 then 
	MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
   return -1
end if

DECLARE st_fn procedure for f_create_inbound_sh_status (:ll_edi_file_id,:ls_bol) using dboconnect;
execute st_fn;
if dboconnect.SQLCode < 0 then 
	MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
	return -1
end if
fetch st_fn INTO :li_return; 
close st_fn;

disconnect using dboconnect;
destroy dboconnect;
*/
OpenWithParm(w_coil_list_by_bol, lds_edi_file_id_and_bol)

dw_bol.Retrieve()
dw_bol.SetFocus()
dw_bol.ScrollToRow(1)


*/
end event

event clicked;call super::clicked;//Override pfc_clicked

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

