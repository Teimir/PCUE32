module top (
    input clk
);

vga VGA_GEN
(
    .clk,
    .rst,
    .hsync,
    .vsync,
    .display_on,
    .hpos,
    .vpos,
    .pixel_clk
);


endmodule