; Query 9 -- Type: InitialValues, Instructions: 12433
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun b () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (bvule  (bvand  (bvsub  (_ bv32 32) (bvand  (bvlshr  (concat  (select  b (_ bv3 32) ) (concat  (select  b (_ bv2 32) ) (concat  (select  b (_ bv1 32) ) (select  b (_ bv0 32) ) ) ) ) (_ bv0 32) ) (_ bv31 32) ) ) (_ bv63 32) ) (_ bv31 32) ) )
(check-sat)
(get-value ( (select b (_ bv0 32) ) ) )
(get-value ( (select b (_ bv1 32) ) ) )
(get-value ( (select b (_ bv2 32) ) ) )
(get-value ( (select b (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.155793e-02
;   Solvable: true
;     b = [1,255,255,255]
