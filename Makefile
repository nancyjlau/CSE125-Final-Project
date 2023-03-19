# CSE x25 Lab 1, Part 1
# If you have iverilog or verilator installed in a non-standard path,
# you can override these to specify the path to the executable.
IVERILOG ?= iverilog
VERILATOR ?= verilator

## DO NOT MODIFY ANYTHING BELOW THIS LINE

# We will always provide these six targets:
help:
	@echo "make [help|lint|test|all]"
	@echo "  help: Print this message."
	@echo "  lint: Run the Verilator linter on all source files."
	@echo "  test: Run all testbenches and generate the simulation log files."
	@echo "  all: Run the lint target, and if it passes, run the test target."
	@echo "  clean: Remove all compiler outputs."
	@echo "  extraclean: Remove all generated files (runs clean)."
	@echo ""
	@echo "  Optional Variables:"
	@echo "    IVERILOG: Override this variable on the CLI to set the location of your Icarus Verilog executable."
	@echo "    VERILATOR: Override this variable on the CLI to set the location of your Verilator  executable."

# lint runs the Verilator linter on your code. 
lint:
	$(VERILATOR) --lint-only -sv --timing tb_tdc.sv -I.

# test runs the simulation logs that you will check into git
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

.PHONY: $(ISIM_LOG) help lint test all clean extraclean
