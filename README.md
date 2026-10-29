# APB-Protocol-
# APB Protocol Verification

## Project Overview
This project focuses on verifying an AMBA Advanced Peripheral Bus (APB) slave using Verilog-Based testbench.

## Objectives
- Understand APB Setup and Access phases.
- Perform read and write transactions.
- Verify address and data handling.
- Check whether written data can be read back correctly.

## Protocol Signals
- `PCLK` — APB clock
- `PRESETn` — Active-low reset
- `PSEL` — Peripheral select
- `PENABLE` — Indicates the Access phase
- `PWRITE` — Selects read or write operation
- `PADDR` — Address bus
- `PWDATA` — Write data bus
- `PRDATA` — Read data bus
- `PREADY` — Indicates transfer completion

## Testbench Approach
1. Generate the clock and reset.
2. Generate address and data values.
3. Perform APB write transactions.
4. Read from the same addresses.
5. Compare the read data against the expected written data.

## Tools Used
- Verilog / SystemVerilog
- QuestaSim / ModelSim

## Project Structure
- `rtl/` — APB slave design
- `testbench/` — Testbench source code and simulation script
- `docs/` — Simulation screenshots and waveforms

## Simulation Results
Simulation screenshots and waveforms will be added here after verification.

## Future Improvements
- Add SystemVerilog Assertions (SVA).
- Extend verification using UVM.
- Add additional APB protocol checks and test scenarios.

