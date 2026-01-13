`timescale 1ps/1ps

module ddr_testbench();
    reg clk;
	reg reset;
	reg write_en;
	reg read_en;
	reg [31:0]address;
	reg clk_enable;
	reg [15:0]data_in;

	wire [15:0] ddr4_dq;
	
	reg [1:0]burst_len;
	reg burst_type;
	reg [4:0]latency;
	reg [5:0] delay;

	reg[31:0] queue[$];


ddr4_top tb(.clk(clk),.reset(reset),.write_en(write_en),.read_en(read_en),.address(address),.clk_enable(clk_enable),.data_in(data_in),.ddr4_dq(ddr4_dq));


always #312 clk=~clk;


initial 
begin

    clk=0;
	reset=0;
    clk_enable=1;

	#624;

	
	repeat(10)
	write();
	
	repeat(10)
	read();
	
	$finish;
end




task configure();

	burst_len=$urandom_range(0,1);
	burst_type=$random;
	latency=$urandom_range(0,21);

endtask

task write();

	write_en=1;
	read_en=0;

	configure();

	address[12:11]=2'b00;//USING FOR THE TO CONFIGURE MODE REGISTER 1
	address[7:3]=latency;//using for the to configure cas_rd_latency
	address[2]=burst_type;
	address[1:0]=burst_len;
	address[10:8]=$random;
	address[17:13]=$random;
	address[31:18]=0;

	#624;

	reset=1;
	
	queue.push_back(address);

	repeat(3)
	begin
	@(clk);
	end

	if(burst_len==2'b00)
	repeat(8)
	begin
	data_in=$random;
	@(clk);
	end

	else if(burst_len==2'b01)
	repeat(4)
	begin
	data_in=$random;
	@(clk);
	end

endtask

task read();
	
	write_en=0;
	read_en=1;
		
	address=queue.pop_front();
	$display("Read: addres=%d,time=%0t",address,$time);

    repeat(4)
	begin
	@(clk);
	end
		
	case(address[7:3])

		5'b00000:delay=9;
		5'b00001:delay=10;
		5'b00010:delay=11;
		5'b00011:delay=12;
		5'b00100:delay=13;
		5'b00101:delay=14;
		5'b00110:delay=15;
		5'b00111:delay=16;
		5'b01000:delay=18;
		5'b01001:delay=20;
		5'b01010:delay=22;
		5'b01011:delay=24;
		5'b01100:delay=23;
		5'b01101:delay=17;
		5'b01110:delay=19;
		5'b01111:delay=21;
		5'b10000:delay=25;
		5'b10001:delay=26;
		5'b10001:delay=28;
		5'b10010:delay=29;
		5'b10011:delay=30;
		5'b10100:delay=31;
		5'b10101:delay=32;
		5'b11111:delay=0;
		default: delay=9;
	endcase

    repeat(2*delay)
	begin
	@(clk);
	end

	$display("After 40 clk: time=%0t",$time);

	
	if(address[1:0]==2'b00) begin
	repeat(8)
	begin
	@(clk);
	end
    end

	else if(address[1:0]==2'b01) begin
	repeat(4)
	begin
	@(clk);
	$display("After inside : time=%0t",$time);
	end
	end
	$display("After 44 clk: time=%0t",$time);

	endtask

endmodule

