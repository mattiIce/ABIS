$PBExportHeader$w_order_entry_job_list.srw
$PBExportComments$<Response> list jobs from this order item inherited from pfemain/w_response
forward
global type w_order_entry_job_list from w_response
end type
type cb_new from u_cb within w_order_entry_job_list
end type
type cb_open from u_cb within w_order_entry_job_list
end type
type cb_cancel from u_cb within w_order_entry_job_list
end type
type dw_job_list from u_dw within w_order_entry_job_list
end type
end forward

global type w_order_entry_job_list from w_response
integer x = 633
integer y = 374
integer width = 2531
integer height = 1382
string title = "Job from order item"
cb_new cb_new
cb_open cb_open
cb_cancel cb_cancel
dw_job_list dw_job_list
end type
global w_order_entry_job_list w_order_entry_job_list

type variables
Long il_order
Int ii_item
end variables

event open;call super::open;s_order_and_item lstr_s
Integer	li_item_status //Alex Gerlants. Order Entry Disable Job Button

lstr_s = Message.PowerObjectParm

ii_item = lstr_s.item_num
il_order = lstr_s.order_num

this.Title = "Jobs created from order#" + String(il_order) + " item#" + string(ii_item)

dw_job_list.retrieve(il_order, ii_item)

//Alex Gerlants. Order Entry Disable Job Button. Begin
li_item_status = lstr_s.item_status

If li_item_status = 2 Then //New item
	cb_new.Enabled = True
Else //Not a new item
	cb_new.Enabled = False
End If
//Alex Gerlants. Order Entry Disable Job Button. End
end event

on w_order_entry_job_list.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.cb_open=create cb_open
this.cb_cancel=create cb_cancel
this.dw_job_list=create dw_job_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.cb_open
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.dw_job_list
end on

on w_order_entry_job_list.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.cb_open)
destroy(this.cb_cancel)
destroy(this.dw_job_list)
end on

type cb_new from u_cb within w_order_entry_job_list
integer x = 519
integer y = 1190
integer width = 351
integer height = 83
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&New"
end type

event clicked;IF MessageBox("Question","Create a new production order for this order item?",Question!,OKCancel!, 1) = 2 THEN RETURN 0

gstr_order.item_num = ii_item
gstr_order.order_num = il_order
gl_message = 0

SetPointer(HourGlass!)
Message.StringParm = "w_production" 
gnv_app.of_getFrame().Event pfc_open()
Close(Parent)

end event

type cb_open from u_cb within w_order_entry_job_list
integer x = 1072
integer y = 1190
integer width = 351
integer height = 83
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Open"
end type

event clicked;Long ll_row

ll_row = dw_job_list.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select an order first!", StopSign! )
	RETURN
END IF

gl_message = dw_job_list.GetItemNumber(ll_row, "ab_job_num" )


SetPointer(HourGlass!)
Message.StringParm = "w_production" 
gnv_app.of_getFrame().Event pfc_open()
Close(Parent)

end event

type cb_cancel from u_cb within w_order_entry_job_list
integer x = 1624
integer y = 1190
integer width = 351
integer height = 83
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;Close(Parent)
end event

type dw_job_list from u_dw within w_order_entry_job_list
integer x = 22
integer y = 10
integer width = 2483
integer height = 1171
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_order_entry_ab_job_list"
end type

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
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
SetTransObject(SQLCA)

end event

event doubleclicked;IF (row < 1) OR IsNULL(row) THEN Return 0

cb_open.Event Clicked()
end event

event rbuttondown;//Override
RETURN 0
end event

event rbuttonup;//Override
RETURN 0
end event

