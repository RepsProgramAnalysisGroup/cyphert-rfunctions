; Query 2400 -- Type: InitialValues, Instructions: 7994610
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
(assert (let ( (?B1 (select  except_started (_ bv0 32) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  ((_ zero_extend 24)  (select  dsx (_ bv0 32) ) ) (_ bv1 32) ) ) ) (let ( (?B8 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B7 ((_ zero_extend 24)  ((_ extract 7  0)  ?B2 ) ) ) (?B6 ((_ zero_extend 24)  ?B1 ) ) (?B10 (bvand  (bvshl  (bvand  ?B5 (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B9 (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) ) (let ( (?B12 (ite  (=  (_ bv30 32) ?B9 ) (_ bv1073741824 32) (_ bv2147483648 32) ) ) (?B11 (bvshl  (bvand  ?B6 (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B13 (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  ?B11 (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ) ) (let ( (?B14 (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B13 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B13 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B15 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B14 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B16 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B14 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B14 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B17 (bvshl  (bvand  (bvlshr  ?B14 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B18 (bvshl  (bvand  (bvlshr  ?B14 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B19 (bvshl  (bvand  (bvor  ?B6 (bvlshr  ?B14 (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B20 (bvshl  (bvand  (bvlshr  ?B14 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B21 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B13 (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B16 ) (_ bv4294905855 32) ) ?B15 ) (_ bv4294965247 32) ) ?B17 ) (_ bv4294966271 32) ) ?B20 ) (_ bv4294966783 32) ) ?B18 ) (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B16 ) (_ bv4294905855 32) ) ?B15 ) (_ bv4294965247 32) ) ?B17 ) (_ bv4294966271 32) ) ?B20 ) (_ bv4294966783 32) ) ?B18 ) ) ) (let ( (?B22 (bvor  (bvshl  (bvand  (bvlshr  ?B21 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B21 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B21 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B23 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B22 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B22 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B24 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B22 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B25 (bvshl  (bvand  (bvlshr  ?B22 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B26 (bvshl  (bvand  (bvlshr  ?B22 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B27 (bvshl  (bvand  (bvor  ?B6 (bvlshr  ?B22 (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B28 (bvshl  (bvand  (bvlshr  ?B22 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B29 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B21 (_ bv4294901759 32) ) ?B27 ) (_ bv4294966784 32) ) ?B23 ) (_ bv4294905855 32) ) ?B24 ) (_ bv4294965247 32) ) ?B28 ) (_ bv4294966271 32) ) ?B25 ) (_ bv4294966783 32) ) ?B26 ) (_ bv4294901759 32) ) ?B27 ) (_ bv4294966784 32) ) ?B23 ) (_ bv4294905855 32) ) ?B24 ) (_ bv4294965247 32) ) ?B28 ) (_ bv4294966271 32) ) ?B25 ) (_ bv4294966783 32) ) ?B26 ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  ?B12 (bvsub  (_ bv0 32) (bvor  ?B3 (bvand  ?B2 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B29 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B29 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B29 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ?B8 ) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv8 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv9 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv10 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv11 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv12 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv13 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv14 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv16 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv18 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv19 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv20 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv21 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv22 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv23 32) ?B9 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv24 32) ?B9 ) ) ) (=  false (=  (_ bv25 32) ?B9 ) ) ) (=  false (=  (_ bv26 32) ?B9 ) ) ) (=  false (=  (_ bv27 32) ?B9 ) ) ) (=  false (=  (_ bv28 32) ?B9 ) ) ) (=  false (=  (_ bv29 32) ?B9 ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) (=  false (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvor  (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  ?B12 (bvsub  (_ bv0 32) ?B3 ) ) (_ bv0 32) ) ?B8 ) ) ) ) ((_ zero_extend 24)  (select  flag_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  cy_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  ov_we (_ bv0 32) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )
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
;   OK -- Elapsed: 1.433301e-02
;   Solvable: false
