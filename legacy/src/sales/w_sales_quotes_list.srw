$PBExportHeader$w_sales_quotes_list.srw
$PBExportComments$<Child> list all current sales status inherited from w_child
forward
global type w_sales_quotes_list from w_child
end type
type pb_6 from u_pb within w_sales_quotes_list
end type
type pb_7 from u_pb within w_sales_quotes_list
end type
type pb_5 from u_pb within w_sales_quotes_list
end type
type pb_3 from u_pb within w_sales_quotes_list
end type
type pb_2 from u_pb within w_sales_quotes_list
end type
type pb_1 from u_pb within w_sales_quotes_list
end type
type dw_list from u_dw within w_sales_quotes_list
end type
type rb_4 from radiobutton within w_sales_quotes_list
end type
type rb_3 from radiobutton within w_sales_quotes_list
end type
type ddlb_1 from dropdownlistbox within w_sales_quotes_list
end type
type rb_2 from radiobutton within w_sales_quotes_list
end type
type rb_1 from radiobutton within w_sales_quotes_list
end type
type gb_1 from groupbox within w_sales_quotes_list
end type
type gb_2 from groupbox within w_sales_quotes_list
end type
end forward

global type w_sales_quotes_list from w_child
integer x = 214
integer width = 3354
integer height = 1798
string title = "Sales status"
long backcolor = 16777215
pb_6 pb_6
pb_7 pb_7
pb_5 pb_5
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
dw_list dw_list
rb_4 rb_4
rb_3 rb_3
ddlb_1 ddlb_1
rb_2 rb_2
rb_1 rb_1
gb_1 gb_1
gb_2 gb_2
end type
global w_sales_quotes_list w_sales_quotes_list

on w_sales_quotes_list.create
int iCurrent
call super::create
this.pb_6=create pb_6
this.pb_7=create pb_7
this.pb_5=create pb_5
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_list=create dw_list
this.rb_4=create rb_4
this.rb_3=create rb_3
this.ddlb_1=create ddlb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_6
this.Control[iCurrent+2]=this.pb_7
this.Control[iCurrent+3]=this.pb_5
this.Control[iCurrent+4]=this.pb_3
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.dw_list
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.rb_1
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
end on

on w_sales_quotes_list.destroy
call super::destroy
destroy(this.pb_6)
destroy(this.pb_7)
destroy(this.pb_5)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_list)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.ddlb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event pfc_postopen;call super::pfc_postopen;Long ll_row, ll_i, ll_q, ll_r
Real lr_p
DateTime ldt_t

ll_row = dw_list.RowCount()

If ll_row <= 0 THEN RETURN 

FOR ll_i = 1 TO ll_row
	ll_r = dw_list.GetItemNumber(ll_i, "sales_quote_quote_revision_id")
	ll_q = dw_list.GetItemNumber(ll_i, "sales_quote_quote_id")
	
	SELECT sales_probability INTO :lr_p
	FROM sales_probability
	WHERE quote_id = :ll_q AND 
			quote_revision_id = :ll_r AND 
			review_date = (SELECT MAX(review_date) 
							FROM sales_probability
							WHERE quote_id = :ll_q AND quote_revision_id = :ll_r)		
	USING SQLCA;
	
	dw_list.SetItem(ll_i,"latest_probability", lr_p)
NEXT
dw_list.ResetUpdate()


end event

type pb_6 from u_pb within w_sales_quotes_list
integer x = 3211
integer y = 198
integer width = 80
integer height = 70
integer taborder = 80
string text = ""
boolean originalsize = false
string picturename = "Exit!"
string powertiptext = "Exit"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_7 from u_pb within w_sales_quotes_list
integer x = 3094
integer y = 198
integer width = 80
integer height = 70
integer taborder = 70
string text = ""
boolean originalsize = false
string picturename = "Custom065!"
string powertiptext = "Search"
end type

type pb_5 from u_pb within w_sales_quotes_list
integer x = 2977
integer y = 198
integer width = 80
integer height = 70
integer taborder = 60
string text = ""
boolean originalsize = false
string picturename = "Custom074!"
string powertiptext = "Print"
end type

type pb_3 from u_pb within w_sales_quotes_list
integer x = 2860
integer y = 198
integer width = 80
integer height = 70
integer taborder = 50
string text = ""
boolean originalsize = false
string picturename = "Custom008!"
string powertiptext = "Save"
end type

type pb_2 from u_pb within w_sales_quotes_list
integer x = 2743
integer y = 198
integer width = 80
integer height = 70
integer taborder = 40
string text = ""
string picturename = "Custom072!"
string powertiptext = "Edit"
end type

event clicked;call super::clicked;Long ll_row
s_quote_data lds_s

If dw_list.RowCount() <= 0 THEN RETURN 0
ll_row = 0
ll_row = dw_list.GetRow()
IF ll_row <= 0 THEN RETURN 0

lds_s.revision_id = dw_list.GetItemNumber(ll_row, "sales_quote_quote_revision_id")
lds_s.quote_id = dw_list.GetItemNumber(ll_row, "sales_quote_quote_id")
lds_s.contact_id = dw_list.GetItemNumber(ll_row, "sales_quote_contact_id")

RETURN OpenWithParm(w_edit_quote, lds_s)


end event

type pb_1 from u_pb within w_sales_quotes_list
integer x = 2626
integer y = 198
integer width = 80
integer height = 70
integer taborder = 30
string text = ""
string picturename = "AddWatch5!"
boolean map3dcolors = true
string powertiptext = "New"
end type

type dw_list from u_dw within w_sales_quotes_list
integer x = 26
integer y = 282
integer width = 3277
integer height = 1411
integer taborder = 30
string dataobject = "d_pending_sales_list"
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetBase(TRUE)
SetTransObject(SQLCA)
Retrieve()
end event

type rb_4 from radiobutton within w_sales_quotes_list
integer x = 2081
integer y = 83
integer width = 512
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217737
string text = "Only my quotes"
end type

type rb_3 from radiobutton within w_sales_quotes_list
integer x = 2629
integer y = 83
integer width = 307
integer height = 74
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217737
string text = "All quotes"
end type

type ddlb_1 from dropdownlistbox within w_sales_quotes_list
integer x = 965
integer y = 80
integer width = 859
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

type rb_2 from radiobutton within w_sales_quotes_list
integer x = 406
integer y = 83
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
string text = "Only this one:"
end type

type rb_1 from radiobutton within w_sales_quotes_list
integer x = 124
integer y = 83
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

type gb_1 from groupbox within w_sales_quotes_list
integer x = 18
integer y = 13
integer width = 1913
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
string text = "Customer"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_sales_quotes_list
integer x = 1953
integer y = 13
integer width = 1357
integer height = 163
integer taborder = 20
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

