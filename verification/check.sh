#!/usr/bin/env bash
set -euo pipefail
cd "$(mktemp -d)"
ghdl -a --std=08 "/src/Project 1.srcs/sources_1/new/Adder_8b.vhd" "/src/Project 1.srcs/sources_1/new/ALU.vhd" "/src/Project 1.srcs/sim_1/new/Adder_8b_tb.vhd" "/src/Project 1.srcs/sim_1/new/ALU_tb.vhd"
ghdl -e --std=08 Adder_8b_tb
ghdl -r --std=08 Adder_8b_tb --assert-level=error
ghdl -e --std=08 ALU_tb
ghdl -r --std=08 ALU_tb --assert-level=error
echo "PASS: all self-checking testbenches"
