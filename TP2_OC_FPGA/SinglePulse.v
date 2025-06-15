module SinglePulse (
    input wire clk,         
    input wire trigger_in,  
    output reg pulse_out    
);

    reg prev_trigger_in;

    initial begin
        pulse_out = 1'b0;
        prev_trigger_in = 1'b0;
    end

    always @(posedge clk) begin
        prev_trigger_in <= trigger_in;
        if (trigger_in && ~prev_trigger_in) begin
            pulse_out <= 1'b1;
        end else begin
            pulse_out <= 1'b0;
        end
    end

endmodule