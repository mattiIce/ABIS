$PBExportHeader$w_load_partial.srw
forward
global type w_load_partial from w_response
end type
type cbx_1 from checkbox within w_load_partial
end type
type st_select from statictext within w_load_partial
end type
type cb_cancel from commandbutton within w_load_partial
end type
type cb_select from commandbutton within w_load_partial
end type
type dw_partial from u_dw within w_load_partial
end type
end forward

global type w_load_partial from w_response
integer width = 2940
integer height = 1222
string title = "Please select partial"
boolean controlmenu = false
cbx_1 cbx_1
st_select st_select
cb_cancel cb_cancel
cb_select cb_select
dw_partial dw_partial
end type
global w_load_partial w_load_partial

type variables
s_partial_skid is_partial
long il_job
end variables

on w_load_partial.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.st_select=create st_select
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_partial=create dw_partial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.st_select
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.dw_partial
end on

on w_load_partial.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.st_select)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_partial)
end on

event open;call super::open;//long ll_job
il_job = message.doubleparm

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

dw_partial.settransobject( sqlca)
dw_partial.retrieve( il_job)
if dw_partial.rowcount( ) < 1 then
	cb_select.enabled = false
	st_select.text = "No partial skid for job " + string( il_job )
elseif dw_partial.rowcount( ) = 1 then
	dw_partial.selectrow( 1, true)
	is_partial.partial_skid_num = dw_partial.getitemnumber( 1, "sheet_skid_sheet_skid_num")
	is_partial.partial_skid_pieces = dw_partial.getitemnumber( 1, "sheet_skid_skid_pieces")
	is_partial.partial_skid_net_wt = dw_partial.getitemnumber( 1, "sheet_skid_sheet_net_wt")
	is_partial.partial_skid_tare_wt = dw_partial.getitemnumber( 1, "sheet_skid_sheet_tare_wt")
	cb_select.text = "Select " + string(is_partial.partial_skid_num) 
else
	cb_select.text = "Select ticket"
end if
end event

type cbx_1 from checkbox within w_load_partial
integer x = 892
integer y = 35
integer width = 556
integer height = 93
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show all skids"
end type

event clicked;if this.checked then
	dw_partial.dataobject = "d_partail_for_job_all_status"
else
	dw_partial.dataobject = "d_partail_for_job"
end if

dw_partial.SetTransObject(sqlca) //Alex Gerlants. 06/22/2022
dw_partial.retrieve( il_job)
if dw_partial.rowcount( ) < 1 then
	cb_select.enabled = false
	st_select.text = "No partial skid for job " + string( il_job )
elseif dw_partial.rowcount( ) = 1 then
	dw_partial.selectrow( 1, true)
	is_partial.partial_skid_num = dw_partial.getitemnumber( 1, "sheet_skid_sheet_skid_num")
	is_partial.partial_skid_pieces = dw_partial.getitemnumber( 1, "sheet_skid_skid_pieces")
	is_partial.partial_skid_net_wt = dw_partial.getitemnumber( 1, "sheet_skid_sheet_net_wt")
	is_partial.partial_skid_tare_wt = dw_partial.getitemnumber( 1, "sheet_skid_sheet_tare_wt")
	cb_select.text = "Select " + string(is_partial.partial_skid_num) 
else
	cb_select.text = "Select ticket"
end if
end event

type st_select from statictext within w_load_partial
integer x = 55
integer y = 48
integer width = 651
integer height = 74
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select partial skid:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_load_partial
integer x = 1598
integer y = 941
integer width = 647
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

event clicked;is_partial.partial_skid_num = -1
CloseWithReturn(parent, is_partial)
end event

type cb_select from commandbutton within w_load_partial
integer x = 640
integer y = 938
integer width = 647
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select"
end type

event clicked;ClosewithReturn(parent, is_partial  )
end event

type dw_partial from u_dw within w_load_partial
integer x = 48
integer y = 154
integer width = 2842
integer height = 707
integer taborder = 10
string dataobject = "d_partail_for_job"
end type

event clicked;call super::clicked;//selectrow( 0, false)
//selectrow( row, true)
//MessageBox("row", string(row))
if row > 0 then
	this.selectrow( 0, false)
	this.selectrow( row, true)
	is_partial.partial_skid_num = getitemnumber( row, "sheet_skid_sheet_skid_num")
	is_partial.partial_skid_pieces = getitemnumber( row, "sheet_skid_skid_pieces")
	is_partial.partial_skid_net_wt = dw_partial.getitemnumber( row, "sheet_skid_sheet_net_wt")
	is_partial.partial_skid_tare_wt = dw_partial.getitemnumber( row, "sheet_skid_sheet_tare_wt")
	parent.cb_select.text = "Select " + string(is_partial.partial_skid_num)
end if
end event

