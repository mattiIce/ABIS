$PBExportHeader$w_part_num_new.srw
$PBExportComments$<Child> create new part number inherited from pfcmain/w_child
forward
global type w_part_num_new from w_child
end type
type st_2 from statictext within w_part_num_new
end type
type st_1 from statictext within w_part_num_new
end type
type ddlb_type from u_ddlb within w_part_num_new
end type
type ddlb_customer from u_ddlb within w_part_num_new
end type
type dw_customer from u_dw within w_part_num_new
end type
type dw_type from u_dw within w_part_num_new
end type
type dw_pn from u_dw within w_part_num_new
end type
type cb_coil_cancel from u_cb within w_part_num_new
end type
type cb_save from u_cb within w_part_num_new
end type
end forward

global type w_part_num_new from w_child
string tag = "detail information of a new part"
integer x = 878
integer y = 488
integer width = 2866
integer height = 2360
string title = " Adding new parts"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
st_2 st_2
st_1 st_1
ddlb_type ddlb_type
ddlb_customer ddlb_customer
dw_customer dw_customer
dw_type dw_type
dw_pn dw_pn
cb_coil_cancel cb_coil_cancel
cb_save cb_save
end type
global w_part_num_new w_part_num_new

type variables
String is_type
Long il_cust
end variables

forward prototypes
public subroutine wf_update_trimming_data (boolean ab_trimming_required)
public function string wf_get_customer_name (long al_customer_id, n_tr_abc01 at_tran)
end prototypes

public subroutine wf_update_trimming_data (boolean ab_trimming_required);/*
Function:	wf_update_trimming_data
				Update to NULL value 6 part_num columns: 
					trimming_required, trim_type_code, incoming_coil_width, and trimmed_coil_width,
					trimmed_width_overridden, trimmed_width_override_user
Returns:		none
Arguments:	value	boolean	ab_trimming_required
*/

Decimal{3}	ld_null
String		ls_null

SetNull(ld_null)
SetNull(ls_null)

If Not ab_trimming_required Then
	dw_pn.Object.trimming_required[dw_pn.GetRow()] = "N"
	dw_pn.Object.trim_type_code[dw_pn.GetRow()] = ld_null
	dw_pn.Object.incoming_coil_width[dw_pn.GetRow()] = ld_null
	dw_pn.Object.trimmed_coil_width[dw_pn.GetRow()] = ld_null
	dw_pn.Object.trimmed_width_overridden[dw_pn.GetRow()] = ls_null
	dw_pn.Object.trimmed_width_override_user[dw_pn.GetRow()] = ls_null
End If
end subroutine

public function string wf_get_customer_name (long al_customer_id, n_tr_abc01 at_tran);/*
Function:	wf_get_customer_name
Returns:		string <== customer.customer_short_name
Arguments:	value	long			al_customer_id
				value	n_tr_abc01	at_tran
*/

String	ls_customer_short_name

select	customer_short_name
into		:ls_customer_short_name
from 		customer
where 	customer_id = :al_customer_id
using		at_tran;

If at_tran.sqlcode <> 0 Then //DB error
	ls_customer_short_name = ""
End If

Return ls_customer_short_name
end function

on w_part_num_new.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_type=create ddlb_type
this.ddlb_customer=create ddlb_customer
this.dw_customer=create dw_customer
this.dw_type=create dw_type
this.dw_pn=create dw_pn
this.cb_coil_cancel=create cb_coil_cancel
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_type
this.Control[iCurrent+4]=this.ddlb_customer
this.Control[iCurrent+5]=this.dw_customer
this.Control[iCurrent+6]=this.dw_type
this.Control[iCurrent+7]=this.dw_pn
this.Control[iCurrent+8]=this.cb_coil_cancel
this.Control[iCurrent+9]=this.cb_save
end on

on w_part_num_new.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_type)
destroy(this.ddlb_customer)
destroy(this.dw_customer)
destroy(this.dw_type)
destroy(this.dw_pn)
destroy(this.cb_coil_cancel)
destroy(this.cb_save)
end on

event open;call super::open;DataWindowChild	ldwc //Alex Gerlants. 03/01/2024. 9999_Work_Center
Integer				li_rtn, li_rows //Alex Gerlants. 03/01/2024. 9999_Work_Center

this.title = "Adding new part item"

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
ddlb_customer.SelectItem(1)
ddlb_customer.Event SelectionChanged(1)
//ddlb_type.SelectItem(1)

ll_row = dw_pn.InsertRow(0) //Alex Gerlants. 10/17/2016. Added "ll_row = ".
is_type=""

//dw_type.InsertRow(0)
//is_type = "Chevron"
//dw_pn.SetItem(dw_pn.GetRow(), "sheet_type", is_type)

dw_pn.SetItem(ll_row, "customer_id", dw_customer.GetItemNumber(1, "customer_id")) //Alex Gerlants. 10/17/2016

dw_pn.SetFocus()

//Alex Gerlants. 03/01/2024. 9999_Work_Center. Begin  
//li_rtn = dw_pn.GetChild("die_id", ldwc)
//
//If li_rtn = 1 Then //OK
//	ldwc.SetTransObject(sqlca)
//	li_rows= ldwc.Retrieve()
//End If

li_rtn = dw_pn.GetChild("line_num", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	li_rows = ldwc.Retrieve()
End If
//Alex Gerlants. 03/01/2024. 9999_Work_Center. End
end event

event activate;call super::activate;//IF f_security_door("Part Number Info") = 1 THEN RETURN 1
//This.Event ue_read_only()
end event

type st_2 from statictext within w_part_num_new
integer x = 9
integer y = 1392
integer width = 462
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pick a type:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_part_num_new
integer x = 23
integer y = 4
integer width = 526
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select a customer:"
boolean focusrectangle = false
end type

type ddlb_type from u_ddlb within w_part_num_new
integer x = 9
integer y = 1468
integer width = 599
integer height = 496
integer taborder = 40
string facename = "Arial"
string item[] = {"Chevron","Circle","Fender","Liftgate","L.Trapezoid","Parallelogram","Rectangle","Reinforcement","R.Trapezoid","Trapezoid","Other"}
end type

event selectionchanged;call super::selectionchanged;//Alex Gerlants. 12/05/2024. 9999_Work Center. Begin
String				ls_column_name, ls_sheet_type
Integer				li_rtn
Long					li_rows, ll_die_id, li_null
DataWindowChild	ldwc
//Alex Gerlants. 12/05/2024. 9999_Work Center. End

is_type = Text(index)
SetNull(li_null)

CHOOSE CASE Upper(Trim(is_type))
	CASE "RECTANGLE"
		dw_type.DataObject = "d_pn_rectangle_new"
	CASE "PARALLELOGRAM"
		dw_type.DataObject = "d_pn_parallelogram_new"
	CASE "FENDER"
		dw_type.DataObject = "d_pn_fender_new"
	CASE "CHEVRON"
		dw_type.DataObject = "d_pn_chevron_new"
	CASE "CIRCLE"
		dw_type.DataObject = "d_pn_circle_new"
	CASE "TRAPEZOID"
		dw_type.DataObject = "d_pn_trapezoid_new"
	CASE "L.TRAPEZOID"
		dw_type.DataObject = "d_pn_ltrapezoid_new"
	CASE "R.TRAPEZOID"
		dw_type.DataObject = "d_pn_rtrapezoid_new"
	CASE "REINFORCEMENT"
		dw_type.DataObject = "d_pn_reinforcement_new"
	CASE "LIFTGATE"
		dw_type.DataObject = "d_pn_liftgate_shape_new"	
	CASE ELSE
		dw_type.DataObject = "d_pn_x1shape_new"
END CHOOSE
dw_type.SetTransObject(SQLCA)
dw_type.InsertRow(0)

dw_pn.SetItem(dw_pn.GetRow(), "sheet_type", is_type)

//Alex Gerlants. 12/05/2024. 9999_Work Center. Begin
li_rtn = dw_pn.GetChild("die_id", ldwc)

If li_rtn = 1 Then //OK
	ldwc.SetTransObject(sqlca)
	li_rows = ldwc.Retrieve(is_type)
	
	If li_rows > 0 Then
		ll_die_id = ldwc.GetItemNumber(1, "die_id")
		dw_pn.Object.die_id[1] = ll_die_id
	Else
		dw_pn.Object.die_id[1] = li_null
	End If
End If
//Alex Gerlants. 12/05/2024. 9999_Work Center. End

end event

type ddlb_customer from u_ddlb within w_part_num_new
integer x = 23
integer y = 76
integer width = 599
integer height = 912
integer taborder = 30
string facename = "Arial"
end type

event selectionchanged;call super::selectionchanged;String ls_text
Long ll_row, ll_i

ls_text = Text(index)
ll_row = dw_customer.RowCount()
FOR ll_i = 1 TO ll_row
	IF dw_customer.GetItemString(ll_i, "customer_short_name") = ls_text THEN
		il_cust = dw_customer.GetItemNumber(ll_i, "customer_id")
		dw_pn.SetItem(dw_pn.GetRow(), "customer_id", il_cust)
	END IF
NEXT

end event

type dw_customer from u_dw within w_part_num_new
integer x = 562
integer y = 4
integer width = 73
integer height = 44
integer taborder = 20
string dataobject = "d_customer_short_display"
end type

type dw_type from u_dw within w_part_num_new
string tag = "Detail information of the type"
integer x = 631
integer y = 1496
integer width = 2181
integer height = 612
integer taborder = 20
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

type dw_pn from u_dw within w_part_num_new
string tag = "Detail information of an part item"
integer x = 631
integer width = 2181
integer height = 1488
integer taborder = 10
string dataobject = "d_pn_item_detail_new"
boolean vscrollbar = false
boolean livescroll = false
end type

event rbuttondown;//disbaled
Return 0
end event

event rbuttonup;//disbaled
Return 0
end event

event constructor;call super::constructor;This.SetTransObject(SQLCA)
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event editchanged;call super::editchanged;String	ls_column_name, ls_modstring
Long		ll_note_length

If row > 0 Then
	ls_column_name = dwo.name
	
	If ls_column_name = "item_note" Then
		f_display_num_of_chars(This, data, "num_of_char_t")
	End If
End If
end event

type cb_coil_cancel from u_cb within w_part_num_new
event clicked pbm_bnclicked
string tag = "Close this window"
integer x = 1925
integer y = 2152
integer taborder = 40
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;s_part_num_info lds_rc
dw_pn.Reset()
dw_type.Reset()
lds_rc.part_num_id = 0
CloseWithReturn(parent, lds_rc)
end event

type cb_save from u_cb within w_part_num_new
string tag = "Close this window and pass the information"
integer x = 713
integer y = 2152
integer taborder = 30
string facename = "Arial"
string text = "&Save"
end type

event clicked;Integer li_rc
Long ll_new_id, ll_enduser
Real lr_gauge
String ls_type
s_part_num_info lds_rc
Integer		li_sector //Alex Gerlants. 10/04/2016
String		ls_trimming_required, ls_err_string, ls_null, ls_system_log_msg, ls_customer_name //Alex Gerlants. 10/17/2016
Decimal{3}	ld_incoming_coil_width, ld_trimmed_coil_width, ld_difference //Alex Gerlants. 10/17/2016
Decimal{3}	ld_lower_limit, ld_upper_limit //Alex Gerlants. 06/16/2017
Integer		li_trim_type_code, li_answer //Alex Gerlants. 10/17/2016

IF MessageBox("Question", "Save changes?", Question!, OkCancel!, 2 ) = 2 THEN RETURN 0

dw_pn.AcceptText()
dw_type.AcceptText()

IF is_type = "" THEN
	MessageBox("Error", "Invalid data. Please specify a type!")
	RETURN -4
END IF

ll_enduser = dw_pn.GetItemNumber(dw_pn.GetRow(), "enduser_id", Primary!, FALSE)
IF ll_enduser = 0 OR IsNULL(ll_enduser) THEN
	MessageBox("Error", "Invalid end user.")
	RETURN - 5
END IF

lr_gauge = dw_pn.GetItemNumber(dw_pn.GetRow(), "gauge", Primary!, FALSE)
IF lr_gauge = 0.0 OR IsNULL(lr_gauge) THEN
	MessageBox("Error", "Invalid Gauge.")
	RETURN - 5
END IF


ll_new_id = 0
ll_new_id = f_get_next_value("part_num_id_seq")
IF ll_new_id <= 0 THEN
	MessageBox("Error", "Failed to retrieve new id!")
	RETURN -3
END IF


dw_pn.SetItem(dw_pn.GetRow(), "part_num_id", ll_new_id)
dw_type.SetItem(dw_type.GetRow(), "part_num_id", ll_new_id)

dw_pn.AcceptText()
dw_type.AcceptText()

//Alex Gerlants. 10/04/2016. Begin
li_sector = dw_pn.Object.sector[dw_pn.GetRow()]
If IsNull(li_sector) Then li_sector = -99

If li_sector = -99 Then
	MessageBox("Sector must be selected", "Please select sector.", StopSign!)
	dw_pn.SetFocus()
	dw_pn.ScrollToRow(dw_pn.GetRow())
	dw_pn.SetRow(dw_pn.GetRow())
	dw_pn.SetColumn("sector")
	
	Return -6
End If
//Alex Gerlants. 10/04/2016. End

//Alex Gerlants. 10/17/2016. Begin
ls_trimming_required = Upper(Trim(dw_pn.Object.trimming_required[dw_pn.GetRow()]))
	
If ls_trimming_required = "Y" Then
	//Check the edge trimming data
	ld_incoming_coil_width = dw_pn.Object.incoming_coil_width[dw_pn.GetRow()]
	ld_trimmed_coil_width = dw_pn.Object.trimmed_coil_width[dw_pn.GetRow()]
	li_trim_type_code = dw_pn.Object.trim_type_code[dw_pn.GetRow()]
	
	If IsNull(ld_incoming_coil_width) Then
		ls_err_string = ls_err_string + "~n~rIncoming coil width missing, "
	End If
	
	If IsNull(ld_trimmed_coil_width) Then
		ls_err_string = ls_err_string + "~n~rTrimmed coil width missing, "
	End If
	
	If IsNull(li_trim_type_code) Then
		ls_err_string = ls_err_string + "~n~rTrim type missing, "
	End If
	
	If ld_incoming_coil_width - ld_trimmed_coil_width < 0 Then
		ls_err_string = ls_err_string + "~n~rIncoming coil width must be greater then trimmed coil width, "
	End If
	
	If ls_err_string = "" Then //No errors so far
		
		//Alex Gerlants. 06/16/2017. Begin
		select	lower_limit, upper_limit
		into		:ld_lower_limit, :ld_upper_limit
		from		dbo.edge_trim_tolearance
		using		sqlca;
		
		If sqlca.sqlcode = 0 Then //OK
			If IsNull(ld_lower_limit) Then ld_lower_limit = 1.500
			If IsNull(ld_upper_limit) Then ld_upper_limit = 12.000
		Else //DB error or no row found
			ld_lower_limit = 1.500
			ld_upper_limit = 12.000
		End If
		//Alex Gerlants. 06/16/2017. End
	
		//Difference between incoming coil width and trimmed coil width must be 3/4 of an inch or greater
		ld_difference = ld_incoming_coil_width - ld_trimmed_coil_width
		
		//Alex Gerlants. 12/06/2016. As per Laura Anderson, changed from "< 1" to "< 0.75"
		//Alex Gerlants. 06/16/2017. As per Dan Polkinhorne, changed from "< 0.75" to "ld_difference < 1.50 Or ld_difference > 12.00"
		If ld_difference < ld_lower_limit Or ld_difference > ld_upper_limit Then //Error
			li_answer = MessageBox("Data Entry Error", &
								"Trimmed width is under trimmer tolerance" + &
								"~n~r~n~rDifference between incoming coil width and trimmed coil width " + &
								"must not be less than " + String(ld_lower_limit, "###.#0") + " inches " + &
								"or greater than " + String(ld_upper_limit, "###.#0") + " inches." + &
								"~n~r~n~rPlease click on 'Yes' to override, or 'No' to go back, and correct.", &
								Question!, YesNo!, 2)
					
			If li_answer = 2 Then //No
				Return -7
			Else //li_answer = 1 <== Override
				dw_pn.Object.trimmed_width_overridden[dw_pn.GetRow()] = "Y"
				dw_pn.Object.trimmed_width_override_user[dw_pn.GetRow()] = sqlca.logid
				
				//Insert into system_log table
				ls_customer_name = wf_get_customer_name(il_cust, sqlca)
				
				ls_system_log_msg = 	"Part " + String(ll_new_id) + &
											" Customer Id " + String(il_cust) + &
											" Customer Name " + ls_customer_name + &
											" by " + gnv_app.of_GetUserId() + ". " + &
											String(Today(), "mm-dd-yyyy @HH:MM.") + &
											" Trimmed coil width overridden."
			
				f_add_system_log_tran(ls_system_log_msg, sqlca)
			End If
		Else //Difference between incoming coil width and trimmed coil width is 3/4 of an inch or greater. This is OK.
			SetNull(ls_null)
			dw_pn.Object.trimmed_width_overridden[dw_pn.GetRow()] = ls_null
			dw_pn.Object.trimmed_width_override_user[dw_pn.GetRow()] = ls_null
		End If
	Else
		//Remove the last comma
		ls_err_string = Left(ls_err_string, Len(ls_err_string) - 2)
		
		MessageBox("Data Entry Error", "Please correct:~n~r" + ls_err_string)
		Return -8
	End If
Else //ls_trimming_required = "N"
	wf_update_trimming_data(False) //Update to NULL value dw_pn part_num columns: trim_type_code, incoming_coil_width, and trimmed_coil_width
End If
//Alex Gerlants. 10/17/2016. End

li_rc = dw_pn.Update()
IF (li_rc = 1) OR IsNULL(li_rc) THEN
	//COMMIT USING SQLCA;
ELSE
	MessageBox("Error", "Failed to save part item changes!")
	ROLLBACK USING SQLCA;
	RETURN -1
END IF
li_rc = dw_type.Update()
IF (li_rc = 1) OR IsNULL(li_rc) THEN
	COMMIT USING SQLCA;
ELSE
	MessageBox("Error", "Failed to save part type changes!")
	ROLLBACK USING SQLCA;
	RETURN -2
END IF

lds_rc.part_num_id  = ll_new_id
lds_rc.part_type = is_type
lds_rc.customer_id = il_cust
CloseWithReturn(parent,lds_rc)
end event

