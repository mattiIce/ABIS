$PBExportHeader$w_new_qa_coil.srw
forward
global type w_new_qa_coil from w_sheet
end type
type st_3 from statictext within w_new_qa_coil
end type
type cb_select from u_cb within w_new_qa_coil
end type
type st_2 from statictext within w_new_qa_coil
end type
type plb_back from picturelistbox within w_new_qa_coil
end type
type st_1 from statictext within w_new_qa_coil
end type
type cb_save from commandbutton within w_new_qa_coil
end type
type cb_email from commandbutton within w_new_qa_coil
end type
type cb_close from commandbutton within w_new_qa_coil
end type
type cb_delete_pic from u_cb within w_new_qa_coil
end type
type cb_add_pic from u_cb within w_new_qa_coil
end type
type p_coil from picture within w_new_qa_coil
end type
type plb_qa from picturelistbox within w_new_qa_coil
end type
type dw_coil_detail from u_dw within w_new_qa_coil
end type
type cb_enter from u_cb within w_new_qa_coil
end type
type sle_coil_num from singlelineedit within w_new_qa_coil
end type
type gb_1 from groupbox within w_new_qa_coil
end type
type gb_2 from groupbox within w_new_qa_coil
end type
end forward

global type w_new_qa_coil from w_sheet
integer width = 2604
integer height = 2061
string title = "New QA Coil"
event type integer ue_coil_num_search ( )
event type integer ue_save ( )
event type integer ue_show_pic ( )
event type integer ue_add_picture ( )
event type integer ue_delete_picture ( )
st_3 st_3
cb_select cb_select
st_2 st_2
plb_back plb_back
st_1 st_1
cb_save cb_save
cb_email cb_email
cb_close cb_close
cb_delete_pic cb_delete_pic
cb_add_pic cb_add_pic
p_coil p_coil
plb_qa plb_qa
dw_coil_detail dw_coil_detail
cb_enter cb_enter
sle_coil_num sle_coil_num
gb_1 gb_1
gb_2 gb_2
end type
global w_new_qa_coil w_new_qa_coil

type variables
Long il_coil_abc_num
String is_path, is_folder_base
n_cst_filesrv inv_filesrv
end variables

event type integer ue_coil_num_search();Long ll_coil_abc_num
String ls_coil_org_num
Int li_row_count, li_rc

if Len(sle_coil_num.text) <= 0 then
	Messagebox("Coil Number Error", "Please enter a coil number then try again.")
	return 0
end if

ll_coil_abc_num = Long(sle_coil_num.Text)

li_rc = 0

SELECT COUNT(coil_abc_num) INTO :li_rc
FROM coil
WHERE coil_abc_num = :ll_coil_abc_num
USING SQLCA;

IF li_rc <= 0 THEN
	MessageBox("Error", "Coil not found. Please input a valid coil ABC number", StopSign!)
	Return  0
END IF

il_coil_abc_num = ll_coil_abc_num
dw_coil_detail.Retrieve(il_coil_abc_num)


return 1
end event

event type integer ue_save();//change coil status to 11:QA OnHold
update coil
set coil_status = 11
where coil_abc_num = :il_coil_abc_num
using SQLCA;

commit using SQLCA;


//save picture into coil picture folder
inv_filesrv.of_CreateDirectory(is_folder_base + "\" + String(il_coil_abc_num))

Run("cmd /c move " + is_path + "\*.JPG " + is_folder_base + "\" + String(il_coil_abc_num), Minimized!)

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

plb_back.DirList(is_path + "\*.JPG", 0)
li_total_pic = plb_back.TotalItems()
IF li_total_pic > 0 THEN
	plb_qa.PictureHeight = 50
	plb_qa.PictureWidth = 50
	for i = 1 to li_total_pic
		ls_item_name =plb_back.Text(i)
		li_pic_index = plb_qa.AddPicture(is_path + "\" + ls_item_name)
		plb_qa.Additem(ls_item_name, li_pic_index)
		if i = 1 then
			p_coil.picturename = is_path + "\" + ls_item_name
		end if
	next	
	
END IF
return 1
end event

event type integer ue_add_picture();String ls_path, ls_file[], ls_singlefilename
Int li_rc, li_num, i

if NOT DirectoryExists(is_path) then
	CreateDirectory(is_path)
end if

li_rc = GetFileSaveName("Select File", ls_path, ls_file[], "JPG Files", "JPG Files (*.JPG),*.JPG", "P:\", 18)

if li_rc < 1 then return 0

li_num = Upperbound(ls_file)
if li_num = 1 then
   filecopy(ls_path, is_path  + "\" +ls_file[1])
else
	for i= 1 to li_num
		filecopy(ls_path + "\" + ls_file[i], is_path  + "\" + ls_file[i])
   next
end if

this.event ue_show_pic()

return 1
end event

event type integer ue_delete_picture();String ls_item_name
Int li_rc, li_index

li_index = plb_qa.selectedindex()

if li_index < 1 then return 0

ls_item_name = plb_qa.Text(li_index)

li_rc = MessageBox("Delete", "Do you want to delete " + ls_item_name + "?", Question!, YesNo!)
if li_rc =1  then
	FileDelete(is_path + "\" + ls_item_name)
	this.event ue_show_pic()
	return 1
else
	return 0
end if
end event

on w_new_qa_coil.create
int iCurrent
call super::create
this.st_3=create st_3
this.cb_select=create cb_select
this.st_2=create st_2
this.plb_back=create plb_back
this.st_1=create st_1
this.cb_save=create cb_save
this.cb_email=create cb_email
this.cb_close=create cb_close
this.cb_delete_pic=create cb_delete_pic
this.cb_add_pic=create cb_add_pic
this.p_coil=create p_coil
this.plb_qa=create plb_qa
this.dw_coil_detail=create dw_coil_detail
this.cb_enter=create cb_enter
this.sle_coil_num=create sle_coil_num
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.plb_back
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_email
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_delete_pic
this.Control[iCurrent+10]=this.cb_add_pic
this.Control[iCurrent+11]=this.p_coil
this.Control[iCurrent+12]=this.plb_qa
this.Control[iCurrent+13]=this.dw_coil_detail
this.Control[iCurrent+14]=this.cb_enter
this.Control[iCurrent+15]=this.sle_coil_num
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
end on

on w_new_qa_coil.destroy
call super::destroy
destroy(this.st_3)
destroy(this.cb_select)
destroy(this.st_2)
destroy(this.plb_back)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.cb_email)
destroy(this.cb_close)
destroy(this.cb_delete_pic)
destroy(this.cb_add_pic)
destroy(this.p_coil)
destroy(this.plb_qa)
destroy(this.dw_coil_detail)
destroy(this.cb_enter)
destroy(this.sle_coil_num)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;F_SetFilesrv(inv_filesrv, TRUE)

dw_coil_detail.SetTransObject(SQLCA)

is_path = ProfileString(gs_ini_file, "QA_PICTURE","LOCAL_FOLDER_BASE","C:\COILPHOTO")
is_folder_base = ProfileString(gs_ini_file, "QA_PICTURE","FOLDER_BASE","E:\PHOTO")

end event

type st_3 from statictext within w_new_qa_coil
integer x = 1755
integer y = 102
integer width = 636
integer height = 51
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "to select Coil ABC Number."
boolean focusrectangle = false
end type

type cb_select from u_cb within w_new_qa_coil
integer x = 1346
integer y = 77
integer width = 369
integer height = 99
integer taborder = 30
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;call super::clicked;Long ll_rc

Open(w_coil_list_select)

ll_rc = Message.DoubleParm
if (Not IsNull(ll_rc)) and ll_rc <> 0 then
	il_coil_abc_num = ll_rc
	dw_coil_detail.Retrieve(il_coil_abc_num)
	sle_coil_num.text = String(il_coil_abc_num)	
end if
end event

type st_2 from statictext within w_new_qa_coil
integer x = 1258
integer y = 102
integer width = 59
integer height = 51
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "or"
boolean focusrectangle = false
end type

type plb_back from picturelistbox within w_new_qa_coil
integer x = 2926
integer y = 1280
integer width = 176
integer height = 77
integer taborder = 80
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

type st_1 from statictext within w_new_qa_coil
integer x = 88
integer y = 102
integer width = 468
integer height = 77
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Coil ABC Number"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_new_qa_coil
integer x = 410
integer y = 1818
integer width = 421
integer height = 99
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Save"
end type

event clicked;parent.event ue_save()
end event

type cb_email from commandbutton within w_new_qa_coil
integer x = 1112
integer y = 1818
integer width = 421
integer height = 99
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Send &E-Mail"
end type

type cb_close from commandbutton within w_new_qa_coil
integer x = 1755
integer y = 1818
integer width = 421
integer height = 99
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Run("cmd /c del " + is_path + "\*.* /Q", Minimized!)

Close(Parent)
end event

type cb_delete_pic from u_cb within w_new_qa_coil
integer x = 1902
integer y = 1434
integer width = 369
integer height = 99
integer taborder = 90
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete Picture"
end type

event clicked;call super::clicked;parent.Event ue_delete_picture()
end event

type cb_add_pic from u_cb within w_new_qa_coil
integer x = 1902
integer y = 1126
integer width = 369
integer height = 99
integer taborder = 70
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Add Picture"
end type

event clicked;call super::clicked;parent.Event ue_add_picture()
end event

type p_coil from picture within w_new_qa_coil
integer x = 848
integer y = 998
integer width = 790
integer height = 691
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type plb_qa from picturelistbox within w_new_qa_coil
integer x = 117
integer y = 998
integer width = 614
integer height = 691
integer taborder = 50
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

p_coil.picturename = is_path  + "\" + ls_item_name
end event

type dw_coil_detail from u_dw within w_new_qa_coil
integer x = 117
integer y = 307
integer width = 2341
integer height = 538
integer taborder = 40
string dataobject = "d_coil_detail_display_qa"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//of_SetBase(TRUE)
//of_SetRowSelect(TRUE)
//of_SetRowManager(TRUE)
//of_SetSort(TRUE)
//inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 ) 
end event

type cb_enter from u_cb within w_new_qa_coil
integer x = 848
integer y = 77
integer width = 369
integer height = 99
integer taborder = 20
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Enter"
boolean default = true
end type

event clicked;call super::clicked;parent.event ue_coil_num_search()
end event

type sle_coil_num from singlelineedit within w_new_qa_coil
integer x = 556
integer y = 77
integer width = 263
integer height = 99
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_new_qa_coil
integer x = 59
integer y = 230
integer width = 2458
integer height = 666
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Coil Details"
end type

type gb_2 from groupbox within w_new_qa_coil
integer x = 59
integer y = 915
integer width = 2458
integer height = 845
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 80263581
string text = "Coil Picture"
end type

