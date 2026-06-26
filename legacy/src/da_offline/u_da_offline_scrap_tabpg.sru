$PBExportHeader$u_da_offline_scrap_tabpg.sru
forward
global type u_da_offline_scrap_tabpg from u_da_scrap_tabpg
end type
end forward

global type u_da_offline_scrap_tabpg from u_da_scrap_tabpg
end type
global u_da_offline_scrap_tabpg u_da_offline_scrap_tabpg

on u_da_offline_scrap_tabpg.create
call super::create
end on

on u_da_offline_scrap_tabpg.destroy
call super::destroy
end on

type cb_reset_pcs from u_da_scrap_tabpg`cb_reset_pcs within u_da_offline_scrap_tabpg
end type

type em_offset from u_da_scrap_tabpg`em_offset within u_da_offline_scrap_tabpg
end type

type cb_retrieve from u_da_scrap_tabpg`cb_retrieve within u_da_offline_scrap_tabpg
end type

type cb_edit from u_da_scrap_tabpg`cb_edit within u_da_offline_scrap_tabpg
end type

type cb_new from u_da_scrap_tabpg`cb_new within u_da_offline_scrap_tabpg
end type

type cb_scrap_print from u_da_scrap_tabpg`cb_scrap_print within u_da_offline_scrap_tabpg
end type

type cb_save from u_da_scrap_tabpg`cb_save within u_da_offline_scrap_tabpg
end type

type cb_delete_item from u_da_scrap_tabpg`cb_delete_item within u_da_offline_scrap_tabpg
end type

type cb_pallet from u_da_scrap_tabpg`cb_pallet within u_da_offline_scrap_tabpg
end type

type cb_change_type from u_da_scrap_tabpg`cb_change_type within u_da_offline_scrap_tabpg
boolean visible = false
boolean enabled = false
end type

type cb_read_scale from u_da_scrap_tabpg`cb_read_scale within u_da_offline_scrap_tabpg
end type

type dw_scrap from u_da_scrap_tabpg`dw_scrap within u_da_offline_scrap_tabpg
end type

type dw_current_quality_scrap from u_da_scrap_tabpg`dw_current_quality_scrap within u_da_offline_scrap_tabpg
end type

event dw_current_quality_scrap::itemchanged;return 0
end event

type st_7 from u_da_scrap_tabpg`st_7 within u_da_offline_scrap_tabpg
end type

