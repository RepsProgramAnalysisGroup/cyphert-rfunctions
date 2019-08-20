; Query 4 -- Type: InitialValues, Instructions: 11804
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun rfwb_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (bvand  (bvlshr  ((_ zero_extend 24)  (select  rfwb_op (_ bv0 32) ) ) (_ bv1 32) ) (_ bv7 32) ) ) ) (and  (and  (=  false (=  (_ bv2 32) ?B1 ) ) (=  false (=  (_ bv0 32) ?B1 ) ) ) (=  false (=  (_ bv1 32) ?B1 ) ) ) ) )
(check-sat)
(get-value ( (select rfwb_op (_ bv0 32) ) ) )
(get-value ( (select rfwb_op (_ bv1 32) ) ) )
(get-value ( (select rfwb_op (_ bv2 32) ) ) )
(get-value ( (select rfwb_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.256906e-02
;   Solvable: true
;     rfwb_op = [6,255,255,255]
