$PBExportHeader$w_circlepro.srw
$PBExportComments$<Sheet>Circlepro quotation program inherited form pfemain/w_sheet
forward
global type w_circlepro from w_sheet
end type
type tab_quote from tab within w_circlepro
end type
type tabpage_coil from userobject within tab_quote
end type
type st_6 from u_st within tabpage_coil
end type
type em_a from u_em within tabpage_coil
end type
type st_7 from u_st within tabpage_coil
end type
type em_cd from u_em within tabpage_coil
end type
type st_8 from u_st within tabpage_coil
end type
type em_pz from u_em within tabpage_coil
end type
type st_9 from u_st within tabpage_coil
end type
type em_d from u_em within tabpage_coil
end type
type st_10 from u_st within tabpage_coil
end type
type em_ct from u_em within tabpage_coil
end type
type st_12 from u_st within tabpage_coil
end type
type em_cw from u_em within tabpage_coil
end type
type st_15 from u_st within tabpage_coil
end type
type em_ac from u_em within tabpage_coil
end type
type st_16 from u_st within tabpage_coil
end type
type em_no from u_em within tabpage_coil
end type
type st_17 from u_st within tabpage_coil
end type
type st_18 from u_st within tabpage_coil
end type
type em_jl from u_em within tabpage_coil
end type
type st_20 from u_st within tabpage_coil
end type
type em_wx from u_em within tabpage_coil
end type
type st_21 from u_st within tabpage_coil
end type
type em_st from u_em within tabpage_coil
end type
type cbx_a$ from u_cbx within tabpage_coil
end type
type cbx_i$ from u_cbx within tabpage_coil
end type
type cbx_t$ from u_cbx within tabpage_coil
end type
type st_29 from u_st within tabpage_coil
end type
type em_ni from u_em within tabpage_coil
end type
type cbx_cardboard from u_cbx within tabpage_coil
end type
type cbx_edgeprotector from u_cbx within tabpage_coil
end type
type cbx_wrapping from u_cbx within tabpage_coil
end type
type cbx_reused from u_cbx within tabpage_coil
end type
type tabpage_coil from userobject within tab_quote
st_6 st_6
em_a em_a
st_7 st_7
em_cd em_cd
st_8 st_8
em_pz em_pz
st_9 st_9
em_d em_d
st_10 st_10
em_ct em_ct
st_12 st_12
em_cw em_cw
st_15 st_15
em_ac em_ac
st_16 st_16
em_no em_no
st_17 st_17
st_18 st_18
em_jl em_jl
st_20 st_20
em_wx em_wx
st_21 st_21
em_st em_st
cbx_a$ cbx_a$
cbx_i$ cbx_i$
cbx_t$ cbx_t$
st_29 st_29
em_ni em_ni
cbx_cardboard cbx_cardboard
cbx_edgeprotector cbx_edgeprotector
cbx_wrapping cbx_wrapping
cbx_reused cbx_reused
end type
type tabpage_process from userobject within tab_quote
end type
type dw_process from u_dw within tabpage_process
end type
type tabpage_process from userobject within tab_quote
dw_process dw_process
end type
type tabpage_skid from userobject within tab_quote
end type
type dw_skid from u_dw within tabpage_skid
end type
type tabpage_skid from userobject within tab_quote
dw_skid dw_skid
end type
type tabpage_ave_coil_wt from userobject within tab_quote
end type
type dw_ave_coil from u_dw within tabpage_ave_coil_wt
end type
type st_note from statictext within tabpage_ave_coil_wt
end type
type tabpage_ave_coil_wt from userobject within tab_quote
dw_ave_coil dw_ave_coil
st_note st_note
end type
type tabpage_max_coil_wt from userobject within tab_quote
end type
type dw_max_coil from u_dw within tabpage_max_coil_wt
end type
type tabpage_max_coil_wt from userobject within tab_quote
dw_max_coil dw_max_coil
end type
type tabpage_plate from userobject within tab_quote
end type
type dw_plate from u_dw within tabpage_plate
end type
type st_22 from statictext within tabpage_plate
end type
type st_note1 from statictext within tabpage_plate
end type
type tabpage_plate from userobject within tab_quote
dw_plate dw_plate
st_22 st_22
st_note1 st_note1
end type
type tabpage_setup from userobject within tab_quote
end type
type em_gj from u_em within tabpage_setup
end type
type st_11 from u_st within tabpage_setup
end type
type st_13 from u_st within tabpage_setup
end type
type st_14 from u_st within tabpage_setup
end type
type em_i from u_em within tabpage_setup
end type
type st_19 from u_st within tabpage_setup
end type
type em_m from u_em within tabpage_setup
end type
type st_23 from u_st within tabpage_setup
end type
type st_24 from u_st within tabpage_setup
end type
type em_l from u_em within tabpage_setup
end type
type st_25 from u_st within tabpage_setup
end type
type em_o from u_em within tabpage_setup
end type
type st_26 from u_st within tabpage_setup
end type
type st_27 from u_st within tabpage_setup
end type
type em_sh from u_em within tabpage_setup
end type
type st_28 from u_st within tabpage_setup
end type
type tabpage_setup from userobject within tab_quote
em_gj em_gj
st_11 st_11
st_13 st_13
st_14 st_14
em_i em_i
st_19 st_19
em_m em_m
st_23 st_23
st_24 st_24
em_l em_l
st_25 st_25
em_o em_o
st_26 st_26
st_27 st_27
em_sh em_sh
st_28 st_28
end type
type tab_quote from tab within w_circlepro
tabpage_coil tabpage_coil
tabpage_process tabpage_process
tabpage_skid tabpage_skid
tabpage_ave_coil_wt tabpage_ave_coil_wt
tabpage_max_coil_wt tabpage_max_coil_wt
tabpage_plate tabpage_plate
tabpage_setup tabpage_setup
end type
type em_d$ from u_em within w_circlepro
end type
type st_1 from u_st within w_circlepro
end type
type st_2 from u_st within w_circlepro
end type
type sle_n$ from u_sle within w_circlepro
end type
type pb_cust_list from u_pb within w_circlepro
end type
type st_3 from u_st within w_circlepro
end type
type sle_c$ from u_sle within w_circlepro
end type
type sle_p$ from u_sle within w_circlepro
end type
type st_4 from u_st within w_circlepro
end type
type st_5 from u_st within w_circlepro
end type
type sle_m$ from u_sle within w_circlepro
end type
type pb_close from u_pb within w_circlepro
end type
type pb_print from u_pb within w_circlepro
end type
type pb_reset from u_pb within w_circlepro
end type
type pb_save from u_pb within w_circlepro
end type
type pb_circpro3 from u_pb within w_circlepro
end type
type pb_circpro2 from u_pb within w_circlepro
end type
type pb_circpro1 from u_pb within w_circlepro
end type
type pb_open from u_pb within w_circlepro
end type
type ln_1 from line within w_circlepro
end type
end forward

global type w_circlepro from w_sheet
integer x = 88
integer y = 227
integer width = 2747
integer height = 1507
string title = "QUOTATION - CIRCLE"
boolean minbox = false
boolean resizable = false
long backcolor = 15780518
event ue_reset ( )
event ue_openfile ( )
event type string ue_whoami ( )
tab_quote tab_quote
em_d$ em_d$
st_1 st_1
st_2 st_2
sle_n$ sle_n$
pb_cust_list pb_cust_list
st_3 st_3
sle_c$ sle_c$
sle_p$ sle_p$
st_4 st_4
st_5 st_5
sle_m$ sle_m$
pb_close pb_close
pb_print pb_print
pb_reset pb_reset
pb_save pb_save
pb_circpro3 pb_circpro3
pb_circpro2 pb_circpro2
pb_circpro1 pb_circpro1
pb_open pb_open
ln_1 ln_1
end type
global w_circlepro w_circlepro

type variables
real A	//Metal Gauge
real C	//Feed Length
real D	//Density

long F	//Skid Wt.
real G	//Coil Change time
long H	//Intermediate Skid wt.
real I	//Skid change time
real J	//Skid Cost
real K	//Paper cost/ SQ. FT
int L	//No. of men req'd
real M	//PCs/ Min
real O	//Man-Hrs Die Setting
real P 	//Wt. of all circles
int Q	//No. of skids
real  X1	//Net circle Wt.

real AM	//Seconds/pc for 1 man to load
real AS	//Oven line speed 1pm
real AT	//time for one row of circles to enter oven
int AW	//No. circles across width
int AC	//No. of circles req'd
real AZ	//Total time req'd to anneal Hrs
int AL 	//No. of men req'd ti anneal

// anneal is a processing without accurated production data and must be separatedf from others
real AP	//Anneal price/LB
real AA 	//Anneal price/circle
real AZZ	//Total time fo anneal (one man loading )
real APP	//Anneal price/lb with (one man loading )
real APA 	//Anneal Price/Circle wth (one man loading)

real CD	//Circle diameter
real CT 	//Circle spacing
real CW	//Width spacing

real EQ	//Input coil O.D

real GJ	//Plate loading time (input)

real JL	//No.  times skid used
real JP

real KA
real KB
int KD	//No. of deck boards used
int KF	//No. of 2X4's on width
real KH	//Stack Ht.
real KL 	//Skid Length
real KO	//Space between deck boards
int KP 	//No. of Top 1X6's
real KQ	//Total brd - feet of lumber
int KS	//No. deck brds in solid deck
int KT	//No. circles along skid length
real KV
real KW	//Skid width
real KX	//1X6 brd feet
int KY	//No. of 4X4's
real  KZ

real NI	//No. I.D.wraps n.g
real NO	//No. O.D wrapsn.g
int NS	//No. of stacks/skid
int NZ	//largest No. circle in row along plate length

real PX	//New plate length input
real PY	//New coil side area X density
real PZ 	//Plate length

real QZ	//New coil side area X density
 
real SS
real SR
real SP
real SQ
real SO
real SN
real SM
real SL

int SU	//new No. stacks/skid
real SH	//Scrap handling charge
real SV	//New average stack Ht.
real ST	//Max customer Skid wt
long SW	//New skid WT.
real SX	//Even stack Ht.

real TS  	//Trial skid wt
long TT	//Actual No. of either circle No. (AC) or circle wt (WX)

real  WX  	//Total Wt. of circles req'd
real WW

real XB	//Bottom paper price/in.
real XF	//Bottom cardboard price/in.
real XT	//Top paper price/in.
real XX	//Pass To continue

int ZB 	//No. of bands on skid width
int ZC	//No. of bands on skid length
real ZD	//Total band length

real DE, AE, BE, CE		//O.D.of ave. coils
real BA, BB, BC, BD		//Plate width (input spacing)	- Plate
//BD, BA, BB, BC		Coil aver. width (input. spac.)	- Coil
real BF, BG, BH, BI		//Coil Aver. width (Met. th. spac)
real BL, BM, BN, BO		//YLD( Met. th. spac & Ave. coil)
real BS, BP, BQ, BR		//YLD ( input. spac. & ave. coil)	- Coil
//BP, BQ, BR, BS		YLD - input. spac' 		- Plate

real  EA, EB, EC, ED		//No. of plates req'd(Met.th.sp)	- Plate
//ED, EA, EB, EC		Ave. Coil Wts.
real  EE, EF, EG, EH		//No. plates req'd (input. space)

real GD, GA, GB, GC	//Gross Wt/Circle(Met.Th.sp.)

real HL, HM, HN, HO	                    //Total Hrs (Met. Th. Sp)
real HP, HQ, HR, HS		//Total Hrs ( Inp. Spacing)

long IL, IM, IN1, IO	 	//Total scrap(Ave. coils)
long IP, IQ, IR, IS1		//Total scrap(Max. coils)

real KC    //cost of connerboard

real LA, LB, LC, LD		//Total scrap (Met. Th.)		- Plate
//LD, LA, LB, LC		Wt. Ave. coils with I.D.Scrap	- Coils
real LE, LF, LG, LH		//WT. Max. coil with I.D. Scrap	- Coils
//LE, LF, LG, LH		Total scrap ( input spacing)	- Plates

real  NA, NB, NC, ND	//Total Wt. of all plates(met. th. sp.)		- Plate
real  NE, NF, NG, NH		//Totla Wt. of all plates(Input spacing)	- Plate
//ND, NA, NB, NC 	Coil wts ( of new input coil dia.)		- Coils
//NE, NF, NG, NH		O.D. of input (& new input O.D) coil wts.	- Coils

real OD, OA, OB, OC	//Wt.s of scrap ends (ave. ea. coil)
real OE, OF1, OG, OH		//Wt. of scrap ends (Max. ea. coil )(16250) Input O. D)

real PD, PA, PB, PC		//No. of Coils (ave.)
real  PE, PF, PG, PH		//No. of coils (Max)

real  QD, QA, QB, QC		//O.D. coils with ave. wt.
//			O.D. coils with ave. wt & I. D. Scrap
//			O.D. coils with ave. wt with I.D. & O.D. scrap
//			Final O.D. of ave. coils
real QE, QF, QG, QH		//Final O.D. max. coils
//			O.D.max. coils with I.D.scrap
//			O.D.max. coils with I.D.& O.D. scrap
real QS

real RD, RA, RB, RC		//Total Wt. of all ave. coils
real  RE, RF, RG, RH		//Total Wt. of all Max. coils
real RL, RM, RN, RO		//Total job cost (Metal thkk. spacing)
real RP, RQ, RR, RS		//Total job cost ( input spacing)

real TA, TB, TC, TD		//Plate wts. (met. th. spacing)   		- Plate
//long TD, TA, TB, TC		//Semi-final gross coil wt. (Ave. coils)	- Coils
//			Final gross coil wt. (ave. coils)
real TE, TF, TG, TH		//Semi-final gross coil wt. (max. coils)
//			Final gross coil wt.(max. coils)
//			final gross coil wt. (input coils)

real UA, UB, UC, UD	//Plate weight ( input spacing)	- Plate
//Long UD, UA, UB, UC	//No. coils (ave. wt.)		- Coils
real UE, UF, UG, UH	//No.  coils (Max. Wt.)
//			No. coils (input O.D.)

real VD, VA, VB, VC		//% YLD losses by coil ends( Ave. coils)
real VE, VF, VG, VH		//% YLD losses by coil ends( Max. coils)

real WD, WA, WB, WC	//Final yield on Ave. coils
real WE, WF, WG, WH	//Final yield on Max. coils

real XA

real YD, YA, YB, YC		//Price/LB metal th. sp. (ave. coil wts)
real YE, YF, YG, YH		//Price/lb input spacing (max. coils)
real YL, YM, YN, YO		//Price/lb with S.H.C.(metal Th.) ave. coils		- Coils
real YP, YQ, YR, YS		//Price/lb with S.H.C. (input spacing) max. coils	- Plate

Int zn      //same as nz

boolean A$	//will flash annealing be req'd?
string C$	//Contact
Date D$	//Date
String f$     //tempreture for annealing
boolean I$ 	//is paper interleaf req'd?
String P$	                     //phone
String M$	//Material
String N$	//Name
String v$
Boolean T$   // is metal O temper

String bm$
String bn$
String bo$
String bp$

Boolean hh$  //same as h$

Boolean TT$    //same as t$

boolean YY$
boolean ZU$             // program handle incoming plate instead of coil - yes or no

Long  il_print_plate_s  //print plate result start
Long  il_print_plate_e  //print plate result end
end variables

forward prototypes
public function integer wf_saveas_file ()
public function string wf_trim_value (string as_line, integer ai_len)
public function integer wf_coil_annealing ()
public function integer wf_init_circpro ()
public function integer wf_line_30010 ()
public subroutine wf_display_plate_dw (integer ai_id)
public function integer wf_line_40500 ()
public function integer wf_line_10000 ()
public function integer wf_sub_14000 ()
public function integer wf_line_1435 ()
public function integer wf_sub_6660 ()
public function integer wf_line_4500 ()
public function integer wf_sub_11500 ()
public function integer wf_line_42190 ()
public function integer wf_sub_33000 ()
public function integer wf_sub_33200 ()
public function integer wf_sub_32000 ()
public function integer wf_sub_60010 ()
public function integer wf_line_60500 ()
public subroutine wf_display_ave_coil_info ()
public function integer wf_line_240 ()
public subroutine wf_sub_65305 ()
public function integer wf_display_max_coil_init ()
public function integer wf_sub_65350 ()
public function integer wf_sub_65370 ()
public function integer wf_sub_65388 ()
public function integer wf_sub_548 ()
public function integer wf_sub_564 ()
public function integer wf_display_ave_coil_592 ()
public function integer wf_display_max_coil_605 ()
public function integer wf_sub_3000 ()
public function integer wf_sub_3400 ()
public function integer wf_sub_12000 ()
public function integer wf_sub_2380 ()
public subroutine wf_sub_5200 ()
public function integer wf_print_process ()
public function integer wf_sub_8000 ()
public function integer wf_final_result ()
public subroutine wf_line_sub_10000 ()
public subroutine wf_sub_11000 ()
end prototypes

event ue_reset;call super::ue_reset;tab_quote.tabpage_coil.em_a.Event pfc_selectAll()
tab_quote.tabpage_coil.em_a.Event pfc_Clear()
tab_quote.tabpage_coil.em_cd.Event pfc_selectAll()
tab_quote.tabpage_coil.em_cd.Event pfc_Clear()
tab_quote.tabpage_coil.em_pz.Event pfc_selectAll()
tab_quote.tabpage_coil.em_pz.Event pfc_Clear()
tab_quote.tabpage_coil.em_d.Event pfc_selectAll()
tab_quote.tabpage_coil.em_d.Event pfc_Clear()
tab_quote.tabpage_coil.em_ct.Event pfc_selectAll()
tab_quote.tabpage_coil.em_ct.Event pfc_Clear()
tab_quote.tabpage_coil.em_cw.Event pfc_selectAll()
tab_quote.tabpage_coil.em_cw.Event pfc_Clear()
tab_quote.tabpage_coil.em_ac.Event pfc_selectAll()
tab_quote.tabpage_coil.em_ac.Event pfc_Clear()
tab_quote.tabpage_coil.em_no.Event pfc_selectAll()
tab_quote.tabpage_coil.em_no.Event pfc_Clear()
tab_quote.tabpage_coil.em_ni.Event pfc_selectAll()
tab_quote.tabpage_coil.em_ni.Event pfc_Clear()
tab_quote.tabpage_coil.em_jl.Event pfc_selectAll()
tab_quote.tabpage_coil.em_jl.Event pfc_Clear()
tab_quote.tabpage_coil.em_wx.Event pfc_selectAll()
tab_quote.tabpage_coil.em_wx.Event pfc_Clear()
tab_quote.tabpage_coil.em_st.Event pfc_selectAll()
tab_quote.tabpage_coil.em_st.Event pfc_Clear()

//em_d$.Text = ""
//sle_n$.Text = ""
//sle_c$.Text = ""
//sle_p$.Text = ""
//sle_m$.Text = ""

tab_quote.tabpage_process.dw_process.Reset()
tab_quote.tabpage_skid.dw_skid.Reset()
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.Reset()
tab_quote.tabpage_max_coil_wt.dw_max_coil.Reset()
tab_quote.tabpage_plate.dw_plate.Reset()
end event

event ue_openfile;call super::ue_openfile;integer li_FileNum, li_rc
String ls_line
string ls_docname, ls_named

SetPointer(HourGlass!)

li_rc = GetFileOpenName("Select File", ls_docname, ls_named, "DOC",  &
	+ "CIRCLE PRO Files (*.CIR),*.CIR," )

IF li_rc = 1 THEN 
	li_FileNum = FileOpen(ls_docname, LineMode!, Read!, LockRead!)
ELSE
	RETURN 
END IF

DO  
	li_rc = FileRead(li_FileNum, ls_line)
   IF Match(ls_line,"^D@ = ") THEN em_d$.Text = wf_trim_value(ls_line,5) 
   IF Match(ls_line,"^N@ = ") THEN sle_n$.Text = wf_trim_value(ls_line,5) 
   IF Match(ls_line,"^C@ = ") THEN sle_c$.Text = wf_trim_value(ls_line,5) 
   IF Match(ls_line,"^M@ = ") THEN sle_m$.Text = wf_trim_value(ls_line,5) 
   IF Match(ls_line,"^P@ = ") THEN sle_p$.Text = wf_trim_value(ls_line,5) 

	IF Match(ls_line, "^A = " ) THEN tab_quote.tabpage_coil.em_a.Text = wf_trim_value(ls_line,4) 
	IF Match(ls_line, "^CD = " ) THEN tab_quote.tabpage_coil.em_cd.Text = wf_trim_value(ls_line,5) 
	IF Match(ls_line, "^PZ = " ) THEN tab_quote.tabpage_coil.em_pz.Text = wf_trim_value(ls_line,5) 
	IF Match(ls_line, "^D = " ) THEN tab_quote.tabpage_coil.em_d.Text = wf_trim_value(ls_line,4) 
	IF Match(ls_line, "^NO = " ) THEN tab_quote.tabpage_coil.em_no.Text = wf_trim_value(ls_line,5) 
	IF Match(ls_line, "^NI = " ) THEN tab_quote.tabpage_coil.em_ni.Text = wf_trim_value(ls_line,5) 
	IF Match(ls_line, "^JL = " ) THEN tab_quote.tabpage_coil.em_jl.Text = wf_trim_value(ls_line,5) 
	IF Match(ls_line, "^WX = " ) THEN tab_quote.tabpage_coil.em_wx.Text = wf_trim_value(ls_line,5) 
	IF Match(ls_line, "^ST = " ) THEN tab_quote.tabpage_coil.em_st.Text = wf_trim_value(ls_line,5) 

LOOP UNTIL li_rc < 0

FileClose(li_FileNum)
end event

event ue_whoami;RETURN " "
end event

public function integer wf_saveas_file ();string ls_today, ls_now
Date ld_today
Time ld_now
DateTime ldt_now
long ll_newrow
n_ds ids_datastore 

//prepare a temporary storage 
ids_datastore = CREATE n_ds
ids_datastore.DataObject = "d_quote_datastore"
ids_datastore.Reset()
ids_datastore.of_SetBase(TRUE)

ld_today = Today()
ld_now = Now()
ls_today = string(ld_today,"yymmdd")
ls_now = string(ld_now,"hhmm")
	
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "D@ = " + em_d$.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "N@ = " + sle_n$.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "C@ = " + sle_c$.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "M@ = " + sle_m$.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "P@ = " + sle_p$.Text)
				 
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "A = " + tab_quote.tabpage_coil.em_a.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "CD = " + tab_quote.tabpage_coil.em_cd.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "PZ = " + tab_quote.tabpage_coil.em_pz.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "D = " + tab_quote.tabpage_coil.em_d.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "NO = " + tab_quote.tabpage_coil.em_no.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "NI = " + tab_quote.tabpage_coil.em_ni.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "JL = " + tab_quote.tabpage_coil.em_jl.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "WX = " + tab_quote.tabpage_coil.em_wx.Text)
ids_datastore.inv_base.of_SetItem(ids_datastore.InsertRow(0), "quote_line",&				 
             "ST = " + tab_quote.tabpage_coil.em_st.Text)

//Save quote File
IF ids_datastore.SaveAs(&
     ProfileString(gs_ini_file, "QUOTATION","file_path","c:\temp")+'\'&
	              +'c' + ls_today + ls_now +".cir", Text!, FALSE) =-1 THEN
  	MessageBox("Quotation DataStore SaveAs", "Error")
	RETURN -1  
END IF

MessageBox("Success", "File has been saved as " + 'c' + ls_today + ls_now +".cir" + " Successfully!" )

DESTROY ids_datastore

RETURN 1
end function

public function string wf_trim_value (string as_line, integer ai_len);String ls_value
ls_value = Trim(Replace(as_line, 1, ai_len, " ") )

Return ls_value
end function

public function integer wf_coil_annealing ();Int li_m$
IF tab_quote.tabpage_coil.cbx_i$.Checked THEN
	i$ = TRUE
	yy$ = TRUE
ELSE
	i$ = FALSE
	yy$ = FALSE
END IF
m$ = Trim(sle_m$.Text)
li_m$ = Integer(m$)
CHOOSE CASE li_m$ 
	CASE IS < 1000
		MessageBox("Error","Invalid material alloy number!", StopSign! )
		Return -1
	CASE 1060
		F$ = "650 deg. F"
	CASE 1100
		F$ = "650 deg. F"
	CASE 1145
		F$ = "650 deg. F"
	CASE 1235
		F$ = "650 deg. F"
	CASE 1345
		F$ = "650 deg. F"
	CASE 1350
		F$ = "650 deg. F"
	CASE 3004
		F$ = "650 deg. F"
	CASE 3105
		F$ = "650 deg. F"
	CASE 3003
		F$ = "775 deg. F"
	CASE 3005
		F$ = "775 deg. F"
	CASE 5005
		F$ = "650 deg. F"
	CASE 5050
		F$ = "650 deg. F"
	CASE 5052
		F$ = "650 deg. F"
	CASE 5056
		F$ = "650 deg. F"
	CASE 5083
		F$ = "650 deg. F"
	CASE 5086
		F$ = "650 deg. F"
	CASE 5154
		F$ = "650 deg. F"
	CASE 5254
		F$ = "650 deg. F"
	CASE 5454
		F$ = "650 deg. F"
	CASE 5456
		F$ = "650 deg. F"
	CASE 5457
		F$ = "650 deg. F"
	CASE 5652
		F$ = "650 deg. F"
	CASE 7072
		F$ = "650 deg. F"
	CASE 2014 TO 2219
		MessageBox("Warning","This alloy requires a batch anneal oven, input another alloy value!" )
		Return -1
	CASE 6005 TO 6066
		MessageBox("Warning","This alloy requires a batch anneal oven, input another alloy value!" )
		Return -1
	CASE 7075 TO 7475
		MessageBox("Warning","This alloy requires a batch anneal oven, input another alloy value!" )
		Return -1
END CHOOSE
	
Return 1
end function

public function integer wf_init_circpro ();Int li_rc

//** annealing was temporary discontinued by Mr. Hole **
//IF tab_quote.tabpage_coil.cbx_a$.Checked THEN
//	a$ = TRUE
//	IF wf_coil_annealing() < 0 THEN Return -1
//ELSE
//	a$ = FALSE
//END IF
a$ = FALSE

d$ = Date(em_d$)
n$ = sle_n$.Text
c$ = sle_c$.Text
p$ = sle_p$.Text
IF NOT(a$) THEN m$ = sle_m$.Text

cd = real(tab_quote.tabpage_coil.em_cd.Text)
IF cd < 1 THEN
	MessageBox("Error", "Invalid circle diameter value!", StopSign! )
	Return -2
END IF
IF cd > 32.5 THEN
	li_rc = MessageBox("Warning", "Circle diameter value is too large for multiple nesting, use CIRCPRO1 program or you can continue with this one. Continue?", Question!, YesNo!, 1 ) 
	IF li_rc = 2 THEN Return -3
END IF

a = real(tab_quote.tabpage_coil.em_a.Text)	
IF a < 0.01 THEN 
	MessageBox("Error", "Invalid gauge value!", StopSign! )
	Return -4
END IF
IF a > 0.75 THEN
	li_rc = MessageBox("Warning", "The metal is too thick for coiled aluminum, and this program will now switch from coil to flat aluminum plate. Continue?", Question!, YesNo!, 1 ) 
	IF li_rc = 2 THEN Return -5
END IF
zu$ = FALSE
//IF a >= 0.25  AND a <= 0.55 THEN
//	li_rc = MessageBox("Question", "Do you want this program to handle incoming plate instead of coils?", Question!, YesNo!, 2 ) 
//	IF li_rc = 2 THEN 
//		zu$ = FALSE
//	ELSE
//		zu$ = TRUE
//	END IF
//plate handling was taken out of program by Mr. Hole 05/27/1997
//END IF
cw = a
ct = a

d = real(tab_quote.tabpage_coil.em_d.Text)
IF d < 0.001 THEN
	li_rc = MessageBox("Info", "Invalid coil density value (<0.05), density will be reset back to 0.098, Continue?", Question!,YesNo!, 2 )
	IF li_rc = 2 THEN Return -6
	d = 0.098
END IF
IF d > 0.3 THEN
	MessageBox("Error", "Invalid coil density value (>0.3):: too high", StopSign! )
	Return -7
END IF

Return 1
end function

public function integer wf_line_30010 ();//Aluminum plate program
//from line 30010
int li_rc

bg = (cd + ct) * 0.8660254 + cd + 2 * cw
//bg - bi = plate width (metal thickness spacing)
//bm -bo = yield for plate width metal thickness spacing
bf = cd + 2 * cw
bh = 2 * (cd + ct) * 0.8660254 + cd + 2 * cw
bi = 3 * (cd + ct) * 0.8660254 + cd + 2 * cw
li_rc = MessageBox("Question", "An approximate plate length of 120 inches will be assumed, OK?", Question!, YesNo!, 1 )
IF li_rc = 2 THEN
	pz = real(tab_quote.tabpage_coil.em_pz.Text)
	IF pz < 1 THEN 
		MessageBox("Error", "Invalid plate length value!" )
		Return -1
	ELSE 
		nz = Int(((pz)/(cd + ct)) + 0.5)
	END IF
ELSE
	nz = Int((120 / (cd + ct)) + 0.5 )
END IF
pz = nz * (cd + ct) + ct
bl = 100 * (cd / 2)^2 * 3.141592 /((pz * bf) / nz)
bm = 100 * (cd / 2)^2 * 3.141592 /((pz * bg) / (2 * nz - 1))
bn = 100 * (cd / 2)^2 * 3.141592 /((pz * bh) / ( 3 * nz - 1))
bo = 100 * (cd / 2)^2 * 3.141592 /((pz * bi) / ( 4 * nz - 2))
bm$ = "2 WIDE"
bp$ = "1 WIDE"
bn$ = "3 WIDE"
bo$ = "4 WIDE"
//ta-td = total plate weight
ta = Int(d * pz * a * bf + 0.5)
tb = Int(d * pz * a * bg + 0.5)
tc = Int(d * pz * a * bh + 0.5)
td = Int(d * pz * a * bi + 0.5)

wf_display_plate_dw(1)
tab_quote.tabpage_plate.st_note1.Text = " The foregoing INFO is with metal thickness spacing between circles"

li_rc = MessageBox("Question", "Do you want to use your spacing between either circle to circle or between plate sides and the cicles?", Question!, YesNo!, 2)
IF li_rc = 1 THEN
	ct = real(tab_quote.tabpage_coil.em_ct.Text)
	IF ct < a THEN 
		MessageBox("Error", "Invalid spacing between circles!", StopSign!)
		Return -2
	END IF
	cw = real(tab_quote.tabpage_coil.em_cw.Text)
	IF cw < a THEN 
		MessageBox("Error", "Invalid spacing between plate sides && circles!", StopSign!)
		Return -3
	END IF
	//40010
	bb = (cd + ct) * 0.8660254 + cd + 2 * cw
	ba = cd + 2 * cw
	bc = 2 * (cd + ct) * 0.8660254 + cd + 2 * cw
	bd = 3 * (cd + ct) * 0.8660254 + cd + 2 * cw
	li_rc = MessageBox("Question", "An approximate plate length of 120 inches will be assumed, OK?", Question!, YesNo!, 1 )
	IF li_rc = 2 THEN	
		px = real(tab_quote.tabpage_coil.em_pz.Text)
		IF px < 1 THEN 
			MessageBox("Error", "Invalid plate length value!" )
			Return -1
		ELSE 
			zn = Int(((pz)/(cd + ct)) + 0.5)
		END IF
	ELSE
		zn = Int((120 / (cd + ct)) + 0.5 )
	END IF
	px = zn * (cd + ct) + ct
	bp = 100 * (cd / 2)^2 * 3.141592 /((px * ba) / zn)
	bq = 100 * (cd / 2)^2 * 3.141592 /((px * bb) / (2 * zn - 1))
	br = 100 * (cd / 2)^2 * 3.141592 /((px * bc) / ( 3 * zn - 1))
	bs = 100 * (cd / 2)^2 * 3.141592 /((px * bd) / ( 4 * zn - 2))
	ua = Int(d * px * a * ba + 0.5)
	ub = Int(d * px * a * bb + 0.5)
	uc = Int(d * px * a * bc + 0.5)
	ud = Int(d * px * a * bd + 0.5)
	
	wf_display_plate_dw(2)
	tab_quote.tabpage_plate.st_note1.Text = " "
ELSE
	tab_quote.tabpage_coil.em_ct.Text = String(ct, "###,###.##" )
	tab_quote.tabpage_coil.em_cw.Text = String(cw, "###,###.##" )
END IF

Return 1
end function

public subroutine wf_display_plate_dw (integer ai_id);Long ll_newrow
String ls_s

tab_quote.tabpage_plate.dw_plate.Reset()
tab_quote.tabpage_plate.dw_plate.of_SetBase(TRUE)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "NO. CIRCLES/COIL WIDTH:")
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", bp$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", bm$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", bn$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", bo$)

CHOOSE CASE ai_id
	CASE 1
		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "PLATE WIDTH:")
		ls_s = String(bf, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		ls_s = String(bg, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		ls_s = String(bh, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		ls_s = String(bi, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "PLATE LENGTH:")
		ls_s = String(pz, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "PLATE WEIGHT:")
		ls_s = String(ta, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		ls_s = String(tb, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		ls_s = String(tc, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		ls_s = String(td, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "YIELD ( % ):")
		ls_s = String(bl, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		ls_s = String(bm, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		ls_s = String(bn, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		ls_s = String(bo, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)
	CASE 2
		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "PLATE WIDTH:")
		ls_s = String(ba, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		ls_s = String(bb, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		ls_s = String(bc, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		ls_s = String(bd, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "PLATE LENGTH:")
		ls_s = String(px, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "PLATE WEIGHT:")
		ls_s = String(ua, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		ls_s = String(ub, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		ls_s = String(uc, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		ls_s = String(ud, "###,###,###" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

		ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "YIELD ( % ):")
		ls_s = String(bp, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
		ls_s = String(bq, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
		ls_s = String(br, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
		ls_s = String(bs, "###,###.##" )
		tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)
END CHOOSE
end subroutine

public function integer wf_line_40500 ();Int li_rc
//x1 = net circle wt.
x1 = 3.14159 * (cd / 2)^2 * a * d
ac = real(tab_quote.tabpage_coil.em_ac.Text)
wx = real(tab_quote.tabpage_coil.em_wx.Text)
IF (ac > 0) AND (wx > 0) THEN
	MessageBox("Error", "System requires either number of circles OR total WT. of all circles but not both!", StopSign!)
	Return -1
END IF
IF (ac <= 0) AND (wx <= 0) THEN
	MessageBox("Error", "System requires either number of circles OR total WT. of all circles!", StopSign!)
	Return -2
END IF
IF ac > 1 THEN 
	tt = abs(ac)
	v$ = "Total number of circles"
END IF
IF ac >= 1  THEN
	p = ac * x1
	wx = ac * x1
	tab_quote.tabpage_coil.em_wx.Text = String(wx, "##,###,###" )
END IF
IF (wx > 1) AND (ac < 1) THEN 
	tt = abs(wx)
	v$ = "Lbs of circles"
END IF
IF (wx >= 1) AND (ac < 1) THEN
	p = wx
	ac = ceiling(wx/x1)
	tab_quote.tabpage_coil.em_ac.Text = String(ac, "##,###,###" )
END IF

IF bi <= 60 THEN ed = Int( ac / ((nz * 4) - 2) + 0.5) + 1
IF bh <= 60 THEN ec = Int( ac / ((nz * 3) - 1) + 0.5) + 1
IF bg <= 60 THEN eb = Int( ac / ((nz * 2) - 1) + 0.5) + 1
ea = Int( ac / nz + 0.5) + 1
IF zn > 0 THEN
	IF bd <= 60 THEN eh = Int( ac / ((zn * 4) - 2) + 0.5) + 1
	IF bc <= 60 THEN eg = Int( ac / ((zn * 3) - 1) + 0.5) + 1
	IF bb <= 60 THEN ef = Int( ac / ((zn * 2) - 1) + 0.5) + 1
	ee = Int( ac / zn + 0.5) + 1
END IF
IF ed <> 0 THEN nd = ed * td
IF ec <> 0 THEN nc = ec * tc
IF eb <> 0 THEN nb = eb * tb
na = ea * ta
IF eh <> 0 THEN nh = eh * ud
IF eg <> 0 THEN ng = eg * uc
IF ef <> 0 THEN nf = ef * ub
ne = ee * ua
//5010
st = Real(tab_quote.tabpage_coil.em_st.Text)
IF st < 500 OR st > 10000 THEN
	MessageBox("Error", "Invalid customer's MAX skid WT. value!", StopSign!)
	Return -3
END IF

Return 1
end function

public function integer wf_line_10000 ();String ls_s
Long ll_newrow

wf_line_sub_10000()

//10220
kh = a * ( ts / x1 ) / ns
sx = Int(kh + 0.5)
IF ns >= 4 AND ( sqrt(ns) - Int(sqrt(ns)) ) = 0 THEN 
	kl = sqrt(ns) * cd
	kw = kl
END IF
IF ns = 2 THEN
	kl = 2 * cd
	kw = cd
END IF
IF ns = 1 THEN
	kl = cd
	kw = cd
END IF
wf_sub_5200()
//ts = Int(sx / a) * ns * x1
h = ac * x1 / ts
//ts = ac * x1 / (Int(h + 0.5))

kh = ((ts / x1) * a) / ns
q = ac * x1 / ts
//print out is included in wf_line_1435()


// 1290
f = wx / q
//IF wf_sub_14000() < 0 THEN Return -1
IF wf_line_1435() < 0 THEN Return -2
IF wf_line_4500() < 0 THEN Return -3

Return 1
end function

public function integer wf_sub_14000 ();Int li_rc
li_rc = MessageBox("Question", "Do you agree with this skid?", Question!, YesNo!, 1)
IF li_rc = 2 THEN
	MessageBox("Info","Change the values on MATERIAL tabpage and use the Recal buttom to recalculate all values!" )
	//tab_quote.tabpage_plate.cb_recal.Enabled = TRUE
	Return -1
END IF
Return 1
end function

public function integer wf_line_1435 ();Long ll_newrow
String ls_s
Real lr_charge

tab_quote.SelectTab(3)

tab_quote.tabpage_skid.dw_skid.Reset()
tab_quote.tabpage_skid.dw_skid.of_SetBase(TRUE)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "Skid weight:")
ls_s = String(ts, "###,###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item2", "No. of stacks/skid:")
ls_s = String(ns, "###,###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "Skid width in inches:")
ls_s = String(kw, "###,###.##" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item2", "Skid length in inches:")
ls_s = String(kl, "###,###.##" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "Average stack height:")
ls_s = String(kh, "###,###.##" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item2", "Number of skids req'd:")
ls_s = String(q, "###,###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

ks = kl / 5.5 + 1
IF cd < 8.5 THEN kd = Int(kl / 5.5)
IF cd >= 8.5 AND cd < 14 THEN kd = Int(kl / cd) + 1
IF cd >= 14 AND cd < 22 THEN kd = 2 * Int(kl / cd) + 1
If cd >= 22 AND cd < 37 THEN kd = 3 * Int(kl / cd) + 1
kt = int(kl / cd)
kx = (6 / 144)*(kt * kw + kv * kh + kd * kw)
IF (kw < 20) AND (f < 2000) THEN ky = 2
IF (kw > 20) AND (kw < 30) AND (f < 2000) THEN ky = 2
IF (kw > 20) AND (kw < 30) AND (f < 2000) THEN ky = 2
IF kw >= 30 THEN ky = 3
IF ky = 3 THEN kf = 2
IF ky = 2 THEN kf = 3

IF cd >= 6 THEN 
	kp = Int(kl / cd)
	IF cd >= 6 THEN 
		zc = Int(kw / cd)
		IF cd >= 6 THEN 
			zb = Int(kl / cd)
			kp = Int(kl / 6)
		ELSE
			zb = kp
		END IF	
		wf_sub_6660()
	ELSE
		zc = Int(kl / 12 )
		wf_sub_6660()
	END IF	
ELSE
	kp = Int(kl / 6 )
	wf_sub_6660()
END IF

ko = (kl - (5.5 * kd)) / (kd - 1)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "SKID INFORMATION")

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "No. of deck boards:")
ls_s = String(kd, "###,###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "No. of 1 X 6 top batens:")
ls_s = String(kt, "###,###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "No. of 4 X 4 boards:")
ls_s = String(ky, "###,###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "No. of 2 X 4 boards:")
ls_s = String(kf, "###,###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "Space between deck boards:")
ls_s = String(ko, "###,###.###" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)

ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 

lr_charge = j / 0.7
ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "SKID CHARGE:")
ls_s = String( lr_charge, "###,###.##" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)

lr_charge = jp / 0.7
ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "PACKAGING CHARGE:")
ls_s = String( lr_charge, "###,###.##" )
tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)


Return 1
end function

public function integer wf_sub_6660 ();Real lr_t
Int li_rc
String ls_s
Long ll_newrow

lr_t = 2 * kh + kw
IF lr_t < 48 THEN xt = 0.016
IF lr_t >= 48 AND lr_t < 60 THEN xt = 0.018
IF lr_t >= 60 AND lr_t < 80 THEN xt = 0.032
IF lr_t >= 80 AND lr_t < 100 THEN xt = 0.032
IF lr_t >= 100 THEN xt = 0.034

IF a <= 0.125 THEN
	IF kw <= 48 THEN xf = 0.009
	IF kw <= 60 AND kw > 48 THEN xf = 0.0105
	IF kw > 60 THEN xf = 0.0168
	IF tab_quote.tabpage_coil.cbx_wrapping.Checked THEN
		qs = 0.006 * ( 2 * kl * kh + 2 * kw * kh ) * 8 / 144
	END IF
	IF tab_quote.tabpage_coil.cbx_edgeprotector.Checked THEN
		kc = 0.15 * 2 * (kl  + kw ) / 12
		ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
		tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "Cost of cornerboards:")
		ls_s = String(kc, "###,###.##" )
		tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
	END IF
ELSE
	IF tab_quote.tabpage_coil.cbx_cardboard.Checked THEN
		IF kw <= 48 THEN xf = 0.009
		IF kw <= 60 AND kw > 48 THEN xf = 0.0105
		IF kw > 60 THEN xf = 0.0168
		IF tab_quote.tabpage_coil.cbx_wrapping.Checked THEN
			qs = 0.006 * ( 2 * kl * kh + 2 * kw * kh ) * 8 / 144
		END IF
		IF tab_quote.tabpage_coil.cbx_edgeprotector.Checked THEN
			kc = 0.15 * 2 * (kl  + kw ) / 12
			ll_newrow = tab_quote.tabpage_skid.dw_skid.InsertRow(0) 
			tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "item1", "Cost of cornerboards:")
			ls_s = String(kc, "###,###.##" )
			tab_quote.tabpage_skid.dw_skid.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
		END IF
	ELSE
		xa = 1
	END IF
END IF

IF kw <= 48 THEN xb = 0.018
IF kw <= 60 AND kw > 48 THEN xb = 0.018
IF kw > 60 AND kw <= 84 THEN xb = 0.032
IF kw > 84 THEN xb = 0.034

zd = (2 * (kh + kw) + 24) * zb / 12 + (2 * (kh + kl) + 24) * zc / 12
kb = 0.024 * (zb + zc) * 2
kq = (4 * 4 * kl * ky + 2 * 4 * 144 * kz + 2 * 4 * kw * kf + 6 * kw * kd + 6 * kh * kv + 6 * kl * kt + 12 * kw * kp) / 144
ka = 4 * 0.02 * kd * (kz + ky) + 4 * 0.02 * kf * (kz + ky)
j = kq * 0.6 + 0.18 * kq + ka
jp = 0.18 * kq + 0.065 * zd + xt * kl + 2 * xf * kl + xb * kl + 0.11 * (zb + zc) + 0.04 * (zb + zc) + kb + kc + qs

Return 1
end function

public function integer wf_line_4500 ();Int li_rc
String ls_s
Long ll_newrow

//li_rc = MessageBox("Question", "Can skids be returned for reuse?", Question!, YesNo!, 2 )
IF tab_quote.tabpage_coil.cbx_reused.Checked THEN 
	li_rc = 1
ELSE
	li_rc = 2
END IF
IF li_rc = 2 THEN
	jl = 1
ELSE
	jl = Real(tab_quote.tabpage_coil.em_jl.Text)
	IF IsNull(jl) THEN jl = 0
	IF jl < 1 THEN 
		MessageBox("Error","Invalid number of times each skid can be used before dicarding value!", StopSign!)
		Return -1
	END IF
	IF jl >= 2 THEN
		IF jl > Q THEN
			ls_s = "Only " + String(Q) + " skids are req'd. Yoo can't reused more skids than are actually needed!"
			MessageBox("Error",ls_s, StopSign!)
			Return -2
		END IF
	END IF		
END IF
IF (a > 0.375) OR (ZU$) THEN
	//41700
	// g = plate loading time
	gj = real(tab_quote.tabpage_setup.em_gj.Text)
	IF gj < 0.1 THEN 
		MessageBox("Info", "Plate loading time is assumed to take 5 minutes")
		g = 0.5
	ELSE
		g = gj / 60
	END IF
	i = 0.5
	m = real(tab_quote.tabpage_setup.em_m.Text)
	IF m < 1 THEN 
		//MessageBox("Info", "Production rate will be 10 pcs/min")
		m = 10
	END IF
	l = real(tab_quote.tabpage_setup.em_l.Text)
	IF l < 1 THEN 
		MessageBox("Info", "Number of men required is 5")
		l = 5
	END IF		
ELSE
	//1700
	// g = coil change time
	g = 0.5
	i = 0.4
	m = real(tab_quote.tabpage_setup.em_m.Text)
	IF m < 1 THEN 
		//MessageBox("Info", "Production rate will be 25 pcs/min")
		m = 25
	END IF
	l = real(tab_quote.tabpage_setup.em_l.Text)
	IF l < 1 THEN 
		MessageBox("Info", "Number of men required is 5")
		l = 5
	END IF			
END IF
//3500
// IF a$ then 2068
IF tab_quote.tabpage_coil.cbx_t$.Checked THEN
	t$ = TRUE
	tt$ = TRUE
ELSE
	t$ = FALSE
	tt$ = FALSE
END IF
IF t$ THEN m = 0.9 * m

IF tab_quote.tabpage_coil.cbx_i$.Checked THEN 
	hh$ = TRUE
ELSE
	hh$ = FALSE
END IF

//total hrs = skid + plate change + run time
IF ( a > 0.375 ) OR ZU$ THEN
	//41781
	o = real(tab_quote.tabpage_setup.em_o.Text)
	IF o < 1 THEN 
		MessageBox("Info", "Die setting requires 4 man-hours")
		o = 4
	END IF
	IF hh$ THEN
		l = l + 1
		k = 0.0175
	END IF
	IF bi <= 60 THEN ho = q * i + ed * g + ac / (m * 45)
	IF bh <= 60 THEN hn = q * i + ec * g + ac / (m * 45)
	IF bg <= 60 THEN hm = q * i + eb * g + ac / (m * 45)
	hl = q * i + ea * g + ac / (m * 45)
	IF ba <> 0 THEN 
		hs = q * i + eh * g + ac / (m * 45)
		IF bc <= 60 THEN hr  = q * i + eg * g + ac / (m * 45)
		IF bb <= 60 THEN hq = q * i + ef * g + ac / (m * 45)
		hp = q * i + ee * g + ac / (m * 45)
	END IF	
ELSE
	//1810
	IF (a > 0.375) AND (zu$) THEN
		o = real(tab_quote.tabpage_setup.em_o.Text)
		IF o < 1 THEN 
			MessageBox("Info", "Die setting requires 4 man-hours")
			o = 4
		END IF
		IF hh$ THEN
			l = l + 1
			k = 0.005
		END IF		
	ELSE
		o = 4
		IF hh$ THEN
			l = l + 1
			k = 0.0175
		END IF
	END IF	
	hl = q * i + ud * g + rd / gd / (m * 45)
	IF gc <> 0 THEN ho = q * i + uc * g + rc / gc / (m * 45)
	IF gb <> 0 THEN hn  = q * i + ub * g + rb / gb / (m * 45)
	IF ga <> 0 THEN hm = q * i + ua * g + ra / ga / (m * 45)
	IF gc <> 0 THEN hs = q * i + uh * g + rh / gc / (m * 45)
	IF gb <> 0 THEN hr = q * i + ug * g + rg / gb / (m * 45)
	IF ga <> 0 THEN hq = q * i + uf * g + rf / ga / (m * 45)
	hp = q * i + ue * g + re / gd / (m * 45)
END IF

//ave.
IF jl <= 1 THEN
	ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "APPROX. LINE TIME REQ'D TO RUN (HRS):")
	ls_s = String(hl, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String(hm, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String(hn, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String(ho, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)
END IF
IF jl >= 2 THEN
	ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "*(reusing skids reduces INCLUSIVE PRICES proportionately)")
END IF
//max
ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "APPROX. LINE TIME REQ'D TO RUN (HRS):")
ls_s = String(hp, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(hq, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(hr, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(hs, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)


wf_sub_11500()
//2090
yh = rs / 0.7 / (x1 * ac)
yg = rr / 0.7 / (x1 * ac)
yf = rq / 0.7 / (x1 * ac)
ye = rp / 0.7 / (x1 * ac)
yc = ro / 0.7 / (x1 * ac)
yb = rn / 0.7 / (x1 * ac)
ya = rm / 0.7 / (x1 * ac)
yd = rl / 0.7 / (x1 * ac)
sh = 0.025

RETURN 1
end function

public function integer wf_sub_11500 ();//total job cost = no. of men X  40 X total hrs + dei setting + interleaf
// + skid cost / skid returns + die cost
IF hs = 0 THEN
	rs = 0
ELSE
	rs = l * 40 * hs + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
	ss = l * 40 * hs + o * 40 + kw * kl * k / 144 * ac / ns + 245
END IF
IF hr = 0 THEN
	rr = 0
ELSE
	rr = l * 40 * hr + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
	sr = l * 40 * hr + o * 40 + kw * kl * k / 144 * ac / ns + 245
END IF
IF hq = 0 THEN rq = 0
IF ba <> 0 THEN
	IF hq <> 0 THEN
		rq = l * 40 * hq + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
		sq = l * 40 * hq + o * 40 + kw * kl * k / 144 * ac / ns + 245	
	END IF
	rp = l * 40 * hp + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
	sp = l * 40 * hp + o * 40 + kw * kl * k / 144 * ac / ns + 245				
END IF
IF ho = 0 THEN
	ro = 0
ELSE
	ro = l * 40 * ho + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
	so = l * 40 * ho + o * 40 + kw * kl * k / 144 * ac / ns + 245
END IF
IF hn = 0 THEN
	rn = 0
ELSE
	rn = l * 40 * hn + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
	sn = l * 40 * hn + o * 40 + kw * kl * k / 144 * ac / ns + 245
END IF
IF hm = 0 THEN
	rm = 0
ELSE
	rm = l * 40 * hm + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
	sm = l * 40 * hm + o * 40 + kw * kl * k / 144 * ac / ns + 245
END IF

rl = l * 40 * hl + o * 40 + kw * kl * k / 144 * ac / ns + (Int( q / jl + 0.5) + 1) * j + 245 + jp * q
sl = l * 40 * hl + o * 40 + kw * kl * k / 144 * ac / ns + 245

	
Return 1
end function

public function integer wf_line_42190 ();//Print out plate result
String ls_s
Long ll_newrow

wf_sub_33000()
wf_sub_33200()
wf_sub_32000()

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "*** FINAL RESULT ***")

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
il_print_plate_s = ll_newrow
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Metal thickness spacing:")
ls_s = String(a, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "No. circles/coil width:")
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", bp$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", bm$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", bn$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", bo$)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Plate width:")
ls_s = String(bf, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(bg, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bh, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bi, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Plate length:")
ls_s = String(pz, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Plate weight:")
ls_s = String(ta, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(tb, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(tc, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(td, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Yield ( % ):")
ls_s = String(bl, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(bm, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bn, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bo, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Total line time needed in HRs:")
ls_s = String(hl, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(hm, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(hn, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(ho, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Price / LB:")
ls_s = String(yd, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ya, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(yb, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(yc, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Price/LB with scrap handling charge:")
ls_s = String(yo, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(yl, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(ym, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(yn, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Input spacing:")
ls_s = String(ct, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(cw, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)

//print second time
ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0) 

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "No. circles/coil width:")
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", bp$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", bm$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", bn$)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", bo$)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Plate width:")
ls_s = String(ba, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(bb, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bc, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bd, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Plate length:")
ls_s = String(px, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Plate weight:")
ls_s = String(ua, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ub, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(uc, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(ud, "###,###,##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Yield ( % ):")
ls_s = String(bp, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(bq, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(br, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bs, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Total line time needed in HRs:")
ls_s = String(hp, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(hq, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(hr, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(hs, "###,###.##" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Price / LB:")
ls_s = String(ye, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(yf, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(yg, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(yh, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_plate.dw_plate.InsertRow(0)
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Desc", "Price/LB with scrap handling charge:")
ls_s = String(yp, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(yq, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(yr, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(ys, "###,###.###" )
tab_quote.tabpage_plate.dw_plate.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

il_print_plate_e = ll_newrow

Return 1
end function

public function integer wf_sub_33000 ();//la-ld = total scrap with metal thick. spacing
//le - lh = total scrap with input spacing
la = na - (( nz * x1 ) / ta ) * na
lb = nb - (((2 * nz) - 1) * x1) / tb * nb
lc = nc - (((3 * nz) - 1) * x1) / tc * nc
ld = nd - (((4 * nz) - 2) * x1) / td * nd
IF ua <> 0 THEN
	le = ne - ((zn * x1) / ua ) * ne
	lf = nf - (((2 * zn) - 1) * x1) / ub * nf
	lg = ng - (((3 * zn) - 1) * x1) / uc * ng
	lh = nh - (((4 * zn) - 2) * x1) / ud * nh
END IF	
Return 1
end function

public function integer wf_sub_33200 ();sh = Real(tab_quote.tabpage_setup.em_sh.Text)
IF sh <= 0 THEN sh = 0.025

Return 1
end function

public function integer wf_sub_32000 ();// yl - ys = price/lb with scrap handling charge

IF yh = 0 THEN
	ys = 0
ELSE
	ys = yh + (sh * (nh - ac * x1))/(ac * x1)
END IF
IF yg = 0 THEN
	yr = 0
ELSE
	yr = yg + (sh * (ng - ac * x1))/(ac * x1)
END IF
IF yf = 0 THEN 
	yq = 0
ELSE
	yq = yf + (sh * (nf - ac * x1))/(ac * x1)
	IF ba <> 0 THEN yp = ye + (sh * (ne - ac * x1))/(ac * x1)
END IF
IF yc = 0 THEN
	yn = 0
ELSE
	yn = yc + (sh * (nd - ac * x1))/(ac * x1)
END IF
IF yb = 0 THEN
	ym = 0
ELSE
	ym = yb + (sh * (nc - ac * x1))/(ac * x1)
END IF
IF ya = 0 THEN
	yl = 0
ELSE
	yl = ya + (sh * (nb - ac * x1))/(ac * x1)
	yo = yd + (sh * (na - ac * x1))/(ac * x1)
END IF

Return 1

	
end function

public function integer wf_sub_60010 ();//coil processing 
//from line 60010
int li_rc

bg = (cd + a) * 0.8660254 + cd + 2 * a
//bg - bi = coil width (metal thickness spacing)
//bm -bo = theoretical yield for coil width
bf = cd + 2 * a
bh = 2 * (cd + a) * 0.8660254 + cd + 2 * a
bi = 3 * (cd + a) * 0.8660254 + cd + 2 * a
bm = 100 * (cd / 2)^2 * 3.141592 /( bg * (cd + a) / 2)
bl = 100 * (cd / 2)^2 * 3.141592 /( bf * (cd + a))
bn = 100 * (cd / 2)^2 * 3.141592 /( bh * (cd + a) / 3)
bo = 100 * (cd / 2)^2 * 3.141592 /( bi * (cd + a) / 4)
bm$ = "2 WIDE"
bp$ = "1 WIDE"
bn$ = "3 WIDE"
bo$ = "4 WIDE"
// ct = program input spacing between circles
// cw = program input spacing between coil sides & circles
IF a <= 0.125 THEN cw = 0.25
IF a > 0.125 AND a <= 0.188 THEN cw = 0.375
IF a > 0.188 THEN cw = 2 * a
IF a <= 0.125 THEN ct = 0.188
IF a > 0.125 AND a <= 0.15 THEN ct = 0.25
If a > 0.15 AND a<= 0.175 THEN ct = 0.3
IF a > 0.175 AND a <= 0.2 THEN ct = 0.35
IF a > 0.2 AND a <= 0.225 THEN ct = 0.375
IF a > 0.225 AND a <= 0.4 THEN ct = 0.4
IF a > 0.25 AND a <= 0.275 THEN ct = 0.44
IF a > 0.275 AND a <= 0.325 THEN ct = 0.475
IF a > 0.325 THEN ct = a + 0.25 * a
ba = (cd + ct) * 0.8660254 + cd + 2 * cw
bb = 2 * (cd + ct) * 0.8660254 + cd + 2 * cw
bc = 3 * (cd + ct) * 0.8660254 + cd + 2 * cw
bd = cd + 2 * cw
//ba - bd = coil width 
// bp - bs = yields for input spacing
bp = 100 * (cd / 2)^2 * 3.141592 /(ba * (cd + ct) / 2)
bs = 100 * (cd / 2)^2 * 3.141592 /(bd * (cd + ct))
bq = 100 * (cd / 2)^2 * 3.141592 /(bb * (cd + ct) / 3)
br = 100 * (cd / 2)^2 * 3.141592 /(bc * (cd + ct) / 4)
IF ba > 75 THEN ba = 0
IF bb > 75 THEN bb = 0
IF bc > 75 THEN bc = 0
IF ba = 0 THEN bp = 0
IF bb = 0 THEN bq = 0
IF bc = 0 THEN br = 0
IF bh > 75 THEN bh = 0
IF bh = 0 THEN bn = 0
IF bi > 75 THEN bi = 0
IF bi = 0 THEN bo = 0
IF bg > 75 THEN bg = 0
IF bg = 0 THEN bm = 0

Return 1
end function

public function integer wf_line_60500 ();Int li_rc
LONG ll_newrow
String ls_s

tab_quote.SelectTab(4)

wf_display_ave_coil_info()

//li_rc = MessageBox("Question", "Do you agree with this skid?", Question!, YesNo!, 1)
//IF li_rc = 2 THEN
//	MessageBox("Info","Change the values on MATERIAL tabpage and use the Recal buttom to recalculate all values!" )
//	//tab_quote.tabpage_ave_coil_wt.cb_recal_coil.Enabled = TRUE
//	Return -1
//END IF
//

Return 1
end function

public subroutine wf_display_ave_coil_info ();Long ll_newrow
String ls_s

tab_quote.tabpage_ave_coil_wt.dw_ave_coil.Reset()
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.of_SetBase(TRUE)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "NO. CIRCLES/COIL WIDTH:")
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", bp$)
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", bm$)
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", bn$)
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", bo$)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "THEORETICAL COIL WIDTH:")
ls_s = String(bf, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(bg, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bh, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bi, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "THEORETICAL YIELD ( % ):")
ls_s = String(bl, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(bm, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bn, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bo, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "INPUT SPACING ON CIRCLES:")
ls_s = String(ct, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "INPUT SPACING ON COIL SIDES:")
ls_s = String(cw, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "COIL WIDTH WITH INPUT SPACING:")
ls_s = String(bd, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ba, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bb, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bc, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "YIELD WITH INPUT SPACING ( % ):")
ls_s = String(bs, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(bp, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bq, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(br, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

end subroutine

public function integer wf_line_240 ();//c = feed length
//cd = circle diameter
//ct = input spacing
c = cd + ct
// following = the gross aluminum wt. / circle based on 1,2,3,4 out coils width with metal thickness spacing
gd = a * bd * c * d
ga = a * ba * c * d / 2
gb = a * bb * c * d / 3
gc = a * bc * c * d / 4
// x1 = net circle wt.
x1 = 3.14159 * ( cd / 2)^2 * a * d
//average & maxinum coil wt.
ed = 200 * bd
ea = 200 * ba
eb = 200 * bb
ec = 200 * bc
nd = 592 * bd
If nd > 30000 THEN nd = 30000
na = 592 * ba
If na > 30000 THEN na = 30000
nb = 592 * bb
If nb > 30000 THEN nb = 30000
nc = 592 * bc
If nc > 30000 THEN nc = 30000
//outside dia of ave. and max. coil
//1041
IF bc <> 0 THEN ce = 2 * sqrt((ec / (3.14159 * bc * d)) + 100 )
IF bb <> 0 THEN be = 2 * sqrt((eb / (3.14159 * bb * d)) + 100 )
IF ba <> 0 THEN ae = 2 * sqrt((ea / (3.14159 * ba * d)) + 100 )
de = 2 * sqrt((ed / (3.14159 * bd * d)) + 100 )
IF bc <> 0 THEN nh = 2 * sqrt((nc / (3.14159 * bc * d)) + 100 )
IF bb <> 0 THEN ng = 2 * sqrt((nb / (3.14159 * bb * d)) + 100 )
IF ba <> 0 THEN nf = 2 * sqrt((na / (3.14159 * ba * d)) + 100 )
ne = 2 * sqrt((nd / (3.14159 * bd * d)) + 100 )

no = Real(tab_quote.tabpage_coil.em_no.Text)
ni = Real(tab_quote.tabpage_coil.em_ni.Text)

wf_sub_65305()

ac = real(tab_quote.tabpage_coil.em_ac.Text)
wx = real(tab_quote.tabpage_coil.em_wx.Text)
IF (ac > 0.1) AND (wx > 0.1) THEN
	MessageBox("Error", "System requires either number of circles OR total WT. of all circles but not both!", StopSign!)
	Return -1
END IF
IF (ac <= 0.1) AND (wx <= 0.1) THEN
	MessageBox("Error", "System requires either number of circles OR total WT. of all circles!", StopSign!)
	Return -2
END IF
IF ac > 0.1 THEN 
	tt = abs(ac)
	v$ = "Total number of circles"
	p = ac * x1
	wx = ac * x1
	tab_quote.tabpage_coil.em_wx.Text = String(wx, "##,###,###" )
ELSE
	tt = abs(wx)
	v$ = "Lbs of circles"
	p = abs(wx)
	ac = ceiling(wx / x1)
	tab_quote.tabpage_coil.em_ac.Text = String(ac, "##,###,###" )
END IF
//482
//no. of coils = gr. circle wt X total no. circles /ave.& max coil wt - scrap
IF ec <> 0 THEN pc = gc * ac / (ec - oc)
IF eb <> 0 THEN pb = gb * ac / (eb - ob)
IF ea <> 0 THEN pa = ga * ac / (ea - oa)
pd = gd * ac / (ed - od)
IF nc <> 0 THEN ph = gc * ac / (nc - oh)
IF nb <> 0 THEN pg = gb * ac / (nb - og)
IF na <> 0 THEN pf = ga * ac / (na - of1)
pe = gd * ac / (nd - oe)
//integerize
ud = Int(pd + 0.5)
ua = Int(pa + 0.5)
ub = Int(pb + 0.5)
uc = Int(pc + 0.5)
ue = Int(pe + 0.5)
uf = Int(pf + 0.5)
ug = Int(pg + 0.5)
uh = Int(ph + 0.5)

wf_sub_65350()
wf_sub_548()
wf_sub_65388()
wf_sub_65370()
wf_sub_564()

//following = final integer for No. of coils
IF td > ed THEN ud = Int( ud + 0.5 ) + 1
IF ta > ea THEN ua = Int( ua + 0.5 ) + 1
IF tb > eb THEN ub = Int( ub + 0.5 ) + 1
IF tc > ec THEN uc = Int( uc + 0.5 ) + 1
IF te > nd THEN ue = Int( ue + 0.5 ) + 1
IF tf > na THEN uf = Int( uf + 0.5 ) + 1
IF tg > nb THEN ug = Int( ug + 0.5 ) + 1
IF th > nc THEN uh = Int( uh + 0.5 ) + 1

//3200
// average & maximun coil weight
IF uh <> 0 THEN th = rh / uh
IF ug <> 0 THEN tg = rg / ug
IF uf <> 0 THEN tf = rf / uf
te = re / ue
IF uc <> 0 THEN tc = rc / uc
IF ub <> 0 THEN tb = rb / ub
IF ua <> 0 THEN ta = ra / ua
td = rd / ud

//13000
//final O.D of average and maximum final coil weight.
IF tc = 0 THEN 
	qc = 0
ELSE
	qc = 2 * sqrt((tc / (3.141592 * bc * d)) + 100 )
END IF
IF tb = 0 THEN 
	qb = 0
ELSE
	qb = 2 * sqrt((tb / (3.141592 * bb * d)) + 100 )
END IF
IF ta = 0 THEN 
	qa = 0
ELSE
	qa = 2 * sqrt((ta / (3.141592 * ba * d)) + 100 )
END IF
qd = 2 * sqrt((td / (3.141592 * bd * d)) + 100 )
IF th = 0 THEN 
	qh = 0
ELSE
	qh = 2 * sqrt((th / (3.141592 * bc * d)) + 100 )
END IF
IF tg = 0 THEN 
	qg = 0
ELSE
	qg = 2 * sqrt((tg / (3.141592 * bb * d)) + 100 )
END IF
IF tf = 0 THEN 
	qf = 0
ELSE
	qf = 2 * sqrt((tf / (3.141592 * ba * d)) + 100 )
END IF
qe = 2 * sqrt((te / (3.141592 * bd * d)) + 100 )

wf_sub_3000()
wf_sub_3400()
wf_display_ave_coil_592()
wf_display_max_coil_605()

//5010 --SAME AS PLATE UNTIL LINE 42190 
st = Real(tab_quote.tabpage_coil.em_st.Text)
IF st < 500 OR st > 10000 THEN
	MessageBox("Error", "Invalid customer's MAX skid WT. value!", StopSign!)
	Return -1
END IF
//from line 10000 To line 2118 included in following function
IF wf_line_10000() < 0 THEN Return -2

//2120
wf_sub_12000()
wf_sub_2380()

Return 1
end function

public subroutine wf_sub_65305 ();Long ll_newrow
String ls_s

// following = wt. of scrap ends
od = 3.141592 * a * d * bd * (de * no + 20 * ni)
oa = 3.141592 * a * d * ba * (ae * no + 20 * ni)
ob = 3.141592 * a * d * bb * (be * no + 20 * ni)
oc = 3.141592 * a * d * bc * (ce * no + 20 * ni)
oe = 3.141592 * a * d * bd * (ne * no + 20 * ni)
of1 = 3.141592 * a * d * ba * (nf * no + 20 * ni)
og = 3.141592 * a * d * bb * (ng * no + 20 * ni)
oh = 3.141592 * a * d * bc * (nh * no + 20 * ni)

wf_display_max_coil_init()

IF eq > 1 THEN 
	ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "MAXIMUM COIL WEIGHT:")
	ls_s = String((340 * bd), "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String((340 * ba), "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String((340 * bb), "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String((340 * bc), "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

	ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "OUTSIDE DIAMETER:")
	ls_s = String(70, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String(70, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String(70, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String(70, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)
ELSE
	//ave
	ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 

	ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "AVERAGE COIL WEIGHT:")
	ls_s = String(ed, "###,###,###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String(ea, "###,###,###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String(eb, "###,###,###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String(ec, "###,###,###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

	ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "OUTSIDE DIAMETER:")
	ls_s = String(de, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String(ae, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String(be, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String(ce, "###,###.##" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

	//max
	ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "MAXIMUM COIL WEIGHT:")
	ls_s = String(nd, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String(na, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String(nb, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String(nc, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

	ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "OUTSIDE DIAMETER:")
	ls_s = String(ne, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String(nf, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String(ng, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String(nh, "###,###,###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

END IF	
end subroutine

public function integer wf_display_max_coil_init ();tab_quote.tabpage_max_coil_wt.dw_max_coil.Reset()
tab_quote.tabpage_max_coil_wt.dw_max_coil.of_SetBase(TRUE)
Return 1

end function

public function integer wf_sub_65350 ();// following = coil wt. + I.D. scrap wt
IF uc <> 0 THEN lc = gc * ac / uc + 3.41592 * (20 + ni * a) * ni * a * bc * d
IF ub <> 0 THEN lb = gb * ac / ub + 3.41592 * (20 + ni * a) * ni * a * bb * d
IF ua <> 0 THEN la = ga * ac / ua + 3.41592 * (20 + ni * a) * ni * a * ba * d
ld = gd * ac / ud + 3.41592 * (20 + ni * a) * ni * a * bd * d

IF uh <> 0 THEN lh = gc * ac / uh + 3.41592 * (20 + ni * a) * ni * a * bc * d
IF ug <> 0 THEN lg = gb * ac / ug + 3.41592 * (20 + ni * a) * ni * a * bb * d
IF uf <> 0 THEN lf = ga * ac / uf + 3.41592 * (20 + ni * a) * ni * a * ba * d
le = gd * ac / ue + 3.41592 * (20 + ni * a) * ni * a * bd * d

Return 1
end function

public function integer wf_sub_65370 ();// following = semi-final gross coil weight
IF qc <> 0 THEN tc = 3.14159 * bc * d * ((qc / 2)^2 - 100)
IF qb <> 0 THEN tb = 3.14159 * bb * d * ((qb / 2)^2 - 100)
IF qa <> 0 THEN ta = 3.14159 * ba * d * ((qa / 2)^2 - 100)
td = 3.14159 * bd * d * ((qd / 2)^2 - 100)
IF qh <> 0 THEN th = 3.14159 * bc * d * ((qh / 2)^2 - 100)
IF qg <> 0 THEN tg = 3.14159 * bb * d * ((qg / 2)^2 - 100)
IF qf <> 0 THEN tf = 3.14159 * ba * d * ((qf / 2)^2 - 100)
te = 3.14159 * bd * d * ((qe / 2)^2 - 100)


Return 1
end function

public function integer wf_sub_65388 ();//following = final O.D. of coil with O.D. scrap
IF qc <> 0 THEN qc = qc + no * 2 * a
IF qb <> 0 THEN qb = qb + no * 2 * a
IF qa <> 0 THEN qa = qa + no * 2 * a
qd = qd + no * 2 * a
IF qh <> 0 THEN qh = qh + no * 2 * a
IF qg <> 0 THEN qg = qg + no * 2 * a
IF qf <> 0 THEN qf = qf + no * 2 * a
qe = qe + no * 2 * a

Return 1

end function

public function integer wf_sub_548 ();// following = O.D.of coils with I.D. scrap
IF lc <> 0 THEN qc = sqrt((lc / (3.14159 * bc * d)) + 100 ) * 2
IF lb <> 0 THEN qb = sqrt((lb / (3.14159 * bb * d)) + 100 ) * 2
IF la <> 0 THEN qa = sqrt((la / (3.14159 * ba * d)) + 100 ) * 2
qd = sqrt((ld / (3.14159 * bd * d)) + 100 ) * 2
IF lh <> 0 THEN qh = sqrt((lh / (3.14159 * bc * d)) + 100 ) * 2
IF lg <> 0 THEN qg = sqrt((lg / (3.14159 * bb * d)) + 100 ) * 2
IF lf <> 0 THEN qf = sqrt((lf / (3.14159 * ba * d)) + 100 ) * 2
qe = sqrt((le / (3.14159 * bd * d)) + 100 ) * 2
Return 1
end function

public function integer wf_sub_564 ();// following is the total material weight required
rd = ud * td
ra = ua * ta
rb = ub * tb
rc = uc * tc
re = ue * te
rf = uf * tf
rg = ug * tg
rh = uh * th

Return 1
end function

public function integer wf_display_ave_coil_592 ();Long ll_newrow
String ls_s

tab_quote.SelectTab(4)

//tab_quote.tabpage_ave_coil_wt.dw_ave_coil.Reset()
//tab_quote.tabpage_ave_coil_wt.dw_ave_coil.of_SetBase(TRUE)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
//tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "NO. CIRCLES/COIL WIDTH:")
//tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", bp$)
//tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", bm$)
//tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", bn$)
//tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", bo$)
//ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
//
ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "COIL WIDTH:")
ls_s = String(bd, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ba, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bb, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bc, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "AVERAGE COIL WEIGHT:")
ls_s = String(td, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ta, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(tb, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(tc, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "OUTSIDE DIAMETER:")
ls_s = String(qd, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(qa, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(qb, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(qc, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "NUMBER OF COILS REQ'D:")
ls_s = String(ud, "###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ua, "###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(ub, "###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(uc, "###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "TOTAL COIL WEIGHT REQ'D:")
ls_s = String(rd, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ra, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(rb, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(rc, "###,###,###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "YIELD WITH AVERAGE COILS (%):")
ls_s = String(wd, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(wa, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(wb, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(wc, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "YIELD LOSS DUE TO COIL WRAP LOSSED (%):")
ls_s = String(vd, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(va, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(vb, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(vc, "###,###.##" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)


Return 1
end function

public function integer wf_display_max_coil_605 ();Long ll_newrow
String ls_s

tab_quote.Selecttab(5)

tab_quote.tabpage_max_coil_wt.dw_max_coil.Reset()
tab_quote.tabpage_max_coil_wt.dw_max_coil.of_SetBase(TRUE)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "NO. CIRCLES/COIL WIDTH:")
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", bp$)
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", bm$)
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", bn$)
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", bo$)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "COIL WIDTH:")
ls_s = String(bd, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ba, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(bb, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(bc, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "MAXIMUN COIL WEIGHT:")
ls_s = String(te, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(tf, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(tg, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(th, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "OUTSIDE DIAMETER:")
ls_s = String(qe, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(qf, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(qg, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(qh, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "NUMBER OF COILS REQ'D:")
ls_s = String(ue, "###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(uf, "###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(ug, "###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(uh, "###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "TOTAL COIL WEIGHT REQ'D:")
ls_s = String(re, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(rf, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(rg, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(rh, "###,###,###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "YIELD WITH MAXIMUM COILS (%):")
ls_s = String(we, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(wf, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(wg, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(wh, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "YIELD LOSS DUE TO COIL WRAP LOSSES (%):")
ls_s = String(ve, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(vf, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(vg, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(vh, "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

Return 1

end function

public function integer wf_sub_3000 ();// final yield on average and maximum weight coils
IF rc <> 0 THEN wc = ((p / rc) * 100 )
IF rb <> 0 THEN wb = ((p / rb) * 100 )
IF ra <> 0 THEN wa = ((p / ra) * 100 )
wd = ((p / rd) * 100 )
IF rh <> 0 THEN wh = ((p / rh) * 100 )
IF rg <> 0 THEN wg = ((p / rg) * 100 )
IF rf <> 0 THEN wf = ((p / rf) * 100 )
we = ((p / re) * 100 )
Return 1
end function

public function integer wf_sub_3400 ();// yield loss due to coil end loss
IF rc <> 0 THEN vc = ((rc - ac * gc) / rc) * 100
IF rb <> 0 THEN vb = ((rb - ac * gb) / rb) * 100
IF ra <> 0 THEN va = ((ra - ac * ga) / ra) * 100
vd = ((rd - ac * gd) / rd) * 100
IF rh <> 0 THEN vh = ((rh - ac * gc) / rh) * 100
IF rg <> 0 THEN vg = ((rg - ac * gb) / rg) * 100
IF rf <> 0 THEN vf = ((rf - ac * ga) / rf) * 100
ve = ((re - ac * gd) / re) * 100
Return 1
end function

public function integer wf_sub_12000 ();// yl - ys = price/lb with scrap handling charge
IF yh = 0 THEN
	ys = 0
ELSE
	ys = yh + (sh * (rh - ac * x1)) / (ac * x1)
END IF
IF yg = 0 THEN
	yr = 0
ELSE
	yr = yg + (sh * (rg - ac * x1)) / (ac * x1)
END IF
IF yf = 0 THEN
	yq = 0
ELSE
	yq = yf + (sh * (rf - ac * x1)) / (ac * x1)
END IF
yp = ye + (sh * (re - ac * x1)) / (ac * x1)

IF eq > 1 THEN return 1

IF yc = 0 THEN
	yo = 0
ELSE
	yo = yc + (sh * (rc - ac * x1)) / (ac * x1)
END IF
IF yb = 0 THEN
	yn = 0
ELSE
	yn = yb + (sh * (rb - ac * x1)) / (ac * x1)
END IF
IF ya = 0 THEN
	ym = 0
ELSE
	ym = ya + (sh * (ra - ac * x1)) / (ac * x1)
END IF
yl = yd + (sh * (rd - ac * x1)) / (ac * x1)

Return 2
end function

public function integer wf_sub_2380 ();Long ll_newrow
String ls_s

tab_quote.tabpage_ave_coil_wt.st_note.Text = "The INCLUSIVE prices include all charge for skids, packaging and scrap and scrap handling. then BASIC price do NOT include any extra charge"

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "PRICE/LB with average coil weight:")
ls_s = String(yd, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ya, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(yb, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(yc, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "PRICE/LB with maximum coil weight:")
ls_s = String(ye, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(yf, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(yg, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(yh, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "PRICE/CIRCLE with average coil weight:")
ls_s = String((yd * x1), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String((ya * x1), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String((yb * x1), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String((yc * x1), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "PRICE/CIRCLE with maximum coil weight:")
ls_s = String((ye * x1), "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String((yf * x1), "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String((yg * x1), "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String((yh * x1), "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

//average
ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "INCLUSIVE PRICE/LB (on circles shipped):")
ls_s = String(yl, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(ym, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(yn, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(yo, "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "BASIC PRICE/LB (on circles shipped):")
ls_s = String((sl / 0.7 / (x1 * ac)), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String((sm / 0.7 / (x1 * ac)), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String((sn / 0.7 / (x1 * ac)), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String((so / 0.7 / (x1 * ac)), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "INCLUSIVE PRICE/LB (on coil wt. rec'd):")
ls_s = String((yl * wd / 100), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String((ym * wa / 100), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String((yn * wb / 100), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String((yo * wc / 100), "###,###.###" )
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_ave_coil_wt.dw_ave_coil.InsertRow(0) 
tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Desc", "BASIC PRICE/LB (on coil wt. rec'd):")
IF rd <> 0 THEN 
	ls_s = String((sl / 0.7 / rd), "###,###.###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
END IF
IF ra <> 0 THEN
	ls_s = String((sm / 0.7 / ra), "###,###.###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
END IF
IF rb <> 0 THEN
	ls_s = String((sn / 0.7 / rb), "###,###.###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
END IF
IF rc <> 0 THEN
	ls_s = String((so / 0.7 / rc), "###,###.###" )
	tab_quote.tabpage_ave_coil_wt.dw_ave_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)
END IF

//maximum
ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "INCLUSIVE PRICE/LB (on circles shipped):")
ls_s = String(yp, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String(yq, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String(yr, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String(ys, "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "BASIC PRICE/LB (on circles shipped):")
IF (x1 * ac) <> 0 THEN
	ls_s = String((sp / 0.7 / (x1 * ac)), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
	ls_s = String((sq / 0.7 / (x1 * ac)), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
	ls_s = String((sr / 0.7 / (x1 * ac)), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
	ls_s = String((ss / 0.7 / (x1 * ac)), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)
END IF

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "INCLUSIVE PRICE/LB (on coil wt. rec'd):")
ls_s = String((yp * we /100), "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
ls_s = String((yq * wf /100), "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
ls_s = String((yr * wg /100), "###,###.##" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
ls_s = String((ys * wh /100), "###,###.###" )
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)

ll_newrow = tab_quote.tabpage_max_coil_wt.dw_max_coil.InsertRow(0) 
tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Desc", "BASIC PRICE/LB (on coil wt. rec'd):")
IF re <> 0 THEN
	ls_s = String((sp / 0.7 / re), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal1", ls_s)
END IF
IF rf <> 0 THEN
	ls_s = String((sq / 0.7 / rf), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal2", ls_s)
END IF
IF rg <> 0 THEN
	ls_s = String((sr / 0.7 / rg), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal3", ls_s)
END IF
IF rh <> 0 THEN
	ls_s = String((ss / 0.7 / rh), "###,###.###" )
	tab_quote.tabpage_max_coil_wt.dw_max_coil.inv_base.of_SetItem(ll_newrow, "Cal4", ls_s)
END IF

Return 1
end function

public subroutine wf_sub_5200 ();CHOOSE CASE ns
	CASE 3
		kw = cd
		kl = 3 * cd
	CASE 6
		kw = 2 * cd
		kl = 3 * cd
	CASE 8
		kw = 2 * cd
		kl = 4 * cd
	CASE 12
		kw = 3 * cd
		kl = 4 * cd
	CASE 15
		kw = 3 * cd
		kl = 5 * cd
	CASE 18
		kw = 3 * cd
		kl = 6 * cd
	CASE 20
		kw = 4 * cd
		kl = 5 * cd
	CASE 24
		kw = 4 * cd
		kl = 6 * cd
END CHOOSE
	
end subroutine

public function integer wf_print_process ();Long ll_newrow
String ls_s

tab_quote.SelectTab(2)

tab_quote.tabpage_process.dw_process.Reset()
tab_quote.tabpage_process.dw_process.of_SetBase(TRUE)

ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item1", "CIRCLE WEIGHT:")
ls_s = String(x1, "###.####" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item2", "SCRAP HANDLING CHRG/LB:")
ls_s = String(sh, "##.####" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item1", "DIE SPACING:  BETWEEN CIRCLES:")
ls_s = String(ct, "###,###.#####" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item2", "ON COIL SIDES:")
ls_s = String(cw, "###,###.#####" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item1", "COIL CHANGE TIME (HRS):")
ls_s = String(g, "###,###.##" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item2", "SKID CHANGE TIME:")
ls_s = String(i, "###,###.##" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item1", "SCRAP O.D. COIL WRAPS:")
ls_s = String(no, "###,###.##" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item2", "SCRAP I.D. WRAPS:")
ls_s = String(ni, "###,###.##" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item1", "PRODUCTION RATE (SPM):")
ls_s = String(m, "###,###,###" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item2", "IS METAL O TEMPER:")
IF t$ THEN
	tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", "YES")
ELSE
	tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", "NO")
END IF

ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item1", "NO. OF MEN FOR BLANKING:")
ls_s = String(l, "###,###" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val1", ls_s)
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item2", "NO. OF MAN-HRS TO DIE SET:")
ls_s = String(o, "###,###" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", ls_s)

wf_sub_8000()

Return 1
end function

public function integer wf_sub_8000 ();String ls_vv$
String ls_s
Long ll_newrow

IF tt = abs(ac) THEN 
	ww = abs(wx)
	ls_vv$ = " TOTAL WT. OF CIRCLES:"
END IF
IF tt = abs(wx) THEN
	ww = abs(ac)
	ls_vv$ = " TOTAL NUMBER OF CIRCLES:"
END IF

ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
ll_newrow = tab_quote.tabpage_process.dw_process.InsertRow(0) 
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item1", ls_vv$)
ls_s = String(ww, "#,###,###" )
tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val1", ls_s)

tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "item2", "PAPER INTERLEAF REQ'D?" )
IF hh$ THEN
	tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", "YES")
ELSE
	tab_quote.tabpage_process.dw_process.inv_base.of_SetItem(ll_newrow, "val2", "NO")
END IF

Return 1
end function

public function integer wf_final_result ();wf_print_process()
Return 1
end function

public subroutine wf_line_sub_10000 ();IF st > (1.5 * cd / a) * x1 * 25 THEN
		ts = (1.5 * cd / a) * x1 * 25
		ns = 25
		Return
END IF
IF st > (cd / a) * x1 * 25 THEN
		ts = st
		ns = 25
		Return
END IF

IF st > (1.5 * cd / a) * x1 * 16 THEN
		ts = (1.5 * cd / a) * x1 * 16
		ns = 16
		Return
END IF
IF st > (cd / a) * x1 * 16 THEN
		ts = st
		ns = 16
		Return
END IF

IF st > (1.5 * cd / a) * x1 * 9 THEN
		ts = (1.5 * cd / a) * x1 * 9
		ns = 9
		Return
END IF
IF st > (cd / a) * x1 * 9 THEN
		ts = st
		ns = 9
		Return
END IF

IF st > (1.5 * cd / a) * x1 * 4 THEN
		ts = (1.5 * cd / a) * x1 * 4
		ns = 4
		Return
END IF
IF st > (cd / a) * x1 * 4 THEN
		ts = st
		ns = 4
		Return
END IF

IF st > (1.5 * cd / a) * x1 * 2 THEN
		ts = (1.5 * cd / a) * x1 * 2
		ns = 2
		Return
END IF
IF st > (cd / a) * x1 * 2 THEN
		ts = st
		ns = 2
		Return
END IF

IF st > (1.5 * cd / a) * x1  THEN
		ts = (1.5 * cd / a) * x1 
		ns = 1
		Return
END IF
IF st > (cd / a) * x1  THEN
		ts = st
		ns = 1
		Return
END IF

IF st < (cd / a) * x1 THEN 
	ts = st
	ns = 1
END IF

Return


end subroutine

public subroutine wf_sub_11000 ();//il - is = total scrap with ave. and max. coils
il = rd - ac * x1
IF rd = 0 THEN il = 0
im = ra - ac * x1
IF ra = 0 THEN im = 0
in1 = rb - ac * x1
IF rb = 0 THEN in1 = 0
io = rc - ac * x1
IF rc = 0 THEN io = 0

ip = re - ac * x1
IF re = 0 THEN ip = 0
iq = rf - ac * x1
IF rf = 0 THEN iq = 0
ir = rg - ac * x1
IF rg = 0 THEN ir = 0
is1 = rh - ac * x1
IF rh = 0 THEN is1 = 0
end subroutine

on w_circlepro.create
int iCurrent
call super::create
this.tab_quote=create tab_quote
this.em_d$=create em_d$
this.st_1=create st_1
this.st_2=create st_2
this.sle_n$=create sle_n$
this.pb_cust_list=create pb_cust_list
this.st_3=create st_3
this.sle_c$=create sle_c$
this.sle_p$=create sle_p$
this.st_4=create st_4
this.st_5=create st_5
this.sle_m$=create sle_m$
this.pb_close=create pb_close
this.pb_print=create pb_print
this.pb_reset=create pb_reset
this.pb_save=create pb_save
this.pb_circpro3=create pb_circpro3
this.pb_circpro2=create pb_circpro2
this.pb_circpro1=create pb_circpro1
this.pb_open=create pb_open
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_quote
this.Control[iCurrent+2]=this.em_d$
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_n$
this.Control[iCurrent+6]=this.pb_cust_list
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.sle_c$
this.Control[iCurrent+9]=this.sle_p$
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.sle_m$
this.Control[iCurrent+13]=this.pb_close
this.Control[iCurrent+14]=this.pb_print
this.Control[iCurrent+15]=this.pb_reset
this.Control[iCurrent+16]=this.pb_save
this.Control[iCurrent+17]=this.pb_circpro3
this.Control[iCurrent+18]=this.pb_circpro2
this.Control[iCurrent+19]=this.pb_circpro1
this.Control[iCurrent+20]=this.pb_open
this.Control[iCurrent+21]=this.ln_1
end on

on w_circlepro.destroy
call super::destroy
destroy(this.tab_quote)
destroy(this.em_d$)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_n$)
destroy(this.pb_cust_list)
destroy(this.st_3)
destroy(this.sle_c$)
destroy(this.sle_p$)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_m$)
destroy(this.pb_close)
destroy(this.pb_print)
destroy(this.pb_reset)
destroy(this.pb_save)
destroy(this.pb_circpro3)
destroy(this.pb_circpro2)
destroy(this.pb_circpro1)
destroy(this.pb_open)
destroy(this.ln_1)
end on

event pfc_print;n_ds ids_datastore 
long ll_newrow
real lr_t
String ls_s

ids_datastore = CREATE n_ds
ids_datastore.DataObject = "d_report_circpro2"
ids_datastore.Reset()
ids_datastore.of_SetBase(TRUE)
ll_newrow = ids_datastore.InsertRow(0) 
//section 1
ids_datastore.inv_base.of_SetItem(ll_newrow, "d$", em_d$.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "n$", sle_n$.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "c$", sle_c$.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "p$", sle_p$.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "m$", sle_m$.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "d", tab_quote.tabpage_coil.em_d.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "cd", tab_quote.tabpage_coil.em_cd.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "a", tab_quote.tabpage_coil.em_a.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "st", tab_quote.tabpage_coil.em_st.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "wx", tab_quote.tabpage_coil.em_wx.Text)
ids_datastore.inv_base.of_SetItem(ll_newrow, "ac", tab_quote.tabpage_coil.em_ac.Text)
IF tab_quote.tabpage_coil.cbx_i$.checked THEN
	ids_datastore.inv_base.of_SetItem(ll_newrow, "i$", "YES" )
ELSE
	ids_datastore.inv_base.of_SetItem(ll_newrow, "i$", "NO" )
END IF

//section 2
ls_s = String(x1, "###,###.####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "x1", ls_s)
ls_s = String(ct, "###,###.#####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ct", ls_s)
ls_s = String(g, "###,###.####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "g", ls_s)
ls_s = String(no, "###.#####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "no", ls_s)
ls_s = String(m, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "m", ls_s)
ls_s = String(l, "###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "l", ls_s)
ls_s = String(sh, "###,###.####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "sh", ls_s)
ls_s = String(cw, "###,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "cw", ls_s)
ls_s = String(i, "###,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "i", ls_s)
ls_s = String(ni, "###.#####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ni", ls_s)
IF tab_quote.tabpage_coil.cbx_t$.checked THEN
	ids_datastore.inv_base.of_SetItem(ll_newrow, "tt$", "YES" )
ELSE
	ids_datastore.inv_base.of_SetItem(ll_newrow, "tt$", "NO" )
END IF
ls_s = String(o, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "o", ls_s)

//section 3
ls_s = String(ts, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ts", ls_s)
ls_s = String(kw, "#,###.#####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "kw", ls_s)
ls_s = String(kh, "###,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "kh", ls_s)
ls_s = String(ns, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ns", ls_s)
ls_s = String(kl, "#,###.#####")
ids_datastore.inv_base.of_SetItem(ll_newrow, "kl", ls_s)
ls_s = String((jp / 0.7), "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "jp", ls_s)
ls_s = String((j / 0.7), "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "j", ls_s)
IF jl >= 2 THEN
	ls_s = String((Int(q / jl + 0.5) + 1), "###,###,###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "q", ls_s)	
	ls_s = "***(see notes marked * below for skids used " + String(jl) + " times or more) ***"
	ids_datastore.inv_base.of_SetItem(ll_newrow, "note1", ls_s)	
ELSE
	ls_s = String(q, "###,###,###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "q", ls_s)
	ls_s = ""
	ids_datastore.inv_base.of_SetItem(ll_newrow, "note1", ls_s)	
END IF	

//section 4
ids_datastore.inv_base.of_SetItem(ll_newrow, "bp$", bp$)
ids_datastore.inv_base.of_SetItem(ll_newrow, "bm$", bm$)
ids_datastore.inv_base.of_SetItem(ll_newrow, "bn$", bn$)
ids_datastore.inv_base.of_SetItem(ll_newrow, "bo$", bo$)
ls_s = String(bd, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "bd", ls_s)
ls_s = String(ba, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ba", ls_s)
ls_s = String(bb, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "bb", ls_s)
ls_s = String(bc, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "bc", ls_s)
ls_s = String(td, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "td", ls_s)
ls_s = String(ta, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ta", ls_s)
ls_s = String(tb, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "tb", ls_s)
ls_s = String(tc, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "tc", ls_s)
ls_s = String(qd, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qd", ls_s)
ls_s = String(qa, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qa", ls_s)
ls_s = String(qb, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qb", ls_s)
ls_s = String(qc, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qc", ls_s)
ls_s = String(ud, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ud", ls_s)
ls_s = String(ua, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ua", ls_s)
ls_s = String(ub, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ub", ls_s)
ls_s = String(uc, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "uc", ls_s)
ls_s = String(rd, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "rd", ls_s)
ls_s = String(ra, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ra", ls_s)
ls_s = String(rb, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "rb", ls_s)
ls_s = String(rc, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "rc", ls_s)
ls_s = String(bl, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "bl", ls_s)
ls_s = String(bm, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "bm", ls_s)
ls_s = String(bn, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "bn", ls_s)
ls_s = String(bo, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "bo", ls_s)
ls_s = String(wd, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "wd", ls_s)
ls_s = String(wa, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "wa", ls_s)
ls_s = String(wb, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "wb", ls_s)
ls_s = String(wc, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "wc", ls_s)

wf_sub_11000()

ls_s = String(il, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "il", ls_s)
ls_s = String(im, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "im", ls_s)
ls_s = String(in1, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "in1", ls_s)
ls_s = String(io, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "io", ls_s)
ls_s = String(yl, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "yl", ls_s)
ls_s = String(ym, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ym", ls_s)
ls_s = String(yn, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "yn", ls_s)
ls_s = String(yo, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "yo", ls_s)

IF x1 * ac <> 0 THEN
	lr_t = sl / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abps1", ls_s)
	lr_t = sm / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abps2", ls_s)
	lr_t = sn / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abps3", ls_s)
	lr_t = so / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abps4", ls_s)
END IF

lr_t = yl * wd / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "aipr1", ls_s)
lr_t = ym * wa / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "aipr2", ls_s)
lr_t = yn * wb / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "aipr3", ls_s)
lr_t = yo * wc / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "aipr4", ls_s)

IF rd <> 0 THEN
	lr_t = sl / 0.7 / rd
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abpr1", ls_s)
END IF
IF ra <> 0 THEN
	lr_t = sm / 0.7 / ra
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abpr2", ls_s)
END IF
IF rb <> 0 THEN
	lr_t = sn / 0.7 / rb
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abpr3", ls_s)
END IF
IF rc <> 0 THEN
	lr_t = so / 0.7 / rc
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "abpr4", ls_s)
END IF

ls_s = String(hl, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "hl", ls_s)
ls_s = String(hm, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "hm", ls_s)
ls_s = String(hn, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "hn", ls_s)
ls_s = String(ho, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ho", ls_s)

//section 5
ls_s = String(te, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "te", ls_s)
ls_s = String(tf, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "tf", ls_s)
ls_s = String(tg, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "tg", ls_s)
ls_s = String(th, "###,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "th", ls_s)
ls_s = String(qe, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qe", ls_s)
ls_s = String(qf, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qf", ls_s)
ls_s = String(qg, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qg", ls_s)
ls_s = String(qh, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "qh", ls_s)
ls_s = String(ue, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ue", ls_s)
ls_s = String(uf, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "uf", ls_s)
ls_s = String(ug, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ug", ls_s)
ls_s = String(uh, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "uh", ls_s)
ls_s = String(re, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "re", ls_s)
ls_s = String(rf, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "rf", ls_s)
ls_s = String(rg, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "rg", ls_s)
ls_s = String(rh, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "rh", ls_s)
ls_s = String(we, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "we", ls_s)
ls_s = String(wf, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "wf", ls_s)
ls_s = String(wg, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "wg", ls_s)
ls_s = String(wh, "###,###.##")
ids_datastore.inv_base.of_SetItem(ll_newrow, "wh", ls_s)
ls_s = String(ip, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ip", ls_s)
ls_s = String(iq, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "iq", ls_s)
ls_s = String(ir, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ir", ls_s)
ls_s = String(is1, "##,###,###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "is1", ls_s)
ls_s = String(yp, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "yp", ls_s)
ls_s = String(yq, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "yq", ls_s)
ls_s = String(yr, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "yr", ls_s)
ls_s = String(ys, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "ys", ls_s)

IF x1 * ac <> 0 THEN
	lr_t = sp / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbps1", ls_s)
	lr_t = sq / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbps2", ls_s)
	lr_t = sr / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbps3", ls_s)
	lr_t = ss / 0.7 / (x1 * ac)
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbps4", ls_s)
END IF

lr_t = yp * we / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "mipr1", ls_s)
lr_t = yq * wf / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "mipr2", ls_s)
lr_t = yr * wg / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "mipr3", ls_s)
lr_t = ys * wh / 100
ls_s = String(lr_t, "##,###.###")
ids_datastore.inv_base.of_SetItem(ll_newrow, "mipr4", ls_s)

IF re <> 0 THEN
	lr_t = sp / 0.7 / re
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbpr1", ls_s)
END IF
IF rf <> 0 THEN
	lr_t = sq / 0.7 / rf
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbpr2", ls_s)
END IF
IF rg <> 0 THEN
	lr_t = sr / 0.7 / rg
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbpr3", ls_s)
END IF
IF rh <> 0 THEN
	lr_t = ss / 0.7 / rh
	ls_s = String(lr_t, "##,###.###")
	ids_datastore.inv_base.of_SetItem(ll_newrow, "mbpr4", ls_s)
END IF

ls_s = String(hp, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "hp", ls_s)
ls_s = String(hq, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "hq", ls_s)
ls_s = String(hr, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "hr", ls_s)
ls_s = String(hs, "###,###.#")
ids_datastore.inv_base.of_SetItem(ll_newrow, "hs", ls_s)

//Print quotation
ids_datastore.Print(TRUE)
MessageBox("Success", "Quotation has been printed successfully!" )

DESTROY ids_datastore

RETURN 1
end event

event open;call super::open;em_d$.Text = String(Today( ), "mm/dd/yyyy")

end event

event pfc_saveas;call super::pfc_saveas;wf_saveas_file()
end event

event close;call super::close;f_display_app()
end event

type tab_quote from tab within w_circlepro
integer x = 18
integer y = 205
integer width = 2319
integer height = 1187
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
tabposition tabposition = tabsontopandbottom!
integer selectedtab = 1
tabpage_coil tabpage_coil
tabpage_process tabpage_process
tabpage_skid tabpage_skid
tabpage_ave_coil_wt tabpage_ave_coil_wt
tabpage_max_coil_wt tabpage_max_coil_wt
tabpage_plate tabpage_plate
tabpage_setup tabpage_setup
end type

on tab_quote.create
this.tabpage_coil=create tabpage_coil
this.tabpage_process=create tabpage_process
this.tabpage_skid=create tabpage_skid
this.tabpage_ave_coil_wt=create tabpage_ave_coil_wt
this.tabpage_max_coil_wt=create tabpage_max_coil_wt
this.tabpage_plate=create tabpage_plate
this.tabpage_setup=create tabpage_setup
this.Control[]={this.tabpage_coil,&
this.tabpage_process,&
this.tabpage_skid,&
this.tabpage_ave_coil_wt,&
this.tabpage_max_coil_wt,&
this.tabpage_plate,&
this.tabpage_setup}
end on

on tab_quote.destroy
destroy(this.tabpage_coil)
destroy(this.tabpage_process)
destroy(this.tabpage_skid)
destroy(this.tabpage_ave_coil_wt)
destroy(this.tabpage_max_coil_wt)
destroy(this.tabpage_plate)
destroy(this.tabpage_setup)
end on

type tabpage_coil from userobject within tab_quote
integer x = 15
integer y = 102
integer width = 2289
integer height = 982
long backcolor = 16776960
string text = "Material"
long tabtextcolor = 33554432
long tabbackcolor = 16776960
string picturename = "Query5!"
long picturemaskcolor = 79741120
st_6 st_6
em_a em_a
st_7 st_7
em_cd em_cd
st_8 st_8
em_pz em_pz
st_9 st_9
em_d em_d
st_10 st_10
em_ct em_ct
st_12 st_12
em_cw em_cw
st_15 st_15
em_ac em_ac
st_16 st_16
em_no em_no
st_17 st_17
st_18 st_18
em_jl em_jl
st_20 st_20
em_wx em_wx
st_21 st_21
em_st em_st
cbx_a$ cbx_a$
cbx_i$ cbx_i$
cbx_t$ cbx_t$
st_29 st_29
em_ni em_ni
cbx_cardboard cbx_cardboard
cbx_edgeprotector cbx_edgeprotector
cbx_wrapping cbx_wrapping
cbx_reused cbx_reused
end type

on tabpage_coil.create
this.st_6=create st_6
this.em_a=create em_a
this.st_7=create st_7
this.em_cd=create em_cd
this.st_8=create st_8
this.em_pz=create em_pz
this.st_9=create st_9
this.em_d=create em_d
this.st_10=create st_10
this.em_ct=create em_ct
this.st_12=create st_12
this.em_cw=create em_cw
this.st_15=create st_15
this.em_ac=create em_ac
this.st_16=create st_16
this.em_no=create em_no
this.st_17=create st_17
this.st_18=create st_18
this.em_jl=create em_jl
this.st_20=create st_20
this.em_wx=create em_wx
this.st_21=create st_21
this.em_st=create em_st
this.cbx_a$=create cbx_a$
this.cbx_i$=create cbx_i$
this.cbx_t$=create cbx_t$
this.st_29=create st_29
this.em_ni=create em_ni
this.cbx_cardboard=create cbx_cardboard
this.cbx_edgeprotector=create cbx_edgeprotector
this.cbx_wrapping=create cbx_wrapping
this.cbx_reused=create cbx_reused
this.Control[]={this.st_6,&
this.em_a,&
this.st_7,&
this.em_cd,&
this.st_8,&
this.em_pz,&
this.st_9,&
this.em_d,&
this.st_10,&
this.em_ct,&
this.st_12,&
this.em_cw,&
this.st_15,&
this.em_ac,&
this.st_16,&
this.em_no,&
this.st_17,&
this.st_18,&
this.em_jl,&
this.st_20,&
this.em_wx,&
this.st_21,&
this.em_st,&
this.cbx_a$,&
this.cbx_i$,&
this.cbx_t$,&
this.st_29,&
this.em_ni,&
this.cbx_cardboard,&
this.cbx_edgeprotector,&
this.cbx_wrapping,&
this.cbx_reused}
end on

on tabpage_coil.destroy
destroy(this.st_6)
destroy(this.em_a)
destroy(this.st_7)
destroy(this.em_cd)
destroy(this.st_8)
destroy(this.em_pz)
destroy(this.st_9)
destroy(this.em_d)
destroy(this.st_10)
destroy(this.em_ct)
destroy(this.st_12)
destroy(this.em_cw)
destroy(this.st_15)
destroy(this.em_ac)
destroy(this.st_16)
destroy(this.em_no)
destroy(this.st_17)
destroy(this.st_18)
destroy(this.em_jl)
destroy(this.st_20)
destroy(this.em_wx)
destroy(this.st_21)
destroy(this.em_st)
destroy(this.cbx_a$)
destroy(this.cbx_i$)
destroy(this.cbx_t$)
destroy(this.st_29)
destroy(this.em_ni)
destroy(this.cbx_cardboard)
destroy(this.cbx_edgeprotector)
destroy(this.cbx_wrapping)
destroy(this.cbx_reused)
end on

type st_6 from u_st within tabpage_coil
integer x = 37
integer y = 35
integer width = 187
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Gauge:"
end type

type em_a from u_em within tabpage_coil
integer x = 234
integer y = 32
integer width = 241
integer height = 74
integer taborder = 61
string mask = "###.######"
string displaydata = "Ä"
double increment = 0
string minmax = ""
end type

type st_7 from u_st within tabpage_coil
integer x = 512
integer y = 35
integer width = 428
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Circle diameter:"
end type

type em_cd from u_em within tabpage_coil
integer x = 947
integer y = 32
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "###,###.####"
string displaydata = "H"
double increment = 0
string minmax = ""
end type

type st_8 from u_st within tabpage_coil
integer x = 1697
integer y = 35
integer width = 336
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Plate length:"
end type

type em_pz from u_em within tabpage_coil
integer x = 2033
integer y = 32
integer width = 216
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "###,###.##"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type st_9 from u_st within tabpage_coil
integer x = 1211
integer y = 35
integer width = 238
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Density:"
end type

type em_d from u_em within tabpage_coil
integer x = 1448
integer y = 32
integer height = 74
integer taborder = 2
boolean bringtotop = true
string text = "0.098"
string mask = "##.#####"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type st_10 from u_st within tabpage_coil
integer x = 37
integer y = 202
integer width = 651
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Space between circles:"
end type

type em_ct from u_em within tabpage_coil
integer x = 691
integer y = 198
integer width = 289
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "###,###.##"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type st_12 from u_st within tabpage_coil
integer x = 1009
integer y = 205
integer width = 1031
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Spacing between plate sides && circles:"
end type

type em_cw from u_em within tabpage_coil
integer x = 2044
integer y = 195
integer width = 219
integer height = 77
integer taborder = 2
boolean bringtotop = true
string mask = "#,###,###.##"
string displaydata = "Ä"
double increment = 0
string minmax = ""
end type

type st_15 from u_st within tabpage_coil
integer x = 37
integer y = 125
integer width = 647
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Number of circles req~'d:"
end type

type em_ac from u_em within tabpage_coil
integer x = 691
integer y = 118
integer width = 289
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "#,###,###"
string displaydata = "~b"
double increment = 0
string minmax = ""
end type

type st_16 from u_st within tabpage_coil
integer x = 37
integer y = 368
integer width = 1072
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "How many O.D. coil wraps are no good:"
end type

type em_no from u_em within tabpage_coil
integer x = 1115
integer y = 362
integer width = 139
integer height = 70
integer taborder = 2
boolean bringtotop = true
string mask = "#,###,###"
string displaydata = "8"
double increment = 0
string minmax = ""
end type

type st_17 from u_st within tabpage_coil
integer x = 1090
integer y = 282
integer width = 139
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "LBs:"
end type

type st_18 from u_st within tabpage_coil
integer x = 37
integer y = 842
integer width = 1196
integer height = 131
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "If skids can be returned for reused, estimate the number of times each skid can be used before discarding:"
end type

type em_jl from u_em within tabpage_coil
integer x = 1287
integer y = 864
integer width = 201
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "###,###"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type st_20 from u_st within tabpage_coil
integer x = 1009
integer y = 125
integer width = 611
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Total WT. of all circles:"
end type

type em_wx from u_em within tabpage_coil
integer x = 1679
integer y = 118
integer width = 285
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "#,###,###"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type st_21 from u_st within tabpage_coil
integer x = 37
integer y = 282
integer width = 720
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Customer~'s MAX skid WT.:"
end type

type em_st from u_em within tabpage_coil
integer x = 768
integer y = 282
integer width = 289
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "#,###,###"
string displaydata = "\D"
double increment = 0
string minmax = ""
end type

type cbx_a$ from u_cbx within tabpage_coil
integer x = 1287
integer y = 410
integer width = 987
integer height = 64
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
boolean enabled = false
string text = "Will flash annealing be required?"
end type

type cbx_i$ from u_cbx within tabpage_coil
integer x = 1287
integer y = 477
integer width = 790
integer height = 61
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Is paper interleaf required?"
end type

type cbx_t$ from u_cbx within tabpage_coil
integer x = 1287
integer y = 349
integer width = 574
integer height = 61
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Is metal O temper?"
end type

type st_29 from u_st within tabpage_coil
integer x = 37
integer y = 451
integer width = 1068
boolean bringtotop = true
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "How many I.D. coil  wraps are no good:"
end type

type em_ni from u_em within tabpage_coil
integer x = 1115
integer y = 442
integer width = 139
integer height = 74
integer taborder = 2
boolean bringtotop = true
string mask = "#,###,###"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type cbx_cardboard from u_cbx within tabpage_coil
integer x = 37
integer y = 547
integer width = 1814
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Is corrugated cardboard req~'d between skid and metal stack?"
end type

type cbx_edgeprotector from u_cbx within tabpage_coil
integer x = 37
integer y = 621
integer width = 1814
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Are edge protectors req~'d around top perimeter of sheet stack?"
end type

type cbx_wrapping from u_cbx within tabpage_coil
integer x = 37
integer y = 694
integer width = 753
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Is stretch wrapping req~'d?"
end type

type cbx_reused from u_cbx within tabpage_coil
integer x = 37
integer y = 768
integer width = 987
integer textsize = -10
string facename = "Arial"
long backcolor = 16776960
string text = "Can skids be returned for reuse?"
end type

type tabpage_process from userobject within tab_quote
integer x = 15
integer y = 102
integer width = 2289
integer height = 982
long backcolor = 15780518
string text = "Process"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "AlignBottom!"
long picturemaskcolor = 79741120
dw_process dw_process
end type

on tabpage_process.create
this.dw_process=create dw_process
this.Control[]={this.dw_process}
end on

on tabpage_process.destroy
destroy(this.dw_process)
end on

type dw_process from u_dw within tabpage_process
integer x = 33
integer y = 35
integer width = 2231
integer height = 944
integer taborder = 2
string dataobject = "d_circpro_process"
boolean livescroll = false
end type

type tabpage_skid from userobject within tab_quote
integer x = 15
integer y = 102
integer width = 2289
integer height = 982
long backcolor = 12639424
string text = "Skid Info"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
string picturename = "UnionReturn!"
long picturemaskcolor = 79741120
dw_skid dw_skid
end type

on tabpage_skid.create
this.dw_skid=create dw_skid
this.Control[]={this.dw_skid}
end on

on tabpage_skid.destroy
destroy(this.dw_skid)
end on

type dw_skid from u_dw within tabpage_skid
integer x = 33
integer y = 48
integer width = 2224
integer height = 918
integer taborder = 2
string dataobject = "d_circpro_skid"
boolean livescroll = false
end type

type tabpage_ave_coil_wt from userobject within tab_quote
integer x = 15
integer y = 102
integer width = 2289
integer height = 982
long backcolor = 32768
string text = "Ave. Coil WT."
long tabtextcolor = 33554432
long tabbackcolor = 32768
string picturename = "Database!"
long picturemaskcolor = 79741120
dw_ave_coil dw_ave_coil
st_note st_note
end type

on tabpage_ave_coil_wt.create
this.dw_ave_coil=create dw_ave_coil
this.st_note=create st_note
this.Control[]={this.dw_ave_coil,&
this.st_note}
end on

on tabpage_ave_coil_wt.destroy
destroy(this.dw_ave_coil)
destroy(this.st_note)
end on

type dw_ave_coil from u_dw within tabpage_ave_coil_wt
integer x = 22
integer y = 128
integer width = 2249
integer height = 842
integer taborder = 2
string dataobject = "d_circpro_ave_coil"
boolean livescroll = false
end type

type st_note from statictext within tabpage_ave_coil_wt
integer x = 51
integer y = 16
integer width = 2205
integer height = 109
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32768
boolean enabled = false
string text = "The following information is based on metal thickness spacing between circles and on coil sides on line (1) and (2). Information lines (3) and (4) are with the spacing indicated."
boolean focusrectangle = false
end type

type tabpage_max_coil_wt from userobject within tab_quote
integer x = 15
integer y = 102
integer width = 2289
integer height = 982
long backcolor = 8421376
string text = "Max. Coil WT."
long tabtextcolor = 33554432
long tabbackcolor = 8421376
string picturename = "SelectTable!"
long picturemaskcolor = 79741120
dw_max_coil dw_max_coil
end type

on tabpage_max_coil_wt.create
this.dw_max_coil=create dw_max_coil
this.Control[]={this.dw_max_coil}
end on

on tabpage_max_coil_wt.destroy
destroy(this.dw_max_coil)
end on

type dw_max_coil from u_dw within tabpage_max_coil_wt
integer x = 26
integer y = 26
integer width = 2238
integer height = 950
integer taborder = 2
string dataobject = "d_circpro_coil"
boolean livescroll = false
end type

type tabpage_plate from userobject within tab_quote
integer x = 15
integer y = 102
integer width = 2289
integer height = 982
long backcolor = 65280
string text = "Plate"
long tabtextcolor = 33554432
long tabbackcolor = 65280
string picturename = "Horizontal!"
long picturemaskcolor = 79741120
string powertiptext = "Aluminum plate program"
dw_plate dw_plate
st_22 st_22
st_note1 st_note1
end type

on tabpage_plate.create
this.dw_plate=create dw_plate
this.st_22=create st_22
this.st_note1=create st_note1
this.Control[]={this.dw_plate,&
this.st_22,&
this.st_note1}
end on

on tabpage_plate.destroy
destroy(this.dw_plate)
destroy(this.st_22)
destroy(this.st_note1)
end on

type dw_plate from u_dw within tabpage_plate
integer x = 26
integer y = 80
integer width = 2238
integer height = 864
integer taborder = 2
string dataobject = "d_circpro_plate"
boolean livescroll = false
end type

event rbuttondown;//Override
Return 1
end event

event rbuttonup;//Override
Return 1
end event

type st_22 from statictext within tabpage_plate
integer x = 614
integer y = 19
integer width = 1211
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 65280
boolean enabled = false
string text = "********** ALUMINUM PLATE PROGRAM **********"
boolean focusrectangle = false
end type

type st_note1 from statictext within tabpage_plate
integer x = 40
integer y = 954
integer width = 1419
integer height = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 65280
boolean enabled = false
boolean focusrectangle = false
end type

type tabpage_setup from userobject within tab_quote
integer x = 15
integer y = 102
integer width = 2289
integer height = 982
long backcolor = 15793151
string text = "Setup"
long tabtextcolor = 33554432
long tabbackcolor = 15793151
string picturename = "Custom087!"
long picturemaskcolor = 79741120
em_gj em_gj
st_11 st_11
st_13 st_13
st_14 st_14
em_i em_i
st_19 st_19
em_m em_m
st_23 st_23
st_24 st_24
em_l em_l
st_25 st_25
em_o em_o
st_26 st_26
st_27 st_27
em_sh em_sh
st_28 st_28
end type

on tabpage_setup.create
this.em_gj=create em_gj
this.st_11=create st_11
this.st_13=create st_13
this.st_14=create st_14
this.em_i=create em_i
this.st_19=create st_19
this.em_m=create em_m
this.st_23=create st_23
this.st_24=create st_24
this.em_l=create em_l
this.st_25=create st_25
this.em_o=create em_o
this.st_26=create st_26
this.st_27=create st_27
this.em_sh=create em_sh
this.st_28=create st_28
this.Control[]={this.em_gj,&
this.st_11,&
this.st_13,&
this.st_14,&
this.em_i,&
this.st_19,&
this.em_m,&
this.st_23,&
this.st_24,&
this.em_l,&
this.st_25,&
this.em_o,&
this.st_26,&
this.st_27,&
this.em_sh,&
this.st_28}
end on

on tabpage_setup.destroy
destroy(this.em_gj)
destroy(this.st_11)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.em_i)
destroy(this.st_19)
destroy(this.em_m)
destroy(this.st_23)
destroy(this.st_24)
destroy(this.em_l)
destroy(this.st_25)
destroy(this.em_o)
destroy(this.st_26)
destroy(this.st_27)
destroy(this.em_sh)
destroy(this.st_28)
end on

type em_gj from u_em within tabpage_setup
integer x = 651
integer y = 19
integer width = 154
integer height = 64
integer taborder = 2
string facename = "Arial"
string text = "5"
string mask = "###,###.##"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type st_11 from u_st within tabpage_setup
integer x = 18
integer y = 22
integer width = 629
integer height = 58
string facename = "Arial"
long backcolor = 15793151
string text = "Plate loading time in minutes:"
end type

type st_13 from u_st within tabpage_setup
integer x = 18
integer y = 93
integer width = 889
integer height = 58
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "Circle skid change time allowed is fixed at "
end type

type st_14 from u_st within tabpage_setup
integer x = 1086
integer y = 90
integer width = 208
integer height = 58
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "minutes:"
end type

type em_i from u_em within tabpage_setup
integer x = 922
integer y = 90
integer width = 157
integer height = 67
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "30"
string mask = "###,###"
string displaydata = "À"
double increment = 0
string minmax = ""
end type

type st_19 from u_st within tabpage_setup
integer x = 18
integer y = 163
integer width = 483
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "Production rate will be "
end type

type em_m from u_em within tabpage_setup
integer x = 501
integer y = 157
integer width = 157
integer height = 67
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "0"
string mask = "###,###"
string displaydata = "À"
double increment = 0
string minmax = ""
end type

type st_23 from u_st within tabpage_setup
integer x = 684
integer y = 160
integer width = 1492
integer height = 61
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "PCs/Min ( Default = 25 when processing coil, 10 when processing plate)"
end type

type st_24 from u_st within tabpage_setup
integer x = 18
integer y = 240
integer width = 468
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "Number of men req~'d:"
end type

type em_l from u_em within tabpage_setup
integer x = 501
integer y = 237
integer width = 157
integer height = 67
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "5"
string mask = "###,###"
string displaydata = "Ä"
double increment = 0
string minmax = ""
end type

type st_25 from u_st within tabpage_setup
integer x = 18
integer y = 317
integer width = 453
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "Die setting requires "
end type

type em_o from u_em within tabpage_setup
integer x = 501
integer y = 317
integer width = 157
integer height = 67
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "4"
string mask = "###,###"
string displaydata = "Ä"
double increment = 0
string minmax = ""
end type

type st_26 from u_st within tabpage_setup
integer x = 669
integer y = 317
integer width = 479
integer height = 58
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "man-hours "
end type

type st_27 from u_st within tabpage_setup
integer x = 18
integer y = 394
integer width = 618
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "A scrap handling charge of $"
end type

type em_sh from u_em within tabpage_setup
integer x = 644
integer y = 390
integer width = 146
integer height = 67
integer taborder = 2
boolean bringtotop = true
string facename = "Arial"
string text = "0.025"
string mask = "###.###"
string displaydata = "Ä"
double increment = 0
string minmax = ""
end type

type st_28 from u_st within tabpage_setup
integer x = 801
integer y = 394
integer width = 651
integer height = 54
boolean bringtotop = true
string facename = "Arial"
long backcolor = 15793151
string text = "/lb of scrap will be used"
end type

type em_d$ from u_em within w_circlepro
integer x = 187
integer y = 22
integer width = 260
integer height = 74
integer taborder = 10
integer weight = 700
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
string displaydata = ""
double increment = 0
string minmax = ""
end type

type st_1 from u_st within w_circlepro
integer x = 37
integer y = 26
integer width = 135
integer textsize = -9
integer weight = 700
string facename = "Arial"
long backcolor = 15780518
string text = "Date"
boolean border = true
borderstyle borderstyle = styleshadowbox!
end type

type st_2 from u_st within w_circlepro
integer x = 450
integer y = 26
integer width = 274
boolean bringtotop = true
integer textsize = -9
integer weight = 700
string facename = "Arial"
long backcolor = 15780518
string text = "Customer"
boolean border = true
borderstyle borderstyle = styleshadowbox!
end type

type sle_n$ from u_sle within w_circlepro
integer x = 728
integer y = 19
integer width = 1441
integer taborder = 20
integer weight = 700
string facename = "Arial"
end type

type pb_cust_list from u_pb within w_circlepro
integer x = 2180
integer y = 16
integer width = 88
integer height = 80
integer taborder = 0
string text = ""
boolean originalsize = false
end type

type st_3 from u_st within w_circlepro
integer x = 33
integer y = 112
integer width = 413
boolean bringtotop = true
integer textsize = -9
integer weight = 700
string facename = "Arial"
long backcolor = 15780518
string text = "Contact person"
boolean border = true
borderstyle borderstyle = styleshadowbox!
end type

type sle_c$ from u_sle within w_circlepro
integer x = 453
integer y = 112
integer width = 464
integer taborder = 30
integer weight = 700
string facename = "Arial"
end type

type sle_p$ from u_sle within w_circlepro
integer x = 1123
integer y = 112
integer width = 446
integer taborder = 40
boolean bringtotop = true
integer weight = 700
string facename = "Arial"
end type

type st_4 from u_st within w_circlepro
integer x = 922
integer y = 112
integer width = 190
boolean bringtotop = true
integer textsize = -9
integer weight = 700
string facename = "Arial"
long backcolor = 15780518
string text = "Phone"
boolean border = true
borderstyle borderstyle = styleshadowbox!
end type

type st_5 from u_st within w_circlepro
integer x = 1576
integer y = 112
integer width = 227
boolean bringtotop = true
integer textsize = -9
integer weight = 700
string facename = "Arial"
long backcolor = 15780518
string text = "Material"
boolean border = true
borderstyle borderstyle = styleshadowbox!
end type

type sle_m$ from u_sle within w_circlepro
integer x = 1818
integer y = 112
integer taborder = 50
integer weight = 700
string facename = "Arial"
end type

type pb_close from u_pb within w_circlepro
string tag = "close application"
integer x = 2352
integer y = 1162
integer width = 344
integer height = 154
integer taborder = 140
string facename = "Arial"
string text = "&Close"
string picturename = "b1_down.jpg"
string disabledname = "b1.jpg"
end type

event clicked;call super::clicked;Close(Parent)
end event

type pb_print from u_pb within w_circlepro
event clicked pbm_bnclicked
string tag = "print circle pro report"
integer x = 2352
integer y = 1005
integer width = 344
integer height = 154
integer taborder = 130
string facename = "Arial"
string text = "&Print"
string picturename = "b2_down.jpg"
string disabledname = "b2.jpg"
end type

event clicked;call super::clicked;Parent.Event pfc_print()

end event

type pb_reset from u_pb within w_circlepro
event clicked pbm_bnclicked
string tag = "Reset all values"
integer x = 2352
integer y = 848
integer width = 344
integer height = 154
integer taborder = 120
string facename = "Arial"
string text = "&Reset"
string picturename = "b3_down.jpg"
string disabledname = "b3.jpg"
end type

event clicked;call super::clicked;Parent.Event ue_reset()
end event

type pb_save from u_pb within w_circlepro
event clicked pbm_bnclicked
string tag = "Save current information"
integer x = 2352
integer y = 691
integer width = 344
integer height = 154
integer taborder = 110
string facename = "Arial"
string text = "&Save"
string picturename = "b4_down.jpg"
string disabledname = "b4.jpg"
end type

event clicked;call super::clicked;parent.event pfc_saveas()
end event

type pb_circpro3 from u_pb within w_circlepro
event clicked pbm_bnclicked
string tag = "CirclePro 3"
integer x = 2352
integer y = 534
integer width = 344
integer height = 154
integer taborder = 100
string facename = "Arial"
string text = "CircPro&3"
string picturename = "b5_down.jpg"
string disabledname = "b5.jpg"
end type

event clicked;IF wf_init_circpro() < 0 THEN Return

IF (a > 0.75) OR (zu$) THEN
	tab_quote.SelectTab(6)
	IF wf_line_30010() < 0 THEN Return 
	IF wf_line_40500() < 0 THEN Return 
	IF wf_line_10000() < 1 THEN return 
	IF wf_line_42190() < 1 THEN Return
ELSE
	wf_sub_60010()
	IF wf_line_60500() < 0 THEN Return
	IF wf_line_240() < 0 THEN Return
END IF

wf_final_result()

end event

type pb_circpro2 from u_pb within w_circlepro
event clicked pbm_bnclicked
string tag = "CirclePro 2"
integer x = 2352
integer y = 378
integer width = 344
integer height = 154
integer taborder = 90
string facename = "Arial"
string text = "CircPro&2"
string picturename = "b6_down.jpg"
string disabledname = "b6.jpg"
end type

event clicked;call super::clicked;IF wf_init_circpro() < 0 THEN Return

IF (a > 0.75) OR (zu$) THEN
	tab_quote.SelectTab(6)
	IF wf_line_30010() < 0 THEN Return 
	IF wf_line_40500() < 0 THEN Return 
	IF wf_line_10000() < 1 THEN return 
	IF wf_line_42190() < 1 THEN Return
ELSE
	wf_sub_60010()
	IF wf_line_60500() < 0 THEN Return
	IF wf_line_240() < 0 THEN Return
END IF

wf_final_result()


end event

type pb_circpro1 from u_pb within w_circlepro
event clicked pbm_bnclicked
string tag = "CirclePro 1"
integer x = 2352
integer y = 221
integer width = 344
integer height = 154
integer taborder = 80
string facename = "Arial"
string text = "CircPro&1"
string picturename = "b7_down.jpg"
string disabledname = "b7.jpg"
end type

type pb_open from u_pb within w_circlepro
event clicked pbm_bnclicked
string tag = "Open an existing quotation"
integer x = 2352
integer y = 64
integer width = 344
integer height = 154
integer taborder = 70
string facename = "Arial"
string text = "&Open"
string picturename = "b8_down.jpg"
string disabledname = "b8.jpg"
end type

event clicked;call super::clicked;Parent.Event ue_openfile()
end event

type ln_1 from line within w_circlepro
integer linethickness = 3
integer beginx = 18
integer endx = 2750
end type

