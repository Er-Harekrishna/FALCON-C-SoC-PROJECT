//########################################################
//# Test Bench Generated by vlogtb.pl 
//# Author : Aviral Mittal
//########################################################
module cm3_matrix_lite_tb ;
  reg HCLK;
  reg HRESETn;
  reg [3:0] REMAP;
  reg [31:0] HADDRS0;
  reg [1:0] HTRANSS0;
  reg HWRITES0;
  reg [2:0] HSIZES0;
  reg [2:0] HBURSTS0;
  reg [3:0] HPROTS0;
  reg [31:0] HWDATAS0;
  reg HMASTLOCKS0;
  reg [31:0] HAUSERS0;
  reg [31:0] HWUSERS0;
  reg [31:0] HADDRS1;
  reg [1:0] HTRANSS1;
  reg HWRITES1;
  reg [2:0] HSIZES1;
  reg [2:0] HBURSTS1;
  reg [3:0] HPROTS1;
  reg [31:0] HWDATAS1;
  reg HMASTLOCKS1;
  reg [31:0] HAUSERS1;
  reg [31:0] HWUSERS1;
  reg [31:0] HADDRS3;
  reg [1:0] HTRANSS3;
  reg HWRITES3;
  reg [2:0] HSIZES3;
  reg [2:0] HBURSTS3;
  reg [3:0] HPROTS3;
  reg [31:0] HWDATAS3;
  reg HMASTLOCKS3;
  reg [31:0] HAUSERS3;
  reg [31:0] HWUSERS3;
  reg [31:0] HADDRS4;
  reg [1:0] HTRANSS4;
  reg HWRITES4;
  reg [2:0] HSIZES4;
  reg [2:0] HBURSTS4;
  reg [3:0] HPROTS4;
  reg [31:0] HWDATAS4;
  reg HMASTLOCKS4;
  reg [31:0] HAUSERS4;
  reg [31:0] HWUSERS4;
  reg [31:0] HADDRS5;
  reg [1:0] HTRANSS5;
  reg HWRITES5;
  reg [2:0] HSIZES5;
  reg [2:0] HBURSTS5;
  reg [3:0] HPROTS5;
  reg [31:0] HWDATAS5;
  reg HMASTLOCKS5;
  reg [31:0] HAUSERS5;
  reg [31:0] HWUSERS5;
  reg [31:0] HRDATAM0;
  reg HREADYOUTM0;
  reg HRESPM0;
  reg [31:0] HRUSERM0;
  reg [31:0] HRDATAM1;
  reg HREADYOUTM1;
  reg HRESPM1;
  reg [31:0] HRUSERM1;
  reg [31:0] HRDATAM2;
  reg HREADYOUTM2;
  reg HRESPM2;
  reg [31:0] HRUSERM2;
  reg [31:0] HRDATAM3;
  reg HREADYOUTM3;
  reg HRESPM3;
  reg [31:0] HRUSERM3;
  reg SCANENABLE;
  reg SCANINHCLK;
  wire HSELM0;
  wire [31:0] HADDRM0;
  wire [1:0] HTRANSM0;
  wire HWRITEM0;
  wire [2:0] HSIZEM0;
  wire [2:0] HBURSTM0;
  wire [3:0] HPROTM0;
  wire [31:0] HWDATAM0;
  wire HMASTLOCKM0;
  wire HREADYMUXM0;
  wire [31:0] HAUSERM0;
  wire [31:0] HWUSERM0;
  wire HSELM1;
  wire [31:0] HADDRM1;
  wire [1:0] HTRANSM1;
  wire HWRITEM1;
  wire [2:0] HSIZEM1;
  wire [2:0] HBURSTM1;
  wire [3:0] HPROTM1;
  wire [31:0] HWDATAM1;
  wire HMASTLOCKM1;
  wire HREADYMUXM1;
  wire [31:0] HAUSERM1;
  wire [31:0] HWUSERM1;
  wire HSELM2;
  wire [31:0] HADDRM2;
  wire [1:0] HTRANSM2;
  wire HWRITEM2;
  wire [2:0] HSIZEM2;
  wire [2:0] HBURSTM2;
  wire [3:0] HPROTM2;
  wire [31:0] HWDATAM2;
  wire HMASTLOCKM2;
  wire HREADYMUXM2;
  wire [31:0] HAUSERM2;
  wire [31:0] HWUSERM2;
  wire HSELM3;
  wire [31:0] HADDRM3;
  wire [1:0] HTRANSM3;
  wire HWRITEM3;
  wire [2:0] HSIZEM3;
  wire [2:0] HBURSTM3;
  wire [3:0] HPROTM3;
  wire [31:0] HWDATAM3;
  wire HMASTLOCKM3;
  wire HREADYMUXM3;
  wire [31:0] HAUSERM3;
  wire [31:0] HWUSERM3;
  wire [31:0] HRDATAS0;
  wire HREADYS0;
  wire HRESPS0;
  wire [31:0] HRUSERS0;
  wire [31:0] HRDATAS1;
  wire HREADYS1;
  wire HRESPS1;
  wire [31:0] HRUSERS1;
  wire [31:0] HRDATAS3;
  wire HREADYS3;
  wire HRESPS3;
  wire [31:0] HRUSERS3;
  wire [31:0] HRDATAS4;
  wire HREADYS4;
  wire HRESPS4;
  wire [31:0] HRUSERS4;
  wire [31:0] HRDATAS5;
  wire HREADYS5;
  wire HRESPS5;
  wire [31:0] HRUSERS5;
  wire SCANOUTHCLK;
cm3_matrix_lite cm3_matrix_lite (
.HCLK(HCLK),
.HRESETn(HRESETn),
.REMAP(REMAP),
.HADDRS0(HADDRS0),
.HTRANSS0(HTRANSS0),
.HWRITES0(HWRITES0),
.HSIZES0(HSIZES0),
.HBURSTS0(HBURSTS0),
.HPROTS0(HPROTS0),
.HWDATAS0(HWDATAS0),
.HMASTLOCKS0(HMASTLOCKS0),
.HAUSERS0(HAUSERS0),
.HWUSERS0(HWUSERS0),
.HADDRS1(HADDRS1),
.HTRANSS1(HTRANSS1),
.HWRITES1(HWRITES1),
.HSIZES1(HSIZES1),
.HBURSTS1(HBURSTS1),
.HPROTS1(HPROTS1),
.HWDATAS1(HWDATAS1),
.HMASTLOCKS1(HMASTLOCKS1),
.HAUSERS1(HAUSERS1),
.HWUSERS1(HWUSERS1),
.HADDRS3(HADDRS3),
.HTRANSS3(HTRANSS3),
.HWRITES3(HWRITES3),
.HSIZES3(HSIZES3),
.HBURSTS3(HBURSTS3),
.HPROTS3(HPROTS3),
.HWDATAS3(HWDATAS3),
.HMASTLOCKS3(HMASTLOCKS3),
.HAUSERS3(HAUSERS3),
.HWUSERS3(HWUSERS3),
.HADDRS4(HADDRS4),
.HTRANSS4(HTRANSS4),
.HWRITES4(HWRITES4),
.HSIZES4(HSIZES4),
.HBURSTS4(HBURSTS4),
.HPROTS4(HPROTS4),
.HWDATAS4(HWDATAS4),
.HMASTLOCKS4(HMASTLOCKS4),
.HAUSERS4(HAUSERS4),
.HWUSERS4(HWUSERS4),
.HADDRS5(HADDRS5),
.HTRANSS5(HTRANSS5),
.HWRITES5(HWRITES5),
.HSIZES5(HSIZES5),
.HBURSTS5(HBURSTS5),
.HPROTS5(HPROTS5),
.HWDATAS5(HWDATAS5),
.HMASTLOCKS5(HMASTLOCKS5),
.HAUSERS5(HAUSERS5),
.HWUSERS5(HWUSERS5),
.HRDATAM0(HRDATAM0),
.HREADYOUTM0(HREADYOUTM0),
.HRESPM0(HRESPM0),
.HRUSERM0(HRUSERM0),
.HRDATAM1(HRDATAM1),
.HREADYOUTM1(HREADYOUTM1),
.HRESPM1(HRESPM1),
.HRUSERM1(HRUSERM1),
.HRDATAM2(HRDATAM2),
.HREADYOUTM2(HREADYOUTM2),
.HRESPM2(HRESPM2),
.HRUSERM2(HRUSERM2),
.HRDATAM3(HRDATAM3),
.HREADYOUTM3(HREADYOUTM3),
.HRESPM3(HRESPM3),
.HRUSERM3(HRUSERM3),
.SCANENABLE(SCANENABLE),
.SCANINHCLK(SCANINHCLK),
.HSELM0(HSELM0),
.HADDRM0(HADDRM0),
.HTRANSM0(HTRANSM0),
.HWRITEM0(HWRITEM0),
.HSIZEM0(HSIZEM0),
.HBURSTM0(HBURSTM0),
.HPROTM0(HPROTM0),
.HWDATAM0(HWDATAM0),
.HMASTLOCKM0(HMASTLOCKM0),
.HREADYMUXM0(HREADYMUXM0),
.HAUSERM0(HAUSERM0),
.HWUSERM0(HWUSERM0),
.HSELM1(HSELM1),
.HADDRM1(HADDRM1),
.HTRANSM1(HTRANSM1),
.HWRITEM1(HWRITEM1),
.HSIZEM1(HSIZEM1),
.HBURSTM1(HBURSTM1),
.HPROTM1(HPROTM1),
.HWDATAM1(HWDATAM1),
.HMASTLOCKM1(HMASTLOCKM1),
.HREADYMUXM1(HREADYMUXM1),
.HAUSERM1(HAUSERM1),
.HWUSERM1(HWUSERM1),
.HSELM2(HSELM2),
.HADDRM2(HADDRM2),
.HTRANSM2(HTRANSM2),
.HWRITEM2(HWRITEM2),
.HSIZEM2(HSIZEM2),
.HBURSTM2(HBURSTM2),
.HPROTM2(HPROTM2),
.HWDATAM2(HWDATAM2),
.HMASTLOCKM2(HMASTLOCKM2),
.HREADYMUXM2(HREADYMUXM2),
.HAUSERM2(HAUSERM2),
.HWUSERM2(HWUSERM2),
.HSELM3(HSELM3),
.HADDRM3(HADDRM3),
.HTRANSM3(HTRANSM3),
.HWRITEM3(HWRITEM3),
.HSIZEM3(HSIZEM3),
.HBURSTM3(HBURSTM3),
.HPROTM3(HPROTM3),
.HWDATAM3(HWDATAM3),
.HMASTLOCKM3(HMASTLOCKM3),
.HREADYMUXM3(HREADYMUXM3),
.HAUSERM3(HAUSERM3),
.HWUSERM3(HWUSERM3),
.HRDATAS0(HRDATAS0),
.HREADYS0(HREADYS0),
.HRESPS0(HRESPS0),
.HRUSERS0(HRUSERS0),
.HRDATAS1(HRDATAS1),
.HREADYS1(HREADYS1),
.HRESPS1(HRESPS1),
.HRUSERS1(HRUSERS1),
.HRDATAS3(HRDATAS3),
.HREADYS3(HREADYS3),
.HRESPS3(HRESPS3),
.HRUSERS3(HRUSERS3),
.HRDATAS4(HRDATAS4),
.HREADYS4(HREADYS4),
.HRESPS4(HRESPS4),
.HRUSERS4(HRUSERS4),
.HRDATAS5(HRDATAS5),
.HREADYS5(HREADYS5),
.HRESPS5(HRESPS5),
.HRUSERS5(HRUSERS5),
.SCANOUTHCLK(SCANOUTHCLK)
);

  initial
  begin
    //clk = 0 ;
    //reset = 0 ;
  end
  //always #5 clk = ~clk ;

endmodule
