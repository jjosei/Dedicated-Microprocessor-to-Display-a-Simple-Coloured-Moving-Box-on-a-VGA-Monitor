
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name VGA_MOVING_BOX -dir "/home/jesse/VGA_ADAPTER_MOVING BOX/VGA_MOVING_BOX/planAhead_run_3" -part xc3s200ft256-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "moving_box.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {V_FSM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Velevenbitcounter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {H_FSM.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Helevenbitcounter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {c2counter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {c1counter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {b2counter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {b1counter.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {moving_box.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top moving_box $srcset
add_files [list {moving_box.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s200ft256-4
