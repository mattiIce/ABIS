$PBExportHeader$w_cust_coil_list.srw
$PBExportComments$<Child>list all coils belong to a customer, used in Order Entry, inherited from pfemain/w_child
forward
global type w_cust_coil_list from w_child
end type
type dw_customer_coil_list from u_dw within w_cust_coil_list
end type
type cb_copy from u_cb within w_cust_coil_list
end type
type cbx_w from checkbox within w_cust_coil_list
end type
type cb_cancel from u_cb within w_cust_coil_list
end type
type cb_show from u_cb within w_cust_coil_list
end type
type em_w from u_em within w_cust_coil_list
end type
type st_1 from statictext within w_cust_coil_list
end type
type st_2 from statictext within w_cust_coil_list
end type
end forward

global type w_cust_coil_list from w_child
int X=472
int Y=403
int Width=2619
int Height=1395
WindowType WindowType=response!
boolean TitleBar=true
string Title="Customer Coil List"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_customer_coil_list dw_customer_coil_list
cb_copy cb_copy
cbx_w cbx_w
cb_cancel cb_cancel
cb_show cb_show
em_w em_w
st_1 st_1
st_2 st_2
end type
global w_cust_coil_list w_cust_coil_list

type variables
Long il_cur_cust_id
s_order_data  istr_data
end variables

forward prototypes
public subroutine wf_close_extenal ()
end prototypes

public subroutine wf_close_extenal ();ib_closestatus = true
Close (this)

end subroutine

on w_cust_coil_list.create
int iCurrent
call super::create
this.dw_customer_coil_list=create dw_customer_coil_list
this.cb_copy=create cb_copy
this.cbx_w=create cbx_w
this.cb_cancel=create cb_cancel
this.cb_show=create cb_show
this.em_w=create em_w
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_customer_coil_list
this.Control[iCurrent+2]=this.cb_copy
this.Control[iCurrent+3]=this.cbx_w
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_show
this.Control[iCurrent+6]=this.em_w
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
end on

on w_cust_coil_list.destroy
call super::destroy
destroy(this.dw_customer_coil_list)
destroy(this.cb_copy)
destroy(this.cbx_w)
destroy(this.cb_cancel)
destroy(this.cb_show)
destroy(this.em_w)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;String ls_cust_name

il_cur_cust_id = message.DoubleParm

SELECT customer_full_name INTO :ls_cust_name
FROM customer
WHERE customer_id = :il_cur_cust_id
USING SQLCA;

this.title = " Coils list ( Customer:  " + ls_cust_name + " )"

dw_customer_coil_list.SetTransObject(sqlca)
IF dw_customer_coil_list.Event pfc_retrieve() = -1 THEN
	SQLCA.of_Rollback()
	MessageBox("Error", "w_cust_coil_list::open event" )
	Return 0
ELSE
	SQLCA.of_Commit()
	dw_customer_coil_list.SetFocus()
End IF

end event

type dw_customer_coil_list from u_dw within w_cust_coil_list
int X=33
int Y=0
int Width=2542
int Height=1136
int TabOrder=10
string DataObject="d_coil_cust_available"
boolean HScrollBar=true
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_cur_cust_id)
end event

event constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 
of_SetFilter(TRUE)


end event

event rbuttondown;//Override
Return 0
end event

event rbuttonup;//Override
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

type cb_copy from u_cb within w_cust_coil_list
int X=161
int Y=1206
int Height=80
int TabOrder=30
string Text="&Add"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;SetPointer(HourGlass!)

Long ll_row, ll_coil_num, ll_order
Window lw_parent

ll_row = dw_customer_coil_list.GetRow()
IF ll_row > 0 THEN
	ll_coil_num = dw_customer_coil_list.GetItemNumber(ll_row, "coil_coil_abc_num", Primary!, TRUE)
	IF ll_coil_num <= 0 THEN 
		MessageBox("Error", "Failed to retrieve this coil!" )
		Return 0
	END IF
	ll_order = dw_customer_coil_list.GetItemNumber(ll_row, "order_coil_order_abc_num", Primary!, TRUE)
	IF IsNULL(ll_order) THEN ll_order = 0
	IF ll_order > 0 THEN 
		IF MessageBox("Question", "Coil had been assigned to another customer order "+ String(ll_order) + " already. Continue?", Question!, YesNo!, 2 ) = 2 THEN Return 0
	END IF
	
	CloseWithReturn(Parent,ll_coil_num)
ELSE
	Return -1
END IF

Return 1
end event

type cbx_w from checkbox within w_cust_coil_list
int X=1854
int Y=1206
int Width=344
int Height=80
boolean BringToTop=true
string Text="Coil Width = "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF this.Checked THEN
	cb_show.Text = "Show"
ELSE
	cb_show.Text = "ShowAll"
END IF
end event

type cb_cancel from u_cb within w_cust_coil_list
int X=794
int Y=1206
int Height=80
int TabOrder=40
string Text="C&lose"
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event clicked;ClosewithReturn(Parent, 0)
end event

type cb_show from u_cb within w_cust_coil_list
int X=1426
int Y=1206
int Height=80
int TabOrder=50
string Text="&ShowAll"
string FaceName="Arial"
end type

event clicked;String ls_f
IF cbx_w.Checked THEN
	//filter
	ls_f = "coil_coil_width = " + em_w.Text	
ELSE
	//no filter
	ls_f = ""
END IF
dw_customer_coil_list.inv_filter.of_SetFilter(ls_f)
dw_customer_coil_list.inv_filter.of_Filter()

end event

type em_w from u_em within w_cust_coil_list
int X=2209
int Y=1210
int Width=336
int Height=74
int TabOrder=20
boolean BringToTop=true
string Mask="##,###.##"
double Increment=0
string MinMax=""
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

type st_1 from statictext within w_cust_coil_list
int X=40
int Y=1142
int Width=944
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="Coil has been assigned to an order already"
boolean FocusRectangle=false
long TextColor=65535
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_cust_coil_list
int X=1009
int Y=1142
int Width=757
int Height=54
boolean Enabled=false
boolean BringToTop=true
string Text="OR coil has not been assigned yet."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

