module dfi_interface;
   // wire  [15:0]dfi_rddata;//read data

    wire dfi_ras_n;//row address strobe negative signal
    wire dfi_cas_n;//column address strobe 
    wire dfi_we_n;//write enable
    wire [31:0]dfi_addr;//address bus
    wire dfi_cke;//clock enable
    wire dfi_cs_n;//chip selection
    wire dfi_wrdata_mask;//data mask of write data
    wire dfi_odt;//on_die_termination
    wire [15:0]dfi_wrdata;//write data

endmodule
