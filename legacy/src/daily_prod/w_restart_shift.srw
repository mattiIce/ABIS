$PBExportHeader$w_restart_shift.srw
forward
global type w_restart_shift from w_sheet
end type
type cb_close from commandbutton within w_restart_shift
end type
type st_shift_id from statictext within w_restart_shift
end type
type sle_shift_id from singlelineedit within w_restart_shift
end type
type cb_restart_shift from commandbutton within w_restart_shift
end type
end forward

global type w_restart_shift from w_sheet
integer width = 1499
integer height = 515
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
cb_close cb_close
st_shift_id st_shift_id
sle_shift_id sle_shift_id
cb_restart_shift cb_restart_shift
end type
global w_restart_shift w_restart_shift

on w_restart_shift.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_shift_id=create st_shift_id
this.sle_shift_id=create sle_shift_id
this.cb_restart_shift=create cb_restart_shift
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_shift_id
this.Control[iCurrent+3]=this.sle_shift_id
this.Control[iCurrent+4]=this.cb_restart_shift
end on

on w_restart_shift.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_shift_id)
destroy(this.sle_shift_id)
destroy(this.cb_restart_shift)
end on

event open;call super::open;IF f_security_door("Shift Control") < 0 THEN
	MessageBox("Info", "Insufficient privileges!")
	Close(this)
	RETURN 0
END IF
end event

type cb_close from commandbutton within w_restart_shift
integer x = 914
integer y = 253
integer width = 322
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type st_shift_id from statictext within w_restart_shift
integer x = 102
integer y = 131
integer width = 197
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shift ID:"
boolean focusrectangle = false
end type

type sle_shift_id from singlelineedit within w_restart_shift
integer x = 322
integer y = 106
integer width = 384
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_restart_shift from commandbutton within w_restart_shift
integer x = 911
integer y = 102
integer width = 322
integer height = 90
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Restart Shift"
end type

event clicked;IF sle_shift_id.Text <> '' THEN
	CONNECT USING SQLCA;
	UPDATE DBO.SHIFT
	SET END_TIME = NULL
	WHERE SHIFT_NUM = :sle_shift_id.Text
	USING SQLCA;
	
	IF SQLCA.SQLCODE = 0 THEN
		IF SQLCA.SQLNROWS > 1 THEN
			MessageBox("Failed to Restart Shift", "More than one row found for shift ID " + sle_shift_id.Text)	
			ROLLBACK USING SQLCA;			
		END IF
		IF SQLCA.SQLNROWS = 0 THEN
			MessageBox("Shift Not Found", "Shift ID '" + sle_shift_id.Text + "' was not found.")
			ROLLBACK USING SQLCA;
		ELSE
			COMMIT USING SQLCA;
			MessageBox("Success", "Shift restarted successfully.")
		END IF		
	ELSE
		MessageBox("Failed to Restart Shift", "A database error has occurred. Code " + string(sqlca.sqldbcode) + ": " + sqlca.sqlerrtext)
		ROLLBACK USING SQLCA;
	END IF
ELSE
	MessageBox("No Shift ID", "Please enter a shift ID.")
END IF
end event

