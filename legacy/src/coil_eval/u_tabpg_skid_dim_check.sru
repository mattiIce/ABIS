$PBExportHeader$u_tabpg_skid_dim_check.sru
forward
global type u_tabpg_skid_dim_check from u_tabpg
end type
type st_length_minus from statictext within u_tabpg_skid_dim_check
end type
type st_length_plus from statictext within u_tabpg_skid_dim_check
end type
type st_width_minus from statictext within u_tabpg_skid_dim_check
end type
type st_width_plus from statictext within u_tabpg_skid_dim_check
end type
type st_gauge_minus from statictext within u_tabpg_skid_dim_check
end type
type st_gauge_plus from statictext within u_tabpg_skid_dim_check
end type
type st_length from statictext within u_tabpg_skid_dim_check
end type
type st_width from statictext within u_tabpg_skid_dim_check
end type
type st_gauge from statictext within u_tabpg_skid_dim_check
end type
type st_4 from statictext within u_tabpg_skid_dim_check
end type
type st_3 from statictext within u_tabpg_skid_dim_check
end type
type st_2 from statictext within u_tabpg_skid_dim_check
end type
type cb_edit from commandbutton within u_tabpg_skid_dim_check
end type
type cb_cancel from commandbutton within u_tabpg_skid_dim_check
end type
type cb_delete from commandbutton within u_tabpg_skid_dim_check
end type
type cb_save from commandbutton within u_tabpg_skid_dim_check
end type
type cb_new from commandbutton within u_tabpg_skid_dim_check
end type
type st_skid from statictext within u_tabpg_skid_dim_check
end type
type st_1 from statictext within u_tabpg_skid_dim_check
end type
type dw_edit from u_dw within u_tabpg_skid_dim_check
end type
type dw_skid_dim from u_dw within u_tabpg_skid_dim_check
end type
end forward

global type u_tabpg_skid_dim_check from u_tabpg
integer width = 2703
integer height = 1293
st_length_minus st_length_minus
st_length_plus st_length_plus
st_width_minus st_width_minus
st_width_plus st_width_plus
st_gauge_minus st_gauge_minus
st_gauge_plus st_gauge_plus
st_length st_length
st_width st_width
st_gauge st_gauge
st_4 st_4
st_3 st_3
st_2 st_2
cb_edit cb_edit
cb_cancel cb_cancel
cb_delete cb_delete
cb_save cb_save
cb_new cb_new
st_skid st_skid
st_1 st_1
dw_edit dw_edit
dw_skid_dim dw_skid_dim
end type
global u_tabpg_skid_dim_check u_tabpg_skid_dim_check

type variables
long il_skid, il_job, il_order
int ii_order_item
long il_current_row
string is_action
double id_gauge, id_width, id_length
double id_gauge_plus, id_gauge_minus, id_width_plus, id_width_minus, id_length_plus, id_length_minus
end variables

forward prototypes
public function integer of_validate_row (long al_row)
public function integer of_init ()
public function integer of_validate_edit ()
end prototypes

public function integer of_validate_row (long al_row);//return 1 ok
//return -1 failed

double ld_temp
int li_rc
dw_edit.accepttext( )
//dw_skid_dim.accepttext( )
//if dw_skid_dim.rowcount( ) <> 1 then
//	return 1
//end if
//dw_skid_dim.accepttext( )
ld_temp = dw_skid_dim.object.pc_number[al_row]
if ld_temp < 1 or ld_temp > 99 or isNull(ld_temp ) then
	MessageBox("Data validation", "PC number out of range!")
	return -1
end if

ld_temp = dw_skid_dim.object.gauge[al_row]
if ld_temp < 0 or ld_temp > 1 or isNull(ld_temp ) then
	MessageBox("Data validation", "Gauge out of range!")
	return -1
elseif	((ld_temp > id_gauge + id_gauge_plus) or (ld_temp < id_gauge - id_gauge_minus)) then
			li_rc = MessageBox("Data validation", "Gauge out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc <> 1 then
				return -1
			end if
end if

ld_temp = dw_skid_dim.object.width[al_row]
if ld_temp < 5 or ld_temp > 199 then
	MessageBox("Data validation", "Width out of range!")
	return -1
elseif	((ld_temp > id_width + id_width_plus) or (ld_temp < id_width - id_width_minus)) then
			li_rc = MessageBox("Data validation", "Width out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc <> 1 then
				return -1
			end if	
end if

ld_temp = dw_skid_dim.object.square[al_row]
if ld_temp < 0 or ld_temp > 9 then
	MessageBox("Data validation", "Square out of range!")
	return -1
end if

ld_temp = dw_skid_dim.object.length_oper[al_row]
if ld_temp < 1 or ld_temp > 999 then
	MessageBox("Data validation", "Operator Side length out of range!")
	return -1
elseif	((ld_temp > id_length + id_length_plus) or (ld_temp < id_length - id_length_minus)) then
					li_rc = MessageBox("Data validation", "Operator side lenght out of plus/minus range, do you want to continue?", Question!, YesNo!)
					if li_rc <> 1 then
				return -1
			end if		
end if

ld_temp = dw_skid_dim.object.length_drive[al_row]
if ld_temp < 1 or ld_temp > 999 then
	MessageBox("Data validation", "Drive side lenght out of range!")
	return -1
elseif	((ld_temp > id_length + id_length_plus) or (ld_temp < id_length - id_length_minus)) then
			li_rc = MessageBox("Data validation", "Drive side lenght out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc <> 1 then
				return -1
			end if	
end if

return 1
end function

public function integer of_init ();//return 0 if all good, 1 if db error
int ll_rc
string ls_part_shape

  SELECT "SHEET_SKID"."AB_JOB_NUM"  
    INTO :il_job  
    FROM "SHEET_SKID"  
   WHERE "SHEET_SKID"."SHEET_SKID_NUM" = :il_skid   ;

if sqlca.sqlcode <> 0 or isNull(il_job) then
	return 1
end if

SELECT "AB_JOB"."ORDER_ITEM_NUM",   
         "AB_JOB"."ORDER_ABC_NUM"  
    INTO :ii_order_item,   
         :il_order  
    FROM "AB_JOB"	 WHERE "AB_JOB"."AB_JOB_NUM" = :il_job ;
	
if sqlca.sqlcode <> 0 then
	return 1
end if
	
  SELECT "ORDER_ITEM"."SHEET_TYPE",   
         "ORDER_ITEM"."GAUGE",
			"ORDER_ITEM"."GAUGE_P",
			"ORDER_ITEM"."GAUGE_M"
    INTO :ls_part_shape,   
         :id_gauge,
			:id_gauge_plus,
			:id_gauge_minus
    FROM "ORDER_ITEM"  
   WHERE ( "ORDER_ITEM"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         ( "ORDER_ITEM"."ORDER_ABC_NUM" = :il_order )   
           ;
			  
	if sqlca.sqlcode <> 0 then
		return 1
	end if
ls_part_shape = Upper( Trim(ls_part_shape) )

choose case ls_part_shape
	case "CHEVRON"
		SELECT "CHEVRON"."CH_LENGTH",
				"CHEVRON"."CH_LENGTH_PLUS",
				"CHEVRON"."CH_LENGTH_MINUS",
         	"CHEVRON"."CH_WIDTH",
				"CHEVRON"."CH_WIDTH_PLUS",
				"CHEVRON"."CH_WIDTH_MINUS"			
    	INTO :id_length,
		 		:id_length_plus,
				 :id_length_minus,
         	:id_width,
				:id_width_plus,
				:id_width_minus
    	FROM "CHEVRON"  
   	WHERE ( "CHEVRON"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         ( "CHEVRON"."ORDER_ABC_NUM" = :il_order )   
           ;

		
	case "CIRCLE"
		SELECT "CIRCLE"."C_DIAMETER",   
         "CIRCLE"."C_DIAMETER_PLUS",
			"CIRCLE"."C_DIAMETER_MINUS",   
         "CIRCLE"."C_DIAMETER",
			"CIRCLE"."C_DIAMETER_PLUS",   
         "CIRCLE"."C_DIAMETER_MINUS"			
    	INTO :id_length,
		 		:id_length_plus,
		 		:id_length_minus,
		 		:id_width, 
				:id_width_plus, 
				 :id_width_minus
    	FROM "CIRCLE"  
   	WHERE ( "CIRCLE"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         ( "CIRCLE"."ORDER_ABC_NUM" = :il_order )   
           ;
	case "FENDER"
			SELECT "FENDER"."FE_LENGTH", 
					"FENDER"."FE_LENGTH_PLUS",
					"FENDER"."FE_LENGTH_MINUS",
        			 "FENDER"."FE_SIDE", 
					"FENDER"."FE_SIDE_PLUS", 
					"FENDER"."FE_SIDE_MINUS"
    		INTO :id_length,
			 		:id_length_plus,
					 :id_length_minus,
         		:id_width,
					:id_width_plus,
					:id_width_minus
    		FROM "FENDER"  
   		WHERE ( "FENDER"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "FENDER"."ORDER_ABC_NUM" = :il_order ) ;
	
	case "LIFTGATE"
		SELECT "LIFTGATE_SHAPE"."LI_LENGTH",
				"LIFTGATE_SHAPE"."LI_LENGTH_PLUS",
				"LIFTGATE_SHAPE"."LI_LENGTH_MINUS",
         	"LIFTGATE_SHAPE"."LI_WIDTH", 
				"LIFTGATE_SHAPE"."LI_WIDTH_PLUS", 
				"LIFTGATE_SHAPE"."LI_WIDTH_MINUS"
    		INTO :id_length, 
			 		:id_length_plus,
			 		:id_length_minus,
         		:id_width,
					:id_width_plus,
					:id_width_minus
    		FROM "LIFTGATE_SHAPE"  
   		WHERE ( "LIFTGATE_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "LIFTGATE_SHAPE"."ORDER_ABC_NUM" = :il_order ) ;
	case "OTHER"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO :id_length,   
         	:id_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :il_order ) ;
	case "PARALLELOGRAM"
		SELECT "PARALLELOGRAM"."P_LENGTH",
				"PARALLELOGRAM"."P_LENGTH_PLUS",
				"PARALLELOGRAM"."P_LENGTH_MINUS",
         	"PARALLELOGRAM"."P_WIDTH",  
				"PARALLELOGRAM"."P_WIDTH_PLUS",
				"PARALLELOGRAM"."P_WIDTH_MINUS"
    		INTO :id_length, 
			 		:id_length_plus,
			 		:id_length_minus,
         		:id_width,
					:id_width_plus,
					:id_width_minus
    		FROM "PARALLELOGRAM"  
   		WHERE ( "PARALLELOGRAM"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "PARALLELOGRAM"."ORDER_ABC_NUM" = :il_order ) ;
	case "RECTANGLE"
		SELECT "RECTANGLE"."RT_LENGTH",
				"RECTANGLE"."RT_LENGTH_PLUS",
				"RECTANGLE"."RT_LENGTH_MINUS",
         	"RECTANGLE"."RT_WIDTH", 
				"RECTANGLE"."RT_WIDTH_PLUS",
				"RECTANGLE"."RT_WIDTH_MINUS"
    		INTO :id_length, 
			 		:id_length_plus,
			 		:id_length_minus,
         		:id_width,
					:id_width_plus,
					:id_width_minus
    		FROM "RECTANGLE"  
   		WHERE ( "RECTANGLE"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "RECTANGLE"."ORDER_ABC_NUM" = :il_order ) ;
	case "REINFORCEMENT"
		SELECT "REINFORCEMENT"."RE_LENGTH",
				"REINFORCEMENT"."RE_LENGTH_PLUS",
				"REINFORCEMENT"."RE_LENGTH_MINUS",		
        		 "REINFORCEMENT"."RE_WIDTH",
				"REINFORCEMENT"."RE_WIDTH_PLUS",	
				"REINFORCEMENT"."RE_WIDTH_MINUS"	
    		INTO :id_length,
			 		:id_length_plus,
			 		:id_length_minus,
         		:id_width,
					:id_width_plus,
					:id_width_minus
    		FROM "REINFORCEMENT"  
   		WHERE ( "REINFORCEMENT"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "REINFORCEMENT"."ORDER_ABC_NUM" = :il_order ) ;
	case "TRAPEZOID"
		SELECT "TRAPEZOID"."TR_LONG_LENGTH",
				"TRAPEZOID"."TR_LONG_PLUS",
				"TRAPEZOID"."TR_LONG_MINUS",
         	"TRAPEZOID"."TR_WIDTH",
				"TRAPEZOID"."TR_WIDTH_PLUS",
				"TRAPEZOID"."TR_WIDTH_MINUS"
    		INTO :id_length, 
			 		:id_length_plus,
					:id_length_minus, 
         		:id_width,
					:id_width_plus,
					:id_width_minus
    		FROM "TRAPEZOID"  
   		WHERE ( "TRAPEZOID"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "TRAPEZOID"."ORDER_ABC_NUM" = :il_order ) ;
	case "X SHAPE"
		SELECT "X1_SHAPE"."X_2",   
         "X1_SHAPE"."X_1"  
    		INTO :id_length,   
         	:id_width  
    		FROM "X1_SHAPE"  
   		WHERE ( "X1_SHAPE"."ORDER_ITEM_NUM" = :ii_order_item ) AND  
         	( "X1_SHAPE"."ORDER_ABC_NUM" = :il_order ) ;
	case else
		/*statementblock*/
end choose

ll_rc = sqlca.sqlcode
st_gauge.text = string( id_gauge )
st_gauge_plus.text = "+"+string( id_gauge_plus )
st_gauge_minus.text = "-"+string( id_gauge_minus )
st_length.text = string( id_length )
st_length_plus.text = "+"+string( id_length_plus )
st_length_minus.text = "-"+string( id_length_minus )
st_width.text = string( id_width )
st_width_plus.text = "+"+string( id_width_plus )
st_width_minus.text = "-"+string( id_width_minus )

return ll_rc





end function

public function integer of_validate_edit ();double ld_temp
int li_rc
dw_edit.accepttext( )
//dw_edit.accepttext( )
if dw_edit.rowcount( ) <> 1 then
	return 1
end if
//dw_edit.accepttext( )
ld_temp = dw_edit.object.pc_number[1]
if ld_temp < 1 or ld_temp > 99 or isNull(ld_temp ) then
	MessageBox("Data validation", "PC number out of range!")
	return -1
end if

ld_temp = dw_edit.object.gauge[1]
if abs(ld_temp - id_gauge) > id_gauge * 0.15 or isNull(ld_temp ) then
	MessageBox("Data validation", "Gauge out of range!")	
	return -1
elseif	((ld_temp > id_gauge + id_gauge_plus) or (ld_temp < id_gauge - id_gauge_minus)) then
			li_rc = MessageBox("Data validation", "Gauge out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc <> 1 then
				return -1
			end if
end if

ld_temp = dw_edit.object.width[1]
if isNull(ld_temp ) or abs(ld_temp - id_width) > id_width * 0.15  then
	MessageBox("Data validation", "Width out of range!")
	return -1
elseif	((ld_temp > id_width + id_width_plus) or (ld_temp < id_width - id_width_minus)) then
			li_rc = MessageBox("Data validation", "Width out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc <> 1 then
				return -1
			end if		
end if

ld_temp = dw_edit.object.square[1]
if ld_temp < 0 or ld_temp > 9 then
	MessageBox("Data validation", "Square out of range!")
	return -1
end if

ld_temp = dw_edit.object.length_oper[1]
if isNull(ld_temp ) or abs(ld_temp - id_length) > id_length * 0.15 then
	MessageBox("Data validation", "Operator Side length out of range!")
	return -1
elseif	((ld_temp > id_length + id_length_plus) or (ld_temp < id_length - id_length_minus)) then
					li_rc = MessageBox("Data validation", "Operator side lenght out of plus/minus range, do you want to continue?", Question!, YesNo!)
					if li_rc <> 1 then
						return -1
					end if			
end if

ld_temp = dw_edit.object.length_drive[1]
if isNull(ld_temp ) or abs(ld_temp - id_length) > id_length * 0.15 then
	MessageBox("Data validation", "Drive side lenght out of range!")
	return -1
elseif	((ld_temp > id_length + id_length_plus) or (ld_temp < id_length - id_length_minus)) then
			li_rc = MessageBox("Data validation", "Drive side lenght out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc <> 1 then
				return -1
			end if		
end if

return 1
end function

on u_tabpg_skid_dim_check.create
int iCurrent
call super::create
this.st_length_minus=create st_length_minus
this.st_length_plus=create st_length_plus
this.st_width_minus=create st_width_minus
this.st_width_plus=create st_width_plus
this.st_gauge_minus=create st_gauge_minus
this.st_gauge_plus=create st_gauge_plus
this.st_length=create st_length
this.st_width=create st_width
this.st_gauge=create st_gauge
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_edit=create cb_edit
this.cb_cancel=create cb_cancel
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_new=create cb_new
this.st_skid=create st_skid
this.st_1=create st_1
this.dw_edit=create dw_edit
this.dw_skid_dim=create dw_skid_dim
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_length_minus
this.Control[iCurrent+2]=this.st_length_plus
this.Control[iCurrent+3]=this.st_width_minus
this.Control[iCurrent+4]=this.st_width_plus
this.Control[iCurrent+5]=this.st_gauge_minus
this.Control[iCurrent+6]=this.st_gauge_plus
this.Control[iCurrent+7]=this.st_length
this.Control[iCurrent+8]=this.st_width
this.Control[iCurrent+9]=this.st_gauge
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.cb_edit
this.Control[iCurrent+14]=this.cb_cancel
this.Control[iCurrent+15]=this.cb_delete
this.Control[iCurrent+16]=this.cb_save
this.Control[iCurrent+17]=this.cb_new
this.Control[iCurrent+18]=this.st_skid
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.dw_edit
this.Control[iCurrent+21]=this.dw_skid_dim
end on

on u_tabpg_skid_dim_check.destroy
call super::destroy
destroy(this.st_length_minus)
destroy(this.st_length_plus)
destroy(this.st_width_minus)
destroy(this.st_width_plus)
destroy(this.st_gauge_minus)
destroy(this.st_gauge_plus)
destroy(this.st_length)
destroy(this.st_width)
destroy(this.st_gauge)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_edit)
destroy(this.cb_cancel)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_new)
destroy(this.st_skid)
destroy(this.st_1)
destroy(this.dw_edit)
destroy(this.dw_skid_dim)
end on

event constructor;call super::constructor;il_skid = message.doubleparm
this.text = "Skid # " + string( il_skid ) + " dimensional check"
//st_skid.text = string( il_skid )
//dw_skid_dim.of_retrieve( )
of_SetLogicalUnitOfWork (TRUE)
dw_skid_dim.of_SetTransObject(SQLCA)
dw_skid_dim.of_retrieve( )
is_action = ""
if of_init( ) <> 0 then
	MessageBox("skid dim", "Skid #" + string( il_skid ) + " initail error"  )
end if
//dw_skid_dim.sharedata( dw_edit )
end event

event destructor;call super::destructor;//if dw_edit.rowcount( ) = 1 then
//	if MessageBox("Warning", "Data not saved, Do you want to save it?", Question!, YesNo!,1) = 1 then
//		cb_save.event clicked( )
//	end if
//end if

if dw_skid_dim.of_updatespending( ) = 1 then 
		if MessageBox("Warning", "Data not saved, Do you want to save it?", Question!, YesNo!,1) = 1 then
			cb_save.event clicked( )
		end if
end if

end event

type st_length_minus from statictext within u_tabpg_skid_dim_check
integer x = 2304
integer y = 557
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_length_plus from statictext within u_tabpg_skid_dim_check
integer x = 2304
integer y = 480
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_width_minus from statictext within u_tabpg_skid_dim_check
integer x = 1393
integer y = 557
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_width_plus from statictext within u_tabpg_skid_dim_check
integer x = 1393
integer y = 480
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_gauge_minus from statictext within u_tabpg_skid_dim_check
integer x = 472
integer y = 557
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_gauge_plus from statictext within u_tabpg_skid_dim_check
integer x = 472
integer y = 480
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_length from statictext within u_tabpg_skid_dim_check
integer x = 2052
integer y = 522
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type st_width from statictext within u_tabpg_skid_dim_check
integer x = 1148
integer y = 522
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_gauge from statictext within u_tabpg_skid_dim_check
integer x = 216
integer y = 522
integer width = 249
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0.0"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within u_tabpg_skid_dim_check
integer x = 1869
integer y = 525
integer width = 194
integer height = 67
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Length"
boolean focusrectangle = false
end type

type st_3 from statictext within u_tabpg_skid_dim_check
integer x = 969
integer y = 525
integer width = 194
integer height = 67
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Width:"
boolean focusrectangle = false
end type

type st_2 from statictext within u_tabpg_skid_dim_check
integer x = 37
integer y = 522
integer width = 194
integer height = 67
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gauge"
boolean focusrectangle = false
end type

type cb_edit from commandbutton within u_tabpg_skid_dim_check
integer x = 2311
integer y = 653
integer width = 315
integer height = 138
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Edit"
end type

event clicked;long ll_row
ll_row = dw_skid_dim.getselectedrow(0)
if ll_row < 1 then
	MessageBox("Edit data", "Please select dimension data to edit!")
	return 1
end if

if dw_edit.rowcount( ) > 0 then
	MessageBox("Edit data", "Update pending, please save changes first")
	return 1
end if

dw_skid_dim.rowscopy( ll_row, ll_row, Primary!, dw_edit , 1, Primary!)

is_action = "edit"
end event

type cb_cancel from commandbutton within u_tabpg_skid_dim_check
integer x = 2308
integer y = 867
integer width = 315
integer height = 138
integer taborder = 50
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;if dw_edit.rowcount( ) > 0 then
	choose case is_action
		case "edit"
			dw_edit.of_reset( )
			dw_edit.resetupdate( )
		case "new"
			dw_edit.of_reset( )
			dw_edit.resetupdate( )
		case else
			dw_edit.of_reset( )
			dw_edit.resetupdate( )
	end choose
end if

end event

type cb_delete from commandbutton within u_tabpg_skid_dim_check
integer x = 1887
integer y = 867
integer width = 315
integer height = 138
integer taborder = 60
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;//int li_rc
//li_rc = dw_edit.of_validation( )
//
//messageBox("validation", string(li_rc))
//dw_edit.deleterow( 1 )
//dw_edit.resetupdate( )
long ll_row
		ll_row = dw_skid_dim.getselectedrow( 0 )
		if ll_row < 1 then
			MessageBox("Delete item", "No item selected!")
			return 1
		end if
			
		if dw_edit.rowcount( ) > 0 OR dw_skid_dim.of_updatespending( ) = 1 then
			MessageBox("Update pending", "Please save your changes first!")
			return 1
		end if
		
		if MessageBox("Delete item", "Do you want to delete selected record?", Exclamation!, OKCancel!, 2) = 2 then
			return 0
		end if
		if ll_row > 0 then
			dw_skid_dim.deleterow( ll_row)
			
			IF dw_skid_dim.of_Update(TRUE, TRUE) = 1 THEN
				SQLCA.of_Commit()
			ELSE
				MessageBox( "Delete function", "Failed saving data!", StopSign!  )
				SQLCA.of_Rollback()
			END IF
			
//			ll_row = dw_skid_dim.getrow( )
			
//			if ll_row > 0 then
//				//dw_skid_dim.setrow( ll_row)
//				dw_skid_dim.selectrow( 0, false)
//				dw_skid_dim.selectrow( ll_row, true)
//				dw_edit.scrolltorow( ll_row)
//			end if
		end if
end event

type cb_save from commandbutton within u_tabpg_skid_dim_check
integer x = 1887
integer y = 1088
integer width = 731
integer height = 138
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;long ll_row, ll_dim_id, ll_seq
int li_rc
if dw_edit.rowcount( ) > 0 then
	dw_edit.accepttext( )
	
	li_rc = of_validate_edit( )
	
	if  li_rc <> 1 then
		return 1
	end if
	
	choose case is_action
		case "edit"
			ll_dim_id = dw_edit.object.dimension_check_num[1]
			ll_row = dw_skid_dim.find( "dimension_check_num="+string(ll_dim_id), 1, dw_skid_dim.rowcount( ) )
			dw_skid_dim.object.Data[ll_row] = dw_edit.Object.data[1]
		case "new"
			
			SELECT sheet_skid_dimension_check_seq.NEXTVAL INTO :ll_seq FROM DUAL;
			if sqlca.sqlcode <> 0 then
				MessageBox("Database error", "Can not get dimension check seq!")
				return 1
			end if
			
			ll_row = dw_skid_dim.insertrow( 0 )
			dw_skid_dim.object.data[ll_row] = dw_edit.object.data[1]
			dw_skid_dim.object.dimension_check_num[ll_row] = ll_seq
			
		case else
			//
	end choose
end if


//int li_rc
//
//if il_current_row > 0 then
//	li_rc = of_validate_row( il_current_row )
//else
//	li_rc = 1
//end if

li_rc = 1
if li_rc = 1 then
	IF dw_skid_dim.of_Update(TRUE, TRUE) = 1 THEN
		SQLCA.of_Commit()
		dw_edit.of_reset( )
		dw_edit.resetupdate( )
	ELSE
		MessageBox( "Save function", "Failed saving data!", StopSign!  )
		SQLCA.of_Rollback()
	END IF
else
	MessageBox("Data error", "There is invalid data in editor. Please double check!", StopSign!)
end if
end event

type cb_new from commandbutton within u_tabpg_skid_dim_check
integer x = 1887
integer y = 653
integer width = 315
integer height = 138
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "New"
end type

event clicked;long ll_row, ll_rc, ll_pc, ll_i, ll_seq


if il_skid < 1000 then
	MessageBox("Invald skid", "No skid available!")
	return 1
end if

//if dw_skid_dim.of_updatespending( ) = 1 then
//	MessageBox("Update pending", "Please save your changes first!")
//	return 1
//end if

if dw_edit.rowcount( ) > 0 then
	MessageBox("Update pending", "Please save your changes first!")
	return 1
end if

//SELECT sheet_skid_dimension_check_seq.NEXTVAL INTO :ll_seq FROM DUAL;

	ll_rc = dw_skid_dim.rowcount( )
	if ll_rc < 1 then
		ll_pc = 1
	elseif ll_rc = 1 then
		ll_pc = dw_skid_dim.object.pc_number[1] + 1
	else
		ll_pc = dw_skid_dim.object.pc_number[1]
		for ll_i=1 to ll_rc
			if dw_skid_dim.object.pc_number[ll_i] > ll_pc then
				ll_pc = dw_skid_dim.object.pc_number[ll_i]
			end if
		next
		ll_pc = ll_pc +1
	end if

ll_row = dw_edit.insertrow( 0 )
dw_edit.object.sheet_skid_num[ll_row] = il_skid
dw_edit.object.pc_number[ll_row] = ll_pc
dw_edit.object.dimension_check_num[ll_row] = ll_seq
dw_edit.object.gauge[ll_row] = 0
dw_edit.object.width[ll_row] = 0
dw_edit.object.all_cut_edge[ll_row] = 0
dw_edit.object.in_spec[ll_row] = 0
is_action = "new"
//if dw_skid_dim.setrow(ll_row) = 1 then
//	dw_edit.scrolltorow( ll_row )
//	dw_skid_dim.selectrow( 0, false)
//	dw_skid_dim.selectrow( ll_row, true)
//end if

//			DWItemStatus ldw_status
//			ldw_status = dw_skid_dim.getitemstatus( ll_row, 0, Primary!)
//			dw_skid_dim.setitemstatus( ll_row, 0, Primary!, NotModified!)
//			ldw_status = dw_skid_dim.getitemstatus( ll_row, 0, Primary!)
			

//ll_row = dw_edit.rowcount( )
//if ll_row > 0 then
//	MessageBox("Warning", "Please save the data first", Stopsign!)
//	return 1
//end if
//	ll_row = dw_edit.insertrow( 0 )
//	dw_edit.object.sheet_skid_num[ll_row] = il_skid
//	
//	ll_rc = dw_skid_dim.rowcount( )
//	if ll_rc < 1 then
//		ll_pc = 1
//	elseif ll_rc = 1 then
//		ll_pc = dw_skid_dim.object.pc_number[1] + 1
//	else
//		ll_pc = dw_skid_dim.object.pc_number[1]
//		for ll_i=1 to ll_rc
//			if dw_skid_dim.object.pc_number[ll_i] > ll_pc then
//				ll_pc = dw_skid_dim.object.pc_number[ll_i]
//			end if
//		next
//		ll_pc = ll_pc +1
//	end if
//		
//	dw_edit.object.pc_number[ll_row] = ll_pc
//	
end event

type st_skid from statictext within u_tabpg_skid_dim_check
boolean visible = false
integer x = 366
integer y = 42
integer width = 410
integer height = 67
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within u_tabpg_skid_dim_check
boolean visible = false
integer x = 73
integer y = 42
integer width = 219
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Skid #"
boolean focusrectangle = false
end type

type dw_edit from u_dw within u_tabpg_skid_dim_check
integer x = 48
integer y = 637
integer width = 1785
integer height = 640
integer taborder = 20
string dataobject = "d_skid_dim_check"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalculator(TRUE)
this.iuo_calculator.of_Register("gauge", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("width", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("square", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("length_oper", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("length_drive", &
this.iuo_calculator.NONE)
this.iuo_calculator.of_Register("head_dimension", &
this.iuo_calculator.NONE)

this.iuo_calculator.of_SetCloseOnClick(True)
this.iuo_calculator.of_SetInitialValue(TRUE)
this.of_setbase( true)
this.of_settransobject( sqlca)
end event

event itemchanged;call super::itemchanged;double ld_temp
int li_rc

ld_temp = double(data)

CHOOSE CASE Lower(dwo.Name)
  	CASE "pc_number"
		if ld_temp < 1 or ld_temp > 99 or isNull(ld_temp ) then
			MessageBox("Data validation", "PC number out of range!")
			return 1
		end if
	CASE "gauge"
		if abs(ld_temp - id_gauge) > id_gauge * 0.15 then
			MessageBox("Data validation", "Gauge out of range!")
			return 1
		elseif	((ld_temp > id_gauge + id_gauge_plus) or (ld_temp < id_gauge - id_gauge_minus)) then
			li_rc = MessageBox("Data validation", "Gauge out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc = 1 then
				return 0
			else 
				return 1	
			end if
		end if
	CASE "width"
		if abs(ld_temp - id_width) > id_width * 0.15 then
			MessageBox("Data validation", "Width out of range!")
			return 1
		elseif	((ld_temp > id_width + id_width_plus) or (ld_temp < id_width - id_width_minus)) then
			li_rc = MessageBox("Data validation", "Width out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc = 1 then
				return 0
			else 
				return 1	
			end if	
		end if
	CASE "square"
			if ld_temp < 0 or ld_temp > 9 then
				MessageBox("Data validation", "Square out of range!")
				return 1
			end if
	CASE "length_oper"
				if abs(ld_temp - id_length) > id_length * 0.15 then
					MessageBox("Data validation", "Operator side length out of range!")
					return 1
				elseif	((ld_temp > id_length + id_length_plus) or (ld_temp < id_length - id_length_minus)) then
					li_rc = MessageBox("Data validation", "Operator side lenght out of plus/minus range, do you want to continue?", Question!, YesNo!)
					if li_rc = 1 then
						return 0
					else 
				return 1	
			end if		
				end if
	CASE "length_drive"
		if abs(ld_temp - id_length) > id_length * 0.15 then
			MessageBox("Data validation", "Drive side lenght out of range!")
			return 1
		elseif	((ld_temp > id_length + id_length_plus) or (ld_temp < id_length - id_length_minus)) then
			li_rc = MessageBox("Data validation", "Drive side lenght out of plus/minus range, do you want to continue?", Question!, YesNo!)
			if li_rc = 1 then
				return 0
			else 
				return 1	
			end if	
		end if
END CHOOSE

return 0
end event

event itemerror;call super::itemerror;return 1
end event

event rowfocuschanging;call super::rowfocuschanging;//if currentrow > 0 and of_updatespending( ) = 1 then
//		MessageBox("Data changed", "Please save changes first!") 
//		return 1
//end if
//return 0
end event

type dw_skid_dim from u_dw within u_tabpg_skid_dim_check
integer x = 48
integer y = 61
integer width = 2586
integer height = 413
integer taborder = 10
string dataobject = "d_dim_per_skid"
end type

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve( il_skid )
end event

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
//this.of_SetRowManager(TRUE)
//this.of_SetSort(TRUE)

end event

event clicked;call super::clicked;if row > 0 and dw_edit.rowcount( ) < 1 then
	if this.setrow( row) = 1 then
//		dw_edit.scrolltorow( row )
		this.selectrow( 0, false)
		this.selectrow( row, true)
	end if
//	MessageBox("test", string( this.of_updatespending( ) ))
end if
end event

event rowfocuschanged;call super::rowfocuschanged;//MessageBox("dw_skid_dim row changed", string(currentrow) )
//if this.of_updatespending( ) = 1 then
//	MessageBox("Data changed", "New data will be saved!")
//	parent.cb_save.event clicked( )
//end if
il_current_row = currentrow
end event

event rowfocuschanging;call super::rowfocuschanging;//MessageBox("row focus changing", string(currentrow) + "-" + string(newrow))
//dw_edit.accepttext( )
//if currentrow > 0 and of_updatespending( ) = 1 then
//		MessageBox("Data changed", "Please save changes first!") 
//		return 1
//end if
//return 0
end event

event doubleclicked;call super::doubleclicked;
if row > 0 and dw_edit.rowcount( ) < 1 then
	dw_skid_dim.rowscopy( row, row, Primary!, dw_edit , 1, Primary!)
	is_action = "edit"
end if
end event

