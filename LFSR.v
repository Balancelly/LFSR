module LFSR(
	input clk,
	input rst,
	input seed_val,
	input [7:0] seed,//if rst=1, d=8'd0
	output reg [7:0] d// d[0] = (d[7]^d[5]) ^ (d[4] ^ d[2])
);

reg [7:0] c_LFSR;//current cycle

wire [7:0] n_LFSR;//next cycle
wire random_bit;

assign random_bit=(c_LFSR[7]^c_LFSR[5])^(c_LFSR[4]^c_LFSR[2]);
assign n_LFSR={c_LFSR[6:0],random_bit};

always@(posedge clk or posedge rst)begin //rst change value one shot
	if(rst)begin
		c_LFSR<=8'd0;
	end
	else begin
		if(seed_val)begin
			c_LFSR<=seed;
		end
		else begin
			c_LFSR<=n_LFSR; //c_LFSR change only at posedge clk
		end
	end
end

always@(*)begin

d=c_LFSR;

end

endmodule
