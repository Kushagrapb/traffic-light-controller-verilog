`timescale 1ns / 1ps

module Traffic_Light_Controller_tb;
    reg clk, rst;
    wire [2:0] light_M1, light_S, light_MT, light_M2;

    Traffic_Light_Controller dut (
        .clk(clk), 
        .rst(rst), 
        .light_M1(light_M1), 
        .light_S(light_S), 
        .light_MT(light_MT), 
        .light_M2(light_M2)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin

        rst = 1;               
        #20;                   
        rst = 0;               
        
        #1000; 
        
        $display("Simulation Finished");
        $finish;
    end

    initial begin
        $monitor("Time=%0t | ps=%0d | M1=%b M2=%b MT=%b S=%b", 
                 $time, dut.ps, light_M1, light_M2, light_MT, light_S);
    end

endmodule