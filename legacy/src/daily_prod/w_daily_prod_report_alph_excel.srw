$PBExportHeader$w_daily_prod_report_alph_excel.srw
$PBExportComments$auto export to excel file
forward
global type w_daily_prod_report_alph_excel from w_sheet
end type
type dw_report from u_dw within w_daily_prod_report_alph_excel
end type
type cb_setzoom from u_cb within w_daily_prod_report_alph_excel
end type
type cb_print from u_cb within w_daily_prod_report_alph_excel
end type
type cbx_setpreview from u_cbx within w_daily_prod_report_alph_excel
end type
type cb_close from u_cb within w_daily_prod_report_alph_excel
end type
type cb_1 from u_cb within w_daily_prod_report_alph_excel
end type
end forward

global type w_daily_prod_report_alph_excel from w_sheet
int Y=218
int Width=3346
int Height=1776
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
cb_1 cb_1
end type
global w_daily_prod_report_alph_excel w_daily_prod_report_alph_excel

type variables

end variables

forward prototypes
public subroutine getcolumns (datawindow adw_dw, ref string as_columns[])
public function any getdata (datawindow adw_dw, long al_row, string as_column)
public function string inttocolumn (integer ai_col)
public subroutine exporttoexcel (datawindow adw_dw, long al_rows)
end prototypes

public subroutine getcolumns (datawindow adw_dw, ref string as_columns[]);// Get a list of all the columns in the DW
// Note this function could be replaced with
// a function that allows the developer to specify
// the column names to be exported.
Long ll_I, ll_Cols

ll_Cols = Long( adw_DW.Describe( 'datawindow.column.count' ) )
FOR ll_I = ll_cols TO 1 STEP -1
	as_columns[ ll_I ] = adw_DW.Describe( '#' + String( ll_I ) + '.Name' )
NEXT

end subroutine

public function any getdata (datawindow adw_dw, long al_row, string as_column);Long ll_Col
Any la_A

IF al_Row > adw_DW.RowCount() THEN RETURN ""
ll_Col = Long( adw_DW.Describe( as_Column + ".ID" ) )
IF ll_Col > 0 THEN &
   la_A = adw_DW.object.data.primary.current[ al_Row, ll_Col ]

RETURN la_A


end function

public function string inttocolumn (integer ai_col);// Convert a column number into a spreadsheet column reference

String ls_Col
Integer li_Min, li_Max

IF ai_col <= 0 THEN RETURN ""

// calc the major/minor letters
li_Max = ai_col / 26
li_Min = ai_col - ( li_Max * 26 )

// Convert min and max to letters
IF li_Max > 0 THEN
	ls_Col = Char( 64 + li_Max )
END IF

ls_Col += String( Char( 64 + li_Min ) )

RETURN ls_Col


end function

public subroutine exporttoexcel (datawindow adw_dw, long al_rows);// Export the data to Excel
OleObject lole_OLE, lole_Sheet
String ls_Columns[]
Long ll_Row, ll_Col, ll_Cols

lole_OLE = CREATE OleObject

SetPointer( HourGlass! )

lole_OLE.ConnectToNewObject( 'excel.application' )
lole_OLE.Workbooks.Add
lole_sheet = lole_OLE.Application.ActiveWorkbook.WorkSheets[1]

this.GetColumns( adw_DW, ls_Columns )
ll_Cols = UpperBound( ls_Columns )
FOR ll_col = 1 TO ll_cols
	lole_Sheet.Cells[ 1, ll_Col ] = ls_Columns[ ll_Col ]
NEXT

FOR ll_Row = 2 TO al_rows + 1
	FOR ll_Col = 1 TO ll_cols
		lole_Sheet.Cells[ ll_Row, ll_Col ] = &
		this.GetData( adw_DW, ll_Row - 1, ls_Columns[ ll_Col ] )
	NEXT
NEXT

lole_Sheet.Range( inttocolumn( 1 ) + "1:" + inttocolumn( ll_Cols ) + "1").Select
lole_OLE.Selection.Font.Bold = True

lole_Sheet.Range("A1:A1").Select
lole_Sheet.Columns( inttocolumn( 1 ) + ":" + inttocolumn( ll_cols ) ).EntireColumn.AutoFit

lole_OLE.Application.Visible = TRUE
lole_OLE.DisconnectObject()
DESTROY lole_OLE


end subroutine

on w_daily_prod_report_alph_excel.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.cb_setzoom=create cb_setzoom
this.cb_print=create cb_print
this.cbx_setpreview=create cbx_setpreview
this.cb_close=create cb_close
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.cb_setzoom
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.cbx_setpreview
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_1
end on

on w_daily_prod_report_alph_excel.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.cb_setzoom)
destroy(this.cb_print)
destroy(this.cbx_setpreview)
destroy(this.cb_close)
destroy(this.cb_1)
end on

event open;call super::open;s_new_daily_prod_info lstr_q
Int li_rcs, li_rcd, li_i, li_d, li_series1 
Long ll_shift, ll_alph, ll_wt, ll_totalwt_day, ll_totalwt, ll_row 
Real lr_hrs, lr_avg, lr_totalhrs_day, lr_totalhrs, lr_totalavg_day, lr_totalavg
DateTime ldt_s, ldt_e
Date ld_d
String ls_shift
DataStore lds_shift, lds_date


lstr_q = Message.PowerObjectParm

dw_Report.SetTransObject(sqlca)

SELECT avg_lb_per_hr INTO :ll_alph
FROM line
WHERE line_num = :lstr_q.line_id
USING SQLCA;

lds_date = CREATE datastore
lds_date.dataobject = "d_daily_prod_shift_info_alph_date"
lds_date.SetTransObject(SQLCA)
li_rcd = lds_date.Retrieve(lstr_q.line_id, lstr_q.start_date, lstr_q.end_date)

lds_shift = CREATE datastore
lds_shift.dataobject = "d_daily_prod_shift_info_alph"
lds_shift.SetTransObject(SQLCA)
li_rcs = lds_shift.Retrieve(lstr_q.line_id, lstr_q.start_date, lstr_q.end_date)

IF (li_rcd <= 0) OR (li_rcs <= 0) THEN
	MessageBox("Warning", "No valid data available.")
	DESTROY lds_shift
	DESTROY lds_date
	RETURN -1
END IF

ll_totalwt = 0
lr_totalavg = 0.0
lr_totalhrs = 0.0
FOR li_d = 1 TO li_rcd
	ld_d = Date(lds_date.GetItemDateTime(li_d, "data_date"))
	ll_totalwt_day = 0
	lr_totalavg_day = 0.0
	lr_totalhrs_day = 0.0
	FOR li_i = 1 TO li_rcs
		ldt_s = lds_shift.GetItemDateTime(li_i, "start_time")
		IF Date(ldt_s) = ld_d THEN
			ll_shift = lds_shift.GetItemNumber(li_i, "shift_num")
			ldt_e = lds_shift.GetItemDateTime(li_i, "shift_end_time")
			ls_shift = lds_shift.GetItemString(li_i, "shift_display")
			lr_hrs = f_hoursafter(ldt_s,ldt_e)
			IF lr_hrs <= 0 or IsNULL(lr_hrs) THEN
				MessageBox("Warning", "Invalid Date Info.")
				dw_report.Reset()
				DESTROY lds_shift
				DESTROY lds_date
				RETURN -2
			END IF
			lr_totalhrs = lr_totalhrs + lr_hrs
			lr_totalhrs_day = lr_totalhrs_day + lr_hrs
			SELECT SUM(process_wt) INTO :ll_wt
			FROM SHIFT_COIL
			WHERE Shift_num = :ll_shift
			USING SQLCA;
			ll_totalwt_day = ll_totalwt_day + ll_wt
			ll_totalwt = ll_totalwt + ll_wt
			
			lr_avg = ll_wt / lr_hrs	
			ll_row = dw_report.InsertRow(0)
			dw_report.SetItem(ll_row,"date",ld_d) 
			dw_report.SetItem(ll_row,"Shift",ls_shift) 
			dw_report.SetItem(ll_row,"average",lr_avg) 
			dw_report.SetItem(ll_row,"Process_wt",ll_wt) 
			dw_report.SetItem(ll_row,"hrs",lr_hrs) 
		END IF
	NEXT
	lr_totalavg_day = ll_totalwt_day/lr_totalhrs_day
	ll_row = dw_report.InsertRow(0)
	dw_report.SetItem(ll_row,"date",ld_d) 
	dw_report.SetItem(ll_row,"Shift","Daily") 
	dw_report.SetItem(ll_row,"average",lr_totalavg_day) 
	dw_report.SetItem(ll_row,"Process_wt",ll_totalwt_day) 
	dw_report.SetItem(ll_row,"hrs",lr_totalhrs_day) 
NEXT

lr_totalavg = ll_totalwt/lr_totalhrs
li_rcd = dw_report.RowCount()
IF li_rcd > 0 THEN 
	FOR li_d = 1 TO li_rcd
		dw_report.SetItem(li_d,"Avg_All",lr_totalavg)
	NEXT
END IF

li_rcd = dw_report.RowCount()
IF li_rcd > 0 THEN 
	FOR li_d = 1 TO li_rcd
		dw_report.SetItem(li_d,"Goal",ll_alph)
	NEXT
END IF

dw_report.ResetUpdate()

DESTROY lds_shift
DESTROY lds_date
RETURN 1


end event
type dw_report from u_dw within w_daily_prod_report_alph_excel
int X=7
int Y=10
int Width=1499
int Height=1546
int TabOrder=40
string DataObject="d_daily_prod_shift_average_new_excel"
boolean HScrollBar=true
end type

event constructor;This.of_SetPrintPreview(TRUE)
end event

type cb_setzoom from u_cb within w_daily_prod_report_alph_excel
int X=666
int Y=1568
int TabOrder=10
string Text="&SetZoom"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.inv_printPreview.of_SetZoom()
end event

type cb_print from u_cb within w_daily_prod_report_alph_excel
int X=1273
int Y=1568
int TabOrder=20
boolean BringToTop=true
string Text="&Print"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_print()
end event

type cbx_setpreview from u_cbx within w_daily_prod_report_alph_excel
int X=2487
int Y=1581
int Width=366
string Text="SetPreview"
long BackColor=79741120
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;dw_report.Event pfc_PrintPreview()
end event

type cb_close from u_cb within w_daily_prod_report_alph_excel
int X=1880
int Y=1568
int TabOrder=30
string Tag="Close without printing"
string Text="&Close"
int Weight=700
string FaceName="Arial"
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_1 from u_cb within w_daily_prod_report_alph_excel
int X=1679
int Y=1328
int TabOrder=11
boolean BringToTop=true
string Text="&excel"
int Weight=700
string FaceName="Arial"
end type

event clicked;Parent.ExportToExcel( dw_report, dw_report.RowCount() )

end event

