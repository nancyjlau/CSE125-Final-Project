module tdc (#parameter num_stages = 5)(
  input logic clk,
  input logic reset,
  input logic [7:0] uart_data,
  output logic [4:0] stage_delays
);

  logic [4:0] delay_line;
  
  // measure delay between input pulse signal and UART data signal 
  always_ff @(posedge clk) begin
    if (reset) begin
      delay_line <= '0;
    end else begin
      delay_line[4:1] <= delay_line[3:0];
      delay_line[0] <= uart_data;
    end
  end

  // save stage_delays to delay_line
  always_ff @(posedge clk) begin
    for (int i = 0; i < num_stages; i++) begin
        stage_delays[i] <= delay_line[i];
    end
  end

  // at reset, stage_delays should be 0
  assign stage_delays[4:0] = reset ? '0 : stage_delays[4:0];

endmodule
