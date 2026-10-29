#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
docker build -t lanroveg/alu-vhdl:local verification
docker run --rm --network none --mount "type=bind,source=$PWD,target=/src,readonly" lanroveg/alu-vhdl:local bash /src/verification/check.sh
