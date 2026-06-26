$PBExportHeader$w_order_entry_part_filter.srw
$PBExportComments$<Response)  order entry part number search window
forward
global type w_order_entry_part_filter from w_main
end type
type dw_1 from u_dw within w_order_entry_part_filter
end type
type cb_cancel from u_cb within w_order_entry_part_filter
end type
type cb_reset from u_cb within w_order_entry_part_filter
end type
type st_6 from u_st within w_order_entry_part_filter
end type
type mle_2 from u_mle within w_order_entry_part_filter
end type
type ddlb_column from u_ddlb within w_order_entry_part_filter
end type
type cb_apply from u_cb within w_order_entry_part_filter
end type
type dw_search from u_dw within w_order_entry_part_filter
end type
type cb_add from u_cb within w_order_entry_part_filter
end type
type cb_remove from u_cb within w_order_entry_part_filter
end type
type gb_2 from u_gb within w_order_entry_part_filter
end type
end forward

global type w_order_entry_part_filter from w_main
integer x = 859
integer y = 477
integer width = 2052
integer height = 1078
string title = "Order Entry Part Filter"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_buildexpr1 ( )
event type any ue_get_header ( string as_id )
dw_1 dw_1
cb_cancel cb_cancel
cb_reset cb_reset
st_6 st_6
mle_2 mle_2
ddlb_column ddlb_column
cb_apply cb_apply
dw_search dw_search
cb_add cb_add
cb_remove cb_remove
gb_2 gb_2
end type
global w_order_entry_part_filter w_order_entry_part_filter

type variables
s_colname_header istr_ch[]
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]

end variables

forward prototypes
public subroutine wf_init_dwdb ()
end prototypes

event type any ue_get_header(string as_id);Int li_i
s_dw_header_type lstr_ht

lstr_ht.dw_header = "NULL"
lstr_ht.col_type = "NULL"

li_i = 1
DO WHILE li_i <= UpperBound(istr_dwdb)
	IF istr_dwdb[li_i].dw_column = as_id THEN
		 lstr_ht.dw_header = istr_dwdb[li_i].dw_header
		 lstr_ht.col_type = istr_dwdb[li_i].col_type
	END IF
	li_i++
LOOP

RETURN lstr_ht

end event

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

on w_order_entry_part_filter.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_reset)
destroy(this.st_6)
destroy(this.mle_2)
destroy(this.ddlb_column)
destroy(this.cb_apply)
destroy(this.dw_search)
destroy(this.cb_add)
destroy(this.cb_remove)
destroy(this.gb_2)
end on

on w_order_entry_part_filter.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_reset=create cb_reset
this.st_6=create st_6
this.mle_2=create mle_2
this.ddlb_column=create ddlb_column
this.cb_apply=create cb_apply
this.dw_search=create dw_search
this.cb_add=create cb_add
this.cb_remove=create cb_remove
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_reset
this.Control[iCurrent+4]=this.st_6
this.Control[iCurrent+5]=this.mle_2
this.Control[iCurrent+6]=this.ddlb_column
this.Control[iCurrent+7]=this.cb_apply
this.Control[iCurrent+8]=this.dw_search
this.Control[iCurrent+9]=this.cb_add
this.Control[iCurrent+10]=this.cb_remove
this.Control[iCurrent+11]=this.gb_2
end on

event open;call super::open;dw_1.DataObject = Message.StringParm
dw_1.SetTransObject(SQLCA)

// Build the list of columns.
wf_init_dwdb()

integer li_colcount
integer li_idx, li_i
string	ls_colname, ls_type
s_dw_header_type lstr_ht

li_i = 1
//lw_parent = gnv_app.of_GetFrame().GetActiveSheet()
//IF IsValid(lw_parent) THEN
	li_colcount = Integer( dw_1.Object.DataWindow.Column.Count )
	For li_idx = 1 to li_colcount
		ls_colname = dw_1.Describe("#"+ string(li_idx) +".Name")
		ls_type = dw_1.Describe("#"+ string(li_idx) +".ColType")
		If len(ls_colname) > 0 Then
			lstr_ht = this.Event ue_get_header(ls_colname)
			IF lstr_ht.dw_header <> "NULL" THEN 
				ddlb_column.AddItem(lstr_ht.dw_header)
				istr_ch[li_i].col_name = ls_colname
				istr_ch[li_i].dw_header = lstr_ht.dw_header
				istr_ch[li_i].col_type = lstr_ht.col_type
				li_i++
			END IF
		End If
	Next
//END IF

end event

type dw_1 from u_dw within w_order_entry_part_filter
boolean visible = false
integer x = 1814
integer y = 890
integer width = 121
integer height = 35
integer taborder = 0
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	constructor
//
//	Description:
//	Initializes the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetTransObject(sqlca)

of_SetRowSelect(true)
of_SetUpdateable(false)

of_Retrieve()

end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	rowfocuschanged
//
//	Description:
//	Set the row value in grouping one equal to the current row number.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	pfc_retrieve
//
//	Arguments:
//	None
//
//	Returns:
//	long
//	The number of rows retrieved from the database
// -1 if it fails
// If any argument's value is NULL, pfc_retrieve returns NULL
//
//	Description:
//	Retrieves data into the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return this.Retrieve()
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	pfc_prermbmenu
//
//	Arguments:
//	am_dw   	the menu that will be displayed when the DataWindow
//				is right clicked.
//
//	Returns:
//	None
//
//	Description:
// Initialize the Right Mouse Menu for the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

am_dw.m_table.m_insert.enabled = false
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_delete.enabled = false
end event

type cb_cancel from u_cb within w_order_entry_part_filter
integer x = 1265
integer y = 883
integer width = 424
integer height = 83
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;ClosewithReturn(Parent, dw_search)
end event

type cb_reset from u_cb within w_order_entry_part_filter
integer x = 779
integer y = 883
integer width = 424
integer height = 83
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "C&lear Search"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	clicked
//
//	Description:
//	Sets the filter to the expression created by of_BuildExpression(), then
// applies the filter to the DataWindow.
//
//////////////////////////////////////////////////////////////////////////////

dw_search.Reset()
dw_search.ResetUpdate()
cb_apply.Enabled = FALSE
end event

type st_6 from u_st within w_order_entry_part_filter
integer x = 80
integer y = 90
integer height = 77
boolean bringtotop = true
string text = "Select Column:"
end type

type mle_2 from u_mle within w_order_entry_part_filter
integer x = 48
integer y = 794
integer width = 1832
integer height = 61
integer taborder = 0
boolean bringtotop = true
long backcolor = 79741120
string text = "You can also build a dynamic search expression with a column, operator and value."
boolean border = false
boolean autovscroll = false
boolean displayonly = true
borderstyle borderstyle = stylebox!
end type

type ddlb_column from u_ddlb within w_order_entry_part_filter
integer x = 69
integer y = 147
integer width = 1039
integer height = 394
integer taborder = 10
boolean bringtotop = true
boolean sorted = false
end type

type cb_apply from u_cb within w_order_entry_part_filter
integer x = 293
integer y = 883
integer width = 424
integer height = 83
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean enabled = false
string text = "&Apply Search"
boolean default = true
end type

event clicked;Int li_row, li_i
String ls_s

dw_search.AcceptText()
dw_search.ResetUpdate()
li_row = dw_search.rowCount()
IF li_row > 0 THEN
	FOR li_i = 1 TO li_row
		ls_s = dw_search.GetItemString(li_i, "value_t", Primary!, FALSE)
		IF (Len(ls_s) < 1) OR IsNULL(ls_s)  THEN
			MessageBox("Warning", dw_search.GetItemString(li_i, "column_t", Primary!, FALSE) + " has no value yet." )
			RETURN 0
		END IF
	NEXT
ELSE			
	MessageBox("Warning", "Nothing to search here.")
	RETURN -1
END IF

ClosewithReturn(parent, dw_search)
end event

type dw_search from u_dw within w_order_entry_part_filter
integer x = 69
integer y = 243
integer width = 1902
integer height = 509
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_search_dw"
end type

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetUpdateable(false)

end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//override
RETURN 0
end event

event losefocus;this.AcceptText()
this.ResetUpdate()
end event

type cb_add from u_cb within w_order_entry_part_filter
integer x = 1159
integer y = 147
integer width = 351
integer height = 80
integer taborder = 20
boolean bringtotop = true
string text = "&Add"
end type

event clicked;String ls_s, ls_colname, ls_type
Int li_i, ll_row

ls_s = ddlb_column.text

li_i = 1
DO WHILE li_i <= UpperBound(istr_ch)
	IF Trim(istr_ch[li_i].dw_header) = Trim(ls_s) THEN
		ls_type = istr_ch[li_i].col_type
		ll_row = dw_search.InsertRow(0)
		dw_search.SetItem(ll_row, "column_t", ls_s)
		dw_search.SetItem(ll_row, "operator_t", "=")
		CHOOSE CASE UPPER(Trim(ls_type))
			CASE "STRING"
				dw_search.SetItem(ll_row, "format_t", "2")
			CASE "NUMBER"
				dw_search.SetItem(ll_row, "format_t", "1")
			CASE "DATE"
				dw_search.SetItem(ll_row, "format_t", "3")
			CASE "STATUS"
				dw_search.SetItem(ll_row, "format_t", "4")
			CASE "CUSTOMER"
				dw_search.SetItem(ll_row, "format_t", "5")
			CASE "CARRIER"
				dw_search.SetItem(ll_row, "format_t", "5")
			CASE "VEHICLE_STATUS"
				dw_search.SetItem(ll_row, "format_t", "4")
			CASE ELSE
				dw_search.SetItem(ll_row, "format_t", "2")				
		END CHOOSE
		cb_apply.Enabled = TRUE
	End If
	li_i++
LOOP


end event

type cb_remove from u_cb within w_order_entry_part_filter
integer x = 1576
integer y = 147
integer width = 351
integer height = 80
integer taborder = 30
boolean bringtotop = true
string text = "&Remove"
end type

event clicked;Long ll_row
ll_row = dw_search.GetRow()
IF ll_row > 0 THEN
	dw_search.deleterow(ll_row)
	IF dw_search.RowCount() < 1 THEN cb_apply.Enabled = FALSE
	dw_search.AcceptText()
	dw_search.ResetUpdate()
END IF
end event

type gb_2 from u_gb within w_order_entry_part_filter
integer x = 37
integer y = 26
integer width = 1960
integer height = 758
integer taborder = 0
long backcolor = 79741120
string text = "Build Serach From Supplied Criteria:"
end type

