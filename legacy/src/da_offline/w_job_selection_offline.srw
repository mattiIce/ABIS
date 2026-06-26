$PBExportHeader$w_job_selection_offline.srw
$PBExportComments$<Response> show all job waiting to be processed inherited from pfemain/w_sheet
forward
global type w_job_selection_offline from w_sheet
end type
type dw_job from u_dw within w_job_selection_offline
end type
type cb_select from u_cb within w_job_selection_offline
end type
type cb_close from u_cb within w_job_selection_offline
end type
end forward

global type w_job_selection_offline from w_sheet
integer x = 318
integer y = 144
integer width = 2019
integer height = 1690
string title = "Select a job to process"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_job dw_job
cb_select cb_select
cb_close cb_close
end type
global w_job_selection_offline w_job_selection_offline

type variables
Int ii_sheettype
end variables

on w_job_selection_offline.create
int iCurrent
call super::create
this.dw_job=create dw_job
this.cb_select=create cb_select
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_job
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_close
end on

on w_job_selection_offline.destroy
call super::destroy
destroy(this.dw_job)
destroy(this.cb_select)
destroy(this.cb_close)
end on

event open;call super::open;Long ll_line

ll_line = message.DoubleParm

dw_job.Retrieve(ll_line)
dw_job.SetFocus()


end event

type dw_job from u_dw within w_job_selection_offline
integer x = 4
integer width = 1979
integer height = 1488
integer taborder = 30
string dataobject = "d_job_schedule_offline"
boolean hscrollbar = true
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

type cb_select from u_cb within w_job_selection_offline
integer x = 560
integer y = 1494
integer width = 351
integer height = 102
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Select"
end type

event clicked;Long ll_job, ll_row

SetPointer(HourGlass!)

ll_row = dw_job.GetRow()
IF ll_row < 1 THEN 
	MessageBox("Error", "Select a job first!", StopSign! )
	RETURN
END IF

ll_job = dw_job.GetItemNumber(ll_row, "line_priority_ab_job_num" )


CloseWithReturn(Parent,ll_job)
end event

type cb_close from u_cb within w_job_selection_offline
string tag = "Close without selection"
integer x = 1083
integer y = 1494
integer width = 351
integer height = 102
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancel"
end type

event clicked;call super::clicked;CloseWithReturn(Parent,0)
end event

