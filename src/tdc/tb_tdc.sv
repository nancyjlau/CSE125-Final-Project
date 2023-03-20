`timescale 1ns/1ps

module tb_tdc();

  logic clk;
  logic reset;
  logic [7:0] uart_data;
  logic [31:0] t_1;
  logic [31:0] clock_cycles;

  tdc tdc_inst (
    .clk(clk),
    .reset(reset),
    .uart_data(uart_data),
    .t(t_1),
    .clock_cycles(clock_cycles)
  );

  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 0;
    reset = 1;
    $display(" _______________________");
    $display("|                       |");
    $display("| Resetting the TDC...  |");
    $display("|_______________________|");

    uart_data = 8'b00000000;
    #10 reset = 0;

    $display(" _______________________");
    $display("|                       |");
    $display("| Reset complete...     |");
    $display("|_______________________|");

    #50 uart_data = 8'b00000000;
    #10

    #50 uart_data = 8'b00000001;
    #10

    #50 uart_data = 8'b00000010;
    #10

    #50 uart_data = 8'b00000000;
    #10

    #50 $finish;
  end

  // time is for time elapsed between consecutive rising edges of uart_data signal
  initial begin
    $monitor("At time %t, uart_data = %b, time = %t, clock_cycles = %d",
             $time, uart_data, t_1, clock_cycles);
  end

endmodule
