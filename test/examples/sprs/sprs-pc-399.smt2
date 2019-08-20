; Query 398 -- Type: InitialValues, Instructions: 2115942
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cy_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flag_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ov_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) ) (let ( (?B2 (bvand  (bvlshr  ?B1 (_ bv11 32) ) (_ bv31 32) ) ) ) (let ( (?B3 (=  (_ bv22 32) ?B2 ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvor  (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (ite  ?B3 (_ bv4194304 32) (_ bv8388608 32) ) (bvsub  (_ bv0 32) ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B1 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) ((_ zero_extend 24)  (select  flag_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  cy_we (_ bv0 32) ) ) ) ((_ zero_extend 24)  (select  ov_we (_ bv0 32) ) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv8 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv9 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv10 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv11 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv12 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv13 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv14 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite ?B3 (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv23 32) ?B2 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv16 32) ?B2 ) ) ) (=  false (=  (_ bv17 32) ?B2 ) ) ) (=  false (=  (_ bv18 32) ?B2 ) ) ) (=  false (=  (_ bv19 32) ?B2 ) ) ) (=  false (=  (_ bv20 32) ?B2 ) ) ) (=  false (=  (_ bv21 32) ?B2 ) ) ) ) ) ) )
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
(exit)
;   OK -- Elapsed: 2.157903e-02
;   Solvable: true
;     addrbase = [0,176,0,0]
;     addrofs = [0,0,255,255]
;     ex_spr_write = [255,255,255,255]
;     ex_spr_read = [255,255,255,255]
;     flag_we = [1,255,255,255]
;     cy_we = [0,255,255,255]
;     ov_we = [0,255,255,255]