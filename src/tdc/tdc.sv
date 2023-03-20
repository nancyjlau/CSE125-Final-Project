module tdc (
  input logic clk,
  input logic reset,
  input logic [7:0] uart_data,
  output logic [31:0] t,
  output logic [31:0] clock_cycles
);

  logic [31:0] counter;
  logic [31:0] time_latch;
  logic [7:0] uart_data_prev;

  always_ff @(posedge clk) begin
    if (reset) begin
      counter <= 32'd0;
      time_latch <= 32'd0;
      uart_data_prev <= 8'b0;
    end else begin
      if (uart_data != 8'b0) begin
        counter <= counter + 32'd1;
      end else if (uart_data_prev != 8'b0) begin
        time_latch <= counter;
        counter <= 32'd0;
      end
      uart_data_prev <= uart_data;
    end
  end
  
  // t represents time from between consecutive rising edges of uart_data
  // time_latch captures value of counter at each rising edge of uart_data
  assign t = time_latch;
  assign clock_cycles = t;

endmodule
