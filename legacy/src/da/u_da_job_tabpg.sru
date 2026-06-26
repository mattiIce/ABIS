$PBExportHeader$u_da_job_tabpg.sru
forward
global type u_da_job_tabpg from u_tabpg
end type
type dw_job_sheet from u_dw within u_da_job_tabpg
end type
end forward

global type u_da_job_tabpg from u_tabpg
integer width = 3727
integer height = 1702
dw_job_sheet dw_job_sheet
end type
global u_da_job_tabpg u_da_job_tabpg

type variables
string is_title
w_da_sheet iw_sheet
end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
end prototypes

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
end subroutine

on u_da_job_tabpg.create
int iCurrent
call super::create
this.dw_job_sheet=create dw_job_sheet
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_job_sheet
end on

on u_da_job_tabpg.destroy
call super::destroy
destroy(this.dw_job_sheet)
end on

event constructor;call super::constructor;dw_job_sheet.of_settransobject( sqlca)
dw_job_sheet.of_setupdateable( false)
end event

type dw_job_sheet from u_dw within u_da_job_tabpg
integer x = 4
integer width = 3712
integer height = 1693
integer taborder = 10
string dataobject = "d_report_prod_order"
end type

