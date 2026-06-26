$PBExportHeader$w_scale_item_selection_backup.srw
$PBExportComments$<Sheet> List all scale items such as coil, skid, scrap, inherited from pfemain\w_sheet
forward
global type w_scale_item_selection_backup from w_sheet
end type
type st_5 from statictext within w_scale_item_selection_backup
end type
type pb_general from u_pb within w_scale_item_selection_backup
end type
type st_4 from statictext within w_scale_item_selection_backup
end type
type st_3 from statictext within w_scale_item_selection_backup
end type
type st_2 from statictext within w_scale_item_selection_backup
end type
type st_1 from statictext within w_scale_item_selection_backup
end type
type pb_coil from u_pb within w_scale_item_selection_backup
end type
type pb_scrap from u_pb within w_scale_item_selection_backup
end type
type pb_skid from u_pb within w_scale_item_selection_backup
end type
type cb_close from u_cb within w_scale_item_selection_backup
end type
end forward

global type w_scale_item_selection_backup from w_sheet
string tag = "Weighting utility"
integer x = 4
integer y = 3
integer width = 3661
integer height = 1504
string title = "Scale Application"
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
st_5 st_5
pb_general pb_general
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
pb_coil pb_coil
pb_scrap pb_scrap
pb_skid pb_skid
cb_close cb_close
end type
global w_scale_item_selection_backup w_scale_item_selection_backup

type variables
String is_select
String is_where
s_coil_info ids_coil
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_delete
Boolean ib_new
Boolean ib_modify
Long il_cur_coil
Boolean ib_readonly
Boolean ib_allcust
Int ii_showall
Long il_index
end variables

event type string ue_whoami();RETURN "w_scale_item_selection"
end event

on w_scale_item_selection_backup.create
int iCurrent
call super::create
this.st_5=create st_5
this.pb_general=create pb_general
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.pb_coil=create pb_coil
this.pb_scrap=create pb_scrap
this.pb_skid=create pb_skid
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.pb_general
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.pb_coil
this.Control[iCurrent+8]=this.pb_scrap
this.Control[iCurrent+9]=this.pb_skid
this.Control[iCurrent+10]=this.cb_close
end on

on w_scale_item_selection_backup.destroy
call super::destroy
destroy(this.st_5)
destroy(this.pb_general)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_coil)
destroy(this.pb_scrap)
destroy(this.pb_skid)
destroy(this.cb_close)
end on

event close;call super::close;f_display_app_shop()
end event

type st_5 from statictext within w_scale_item_selection_backup
integer x = 2739
integer y = 886
integer width = 644
integer height = 93
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "General"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_general from u_pb within w_scale_item_selection_backup
integer x = 2736
integer y = 307
integer width = 651
integer height = 570
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "generalwt.jpg"
end type

event clicked;call super::clicked;Open(w_scale_general)
end event

type st_4 from statictext within w_scale_item_selection_backup
integer x = 102
integer y = 16
integer width = 3478
integer height = 192
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please select an item to weight:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_scale_item_selection_backup
integer x = 1861
integer y = 886
integer width = 644
integer height = 93
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Coil"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;Open(w_scale_coil)
end event

type st_2 from statictext within w_scale_item_selection_backup
integer x = 984
integer y = 886
integer width = 644
integer height = 93
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Scrap"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;Open(w_scale_scrap)
end event

type st_1 from statictext within w_scale_item_selection_backup
integer x = 106
integer y = 886
integer width = 644
integer height = 93
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Skid"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_coil from u_pb within w_scale_item_selection_backup
integer x = 1858
integer y = 307
integer width = 651
integer height = 570
integer taborder = 30
string text = ""
boolean originalsize = false
string picturename = "scale_coil.JPG"
end type

event clicked;call super::clicked;Open(w_scale_coil)
end event

type pb_scrap from u_pb within w_scale_item_selection_backup
integer x = 980
integer y = 304
integer width = 651
integer height = 570
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "scale_scrap.JPG"
end type

event clicked;call super::clicked;Open(w_scale_scrap)
end event

type pb_skid from u_pb within w_scale_item_selection_backup
integer x = 102
integer y = 307
integer width = 651
integer height = 570
integer taborder = 10
string text = ""
string picturename = "scale_skid.JPG"
end type

event clicked;call super::clicked;Open(w_scale_skid)
end event

type cb_close from u_cb within w_scale_item_selection_backup
string tag = "Exit"
integer x = 2992
integer y = 1184
integer width = 607
integer height = 179
integer taborder = 40
integer textsize = -22
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&EXIT"
end type

event clicked;call super::clicked;Close(Parent)
end event

