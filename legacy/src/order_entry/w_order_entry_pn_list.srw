$PBExportHeader$w_order_entry_pn_list.srw
$PBExportComments$<Response> List customer parts and all information about each part, based on customer. Inherited from pfemain\w_sheet
forward
global type w_order_entry_pn_list from w_sheet
end type
type cb_select from u_cb within w_order_entry_pn_list
end type
type cb_reset from u_cb within w_order_entry_pn_list
end type
type cb_search from u_cb within w_order_entry_pn_list
end type
type st_cond from u_st within w_order_entry_pn_list
end type
type st_4 from statictext within w_order_entry_pn_list
end type
type st_3 from statictext within w_order_entry_pn_list
end type
type st_2 from statictext within w_order_entry_pn_list
end type
type dw_pn_list from u_dw within w_order_entry_pn_list
end type
type dw_type from u_dw within w_order_entry_pn_list
end type
type dw_pn from u_dw within w_order_entry_pn_list
end type
type rb_showall from u_rb within w_order_entry_pn_list
end type
type rb_activeonly from u_rb within w_order_entry_pn_list
end type
type dw_customer from u_dw within w_order_entry_pn_list
end type
type cb_close from u_cb within w_order_entry_pn_list
end type
type ddlb_customer from dropdownlistbox within w_order_entry_pn_list
end type
type st_1 from statictext within w_order_entry_pn_list
end type
type gb_display from u_gb within w_order_entry_pn_list
end type
type gb_search from u_gb within w_order_entry_pn_list
end type
end forward

global type w_order_entry_pn_list from w_sheet
integer x = 4
integer y = 3
integer width = 3829
integer height = 2310
string title = "Select a part number"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_set_search ( datawindow adw_d )
cb_select cb_select
cb_reset cb_reset
cb_search cb_search
st_cond st_cond
st_4 st_4
st_3 st_3
st_2 st_2
dw_pn_list dw_pn_list
dw_type dw_type
dw_pn dw_pn
rb_showall rb_showall
rb_activeonly rb_activeonly
dw_customer dw_customer
cb_close cb_close
ddlb_customer ddlb_customer
st_1 st_1
gb_display gb_display
gb_search gb_search
end type
global w_order_entry_pn_list w_order_entry_pn_list

type variables
Long il_id, il_cust_id
String is_type
Integer ii_status

String is_select
String is_where
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_delete
Boolean ib_new
Boolean ib_modify
Long il_cur_part
Boolean ib_readonly
Boolean ib_allcust
Int ii_showall
Long il_index
end variables

forward prototypes
public function string wf_search_terms ()
public subroutine wf_reset_condition ()
public subroutine wf_init_dwdb ()
public function long wf_get_userid (string as_name)
end prototypes

event ue_set_search(datawindow adw_d);Long ll_row, ll_l
String ls_s
Int li_i, li_s

ll_row = adw_d.RowCount()
IF ll_row < 1 THEN RETURN
FOR ll_l = 1 TO ll_row
	IF Len(ls_s) > 1 THEN ls_s = ls_s + ', '
	ls_s = ls_s + adw_d.getItemString(ll_l, "column_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
	ls_s = ls_s + adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
NEXT
st_cond.Text = ls_s

wf_reset_condition()

li_s = 1
FOR ll_l = 1 TO ll_row
	li_i = 1
	DO WHILE li_i <= Upperbound(istr_dwdb)
		IF istr_dwdb[li_i].dw_header = adw_d.getItemString(ll_l, "column_t", Primary!, FALSE) THEN
			istr_search[li_s].db_name = istr_dwdb[li_i].db_name
			istr_search[li_s].db_field = istr_dwdb[li_i].db_field
			istr_search[li_s].col_type = istr_dwdb[li_i].col_type
			istr_search[li_s].operator = adw_d.getItemString(ll_l, "operator_t", Primary!, FALSE)
			istr_search[li_s].value = adw_d.getItemString(ll_l, "value_t", Primary!, FALSE)
			IF istr_search[li_s].col_type = "Customer" THEN
					istr_search[li_s].value = String(wf_get_userid(istr_search[li_s].value))
			END IF
			li_s++
		END IF
	li_i++
	LOOP
NEXT

dw_pn_list.Event ue_search_retrieve()

end event

public function string wf_search_terms ();String ls_terms
integer li_i

ls_terms = is_where
li_i = 1
DO WHILE li_i <= UpperBound(istr_search)
	IF istr_search[li_i].db_name <> "" THEN
		CHOOSE CASE istr_search[li_i].col_type
			CASE "Number"
				IF Len(ls_terms) < 2 THEN 
					ls_terms = " WHERE " + " ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				ELSE
					ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				END IF
			CASE "Customer"
				IF Len(ls_terms) < 2 THEN 
					ls_terms = " WHERE ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				ELSE
					ls_terms = ls_terms + " AND ( ~~~"" + istr_search[li_i].db_name + "~~~".~~~"" + istr_search[li_i].db_field + "~~~" " + istr_search[li_i].operator + " " +istr_search[li_i].value + " )"
				END IF
			CASE "Status"
				IF Len(ls_terms) < 2 THEN 
					ls_terms = " WHERE ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
				ELSE
					ls_terms = ls_terms + " AND ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + istr_search[li_i].value + " )"
				END IF
			CASE "Date"
				IF Len(ls_terms) < 2 THEN 
					ls_terms =" WHERE (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
				ELSE
					ls_terms = ls_terms + " AND (TO_DATE(TO_CHAR(~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~",~~~'DD-MON-YYYY~~~'),~~~'DD-MON-YYYY~~~'  ) " + istr_search[li_i].operator + " TO_DATE(~~~'" + istr_search[li_i].value + "~~~',~~~'mm/dd/yyyy~~~' )" + " )"  //21-DEC-1998 format
				END IF
			CASE "String"
				IF Len(ls_terms) < 2 THEN 
					ls_terms = " WHERE ( ~"" + istr_search[li_i].db_name + "~".~"" + istr_search[li_i].db_field + "~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
				ELSE
					ls_terms = ls_terms + " AND ( ~~~"" + istr_search[li_i].db_name + "~~~".~~~"" + istr_search[li_i].db_field + "~~~" " + istr_search[li_i].operator + " ~~~'" + istr_search[li_i].value + "~~~' )"
				END IF
		END CHOOSE
	END IF
	li_i++
LOOP

Return ls_terms
end function

public subroutine wf_reset_condition ();Int li_i
li_i = 1
DO WHILE li_i <= Upperbound(istr_search)
	istr_search[li_i].db_name = ""
	istr_search[li_i].db_field = ""
	istr_search[li_i].operator = ""
	istr_search[li_i].value = ""
	istr_search[li_i].col_type = ""
	li_i++
LOOP
is_where = "  WHERE ( ~~~"PART_NUM~~~".~~~"CUSTOMER_ID~~~" = :al_cust and  ~~~"PART_NUM~~~".~~~"ITEM_STATUS~~~"  >= :ai_status )"		

end subroutine

public subroutine wf_init_dwdb ();istr_dwdb[1].db_name = "PART_NUM"
istr_dwdb[1].db_field = "SHEET_TYPE"
istr_dwdb[1].dw_column = "sheet_type"
istr_dwdb[1].col_type = "String"
istr_dwdb[1].dw_header = "Type"

istr_dwdb[2].db_name = "PART_NUM"
istr_dwdb[2].db_field = "item_desc"
istr_dwdb[2].dw_column = "item_desc"
istr_dwdb[2].col_type = "String"
istr_dwdb[2].dw_header = "Item Description"

istr_dwdb[3].db_name = "PART_NUM"
istr_dwdb[3].db_field = "ALLOY"
istr_dwdb[3].dw_column = "alloy"
istr_dwdb[3].col_type = "String"
istr_dwdb[3].dw_header = "Alloy"

istr_dwdb[4].db_name = "PART_NUM"
istr_dwdb[4].db_field = "TEMPER"
istr_dwdb[4].dw_column = "temper"
istr_dwdb[4].col_type = "String"
istr_dwdb[4].dw_header = "Temper"

istr_dwdb[5].db_name = "PART_NUM"
istr_dwdb[5].db_field = "ENDUSER_ID"
istr_dwdb[5].dw_column = "enduser_id"
istr_dwdb[5].col_type = "Customer"
istr_dwdb[5].dw_header = "End User"


end subroutine

public function long wf_get_userid (string as_name);Long ll_id, ll_row, ll_i
DataStore lds_u

ll_id = 0

lds_u = CREATE DataStore
lds_u.DataObject = "d_dddw_id_short"
lds_u.SetTransObject(SQLCA)
lds_u.Retrieve()

ll_row = lds_u.RowCount()
IF ll_row > 0 THEN
	FOR ll_i = 1 TO ll_row
		IF Upper(Trim(lds_u.GetItemString(ll_i, "customer_short_name"))) = Upper(Trim(as_name)) THEN
			ll_id = lds_u.GetItemNumber(ll_i, "customer_id")
		END IF
	NEXT
END IF

DESTROY lds_u

RETURN ll_id
end function

on w_order_entry_pn_list.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_reset=create cb_reset
this.cb_search=create cb_search
this.st_cond=create st_cond
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_pn_list=create dw_pn_list
this.dw_type=create dw_type
this.dw_pn=create dw_pn
this.rb_showall=create rb_showall
this.rb_activeonly=create rb_activeonly
this.dw_customer=create dw_customer
this.cb_close=create cb_close
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.gb_display=create gb_display
this.gb_search=create gb_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_reset
this.Control[iCurrent+3]=this.cb_search
this.Control[iCurrent+4]=this.st_cond
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_pn_list
this.Control[iCurrent+9]=this.dw_type
this.Control[iCurrent+10]=this.dw_pn
this.Control[iCurrent+11]=this.rb_showall
this.Control[iCurrent+12]=this.rb_activeonly
this.Control[iCurrent+13]=this.dw_customer
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.ddlb_customer
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.gb_display
this.Control[iCurrent+18]=this.gb_search
end on

on w_order_entry_pn_list.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_reset)
destroy(this.cb_search)
destroy(this.st_cond)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_pn_list)
destroy(this.dw_type)
destroy(this.dw_pn)
destroy(this.rb_showall)
destroy(this.rb_activeonly)
destroy(this.dw_customer)
destroy(this.cb_close)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.gb_display)
destroy(this.gb_search)
end on

event open;call super::open;ii_status = 1  //active only

dw_customer.Visible = FALSE
dw_customer.SetTransObject(sqlca) 
IF dw_customer.retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_prod_num_management::open function" )
ELSE
	dw_customer.SelectRow(1,TRUE)
	dw_customer.SetFocus()
End IF

Long ll_row, ll_i, ll_id
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN
	ll_id = dw_customer.GetItemNumber(1, "customer_id")
	il_cust_id = ll_id
	
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
	ddlb_customer.SelectItem(1)
	
	dw_pn_list.Retrieve(ll_id, ii_status)
	IF dw_pn_list.RowCount() > 0 THEN 
		dw_pn_list.SelectRow(0, FALSE)
		dw_pn_list.SelectRow(1, TRUE)
		il_id = dw_pn_list.GetItemNumber(1, "part_num_id")
		is_type = dw_pn_list.GetItemString(1, "sheet_type")
		dw_pn.Retrieve(il_id)
		dw_type.Event ue_show_shape(il_id, is_type)
	END IF

END IF

wf_init_dwdb()
is_select = "SELECT  ~~~"PART_NUM~~~".~~~"PART_NUM_ID~~~" , ~~~"PART_NUM~~~".~~~"SHEET_TYPE~~~" ,~~~"PART_NUM~~~".~~~"CUSTOMER_ID~~~" ,~~~"PART_NUM~~~".~~~"ITEM_DESC~~~" ,~~~"PART_NUM~~~".~~~"ITEM_STATUS~~~" ,~~~"PART_NUM~~~".~~~"ALLOY~~~" ,           ~~~"PART_NUM~~~".~~~"TEMPER~~~" ,~~~"PART_NUM~~~".~~~"ENDUSER_ID~~~"  FROM ~~~"PART_NUM~~~"    "  
is_where = "  WHERE ( ~~~"PART_NUM~~~".~~~"CUSTOMER_ID~~~" = :al_cust and  ~~~"PART_NUM~~~".~~~"ITEM_STATUS~~~"  >= :ai_status )"		

end event

type cb_select from u_cb within w_order_entry_pn_list
string tag = "Select"
integer x = 1017
integer y = 2099
integer width = 340
integer height = 90
integer taborder = 110
string facename = "Arial"
string text = "&Select"
end type

event clicked;call super::clicked;ClosewithReturn(Parent, il_id)
end event

type cb_reset from u_cb within w_order_entry_pn_list
integer x = 1232
integer y = 1766
integer width = 296
integer height = 93
integer taborder = 31
string facename = "Arial"
string text = "&Reset"
end type

event clicked;call super::clicked;dw_pn_list.Event ue_resume_where()
end event

type cb_search from u_cb within w_order_entry_pn_list
integer x = 1232
integer y = 1667
integer width = 296
integer height = 93
integer taborder = 21
string facename = "Arial"
string text = "&Search"
end type

event clicked;call super::clicked;String ls_s
DataWindow ldw_data

OpenWithParm(w_order_entry_part_filter, dw_pn_list.DataObject)
ldw_data = message.PowerObjectParm
IF ldw_data.RowCount() < 1 THEN 
	RETURN 0
ELSE
	Parent.Event ue_set_search(ldw_data)
	Return 1
END IF
end event

type st_cond from u_st within w_order_entry_pn_list
integer x = 73
integer y = 1690
integer width = 1083
integer height = 166
string facename = "Arial"
string text = "All"
end type

type st_4 from statictext within w_order_entry_pn_list
integer x = 870
integer y = 1392
integer width = 227
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 67108864
string text = "Obsoleted"
boolean focusrectangle = false
end type

type st_3 from statictext within w_order_entry_pn_list
integer x = 699
integer y = 1392
integer width = 157
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Active"
boolean focusrectangle = false
end type

type st_2 from statictext within w_order_entry_pn_list
integer x = 336
integer y = 1392
integer width = 351
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Color Indication:"
boolean focusrectangle = false
end type

type dw_pn_list from u_dw within w_order_entry_pn_list
event type long ue_show_only ( )
event ue_resume_where ( )
event type integer ue_search_retrieve ( )
integer y = 157
integer width = 1562
integer height = 1222
integer taborder = 20
boolean titlebar = true
string title = "Please select a part from the list:"
string dataobject = "d_pn_list_per_customer"
end type

event type long ue_show_only();Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN
	il_id = dw_customer.GetItemNumber(1, "customer_id")
	
	ddlb_customer.SelectItem(1)

	dw_pn_list.Retrieve(il_id, ii_status)
	dw_pn_list.SelectRow(0, FALSE)
	dw_pn_list.SelectRow(1, TRUE)
	IF dw_pn_list.RowCount() > 0 THEN 
		il_id = dw_pn_list.GetItemNumber(1, "part_num_id")
		is_type = dw_pn_list.GetItemString(1, "sheet_type")
	END IF
	dw_pn.Retrieve(il_id)
	dw_type.Event ue_show_shape(il_id, is_type)
ELSE
	RETURN 0
END IF

RETURN 1

end event

event ue_resume_where();String ls_modify, ls_where, ls_rc

wf_reset_condition()
ls_modify ="DataWindow.Table.Select = '" + is_select + is_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(il_cust_id,ii_status)
ELSE
	MessageBox("Error","Failure to resume datawindow!", StopSign!)
END IF
st_cond.Text = "All"
end event

event type integer ue_search_retrieve();String ls_modify, ls_where, ls_rc
Long ll_cust, ll_row
integer li_net

IF this.Event pfc_UpdatesPending() = 1 THEN
	li_net = MessageBox("Search...", "Initial searching,save changes first ?", Question!, OKCancel!,1)
	if li_net = 1 then
		Parent.Event pfc_Save()      
	else
	  	return 0
	end if
END IF

ls_where = wf_search_terms()

//ll_row = dw_customer.GetRow()
//ll_cust = dw_customer.GetItemNumber(ll_row, "customer_id")
ls_modify ="DataWindow.Table.Select = '" + is_select + ls_where + " '"
ls_rc = this.Modify(ls_modify)
IF ls_rc = "" THEN
	this.Retrieve(il_cust_id,ii_status)
ELSE
	MessageBox("Error","Failure to modify datawindow: " + ls_rc + ": " + ls_where, StopSign!)
END IF

Return 1
end event

event constructor;call super::constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_sort.of_SetUseDisplay(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)
SetTransObject(SQLCA)



end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

this.ScrollToRow(li_Row)

Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event rbuttondown;RETURN 0
end event

event rbuttonup;RETURN 0
end event

event clicked;//Override pfc_clicked

integer li_rc, li_status

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

//my code


IF row <= 0 THEN return

this.selectrow(0, FALSE)
this.selectrow(row, TRUE)

il_id = this.GetItemNumber(row, "part_num_id")
IF il_id <= 0 THEN 
	MessageBox("Error", "Invalid part id!")
	Return 
END IF

is_type = this.GetItemString(row, "sheet_type")
IF IsNULL(is_type) THEN 
	MessageBox("Error", "Invalid sheet type")
	Return 
END IF

SetPointer(HourGlass!)

dw_pn.Retrieve(il_id)
dw_type.Event ue_show_shape(il_id,is_type)

RETURN

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

type dw_type from u_dw within w_order_entry_pn_list
event type long ue_show_shape ( long al_id,  string as_shape )
integer x = 1573
integer y = 1440
integer width = 2227
integer height = 618
integer taborder = 40
string dataobject = "d_pn_ltrapezoid_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event type long ue_show_shape(long al_id, string as_shape);CHOOSE CASE Upper(Trim(as_shape))
	CASE "RECTANGLE"
		this.DataObject = "d_pn_rectangle_display"
	CASE "PARALLELOGRAM"
		this.DataObject = "d_pn_parallelogram_display"
	CASE "FENDER"
		this.DataObject = "d_pn_fender_display"
	CASE "CHEVRON"
		this.DataObject = "d_pn_chevron_display"
	CASE "CIRCLE"
		this.DataObject = "d_pn_circle_display"
	CASE "TRAPEZOID"
		this.DataObject = "d_pn_trapezoid_display"
	CASE "L.TRAPEZOID"
		this.DataObject = "d_pn_ltrapezoid_display"
	CASE "R.TRAPEZOID"
		this.DataObject = "d_pn_rtrapezoid_display"
	CASE "REINFORCEMENT"
		this.DataObject = "d_pn_reinforcement_display"
	CASE "LIFTGATE"
		this.DataObject = "d_pn_liftgate_shape_display"	
	CASE ELSE
		this.DataObject = "d_pn_x1shape_display"
END CHOOSE
this.SetTransObject(SQLCA)
this.Retrieve(al_id)

RETURN 1
end event

type dw_pn from u_dw within w_order_entry_pn_list
integer x = 1573
integer width = 2227
integer height = 1424
integer taborder = 30
string dataobject = "d_pn_item_detail_display"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;SetTransObject(SQLCA)

end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

type rb_showall from u_rb within w_order_entry_pn_list
integer x = 867
integer y = 1965
integer width = 315
string facename = "Arial"
string text = "Show All"
end type

event clicked;call super::clicked;ii_status = 0 //show all

RETURN dw_pn_list.Event ue_show_only()

end event

type rb_activeonly from u_rb within w_order_entry_pn_list
integer x = 263
integer y = 1965
integer width = 322
string facename = "Arial"
string text = "Active Only"
boolean checked = true
end type

event clicked;call super::clicked;ii_status = 1 //active only

RETURN dw_pn_list.Event ue_show_only()
end event

type dw_customer from u_dw within w_order_entry_pn_list
integer x = 1174
integer y = 6
integer width = 110
integer height = 42
integer taborder = 0
string dataobject = "d_pn_customer_short_display"
boolean vscrollbar = false
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve()
end event

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
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 


end event

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event pfc_rowchanged;call super::pfc_rowchanged;Integer li_return
long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)
this.ScrollToRow(li_Row)



Return 

end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

type cb_close from u_cb within w_order_entry_pn_list
string tag = "Exit"
integer x = 2205
integer y = 2099
integer width = 340
integer height = 90
integer taborder = 100
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;ClosewithReturn(Parent, 0)
end event

type ddlb_customer from dropdownlistbox within w_order_entry_pn_list
integer x = 48
integer y = 64
integer width = 1441
integer height = 995
integer taborder = 10
boolean bringtotop = true
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

event selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		il_cust_id = dw_customer.GetItemNumber(ll_i, "customer_id")
		//is_where = "  WHERE ( ~~~"PART_NUM~~~".~~~"CUSTOMER_ID~~~" = :al_cust and  ~~~"PART_NUM~~~".~~~"ITEM_STATUS~~~"  >= :ai_status )"		
		dw_pn_list.Retrieve(il_cust_id, ii_status)
		dw_pn_list.SelectRow(0, FALSE)
		dw_pn_list.SelectRow(1, TRUE)
		IF dw_pn_list.RowCount() > 0 THEN
			il_id = dw_pn_list.GetItemNumber(1, "part_num_id")
			is_type = dw_pn_list.GetItemString(1, "sheet_type")
			dw_pn.Retrieve(il_id)
			dw_type.Event ue_show_shape(il_id, is_type)
		ELSE
			dw_pn.Reset()
			dw_type.Reset()
		END IF
	END IF
NEXT




end event

type st_1 from statictext within w_order_entry_pn_list
integer x = 51
integer width = 424
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Current customer:"
boolean focusrectangle = false
end type

type gb_display from u_gb within w_order_entry_pn_list
integer x = 11
integer y = 1904
integer width = 1536
integer height = 154
integer taborder = 50
integer weight = 700
string facename = "Arial"
string text = "Display"
end type

type gb_search from u_gb within w_order_entry_pn_list
integer x = 11
integer y = 1616
integer width = 1536
integer height = 272
integer taborder = 11
integer weight = 700
string facename = "Arial"
string text = "Search"
end type

