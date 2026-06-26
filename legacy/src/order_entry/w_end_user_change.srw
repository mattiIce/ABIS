$PBExportHeader$w_end_user_change.srw
forward
global type w_end_user_change from w_response
end type
type st_1 from statictext within w_end_user_change
end type
type st_2 from statictext within w_end_user_change
end type
type st_3 from statictext within w_end_user_change
end type
type cb_save from commandbutton within w_end_user_change
end type
type cb_cancel from commandbutton within w_end_user_change
end type
type dw_customer from u_dw within w_end_user_change
end type
type ddlb_customer from dropdownlistbox within w_end_user_change
end type
type st_order_num from statictext within w_end_user_change
end type
type st_end_user from statictext within w_end_user_change
end type
end forward

global type w_end_user_change from w_response
int X=636
int Y=720
int Width=1558
int Height=1933
boolean TitleBar=true
string Title="End User Change"
long BackColor=82042848
event ue_save ( )
st_1 st_1
st_2 st_2
st_3 st_3
cb_save cb_save
cb_cancel cb_cancel
dw_customer dw_customer
ddlb_customer ddlb_customer
st_order_num st_order_num
st_end_user st_end_user
end type
global w_end_user_change w_end_user_change

type variables
Long il_order_num
Long il_customer_id
String is_end_user_short_name
end variables

event ue_save;Int li_rc
Long ll_customer_id

li_rc = MessageBox("Save","Do you want to change end user to: " + TRIM(is_end_user_short_name) + "?", Question!,YesNo!)

IF li_rc = 1 THEN
	CONNECT USING SQLCA;
	SELECT CUSTOMER_ID INTO :ll_customer_id
   FROM CUSTOMER
	WHERE CUSTOMER_SHORT_NAME = :is_end_user_short_name;	
	
	UPDATE CUSTOMER_ORDER
	SET ENDUSER_ID = :ll_customer_id
	WHERE order_abc_num = :il_order_num;	
	
	COMMIT;
	
	CLOSEWITHRETURN(THIS,1)
	
ELSE
	RETURN
END IF

end event

on w_end_user_change.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
this.dw_customer=create dw_customer
this.ddlb_customer=create ddlb_customer
this.st_order_num=create st_order_num
this.st_end_user=create st_end_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.dw_customer
this.Control[iCurrent+7]=this.ddlb_customer
this.Control[iCurrent+8]=this.st_order_num
this.Control[iCurrent+9]=this.st_end_user
end on

on w_end_user_change.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_save)
destroy(this.cb_cancel)
destroy(this.dw_customer)
destroy(this.ddlb_customer)
destroy(this.st_order_num)
destroy(this.st_end_user)
end on

event open;call super::open;String ls_current_end_user, ls_modify
s_order_data lst_order_data

lst_order_data = Message.PowerObjectParm
il_order_num = lst_order_data.order_num
il_customer_id = lst_order_data.customer_num

CONNECT USING SQLCA;
SELECT CUSTOMER_SHORT_NAME INTO :ls_current_end_user
FROM CUSTOMER
WHERE CUSTOMER_ID = :lst_order_data.customer_num
USING SQLCA;

st_order_num.Text = String(il_order_num)
st_end_user.Text = ls_current_end_user

dw_customer.Visible = FALSE
dw_customer.SetTransObject(SQLCA)
dw_customer.Retrieve()

Long ll_row, ll_i
ll_row = dw_customer.RowCount()
IF ll_row > 0 THEN 
	FOR ll_i = 1 TO ll_row
		ddlb_customer.AddItem(dw_customer.GetItemString(ll_i, "customer_short_name"))
	NEXT
END IF


end event

type st_1 from statictext within w_end_user_change
int X=102
int Y=51
int Width=307
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Order Num : "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=82042848
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_end_user_change
int X=102
int Y=170
int Width=432
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Current End User :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=82042848
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_end_user_change
int X=99
int Y=288
int Width=761
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Change this order's end user to :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=82042848
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_save from commandbutton within w_end_user_change
int X=1148
int Y=1430
int Width=318
int Height=106
int TabOrder=10
boolean BringToTop=true
string Text="&Save"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_save()
end event

type cb_cancel from commandbutton within w_end_user_change
int X=1148
int Y=1610
int Width=318
int Height=106
int TabOrder=30
boolean BringToTop=true
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event pfc_close()
end event

type dw_customer from u_dw within w_end_user_change
int X=976
int Y=486
int Width=508
int Height=211
int TabOrder=20
string DataObject="d_customer_short_list"
boolean VScrollBar=false
boolean RightToLeft=true
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

type ddlb_customer from dropdownlistbox within w_end_user_change
int X=99
int Y=371
int Width=859
int Height=1264
int TabOrder=40
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
int Limit=20
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;String ls_text

ls_text = Text(index)
CHOOSE CASE ls_text 
	CASE "ALL CUSTOMERS"
		MessageBox("Error","~"ALL CUSTOMERS~" can not be selected to be the end user.")
	CASE ELSE
		is_end_user_short_name = ls_text
END CHOOSE


end event

type st_order_num from statictext within w_end_user_change
int X=428
int Y=51
int Width=340
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=82042848
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_end_user from statictext within w_end_user_change
int X=549
int Y=170
int Width=976
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

