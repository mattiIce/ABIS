$PBExportHeader$w_sample_sticker.srw
forward
global type w_sample_sticker from window
end type
type st_coils_4job from statictext within w_sample_sticker
end type
type cb_retrieve from commandbutton within w_sample_sticker
end type
type cb_getsize from commandbutton within w_sample_sticker
end type
type dw_coils_4job from datawindow within w_sample_sticker
end type
type cb_close from commandbutton within w_sample_sticker
end type
type cb_print from commandbutton within w_sample_sticker
end type
type dw_sample_sticker from datawindow within w_sample_sticker
end type
end forward

global type w_sample_sticker from window
integer width = 2912
integer height = 2324
boolean titlebar = true
string title = "Print Coil Sample Sticker"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_coils_4job st_coils_4job
cb_retrieve cb_retrieve
cb_getsize cb_getsize
dw_coils_4job dw_coils_4job
cb_close cb_close
cb_print cb_print
dw_sample_sticker dw_sample_sticker
end type
global w_sample_sticker w_sample_sticker

type variables
Long		il_ab_job_num
String	is_location
end variables

on w_sample_sticker.create
this.st_coils_4job=create st_coils_4job
this.cb_retrieve=create cb_retrieve
this.cb_getsize=create cb_getsize
this.dw_coils_4job=create dw_coils_4job
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_sample_sticker=create dw_sample_sticker
this.Control[]={this.st_coils_4job,&
this.cb_retrieve,&
this.cb_getsize,&
this.dw_coils_4job,&
this.cb_close,&
this.cb_print,&
this.dw_sample_sticker}
end on

on w_sample_sticker.destroy
destroy(this.st_coils_4job)
destroy(this.cb_retrieve)
destroy(this.cb_getsize)
destroy(this.dw_coils_4job)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_sample_sticker)
end on

event open;Long		ll_coil_abc_num
Integer	li_count, li_rows, li_row, li_selected_row

dw_sample_sticker.SetTransObject(sqlca)
is_location = ProfileString(gs_ini_file, "APPLICATION","location","SHOP")
il_ab_job_num = Message.DoubleParm

dw_coils_4job.SetTransObject(sqlca)
li_rows = dw_coils_4job.Retrieve(il_ab_job_num)

If li_rows < 0 Then //DB error
	MessageBox("DB error", "Database error in Open event for w_sample_sticker while retrieving coils for job " + String(il_ab_job_num) + "~n~r~n~rError:~n~r" + sqlca.SqlErrText)	
	Return -1
ElseIf li_rows = 0 Then //No coils
	Return 0
End If

st_coils_4job.Text = "Coils for job " + String(il_ab_job_num)

If li_rows = 1 Then
	This.Width = 1870 //Hide dw_coils_4job
	ll_coil_abc_num = dw_coils_4job.Object.coil_abc_num[1]
	li_rows = dw_sample_sticker.Retrieve(il_ab_job_num, ll_coil_abc_num)
Else
	This.Width = 2903 //Show dw_coils_4job
End If

cb_getsize.Visible = False
dw_sample_sticker.SetRow(1)
dw_sample_sticker.SetColumn("shift")




end event

event doubleclicked;MessageBox("", "Window Width: " + String(This.Width) + &
					"~n~rWindow Height: " + String(This.Height) + &
					"~n~rWindow X: " + String(This.X) + &
					"~n~rWindow Y: " + String(This.Y))
end event

type st_coils_4job from statictext within w_sample_sticker
integer x = 1865
integer y = 64
integer width = 914
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_sample_sticker
integer x = 110
integer y = 2080
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;Integer	li_rows, li_selected_row
Long		ll_coil_abc_num

li_rows = dw_coils_4job.RowCount()

If li_rows = 1 Then
	ll_coil_abc_num = dw_coils_4job.Object.coil_abc_num[1]
Else //li_rows > 1
	li_selected_row = dw_coils_4job.GetSelectedRow(0)
	
	If li_selected_row > 0 Then
		ll_coil_abc_num = dw_coils_4job.Object.coil_abc_num[li_selected_row]
	Else
		MessageBox("Coil not selected", "Please select a coil", StopSign!)
		Return
	End If
End If

li_rows = dw_sample_sticker.Retrieve(il_ab_job_num, ll_coil_abc_num)

//MessageBox("Clicked event for cb_retrieve", "li_rows = " + String(li_rows))

If li_rows > 0 Then
	dw_sample_sticker.SetFocus()
	dw_sample_sticker.SetRow(1)
	dw_sample_sticker.SetColumn("shift")
End If
end event

type cb_getsize from commandbutton within w_sample_sticker
integer x = 882
integer y = 2080
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Get Size"
end type

event clicked;MessageBox("", "Window Width: " + String(Parent.Width) + &
					"~n~rWindow Height: " + String(Parent.Height) + &
					"~n~rWindow X: " + String(Parent.X) + &
					"~n~rWindow Y: " + String(Parent.Y))
end event

type dw_coils_4job from datawindow within w_sample_sticker
integer x = 1865
integer y = 140
integer width = 914
integer height = 544
integer taborder = 20
string title = "none"
string dataobject = "d_coils_4job_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row > 0 Then
	If This.IsSelected(row) Then
		This.SelectRow(row, False)
	Else
		This.SelectRow(0, False)
		This.SelectRow(row, True)
		cb_retrieve.Event Clicked() //Alex Gerlants. 10/29/2024. 
	End If
End If
end event

event doubleclicked;cb_retrieve.Event Clicked()
end event

type cb_close from commandbutton within w_sample_sticker
integer x = 1390
integer y = 2080
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type cb_print from commandbutton within w_sample_sticker
integer x = 498
integer y = 2080
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;
Integer	li_rtn

dw_sample_sticker.AcceptText()

//is_location = "SHOP" //TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY. TEST ONLY.

If Upper(is_location) = "OFFICE" Then
	li_rtn = Printsetup()
	
	If li_rtn = -1 Then //Error in PrintSetup() or user clicked on "Cancel"
		Return 1
	End If
End If

dw_sample_sticker.Print()
dw_sample_sticker.Print()
end event

type dw_sample_sticker from datawindow within w_sample_sticker
integer x = 110
integer y = 64
integer width = 1609
integer height = 1952
integer taborder = 10
string title = "none"
string dataobject = "d_sample_sticker"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

