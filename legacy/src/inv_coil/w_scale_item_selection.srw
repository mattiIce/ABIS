$PBExportHeader$w_scale_item_selection.srw
$PBExportComments$<Sheet> List all scale items such as coil, skid, scrap, inherited from pfemain\w_sheet
forward
global type w_scale_item_selection from w_sheet
end type
type sle_input from u_sle within w_scale_item_selection
end type
type st_5 from statictext within w_scale_item_selection
end type
type pb_pallet from u_pb within w_scale_item_selection
end type
type st_4 from statictext within w_scale_item_selection
end type
type st_1 from statictext within w_scale_item_selection
end type
type pb_skid from u_pb within w_scale_item_selection
end type
type cb_close from u_cb within w_scale_item_selection
end type
end forward

global type w_scale_item_selection from w_sheet
string tag = "Weighting utility"
integer x = 4
integer y = 3
integer width = 3738
integer height = 2272
string title = "Scale Application"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event type string ue_whoami ( )
sle_input sle_input
st_5 st_5
pb_pallet pb_pallet
st_4 st_4
st_1 st_1
pb_skid pb_skid
cb_close cb_close
end type
global w_scale_item_selection w_scale_item_selection

type variables
DateTime idt_1
end variables

event type string ue_whoami();RETURN "w_scale_item_selection"
end event

on w_scale_item_selection.create
int iCurrent
call super::create
this.sle_input=create sle_input
this.st_5=create st_5
this.pb_pallet=create pb_pallet
this.st_4=create st_4
this.st_1=create st_1
this.pb_skid=create pb_skid
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_input
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.pb_pallet
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.pb_skid
this.Control[iCurrent+7]=this.cb_close
end on

on w_scale_item_selection.destroy
call super::destroy
destroy(this.sle_input)
destroy(this.st_5)
destroy(this.pb_pallet)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.pb_skid)
destroy(this.cb_close)
end on

event open;call super::open;SetNULL(idt_1)
end event

type sle_input from u_sle within w_scale_item_selection
integer x = 3094
integer y = 2106
integer width = 574
integer taborder = 10
string facename = "Arial"
end type

event constructor;call super::constructor;this.Visible = FALSE
end event

event modified;call super::modified;String ls_input, ls_pre
Long ll_exist
DateTime ldt_2

ls_input = This.Text
This.Text = ""
ls_input = RightTrim(LeftTrim(ls_input))
IF Len(ls_input) <= 2 OR ISNULL(ls_input) THEN RETURN 0

ls_pre = Left(ls_input, 2)
CHOOSE CASE Upper(ls_pre)
	CASE "0S" //Skid
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "SKID" THEN OPEN(w_scale_skid)
	CASE "0P" //Pallet
		ls_input = Upper(Mid(ls_input, 3))
		IF ls_input = "PALLET" THEN OPEN(w_scale_pallet)
	CASE "3A" //exit
		ldt_2 = DateTime(Today(), Now())
		IF isNULL(idt_1) OR SecondsAfter(Time(idt_1), Time(ldt_2)) > 2 THEN
			idt_1 = ldt_2
		ELSE
			parent.event pfc_close()
			HALT CLOSE
		END IF
END CHOOSE
		
RETURN 1

end event

type st_5 from statictext within w_scale_item_selection
integer x = 2454
integer y = 1440
integer width = 644
integer height = 150
integer textsize = -26
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "PALLET"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_pallet from u_pb within w_scale_item_selection
integer x = 1894
integer y = 330
integer width = 1759
integer height = 1101
integer taborder = 30
string text = ""
boolean originalsize = false
string picturename = "scale_pallet.JPG"
end type

event clicked;call super::clicked;Open(w_scale_Pallet)

sle_input.SetFocus()
end event

type st_4 from statictext within w_scale_item_selection
integer x = 26
integer y = 16
integer width = 3690
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

type st_1 from statictext within w_scale_item_selection
integer x = 252
integer y = 1440
integer width = 1360
integer height = 150
integer textsize = -26
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "PACKAGED SKID"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_skid from u_pb within w_scale_item_selection
integer x = 55
integer y = 330
integer width = 1759
integer height = 1101
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "scale_skid.JPG"
end type

event clicked;call super::clicked;Open(w_scale_skid)

sle_input.SetFocus()
end event

type cb_close from u_cb within w_scale_item_selection
string tag = "Exit"
integer x = 1562
integer y = 1821
integer width = 607
integer height = 278
integer taborder = 40
integer textsize = -22
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&EXIT"
end type

event clicked;call super::clicked;parent.event pfc_close()
HALT CLOSE

end event

