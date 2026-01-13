
module memory_controller(
	input clk,
	input reset,
	input write_en,
	input read_en,
	input [31:0]address,
	input clk_enable,
	input [15:0] data_in,

	output reg [31:0] addr,
	output reg  cs_n, 
    output reg  ras_n, 
    output reg  cas_n, 
    output reg  we_n,
	output reg cke,
	output reg [15:0] data_out,
	output reg wrdata_mask,
	input ready
	);


//	reg [15:0] internal_out;
	reg [71:0] controller_command; 
    reg [71:0] next_controller_command; 

	localparam  IDLE = "IDLE";
//	localparam  MRS = "MRS";
    localparam  ACTIVATE = "ACTIVATE"; 
    localparam  READ = "READ";
	localparam  WRITE = "WRITE"; 
    localparam  PRECHARGE = "PRECHARGE";

always @(posedge clk or negedge clk) 
	begin
	cke=clk_enable;
	wrdata_mask=write_en;
        if (!reset) begin
            controller_command = IDLE; 
        end
		else begin
            controller_command = next_controller_command;
			  end
    end 

 always @(*) begin
        case (controller_command)
           IDLE: begin
		   	next_controller_command= ACTIVATE;
			addr=address;
				end

		   ACTIVATE: begin
		   		addr=address;
				next_controller_command = read_en? READ:WRITE; 
                    end
            
                   READ: begin 
                next_controller_command = PRECHARGE; 
		   		addr=address;
            end 

            WRITE: begin 
                next_controller_command = PRECHARGE;
		   		addr=address;
				//internal_out=data_in;
            end 

			PRECHARGE: begin
			if(ready==1)
			begin
				 next_controller_command = IDLE; 
		   		addr=address;
			end
			else
			next_controller_command= PRECHARGE;
			addr=address;

				 end

         endcase 
    end 

 /*   always @(*) begin
        // ... (Logic to generate address based on current controller_command, bank_select, burst_count) 
        //  - Update addr_a, addr_b based on burst_count
    end 
*/
    always @(*) begin
        case (controller_command)
    		IDLE: begin
                cs_n = 0;  
                ras_n = 0; 
				cas_n = 0;
                we_n = 0;
            end 

            ACTIVATE: begin
                cs_n = 1'b0;
                ras_n = 1'b0; 
                cas_n = 1'b1; 
				if(write_en)
                we_n = 1'b0; 
				else
				we_n=1'b1;
            end 

			READ: begin
                cs_n = 1'b0; 
                ras_n = 1'b1; 
                cas_n = 1'b0;
                we_n = 1'b1; 
            end 

            WRITE: begin
                cs_n = 1'b0; 
                ras_n = 1'b1; 
                cas_n = 1'b0;
                we_n = 1'b0; 
            end 

			PRECHARGE: begin
                cs_n = 0;  
                ras_n = 1;  
				cas_n = 1;
                we_n = 1;
            end 

        endcase
    end
	assign data_out=(write_en==1)?data_in:16'hzzzz;
endmodule
