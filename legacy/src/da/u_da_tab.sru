$PBExportHeader$u_da_tab.sru
forward
global type u_da_tab from u_tab
end type
end forward

global type u_da_tab from u_tab
string tag = "da tag page"
integer width = 2812
integer height = 1731
integer textsize = -10
integer weight = 700
string facename = "Arial"
long backcolor = 67108864
event ue_close_u_causes ( )
end type
global u_da_tab u_da_tab

type variables
olecustomcontrol iole_opc
end variables

forward prototypes
public subroutine of_set_opc (readonly olecustomcontrol ao_opc)
end prototypes

public subroutine of_set_opc (readonly olecustomcontrol ao_opc);iole_opc = ao_opc
end subroutine

