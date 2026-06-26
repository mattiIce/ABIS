$PBExportHeader$u_da_queue_tab.sru
forward
global type u_da_queue_tab from u_tab
end type
type tabpage_job from userobject within u_da_queue_tab
end type
type tabpage_job from userobject within u_da_queue_tab
end type
type tabpage_coil from userobject within u_da_queue_tab
end type
type tabpage_coil from userobject within u_da_queue_tab
end type
end forward

global type u_da_queue_tab from u_tab
integer width = 925
integer height = 653
string facename = "Arial"
tabposition tabposition = tabsonleft!
tabpage_job tabpage_job
tabpage_coil tabpage_coil
end type
global u_da_queue_tab u_da_queue_tab

event constructor;call super::constructor;//
end event

on u_da_queue_tab.create
this.tabpage_job=create tabpage_job
this.tabpage_coil=create tabpage_coil
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_job
this.Control[iCurrent+2]=this.tabpage_coil
end on

on u_da_queue_tab.destroy
call super::destroy
destroy(this.tabpage_job)
destroy(this.tabpage_coil)
end on

type tabpage_job from userobject within u_da_queue_tab
integer x = 99
integer y = 13
integer width = 812
integer height = 627
long backcolor = 79741120
string text = "Job Queue"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_coil from userobject within u_da_queue_tab
integer x = 99
integer y = 13
integer width = 812
integer height = 627
long backcolor = 79741120
string text = "Coil Queue"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

