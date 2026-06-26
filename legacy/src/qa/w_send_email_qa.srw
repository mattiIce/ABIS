$PBExportHeader$w_send_email_qa.srw
forward
global type w_send_email_qa from w_response
end type
type plb_back from picturelistbox within w_send_email_qa
end type
type st_4 from statictext within w_send_email_qa
end type
type mle_message from multilineedit within w_send_email_qa
end type
type sle_subject from singlelineedit within w_send_email_qa
end type
type cb_2 from u_cb within w_send_email_qa
end type
type cb_1 from u_cb within w_send_email_qa
end type
type cb_delete_pic from u_cb within w_send_email_qa
end type
type p_coil from picture within w_send_email_qa
end type
type cb_add_pic from u_cb within w_send_email_qa
end type
type plb_qa from picturelistbox within w_send_email_qa
end type
type st_1 from statictext within w_send_email_qa
end type
end forward

global type w_send_email_qa from w_response
integer width = 2337
integer height = 1923
string title = "QA E-Mail"
event type integer ue_send ( )
event type integer ue_show_pic ( )
event type integer ue_delete_picture ( )
event type integer ue_add_picture ( )
plb_back plb_back
st_4 st_4
mle_message mle_message
sle_subject sle_subject
cb_2 cb_2
cb_1 cb_1
cb_delete_pic cb_delete_pic
p_coil p_coil
cb_add_pic cb_add_pic
plb_qa plb_qa
st_1 st_1
end type
global w_send_email_qa w_send_email_qa

type variables
Long il_coil_abc_num
String is_path
end variables

event type integer ue_send();String ls_send_text		
mailSession lm_ses
mailReturnCode lm_rc
mailMessage lm_msg
mailFileDescription lmf_file	
Int i, li_total_pic

lm_ses = create mailSession
			
lm_rc = lm_ses.mailLogon(mailNewSession!)
if lm_rc <> mailReturnSuccess! then
	MessageBox ("Mail", 'Mail Logon Failed.')
end if
			
lm_msg.Subject = sle_subject.Text
lm_msg.NoteText = mle_message.Text

li_total_pic = plb_qa.TotalItems()
for i = 1 to li_total_pic
	lmf_file.FileType = mailAttach!
	lmf_file.FileName = plb_qa.Text(i)
	lmf_file.PathName = is_path + "\" + String(il_coil_abc_num) + "\" + plb_qa.Text(i)
	lmf_file.Position = i - 1
	lm_msg.Attachmentfile[i] = lmf_file
next

lm_rc = lm_ses.mailAddress(lm_msg)
IF lm_rc <> mailReturnSuccess! THEN
    MessageBox("Mail", 'Addressing failed.')
    RETURN 0
END IF


lm_rc = lm_ses.mailSend(lm_msg)
			
if lm_rc <> mailReturnSuccess! then
	MessageBox("Mail Send Status", 'Mail send failed')
end if
			
lm_ses.mailLogoff()
Destroy lm_ses
			
return 1

end event

event type integer ue_show_pic();Int li_total_pic, i, li_pic_index
String ls_item_name

if isnull(il_coil_abc_num) or il_coil_abc_num = 0 then
	return 0
end if

plb_back.Reset()
plb_qa.Reset()
p_coil.picturename = "."

plb_back.DirList(is_path + "\" + String(il_coil_abc_num) + "\*.JPG", 0)
li_total_pic = plb_back.TotalItems()
IF li_total_pic > 0 THEN
	plb_qa.PictureHeight = 50
	plb_qa.PictureWidth = 50
	for i = 1 to li_total_pic
		ls_item_name =plb_back.Text(i)
		li_pic_index = plb_qa.AddPicture(is_path + "\"  + String(il_coil_abc_num) + "\" + ls_item_name)
		plb_qa.Additem(ls_item_name, li_pic_index)
		if i = 1 then
			p_coil.picturename = is_path + "\" + String(il_coil_abc_num) + "\" + ls_item_name
		end if
	next	
	
END IF


return 1
end event

event type integer ue_delete_picture();String ls_item_name
Int li_rc, li_index

li_index = plb_qa.selectedindex()

if li_index < 1 then return 0

plb_qa.deleteitem(li_index)

ls_item_name =plb_back.Text(1)
p_coil.picturename = is_path + "\" + String(il_coil_abc_num) + "\" + ls_item_name

return 1

//ls_item_name = plb_qa.Text(li_index)
//li_rc = MessageBox("Delete", "Do you want to delete " + ls_item_name + "?", Question!, YesNo!)
//if li_rc =1  then
//	FileDelete(is_path + "\" + String(il_coil_abc_num) + "\" + ls_item_name)
//	this.event ue_show_pic()
//	return 1
//else
//	return 0
//end if

end event

event type integer ue_add_picture();//String ls_path, ls_file[], ls_singlefilename
//Int li_rc, li_num, i
//
//if NOT DirectoryExists(is_path + "\" + String(il_coil_abc_num)) then
//	CreateDirectory(is_path + "\" + String(il_coil_abc_num))
//end if
//
//li_rc = GetFileSaveName("Select File", ls_path, ls_file[], "JPG Files", "JPG Files (*.JPG),*.JPG", "P:\", 18)
//
//if li_rc < 1 then return 0
//
//li_num = Upperbound(ls_file)
//if li_num = 1 then
//   filecopy(ls_path, is_path + "\" + String(il_coil_abc_num) + "\" +ls_file[1])
//else
//	for i= 1 to li_num
//		filecopy(ls_path + "\" + ls_file[i], is_path + "\" + String(il_coil_abc_num) + "\" + ls_file[i])
//   next
//end if
//
//this.event ue_show_pic()
return 1
end event

on w_send_email_qa.create
int iCurrent
call super::create
this.plb_back=create plb_back
this.st_4=create st_4
this.mle_message=create mle_message
this.sle_subject=create sle_subject
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_delete_pic=create cb_delete_pic
this.p_coil=create p_coil
this.cb_add_pic=create cb_add_pic
this.plb_qa=create plb_qa
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.plb_back
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.mle_message
this.Control[iCurrent+4]=this.sle_subject
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_delete_pic
this.Control[iCurrent+8]=this.p_coil
this.Control[iCurrent+9]=this.cb_add_pic
this.Control[iCurrent+10]=this.plb_qa
this.Control[iCurrent+11]=this.st_1
end on

on w_send_email_qa.destroy
call super::destroy
destroy(this.plb_back)
destroy(this.st_4)
destroy(this.mle_message)
destroy(this.sle_subject)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_delete_pic)
destroy(this.p_coil)
destroy(this.cb_add_pic)
destroy(this.plb_qa)
destroy(this.st_1)
end on

event open;call super::open;il_coil_abc_num = Message.DoubleParm
is_path = ProfileString(gs_ini_file, "QA_PICTURE","FOLDER_BASE","E:\PHOTO")

sle_subject.Text = "Quality issue of Coil ABC# " + String(il_coil_abc_num)

this.event ue_show_pic()
end event

type plb_back from picturelistbox within w_send_email_qa
boolean visible = false
integer x = 59
integer y = 998
integer width = 176
integer height = 77
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
end type

type st_4 from statictext within w_send_email_qa
integer x = 88
integer y = 845
integer width = 453
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Picture Attached:"
boolean focusrectangle = false
end type

type mle_message from multilineedit within w_send_email_qa
integer x = 88
integer y = 205
integer width = 2136
integer height = 589
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_subject from singlelineedit within w_send_email_qa
integer x = 351
integer y = 51
integer width = 1872
integer height = 77
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from u_cb within w_send_email_qa
integer x = 1492
integer y = 1690
integer width = 421
integer height = 99
integer taborder = 60
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_1 from u_cb within w_send_email_qa
integer x = 614
integer y = 1690
integer width = 421
integer height = 99
integer taborder = 50
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Send"
end type

event clicked;call super::clicked;parent.event ue_send()
end event

type cb_delete_pic from u_cb within w_send_email_qa
integer x = 1814
integer y = 1331
integer width = 421
integer height = 99
integer taborder = 40
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete Picture"
end type

event clicked;call super::clicked;//parent.Event ue_delete_picture()
end event

type p_coil from picture within w_send_email_qa
integer x = 965
integer y = 922
integer width = 790
integer height = 691
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_add_pic from u_cb within w_send_email_qa
integer x = 1814
integer y = 1050
integer width = 421
integer height = 99
integer taborder = 30
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Add Picture"
end type

event clicked;call super::clicked;//parent.Event ue_add_picture()
end event

type plb_qa from picturelistbox within w_send_email_qa
integer x = 293
integer y = 922
integer width = 614
integer height = 691
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
end type

event selectionchanged;String ls_item_name

ls_item_name =this.Text(INDEX)

p_coil.picturename = is_path + "\" + String(il_coil_abc_num) + "\" + ls_item_name
end event

type st_1 from statictext within w_send_email_qa
integer x = 88
integer y = 64
integer width = 234
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Subject: "
boolean focusrectangle = false
end type

