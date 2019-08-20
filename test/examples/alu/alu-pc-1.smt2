; Query 0 -- Type: InitialValues, Instructions: 9754
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun model_version () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv1 32) (concat  (select  model_version (_ bv3 32) ) (concat  (select  model_version (_ bv2 32) ) (concat  (select  model_version (_ bv1 32) ) (select  model_version (_ bv0 32) ) ) ) ) ) )
(check-sat)
(get-value ( (select model_version (_ bv0 32) ) ) )
(get-value ( (select model_version (_ bv1 32) ) ) )
(get-value ( (select model_version (_ bv2 32) ) ) )
(get-value ( (select model_version (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.581954e-03
;   Solvable: true
;     model_version = [1,0,0,0]
