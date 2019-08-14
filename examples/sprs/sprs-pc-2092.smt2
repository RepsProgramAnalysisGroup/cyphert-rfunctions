; Query 2091 -- Type: InitialValues, Instructions: 6868593
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
(assert (let ( (?B1 (select  except_started (_ bv0 32) ) ) (?B2 ((_ zero_extend 24)  (select  cy_we (_ bv0 32) ) ) ) (?B3 ((_ zero_extend 24)  (select  ov_we (_ bv0 32) ) ) ) (?B4 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B5 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B6 ((_ zero_extend 24)  (select  flag_we (_ bv0 32) ) ) ) (?B7 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B8 (bvshl  ((_ zero_extend 24)  (select  dsx (_ bv0 32) ) ) (_ bv1 32) ) ) ) (let ( (?B11 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B7 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B10 ((_ zero_extend 24)  ((_ extract 7  0)  ?B4 ) ) ) (?B9 ((_ zero_extend 24)  ?B1 ) ) (?B13 (bvand  (bvshl  (bvand  ?B8 (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B12 (bvand  (bvlshr  ?B7 (_ bv11 32) ) (_ bv31 32) ) ) ) (let ( (?B14 (bvshl  (bvand  ?B9 (_ bv1 32) ) (_ bv16 32) ) ) (?B15 (=  (_ bv14 32) ?B12 ) ) ) (let ( (?B17 (ite  ?B15 (_ bv16384 32) (_ bv32768 32) ) ) (?B16 (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  ?B14 (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B13 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B14 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B13 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B14 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B13 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ) ) (let ( (?B18 (bvor  (bvshl  (bvand  (bvlshr  ?B16 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B16 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (let ( (?B19 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B18 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B18 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B20 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B18 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B8 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B21 (bvshl  (bvand  (bvlshr  ?B18 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B22 (bvshl  (bvand  (bvor  ?B9 (bvlshr  ?B18 (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B23 (bvshl  (bvand  (bvlshr  ?B18 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B24 (bvshl  (bvand  (bvlshr  ?B18 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B25 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B16 (_ bv4294901759 32) ) ?B22 ) (_ bv4294966784 32) ) ?B19 ) (_ bv4294905855 32) ) ?B20 ) (_ bv4294965247 32) ) ?B24 ) (_ bv4294966271 32) ) ?B21 ) (_ bv4294966783 32) ) ?B23 ) (_ bv4294901759 32) ) ?B22 ) (_ bv4294966784 32) ) ?B19 ) (_ bv4294905855 32) ) ?B20 ) (_ bv4294965247 32) ) ?B24 ) (_ bv4294966271 32) ) ?B21 ) (_ bv4294966783 32) ) ?B23 ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvor  (bvand  ?B10 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  ?B17 (bvsub  (_ bv0 32) (bvor  ?B5 (bvand  ?B4 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B25 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B25 (_ bv0 32) ) (_ bv16383 32) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ?B11 ) ) ) ) ?B6 ) ?B2 ) ?B3 ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite ?B15 (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B12 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv8 32) ?B12 ) ) ) (=  false (=  (_ bv9 32) ?B12 ) ) ) (=  false (=  (_ bv10 32) ?B12 ) ) ) (=  false (=  (_ bv11 32) ?B12 ) ) ) (=  false (=  (_ bv12 32) ?B12 ) ) ) (=  false (=  (_ bv13 32) ?B12 ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvor  (bvand  ?B10 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  ?B17 (bvsub  (_ bv0 32) ?B5 ) ) (_ bv0 32) ) ?B11 ) ) ) ) ?B6 ) ?B2 ) ?B3 ) ) ) ) ) ) ) ) ) ) ) )
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
;   OK -- Elapsed: 1.109397e-02
;   Solvable: false
