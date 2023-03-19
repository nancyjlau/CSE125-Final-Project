# Makefile

IVERILOG ?= iverilog
VERILATOR ?= verilator
ICEPROG ?= iceprog
ICEPACK ?= icepack
ICETIME ?= icetime
NEXTPNR ?= nextpnr-ice40
YOSYS ?= yosys

PCF_PATH = icebreaker.pcf

help:
	@echo "make [help|lint|test|all|bitstream|program]"
	@echo "  help: Print this message."
	@echo "  lint: Run the Verilator linter on all source files."
	@echo "  test: Run all testbenches and generate the simulation log files."
	@echo "  all: Run the lint target, and if it passes, run the test target."
	@echo "  bitstream: Generate the bitstream for the iCEbreaker FPGA."
	@echo "  program: Program the iCEbreaker FPGA with the bitstream."
	@echo "  clean: Remove all compiler outputs."
	@echo "  extraclean: Remove all generated files (runs clean)."
	@echo ""
	@echo "  Optional Variables:"
	@echo "    IVERILOG: Override this variable on the CLI to set the location of your Icarus Verilog executable."
	@echo "    VERILATOR: Override this variable on the CLI to set the location of your Verilator  executable."

# lint runs the Verilator linter 
lint:
	$(VERILATOR) --lint-only -sv --timing tb_tdc.sv -I.

# test runs the simulation logs 
test: iverilog.log

# all runs the lint target, and if it passes, the test target
all: lint test

# Icarus Verilog (iverilog) Commands: 
ISIM_EXE := iverilog-tb
ISIM_LOG := iverilog.log
ISIM_WAV := iverilog.vcd
$(ISIM_EXE): tdc.sv tb_tdc.sv
	$(IVERILOG) -g2005-sv -o $(ISIM_EXE) tdc.sv tb_tdc.sv 

$(ISIM_LOG): $(ISIM_EXE)
	./$(ISIM_EXE) | tee iverilog.log
	echo "Current System Time is: $(shell date +%X--%x)" >> iverilog.log

# Remove all compiler outputs
clean:
	rm -f $(ISIM_EXE)

# Remove all generated files
extraclean: clean
	rm -f $(ISIM_LOG)
	rm -f $(ISIM_WAV)

bitstream: tdc.bin

tdc.json: tdc.v
	$(YOSYS) -p 'synth_ice40 -top tdc -json tdc.json' tdc.v

tdc.asc: tdc.json icebreaker.pcf
	$(NEXTPNR) --up5k --package sg48 --json tdc.json --pcf

prog: top.bin
	$(ICEPROG) $<

top.json: top.sv $(SYNTH_SOURCES)
	$(YOSYS) -p 'synth_ice40 -top top -json $@' $<

.PHONY: $(ISIM_LOG) help lint test all clean extraclean bitstream program
