`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 06:35:58 PM
// Design Name: 
// Module Name: blackjack
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 09:24:40 PM
// Design Name: 
// Module Name: cardshuffler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module blackjack(globalclk, reset_deal, start_dealing, hitbtn, standbtn, playerbust, dealerbust, playerpush, playerwin, dealerwin, hit_tickstatus, stand_tickstatus, state_reg, done, data_out, AN);
    
    input globalclk;
    input reset_deal;
    input start_dealing;
    input hitbtn;
    input standbtn;
    
    output playerbust;
    output dealerbust;
    output playerpush;
    output playerwin;
    output dealerwin;
    output hit_tickstatus;
    output stand_tickstatus;
    output [2:0]state_reg;
    output done;
    output [6:0]data_out;
    output [7:0]AN;
    
    wire outputclk;
    wire [3:0]phand1;
    wire [3:0]phand2;
    wire [3:0]phand3;
    wire [3:0]phand4;
    wire [3:0]phand5;
    
    wire [3:0]dhand1;
    wire [3:0]dhand2;
    wire [3:0]dhand3;
    wire [3:0]dhand4;
    wire [3:0]dhand5;
    
    wire hit_tick;
    wire stand_tick;
    
    wire [4:0] playertotal;
    wire [4:0] dealertotal;
    
    wire clkoutput_to_counter;
    
    wire [3:0] digitseperator_to_pattern1;
    wire [3:0] digitseperator_to_pattern2;
    wire [3:0] digitseperator_to_pattern3;
    wire [3:0] digitseperator_to_pattern4;
    /*wire [3:0] digitseperator_to_pattern5;
    wire [3:0] digitseperator_to_pattern6;
    wire [3:0] digitseperator_to_pattern7;
    wire [3:0] digitseperator_to_pattern8;*/

    
    wire [6:0]patterntomultiplexer1;
    wire [6:0]patterntomultiplexer2;
    wire [6:0]patterntomultiplexer3;
    wire [6:0]patterntomultiplexer4;
    /*wire [6:0]patterntomultiplexer5;
    wire [6:0]patterntomultiplexer6;
    wire [6:0]patterntomultiplexer7;
    wire [6:0]patterntomultiplexer8;*/
    wire [1:0]select;
    
    cardshuffling cardshuffling_insta(
        .phand1(phand1), 
        .phand2(phand2), 
        .phand3(phand3), 
        .phand4(phand4), 
        .phand5(phand5), 
        .dhand1(dhand1), 
        .dhand2(dhand2), 
        .dhand3(dhand3), 
        .dhand4(dhand4), 
        .dhand5(dhand5)
        );
        
    dealing dealing_insta(
        .clock(outputclk), 
        .reset(reset_deal), 
        .startdealing(startdealing), 
        .playerhit(hit_tick), 
        .playerstand(stand_tick), 
        .phand1(phand1), 
        .phand2(phand2), 
        .phand3(phand3), 
        .phand4(phand4), 
        .phand5(phand5), 
        .dhand1(dhand1), 
        .dhand2(dhand2), 
        .dhand3(dhand3), 
        .dhand4(dhand4), 
        .dhand5(dhand5), 
        .playerbust(playerbust), 
        .dealerbust(dealerbust), 
        .playerpush(playerpush), 
        .playerwin(playerwin), 
        .dealerwin(dealerwin), 
        .playertotal(playertotal), 
        .dealertotal(dealertotal), 
        .state_reg(state_reg), 
        .done(done)
        );
        
    mealyedge hit_btn(
        .clk(globalclk),
        .reset(1'b1),
        .level(hitbtn),
        .tick(hit_tick),
        .tickstatus(hit_tickstatus)
        );
        
    mealyedge stand_btn(
        .clk(globalclk),
        .reset(1'b1),
        .level(standbtn),
        .tick(stand_tick),
        .tickstatus(stand_tickstatus)
        );
    
    digitseperator digitseperator_insta(
        .Clock(outputclk),
        .in1(playertotal), 
        .in2(dealertotal),
        /*.in3(phand3), 
        .in4(phand4), 
        .in5(dhand1), 
        .in6(dhand2),
        .in7(dhand3),
        .in8(dhand4),*/
        .out1(digitseperator_to_pattern1), 
        .out2(digitseperator_to_pattern2), 
        .out3(digitseperator_to_pattern3), 
        .out4(digitseperator_to_pattern4)
        /*.out5(digitseperator_to_pattern5),
        .out6(digitseperator_to_pattern6),
        .out7(digitseperator_to_pattern7),
        .out8(digitseperator_to_pattern8)*/
        );
        
    patterngenerator patterngenerator_insta(
        .in1(digitseperator_to_pattern1), 
        .in2(digitseperator_to_pattern2), 
        .in3(digitseperator_to_pattern3), 
        .in4(digitseperator_to_pattern4),
        /*.in5(digitseperator_to_pattern5),
        .in6(digitseperator_to_pattern6),
        .in7(digitseperator_to_pattern7),
        .in8(digitseperator_to_pattern8),*/ 
        .num1(patterntomultiplexer1), 
        .num2(patterntomultiplexer2), 
        .num3(patterntomultiplexer3), 
        .num4(patterntomultiplexer4)
        /*.num5(patterntomultiplexer5),
        .num6(patterntomultiplexer6),
        .num7(patterntomultiplexer7),
        .num8(patterntomultiplexer8)*/
        );
    
    upcounter two_bit_upcounter_insta(
        .Resetn(1'b1), 
        .Clock(clkoutput_to_counter), 
        .E(1'b1), 
        .Q(select));
        
    fasterClkGen fasterClkGen_insta(
        .clk(globalclk),
        .resetSW(1'b0),
        .outsignal(clkoutput_to_counter)
        ); 
        
   clkGen clkGen_insta(
        .clk(globalclk), 
        .resetSW(1'b0), 
        .outsignal(outputclk)
        );
     
    
   multiplexer eighttoonemultiplexer(
        .in1(patterntomultiplexer1),
        .in2(patterntomultiplexer2),
        .in3(patterntomultiplexer3),
        .in4(patterntomultiplexer4),
        /*.in5(patterntomultiplexer5),
        .in6(patterntomultiplexer6),
        .in7(patterntomultiplexer7),
        .in8(patterntomultiplexer8),*/
        .out1(data_out),
        .S(select),
        .AN(AN)
        );         
endmodule

module clkGen(clk, resetSW, outsignal);
input clk;
input resetSW;
output outsignal;
reg [27:0] counter;
reg outsignal;
always @ (posedge clk)
begin
    if (resetSW)
        begin
            counter=0;
            outsignal=0;
        end
    else
        begin
            counter = counter +1;
    if (counter == 200_000_000) //0.5 Hz
        begin
            outsignal=~outsignal;
            counter =0;
        end
    end
end
endmodule

module fasterClkGen(clk, resetSW, outsignal);
input clk;
input resetSW;
output outsignal;
reg [18:0] counter;
reg outsignal;
always @ (posedge clk)
begin
    if (resetSW)
        begin
            counter=0;
            outsignal=0;
        end
    else
        begin
            counter = counter +1;
    if (counter == 125_000) //400 Hz
        begin
            outsignal=~outsignal;
            counter =0;
        end
    end
end
endmodule

module upcounter (Resetn, Clock, E, Q);
input Resetn, Clock, E;
output reg [1:0] Q;
always @(negedge Resetn, posedge Clock)
    if (!Resetn)
        Q <= 0;
    else if (E)
        Q <= Q + 1;
endmodule

module mealyedge (input wire clk, reset,level,output reg tick, tickstatus);
localparam zero=1'b0, one=1'b1;
reg state_reg, state_next;
    always @(posedge clk, posedge reset)
    if (reset)
        state_reg<=zero;
    else
        state_reg<=state_next;
    always@*
    begin
        state_next=state_reg;
        tick=1'b0;
        tickstatus=1'b0;
        case (state_reg)
        zero:
        if (level)
        begin
        tick=1'b1; //this change is immediate
        tickstatus=1'b1;
        state_next=one;
    end
    one:
    if (~level)
        state_next=zero;
    default:
        state_next=zero;
    endcase
end
endmodule

module digitseperator(Clock, in1, in2, out1, out2, out3, out4);
input Clock;
input [4:0]in1;
input [4:0]in2;

output reg [3:0]out1;
output reg [3:0]out2;
output reg [3:0]out3;
output reg [3:0]out4;
/*output reg [3:0]out5;
output reg [3:0]out6;
output reg [3:0]out7;
output reg [3:0]out8;*/

always @(posedge Clock)
    begin
        begin //player total and dealer total
            out1 = in1 % 10; //playertotal ones
            out2 = in1 / 10; //playertotal tens
            out3 = in2 % 10; //dealertotal ones
            out4 = in2 / 10; //dealertotal tens
         end          
    end    
endmodule

module patterngenerator(in1, in2, in3, in4, /*in5, in6, in7, in8,*/ num1, num2, num3, num4 /*num5, num6, num7, num8*/);
input [3:0]in1;
input [3:0]in2;
input [3:0]in3;
input [3:0]in4;

/*input [3:0]in5;
input [3:0]in6;
input [3:0]in7;
input [3:0]in8;*/

output reg[6:0]num1;
output reg[6:0]num2;
output reg[6:0]num3;
output reg[6:0]num4;

/*output reg[6:0]num5;
output reg[6:0]num6;
output reg[6:0]num7;
output reg[6:0]num8;*/

parameter [6:0] SEG_0 = 7'b0000001; // 0
parameter [6:0] SEG_1 = 7'b1001111; // 1
parameter [6:0] SEG_2 = 7'b0010010; // 2
parameter [6:0] SEG_3 = 7'b0000110; // 3
parameter [6:0] SEG_4 = 7'b1001100; // 4
parameter [6:0] SEG_5 = 7'b0100100; // 5
parameter [6:0] SEG_6 = 7'b0100000; // 6
parameter [6:0] SEG_7 = 7'b0001111; // 7
parameter [6:0] SEG_8 = 7'b0000000; // 8
parameter [6:0] SEG_9 = 7'b0000100; // 9

always @* begin
    case (in1)
        4'b0000: num1 = SEG_0;
        4'b0001: num1 = SEG_1;
        4'b0010: num1 = SEG_2;
        4'b0011: num1 = SEG_3;
        4'b0100: num1 = SEG_4;
        4'b0101: num1 = SEG_5;
        4'b0110: num1 = SEG_6;
        4'b0111: num1 = SEG_7;
        4'b1000: num1 = SEG_8;
        4'b1001: num1 = SEG_9;
    endcase
    case (in2)
        4'b0000: num2 = SEG_0;
        4'b0001: num2 = SEG_1;
        4'b0010: num2 = SEG_2;
        4'b0011: num2 = SEG_3;
        4'b0100: num2 = SEG_4;
        4'b0101: num2 = SEG_5;
        4'b0110: num2 = SEG_6;
        4'b0111: num2 = SEG_7;
        4'b1000: num2 = SEG_8;
        4'b1001: num2 = SEG_9;
    endcase
    case (in3)
        4'b0000: num3 = SEG_0;
        4'b0001: num3 = SEG_1;
        4'b0010: num3 = SEG_2;
        4'b0011: num3 = SEG_3;
        4'b0100: num3 = SEG_4;
        4'b0101: num3 = SEG_5;
        4'b0110: num3 = SEG_6;
        4'b0111: num3 = SEG_7;
        4'b1000: num3 = SEG_8;
        4'b1001: num3 = SEG_9;
    endcase
    case (in4)
        4'b0000: num4 = SEG_0;
        4'b0001: num4 = SEG_1;
        4'b0010: num4 = SEG_2;
        4'b0011: num4 = SEG_3;
        4'b0100: num4 = SEG_4;
        4'b0101: num4 = SEG_5;
        4'b0110: num4 = SEG_6;
        4'b0111: num4 = SEG_7;
        4'b1000: num4 = SEG_8;
        4'b1001: num4 = SEG_9;
    endcase
    /*case (in5)
        4'b0000: num5 = SEG_0;
        4'b0001: num5 = SEG_1;
        4'b0010: num5 = SEG_2;
        4'b0011: num5 = SEG_3;
        4'b0100: num5 = SEG_4;
        4'b0101: num5 = SEG_5;
        4'b0110: num5 = SEG_6;
        4'b0111: num5 = SEG_7;
        4'b1000: num5 = SEG_8;
        4'b1001: num5 = SEG_9;
    endcase
    case (in6)
        4'b0000: num6 = SEG_0;
        4'b0001: num6 = SEG_1;
        4'b0010: num6 = SEG_2;
        4'b0011: num6 = SEG_3;
        4'b0100: num6 = SEG_4;
        4'b0101: num6 = SEG_5;
        4'b0110: num6 = SEG_6;
        4'b0111: num6 = SEG_7;
        4'b1000: num6 = SEG_8;
        4'b1001: num6 = SEG_9;
    endcase
    case (in7)
        4'b0000: num7 = SEG_0;
        4'b0001: num7 = SEG_1;
        4'b0010: num7 = SEG_2;
        4'b0011: num7 = SEG_3;
        4'b0100: num7 = SEG_4;
        4'b0101: num7 = SEG_5;
        4'b0110: num7 = SEG_6;
        4'b0111: num7 = SEG_7;
        4'b1000: num7 = SEG_8;
        4'b1001: num7 = SEG_9;
    endcase
    case (in8)
        4'b0000: num8 = SEG_0;
        4'b0001: num8 = SEG_1;
        4'b0010: num8 = SEG_2;
        4'b0011: num8 = SEG_3;
        4'b0100: num8 = SEG_4;
        4'b0101: num8 = SEG_5;
        4'b0110: num8 = SEG_6;
        4'b0111: num8 = SEG_7;
        4'b1000: num8 = SEG_8;
        4'b1001: num8 = SEG_9;
    endcase*/
end
endmodule

module multiplexer(in1, in2, in3, in4, /*in5, in6, in7, in8,*/ out1, S, AN);

input [6:0]in1;
input [6:0]in2;
input [6:0]in3;
input [6:0]in4;

/*input [6:0]in5;
input [6:0]in6;
input [6:0]in7;
input [6:0]in8;*/

input [1:0]S;
output reg [6:0]out1;
output reg [7:0]AN;

always @*
if (S == 0)
    begin
        out1 = in1;
        AN = 8'b11111110;
    end
else if (S == 1)
    begin
        out1 = in2;
        AN = 8'b11111101;
    end
else if (S == 2)
    begin
        out1 = in3;
        AN = 8'b11111011;
    end
else if (S == 3)
    begin
        out1 = in4;
        AN = 8'b11110111;
    end
/*else if (S == 4)
    begin
        out1 = in5;
        AN = 8'b11101111;
    end
else if (S == 5)
    begin
        out1 = in6;
        AN = 8'b11011111;
    end
else if (S == 6)
    begin
        out1 = in7;
        AN = 8'b10111111;
    end
else if (S == 7)
    begin
        out1 = in8;
        AN = 8'b01111111;
    end*/
endmodule

module cardshuffling(phand1, phand2, phand3, phand4, phand5, dhand1, dhand2, dhand3, dhand4, dhand5);
output reg [3:0] phand1;
output reg [3:0] phand2;
output reg [3:0] phand3;
output reg [3:0] phand4;
output reg [3:0] phand5;
output reg [3:0] dhand1;
output reg [3:0] dhand2;
output reg [3:0] dhand3;
output reg [3:0] dhand4;
output reg [3:0] dhand5;

// Define parameters for blackjack values
parameter [3:0] ACE = 1;
parameter [3:0] TWO = 2;
parameter [3:0] THREE = 3;
parameter [3:0] FOUR = 4;
parameter [3:0] FIVE = 5;
parameter [3:0] SIX = 6;
parameter [3:0] SEVEN = 7;
parameter [3:0] EIGHT = 8;
parameter [3:0] NINE = 9;
parameter [3:0] TEN = 10;
parameter [3:0] JACK = 10;
parameter [3:0] QUEEN = 10;
parameter [3:0] KING = 10;

integer seed = 12345;

always @* begin
    // Generate random card values
    /*$random(seed);
    phand1 = ($urandom % 13) + 1;  // Generate a random value between 1 and 13
    phand2 = ($urandom % 13) + 1;
    phand3 = ($urandom % 13) + 1;
    phand4 = ($urandom % 13) + 1;
    phand5 = ($urandom % 13) + 1;
    dhand1 = ($urandom % 13) + 1;
    dhand2 = ($urandom % 13) + 1;
    dhand3 = ($urandom % 13) + 1;
    dhand4 = ($urandom % 13) + 1;
    dhand5 = ($urandom % 13) + 1;*/
    
    phand1 = 3;
    phand2 = 2;
    phand3 = 8;
    phand4 = 5;
    phand5 = 2;
    
    dhand1 = 3;
    dhand2 = 11;
    dhand3 = 2;
    dhand4 = 3;
    dhand5 = 5;

    // Assign card types based on numerical values
    case (phand1)
        1: phand1 = ACE;
        2: phand1 = TWO;
        3: phand1 = THREE;
        4: phand1 = FOUR;
        5: phand1 = FIVE;
        6: phand1 = SIX;
        7: phand1 = SEVEN;
        8: phand1 = EIGHT;
        9: phand1 = NINE;
        10: phand1 = TEN;
        11: phand1 = JACK;
        12: phand1 = QUEEN;
        13: phand1 = KING;
    endcase
    case (phand2)
        1: phand2 = ACE;
        2: phand2 = TWO;
        3: phand2 = THREE;
        4: phand2 = FOUR;
        5: phand2 = FIVE;
        6: phand2 = SIX;
        7: phand2 = SEVEN;
        8: phand2 = EIGHT;
        9: phand2 = NINE;
        10: phand2 = TEN;
        11: phand2 = JACK;
        12: phand2 = QUEEN;
        13: phand2 = KING;
    endcase
    case (phand3)
        1: phand3 = ACE;
        2: phand3 = TWO;
        3: phand3 = THREE;
        4: phand3 = FOUR;
        5: phand3 = FIVE;
        6: phand3 = SIX;
        7: phand3 = SEVEN;
        8: phand3 = EIGHT;
        9: phand3 = NINE;
        10: phand3 = TEN;
        11: phand3 = JACK;
        12: phand3 = QUEEN;
        13: phand3 = KING;
    endcase
    case (phand4)
        1: phand4 = ACE;
        2: phand4 = TWO;
        3: phand4 = THREE;
        4: phand4 = FOUR;
        5: phand4 = FIVE;
        6: phand4 = SIX;
        7: phand4 = SEVEN;
        8: phand4 = EIGHT;
        9: phand4 = NINE;
        10: phand4 = TEN;
        11: phand4 = JACK;
        12: phand4 = QUEEN;
        13: phand4 = KING;
   endcase
   case (phand5)
        1: phand5 = ACE;
        2: phand5 = TWO;
        3: phand5 = THREE;
        4: phand5 = FOUR;
        5: phand5 = FIVE;
        6: phand5 = SIX;
        7: phand5 = SEVEN;
        8: phand5 = EIGHT;
        9: phand5 = NINE;
        10: phand5 = TEN;
        11: phand5 = JACK;
        12: phand5 = QUEEN;
        13: phand5 = KING;
    endcase
    case (dhand1)
        1: dhand1 = ACE;
        2: dhand1 = TWO;
        3: dhand1 = THREE;
        4: dhand1 = FOUR;
        5: dhand1 = FIVE;
        6: dhand1 = SIX;
        7: dhand1 = SEVEN;
        8: dhand1 = EIGHT;
        9: dhand1 = NINE;
        10: dhand1 = TEN;
        11: dhand1 = JACK;
        12: dhand1 = QUEEN;
        13: dhand1 = KING;
    endcase
    case (dhand2)
        1: dhand2 = ACE;
        2: dhand2 = TWO;
        3: dhand2 = THREE;
        4: dhand2 = FOUR;
        5: dhand2 = FIVE;
        6: dhand2 = SIX;
        7: dhand2 = SEVEN;
        8: dhand2 = EIGHT;
        9: dhand2 = NINE;
        10: dhand2 = TEN;
        11: dhand2 = JACK;
        12: dhand2 = QUEEN;
        13: dhand2 = KING;
    endcase
    case (dhand3)
        1: dhand3 = ACE;
        2: dhand3 = TWO;
        3: dhand3 = THREE;
        4: dhand3 = FOUR;
        5: dhand3 = FIVE;
        6: dhand3 = SIX;
        7: dhand3 = SEVEN;
        8: dhand3 = EIGHT;
        9: dhand3 = NINE;
        10: dhand3 = TEN;
        11: dhand3 = JACK;
        12: dhand3 = QUEEN;
        13: dhand3 = KING;
    endcase
    case (dhand4)
        1: dhand4 = ACE;
        2: dhand4 = TWO;
        3: dhand4 = THREE;
        4: dhand4 = FOUR;
        5: dhand4 = FIVE;
        6: dhand4 = SIX;
        7: dhand4 = SEVEN;
        8: dhand4 = EIGHT;
        9: dhand4 = NINE;
        10: dhand4 = TEN;
        11: dhand4 = JACK;
        12: dhand4 = QUEEN;
        13: dhand4 = KING;
    endcase
    case (dhand5)
        1: dhand5 = ACE;
        2: dhand5 = TWO;
        3: dhand5 = THREE;
        4: dhand5 = FOUR;
        5: dhand5 = FIVE;
        6: dhand5 = SIX;
        7: dhand5 = SEVEN;
        8: dhand5 = EIGHT;
        9: dhand5 = NINE;
        10: dhand5 = TEN;
        11: dhand5 = JACK;
        12: dhand5 = QUEEN;
        13: dhand5 = KING;
    endcase
end
endmodule

module dealing(clock, reset, startdealing, playerhit, playerstand, phand1, phand2, phand3, phand4, phand5, dhand1, dhand2, dhand3, dhand4, dhand5, playerbust, dealerbust, playerpush, playerwin, dealerwin, playertotal, dealertotal, state_reg, done);

input clock;
input reset;
input startdealing;

input playerhit;
input playerstand;

input [3:0]phand1;
input [3:0]phand2;
input [3:0]phand3;
input [3:0]phand4;
input [3:0]phand5;

input [3:0]dhand1;
input [3:0]dhand2;
input [3:0]dhand3;
input [3:0]dhand4;
input [3:0]dhand5;

output reg playerbust;
output reg dealerbust;
//output reg dealerstand;
//output reg dealerhit;
output reg playerwin;
output reg dealerwin;
output reg playerpush;
output reg [4:0]dealertotal;
output reg [4:0]playertotal;
output reg [2:0]state_reg;
output reg done;

localparam [2:0]gamestart=3'b001, dealerdeal=3'b010, playeraction1=3'b011, playeraction2=3'b100, playeraction3=3'b101, dealeraction=3'b110, compare=3'b111;

reg [3:0]registerphand1, registerphand1_next;
reg [3:0]registerphand2, registerphand2_next;
reg [3:0]registerphand3, registerphand3_next;
reg [3:0]registerphand4, registerphand4_next;
reg [3:0]registerphand5, registerphand5_next;

//reg registerplayerhit, registerplayerhit_next;
//reg registerplayerstand, registerplayerstand_next;

reg [3:0]registerdhand1, registerdhand1_next;
reg [3:0]registerdhand2, registerdhand2_next;
reg [3:0]registerdhand3, registerdhand3_next;
reg [3:0]registerdhand4, registerdhand4_next;
reg [3:0]registerdhand5, registerdhand5_next;

reg [2:0]state_next;
reg playerbust_next;
reg dealerbust_next;
//reg dealerhit_next;
//reg dealerstand_next;
reg playerwin_next;
reg dealerwin_next;
reg playerpush_next;
reg [4:0]dealertotal_next;
reg [4:0]playertotal_next;

reg done_next;

always @(posedge clock)
begin
    if(reset)
        begin
            registerphand1 <= 0;
            registerphand2 <= 0;
            registerphand3 <= 0;
            registerphand4 <= 0;
            registerphand5 <= 0;
            
            registerdhand1 <= 0;
            registerdhand2 <= 0;
            registerdhand3 <= 0;
            registerdhand4 <= 0;
            registerdhand5 <= 0;
            
            //registerplayerhit <= 0;
            //registerplayerstand <=0;
            
            playerbust <= 0;
            dealerbust <= 0;
            //dealerhit <= 0;
            //dealerstand <= 0;
            playerwin <= 0;
            dealerwin <= 0;
            playerpush <= 0;
            dealertotal <= 0;
            playertotal <= 0;
            state_reg <= dealerdeal;
            done <= 0;
            
         end
    else
        begin
            registerphand1 <= registerphand1_next;
            registerphand2 <= registerphand2_next;
            registerphand3 <= registerphand3_next;
            registerphand4 <= registerphand4_next;
            registerphand5 <= registerphand5_next;
            
            registerdhand1 <= registerdhand1_next;
            registerdhand2 <= registerdhand2_next;
            registerdhand3 <= registerdhand3_next;
            registerdhand4 <= registerdhand4_next;
            registerdhand5 <= registerdhand5_next;
            
            //registerplayerhit <= registerplayerhit_next;
            //registerplayerstand <= registerplayerstand_next;
            
            playerbust <= playerbust_next;
            dealerbust <= dealerbust_next;
            //dealerhit <= dealerhit_next;
            //dealerstand <= dealerstand_next;
            playerwin <= playerwin_next;
            dealerwin <= dealerwin_next;
            playerpush <= playerpush_next;
            dealertotal <= dealertotal_next;
            playertotal <= playertotal_next;
            state_reg <= state_next;
            done <= done_next;
        end
end
always @*
begin
    registerphand1_next = registerphand1;
    registerphand2_next = registerphand2;
    registerphand3_next = registerphand3;
    registerphand4_next = registerphand4;
    registerphand5_next = registerphand5;
    
    //registerplayerhit_next = registerplayerhit;
    //registerplayerstand_next = registerplayerstand;
    
    registerdhand1_next = registerdhand1;
    registerdhand2_next = registerdhand2;
    registerdhand3_next = registerdhand3;
    registerdhand4_next = registerdhand4;
    registerdhand5_next = registerdhand5;
    
    playerbust_next = playerbust;
    dealerbust_next = dealerbust;
    //dealerhit_next = dealerhit;
    //dealerstand_next = dealerstand;        
    playerwin_next = playerwin; 
    dealerwin_next = dealerwin;
    playerpush_next = playerpush;
    dealertotal_next = dealertotal;
    playertotal_next = playertotal;       
    state_next = state_reg;
    done_next = done;
    
    case (state_reg)
    gamestart:
    begin
        if(startdealing == 1)
            begin
                state_next = dealerdeal;
                done_next = 0;
            end
        else
            begin //loads cards
                registerphand1_next = {4'b0, phand1};
                registerphand2_next = {4'b0, phand2};
                registerphand3_next = {4'b0, phand3};
                registerphand4_next = {4'b0, phand4};
                registerphand5_next = {4'b0, phand5};
                
                registerdhand1_next = {4'b0, dhand1};
                registerdhand2_next = {4'b0, dhand2};
                registerdhand3_next = {4'b0, dhand3};
                registerdhand4_next = {4'b0, dhand4};
                registerdhand5_next = {4'b0, dhand5};
                
                //registerplayerhit = {1'b0, playerhit};
                //registerplayerstand = {1'b0, playerstand};
            end
    end
    dealerdeal:
        begin
            if(phand1 + phand2 + 10 <= 21 && (phand1 == 1 || phand2 == 1)) //checks if phand1 or phand2 is an Ace, determines if it is a 1 or 11, it is default at 1
                playertotal_next = phand1 + phand2 + 10;
            else playertotal_next = phand1 + phand2;
            if(dhand1 == 1) //check if dealer's first hard is an ace
                dealertotal_next = dhand1 + 10; 
            else dealertotal_next = dhand1; //adds dealer's first card and 2nd card is unknown
            state_next = playeraction1;
        end
    playeraction1:
        begin
            if(playerhit == 1)
                begin
                    if(playertotal + phand3 + 10 <= 21 && phand3 == 1) //checks if phand3 is an Ace, determines if it is a 1 or 11, it is default at 1
                        playertotal_next = playertotal + phand3 + 10;
                    else playertotal_next = playertotal + phand3;      
                    if(playertotal_next > 21) //if playertotal is greater than 21, the player busted
                        begin
                            playerbust_next = 1;
                            state_next = compare;
                        end
                    else
                        state_next = playeraction2;
                end           
            if(playerstand == 1)
                state_next = dealeraction;   
        end
    playeraction2:
        begin
            if(playerhit == 1)
                begin
                    if(playertotal + phand4 + 10 <= 21 && phand4 == 1) //checks if phand4 is an Ace, determines if it is a 1 or 11, it is default at 1
                        playertotal_next = playertotal + phand4 + 10;
                    else 
                        playertotal_next = playertotal + phand4;      
                    if(playertotal_next > 21)
                        begin
                            playerbust_next = 1;
                            state_next = compare;
                        end
                    else
                        state_next = playeraction3; 
                end          
            if(playerstand == 1)
                state_next = dealeraction;    
        end
    playeraction3:
        begin
            if(playerhit == 1)
                begin
                    if(playertotal + phand5 + 10 <= 21 && phand5 == 1) //checks if phand4 is an Ace, determines if it is a 1 or 11, it is default at 1
                        playertotal_next = playertotal + phand5 + 10;
                    else playertotal_next = playertotal + phand5;      
                    if(playertotal_next > 21)
                        begin
                            playerbust_next = 1;
                            state_next = compare;
                        end
                    else
                        state_next = dealeraction;               
                end
            if(playerstand == 1)
                state_next = dealeraction;    
        end        
    dealeraction:
        begin
            if(dhand1 + dhand2 + 10 <= 21 && (dealertotal == 1 || dhand2 == 1)) //checks if dhand1 or dhand2 is an Ace, determines if it is a 1 or 11, it is default at 1
                begin
                    dealertotal_next = dhand1 + dhand2 + 10; //dhand1 or dhand2 is an ace
                    if(dealertotal_next <= 17) //if soft 12 to 17, dealer has to hit
                        begin
                            if(dealertotal_next + dhand3 > 21) //if dealer gets a combination between the three cards that's higher than 12, the ace valued as 11 will turn to 1
                                begin
                                    dealertotal_next = dealertotal_next + dhand3 - 10;
                                    if(dealertotal_next <= 17) //dealer hits until 17
                                        begin
                                            dealertotal_next = dealertotal_next + dhand4;
                                            if(dealertotal_next <= 17) //dealer hits until 17
                                                dealertotal_next = dealertotal_next + dhand5;
                                        end
                                end            
                            else
                                begin
                                    dealertotal_next = dealertotal_next + dhand3; //dealer gets a 12 or above with one card as an ace but less than 17, dealer hit until 17
                                    if (dealertotal_next <= 17)//dealer hits again until 17
                                        begin
                                            dealertotal_next = dealertotal_next + dhand4;
                                            if (dealertotal_next <= 17)
                                                dealertotal_next = dealertotal_next + dhand5;
                                        end
                                end     
                        end
                end
            else
                begin
                    dealertotal_next = dhand1 + dhand2; //dealer's first two cards are not aces
                    if (dealertotal_next < 17) //dealer hits until 17
                        begin
                            if(dhand3 == 1) //dealer's 3rd card is an ace
                                dealertotal_next = dealertotal_next + dhand3 + 10;
                            else
                                dealertotal_next = dealertotal_next + dhand3; //dealer hits as normal
                            if(dealertotal_next < 17) //dealer hits until 17
                                begin
                                    if(dhand4 == 1)//dealer's 4th card is an ace
                                        dealertotal_next = dealertotal_next + dhand4 + 10;
                                    else
                                        dealertotal_next = dealertotal_next + dhand4; //dealer hits as normal
                                    if(dealertotal_next < 17) //dealer h
                                        begin
                                            if(dhand5 == 1)
                                                dealertotal_next = dealertotal_next + dhand5 + 10;
                                            else 
                                                dealertotal_next = dealertotal_next + dhand5;
                                        end  
                                end                    
                        end
                end                      
            if (dealertotal_next > 21) //if dealer's total is above 21, the dealer busted
                begin
                    dealerbust_next = 1;
                end
            state_next = compare;    
        end
    compare:
        begin
            if ((dealertotal < playertotal || dealerbust == 1) && playerbust == 0)
                playerwin_next = 1;
            else
                playerwin_next = 0;
            if ((dealertotal > playertotal || playerbust == 1) && dealerbust == 0)
                dealerwin_next = 1;
            else
                dealerwin_next = 0;
            done_next=1;
            if (dealertotal == playertotal)
                playerpush_next = 1;
            else
                playerpush_next = 0;
            if (startdealing==0)
                state_next = gamestart; 
        end           
    default
        begin
            state_next = gamestart;
            done_next = 0;
        end     
    endcase
end        
endmodule
