$PBExportHeader$w_new_coil_id.srw
$PBExportComments$New coil ID screen inherited from w_response
forward
global type w_new_coil_id from w_response
end type
type cb_new from commandbutton within w_new_coil_id
end type
type cb_ok from commandbutton within w_new_coil_id
end type
type st_1 from statictext within w_new_coil_id
end type
type em_id from u_em within w_new_coil_id
end type
end forward

global type w_new_coil_id from w_response
integer width = 1463
integer height = 570
string title = "New Coil ID"
boolean controlmenu = false
cb_new cb_new
cb_ok cb_ok
st_1 st_1
em_id em_id
end type
global w_new_coil_id w_new_coil_id

type variables

end variables

on w_new_coil_id.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_ok=create cb_ok
this.st_1=create st_1
this.em_id=create em_id
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_id
end on

on w_new_coil_id.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.em_id)
end on

event open;call super::open;if gi_screen = 2 then
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

type cb_new from commandbutton within w_new_coil_id
integer x = 885
integer y = 147
integer width = 505
integer height = 109
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Need a new ID"
end type

event clicked;Long ll_new_id
ll_new_id = f_get_next_value("coil_abc_num_seq")
em_id.Text = String(ll_new_id)


end event

type cb_ok from commandbutton within w_new_coil_id
integer x = 410
integer y = 310
integer width = 633
integer height = 141
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
end type

event clicked;long ll_id
Int li_c
ll_id = long(em_id.text)

if ll_id < 1 or ll_id > 99999999 then
	MessageBox("Warning", "Invalid ID")
	return 1
end if

li_c = 0
SELECT count(*) INTO :li_c
FROM Coil
WHERE coil_abc_num = :ll_id
USING SQLCA;

if li_c > 0 then
	MessageBox("Warning", "Duplicated coil ID. Please enter a new one.")
	return 2
end if

CloseWithReturn(parent, ll_id  )
end event

type st_1 from statictext within w_new_coil_id
integer x = 15
integer y = 26
integer width = 1075
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Please enter ABC coil ID:"
boolean focusrectangle = false
end type

type em_id from u_em within w_new_coil_id
integer x = 176
integer y = 144
integer width = 669
integer height = 118
integer taborder = 10
integer textsize = -12
string facename = "Arial"
string mask = "########"
end type

