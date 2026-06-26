$PBExportHeader$u_tabpg_login.sru
forward
global type u_tabpg_login from u_tabpg
end type
type cb_reverse_coil from u_cb within u_tabpg_login
end type
type st_1 from statictext within u_tabpg_login
end type
type cbx_stacker from u_cbx within u_tabpg_login
end type
type cbx_barcode from u_cbx within u_tabpg_login
end type
type cb_apply from u_cb within u_tabpg_login
end type
type st_2 from statictext within u_tabpg_login
end type
type cbx_scrap from u_cbx within u_tabpg_login
end type
type st_3 from statictext within u_tabpg_login
end type
type cbx_scale from u_cbx within u_tabpg_login
end type
type gb_scale from groupbox within u_tabpg_login
end type
type gb_scan from groupbox within u_tabpg_login
end type
type gb_stacker from groupbox within u_tabpg_login
end type
type gb_1 from groupbox within u_tabpg_login
end type
end forward

global type u_tabpg_login from u_tabpg
integer width = 3599
integer height = 1347
long backcolor = 134217752
cb_reverse_coil cb_reverse_coil
st_1 st_1
cbx_stacker cbx_stacker
cbx_barcode cbx_barcode
cb_apply cb_apply
st_2 st_2
cbx_scrap cbx_scrap
st_3 st_3
cbx_scale cbx_scale
gb_scale gb_scale
gb_scan gb_scan
gb_stacker gb_stacker
gb_1 gb_1
end type
global u_tabpg_login u_tabpg_login

type variables
w_operation_panel iw_operation_panel
end variables

on u_tabpg_login.create
int iCurrent
call super::create
this.cb_reverse_coil=create cb_reverse_coil
this.st_1=create st_1
this.cbx_stacker=create cbx_stacker
this.cbx_barcode=create cbx_barcode
this.cb_apply=create cb_apply
this.st_2=create st_2
this.cbx_scrap=create cbx_scrap
this.st_3=create st_3
this.cbx_scale=create cbx_scale
this.gb_scale=create gb_scale
this.gb_scan=create gb_scan
this.gb_stacker=create gb_stacker
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reverse_coil
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cbx_stacker
this.Control[iCurrent+4]=this.cbx_barcode
this.Control[iCurrent+5]=this.cb_apply
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cbx_scrap
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cbx_scale
this.Control[iCurrent+10]=this.gb_scale
this.Control[iCurrent+11]=this.gb_scan
this.Control[iCurrent+12]=this.gb_stacker
this.Control[iCurrent+13]=this.gb_1
end on

on u_tabpg_login.destroy
call super::destroy
destroy(this.cb_reverse_coil)
destroy(this.st_1)
destroy(this.cbx_stacker)
destroy(this.cbx_barcode)
destroy(this.cb_apply)
destroy(this.st_2)
destroy(this.cbx_scrap)
destroy(this.st_3)
destroy(this.cbx_scale)
destroy(this.gb_scale)
destroy(this.gb_scan)
destroy(this.gb_stacker)
destroy(this.gb_1)
end on

event constructor;call super::constructor;iw_operation_panel = message.powerobjectparm
//em_password.of_setdropdowncalculator( true)
//em_password.iuo_calculator.of_setcloseonclick( true)
//em_password.iuo_calculator.of_setinitialvalue( true)
cbx_scale.checked = iw_operation_panel.iw_da_sheet.ib_skid_scale_connected
cbx_scrap.checked = iw_operation_panel.iw_da_sheet.ib_scrap_scale_connected
cbx_barcode.checked = iw_operation_panel.iw_da_sheet.ib_scanner_connected
cbx_stacker.checked = iw_operation_panel.iw_da_sheet.ib_stacker_online

if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil) then
	if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( )) and isValid(iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_tab_page( )) then
		if iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_skid_tab_page( ).dw_skid_item.rowcount( ) < 1 and iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_tab_page( ).dw_scrap.rowcount( ) < 1 then &
				cb_reverse_coil.enabled = true
	end if
end if

//cb_reverse_coil.enabled = isValid( iw_operation_panel.iw_da_sheet.iu_current_coil )
end event

type cb_reverse_coil from u_cb within u_tabpg_login
integer x = 2381
integer y = 592
integer width = 870
integer height = 195
integer taborder = 20
integer textsize = -14
string facename = "Arial"
boolean enabled = false
string text = "Reverse current coil"
end type

event clicked;call super::clicked;if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil) then
	if this.of_messagebox( "id_reverse_coil", "Confirm reverse", "Do you want to reverse current coil?", Question!, YesNo!, 2) = 1 then
		//iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_coi_job_tabpg( ).cb_reverse.event clicked( )
		if isValid( iw_operation_panel.iw_da_sheet.iuo_shift ) then
			iw_operation_panel.iw_da_sheet.iuo_shift.postevent( "ue_drop_current_coil")
		end if
	end if
end if
end event

type st_1 from statictext within u_tabpg_login
integer x = 2491
integer y = 90
integer width = 673
integer height = 67
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217752
string text = "Coil  option"
boolean focusrectangle = false
end type

type cbx_stacker from u_cbx within u_tabpg_login
integer x = 256
integer y = 275
integer width = 1653
integer textsize = -11
string facename = "Arial"
long backcolor = 134217752
string text = "Using Atlas Stacker"
boolean checked = true
end type

type cbx_barcode from u_cbx within u_tabpg_login
integer x = 256
integer y = 563
integer width = 1653
integer textsize = -11
string facename = "Arial"
long backcolor = 134217752
string text = "This computer uses barcode scanner to scan coil id"
boolean checked = true
end type

type cb_apply from u_cb within u_tabpg_login
integer x = 611
integer y = 1203
integer width = 870
integer height = 118
integer taborder = 10
integer textsize = -14
string facename = "Arial"
string text = "Apply"
end type

event clicked;call super::clicked;if cbx_scale.checked then
	iw_operation_panel.iw_da_sheet.ib_skid_scale_connected = true
else
	iw_operation_panel.iw_da_sheet.ib_skid_scale_connected = false
end if

if cbx_barcode.checked then
	iw_operation_panel.iw_da_sheet.ib_scanner_connected = true
else
	iw_operation_panel.iw_da_sheet.ib_scanner_connected = false
end if

iw_operation_panel.iw_da_sheet.ib_stacker_online = cbx_stacker.checked

iw_operation_panel.iw_da_sheet.ib_scrap_scale_connected = cbx_scrap.checked

if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil) then
	if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_tab_page( ) ) then
		iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_tab_page( ).cb_read_scale.enabled = cbx_scrap.checked
		iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_tab_page( ).cb_reset_scale.enabled = cbx_scrap.checked
	end if
end if
//	
//	if isValid(iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_offline_tab_page( )) then
//		iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_offline_tab_page( ).cb_read_scale.enabled = cbx_scrap.checked
//		iw_operation_panel.iw_da_sheet.iu_current_coil.of_get_scrap_offline_tab_page( ).cb_reset_scale.enabled = cbx_scrap.checked
//	end if
//	
//end if



iw_operation_panel.postevent( "ue_operation_finish")
end event

type st_2 from statictext within u_tabpg_login
integer x = 607
integer y = 61
integer width = 673
integer height = 67
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217752
string text = "Line setup options"
boolean focusrectangle = false
end type

type cbx_scrap from u_cbx within u_tabpg_login
integer x = 260
integer y = 941
integer width = 1653
integer textsize = -11
string facename = "Arial"
long textcolor = 16711935
long backcolor = 134217752
string text = "This line reads scrap directly from smart scale"
boolean checked = true
end type

type st_3 from statictext within u_tabpg_login
integer x = 260
integer y = 1053
integer width = 1551
integer height = 67
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 134217752
string text = "Important! Change these only if scale is not working."
boolean focusrectangle = false
end type

type cbx_scale from u_cbx within u_tabpg_login
integer x = 260
integer y = 826
integer width = 1653
integer textsize = -11
string facename = "Arial"
long backcolor = 134217752
string text = "This line reads skid weight directly from smart scale"
boolean checked = true
end type

type gb_scale from groupbox within u_tabpg_login
integer x = 154
integer y = 739
integer width = 1788
integer height = 419
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Scale"
end type

type gb_scan from groupbox within u_tabpg_login
integer x = 154
integer y = 480
integer width = 1788
integer height = 189
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Scan Coil"
end type

type gb_stacker from groupbox within u_tabpg_login
integer x = 154
integer y = 192
integer width = 1788
integer height = 189
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Stacker"
end type

type gb_1 from groupbox within u_tabpg_login
integer x = 2143
integer y = 192
integer width = 1335
integer height = 966
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217752
string text = "Wrong coil"
end type

