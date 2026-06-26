$PBExportHeader$w_scrap_skid_print_preview_oe.srw
forward
global type w_scrap_skid_print_preview_oe from w_popup
end type
type cb_get_size from commandbutton within w_scrap_skid_print_preview_oe
end type
type cb_cancel from commandbutton within w_scrap_skid_print_preview_oe
end type
type cb_print from commandbutton within w_scrap_skid_print_preview_oe
end type
type dw_scrap_skid_ticket_non_bl110 from datawindow within w_scrap_skid_print_preview_oe
end type
end forward

global type w_scrap_skid_print_preview_oe from w_popup
integer width = 2482
integer height = 2476
string title = "Scrap Skid Print Preview"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
cb_get_size cb_get_size
cb_cancel cb_cancel
cb_print cb_print
dw_scrap_skid_ticket_non_bl110 dw_scrap_skid_ticket_non_bl110
end type
global w_scrap_skid_print_preview_oe w_scrap_skid_print_preview_oe

type variables
//u_office_recap_tabpg_bl110_das	iu_office_recap_tabpg_bl110_das
end variables

on w_scrap_skid_print_preview_oe.create
int iCurrent
call super::create
this.cb_get_size=create cb_get_size
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.dw_scrap_skid_ticket_non_bl110=create dw_scrap_skid_ticket_non_bl110
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_get_size
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.dw_scrap_skid_ticket_non_bl110
end on

on w_scrap_skid_print_preview_oe.destroy
call super::destroy
destroy(this.cb_get_size)
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.dw_scrap_skid_ticket_non_bl110)
end on

event open;call super::open;Long						ll_ab_job_num, ll_scrap_skid_num, ll_selected_row, ll_shift_num, ll_null
Integer					li_rows, li_rtn, li_seq_job, li_job_status
String					ls_shift_desc
str_all_data_types	lstr_all_data_types


lstr_all_data_types = Message.PowerObjectParm

ll_ab_job_num = lstr_all_data_types.long_var[1]
ll_scrap_skid_num = lstr_all_data_types.long_var[2]
li_job_status = lstr_all_data_types.integer_var[1]
ls_shift_desc = lstr_all_data_types.string_var[1]

dw_scrap_skid_ticket_non_bl110.SetTransObject(sqlca)
li_rows = dw_scrap_skid_ticket_non_bl110.Retrieve(ll_scrap_skid_num)

If li_rows > 0 Then
	dw_scrap_skid_ticket_non_bl110.Object.shift[1] = ls_shift_desc
	
	If li_job_status <> 0 Then //Job not Done
		SetNull(ll_null)
		dw_scrap_skid_ticket_non_bl110.Object.scrap_skid_scrap_net_wt[1] = ll_null
		dw_scrap_skid_ticket_non_bl110.Object.scrap_skid_scrap_tare_wt[1] = ll_null
		dw_scrap_skid_ticket_non_bl110.Object.gross_wt[1] = ll_null
	End If
End If

cb_get_size.Visible = False
end event

event pfc_postopen;call super::pfc_postopen;//This.Width = 5336
//This.Height = 2077
This.X = 534
This.Y = 99
end event

type cb_get_size from commandbutton within w_scrap_skid_print_preview_oe
integer x = 1664
integer y = 2252
integer width = 320
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GetSize"
end type

event clicked;MessageBox("", "Window Width: " + String(Parent.Width) + &
					"~n~rWindow Height: " + String(Parent.Height) + &
					"~n~rWindow X: " + String(Parent.X) + &
					"~n~rWindow Y: " + String(Parent.Y) + &
					"~n~r~n~rdw_scrap_skid_ticket_non_bl110.Width: " + String(dw_scrap_skid_ticket_non_bl110.Width) + &
					"~n~rdw_scrap_skid_ticket_non_bl110.Height: " + String(dw_scrap_skid_ticket_non_bl110.Height) + &
					"~n~rdw_scrap_skid_ticket_non_bl110 X: " + String(dw_scrap_skid_ticket_non_bl110.X) + &
					"~n~rdw_scrap_skid_ticket_non_bl110 Y: " + String(dw_scrap_skid_ticket_non_bl110.Y))
end event

type cb_cancel from commandbutton within w_scrap_skid_print_preview_oe
integer x = 1202
integer y = 2252
integer width = 325
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel/Close"
end type

event clicked;Close(Parent)
end event

type cb_print from commandbutton within w_scrap_skid_print_preview_oe
integer x = 645
integer y = 2252
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
boolean default = true
end type

event clicked;Integer	li_rtn

li_rtn = PrintSetup()
		
If li_rtn = -1 Then //Error in PrintSetup() or user clicked on "Cancel"
	Return 1
End If
		
dw_scrap_skid_ticket_non_bl110.Print()
end event

type dw_scrap_skid_ticket_non_bl110 from datawindow within w_scrap_skid_print_preview_oe
integer x = 215
integer y = 180
integer width = 1970
integer height = 2012
integer taborder = 10
string title = "none"
string dataobject = "d_scrap_skid_ticket_non_bl110_oe"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

