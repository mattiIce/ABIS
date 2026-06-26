$PBExportHeader$u_default_packingticket.sru
$PBExportComments$default packaging ticket
forward
global type u_default_packingticket from u_report_object
end type
end forward

global type u_default_packingticket from u_report_object
end type
global u_default_packingticket u_default_packingticket

type variables

end variables

forward prototypes
public function integer of_groupdwprint_4skid (long al_shipment, long al_skid_num)
public function integer of_groupdwprint_4skid_print (long al_shipment, long al_skid_num)
end prototypes

public function integer of_groupdwprint_4skid (long al_shipment, long al_skid_num);//Alex Gerlants. Reprint_Packaging_Ticket_Button. 05/07/2019. Begin
/*
Function:	of_groupdwprint_4skid
				Print packaging ticket for one skid
Returns:		integer
Arguments:	value	long		al_shipment
				value	long		al_skid_num
*/

Integer		li_rtn
Long			ll_rows, ll_row
Long			ll_rows_sheet, ll_rows_scrap, ll_rows_reject
DataStore	lds_print

li_rtn = PrintSetup()

If li_rtn = -1 Then //User clicked on "Cancel"
	Return 1
End If

select	count(*)
into		:ll_rows_sheet
from		sheet_packing_item
where		packing_list = :al_shipment
and		sheet_skid_num = :al_skid_num
using		sqlca;

select	count(*)
into		:ll_rows_scrap
from		scrap_packing_item
where		packing_list = :al_shipment
and		scrap_skid_num = :al_skid_num
using		sqlca;

select	count(*)
into		:ll_rows_reject
from		reject_coil_packing_item
where		packing_list = :al_shipment
and		rej_coil_packaging_ticket = :al_skid_num
using		sqlca;

lds_print = Create DataStore
lds_print.DataObject = ""

If ll_rows_sheet > 0 Then
	lds_print.DataObject = "d_packaging_ticket_sheet_4skid"
ElseIf ll_rows_scrap > 0 Then
	lds_print.DataObject = "d_packaging_ticket_scrap_4skid"
ElseIf ll_rows_reject > 0 Then
	lds_print.DataObject = "d_packaging_ticket_rejcoil_4skid"
Else
	//
End If

If lds_print.DataObject <> "" Then
	lds_print.SetTransObject(sqlca)
	ll_rows = lds_print.Retrieve(al_shipment, al_skid_num)
	lds_print.Print()
End If

Return 0
//Alex Gerlants. Reprint_Packaging_Ticket_Button. 05/07/2019. End
end function

public function integer of_groupdwprint_4skid_print (long al_shipment, long al_skid_num);//Alex Gerlants. Reprint_Packaging_Ticket_Button. 05/07/2019. Begin
/*
Function:	of_groupdwprint_4skid_print
				Print packaging ticket for one skid
Returns:		integer
Arguments:	value	long		al_shipment
				value	long		al_skid_num
*/

Integer		li_rtn
Long			ll_rows, ll_row
Long			ll_rows_sheet, ll_rows_scrap, ll_rows_reject
DataStore	lds_print

If li_rtn = -1 Then //User clicked on "Cancel"
	Return 1
End If

select	count(*)
into		:ll_rows_sheet
from		sheet_packing_item
where		packing_list = :al_shipment
and		sheet_skid_num = :al_skid_num
using		sqlca;

select	count(*)
into		:ll_rows_scrap
from		scrap_packing_item
where		packing_list = :al_shipment
and		scrap_skid_num = :al_skid_num
using		sqlca;

select	count(*)
into		:ll_rows_reject
from		reject_coil_packing_item
where		packing_list = :al_shipment
and		rej_coil_packaging_ticket = :al_skid_num
using		sqlca;

lds_print = Create DataStore
lds_print.DataObject = ""

If ll_rows_sheet > 0 Then
	lds_print.DataObject = "d_packaging_ticket_sheet_4skid"
ElseIf ll_rows_scrap > 0 Then
	lds_print.DataObject = "d_packaging_ticket_scrap_4skid"
ElseIf ll_rows_reject > 0 Then
	lds_print.DataObject = "d_packaging_ticket_rejcoil_4skid"
Else
	//
End If

If lds_print.DataObject <> "" Then
	lds_print.SetTransObject(sqlca)
	ll_rows = lds_print.Retrieve(al_shipment, al_skid_num)
	lds_print.Print()
End If

Return 0
//Alex Gerlants. Reprint_Packaging_Ticket_Button. 05/07/2019. End
end function

on u_default_packingticket.create
call super::create
end on

on u_default_packingticket.destroy
call super::destroy
end on

event constructor;call super::constructor;is_objectname = "d_report_packaging_ticket_general_abco"

istr_dw.width = 3547
istr_dw.length = 2150
istr_dw.v_bar = TRUE
istr_dw.h_bar = TRUE
istr_dw.front = TRUE

RETURN 1
end event

event ue_groupdwprint;call super::ue_groupdwprint;//Alex Gerlants. 06/12/2019. Ship_Print_Delay. Begin
Long			ll_rows, ll_row, ll_sheet_skid_num
Long			ll_delay_ms
Integer		li_rtn
DataStore	lds_skids_4packing_list

ll_delay_ms = f_get_ship_print_delay()

lds_skids_4packing_list = Create DataStore
lds_skids_4packing_list.DataObject = "d_dddw_skids_4packing_list_2"
lds_skids_4packing_list.SetTransObject(sqlca)

ll_rows = lds_skids_4packing_list.Retrieve(al_shipment)

If ll_rows > 0 Then
	//li_rtn = PrintSetup()
	
	//If li_rtn = -1 Then //Error in PrintSetup() or user clicked on "Cancel"
	//	Return 1
	//End If
	
	For ll_row = 1 To ll_rows
		ll_sheet_skid_num = lds_skids_4packing_list.Object.sheet_skid_num[ll_row]
		sleep_ms(ll_delay_ms)
		li_rtn = of_groupdwprint_4skid_print(al_shipment, ll_sheet_skid_num)
	Next
End If
//Alex Gerlants. 06/12/2019. Ship_Print_Delay. End

//idw_requestor.Print() //Alex Gerlants. 06/12/2019. Ship_Print_Delay. Current code. Comment out because I am printing in a loop above.

RETURN 1

end event

event ue_groupdwprint_4skid;call super::ue_groupdwprint_4skid;//Alex Gerlants. Reprint_Packaging_Ticket_Button. 05/07/2019. Begin
/*
Event:		ue_groupdwprint_4skid
Returns:		integer
Arguments:	value	long	al_shipment	
				value	long	al_sheet_skid_num
*/

Integer	li_rtn

li_rtn = of_groupdwprint_4skid(al_shipment, al_sheet_skid_num)

Return li_rtn
//Alex Gerlants. Reprint_Packaging_Ticket_Button. 05/07/2019. End
end event

