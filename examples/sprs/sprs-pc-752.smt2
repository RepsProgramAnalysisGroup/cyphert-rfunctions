; Query 751 -- Type: InitialValues, Instructions: 3044262
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flag_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ov_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  flag_we (_ bv0 32) ) ) (?B2 (select  ov_we (_ bv0 32) ) ) (?B3 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) ) (and  (and  (and  (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (_ bv4096 32) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B3 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) ((_ zero_extend 24)  ?B1 ) ) ((_ zero_extend 24)  ?B2 ) ) ) ) (=  (_ bv12 32) (bvand  (bvlshr  ?B3 (_ bv11 32) ) (_ bv31 32) ) ) ) (=  false (=  (_ bv0 8) ?B2 ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) ) )
(check-sat)
(get-value ( (select flag_we (_ bv0 32) ) ) )
(get-value ( (select flag_we (_ bv1 32) ) ) )
(get-value ( (select flag_we (_ bv2 32) ) ) )
(get-value ( (select flag_we (_ bv3 32) ) ) )
(get-value ( (select ov_we (_ bv0 32) ) ) )
(get-value ( (select ov_we (_ bv1 32) ) ) )
(get-value ( (select ov_we (_ bv2 32) ) ) )
(get-value ( (select ov_we (_ bv3 32) ) ) )
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
(exit)
;   OK -- Elapsed: 6.786942e-03
;   Solvable: false
