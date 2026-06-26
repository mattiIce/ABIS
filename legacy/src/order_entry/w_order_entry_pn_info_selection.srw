$PBExportHeader$w_order_entry_pn_info_selection.srw
$PBExportComments$<Response> let user select which PN info to copy over inherited from w_response
forward
global type w_order_entry_pn_info_selection from w_response
end type
type rb_all from u_rb within w_order_entry_pn_info_selection
end type
type rb_package from u_rb within w_order_entry_pn_info_selection
end type
type rb_process from u_rb within w_order_entry_pn_info_selection
end type
type cb_ok from u_cb within w_order_entry_pn_info_selection
end type
type gb_1 from u_gb within w_order_entry_pn_info_selection
end type
end forward

global type w_order_entry_pn_info_selection from w_response
integer width = 1485
integer height = 486
string title = "Select PN info to be used in order entry"
boolean controlmenu = false
rb_all rb_all
rb_package rb_package
rb_process rb_process
cb_ok cb_ok
gb_1 gb_1
end type
global w_order_entry_pn_info_selection w_order_entry_pn_info_selection

on w_order_entry_pn_info_selection.create
int iCurrent
call super::create
this.rb_all=create rb_all
this.rb_package=create rb_package
this.rb_process=create rb_process
this.cb_ok=create cb_ok
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_all
this.Control[iCurrent+2]=this.rb_package
this.Control[iCurrent+3]=this.rb_process
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.gb_1
end on

on w_order_entry_pn_info_selection.destroy
call super::destroy
destroy(this.rb_all)
destroy(this.rb_package)
destroy(this.rb_process)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

type rb_all from u_rb within w_order_entry_pn_info_selection
integer x = 1101
integer y = 144
integer width = 252
string facename = "Arial"
string text = "All"
boolean checked = true
end type

type rb_package from u_rb within w_order_entry_pn_info_selection
integer x = 622
integer y = 144
string facename = "Arial"
string text = "Packaging"
end type

type rb_process from u_rb within w_order_entry_pn_info_selection
integer x = 143
integer y = 144
string facename = "Arial"
string text = "Processing"
end type

type cb_ok from u_cb within w_order_entry_pn_info_selection
integer x = 501
integer y = 291
integer width = 351
integer height = 93
integer taborder = 10
string facename = "Arial"
string text = "&OK"
end type

event clicked;call super::clicked;String ls_sel

IF rb_process.Checked THEN ls_sel ='PROCESS'
IF rb_package.Checked THEN ls_sel ='PACKAGE'
IF rb_all.Checked THEN ls_sel = 'ALL'

ClosewithReturn(Parent, ls_sel)
end event

type gb_1 from u_gb within w_order_entry_pn_info_selection
integer x = 11
integer y = 13
integer width = 1437
integer taborder = 10
integer textsize = -9
string facename = "Arial"
string text = "Please identify which part~'s info to be copied into order:"
end type

