; Query 6 -- Type: InitialValues, Instructions: 12169
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun b () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  false (bvult  ((_ zero_extend 32)  (bvand  (bvlshr  (concat  (select  b (_ bv3 32) ) (concat  (select  b (_ bv2 32) ) (concat  (select  b (_ bv1 32) ) (select  b (_ bv0 32) ) ) ) ) (_ bv0 32) ) (_ bv31 32) ) ) (_ bv32 64) ) ) )
(check-sat)
(get-value ( (select b (_ bv0 32) ) ) )
(get-value ( (select b (_ bv1 32) ) ) )
(get-value ( (select b (_ bv2 32) ) ) )
(get-value ( (select b (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.713037e-03
;   Solvable: false
