; Query 23 -- Type: InitialValues, Instructions: 14512
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun flag () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  false (=  (_ bv0 8) (select  flag (_ bv0 32) ) ) ) )
(check-sat)
(get-value ( (select flag (_ bv0 32) ) ) )
(get-value ( (select flag (_ bv1 32) ) ) )
(get-value ( (select flag (_ bv2 32) ) ) )
(get-value ( (select flag (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.937913e-03
;   Solvable: true
;     flag = [1,255,255,255]
