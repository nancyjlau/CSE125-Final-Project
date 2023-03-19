`timescale 1ns / 1ps

module tb_tdc();

  // Define parameters and signals
  parameter num_stages = 5;
  reg clk;
  reg reset;
  reg [7:0] uart_data;
  wire [4:0] stage_delays;

  // Instantiate the tdc module
  tdc #(.num_stages(num_stages)) dut (
    .clk(clk),
    .reset(reset),
    .uart_data(uart_data),
    .stage_delays(stage_delays)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    uart_data = 8'b0;

    // Apply reset
    #10 reset = 0;
    
    // Send uart_data
    #10 uart_data = 8'b10101010;
    #10 uart_data = 8'b11001100;
    #10 uart_data = 8'b11110000;
    #10 uart_data = 8'b00001111;
    #10 uart_data = 8'b00110011;
    
    // Apply reset again
    #10 reset = 1;
    #10 reset = 0;

    // Send more uart_data
    #10 uart_data = 8'b01010101;
    #10 uart_data = 8'b10101010;

    // Finish the simulation
    #10 $finish;
  end

  // Monitor the stage_delays
  initial begin
    $monitor("Time: %t stage_delays: %b", $time, stage_delays);
  end

  // Waveform 
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_tdc);
  end

endmodule
