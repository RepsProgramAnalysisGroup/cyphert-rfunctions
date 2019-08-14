; Query 7 -- Type: InitialValues, Instructions: 43440
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun rfwb_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv1 32) (bvand  (bvlshr  ((_ zero_extend 24)  (select  rfwb_op (_ bv0 32) ) ) (_ bv1 32) ) (_ bv7 32) ) ) )
(check-sat)
(get-value ( (select rfwb_op (_ bv0 32) ) ) )
(get-value ( (select rfwb_op (_ bv1 32) ) ) )
(get-value ( (select rfwb_op (_ bv2 32) ) ) )
(get-value ( (select rfwb_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.824068e-03
;   Solvable: true
;     rfwb_op = [2,255,255,255]
