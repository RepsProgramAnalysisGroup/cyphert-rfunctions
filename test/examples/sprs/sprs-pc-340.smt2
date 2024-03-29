; Query 339 -- Type: InitialValues, Instructions: 1953467
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
(assert (let ( (?B1 (select  except_started (_ bv0 32) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  ((_ zero_extend 24)  (select  dsx (_ bv0 32) ) ) (_ bv1 32) ) ) ) (let ( (?B8 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B7 ((_ zero_extend 24)  ((_ extract 7  0)  ?B2 ) ) ) (?B6 ((_ zero_extend 24)  ?B1 ) ) (?B9 (bvand  (bvshl  (bvand  ?B5 (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) ) (let ( (?B10 (bvshl  (bvand  ?B6 (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B11 (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  ?B10 (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B9 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B9 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B9 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ) ) (let ( (?B12 (bvor  (bvshl  (bvand  (bvlshr  ?B11 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B11 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (let ( (?B13 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B12 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B12 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B14 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B12 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B15 (bvshl  (bvand  (bvlshr  ?B12 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B16 (bvshl  (bvand  (bvor  ?B6 (bvlshr  ?B12 (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B17 (bvshl  (bvand  (bvlshr  ?B12 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B18 (bvshl  (bvand  (bvlshr  ?B12 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B19 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B11 (_ bv4294901759 32) ) ?B16 ) (_ bv4294966784 32) ) ?B13 ) (_ bv4294905855 32) ) ?B14 ) (_ bv4294965247 32) ) ?B18 ) (_ bv4294966271 32) ) ?B15 ) (_ bv4294966783 32) ) ?B17 ) (_ bv4294901759 32) ) ?B16 ) (_ bv4294966784 32) ) ?B13 ) (_ bv4294905855 32) ) ?B14 ) (_ bv4294965247 32) ) ?B18 ) (_ bv4294966271 32) ) ?B15 ) (_ bv4294966783 32) ) ?B17 ) ) ) (let ( (?B20 (bvor  (bvshl  (bvand  (bvlshr  ?B19 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B19 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (let ( (?B21 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B22 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B23 (bvshl  (bvand  (bvlshr  ?B20 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B24 (bvshl  (bvand  (bvlshr  ?B20 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B25 (bvshl  (bvand  (bvor  ?B6 (bvlshr  ?B20 (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B26 (bvshl  (bvand  (bvlshr  ?B20 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B27 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B19 (_ bv4294901759 32) ) ?B25 ) (_ bv4294966784 32) ) ?B21 ) (_ bv4294905855 32) ) ?B22 ) (_ bv4294965247 32) ) ?B26 ) (_ bv4294966271 32) ) ?B23 ) (_ bv4294966783 32) ) ?B24 ) (_ bv4294901759 32) ) ?B25 ) (_ bv4294966784 32) ) ?B21 ) (_ bv4294905855 32) ) ?B22 ) (_ bv4294965247 32) ) ?B26 ) (_ bv4294966271 32) ) ?B23 ) (_ bv4294966783 32) ) ?B24 ) ) ) (let ( (?B28 (bvor  (bvshl  (bvand  (bvlshr  ?B27 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B27 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (let ( (?B29 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B28 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B28 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B30 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B28 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B31 (bvshl  (bvand  (bvor  ?B6 (bvlshr  ?B28 (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B32 (bvshl  (bvand  (bvlshr  ?B28 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B33 (bvshl  (bvand  (bvlshr  ?B28 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B34 (bvshl  (bvand  (bvlshr  ?B28 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) ) (let ( (?B35 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B27 (_ bv4294901759 32) ) ?B31 ) (_ bv4294966784 32) ) ?B29 ) (_ bv4294905855 32) ) ?B30 ) (_ bv4294965247 32) ) ?B32 ) (_ bv4294966271 32) ) ?B33 ) (_ bv4294966783 32) ) ?B34 ) (_ bv4294901759 32) ) ?B31 ) (_ bv4294966784 32) ) ?B29 ) (_ bv4294905855 32) ) ?B30 ) (_ bv4294965247 32) ) ?B32 ) (_ bv4294966271 32) ) ?B33 ) (_ bv4294966783 32) ) ?B34 ) ) ) (and  (and  (and  (=  false (=  (_ bv0 32) (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) (bvor  ?B3 (bvand  ?B2 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B35 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvand  (bvlshr  ?B35 (_ bv0 32) ) (_ bv16383 32) ) ) (_ bv0 32) ) ) ) ) (_ bv2 32) ) (_ bv0 32) ) ?B8 ) ) ) ) ) ) (=  (_ bv1 32) (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvor  (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) ?B3 ) (_ bv2 32) ) (_ bv0 32) ) ?B8 ) ) ) ) ((_ zero_extend 24)  (select  flag_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  cy_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  ov_we (_ bv0 32) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )
(check-sat)
(get-value ( (select ex_spr_write (_ bv0 32) ) ) )
(get-value ( (select ex_spr_write (_ bv1 32) ) ) )
(get-value ( (select ex_spr_write (_ bv2 32) ) ) )
(get-value ( (select ex_spr_write (_ bv3 32) ) ) )
(get-value ( (select ex_spr_read (_ bv0 32) ) ) )
(get-value ( (select ex_spr_read (_ bv1 32) ) ) )
(get-value ( (select ex_spr_read (_ bv2 32) ) ) )
(get-value ( (select ex_spr_read (_ bv3 32) ) ) )
(get-value ( (select addrbase (_ bv0 32) ) ) )
(get-value ( (select addrbase (_ bv1 32) ) ) )
(get-value ( (select addrbase (_ bv2 32) ) ) )
(get-value ( (select addrbase (_ bv3 32) ) ) )
(get-value ( (select addrofs (_ bv0 32) ) ) )
(get-value ( (select addrofs (_ bv1 32) ) ) )
(get-value ( (select addrofs (_ bv2 32) ) ) )
(get-value ( (select addrofs (_ bv3 32) ) ) )
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
(get-value ( (select except_started (_ bv0 32) ) ) )
(get-value ( (select except_started (_ bv1 32) ) ) )
(get-value ( (select except_started (_ bv2 32) ) ) )
(get-value ( (select except_started (_ bv3 32) ) ) )
(get-value ( (select dsx (_ bv0 32) ) ) )
(get-value ( (select dsx (_ bv1 32) ) ) )
(get-value ( (select dsx (_ bv2 32) ) ) )
(get-value ( (select dsx (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.045704e-02
;   Solvable: false
