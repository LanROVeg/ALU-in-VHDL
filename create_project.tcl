# Recreate from portable sources in Vivado 2024.2 or later.
set repo [file dirname [file normalize [info script]]]
set work [file join $repo .vivado-work]
if {[file exists [file join $work alu_demo.xpr]]} {
    open_project [file join $work alu_demo.xpr]
} else {
    create_project alu_demo $work -part xc7a35tcpg236-1
    add_files [list [file join $repo {Project 1.srcs/sources_1/new/Adder_8b.vhd}] [file join $repo {Project 1.srcs/sources_1/new/ALU.vhd}]]
    add_files -fileset sim_1 [list [file join $repo {Project 1.srcs/sim_1/new/Adder_8b_tb.vhd}] [file join $repo {Project 1.srcs/sim_1/new/ALU_tb.vhd}]]
}
set_property file_type {VHDL 2008} [get_files *.vhd]
set_property top ALU [get_filesets sources_1]
set_property top ALU_tb [get_filesets sim_1]
set_property xsim.simulate.runtime all [get_filesets sim_1]
puts {Project ready. Run behavioral simulation; the exhaustive bench runs to completion.}
