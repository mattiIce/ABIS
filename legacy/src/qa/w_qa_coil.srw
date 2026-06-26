$PBExportHeader$w_qa_coil.srw
forward
global type w_qa_coil from w_sheet
end type
type cb_1 from commandbutton within w_qa_coil
end type
type cb_new_qa_coil from commandbutton within w_qa_coil
end type
type p_coil from picture within w_qa_coil
end type
type plb_back from picturelistbox within w_qa_coil
end type
type plb_qa from picturelistbox within w_qa_coil
end type
type st_2 from statictext within w_qa_coil
end type
type cb_change from commandbutton within w_qa_coil
end type
type cb_new from commandbutton within w_qa_coil
end type
type st_3 from statictext within w_qa_coil
end type
type cb_coil_num_search from u_cb within w_qa_coil
end type
type sle_coil_num from singlelineedit within w_qa_coil
end type
type st_1 from statictext within w_qa_coil
end type
type rb_org_num from u_rb within w_qa_coil
end type
type rb_abc_num from u_rb within w_qa_coil
end type
type cb_search from u_cb within w_qa_coil
end type
type rb_allday from u_rb within w_qa_coil
end type
type rb_180day from u_rb within w_qa_coil
end type
type rb_30day from u_rb within w_qa_coil
end type
type rb_60day from u_rb within w_qa_coil
end type
type rb_all from u_rb within w_qa_coil
end type
type rb_cust from u_rb within w_qa_coil
end type
type dw_coil_list from u_dw within w_qa_coil
end type
type dw_customer from u_dw within w_qa_coil
end type
type cb_print from commandbutton within w_qa_coil
end type
type cb_close from commandbutton within w_qa_coil
end type
type cb_email from commandbutton within w_qa_coil
end type
type cb_delete_pic from u_cb within w_qa_coil
end type
type cb_add_pic from u_cb within w_qa_coil
end type
type dw_coil_track_qa from u_dw within w_qa_coil
end type
type rb_historic from u_rb within w_qa_coil
end type
type rb_current from u_rb within w_qa_coil
end type
type ddlb_customer from dropdownlistbox within w_qa_coil
end type
type gb_2 from u_gb within w_qa_coil
end type
type gb_1 from u_gb within w_qa_coil
end type
type gb_3 from u_gb within w_qa_coil
end type
type gb_5 from u_gb within w_qa_coil
end type
type gb_6 from groupbox within w_qa_coil
end type
type gb_7 from u_gb within w_qa_coil
end type
type gb_8 from groupbox within w_qa_coil
end type
type gb_9 from groupbox within w_qa_coil
end type
end forward

global type w_qa_coil from w_sheet
integer y = 10
integer width = 4169
integer height = 2138
string title = "Coil Quality Assurance"
boolean resizable = false
event ue_read_only ( )
event type integer ue_coil_num_search ( )
event type integer ue_search ( )
event type integer ue_add_picture ( )
event type integer ue_delete_picture ( )
event type integer ue_show_pic ( )
cb_1 cb_1
cb_new_qa_coil cb_new_qa_coil
p_coil p_coil
plb_back plb_back
plb_qa plb_qa
st_2 st_2
cb_change cb_change
cb_new cb_new
st_3 st_3
cb_coil_num_search cb_coil_num_search
sle_coil_num sle_coil_num
st_1 st_1
rb_org_num rb_org_num
rb_abc_num rb_abc_num
cb_search cb_search
rb_allday rb_allday
rb_180day rb_180day
rb_30day rb_30day
rb_60day rb_60day
rb_all rb_all
rb_cust rb_cust
dw_coil_list dw_coil_list
dw_customer dw_customer
cb_print cb_print
cb_close cb_close
cb_email cb_email
cb_delete_pic cb_delete_pic
cb_add_pic cb_add_pic
dw_coil_track_qa dw_coil_track_qa
rb_historic rb_historic
rb_current rb_current
ddlb_customer ddlb_customer
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
gb_5 gb_5
gb_6 gb_6
gb_7 gb_7
gb_8 gb_8
gb_9 gb_9
end type
global w_qa_coil w_qa_coil

type variables
Long il_coil_abc_num
String is_path
end variables

event ue_read_only();//dw_coil_modify.Object.DataWindow.ReadOnly = "YES"
//cb_save.Enabled = FALSE
//cb_cancel.Enabled = FALSE
cb_add_pic.Enabled = FALSE
cb_delete_pic.Enabled = FALSE
cb_new.Enabled = FALSE
cb_change.Enabled = FALSE
end event

event type integer ue_coil_num_search();Long ll_coil_abc_num
String ls_coil_org_num
Int li_row_count, li_rc

if Len(sle_coil_num.text) <= 0 then
	Messagebox("Coil Number Error", "Please enter a coil number then try again.")
	return 0
end if

if rb_abc_num.Checked = true then
	ll_coil_abc_num = Long(sle_coil_num.text)
	dw_coil_list.DataObject = "d_coil_list_by_coil_abc_num"
	dw_coil_list.SetTransObject(SQLCA)
	dw_coil_list.Retrieve(ll_coil_abc_num)
else
	ls_coil_org_num = sle_coil_num.text
	dw_coil_list.DataObject = "d_coil_list_by_coil_org_num"
	dw_coil_list.SetTransObject(SQLCA)
	dw_coil_list.Retrieve(ls_coil_org_num)
end if	

li_row_count = dw_coil_list.RowCount()
if li_row_count < 1 then
	li_rc = MessageBox("Question", "No QA record found for this coil. Do you want to create one?", Question!, YesNo!)
	if li_rc = 1 then
		/*call up new QA issue window*/
	end if
end if

return 1
end event

event type integer ue_search();Long ll_customer_id

if rb_current.Checked = True then	//For currently QA coil
	
	if rb_all.Checked = True then		//For all customers
		dw_coil_list.DataObject = "d_coil_list_qa_all_cust"
		dw_coil_list.SetTransObject(SQLCA)
		if rb_30day.Checked = True then		//within 30 days
			dw_coil_list.Retrieve(Relativedate(Today(), -30))
		elseif rb_60day.Checked = True then		//within 60 days
			dw_coil_list.Retrieve(Relativedate(Today(), -60))
		elseif rb_180day.Checked = True then		//within 180 days
			dw_coil_list.Retrieve(Relativedate(Today(), -180))
		else	//all time
			dw_coil_list.Retrieve(Relativedate(Today(), -3650))
		end if
	else		//For specific customer
		dw_coil_list.DataObject = "d_coil_list_qa_by_cust"
		dw_coil_list.SetTransObject(SQLCA)
		if rb_30day.Checked = True then		//within 30 days
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -30))
		elseif rb_60day.Checked = True then		//within 60 days
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -60))
		elseif rb_180day.Checked = True then		//within 180 days
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -180))
		else	//all time
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -3650))
		end if
	end if

else		//For historic QA coils
	if rb_all.Checked = True then		//For all customers
		dw_coil_list.DataObject = "d_coil_list_qa_historic_all_cust"
		dw_coil_list.SetTransObject(SQLCA)
		if rb_30day.Checked = True then		//within 30 days
			dw_coil_list.Retrieve(Relativedate(Today(), -30))
		elseif rb_60day.Checked = True then		//within 60 days
			dw_coil_list.Retrieve(Relativedate(Today(), -60))
		elseif rb_180day.Checked = True then		//within 180 days
			dw_coil_list.Retrieve(Relativedate(Today(), -180))
		else	//all time
			dw_coil_list.Retrieve(Relativedate(Today(), -3650))
		end if
	else		//For specific customer
		dw_coil_list.DataObject = "d_coil_list_historic_qa_by_cust"
		dw_coil_list.SetTransObject(SQLCA)
		if rb_30day.Checked = True then		//within 30 days
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -30))
		elseif rb_60day.Checked = True then		//within 60 days
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -60))
		elseif rb_180day.Checked = True then		//within 180 days
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -180))
		else	//all time
			dw_coil_list.Retrieve(ll_customer_id, Relativedate(Today(), -3650))
		end if
	end if
	
end if

return 1
end event

event type integer ue_add_picture();String ls_path, ls_file[], ls_singlefilename
Int li_rc, li_num, i

if NOT DirectoryExists(is_path + "\" + String(il_coil_abc_num)) then
	CreateDirectory(is_path + "\" + String(il_coil_abc_num))
end if

li_rc = GetFileSaveName("Select File", ls_path, ls_file[], "JPG Files", "JPG Files (*.JPG),*.JPG", "P:\", 18)

if li_rc < 1 then return 0

li_num = Upperbound(ls_file)
if li_num = 1 then
   filecopy(ls_path, is_path + "\" + String(il_coil_abc_num) + "\" +ls_file[1])
else
	for i= 1 to li_num
		filecopy(ls_path + "\" + ls_file[i], is_path + "\" + String(il_coil_abc_num) + "\" + ls_file[i])
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
	FileDelete(is_path + "\" + String(il_coil_abc_num) + "\" + ls_item_name)
	this.event ue_show_pic()
	return 1
else
	return 0
end if


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

on w_qa_coil.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_new_qa_coil=create cb_new_qa_coil
this.p_coil=create p_coil
this.plb_back=create plb_back
this.plb_qa=create plb_qa
this.st_2=create st_2
this.cb_change=create cb_change
this.cb_new=create cb_new
this.st_3=create st_3
this.cb_coil_num_search=create cb_coil_num_search
this.sle_coil_num=create sle_coil_num
this.st_1=create st_1
this.rb_org_num=create rb_org_num
this.rb_abc_num=create rb_abc_num
this.cb_search=create cb_search
this.rb_allday=create rb_allday
this.rb_180day=create rb_180day
this.rb_30day=create rb_30day
this.rb_60day=create rb_60day
this.rb_all=create rb_all
this.rb_cust=create rb_cust
this.dw_coil_list=create dw_coil_list
this.dw_customer=create dw_customer
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_email=create cb_email
this.cb_delete_pic=create cb_delete_pic
this.cb_add_pic=create cb_add_pic
this.dw_coil_track_qa=create dw_coil_track_qa
this.rb_historic=create rb_historic
this.rb_current=create rb_current
this.ddlb_customer=create ddlb_customer
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_9=create gb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_new_qa_coil
this.Control[iCurrent+3]=this.p_coil
this.Control[iCurrent+4]=this.plb_back
this.Control[iCurrent+5]=this.plb_qa
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_change
this.Control[iCurrent+8]=this.cb_new
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.cb_coil_num_search
this.Control[iCurrent+11]=this.sle_coil_num
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.rb_org_num
this.Control[iCurrent+14]=this.rb_abc_num
this.Control[iCurrent+15]=this.cb_search
this.Control[iCurrent+16]=this.rb_allday
this.Control[iCurrent+17]=this.rb_180day
this.Control[iCurrent+18]=this.rb_30day
this.Control[iCurrent+19]=this.rb_60day
this.Control[iCurrent+20]=this.rb_all
this.Control[iCurrent+21]=this.rb_cust
this.Control[iCurrent+22]=this.dw_coil_list
this.Control[iCurrent+23]=this.dw_customer
this.Control[iCurrent+24]=this.cb_print
this.Control[iCurrent+25]=this.cb_close
this.Control[iCurrent+26]=this.cb_email
this.Control[iCurrent+27]=this.cb_delete_pic
this.Control[iCurrent+28]=this.cb_add_pic
this.Control[iCurrent+29]=this.dw_coil_track_qa
this.Control[iCurrent+30]=this.rb_historic
this.Control[iCurrent+31]=this.rb_current
this.Control[iCurrent+32]=this.ddlb_customer
this.Control[iCurrent+33]=this.gb_2
this.Control[iCurrent+34]=this.gb_1
this.Control[iCurrent+35]=this.gb_3
this.Control[iCurrent+36]=this.gb_5
this.Control[iCurrent+37]=this.gb_6
this.Control[iCurrent+38]=this.gb_7
this.Control[iCurrent+39]=this.gb_8
this.Control[iCurrent+40]=this.gb_9
end on

on w_qa_coil.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_new_qa_coil)
destroy(this.p_coil)
destroy(this.plb_back)
destroy(this.plb_qa)
destroy(this.st_2)
destroy(this.cb_change)
destroy(this.cb_new)
destroy(this.st_3)
destroy(this.cb_coil_num_search)
destroy(this.sle_coil_num)
destroy(this.st_1)
destroy(this.rb_org_num)
destroy(this.rb_abc_num)
destroy(this.cb_search)
destroy(this.rb_allday)
destroy(this.rb_180day)
destroy(this.rb_30day)
destroy(this.rb_60day)
destroy(this.rb_all)
destroy(this.rb_cust)
destroy(this.dw_coil_list)
destroy(this.dw_customer)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_email)
destroy(this.cb_delete_pic)
destroy(this.cb_add_pic)
destroy(this.dw_coil_track_qa)
destroy(this.rb_historic)
destroy(this.rb_current)
destroy(this.ddlb_customer)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_9)
end on

event activate;call super::activate;IF f_security_door("Quality Control") = 1 THEN RETURN 1
//This.Event ue_read_only()
end event

event open;call super::open;Int li_total_pic, i, li_pic_index
String ls_item_name

dw_coil_list.SetTransObject(SQLCA)
dw_coil_track_qa.SetTransObject(SQLCA)
//dw_coil_modify.SetTransObject(SQLCA)
//dw_coil_pic.SetTransObject(SQLCA)
dw_customer.SetTransObject(SQLCA)

dw_customer.Visible = FALSE
dw_customer.Retrieve()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF
ddlb_customer.SelectItem(1)

dw_coil_list.of_SetLinkage(TRUE)
dw_coil_list.inv_linkage.of_SetConfirmOnRowChange (True)
dw_coil_list.inv_linkage.of_setUpdateOnRowChange (TRUE)

dw_coil_track_qa.of_SetLinkage( TRUE ) 
dw_coil_track_qa.inv_Linkage.of_SetMaster(dw_coil_list)
IF NOT dw_coil_track_qa.inv_linkage.of_IsLinked() THEN
	MessageBox("Linkage error", "Failed to link coil & coil QA record in windown w_qa_coil" )
ELSE
	dw_coil_track_qa.inv_Linkage.of_Register( "coil_abc_num", "coil_abc_num" ) 
	dw_coil_track_qa.inv_Linkage.of_SetStyle( dw_coil_track_qa.inv_linkage.RETRIEVE )
END IF

is_path = ProfileString(gs_ini_file, "QA_PICTURE","FOLDER_BASE","E:\PHOTO")

this.event ue_show_pic()




end event

type cb_1 from commandbutton within w_qa_coil
integer x = 3628
integer y = 691
integer width = 421
integer height = 99
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Make Scrape"
end type

type cb_new_qa_coil from commandbutton within w_qa_coil
integer x = 790
integer y = 1946
integer width = 421
integer height = 99
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New QA Coil"
end type

event clicked;open (w_new_qa_coil)
end event

type p_coil from picture within w_qa_coil
integer x = 3248
integer y = 1075
integer width = 790
integer height = 691
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type plb_back from picturelistbox within w_qa_coil
boolean visible = false
integer x = 2926
integer y = 1280
integer width = 176
integer height = 77
integer taborder = 100
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

type plb_qa from picturelistbox within w_qa_coil
integer x = 2575
integer y = 1075
integer width = 614
integer height = 691
integer taborder = 90
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

type st_2 from statictext within w_qa_coil
integer x = 1083
integer y = 998
integer width = 351
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "QA Records"
boolean focusrectangle = false
end type

type cb_change from commandbutton within w_qa_coil
integer x = 3628
integer y = 563
integer width = 428
integer height = 99
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Edit Coil &Status"
end type

type cb_new from commandbutton within w_qa_coil
integer x = 3628
integer y = 435
integer width = 443
integer height = 99
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "New QA &Record"
end type

type st_3 from statictext within w_qa_coil
integer x = 2692
integer y = 998
integer width = 351
integer height = 51
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "QA Pictures"
boolean focusrectangle = false
end type

type cb_coil_num_search from u_cb within w_qa_coil
integer x = 585
integer y = 179
integer width = 421
integer height = 99
integer taborder = 100
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Se&arch"
end type

event clicked;call super::clicked;Parent.event ue_coil_num_search()
end event

type sle_coil_num from singlelineedit within w_qa_coil
integer x = 585
integer y = 77
integer width = 439
integer height = 77
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_qa_coil
integer x = 1068
integer y = 128
integer width = 88
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
string text = "OR"
boolean focusrectangle = false
end type

type rb_org_num from u_rb within w_qa_coil
integer x = 113
integer y = 189
integer width = 410
integer height = 51
string text = "Customer Num"
end type

event clicked;call super::clicked;//if This.Checked then
//	ii_showall =1
//	ddlb_customer.SelectItem(il_index)
//	ddlb_customer.Event SelectionChanged(il_index)
//end if
//
end event

type rb_abc_num from u_rb within w_qa_coil
integer x = 113
integer y = 118
integer width = 351
integer height = 51
string text = "ABC Num"
boolean checked = true
end type

event clicked;call super::clicked;//if This.Checked then
//	ii_showall =0
//	ddlb_customer.SelectItem(il_index)
//	ddlb_customer.Event SelectionChanged(il_index)
//end if
//
end event

type cb_search from u_cb within w_qa_coil
integer x = 3482
integer y = 179
integer width = 421
integer height = 99
integer taborder = 90
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Search"
end type

event clicked;call super::clicked;Parent.event ue_search()
end event

type rb_allday from u_rb within w_qa_coil
integer x = 2165
integer y = 189
integer width = 399
integer height = 64
boolean enabled = false
string text = "All Time"
end type

type rb_180day from u_rb within w_qa_coil
integer x = 2165
integer y = 118
integer height = 64
boolean enabled = false
string text = "Within 180 days"
end type

type rb_30day from u_rb within w_qa_coil
integer x = 1755
integer y = 118
integer width = 450
integer height = 64
boolean enabled = false
string text = "Within 30 days"
boolean checked = true
end type

event clicked;call super::clicked;//if This.Checked then
//	ii_showall =0
//	ddlb_customer.SelectItem(il_index)
//	ddlb_customer.Event SelectionChanged(il_index)
//end if
//
end event

type rb_60day from u_rb within w_qa_coil
integer x = 1755
integer y = 189
integer width = 399
integer height = 64
boolean enabled = false
string text = "Within 60 days"
end type

event clicked;call super::clicked;//if This.Checked then
//	ii_showall =1
//	ddlb_customer.SelectItem(il_index)
//	ddlb_customer.Event SelectionChanged(il_index)
//end if
//
end event

type rb_all from u_rb within w_qa_coil
integer x = 2692
integer y = 102
integer width = 450
integer height = 64
string text = "All Customer"
boolean checked = true
end type

event clicked;call super::clicked;if this.Checked = true then
	ddlb_customer.Enabled = false
end if
end event

type rb_cust from u_rb within w_qa_coil
integer x = 2692
integer y = 179
integer width = 494
integer height = 64
string text = "Selected Customer"
end type

event clicked;call super::clicked;if This.Checked = true then
	ddlb_customer.Enabled = true
end if

end event

type dw_coil_list from u_dw within w_qa_coil
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_goto_row ( )
event ue_display_changing ( integer ai_type )
integer x = 88
integer y = 410
integer width = 3511
integer height = 461
integer taborder = 120
string dataobject = "d_coil_list_qa_by_cust"
boolean hscrollbar = true
end type

event type integer ue_search_retrieve();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//integer li_net
//
//IF this.Event pfc_UpdatesPending() = 1 THEN
//	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
//	if li_net = 1 then
//		Parent.Event pfc_Save()      
//	else
//	  	return 0
//	end if
//END IF
//
//ls_where = wf_search_terms()
//
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	IF Len(is_where) < 2 THEN
//		this.Retrieve()
//	ELSE
//		this.Retrieve(ll_cust)
//	END IF
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
//END IF
//
Return 1
end event

event ue_resume_where();//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//
//wf_reset_condition()
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + is_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	IF Len(is_where) < 2 THEN
//		this.Retrieve()
//	ELSE
//		this.Retrieve(ll_cust)
//	END IF
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to resume datawindow!", StopSign!)
//END IF
//st_cond.Text = "All"
//
end event

event ue_goto_row();//Long ll_crow, ll_trow, ll_i
//
//IF il_cur_coil <= 0 THEN RETURN
//
//ll_trow = RowCount()
//IF ll_trow > 0 THEN
//	ll_crow = 0
//	FOR ll_i = 1 TO ll_trow
//		IF GetItemNumber(ll_i, "coil_abc_num", Primary!, FALSE) = il_cur_coil THEN
//			ll_crow = ll_i
//		END IF
//	NEXT
//	IF ll_crow > 0 THEN
//		SelectRow(0, False)
//		SelectRow(ll_crow, True)
//		SetRow(ll_crow)
//		ScrollToRow(ll_crow)
//	END IF
//END IF
//
//
end event

event ue_display_changing(integer ai_type);////Override pfc_clicked
//
//integer li_rc
//
//// Check arguments
//IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
//	Return
//END IF
//
//IF IsValid (inv_RowSelect) THEN
//	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
//END IF
//
//IF IsValid (inv_Sort) THEN 
//	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
//END IF 
//
//IF IsValid (inv_linkage) THEN
//	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
//		inv_linkage.CONTINUE_ACTION Then
//		// The user or a service action prevents from going to the clicked row.
//		Return 1
//	End If
//END IF
//
//
end event

event clicked;//Override pfc_clicked

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


if isnull(row) then row = 0
IF row <= 0 THEN
	return 
ELSE
	row = this.getrow()	
END IF

il_coil_abc_num = this.GetItemNumber(row, "coil_abc_num", Primary!, FALSE)

Parent.Event ue_show_pic()


end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event doubleclicked;// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
long ll_coil

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

il_coil_abc_num = this.GetItemNumber(row, "coil_abc_num", Primary!, FALSE)

IF il_coil_abc_num > 0 THEN OpenWithParm(w_coil_detail_display, ll_coil)


end event

event rbuttondown;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//disable
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

type dw_customer from u_dw within w_qa_coil
integer x = 3335
integer y = 205
integer width = 102
integer height = 35
integer taborder = 40
string dataobject = "d_customer_short_display"
boolean vscrollbar = false
boolean righttoleft = true
end type

event clicked;SelectRow(0, FALSE)

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

// Notify the RowSelect service that the row has been clicked.
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF
SelectRow(row, TRUE)

// Sort services.
IF IsValid (inv_Sort) THEN 
	// Notify the Sort service, since it may have have a request
	// to sort on colum header.
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 










end event

event constructor;SetRowFocusIndicator(Hand!)
of_SetBase(TRUE)
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event rbuttondown;//disbaled
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()


end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)
//wf_display_total_info()

Return 

end event

type cb_print from commandbutton within w_qa_coil
integer x = 2194
integer y = 1946
integer width = 421
integer height = 99
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Print"
end type

type cb_close from commandbutton within w_qa_coil
integer x = 2896
integer y = 1946
integer width = 421
integer height = 99
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_email from commandbutton within w_qa_coil
integer x = 1492
integer y = 1946
integer width = 421
integer height = 99
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Send &E-Mail"
end type

event clicked;openwithparm(w_send_email_qa, il_coil_abc_num)
end event

type cb_delete_pic from u_cb within w_qa_coil
integer x = 3482
integer y = 1792
integer width = 421
integer height = 99
integer taborder = 80
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Delete Picture"
end type

event clicked;call super::clicked;parent.Event ue_delete_picture()
end event

type cb_add_pic from u_cb within w_qa_coil
integer x = 2692
integer y = 1792
integer width = 421
integer height = 99
integer taborder = 70
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Add Picture"
end type

event clicked;call super::clicked;parent.Event ue_add_picture()
end event

type dw_coil_track_qa from u_dw within w_qa_coil
event type integer ue_search_retrieve ( )
event ue_resume_where ( )
event ue_display_popup ( long al_row )
integer x = 88
integer y = 1075
integer width = 2399
integer height = 794
integer taborder = 40
string dataobject = "d_coil_track_qa"
boolean hscrollbar = true
end type

event type integer ue_search_retrieve();//RETURN 1
//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//integer li_net
//
//IF this.Event pfc_UpdatesPending() = 1 THEN
//	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
//	if li_net = 1 then
//		Parent.Event pfc_Save()      
//	else
//	  	return 0
//	end if
//END IF
//
//ls_where = wf_search_terms()
//
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
//END IF
//
Return 1
end event

event ue_resume_where();//RETURN
//String ls_modify, ls_where, ls_rc
//Long ll_cust, ll_row
//
//wf_reset_condition()
//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
//ls_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id ) "
//ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
//ls_rc = this.Modify(ls_modify)
//IF ls_rc = "" THEN
//	this.Retrieve(ll_cust)
//	wf_display_total_info()
//ELSE
//	MessageBox("Error","Failure to resume datawindow!", StopSign!)
//END IF
//st_cond.Text = "All"

end event

event ue_display_popup(long al_row);//RETURN
//s_coil_info lds_data
//int li_status
//
//lds_data.customer_id = this.GetItemNumber(al_row, "customer_id",Primary!, FALSE)
//lds_data.ab_coil_num = this.GetItemNumber(al_row, "coil_abc_num", Primary!, FALSE)
//lds_data.coil_orig_num = this.GetItemString(al_row, "coil_org_num", Primary!, FALSE)
//lds_data.coil_alt_num = this.GetItemString(al_row, "coil_mid_num", Primary!, FALSE)
//lds_data.lot_num = this.GetItemString(al_row, "lot_num",Primary!, FALSE)
//lds_data.pieces = this.GetItemNumber(al_row, "pieces_per_case", Primary!, FALSE)
//lds_data.coil_line_num = this.GetItemNumber(al_row, "coil_line_num", Primary!, FALSE)
//lds_data.icra = this.GetItemString(al_row, "icra", Primary!, FALSE)
//lds_data.alloy = this.GetItemString(al_row, "coil_alloy2",Primary!, FALSE)
//lds_data.gauge = this.GetItemNumber(al_row, "coil_gauge", Primary!, FALSE)
//lds_data.Temper = this.GetItemString(al_row, "coil_temper", Primary!, FALSE)
//lds_data.net_wt = this.GetItemNumber(al_row, "net_wt", Primary!, FALSE)
//lds_data.net_balance = this.GetItemNumber(al_row, "net_wt_balance", Primary!, FALSE)
//lds_data.width = this.GetItemNumber(al_row, "coil_width", Primary!, FALSE)
//lds_data.date_received = this.GetItemDateTime(al_row, "date_received", Primary!, FALSE)
//lds_data.location = this.GetItemString(al_row, "coil_location", Primary!, FALSE)
//lds_data.status = this.GetItemNumber(al_row, "coil_status", Primary!, FALSE)
//lds_data.notes = this.GetItemString(al_row, "coil_notes", Primary!, FALSE)
//lds_data.coil_from_cust_id = this.GetItemNumber(al_row, "coil_from_cust_id", Primary!, FALSE)
//
//li_status = lds_data.status
//OpenWithParm(w_coil_detail_2, lds_data)
//IF li_status <> 0 THEN 
//	lds_data = message.PowerObjectParm
//
//	IF lds_data.ab_coil_num > 0 THEN
//		//this.SetItem(al_row, "customer_id",lds_data.customer_id)
//		//this.SetItem(al_row, "coil_abc_num", lds_data.ab_coil_num )
//		this.SetItem(al_row, "coil_org_num",lds_data.coil_orig_num  )
//		this.SetItem(al_row, "coil_mid_num",lds_data.coil_alt_num)
//		this.SetItem(al_row, "lot_num", lds_data.lot_num   )
//		this.SetItem(al_row, "pieces_per_case", lds_data.pieces)
//		this.SetItem(al_row, "coil_line_num", lds_data.coil_line_num)
//		this.SetItem(al_row, "icra", lds_data.icra )
//		this.SetItem(al_row, "coil_alloy2", lds_data.alloy)
//		this.SetItem(al_row, "coil_gauge",lds_data.gauge )
//		this.SetItem(al_row, "coil_temper",lds_data.Temper )
//		this.SetItem(al_row, "net_wt",lds_data.net_wt )
//		this.SetItem(al_row, "net_wt_balance", lds_data.net_balance)
//		this.SetItem(al_row, "coil_width",lds_data.width )
//		this.SetItem(al_row, "date_received", lds_data.date_received)
//		this.SetItem(al_row, "coil_location", lds_data.location )
//		this.SetItem(al_row, "coil_status",lds_data.status )
//		this.SetItem(al_row, "coil_notes", lds_data.notes )
//		this.SetItem(al_row, "coil_from_cust_id",lds_data.coil_from_cust_id)
//		il_cur_coil = lds_data.ab_coil_num
//		ib_modify = TRUE
//		wf_editing_mode()
//	ELSE
//		this.Reset()
//		ib_modify = FALSE
//		wf_normal_mode()
//	END IF
//END IF	
end event

event clicked;//Override pfc_clicked

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF


end event

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)



end event

event doubleclicked;RETURN
// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

//display
long ll_coil_number, ll_num, ll_coil

IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

if isnull(row) then row = 0
IF row <= 0 THEN
	row = this.getrow()
	if row <= 0 then return
end if

IF f_security_door("Inventory(Coil)") = 0 THEN RETURN 

ll_coil = this.GetItemNumber(row, "coil_abc_num", Primary!, FALSE)
IF ll_coil > 0 THEN
	this.Event ue_display_popup(row)
END IF

end event

event rbuttondown;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttonup;//disable
Return 0
end event

event pfc_deleterow;call super::pfc_deleterow;Return 1
end event

event pfc_addrow;call super::pfc_addrow;RETURN 1
//long ll_row_coil, ll_row_cut,ll_c_id, ll_new_id
//
//ll_row_coil = this.GetRow()
//ll_row_cut = dw_customer.GetRow()
//ll_c_id = dw_customer.GetItemNumber(ll_row_cut, "customer_id", Primary!, FALSE)
//this.SetItem(ll_row_coil, "customer_id", ll_c_id)
//ll_new_id = f_get_next_value("coil_abc_num_seq")
//this.SetItem(ll_row_coil, "coil_abc_num", ll_new_id)
//this.setItem(ll_row_coil, "coil_entry_date", Today() )
//this.setItem(ll_row_coil, "coil_status", 2 )  //new coil
////dw_coil_list.setItem(ll_row_coil, "material_type", 1 ) //aluminum
//
//this.SetItem(ll_row_coil, "coil_org_num",ids_coil.coil_orig_num  )
//this.SetItem(ll_row_coil, "coil_mid_num",ids_coil.coil_alt_num)
//this.SetItem(ll_row_coil, "lot_num", ids_coil.lot_num   )
//this.SetItem(ll_row_coil, "pieces_per_case", ids_coil.pieces)
//this.SetItem(ll_row_coil, "coil_line_num", ids_coil.coil_line_num)
//this.SetItem(ll_row_coil, "icra", ids_coil.icra )
//this.SetItem(ll_row_coil, "coil_alloy2", ids_coil.alloy)
//this.SetItem(ll_row_coil, "coil_gauge",ids_coil.gauge )
//this.SetItem(ll_row_coil, "coil_temper",ids_coil.Temper )
//this.SetItem(ll_row_coil, "net_wt",ids_coil.net_wt )
//this.SetItem(ll_row_coil, "net_wt_balance", ids_coil.net_balance)
//this.SetItem(ll_row_coil, "coil_width",ids_coil.width )
//this.SetItem(ll_row_coil, "date_received", ids_coil.date_received)
//this.SetItem(ll_row_coil, "coil_location", ids_coil.location )
//this.SetItem(ll_row_coil, "coil_status",ids_coil.status )
//this.SetItem(ll_row_coil, "coil_notes", ids_coil.notes )
//this.SetItem(ll_row_coil, "coil_from_cust_id",ids_coil.coil_from_cust_id)
//il_cur_coil = ll_new_id
//ib_new = TRUE
//
//Return ll_row_coil
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

type rb_historic from u_rb within w_qa_coil
integer x = 1229
integer y = 189
integer width = 439
integer height = 51
string text = "Historic QA Coil"
end type

event clicked;call super::clicked;rb_30day.Enabled = TRUE
rb_60day.Enabled = TRUE
rb_180day.Enabled = TRUE
rb_allday.Enabled = TRUE
end event

type rb_current from u_rb within w_qa_coil
integer x = 1229
integer y = 118
integer width = 439
integer height = 51
string text = "Current QA Coil"
boolean checked = true
end type

event clicked;call super::clicked;rb_30day.Enabled = FALSE
rb_60day.Enabled = FALSE
rb_180day.Enabled = FALSE
rb_allday.Enabled = FALSE
end event

type ddlb_customer from dropdownlistbox within w_qa_coil
integer x = 3335
integer y = 77
integer width = 702
integer height = 973
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//String ls_text
//Long ll_row, ll_i, ll_cust
//
//ls_text = Text(index)
//ll_row = dw_customer.RowCount()
//FOR ll_i = 1 TO ll_row
//	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
//		dw_customer.Event RowFocusChanged(ll_i)
//		dw_customer.SelectRow(0, False)
//		dw_customer.SelectRow(ll_i, True)
//		ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")		
//		
//		if rb_all.Checked = True then		//all historic QA coil
//			/*action1*/
//		end if
//
//		dw_coil_list.Retrieve(ll_cust)	
////		dw_coil_list.reset()
//	END IF
//NEXT

end event

type gb_2 from u_gb within w_qa_coil
integer x = 1200
integer y = 51
integer width = 505
integer height = 221
integer taborder = 10
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "QA Status"
end type

type gb_1 from u_gb within w_qa_coil
integer x = 59
integer y = 947
integer width = 4037
integer height = 973
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 79741120
string text = "Coil~'s QA Details"
end type

type gb_3 from u_gb within w_qa_coil
integer x = 2662
integer y = 51
integer width = 585
integer height = 221
integer taborder = 20
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "Customer"
end type

type gb_5 from u_gb within w_qa_coil
integer x = 1726
integer y = 51
integer width = 900
integer height = 221
integer taborder = 10
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "Coil Received Time"
end type

type gb_6 from groupbox within w_qa_coil
integer x = 1170
integer width = 2926
integer height = 307
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
end type

type gb_7 from u_gb within w_qa_coil
integer x = 88
integer y = 51
integer width = 468
integer height = 221
integer taborder = 20
integer textsize = -9
integer weight = 700
string facename = "Arial"
string text = "Coil Number"
end type

type gb_8 from groupbox within w_qa_coil
integer x = 59
integer width = 995
integer height = 307
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 80263581
end type

type gb_9 from groupbox within w_qa_coil
integer x = 59
integer y = 333
integer width = 4037
integer height = 589
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "QA Coil List"
end type

