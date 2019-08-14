; Query 1145 -- Type: InitialValues, Instructions: 3500133
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cy_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun esr () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flag_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ov_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (concat  (select  esr (_ bv3 32) ) (concat  (select  esr (_ bv2 32) ) (concat  (select  esr (_ bv1 32) ) (select  esr (_ bv0 32) ) ) ) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B3 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) ) (let ( (?B4 (bvand  (bvshl  (bvand  (bvlshr  ?B1 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B5 (bvand  (bvshl  (bvand  (bvlshr  ?B1 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B10 (bvand  (bvlshr  ?B3 (_ bv11 32) ) (_ bv31 32) ) ) (?B6 (bvshl  (bvand  (bvlshr  ?B1 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B7 (bvshl  (bvand  (bvlshr  ?B1 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B8 (bvshl  (bvand  (bvlshr  ?B1 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B9 (bvshl  (bvand  (bvlshr  ?B1 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) ) (let ( (?B11 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B7 (_ bv4294966784 32) ) ?B5 ) (_ bv4294905855 32) ) ?B4 ) (_ bv4294965247 32) ) ?B6 ) (_ bv4294966271 32) ) ?B8 ) (_ bv4294966783 32) ) ?B9 ) (_ bv4294901759 32) ) ?B7 ) (_ bv4294966784 32) ) ?B5 ) (_ bv4294905855 32) ) ?B4 ) (_ bv4294965247 32) ) ?B6 ) (_ bv4294966271 32) ) ?B8 ) (_ bv4294966783 32) ) ?B9 ) (_ bv4294901759 32) ) ?B7 ) (_ bv4294966784 32) ) ?B5 ) (_ bv4294905855 32) ) ?B4 ) (_ bv4294965247 32) ) ?B6 ) (_ bv4294966271 32) ) ?B8 ) (_ bv4294966783 32) ) ?B9 ) ) (?B12 (=  (_ bv6 32) ?B10 ) ) ) (and  (and  (and  (and  (and  (and  (and  (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvor  (bvor  (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ?B2 ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (ite  ?B12 (_ bv64 32) (_ bv128 32) ) (bvsub  (_ bv0 32) (bvor  ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) (bvand  ?B2 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B11 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B11 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B11 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B3 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (_ bv1 32) ) ((_ zero_extend 24)  (select  flag_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  cy_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  ov_we (_ bv0 32) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite ?B12 (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B10 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv0 32) ?B10 ) ) ) (=  false (=  (_ bv1 32) ?B10 ) ) ) (=  false (=  (_ bv2 32) ?B10 ) ) ) (=  false (=  (_ bv3 32) ?B10 ) ) ) (=  false (=  (_ bv4 32) ?B10 ) ) ) (=  false (=  (_ bv5 32) ?B10 ) ) ) ) ) ) )
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
(get-value ( (select esr (_ bv0 32) ) ) )
(get-value ( (select esr (_ bv1 32) ) ) )
(get-value ( (select esr (_ bv2 32) ) ) )
(get-value ( (select esr (_ bv3 32) ) ) )
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
;   OK -- Elapsed: 8.092999e-03
;   Solvable: false
