module core(
    input            clk,
    input  [31:0] DataIn,
    output [31:0] Address,
    output [31:0] DataOut
);

logic [4:0]  state         = '0;
logic [31:0] instr         = '0;

logic [31:0] alu_flags     = '0; // eq, a > b, carry, zero, sign
logic [31:0] alu_res       = '0;

logic        intr_mask_f   = '0;
logic [31:0] intr_mask     = '0;


wire  [6:0]  op_code     = instr[6:0];
wire  [31:0] alu_pre_res;
wire  [31:0] alu_pre_flags;
wire  [31:0] alu_a;
wire  [31:0] alu_b;

logic [31:0] regis_file [32];


//Выбор входов на алу
always_comb begin
    case(op_code[1:0])
        2'd0: begin
            alu_a <= regis_file[instr[17:13]];
            alu_b <= regis_file[instr[22:18]];
        end
        2'd1: begin
            alu_a <= regis_file[instr[17:13]];
            alu_b <= {{32{1'b0}}, instr[31:18]};
        end
        2'd2: begin
            alu_a <= regis_file[instr[17:13]];
            alu_b <= {{32{1'b0}}, instr[31:13]};
        end
        2'd3: begin
            alu_a <= regis_file[instr[17:13]];
            alu_b <= {instr[31], {21{1'b0}}, instr[31:18]};
        end
    endcase
end


// Переключалка стейтов
always_ff @( posedge clk ) begin
    case (state)
        4'd0: state <= 4'd1; 
        4'd1: state <= 4'd2;
        4'd2: state <= 4'd3;
        4'd3: state <= 4'd0;
    endcase
end

//Cчитывание инструкции
always_ff @(posedge clk) begin
    if (state == 4'd0) instr <= DataIn;
end


//Сохранение результатов
always_ff @( posedge clk ) begin
    if (state == 4'd1)  begin 
        alu_res   <= alu_pre_res;
        if (!op_code[6]) alu_flags <= alu_pre_flags;
    end   
end

//Комбинационная схема алу
always_comb begin
    alu_pre_flags[2] = '0;
    case (op_code[5:2])
        4'd0:  {alu_pre_flags[2], alu_pre_res} = a + b;
        4'd1:  alu_pre_res = a - b;
        4'd2:  alu_pre_res = a + b + 1'b1;
        4'd3:  alu_pre_res = a - b;
        4'd4:  alu_pre_res = a >> b;
        4'd5:  alu_pre_res = a << b;
        4'd6:  alu_pre_res = a <<< b;
        4'd7:  alu_pre_res = a >>> b;
        4'd8:  alu_pre_res = {a << (32 - b), a >> b};
        4'd9:  alu_pre_res = {a >> (32 - b), a >> b};
        4'd10: alu_pre_res = a & b;
        4'd11: alu_pre_res = a | b;
        4'd12: alu_pre_res = a ^ b;
        4'd13: alu_pre_res = 0;
        4'd14: alu_pre_res = '1;
        4'd15: alu_pre_res = '32;
    endcase
    alu_pre_flags[0] = (a == b);
    alu_pre_flags[1] = (a > b );
    alu_pre_flags[3] = alu_pre_res;
    alu_pre_flags[4] = alu_pre_res[31];
end


endmodule