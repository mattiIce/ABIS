$PBExportHeader$w_coil_list_by_bol.srw
forward
global type w_coil_list_by_bol from w_sheet
end type
type cb_archive from commandbutton within w_coil_list_by_bol
end type
type dw_coil_list_by_bol from u_dw within w_coil_list_by_bol
end type
type dw_editor from u_dw within w_coil_list_by_bol
end type
type gb_editor from u_gb within w_coil_list_by_bol
end type
type cb_markdamage from u_cb within w_coil_list_by_bol
end type
type cb_send from u_cb within w_coil_list_by_bol
end type
type cb_cancle from u_cb within w_coil_list_by_bol
end type
type cb_save from u_cb within w_coil_list_by_bol
end type
type cb_close from u_cb within w_coil_list_by_bol
end type
type em_received_time from editmask within w_coil_list_by_bol
end type
type st_1 from statictext within w_coil_list_by_bol
end type
type cb_import from commandbutton within w_coil_list_by_bol
end type
end forward

global type w_coil_list_by_bol from w_sheet
integer x = 11
integer y = 458
integer width = 3683
integer height = 1686
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 82042848
event type integer ue_markdamage ( )
event type integer ue_sendedi861 ( )
event type integer ue_import ( )
event type integer ue_archive ( )
cb_archive cb_archive
dw_coil_list_by_bol dw_coil_list_by_bol
dw_editor dw_editor
gb_editor gb_editor
cb_markdamage cb_markdamage
cb_send cb_send
cb_cancle cb_cancle
cb_save cb_save
cb_close cb_close
em_received_time em_received_time
st_1 st_1
cb_import cb_import
end type
global w_coil_list_by_bol w_coil_list_by_bol

type variables
String is_select
String is_where
s_coil_info ids_coil
s_dw_db  istr_dwdb[]
s_search_condition istr_search[]
Boolean ib_delete
Boolean ib_new
Boolean ib_modify
Long il_cur_coil
Boolean ib_readonly
Boolean ib_allcust
String is_bol
Long il_edi_file_id
Long il_customer_id
end variables

event ue_markdamage;SetPointer(HourGlass!)

Long ll_row
//String ls_coil
Int li_item_num
Int li_status

ll_row = dw_coil_list_by_bol.GetRow()
IF ll_row < 1 THEN RETURN -1
li_status = dw_coil_list_by_bol.GetItemNumber(ll_row, "inbound_coil_status_status", Primary!, FALSE)
IF li_status = 1 THEN
	MessageBox("Error","Failed to mark damage, because this coil has been imported!", StopSign!)
	RETURN 0
END IF

//ls_coil = dw_coil_list_by_bol.GetItemString(ll_row, "coil_number", Primary!, FALSE)
li_item_num = dw_coil_list_by_bol.GetItemNumber(ll_row, "item_num", Primary!, FALSE)
//IF Len(ls_coil) > 0 THEN
IF li_item_num > 0 THEN
	dw_editor.Retrieve(is_bol, il_edi_file_id, li_item_num)
END IF

cb_save.Enabled = TRUE

RETURN 1
end event

event type integer ue_sendedi861();String ls_received_time
integer i, rc, li_return
integer li_cur_coil_status

rc = dw_coil_list_by_bol.rowcount()

FOR i = 1 TO rc
	li_cur_coil_status = dw_coil_list_by_bol.GetItemNumber(i, "inbound_coil_status_status", Primary!, FALSE)
	IF (li_cur_coil_status = 0) or (li_cur_coil_status = 3) THEN
		messagebox("Coil Status Error", "Not all coils have been imported or marked damage yet", StopSign!, OK!)
		return 0
	END IF
NEXT

ls_received_time = String(em_received_time.text)

transaction dboconnect
dboconnect = create transaction
dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
dboconnect.LogID = gs_LogID
dboconnect.LogPass = gs_LogPass
connect using dboconnect;
if dboconnect.SQLCode<0 then 
	MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
   return -1
end if

DECLARE p_edi procedure for F_CREATE_EDI_861_BY_BOL(:is_bol, :il_edi_file_id, :ls_received_time)  using dboconnect;
execute p_edi;
if dboconnect.SQLCode <> 0 then 
	MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
	return -1
end if
fetch p_edi INTO :li_return; 
close p_edi;

CHOOSE CASE li_return
   CASE 1
    messagebox("EDI_861 Generation","EDI 861 generated successfully")
	CASE -1
		MessageBox("Info","System error!" )
	CASE -2
		MessageBox("Error","EDI failed, Errors with UTL_FILE!", StopSign!)
END CHOOSE

disconnect using dboconnect;
destroy dboconnect;


return 1
end event

event ue_import;s_coil_info_import lds_coil_info_import
Long ll_row, ll_rc
Int li_return
//String ls_coil
Int li_item_num
Int li_status

SetPointer(HourGlass!)

ll_row = dw_coil_list_by_bol.GetRow()
IF ll_row < 1 THEN RETURN -1
li_status = dw_coil_list_by_bol.GetItemNumber(ll_row, "inbound_coil_status_status", Primary!, FALSE)
IF li_status = 1 THEN
	MessageBox("Error","Failed to import, because this coil has been imported!", StopSign!)
	RETURN 0
END IF

//ls_coil = dw_coil_list_by_bol.GetItemString(ll_row, "coil_number", Primary!, FALSE)
li_item_num = dw_coil_list_by_bol.GetItemnumber(ll_row, "item_num", Primary!, FALSE)
//IF Len(ls_coil) > 0 THEN
IF li_item_num > 0 THEN
	dw_editor.Retrieve(is_bol, il_edi_file_id, li_item_num)
END IF

ll_row = dw_editor.GetRow()
IF ll_row < 1 THEN RETURN -1

lds_coil_info_import.customer_id = il_customer_id
lds_coil_info_import.coil_number = dw_editor.GetItemString(ll_row, "coil_number", Primary!, FALSE)
lds_coil_info_import.temper = dw_editor.GetItemString(ll_row, "temper", Primary!, FALSE)
lds_coil_info_import.net_weight = dw_editor.GetItemNumber(ll_row, "net_weight", Primary!, FALSE)
lds_coil_info_import.gross_weight = dw_editor.GetItemNumber(ll_row, "gross_weight", Primary!, FALSE)
lds_coil_info_import.lineal_feed = dw_editor.GetItemNumber(ll_row, "lineal_feed", Primary!, FALSE)
lds_coil_info_import.coil_width = dw_editor.GetItemNumber(ll_row, "coil_width", Primary!, FALSE)
lds_coil_info_import.coil_gauge = dw_editor.GetItemNumber(ll_row, "coil_gauge", Primary!, FALSE)
lds_coil_info_import.density = dw_editor.GetItemNumber(ll_row, "density", Primary!, FALSE)
lds_coil_info_import.lot = dw_editor.GetItemString(ll_row, "lot", Primary!, FALSE)
lds_coil_info_import.pack_id = dw_editor.GetItemString(ll_row, "pack_id", Primary!, FALSE)
lds_coil_info_import.alloy = dw_editor.GetItemString(ll_row, "alloy", Primary!, FALSE)

OpenWithParm(w_coil_detail_new_import, lds_coil_info_import)

ll_rc= Message.DoubleParm

IF ll_rc > 0 THEN
	dw_editor.ResetUpdate()
	dw_editor.SetItem(ll_row, "inbound_coil_status_status", 1)
	dw_editor.AcceptText()
	li_return = dw_editor.Update()
	IF li_return = 1 THEN
		COMMIT USING SQLCA;
	ELSE
		ROLLBACK USING SQLCA;
		RETURN -2
	END IF
	
	dw_editor.Reset()
	dw_coil_list_by_bol.Retrieve(is_bol,il_edi_file_id)
	dw_coil_list_by_bol.SetFocus()
END IF

return 1


end event

event type integer ue_archive();String ls_received_time, ls_message
Int li_return, li_rc

li_rc = MessageBox("Please Confirm", "Are you sure to archive BOL# " + String(is_bol) + " ?", Question!, YesNo!)
if li_rc = 1 then
	SetPointer(HourGlass!)
	
	UPDATE "INBOUND_COIL_STATUS"  
	SET "STATUS" = 1
	WHERE "INBOUND_COIL_STATUS"."BOL" = :is_bol   
	USING SQLCA;
	COMMIT USING SQLCA;
	IF SQLCA.SQLCODE <> 0 THEN
		MessageBox("Commit Error", SQLCA.SQLErrText)
		RETURN -1
	END IF
	
	//Log user's archiving trasaction
	ls_message = "BOL# " + String(is_bol) + " archived by " + gnv_app.of_GetUserId() + " @" + String(Today(), "mm-dd-yyyy HH:MM.")
	f_add_system_log(ls_message)	
	  
	ls_received_time = String(em_received_time.text)
	
	transaction dboconnect
	dboconnect = create transaction
	dboconnect.DBMS = ProfileString(gs_ini_file,"Database","DBMS","")
	dboconnect.Servername = ProfileString(gs_ini_file,"Database","ServerName","")
	dboconnect.LogID = gs_LogID
	dboconnect.LogPass = gs_LogPass
	connect using dboconnect;
	if dboconnect.SQLCode<0 then 
		MessageBox ("Connection Failed!!!!",dboconnect.sqlerrtext,exclamation!)
		return -1
	end if
	
	DECLARE p_edi procedure for F_CREATE_EDI_861_BY_BOL(:is_bol, :il_edi_file_id, :ls_received_time)  using dboconnect;
	execute p_edi;
	if dboconnect.SQLCode <> 0 then 
		MessageBox ("Stored Procedure Failed!!!",dboconnect.sqlerrtext,exclamation!)
		return -1
	end if
	fetch p_edi INTO :li_return; 
	close p_edi;
	
	CHOOSE CASE li_return
		CASE 1
		 messagebox("EDI_861 Generation","This BOL has been archived and EDI 861 has been sent successfully")
		CASE -1
			MessageBox("Info","System error!" )
		CASE -2
			MessageBox("Error","EDI failed, Errors with UTL_FILE!", StopSign!)
	END CHOOSE
	
	disconnect using dboconnect;
	destroy dboconnect;
	  
	RETURN 1

end if

RETURN 0



end event

on w_coil_list_by_bol.create
int iCurrent
call super::create
this.cb_archive=create cb_archive
this.dw_coil_list_by_bol=create dw_coil_list_by_bol
this.dw_editor=create dw_editor
this.gb_editor=create gb_editor
this.cb_markdamage=create cb_markdamage
this.cb_send=create cb_send
this.cb_cancle=create cb_cancle
this.cb_save=create cb_save
this.cb_close=create cb_close
this.em_received_time=create em_received_time
this.st_1=create st_1
this.cb_import=create cb_import
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_archive
this.Control[iCurrent+2]=this.dw_coil_list_by_bol
this.Control[iCurrent+3]=this.dw_editor
this.Control[iCurrent+4]=this.gb_editor
this.Control[iCurrent+5]=this.cb_markdamage
this.Control[iCurrent+6]=this.cb_send
this.Control[iCurrent+7]=this.cb_cancle
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.em_received_time
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.cb_import
end on

on w_coil_list_by_bol.destroy
call super::destroy
destroy(this.cb_archive)
destroy(this.dw_coil_list_by_bol)
destroy(this.dw_editor)
destroy(this.gb_editor)
destroy(this.cb_markdamage)
destroy(this.cb_send)
destroy(this.cb_cancle)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.em_received_time)
destroy(this.st_1)
destroy(this.cb_import)
end on

event pfc_save;call super::pfc_save;SetPointer(HourGlass!)
Long ll_rj, ll_rc, ll_i, ll_temp, ll_newrow
Long ll_coil
Int li_rc, li_row
Int li_status, li_damaged_fault, li_damaged_code

dw_editor.AcceptText()
IF dw_editor.RowCount() < 1 THEN RETURN 0

li_row = dw_editor.GetRow()
IF li_row < 1 THEN RETURN 0

li_damaged_fault = dw_editor.GetItemNumber(li_row, "inbound_coil_status_damaged_fault", Primary!, False)
li_damaged_code = dw_editor.GetItemNumber(li_row, "inbound_coil_status_damaged_code", Primary!, False)

IF ((li_damaged_fault=0)AND(li_damaged_code<>0)) OR ((li_damaged_code=0)AND(li_damaged_fault<>0)) THEN
	MessageBox("Mark Damage Error", "Damage Fault and Damage Code are mismatched.", StopSign!, OK!)
	Return 0
ELSEIF (li_damaged_fault=0)AND(li_damaged_code=0) THEN
	MessageBox("No Damage Marked", "No Damage is selected", StopSign!, OK!)
	Return 0
ELSE
	dw_editor.ResetUpdate()
	dw_editor.SetItem(li_row, "inbound_coil_status_status", 2)
	dw_editor.AcceptText()
	li_rc = dw_editor.Update()
	IF li_rc = 1 THEN
		COMMIT USING SQLCA;
	ELSE
		ROLLBACK USING SQLCA;
		RETURN -2
	END IF
END IF

dw_editor.Reset()

cb_markdamage.enabled = TRUE
cb_save.Enabled = FALSE

dw_coil_list_by_bol.retrieve(is_bol, il_edi_file_id)
RETURN 1
end event

event open;call super::open;s_edi_file_id_and_bol lds_edi_file_id_and_bol

lds_edi_file_id_and_bol = Message.PowerObjectParm
date ld_received_time

is_bol = lds_edi_file_id_and_bol.bol 
il_edi_file_id = lds_edi_file_id_and_bol.edi_file_id
il_customer_id = lds_edi_file_id_and_bol.customer_id

String ls_cust
SELECT "CUSTOMER"."CUSTOMER_SHORT_NAME"  
INTO :ls_cust  
FROM "CUSTOMER"  
WHERE "CUSTOMER"."CUSTOMER_ID" = :il_customer_id 
using sqlca;
ls_cust = trim(ls_cust)
this.title = "Coils available to import for " + ls_cust+ " BOL#:" + is_bol

dw_editor.SetTransObject(sqlca)
dw_coil_list_by_bol.SetTransObject(sqlca)
dw_coil_list_by_bol.Retrieve(is_bol,il_edi_file_id)

dw_coil_list_by_bol.SetFocus()

ld_received_time = today()
em_received_time.text = string(ld_received_time, "mm/dd/yyyy, hh:mm")

cb_markdamage.Enabled = TRUE
cb_import.Enabled = TRUE
cb_save.Enabled = FALSE
end event

type cb_archive from commandbutton within w_coil_list_by_bol
integer x = 2055
integer y = 1398
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Archive"
end type

event clicked;parent.event ue_archive()
end event

type dw_coil_list_by_bol from u_dw within w_coil_list_by_bol
integer x = 84
integer y = 64
integer width = 3489
integer height = 643
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_coil_list_by_bol"
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(is_bol,il_edi_file_id)
end event

event clicked;call super::clicked;//Override pfc_clicked

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

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

event constructor;of_SetBase(TRUE)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 0 ) 

end event

event doubleclicked;//parent.event ue_import()
end event

type dw_editor from u_dw within w_coil_list_by_bol
integer x = 88
integer y = 1062
integer width = 3061
integer height = 218
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_coil_list_editor_by_bol"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event constructor;of_SetBase(TRUE)
of_SettransObject(SQLCA)
of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
//inv_sort.of_SetColumnHeader(TRUE)
//inv_RowSelect.of_SetStyle ( 0 ) 
//of_SetFilter(TRUE)
end event

event clicked;call super::clicked;//Override pfc_clicked

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

event rbuttondown;call super::rbuttondown;//disable
Return 0
end event

event rbuttonup;call super::rbuttonup;//disable
Return 0
end event

event rowfocuschanged;call super::rowfocuschanged;this.Event pfc_rowchanged()
end event

event pfc_rowchanged;call super::pfc_rowchanged;long li_Row

this.AcceptText()
li_Row = this.GetRow()
this.SelectRow(0, False)
this.SelectRow(li_Row, True)

//Nochange
Return 

end event

type gb_editor from u_gb within w_coil_list_by_bol
integer x = 69
integer y = 992
integer width = 3489
integer height = 307
integer taborder = 80
string text = "Editor"
end type

type cb_markdamage from u_cb within w_coil_list_by_bol
integer x = 629
integer y = 1398
integer width = 351
integer height = 93
integer taborder = 60
boolean bringtotop = true
string text = "&Mark Damage"
end type

event clicked;parent.event ue_markdamage()
end event

type cb_send from u_cb within w_coil_list_by_bol
integer x = 3174
integer y = 810
integer width = 380
integer height = 93
integer taborder = 50
boolean bringtotop = true
string text = "&Send EDI 861"
end type

event clicked;parent.event ue_sendedi861()
end event

type cb_cancle from u_cb within w_coil_list_by_bol
integer x = 3167
integer y = 1174
integer width = 351
integer height = 93
integer taborder = 40
boolean bringtotop = true
string text = "C&ancel"
end type

event clicked;cb_save.Enabled = FALSE

//cb_modify.Enabled = TRUE

dw_editor.Reset()

end event

type cb_save from u_cb within w_coil_list_by_bol
integer x = 3167
integer y = 1053
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
string text = "&Save"
end type

event clicked;parent.event pfc_save()
end event

type cb_close from u_cb within w_coil_list_by_bol
integer x = 2768
integer y = 1398
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
string text = "&Close"
end type

event clicked;close(parent)
end event

type em_received_time from editmask within w_coil_list_by_bol
integer x = 2571
integer y = 810
integer width = 464
integer height = 77
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy hh:mm"
end type

type st_1 from statictext within w_coil_list_by_bol
integer x = 1971
integer y = 822
integer width = 578
integer height = 93
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 82042848
boolean enabled = false
string text = "Shipment Received Time:"
boolean focusrectangle = false
end type

type cb_import from commandbutton within w_coil_list_by_bol
integer x = 1342
integer y = 1398
integer width = 351
integer height = 93
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Import"
end type

event clicked;parent.event ue_import()
end event

