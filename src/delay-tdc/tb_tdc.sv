`timescale 1ns / 1ps

module tb_tdc();

  // Define parameters and signals
  parameter num_stages = 10;
  reg clk;
  reg reset;
  reg [7:0] uart_data;
  wire [num_stages-1:0] stage_delays;

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
    $display(" _______________________");
    $display("|                       |");
    $display("| Resetting the TDC...  |");
    $display("|_______________________|");
    uart_data = 8'b0;

    // Apply reset
    #10 reset = 0;
    $display(" _______________________");
    $display("|                       |");
    $display("| Reset complete...     |");
    $display("|_______________________|");
    
    // Send uart_data
    #20 uart_data = 8'b10101010;
    $display("                                             ");
    $display("Time: %t --------> Sent uart_data: %b", $time, uart_data);
    $display("                                             ");
    #20 uart_data = 8'b11001100;
    $display("                                             ");
    $display("Time: %t --------> Sent uart_data: %b", $time, uart_data);
    $display("                                             ");
    #20 uart_data = 8'b11110000;
    $display("                                             ");
    $display("Time: %t --------> Sent uart_data: %b", $time, uart_data);
    $display("                                             ");
    #20 uart_data = 8'b00001111;
    $display("                                             ");
    $display("Time: %t --------> Sent uart_data: %b", $time, uart_data);
    $display("                                             ");
    #20 uart_data = 8'b00110011;
    $display("                                             ");
    $display("Time: %t --------> Sent uart_data: %b", $time, uart_data);
    $display("                                             ");
    
    // Apply reset again
    #20 reset = 1;
    $display(" _______________________");
    $display("|                       |");
    $display("| Resetting the TDC...  |");
    $display("|_______________________|");

    #10 reset = 0;
    $display(" _______________________");
    $display("|                       |");
    $display("| Reset complete...     |");
    $display("|_______________________|");

    // Send more uart_data
    #20 uart_data = 8'b01010101;
    $display("                                             ");
    $display("Time: %t --------> Sent uart_data: %b", $time, uart_data);
    $display("                                             ");
    #20 uart_data = 8'b10101010;
    $display("                                             ");
    $display("Time: %t --------> Sent uart_data: %b", $time, uart_data);
    $display("                                             ");

    // Finish the simulation
    #20 $finish;
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
