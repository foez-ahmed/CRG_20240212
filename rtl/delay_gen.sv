///////////////////////////////////////////////////////////////////////////////
//Author: Md Nazmus Sakib
//This is a delay generator which is constructed using counter
///////////////////////////////////////////////////////////////////////////////

module delay_gen #(
    parameter int COUNT_RANGE = 128
)(
    input  logic                  clk_i,
    input  logic                  arst_ni,
    output logic                  delayed_o
);

//////////////////////////////////////////////////////////////////////////////////////////////////
// SIGNALS
//////////////////////////////////////////////////////////////////////////////////////////////////
    
    localparam int COUNT_RANGE_PLUS_ONE = COUNT_RANGE + 1;
    localparam int n = $clog2(COUNT_RANGE_PLUS_ONE);
    logic [n-1:0] count_net;
    logic                  en_net;

//////////////////////////////////////////////////////////////////////////////////////////////////
// COMBINATIONAL
//////////////////////////////////////////////////////////////////////////////////////////////////

    assign delayed_o=(count_net + 1 == COUNT_RANGE);
    always_comb begin
         en_net=~delayed_o;
    end

//////////////////////////////////////////////////////////////////////////////////////////////////
// SEQUENTIAL
//////////////////////////////////////////////////////////////////////////////////////////////////

    always_ff @(posedge clk_i or negedge arst_ni) begin
        if (~arst_ni) begin
            count_net <= 0;
        end else begin
            if(en_net) begin
                count_net <= count_net + 1;
            end
        end
    end

endmodule

