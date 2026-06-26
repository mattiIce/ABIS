$PBExportHeader$w_ejob_frame.srw
forward
global type w_ejob_frame from w_da_frame
end type
end forward

global type w_ejob_frame from w_da_frame
string title = "E-Job folder"
end type
global w_ejob_frame w_ejob_frame

on w_ejob_frame.create
call super::create
end on

on w_ejob_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

