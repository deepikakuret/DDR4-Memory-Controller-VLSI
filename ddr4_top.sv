module ddr4_top(
	input clk,
	input reset,
	input write_en,
	input read_en,
	input [31:0]address,
	input clk_enable,
	input [15:0]data_in,

	output [15:0] ddr4_dq
	);

	wire [31:0] addr;
	wire  cs_n; 
    wire  ras_n; 
    wire  cas_n; 
    wire  we_n;
	wire  cke;
	wire [15:0] data_out;
	wire wrdata_mask;

memory_controller controller_dut(.clk(clk),.reset(reset),.write_en(write_en),.read_en(read_en),.clk_enable(clk_enable),.data_in(data_in),.address(address),.addr(addr),.cs_n(cs_n),.ras_n(ras_n),.cas_n(cas_n),.we_n(we_n),.cke(cke),.data_out(data_out),.wrdata_mask(wrdata_mask),.ready(ddr_dut.ddr4_ready) );


dfi_interface interface_dut();

assign interface_dut.dfi_addr = addr;
assign interface_dut.dfi_cs_n=cs_n;
assign interface_dut.dfi_ras_n=ras_n;
assign interface_dut.dfi_cas_n=cas_n;
assign interface_dut.dfi_we_n=we_n;
assign interface_dut.dfi_cke=cke;
assign interface_dut.dfi_wrdata_mask=wrdata_mask;
assign interface_dut.dfi_wrdata=data_out;
//assign interface_dut.dfi_odt=address[18];

ddr4_rtl ddr_dut(.ddr4_reset_n(reset),.ddr4_cs_n(interface_dut.dfi_cs_n),.ddr4_addr(interface_dut.dfi_addr),.ddr4_we_n(interface_dut.dfi_we_n),.ddr4_dm(interface_dut.dfi_wrdata_mask),.ddr4_cas_n(interface_dut.dfi_cas_n),.ddr4_ras_n(interface_dut.dfi_ras_n),.ddr4_odt(interface_dut.dfi_odt),.ddr4_cke(interface_dut.dfi_cke));

assign ddr_dut.ddr4_ckt=(cke==1)? clk:1'b0;
assign ddr_dut.ddr4_ckc=(cke==1)?~clk:1'b0;

assign ddr_dut.ddr4_dq=interface_dut.dfi_wrdata;

//ddr4_rtl ddr_dut(.ddr4_clk(clk),.ddr4_reset_n(reset),.ddr4_cs_n(cs_n),.ddr4_addr(addr),.ddr4_we_n(we_n),.ddr4_dm(wrdata_mask),.ddr4_cas_n(cas_n),.ddr4_ras_n(ras_n),.ddr4_cke(cke));

assign ddr4_dq=(wrdata_mask==0)?ddr_dut.ddr4_dq:16'hzzzz;

endmodule


