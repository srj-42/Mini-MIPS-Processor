// Simple unified memory block containing 256 words (32-bit width).
// Supports standard reads, full-word writes, and subword writes.
`timescale 1ns / 1ps
`include "defs.vh"

module Memory(
    input reset,
    input clk,
    input [1:0] mem_command,
    input [7:0] addr,           
    input [31:0] write_data,
    output [31:0] read_data 
);

    reg [31:0] mem_array [0:255]; // 256 words of memory
    integer i;

    // Continuous read based on address
    assign read_data = mem_array[addr];

    // Sequential write and reset logic
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) begin
                mem_array[i] <= 32'b0;
            end
        end
        else begin
            // Subword writes also perform a full 32-bit write because the subword merging
            // is handled combinationally upstream in the Processor module.
            case (mem_command)
                `WRITE_COMMAND:         mem_array[addr] <= write_data;
                `SUBWORD_WRITE_COMMAND: mem_array[addr] <= write_data;
            endcase
        end
    end

endmodule