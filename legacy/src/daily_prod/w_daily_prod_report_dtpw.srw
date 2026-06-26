$PBExportHeader$w_daily_prod_report_dtpw.srw
$PBExportComments$<PopUp> daily_production daily total peocess wt  report preview window inherited form pfemain/w_sheet
forward
global type w_daily_prod_report_dtpw from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_dtpw
end type
type cb_setzoom from u_cb within w_daily_prod_report_dtpw
end type
type cb_print from u_cb within w_daily_prod_report_dtpw
end type
type cbx_setpreview from u_cbx within w_daily_prod_report_dtpw
end type
type cb_close from u_cb within w_daily_prod_report_dtpw
end type
end forward

global type w_daily_prod_report_dtpw from w_sheet
int Y=218
int Width=3346
int Height=1789
WindowType WindowType=response!
boolean TitleBar=true
string Title="Print"
long BackColor=80269524
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_report dw_report
cb_setzoom cb_setzoom
cb_print cb_print
cbx_setpreview cbx_setpreview
cb_close cb_close
end type
global w_daily_prod_report_dtpw w_daily_prod_report_dtpw

type variables
Date id_d
end variables

on w_daily_prod_report_dtpw.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.cb_close
end on

on w_daily_prod_report_dtpw.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
end on

event open;call super::open;s_new_daily_prod_info lstr_q

lstr_q= Message.PowerObjectParm
dw_Report.SetTransObject(sqlca)
dw_report.Retrieve(lstr_q.start_date, lstr_q.end_date, lstr_q.line_id)
dw_report.object.gr_1.title = "Daily production total. line: " + lstr_q.line_desc + " between " + String(lstr_q.start_date) + " and " + String(lstr_q.end_date)



end event

type dw_report from u_dw within w_daily_prod_report_dtpw
int X=4
int Y=3
int Width=3317
int Height=1571
int TabOrder=40
string DataObject="d_daily_prod_total_wt_per_line"
boolean HScrollBar=true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event rbuttondown;RETURN 1
end event
event rbuttonup;RETURN 1
end event
type cb_setzoom from u_cb within w_daily_prod_report_dtpw
int X=655
int Y=1584
int TabOrder=10
string Text="&SetZoom"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_dtpw
int X=1276
int Y=1584
int TabOrder=20
boolean BringToTop=true
string Text="&Print"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_daily_prod_report_dtpw
int X=2520
int Y=1597
int Width=366
string Text="SetPreview"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_daily_prod_report_dtpw
int X=1898
int Y=1584
int TabOrder=30
string Tag="Close without printing"
string Text="&Close"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

