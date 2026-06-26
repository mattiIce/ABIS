$PBExportHeader$w_daily_prod_report_msr.srw
$PBExportComments$Monthly summary report
forward
global type w_daily_prod_report_msr from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_msr
end type
type cb_setzoom from u_cb within w_daily_prod_report_msr
end type
type cb_print from u_cb within w_daily_prod_report_msr
end type
type cbx_setpreview from u_cbx within w_daily_prod_report_msr
end type
type cb_close from u_cb within w_daily_prod_report_msr
end type
end forward

global type w_daily_prod_report_msr from w_sheet
int Y=218
int Width=3507
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
global w_daily_prod_report_msr w_daily_prod_report_msr

type variables
Date id_d
end variables

on w_daily_prod_report_msr.create
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

on w_daily_prod_report_msr.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
end on

event open;call super::open;s_new_daily_prod_info lstr_q
Long ll_alph
String ls_month, ls_year, ls_title

lstr_q= Message.PowerObjectParm
dw_Report.SetTransObject(sqlca)

SELECT avg_lb_per_hr INTO :ll_alph
FROM line
WHERE line_num = :lstr_q.line_id
USING SQLCA;

CHOOSE CASE Month(lstr_q.Prod_date )
	CASE 1
		ls_month = 'Jan'
	CASE 2
		ls_month = 'Feb'
	CASE 3
		ls_month = 'Mar'
	CASE 4
		ls_month = 'Apr'
	CASE 5
		ls_month = 'May'
	CASE 6
		ls_month = 'Jun'
	CASE 7
		ls_month = 'Jul'
	CASE 8
		ls_month = 'Aug'
	CASE 9
		ls_month = 'Sep'
	CASE 10
		ls_month = 'Oct'
	CASE 11
		ls_month = 'Nov'
	CASE 12
		ls_month = 'Dec'
END CHOOSE
ls_year = String(Year(lstr_q.Prod_date))
ls_title = lstr_q.line_desc + '  -  ' + ls_month + '/' + ls_year
dw_report.Retrieve(lstr_q.line_id, ll_alph, ls_title, ls_month, ls_year)



end event

type dw_report from u_dw within w_daily_prod_report_msr
int X=4
int Y=3
int Width=3493
int Height=1571
int TabOrder=40
string DataObject="d_daily_prod_report_msr"
boolean HScrollBar=true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

event rbuttondown;RETURN 1
end event
event resize;RETURN 1
end event
type cb_setzoom from u_cb within w_daily_prod_report_msr
int X=753
int Y=1587
int TabOrder=10
string Text="&SetZoom"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_msr
int X=1375
int Y=1587
int TabOrder=20
boolean BringToTop=true
string Text="&Print"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_daily_prod_report_msr
int X=2619
int Y=1600
int Width=366
string Text="SetPreview"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_daily_prod_report_msr
int X=1997
int Y=1587
int TabOrder=30
string Tag="Close without printing"
string Text="&Close"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

