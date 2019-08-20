; Query 40 -- Type: InitialValues, Instructions: 16555
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun comp_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 ((_ zero_extend 24)  (select  comp_op (_ bv0 32) ) ) ) ) (let ( (?B2 (bvand  (bvlshr  ?B1 (_ bv0 32) ) (_ bv7 32) ) ) ) (and  (and  (and  (=  false (=  (_ bv2 32) ?B2 ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv3 32) ) (_ bv1 32) ) ) ) (=  false (=  (_ bv0 32) ?B2 ) ) ) (=  false (=  (_ bv1 32) ?B2 ) ) ) ) ) )
(check-sat)
(get-value ( (select comp_op (_ bv0 32) ) ) )
(get-value ( (select comp_op (_ bv1 32) ) ) )
(get-value ( (select comp_op (_ bv2 32) ) ) )
(get-value ( (select comp_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.866698e-02
;   Solvable: true
;     comp_op = [3,255,255,255]
