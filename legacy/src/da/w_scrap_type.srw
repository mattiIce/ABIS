$PBExportHeader$w_scrap_type.srw
forward
global type w_scrap_type from w_popup
end type
type pb_cancel from u_pb within w_scrap_type
end type
type uo_type from u_scrap_type_panel within w_scrap_type
end type
end forward

global type w_scrap_type from w_popup
integer x = 214
integer width = 2388
integer height = 733
string title = "Scrap type selection"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean ib_isupdateable = false
pb_cancel pb_cancel
uo_type uo_type
end type
global w_scrap_type w_scrap_type

type variables
int ii_scrap_type
u_da_scrap_tabpg iu_da_scrap_tabpg
end variables

event open;call super::open;//ii_scrap_type = message.doubleparm
iu_da_scrap_tabpg = message.powerobjectparm

if gi_screen = 2 then
	if gi_dual_mode = 2 then
		this.x = 1000
		this.y = 4800
	else
		this.x = 7060
		this.y = 1420
	end if
else
	this.x = iu_da_scrap_tabpg.cb_change_type.x - this.width /2
	this.y = iu_da_scrap_tabpg.cb_change_type.y
end if

//this.x = iu_da_scrap_tabpg.cb_change_type.x - this.width /2
//this.y = iu_da_scrap_tabpg.cb_change_type.y
uo_type.of_set_defect_id( iu_da_scrap_tabpg.ii_scrap_type )
ii_scrap_type = iu_da_scrap_tabpg.ii_scrap_type
end event

on w_scrap_type.create
int iCurrent
call super::create
this.pb_cancel=create pb_cancel
this.uo_type=create uo_type
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_cancel
this.Control[iCurrent+2]=this.uo_type
end on

on w_scrap_type.destroy
call super::destroy
destroy(this.pb_cancel)
destroy(this.uo_type)
end on

type pb_cancel from u_pb within w_scrap_type
integer x = 794
integer y = 528
integer width = 783
integer height = 109
integer taborder = 110
integer textsize = -12
string facename = "Arial"
string text = "Cancel"
end type

event clicked;call super::clicked;Close(parent)
end event

type uo_type from u_scrap_type_panel within w_scrap_type
integer x = 11
integer y = 6
integer taborder = 100
end type

on uo_type.destroy
call u_scrap_type_panel::destroy
end on

event type_changed;call super::type_changed;//iu_da_skid_scrap_tabpg.ii_pre_scrap_type = iu_da_skid_scrap_tabpg.ii_scrap_type
//iu_da_skid_scrap_tabpg.ii_scrap_type = this.of_get_current_scrap_type( )
ii_scrap_type = this.of_get_current_scrap_type( )
iu_da_scrap_tabpg.dw_current_quality_scrap.object.scrap_item_type[1] = ii_scrap_type
iu_da_scrap_tabpg.of_change_scrap_type( ii_scrap_type )
close(parent)
end event

