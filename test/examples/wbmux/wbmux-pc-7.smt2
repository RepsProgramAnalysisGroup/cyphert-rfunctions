; Query 6 -- Type: InitialValues, Instructions: 13693
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun wb_freeze () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv0 32) (bvand  (bvxor  (_ bv4294967295 32) ((_ zero_extend 24)  (select  wb_freeze (_ bv0 32) ) ) ) (_ bv1 32) ) ) )
(check-sat)
(get-value ( (select wb_freeze (_ bv0 32) ) ) )
(get-value ( (select wb_freeze (_ bv1 32) ) ) )
(get-value ( (select wb_freeze (_ bv2 32) ) ) )
(get-value ( (select wb_freeze (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.902985e-03
;   Solvable: true
;     wb_freeze = [1,255,255,255]
