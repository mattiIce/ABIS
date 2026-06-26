$PBExportHeader$w_coil_ownership_transfer_certificate.srw
forward
global type w_coil_ownership_transfer_certificate from w_sheet
end type
type cb_3 from u_cb within w_coil_ownership_transfer_certificate
end type
type cb_2 from commandbutton within w_coil_ownership_transfer_certificate
end type
type cb_1 from commandbutton within w_coil_ownership_transfer_certificate
end type
type cb_barcode from commandbutton within w_coil_ownership_transfer_certificate
end type
type dw_coil_ownership_transfer_certificate from u_dw within w_coil_ownership_transfer_certificate
end type
end forward

global type w_coil_ownership_transfer_certificate from w_sheet
integer width = 4118
integer height = 3146
string title = "Transfer Of Coil Ownership Certificate"
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_barcode cb_barcode
dw_coil_ownership_transfer_certificate dw_coil_ownership_transfer_certificate
end type
global w_coil_ownership_transfer_certificate w_coil_ownership_transfer_certificate

on w_coil_ownership_transfer_certificate.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_barcode=create cb_barcode
this.dw_coil_ownership_transfer_certificate=create dw_coil_ownership_transfer_certificate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_barcode
this.Control[iCurrent+5]=this.dw_coil_ownership_transfer_certificate
end on

on w_coil_ownership_transfer_certificate.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_barcode)
destroy(this.dw_coil_ownership_transfer_certificate)
end on

event open;call super::open;Long		ll_rows, ll_certificate_num
Boolean	lb_this_window_open

ll_certificate_num = Message.DoubleParm
This.Title = This.Title + " Number: " + String(ll_certificate_num)

//Check if this window is already open.
lb_this_window_open = f_window_open(This.Title)

If lb_this_window_open Then //Window open
	Close(This) //Close this window
	Return
End If

dw_coil_ownership_transfer_certificate.SetTransObject(sqlca)
ll_rows = dw_coil_ownership_transfer_certificate.Retrieve(ll_certificate_num)

//If ll_rows > 0 Then
//	This.Title = This.Title + " Number: " + String(ll_certificate_num)
//End If
end event

type cb_3 from u_cb within w_coil_ownership_transfer_certificate
integer x = 3657
integer y = 470
integer width = 369
integer height = 106
integer taborder = 40
boolean bringtotop = true
string facename = "Arial"
string text = "Unselect All"
end type

event clicked;call super::clicked;If This.Text = "Select All" Then
	dw_coil_ownership_transfer_certificate.SelectRow(0, True)
	This.Text = "Unselect All"
Else
	dw_coil_ownership_transfer_certificate.SelectRow(0, False)
	This.Text = "Select All"
End if
end event

type cb_2 from commandbutton within w_coil_ownership_transfer_certificate
integer x = 3657
integer y = 1117
integer width = 369
integer height = 106
integer taborder = 40
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

type cb_1 from commandbutton within w_coil_ownership_transfer_certificate
integer x = 3657
integer y = 269
integer width = 369
integer height = 106
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print Certificate"
end type

event clicked;dw_coil_ownership_transfer_certificate.Event pfc_print()
end event

type cb_barcode from commandbutton within w_coil_ownership_transfer_certificate
integer x = 3657
integer y = 77
integer width = 369
integer height = 106
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print Barcodes"
end type

event clicked;String							ls_coil_abs_num
Long								ll_rows
Integer							li_rtn
s_coil_owneship_transfer	lstr_coil_owneship_transfer

ll_rows = dw_coil_ownership_transfer_certificate.RowCount()

If ll_rows > 0 Then
	lstr_coil_owneship_transfer.coil_owneship_transfer = dw_coil_ownership_transfer_certificate
	
	//Open barcode window
	
	//Alex Gerlants. 08/02/2017. Begin
	//Chris Beamer wanted to print in this sequence
	li_rtn = dw_coil_ownership_transfer_certificate.SetSort("coil_abc_num_orig Asc")
	li_rtn = dw_coil_ownership_transfer_certificate.Sort()
	//Alex Gerlants. 08/02/2017. End
																				 
	li_rtn = OpenSheetWithParm(w_report_coil_ownership_transfer, lstr_coil_owneship_transfer, &
				 																gnv_app.of_getframe(), 0, Original!)
																				 
Else
	MessageBox("Nothing to print", "There are no coils to print barcode for")																				
End If

end event

type dw_coil_ownership_transfer_certificate from u_dw within w_coil_ownership_transfer_certificate
integer y = 77
integer width = 3569
integer height = 2918
integer taborder = 10
string dataobject = "d_coil_ownership_transfer_certificate"
end type

event constructor;call super::constructor;//Set up sort and select service
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle(2)
end event

event clicked;//Override pfc's clicked because it is running on wrong sequence
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

event retrieveend;call super::retrieveend;//Select all rows so user can print barcode for all new coils
Long	ll_rows, ll_row

ll_rows = This.RowCount()

For ll_row = 1 To ll_rows
	This.SelectRow(ll_row, True)
Next
end event

