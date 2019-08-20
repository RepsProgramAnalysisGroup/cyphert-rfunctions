; Query 24 -- Type: InitialValues, Instructions: 14520
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun comp_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  false (=  (_ bv0 32) (bvand  (bvlshr  ((_ zero_extend 24)  (select  comp_op (_ bv0 32) ) ) (_ bv3 32) ) (_ bv1 32) ) ) ) )
(check-sat)
(get-value ( (select comp_op (_ bv0 32) ) ) )
(get-value ( (select comp_op (_ bv1 32) ) ) )
(get-value ( (select comp_op (_ bv2 32) ) ) )
(get-value ( (select comp_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.484990e-03
;   Solvable: true
;     comp_op = [8,255,255,255]
