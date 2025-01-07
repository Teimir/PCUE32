module vga_top
# (
    parameter N_MIXER_PIPE_STAGES = 0,

              HPOS_WIDTH          = 10,
              VPOS_WIDTH          = 10,

              // Horizontal constants

              H_DISPLAY           = 640,  // Horizontal display width
              H_FRONT             =  16,  // Horizontal right border (front porch)
              H_SYNC              =  96,  // Horizontal sync width
              H_BACK              =  48,  // Horizontal left border (back porch)

              // Vertical constants

              V_DISPLAY           = 480,  // Vertical display height
              V_BOTTOM            =  10,  // Vertical bottom border
              V_SYNC              =   2,  // Vertical sync # lines
              V_TOP               =  33,  // Vertical top border

              CLK_MHZ             =  50,  // Clock frequency (50 or 100 MHz)
              PIXEL_MHZ           =  25   // Pixel clock frequency of VGA in MHz
)
(
    input                           clk,
    input                           rst,
    output                          r,
    output                          g,
    output                          b,
);

logic [2:0] video_ram [640][480];

vga VGA_GEN
(
    .clk            (clk),
    .rst            (rst),
    .hsync          (hsync),
    .vsync          (vsync),
    .display_on     (display_on),
    .hpos           (hpos),
    .vpos           (vpos),
    .pixel_clk      (pixel_clk)
);

endmodule