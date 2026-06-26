$PBExportHeader$w_recovery_backup.srw
forward
global type w_recovery_backup from w_sheet
end type
type sle_3 from singlelineedit within w_recovery_backup
end type
type tab_rec from tab within w_recovery_backup
end type
type tabpage_data from userobject within tab_rec
end type
type p_3 from picture within tabpage_data
end type
type p_2 from picture within tabpage_data
end type
type st_9 from statictext within tabpage_data
end type
type dw_6 from u_dw within tabpage_data
end type
type cb_10 from u_cb within tabpage_data
end type
type cb_9 from u_cb within tabpage_data
end type
type cb_7 from u_cb within tabpage_data
end type
type dw_5 from u_dw within tabpage_data
end type
type st_8 from statictext within tabpage_data
end type
type dw_4 from u_dw within tabpage_data
end type
type st_7 from statictext within tabpage_data
end type
type gb_2 from groupbox within tabpage_data
end type
type tabpage_data from userobject within tab_rec
p_3 p_3
p_2 p_2
st_9 st_9
dw_6 dw_6
cb_10 cb_10
cb_9 cb_9
cb_7 cb_7
dw_5 dw_5
st_8 st_8
dw_4 dw_4
st_7 st_7
gb_2 gb_2
end type
type tabpage_report from userobject within tab_rec
end type
type rb_7 from radiobutton within tabpage_report
end type
type rb_6 from radiobutton within tabpage_report
end type
type rb_5 from radiobutton within tabpage_report
end type
type rb_4 from radiobutton within tabpage_report
end type
type rb_3 from radiobutton within tabpage_report
end type
type rb_2 from radiobutton within tabpage_report
end type
type rb_1 from radiobutton within tabpage_report
end type
type p_1 from picture within tabpage_report
end type
type cb_3 from u_cb within tabpage_report
end type
type cb_2 from u_cb within tabpage_report
end type
type tabpage_report from userobject within tab_rec
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
p_1 p_1
cb_3 cb_3
cb_2 cb_2
end type
type tab_rec from tab within w_recovery_backup
tabpage_data tabpage_data
tabpage_report tabpage_report
end type
type cb_8 from u_cb within w_recovery_backup
end type
type cb_1 from u_cb within w_recovery_backup
end type
type sle_2 from singlelineedit within w_recovery_backup
end type
type sle_1 from singlelineedit within w_recovery_backup
end type
type st_2 from statictext within w_recovery_backup
end type
type st_5 from statictext within w_recovery_backup
end type
type st_1 from statictext within w_recovery_backup
end type
type ddlb_customer from dropdownlistbox within w_recovery_backup
end type
end forward

global type w_recovery_backup from w_sheet
integer x = 214
integer width = 3643
integer height = 2205
sle_3 sle_3
tab_rec tab_rec
cb_8 cb_8
cb_1 cb_1
sle_2 sle_2
sle_1 sle_1
st_2 st_2
st_5 st_5
st_1 st_1
ddlb_customer ddlb_customer
end type
global w_recovery_backup w_recovery_backup

on w_recovery_backup.create
int iCurrent
call super::create
this.sle_3=create sle_3
this.tab_rec=create tab_rec
this.cb_8=create cb_8
this.cb_1=create cb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.st_5=create st_5
this.st_1=create st_1
this.ddlb_customer=create ddlb_customer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_3
this.Control[iCurrent+2]=this.tab_rec
this.Control[iCurrent+3]=this.cb_8
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.sle_2
this.Control[iCurrent+6]=this.sle_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.ddlb_customer
end on

on w_recovery_backup.destroy
call super::destroy
destroy(this.sle_3)
destroy(this.tab_rec)
destroy(this.cb_8)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.st_1)
destroy(this.ddlb_customer)
end on

type sle_3 from singlelineedit within w_recovery_backup
integer x = 44
integer y = 99
integer width = 1496
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Constellium"
borderstyle borderstyle = stylelowered!
end type

type tab_rec from tab within w_recovery_backup
integer x = 29
integer y = 202
integer width = 3555
integer height = 1798
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_data tabpage_data
tabpage_report tabpage_report
end type

on tab_rec.create
this.tabpage_data=create tabpage_data
this.tabpage_report=create tabpage_report
this.Control[]={this.tabpage_data,&
this.tabpage_report}
end on

on tab_rec.destroy
destroy(this.tabpage_data)
destroy(this.tabpage_report)
end on

type tabpage_data from userobject within tab_rec
integer x = 15
integer y = 90
integer width = 3525
integer height = 1696
long backcolor = 79741120
string text = "Data"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
p_3 p_3
p_2 p_2
st_9 st_9
dw_6 dw_6
cb_10 cb_10
cb_9 cb_9
cb_7 cb_7
dw_5 dw_5
st_8 st_8
dw_4 dw_4
st_7 st_7
gb_2 gb_2
end type

on tabpage_data.create
this.p_3=create p_3
this.p_2=create p_2
this.st_9=create st_9
this.dw_6=create dw_6
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_7=create cb_7
this.dw_5=create dw_5
this.st_8=create st_8
this.dw_4=create dw_4
this.st_7=create st_7
this.gb_2=create gb_2
this.Control[]={this.p_3,&
this.p_2,&
this.st_9,&
this.dw_6,&
this.cb_10,&
this.cb_9,&
this.cb_7,&
this.dw_5,&
this.st_8,&
this.dw_4,&
this.st_7,&
this.gb_2}
end on

on tabpage_data.destroy
destroy(this.p_3)
destroy(this.p_2)
destroy(this.st_9)
destroy(this.dw_6)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_7)
destroy(this.dw_5)
destroy(this.st_8)
destroy(this.dw_4)
destroy(this.st_7)
destroy(this.gb_2)
end on

type p_3 from picture within tabpage_data
integer x = 980
integer y = 102
integer width = 2139
integer height = 608
string picturename = "C:\my abc documents\ABIS-office\rec3.JPG"
boolean focusrectangle = false
end type

type p_2 from picture within tabpage_data
integer y = 787
integer width = 4173
integer height = 1120
boolean originalsize = true
string picturename = "C:\my abc documents\ABIS-office\rec2.JPG"
boolean focusrectangle = false
end type

type st_9 from statictext within tabpage_data
integer y = 704
integer width = 538
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Recovery Data:"
boolean focusrectangle = false
end type

type dw_6 from u_dw within tabpage_data
integer y = 813
integer width = 3511
integer height = 886
integer taborder = 140
end type

type cb_10 from u_cb within tabpage_data
integer x = 3109
integer y = 448
integer width = 351
integer height = 93
integer taborder = 130
integer weight = 700
string text = "Save"
end type

type cb_9 from u_cb within tabpage_data
integer x = 3109
integer y = 288
integer width = 351
integer height = 93
integer taborder = 120
integer weight = 700
string text = "Modify"
end type

type cb_7 from u_cb within tabpage_data
integer x = 3109
integer y = 128
integer width = 351
integer height = 93
integer taborder = 80
integer weight = 700
string text = "Add"
end type

type dw_5 from u_dw within tabpage_data
integer x = 987
integer y = 128
integer width = 2048
integer height = 448
integer taborder = 70
end type

type st_8 from statictext within tabpage_data
integer x = 955
integer y = 19
integer width = 538
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Defects:"
boolean focusrectangle = false
end type

type dw_4 from u_dw within tabpage_data
integer y = 96
integer width = 859
integer height = 512
integer taborder = 60
string dataobject = "d_recovery_job_coil"
end type

type st_7 from statictext within tabpage_data
integer x = 4
integer y = 19
integer width = 538
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "AB Job List:"
boolean focusrectangle = false
end type

type gb_2 from groupbox within tabpage_data
integer x = 951
integer y = 64
integer width = 2560
integer height = 544
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
end type

type tabpage_report from userobject within tab_rec
integer x = 15
integer y = 90
integer width = 3525
integer height = 1696
long backcolor = 79741120
string text = "Reports"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
p_1 p_1
cb_3 cb_3
cb_2 cb_2
end type

on tabpage_report.create
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.p_1=create p_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.Control[]={this.rb_7,&
this.rb_6,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.p_1,&
this.cb_3,&
this.cb_2}
end on

on tabpage_report.destroy
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.p_1)
destroy(this.cb_3)
destroy(this.cb_2)
end on

type rb_7 from radiobutton within tabpage_report
integer x = 22
integer y = 554
integer width = 574
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Summary"
end type

type rb_6 from radiobutton within tabpage_report
integer x = 22
integer y = 474
integer width = 574
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Scrap Defect Details"
end type

type rb_5 from radiobutton within tabpage_report
integer x = 22
integer y = 394
integer width = 574
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Prod Type Graph"
end type

type rb_4 from radiobutton within tabpage_report
integer x = 22
integer y = 314
integer width = 574
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Monthly Prod Type"
end type

type rb_3 from radiobutton within tabpage_report
integer x = 22
integer y = 234
integer width = 574
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Monthly Defects"
boolean checked = true
end type

type rb_2 from radiobutton within tabpage_report
integer x = 22
integer y = 154
integer width = 574
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Monthly Scrap"
end type

type rb_1 from radiobutton within tabpage_report
integer x = 22
integer y = 74
integer width = 325
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Daily Report"
end type

type p_1 from picture within tabpage_report
integer x = 673
integer y = 16
integer width = 2838
integer height = 1539
string picturename = "C:\my abc documents\ABIS-office\rec1.JPG"
boolean focusrectangle = false
end type

type cb_3 from u_cb within tabpage_report
integer x = 1836
integer y = 1584
integer width = 351
integer height = 93
integer taborder = 170
integer weight = 700
string text = "Print"
end type

type cb_2 from u_cb within tabpage_report
integer x = 848
integer y = 1584
integer width = 351
integer height = 93
integer taborder = 160
integer weight = 700
string text = "Export"
end type

type cb_8 from u_cb within w_recovery_backup
integer x = 3240
integer y = 2013
integer width = 351
integer height = 93
integer taborder = 170
integer weight = 700
string text = "Close"
end type

type cb_1 from u_cb within w_recovery_backup
integer x = 3145
integer y = 96
integer width = 351
integer height = 93
integer taborder = 40
integer weight = 700
string text = "Enter"
end type

type sle_2 from singlelineedit within w_recovery_backup
integer x = 2450
integer y = 99
integer width = 512
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "12/01/2011"
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_recovery_backup
integer x = 1719
integer y = 99
integer width = 512
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "11/11/2011"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_recovery_backup
integer x = 2450
integer y = 32
integer width = 146
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_recovery_backup
integer x = 1719
integer y = 32
integer width = 146
integer height = 61
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "From:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_recovery_backup
integer x = 37
integer y = 32
integer width = 538
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Customer:"
boolean focusrectangle = false
end type

type ddlb_customer from dropdownlistbox within w_recovery_backup
integer x = 51
integer y = 301
integer width = 1499
integer height = 1248
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//String ls_text
//Long ll_row, ll_i, ll_cust, ll_item
//
//il_index = index
//ls_text = Text(index)
//CHOOSE CASE ls_text 
//	CASE "ALL CUSTOMERS"
//		dw_coil_list.DataObject = "d_coil_list_allcust"
//		if ii_showall = 1 then	//show all
//			is_where = ""
//		else		//show default
//			is_where = "WHERE ( ~~~"COIL~~~".~~~"COIL_STATUS~~~"  NOT IN (0, 10) )"
//		end if
//		dw_coil_list.SetTransObject(SQLCA)
//		//dw_coil_list.Object.item_t.visible = false		//hide the total coil number
//		cb_cancel.Event Clicked()
//		cb_reset.Event Clicked()					
//		ib_allcust = TRUE
//		cb_new.Enabled = FALSE
//	CASE ELSE		
//		dw_coil_list.DataObject = "d_coil_list"
//		dw_coil_list.SetTransObject(SQLCA)
//		if ii_showall = 1 then
//			is_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id )"
//		else
//			is_where = "  WHERE ( ~~~"COIL~~~".~~~"CUSTOMER_ID~~~" = :Customer_id and  ~~~"COIL~~~".~~~"COIL_STATUS~~~"  NOT IN (0, 10) )"
//		end if
//		ll_row = dw_customer.RowCount()
//		//dw_coil_list.Object.item_t.visible = false		//hide the total coil number
//		FOR ll_i = 1 TO ll_row
//			IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
//				dw_customer.Event RowFocusChanged(ll_i)
//				dw_customer.SelectRow(0, False)
//				dw_customer.SelectRow(ll_i, True)
//				ll_cust = dw_customer.GetItemNumber(ll_i, "customer_id")				
//				cb_reset.Event Clicked()				
//				cb_cancel.Event Clicked()
//				IF NOT(ib_readonly) THEN cb_new.Enabled = TRUE
//			END IF
//		NEXT
//		ib_allcust = FALSE
//		dw_coil_list.Retrieve(ll_cust)
//END CHOOSE
//
////wf_display_total_info()
//
////show only the filted coil number
//dw_coil_list.Object.item_t.visible = true
//ll_item = dw_coil_list.RowCount()
//IF ll_item = 0 THEN
//	dw_coil_list.Object.item_t.Text = ""
//ELSE
//	dw_coil_list.Object.item_t.Text = String(ll_item, "#,###,###") + "  coil(s)"
//END IF
//
//
//
end event

