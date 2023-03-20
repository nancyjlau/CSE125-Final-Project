# Makefile

IVERILOG ?= iverilog
VERILATOR ?= verilator
ICEPROG ?= iceprog
ICEPACK ?= icepack
ICETIME ?= icetime
NEXTPNR ?= nextpnr-ice40
YOSYS ?= yosys

help:
	@echo "make [help|lint|test|all|bitstream|prog]"
	@echo "  help: Print this message."
	@echo "  lint: Run the Verilator linter on all source files."

lint:
	$(VERILATOR) --lint-only -sv --timing encoder.sv -I.

.PHONY: $(ISIM_LOG) help lint