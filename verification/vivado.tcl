set repo [file dirname [file dirname [file normalize [info script]]]]
source [file join $repo create_project.tcl]
# The simulation top is a testbench, not the ALU synthesis top.
foreach top {Adder_8b_tb ALU_tb} {
    set_property top $top [get_filesets sim_1]
    launch_simulation -simset sim_1 -mode behavioral
    set handle [open [file join $work alu_demo.sim sim_1 behav xsim simulate.log] r]
    set output [read $handle]
    close $handle
    # XSim can stop on an assertion without making launch_simulation fail.
    if {![string match "*PASS: *exhaustive binary cases*" $output]} {
        error "$top did not reach its final pass report; check simulate.log"
    }
    close_sim
}
close_project
exit
