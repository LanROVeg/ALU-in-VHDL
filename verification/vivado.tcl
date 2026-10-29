set repo [file dirname [file dirname [file normalize [info script]]]]
source [file join $repo create_project.tcl]
foreach top {Adder_8b_tb ALU_tb} {
    set_property top $top [get_filesets sim_1]
    launch_simulation -simset sim_1 -mode behavioral
    close_sim
}
close_project
exit
