$PBExportHeader$u_da_tabpg.sru
forward
global type u_da_tabpg from u_tabpg
end type
end forward

global type u_da_tabpg from u_tabpg
integer width = 3727
integer height = 1702
end type
global u_da_tabpg u_da_tabpg

type variables
string is_title
w_da_sheet iw_sheet
end variables

forward prototypes
public subroutine of_init (readonly w_da_sheet aw_1)
end prototypes

public subroutine of_init (readonly w_da_sheet aw_1);iw_sheet = aw_1
end subroutine

on u_da_tabpg.create
call super::create
end on

on u_da_tabpg.destroy
call super::destroy
end on

event constructor;call super::constructor;//this.text = is_title
end event

