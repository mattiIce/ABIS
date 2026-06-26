$PBExportHeader$w_report_eval.srw
$PBExportComments$<PopUp> standard report preview window inherited form pfemain/w_sheet
forward
global type w_report_eval from w_sheet
end type
type dw_report from u_dw within w_report_eval
end type
type cb_setzoom from u_cb within w_report_eval
end type
type cb_print from u_cb within w_report_eval
end type
type cbx_setpreview from u_cbx within w_report_eval
end type
type p_1 from u_p within w_report_eval
end type
type cb_close from u_cb within w_report_eval
end type
end forward

global type w_report_eval from w_sheet
integer x = 614
integer y = 528
integer width = 3101
integer height = 1581
string title = "Print"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
p_1 p_1
cb_close cb_close
end type
global w_report_eval w_report_eval

type variables
u_tabpg_end_coil iu_tabpg_end_coil
long il_shift, il_coil, il_job
end variables

on w_report_eval.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.p_1=create p_1
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.cb_close
end on

on w_report_eval.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.p_1)
destroy(this.cb_close)
end on

event open;call super::open;dw_report.SetFocus()
end event

type dw_report from u_dw within w_report_eval
integer x = 7
integer y = 13
integer width = 3065
integer height = 1350
integer taborder = 40
string dataobject = "d_coil_evaluation"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//This.of_SetTransObject(SQLCA)
//This.Event pfc_Retrieve()
iu_tabpg_end_coil = message.powerobjectparm
//ids_eval = message.powerobjectparm
//ids_eval.sharedata( this)

This.of_SetTransObject(SQLCA)
This.of_SetPrintPreview(TRUE)

		long ll_reband_wt, ll_reject_wt
		double ld_yield
		il_job = iu_tabpg_end_coil.iu_coil.get_current_job( )
		il_coil = iu_tabpg_end_coil.iu_coil.get_coil_abc_id( )
		il_shift = iu_tabpg_end_coil.iu_coil.of_get_shift_id( )
		
		ll_reband_wt = iu_tabpg_end_coil.of_get_reband_wt( )
		ll_reject_wt = iu_tabpg_end_coil.of_get_reject_wt( )
		ld_yield = iu_tabpg_end_coil.of_get_coil_yield( )
		
//		lds_eval.retrieve(ll_shift, ll_coil, ll_job )
		this.of_retrieve( )
		//Set reject reband info
		this.object.t_reject_wt.text = string( ll_reject_wt )
		this.object.t_reband_wt.text = string( ll_reband_wt )
		this.object.t_coil_yield.text = string( ld_yield ) + "%"
		this.object.t_skid_total.text = iu_tabpg_end_coil.st_skid_wt.text
		this.object.t_scrap_total.text = iu_tabpg_end_coil.st_scrap_wt.text

//This.Event pfc_Retrieve()
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.Retrieve(il_shift, il_coil, il_job)
end event

type cb_setzoom from u_cb within w_report_eval
integer x = 914
integer y = 1395
integer width = 351
integer height = 93
integer taborder = 10
integer weight = 700
string facename = "Arial"
string text = "&SetZoom"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_report_eval
integer x = 1518
integer y = 1395
integer width = 351
integer height = 93
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
string text = "&Print"
end type

event clicked;call super::clicked;dw_report.event pfc_printimmediate( )
end event

type cbx_setpreview from u_cbx within w_report_eval
integer x = 428
integer y = 1411
integer width = 366
integer weight = 700
string facename = "Arial"
long backcolor = 79741120
string text = "SetPreview"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type p_1 from u_p within w_report_eval
integer x = 2721
integer y = 1421
integer width = 69
integer height = 54
string picturename = "print.jpg"
end type

type cb_close from u_cb within w_report_eval
string tag = "Close without printing"
integer x = 2121
integer y = 1395
integer width = 351
integer height = 93
integer taborder = 30
integer weight = 700
string facename = "Arial"
string text = "&Close"
end type

event clicked;call super::clicked;Close(Parent)
end event

