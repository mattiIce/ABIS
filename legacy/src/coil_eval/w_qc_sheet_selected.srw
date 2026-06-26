$PBExportHeader$w_qc_sheet_selected.srw
forward
global type w_qc_sheet_selected from w_sheet
end type
type cb_close from commandbutton within w_qc_sheet_selected
end type
type tab_dim_skid from u_tab within w_qc_sheet_selected
end type
type tab_dim_skid from u_tab within w_qc_sheet_selected
end type
type st_1 from statictext within w_qc_sheet_selected
end type
end forward

global type w_qc_sheet_selected from w_sheet
integer x = 0
integer y = 0
integer width = 2816
integer height = 1766
boolean maxbox = false
windowtype windowtype = popup!
boolean center = true
event ue_reset_db ( )
cb_close cb_close
tab_dim_skid tab_dim_skid
st_1 st_1
end type
global w_qc_sheet_selected w_qc_sheet_selected

type variables
long il_skid
u_tabpg_skid_dim_check iu_tabpg_skid_dim_check
u_tabpg_job_dim_check_gr iu_tabpg_job_dim_check_gr
end variables

forward prototypes
public function integer of_open_skid (long al_skid_num)
end prototypes

public function integer of_open_skid (long al_skid_num);//tab_dim_skid.closetab( iu_tabpg_skid_dim_check)
tab_dim_skid.opentabwithparm( iu_tabpg_skid_dim_check, al_skid_num,0)

return 1
end function

on w_qc_sheet_selected.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.tab_dim_skid=create tab_dim_skid
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.tab_dim_skid
this.Control[iCurrent+3]=this.st_1
end on

on w_qc_sheet_selected.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.tab_dim_skid)
destroy(this.st_1)
end on

event open;call super::open;il_skid = Message.DoubleParm
//il_skid = 439330
if not isnull(il_skid) then
	of_open_skid( il_skid )
	
	return 1
else
	MessageBox("Invalid SKid Number", "The skid number is invalid." , Stopsign!, OK!)
	return 0
end if




end event

type cb_close from commandbutton within w_qc_sheet_selected
integer x = 2344
integer y = 109
integer width = 399
integer height = 112
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;Close(parent)
end event

type tab_dim_skid from u_tab within w_qc_sheet_selected
integer x = 40
integer y = 250
integer width = 2706
integer height = 1373
integer taborder = 31
string facename = "Arial"
end type

type st_1 from statictext within w_qc_sheet_selected
integer x = 805
integer y = 29
integer width = 1218
integer height = 128
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Skid Dimensional Check"
boolean focusrectangle = false
end type

