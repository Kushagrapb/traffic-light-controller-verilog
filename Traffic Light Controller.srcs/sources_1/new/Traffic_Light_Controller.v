module Traffic_Light_Controller(
    input clk, rst,
    output reg [2:0] light_M1,
    output reg [2:0] light_S,
    output reg [2:0] light_MT,
    output reg [2:0] light_M2
);
    
    parameter S1=3'd0, S2=3'd1, S3=3'd2, S4=3'd3, S5=3'd4, S6=3'd5;
    
    reg [3:0] count;
    reg [2:0] ps;
    
    parameter sec7=7, sec5=5, sec2=2, sec3=3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ps <= S1;
            count <= 4'd0;
        end else begin
            case (ps)
                S1: if (count < sec7) begin count <= count + 1; end 
                    else begin ps <= S2; count <= 0; end
                S2: if (count < sec2) begin count <= count + 1; end 
                    else begin ps <= S3; count <= 0; end
                S3: if (count < sec5) begin count <= count + 1; end 
                    else begin ps <= S4; count <= 0; end
                S4: if (count < sec2) begin count <= count + 1; end 
                    else begin ps <= S5; count <= 0; end
                S5: if (count < sec3) begin count <= count + 1; end 
                    else begin ps <= S6; count <= 0; end
                S6: if (count < sec2) begin count <= count + 1; end 
                    else begin ps <= S1; count <= 0; end
                default: begin ps <= S1; count <= 0; end
            endcase
        end
    end   

    always @(*) begin
        // Default values to prevent latches
        light_M1 = 3'b100; // Red
        light_M2 = 3'b100;
        light_MT = 3'b100;
        light_S  = 3'b100;
        
        case (ps)
            S1: begin light_M1 = 3'b001; light_M2 = 3'b001; end
            S2: begin light_M1 = 3'b001; light_M2 = 3'b010; end
            S3: begin light_M1 = 3'b001; light_MT = 3'b001; end
            S4: begin light_M1 = 3'b010; light_MT = 3'b010; end
            S5: begin light_S  = 3'b001; end
            S6: begin light_S  = 3'b010; end
            default: ;
        endcase
    end                

endmodule