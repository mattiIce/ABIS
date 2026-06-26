$PBExportHeader$w_sales_catalog.srw
$PBExportComments$catalog window inherited from w_child
forward
global type w_sales_catalog from w_child
end type
type pb_6 from u_pb within w_sales_catalog
end type
type tv_cat from u_tvs within w_sales_catalog
end type
type pb_3 from u_pb within w_sales_catalog
end type
type pb_2 from u_pb within w_sales_catalog
end type
type pb_1 from u_pb within w_sales_catalog
end type
type ddlb_1 from dropdownlistbox within w_sales_catalog
end type
type rb_2 from radiobutton within w_sales_catalog
end type
type rb_1 from radiobutton within w_sales_catalog
end type
type gb_1 from groupbox within w_sales_catalog
end type
end forward

global type w_sales_catalog from w_child
integer x = 214
integer width = 2319
integer height = 1779
string title = "Catalog"
long backcolor = 134217737
pb_6 pb_6
tv_cat tv_cat
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
ddlb_1 ddlb_1
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
end type
global w_sales_catalog w_sales_catalog

on w_sales_catalog.create
int iCurrent
call super::create
this.pb_6=create pb_6
this.tv_cat=create tv_cat
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.ddlb_1=create ddlb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_6
this.Control[iCurrent+2]=this.tv_cat
this.Control[iCurrent+3]=this.pb_3
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_sales_catalog.destroy
call super::destroy
destroy(this.pb_6)
destroy(this.tv_cat)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.ddlb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
end on

event pfc_postopen;call super::pfc_postopen;Long ll_tvi

tv_cat.Event pfc_RefreshLevel(1)
ll_tvi = tv_cat.FindItem(RootTreeItem! , 0)
tv_cat.ExpandAll(ll_tvi)

end event

type pb_6 from u_pb within w_sales_catalog
integer x = 2183
integer y = 99
integer width = 80
integer height = 70
integer taborder = 20
string text = ""
boolean originalsize = false
string picturename = "Exit!"
end type

event clicked;call super::clicked;Close(Parent)
end event

type tv_cat from u_tvs within w_sales_catalog
integer x = 26
integer y = 189
integer width = 2245
integer height = 1491
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 1090519039
string picturename[] = {"Application!","CreateRuntime5!","CreateRuntime!","UserObject!","Custom039!","Custom050!"}
end type

event clicked;Triggerevent ("sectionchanged")
end event

event constructor;call super::constructor;this.of_SetLevelSource(TRUE)

this.inv_levelsource.of_Register(1,"customer_customer_short_name", "", "d_sales_cat_customer_id", SQLCA, "")
this.inv_levelsource.of_Register(2, "item_desc", ":parent.1.customer_id", "d_sales_cat_part_id", SQLCA, "")
this.inv_levelsource.of_Register(3, "compute_1",  &
  ":parent.1.part_num_id", "d_sales_cat_item_details", SQLCA, "")

this.inv_levelsource.of_SetPictureColumn(1, "1")
this.inv_levelsource.of_SetSelectedPictureColumn(1, "2")
this.inv_levelsource.of_SetPictureColumn(2, "3")
this.inv_levelsource.of_SetSelectedPictureColumn(2, "4")
this.inv_levelsource.of_SetPictureColumn(3, "5")
this.inv_levelsource.of_SetSelectedPictureColumn(3, "6")

this.event pfc_Populate(0)

end event

event doubleclicked;call super::doubleclicked;Long ll_current, ll_return, ll_row
Long ll_part
TreeViewItem ltvi_item
n_ds lds_datastore


ll_current = this.FindItem(CurrentTreeItem!, 0)
ll_return = this.GetItem(ll_current, ltvi_item)
ll_return = this.inv_levelsource.of_GetDataSource(ltvi_item.level, lds_datastore)
ll_return = this.inv_levelsource.of_GetDataRow(ll_current, lds_datastore,ll_row)

CHOOSE CASE ltvi_item.level 
	CASE 3	//coil
 		//ll_part = lds_datastore.GetItemNumber(ll_row,"part_num_id")
		//OpenWithParm(w_daily_part_details, ll_part)
	CASE else
		//nothing
END CHOOSE

end event

event rightclicked;//override
RETURN 1
end event

event pfc_retrieve;call super::pfc_retrieve;Any   la_args[20]
Integer   li_level

IF IsValid(inv_levelsource) THEN
			li_level = this.of_GetNextLevel(al_parent)
			this.inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
END IF

Return this.of_Retrieve(al_parent, la_args, ads_data)

end event

type pb_3 from u_pb within w_sales_catalog
integer x = 2096
integer y = 99
integer width = 80
integer height = 70
integer taborder = 50
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom072!"
end type

type pb_2 from u_pb within w_sales_catalog
integer x = 2008
integer y = 99
integer width = 80
integer height = 70
integer taborder = 40
string facename = "Arial"
string text = ""
boolean originalsize = false
string picturename = "Custom021!"
end type

type pb_1 from u_pb within w_sales_catalog
integer x = 1920
integer y = 99
integer width = 80
integer height = 70
integer taborder = 30
string facename = "Arial"
string text = ""
string picturename = "AddWatch5!"
end type

type ddlb_1 from dropdownlistbox within w_sales_catalog
integer x = 998
integer y = 90
integer width = 772
integer height = 1011
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_sales_catalog
integer x = 410
integer y = 90
integer width = 578
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217737
string text = "Only this customer:"
end type

type rb_1 from radiobutton within w_sales_catalog
integer x = 128
integer y = 90
integer width = 245
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217737
string text = "All"
end type

type gb_1 from groupbox within w_sales_catalog
integer x = 22
integer y = 19
integer width = 1781
integer height = 163
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217737
string text = "Show"
borderstyle borderstyle = styleraised!
end type

