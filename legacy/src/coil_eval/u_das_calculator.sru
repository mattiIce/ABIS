$PBExportHeader$u_das_calculator.sru
forward
global type u_das_calculator from u_calculator
end type
end forward

global type u_das_calculator from u_calculator
integer width = 574
integer height = 723
end type
global u_das_calculator u_das_calculator

on u_das_calculator.create
call super::create
end on

on u_das_calculator.destroy
call super::destroy
end on

type dw_calculator from u_calculator`dw_calculator within u_das_calculator
integer width = 578
integer height = 723
end type

