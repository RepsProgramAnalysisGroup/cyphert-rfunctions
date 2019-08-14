; Query 1615 -- Type: InitialValues, Instructions: 5389456
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cy_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun dsx () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun except_started () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flag_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ov_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  except_started (_ bv0 32) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  ((_ zero_extend 24)  (select  dsx (_ bv0 32) ) ) (_ bv1 32) ) ) ) (let ( (?B8 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B7 ((_ zero_extend 24)  ((_ extract 7  0)  ?B2 ) ) ) (?B6 ((_ zero_extend 24)  ?B1 ) ) (?B10 (bvand  (bvshl  (bvand  ?B5 (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B9 (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) ) (let ( (?B11 (bvshl  (bvand  ?B6 (_ bv1 32) ) (_ bv16 32) ) ) (?B12 (=  (_ bv14 32) ?B9 ) ) ) (let ( (?B14 (ite  ?B12 (_ bv16384 32) (_ bv32768 32) ) ) (?B13 (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  ?B11 (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ) ) (let ( (?B15 (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B13 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (let ( (?B16 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B15 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B15 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B17 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B15 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B18 (bvshl  (bvand  (bvlshr  ?B15 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B19 (bvshl  (bvand  (bvor  ?B6 (bvlshr  ?B15 (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B20 (bvshl  (bvand  (bvlshr  ?B15 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B21 (bvshl  (bvand  (bvlshr  ?B15 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B22 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B13 (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B16 ) (_ bv4294905855 32) ) ?B17 ) (_ bv4294965247 32) ) ?B21 ) (_ bv4294966271 32) ) ?B18 ) (_ bv4294966783 32) ) ?B20 ) (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B16 ) (_ bv4294905855 32) ) ?B17 ) (_ bv4294965247 32) ) ?B21 ) (_ bv4294966271 32) ) ?B18 ) (_ bv4294966783 32) ) ?B20 ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  ?B14 (bvsub  (_ bv0 32) (bvor  ?B3 (bvand  ?B2 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B22 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B22 (_ bv0 32) ) (_ bv16383 32) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ?B8 ) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite ?B12 (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv8 32) ?B9 ) ) ) (=  false (=  (_ bv9 32) ?B9 ) ) ) (=  false (=  (_ bv10 32) ?B9 ) ) ) (=  false (=  (_ bv11 32) ?B9 ) ) ) (=  false (=  (_ bv12 32) ?B9 ) ) ) (=  false (=  (_ bv13 32) ?B9 ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvor  (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  ?B14 (bvsub  (_ bv0 32) ?B3 ) ) (_ bv0 32) ) ?B8 ) ) ) ) ((_ zero_extend 24)  (select  flag_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  cy_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  ov_we (_ bv0 32) ) ) ) ) ) ) ) ) ) ) ) ) ) )
(check-sat)
(get-value ( (select addrbase (_ bv0 32) ) ) )
(get-value ( (select addrbase (_ bv1 32) ) ) )
(get-value ( (select addrbase (_ bv2 32) ) ) )
(get-value ( (select addrbase (_ bv3 32) ) ) )
(get-value ( (select addrofs (_ bv0 32) ) ) )
(get-value ( (select addrofs (_ bv1 32) ) ) )
(get-value ( (select addrofs (_ bv2 32) ) ) )
(get-value ( (select addrofs (_ bv3 32) ) ) )
(get-value ( (select ex_spr_write (_ bv0 32) ) ) )
(get-value ( (select ex_spr_write (_ bv1 32) ) ) )
(get-value ( (select ex_spr_write (_ bv2 32) ) ) )
(get-value ( (select ex_spr_write (_ bv3 32) ) ) )
(get-value ( (select ex_spr_read (_ bv0 32) ) ) )
(get-value ( (select ex_spr_read (_ bv1 32) ) ) )
(get-value ( (select ex_spr_read (_ bv2 32) ) ) )
(get-value ( (select ex_spr_read (_ bv3 32) ) ) )
(get-value ( (select except_started (_ bv0 32) ) ) )
(get-value ( (select except_started (_ bv1 32) ) ) )
(get-value ( (select except_started (_ bv2 32) ) ) )
(get-value ( (select except_started (_ bv3 32) ) ) )
(get-value ( (select dsx (_ bv0 32) ) ) )
(get-value ( (select dsx (_ bv1 32) ) ) )
(get-value ( (select dsx (_ bv2 32) ) ) )
(get-value ( (select dsx (_ bv3 32) ) ) )
(get-value ( (select flag_we (_ bv0 32) ) ) )
(get-value ( (select flag_we (_ bv1 32) ) ) )
(get-value ( (select flag_we (_ bv2 32) ) ) )
(get-value ( (select flag_we (_ bv3 32) ) ) )
(get-value ( (select cy_we (_ bv0 32) ) ) )
(get-value ( (select cy_we (_ bv1 32) ) ) )
(get-value ( (select cy_we (_ bv2 32) ) ) )
(get-value ( (select cy_we (_ bv3 32) ) ) )
(get-value ( (select ov_we (_ bv0 32) ) ) )
(get-value ( (select ov_we (_ bv1 32) ) ) )
(get-value ( (select ov_we (_ bv2 32) ) ) )
(get-value ( (select ov_we (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 5.499959e-03
;   Solvable: false
