$PBExportHeader$w_picture_file.srw
forward
global type w_picture_file from w_popup
end type
type cb_add from commandbutton within w_picture_file
end type
type cb_select from commandbutton within w_picture_file
end type
end forward

global type w_picture_file from w_popup
integer x = 214
integer width = 2264
integer height = 1114
cb_add cb_add
cb_select cb_select
end type
global w_picture_file w_picture_file

type variables
String is_path, is_file
end variables

on w_picture_file.create
int iCurrent
call super::create
this.cb_add=create cb_add
this.cb_select=create cb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add
this.Control[iCurrent+2]=this.cb_select
end on

on w_picture_file.destroy
call super::destroy
destroy(this.cb_add)
destroy(this.cb_select)
end on

type cb_add from commandbutton within w_picture_file
integer x = 1375
integer y = 845
integer width = 351
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Add Picture"
end type

event clicked;FileCopy(is_path , "C:\tmp\test.jpg" )

return 1
end event

type cb_select from commandbutton within w_picture_file
integer x = 644
integer y = 845
integer width = 351
integer height = 90
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Select Picture"
boolean cancel = true
end type

event clicked;GetFileOpenName("Select File", is_path, is_file, "JPG Files", "JPG Files (*.JPG),*.JPG*", "E:\PHOTO", 18)

return 1
end event

