// SPDX-License-Identifier: MIT
/*

Copyright (c) 2025 FPGA Ninja, LLC

Authors:
- Alex Forencich

*/

interface taxi_axis_if #(
    // Width of AXI stream interfaces in bits
    parameter DATA_WIDTH = 64,
    // tkeep signal width (bytes per cycle)
    parameter KEEP_WIDTH = ((DATA_WIDTH+7)/8),

    parameter CTRL_WIDTH = (DATA_WIDTH/8),
    // Use tkeep signal
    parameter logic KEEP_EN = KEEP_WIDTH > 1,
    // Use tstrb signal
    parameter logic STRB_EN = 1'b0,
    // Use tlast signal
    parameter logic LAST_EN = 1'b1,
    // Use tid signal
    parameter logic ID_EN = 0,
    // tid signal width
    parameter ID_W = 8,
    // Use tdest signal
    parameter logic DEST_EN = 0,
    // tdest signal width
    parameter DEST_W = 8,
    // Use tuser signal
    parameter logic USER_EN = 0,
    // tuser signal width
   // parameter USER_W = 1
   //
    parameter PTP_TS_ENABLE = 0,
    parameter PTP_TS_FMT_TOD = 1,
    parameter PTP_TS_WIDTH = PTP_TS_FMT_TOD ? 96 : 64,
   parameter USER_W = (PTP_TS_ENABLE ? PTP_TS_WIDTH : 0) + 1

)
/*  -----------------compile error (grp1)-----------------------
(input aclk,input aresetn);
    logic [DATA_W-1:0] tdata;
    logic [KEEP_W-1:0] tkeep;
    logic [KEEP_W-1:0] tstrb;
    logic [ID_W-1:0] tid;
    logic [DEST_W-1:0] tdest;
    logic [USER_W-1:0] tuser;
    logic tlast;
    logic tvalid;
    logic tready;
*/



  
(input aclk,input aresetn);
    logic [DATA_WIDTH-1:0] tdata;
    logic [KEEP_WIDTH-1:0] tkeep;
    logic [KEEP_WIDTH-1:0] tstrb;
    logic [ID_W-1:0] tid;
    logic [DEST_W-1:0] tdest;
    logic [USER_W-1:0] tuser;
    logic tlast;
    logic tvalid;
    logic tready;




     logic [DATA_WIDTH-1:0]        xgmii_rxd;
  logic [CTRL_WIDTH-1:0]        xgmii_rxc;
  logic [DATA_WIDTH-1:0]        xgmii_txd;
  logic [CTRL_WIDTH-1:0]        xgmii_txc;


    modport src (
        output tdata,
        output tkeep,
        output tstrb,
        output tid,
        output tdest,
        output tuser,
        output tlast,
        output tvalid,
        input  tready
    );

    modport snk (
        input  tdata,
        input  tkeep,
        input  tstrb,
        input  tid,
        input  tdest,
        input  tuser,
        input  tlast,
        input  tvalid,
        output tready
    );

    modport mon (
        input  tdata,
        input  tkeep,
        input  tstrb,
        input  tid,
        input  tdest,
        input  tuser,
        input  tlast,
        input  tvalid,
        input  tready
    );

endinterface
