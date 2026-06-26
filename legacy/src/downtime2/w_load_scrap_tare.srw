$PBExportHeader$w_load_scrap_tare.srw
forward
global type w_load_scrap_tare from w_response
end type
type cb_1 from commandbutton within w_load_scrap_tare
end type
type cb_lookup from u_cb within w_load_scrap_tare
end type
type sle_scrap_skid_num from singlelineedit within w_load_scrap_tare
end type
type pb_new_tare_wt from u_pb within w_load_scrap_tare
end type
type em_tare_wt from u_em within w_load_scrap_tare
end type
type rb_reuse from radiobutton within w_load_scrap_tare
end type
type rb_new_tare from radiobutton within w_load_scrap_tare
end type
type cb_cancel from commandbutton within w_load_scrap_tare
end type
type cb_select from commandbutton within w_load_scrap_tare
end type
type dw_partial from u_dw within w_load_scrap_tare
end type
type gb_1 from groupbox within w_load_scrap_tare
end type
end forward

global type w_load_scrap_tare from w_response
integer width = 1682
integer height = 1824
string title = "Select scrap tare"
boolean controlmenu = false
cb_1 cb_1
cb_lookup cb_lookup
sle_scrap_skid_num sle_scrap_skid_num
pb_new_tare_wt pb_new_tare_wt
em_tare_wt em_tare_wt
rb_reuse rb_reuse
rb_new_tare rb_new_tare
cb_cancel cb_cancel
cb_select cb_select
dw_partial dw_partial
gb_1 gb_1
end type
global w_load_scrap_tare w_load_scrap_tare

type variables
s_partial_skid is_partial
long il_cust_id
u_da_offline_scrap_tabpg iu_tabpg
string is_alloy
end variables

on w_load_scrap_tare.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_lookup=create cb_lookup
this.sle_scrap_skid_num=create sle_scrap_skid_num
this.pb_new_tare_wt=create pb_new_tare_wt
this.em_tare_wt=create em_tare_wt
this.rb_reuse=create rb_reuse
this.rb_new_tare=create rb_new_tare
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_partial=create dw_partial
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_lookup
this.Control[iCurrent+3]=this.sle_scrap_skid_num
this.Control[iCurrent+4]=this.pb_new_tare_wt
this.Control[iCurrent+5]=this.em_tare_wt
this.Control[iCurrent+6]=this.rb_reuse
this.Control[iCurrent+7]=this.rb_new_tare
this.Control[iCurrent+8]=this.cb_cancel
this.Control[iCurrent+9]=this.cb_select
this.Control[iCurrent+10]=this.dw_partial
this.Control[iCurrent+11]=this.gb_1
end on

on w_load_scrap_tare.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_lookup)
destroy(this.sle_scrap_skid_num)
destroy(this.pb_new_tare_wt)
destroy(this.em_tare_wt)
destroy(this.rb_reuse)
destroy(this.rb_new_tare)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_partial)
destroy(this.gb_1)
end on

event open;call super::open;//string ls_s
il_cust_id = gl_message
//ls_s = Message.stringparm
//iu_tabpg = message.powerobjectparm
//dw_partial.settransobject( sqlca)
//MessageBox("open", iu_tabpg.is_title )
//dw_partial.of_settransobject( sqlca)

if gi_screen = 2 then
	if gi_dual_mode = 2 then
		this.x = 1200
		this.y = 4000
	else
		this.x = 7000
		this.y = 600
	end if
else
	this.x = 1200
	this.y = 600
end if
end event

event pfc_postopen;call super::pfc_postopen;//long ll_cust_id


dw_partial.of_retrieve( )
if dw_partial.rowcount( ) < 1 then
	cb_select.enabled = false
	sle_scrap_skid_num.enabled = false
	cb_lookup.enabled = false
	//st_select.text = "No partial skid for job " + string( ll_job )
elseif dw_partial.rowcount( ) = 1 then
	dw_partial.selectrow( 1, true)
	is_partial.partial_skid_num = dw_partial.object.scrap_skid_num[1]
	//is_partial.partial_skid_pieces = dw_partial.getitemnumber( 1, "sheet_skid_skid_pieces")
	is_partial.partial_skid_net_wt = dw_partial.object.scrap_net_wt[1]
	is_partial.partial_skid_tare_wt = dw_partial.object.scrap_tare_wt[1]
	is_partial.partial_skid_status = 7
	cb_select.text = "Select " + string(is_partial.partial_skid_num) 
	sle_scrap_skid_num.text = string( is_partial.partial_skid_num )
else
	cb_select.text = "Select ticket"
end if
end event

type cb_1 from commandbutton within w_load_scrap_tare
boolean visible = false
integer x = 1618
integer y = 1232
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;messagebox("", is_alloy)
end event

type cb_lookup from u_cb within w_load_scrap_tare
integer x = 1271
integer y = 308
integer width = 192
integer height = 116
integer taborder = 70
integer textsize = -10
integer weight = 700
string facename = "Arial"
string text = "Find"
end type

event clicked;call super::clicked;string ls_find
long ll_row

if	not isNumber( sle_scrap_skid_num.text ) then
	return 0
end if

ls_find = "scrap_skid_num = " + sle_scrap_skid_num.text
if dw_partial.rowcount( ) >= 1 then
	ll_row = dw_partial.find( ls_find , 1, dw_partial.rowcount( ) )
	if ll_row > 0 then
		dw_partial.scrolltorow( ll_row )
		dw_partial.selectrow( 0, false)
		dw_partial.selectrow( ll_row, true)
		is_partial.partial_skid_num = dw_partial.object.scrap_skid_num[ll_row]
		is_partial.partial_skid_net_wt = dw_partial.object.scrap_net_wt[ll_row]
		is_partial.partial_skid_tare_wt = dw_partial.object.scrap_tare_wt[ll_row]
		is_partial.partial_skid_status = 7
		cb_select.text = "Select " + string(is_partial.partial_skid_num)
		return 1
	else
		Messagebox("Find pallet", "Can not find specified pallet!")
		dw_partial.selectrow( 0, false)
		cb_select.text = "Select"
//		cb_select.enabled = false
		return 0
	end if
else
	MessageBox("Scrap pallet", "There is no existing pallet for this customer!")
	return 0
end if
return 0
end event

type sle_scrap_skid_num from singlelineedit within w_load_scrap_tare
integer x = 997
integer y = 308
integer width = 279
integer height = 116
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
borderstyle borderstyle = stylelowered!
end type

type pb_new_tare_wt from u_pb within w_load_scrap_tare
integer x = 1335
integer y = 176
integer width = 119
integer height = 96
integer taborder = 40
boolean enabled = false
boolean originalsize = false
string picturename = "Compute!"
string disabledname = "Close!"
end type

event clicked;call super::clicked;em_tare_wt.Event pfc_DDCalculator( )
end event

event constructor;call super::constructor;//is_alloy = message.stringparm
//is_alloy = UPPER(is_alloy)
end event

type em_tare_wt from u_em within w_load_scrap_tare
integer x = 942
integer y = 176
integer width = 393
integer height = 96
integer taborder = 10
integer textsize = -12
boolean enabled = false
string text = "0000"
string mask = "####"
boolean spin = true
string minmax = "0~~9999"
end type

event constructor;call super::constructor;is_alloy = message.stringparm
is_alloy = UPPER(is_alloy)
this.of_setdropdowncalculator( true)
this.iuo_calculator.of_setcloseonclick( true)
this.iuo_calculator.of_setinitialvalue( true)
end event

event modified;call super::modified;//
if Pos(cb_select.text, "new"  ) > 1 then
	cb_select.text = "Select new " + this.text
end if
end event

type rb_reuse from radiobutton within w_load_scrap_tare
integer x = 160
integer y = 320
integer width = 841
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reuse existing pallet id"
boolean checked = true
end type

event clicked;if dw_partial.rowcount( ) < 1 then
	MessageBox("Scrap pallet", "No available pallet!")
	cb_select.enabled = false
	this.checked = false
	sle_scrap_skid_num.enabled = false
	cb_lookup.enabled = false
	return 0
else
	cb_select.enabled = true
end if

em_tare_wt.enabled = false
pb_new_tare_wt.enabled = false
dw_partial.enabled = true
sle_scrap_skid_num.enabled = true
cb_lookup.enabled = true
end event

type rb_new_tare from radiobutton within w_load_scrap_tare
integer x = 160
integer y = 180
integer width = 704
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "New pallet, tare wt"
end type

event clicked;em_tare_wt.enabled = true
pb_new_tare_wt.enabled = true
dw_partial.enabled = false
//cb_select.text = "Select new " + em_tare_wt.text
sle_scrap_skid_num.enabled = false
cb_lookup.enabled = false
cb_select.enabled = true
end event

type cb_cancel from commandbutton within w_load_scrap_tare
integer x = 905
integer y = 1552
integer width = 677
integer height = 128
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;is_partial.partial_skid_num = -1
CloseWithReturn(parent, is_partial)
end event

type cb_select from commandbutton within w_load_scrap_tare
integer x = 87
integer y = 1548
integer width = 677
integer height = 128
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select"
end type

event clicked;long ll_scrap_seq
if rb_new_tare.checked then
	if not isNumber( em_tare_wt.text ) or Integer( em_tare_wt.text ) < 0 or Integer( em_tare_wt.text ) > 999  then
		MessageBox("Tare weight needed", "Please enter correct tare for new pallet", StopSign!)
		return 1
	end if
	
	SELECT SCRAP_SKID_NUM_SEQ.NEXTVAL INTO :ll_scrap_seq FROM DUAL;
	is_partial.partial_skid_num = ll_scrap_seq
	is_partial.partial_skid_net_wt = 0
	is_partial.partial_skid_tare_wt = Integer( em_tare_wt.text )
	is_partial.partial_skid_status = 6
	
else //select old
	
	if not isNumber( sle_scrap_skid_num.text ) then
		MessageBox("Tare needed", "Please select exist pallet", StopSign!)
		return 1
	else
		if cb_lookup.event clicked( ) = 0 then
			return 1
		end if
	end if
	
end if

ClosewithReturn(parent, is_partial  )




end event

type dw_partial from u_dw within w_load_scrap_tare
integer x = 119
integer y = 476
integer width = 1467
integer height = 988
integer taborder = 20
string dataobject = "d_scrap_pallet"
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;//selectrow( 0, false)
//selectrow( row, true)
//MessageBox("row", string(row))
if row > 0 then
	this.selectrow( 0, false)
	this.selectrow( row, true)
	is_partial.partial_skid_num = getitemnumber( row, "scrap_skid_num")
	//is_partial.partial_skid_pieces = getitemnumber( row, "sheet_skid_skid_pieces")
	is_partial.partial_skid_net_wt = dw_partial.getitemnumber( row, "scrap_net_wt")
	is_partial.partial_skid_tare_wt = dw_partial.getitemnumber( row, "scrap_tare_wt")
	is_partial.partial_skid_status = 7
	sle_scrap_skid_num.text = string(is_partial.partial_skid_num)
	//parent.cb_select.text = "Select " + string(is_partial.partial_skid_num)
end if
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_cust_id, is_alloy)
end event

event constructor;call super::constructor;//il_cust_id = message.doubleparm
//is_alloy = message.stringparm
//is_alloy = UPPER(is_alloy)
this.of_settransobject( sqlca)
end event

type gb_1 from groupbox within w_load_scrap_tare
integer x = 87
integer y = 60
integer width = 1522
integer height = 1440
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select scrap Tare (pallet):"
end type

