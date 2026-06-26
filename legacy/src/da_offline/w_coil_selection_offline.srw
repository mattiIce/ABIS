$PBExportHeader$w_coil_selection_offline.srw
$PBExportComments$<Response> show all coils waiting to be processed inherited from pfemain/w_sheet
forward
global type w_coil_selection_offline from w_sheet
end type
type dw_coil from u_dw within w_coil_selection_offline
end type
type cb_select from u_cb within w_coil_selection_offline
end type
type cb_close from u_cb within w_coil_selection_offline
end type
end forward

global type w_coil_selection_offline from w_sheet
integer x = 318
integer y = 144
integer width = 1115
integer height = 893
string title = "Select a coil to process"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_coil dw_coil
cb_select cb_select
cb_close cb_close
end type
global w_coil_selection_offline w_coil_selection_offline

type variables
Int ii_sheettype
end variables

on w_coil_selection_offline.create
int iCurrent
call super::create
this.dw_coil=create dw_coil
this.cb_select=create cb_select
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_coil
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_close
end on

on w_coil_selection_offline.destroy
call super::destroy
destroy(this.dw_coil)
destroy(this.cb_select)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_job

ll_job = message.DoubleParm

dw_coil.Retrieve(ll_job)
dw_coil.SetFocus()


end event

type dw_coil from u_dw within w_coil_selection_offline
integer x = 4
integer width = 1093
integer height = 685
integer taborder = 30
string dataobject = "d_offline_coil_waiting_to_be_processed"
boolean livescroll = false
end type

event constructor;call super::constructor;of_SetRowSelect(TRUE)
of_SetRowManager(TRUE)
of_SetSort(TRUE)
inv_sort.of_SetColumnHeader(TRUE)
inv_RowSelect.of_SetStyle ( 3 ) 
SetTransObject(SQLCA)


end event

event pfc_retrievedddw;call super::pfc_retrievedddw;DataWindowChild dddw_cni

IF this.GetChild(as_column, dddw_cni) = -1 THEN
	Return -1
ELSE
	dddw_cni.SetTransObject(SQLCA)
	
	Return dddw_cni.Retrieve() 
END IF
end event

event pfc_populatedddw;call super::pfc_populatedddw;IF adwc_obj.SetTransObject(SQLCA) = -1 THEN  
	Return -1  
ELSE   
	Return adwc_obj.Retrieve()  
END IF
end event

type cb_select from u_cb within w_coil_selection_offline
integer x = 106
integer y = 698
integer width = 351
integer height = 102
integer taborder = 10
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;Long ll_coil, ll_row

SetPointer(HourGlass!)

ll_row = dw_coil.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select a coil first!", StopSign! )
	RETURN
END IF

ll_coil = dw_coil.GetItemNumber(ll_row, "process_coil_ab_job_num" )


CloseWithReturn(Parent,ll_coil)
end event

type cb_close from u_cb within w_coil_selection_offline
string tag = "Close without selection"
integer x = 614
integer y = 698
integer width = 351
integer height = 102
integer taborder = 20
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;CloseWithReturn(Parent,0)
end event

