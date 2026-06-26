$PBExportHeader$w_recovery_coil_details.srw
$PBExportComments$detailed job/coil info recovery report
forward
global type w_recovery_coil_details from w_sheet
end type
type cb_add from u_cb within w_recovery_coil_details
end type
type dw_main from u_dw within w_recovery_coil_details
end type
type cb_close from u_cb within w_recovery_coil_details
end type
end forward

global type w_recovery_coil_details from w_sheet
integer width = 2417
integer height = 1766
string title = "Coil details by job"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_add cb_add
dw_main dw_main
cb_close cb_close
end type
global w_recovery_coil_details w_recovery_coil_details

type variables
Long il_job, il_coil

end variables

on w_recovery_coil_details.create
int iCurrent
call super::create
this.cb_add=create cb_add
this.dw_main=create dw_main
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.cb_close
end on

on w_recovery_coil_details.destroy
call super::destroy
destroy(this.cb_add)
destroy(this.dw_main)
destroy(this.cb_close)
end on

event open;call super::open;s_job_and_coil lds_data

lds_data = message.PowerObjectParm
il_job = lds_data.job_num
il_coil = lds_data.coil_num 

THis.Title = "Please confirm coil #" + String(il_coil) + " details for job # " + String(il_job)

dw_main.Event pfc_retrieve()


end event

type cb_add from u_cb within w_recovery_coil_details
integer x = 1287
integer y = 1597
integer width = 541
integer height = 93
integer taborder = 80
integer weight = 700
string text = "C&onfirm && Save"
end type

event clicked;call super::clicked;Long ll_row
Int li_sa, li_sh, li_cr, li_crb, li_pid

dw_main.AcceptText()
ll_row = dw_main.RowCount()

IF ll_row = 1 THEN
	li_sa = dw_main.GetItemNumber(ll_row, "recovery_job_coil_special_attention")
	li_sh = dw_main.GetItemNumber(ll_row, "recovery_job_coil_special_handling")
	li_cr = dw_main.GetItemNumber(ll_row, "recovery_job_coil_coil_rejected")
	li_crb = dw_main.GetItemNumber(ll_row, "recovery_job_coil_coil_rebanded")
	li_pid = dw_main.GetItemNumber(ll_row, "product_type_product_type")	
	
 	INSERT INTO recovery_job_coil (ab_job_num, coil_abc_num, special_attention, special_handling, coil_rejected, coil_rebanded, product_type_id)
	VALUES (:il_job,:il_coil, :li_sa, :li_sh, :li_cr, :li_crb, :li_pid)
	USING SQLCA;
	IF SQLCA.SQLCode >= 0 THEN
		COMMIT USING SQLCA;
	ELSE
		MessageBox("SQL ERROR",SQLCA.SQLErrText, StopSign!)
	   ROLLBACK using SQLCA;
	END IF
	dw_main.ResetUpdate()
END IF

ClosewithReturn(Parent, 1)

RETURN 1

end event

type dw_main from u_dw within w_recovery_coil_details
integer x = 11
integer y = 10
integer width = 2384
integer height = 1581
integer taborder = 70
string dataobject = "d_recovery_info_main_coil_details"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetRowManager(TRUE)
of_SetSort(TRUE)
of_SetBase(TRUE)
SetTransObject(SQLCA)

end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_job, il_coil)
end event

event itemchanged;call super::itemchanged;String ls_ColName
Long ll_row
Int li_status

ls_ColName = this.GetColumnName()
//IF ls_ColName = "selected" THEN
//	this.AcceptText()
//	ll_row = this.GetRow()
//	li_status = this.GetItemNumber(ll_row,"selected")
//	IF li_status = 0 THEN
//      IF cbx_all.Checked THEN cbx_all.Checked = FALSE
//	END IF
//END IF
this.ResetUpdate()


end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event rbuttondown;RETURN 1
end event

event rbuttonup;RETURN 0
end event

type cb_close from u_cb within w_recovery_coil_details
integer x = 1861
integer y = 1597
integer width = 541
integer height = 93
integer taborder = 70
integer weight = 700
string text = "&Cancel"
end type

event clicked;call super::clicked;dw_main.ResetUpdate()
CloseWithReturn(Parent, 0)

end event

