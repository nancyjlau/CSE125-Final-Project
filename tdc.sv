`timescale 1ns / 1ps
module tdc #(parameter num_stages = 5)
(
  input logic clk,
  input logic reset,
  input logic [7:0] uart_data,
  output logic [4:0] stage_delays
);

  logic [4:0] delay_line;
  /* verilator lint_off WIDTH */
  // measure delay between input pulse signal and UART data signal 
  always_ff @(posedge clk) begin
    if (reset) begin
      delay_line <= 5'b0;
    end else begin
      delay_line <= {delay_line[3:0], uart_data};
    end
  end
  // save stage_delays to delay_line
  always_ff @(posedge clk) begin
    if (reset) begin
      stage_delays <= '0;
    end else begin
      for (int i = 0; i < num_stages; i++) begin
          stage_delays[i] <= delay_line[i];
      end
    end
  end

endmodule
