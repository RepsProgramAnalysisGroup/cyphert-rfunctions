; Query 43 -- Type: InitialValues, Instructions: 17338
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun macrc_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  false (=  (_ bv0 8) (select  macrc_op (_ bv0 32) ) ) ) )
(check-sat)
(get-value ( (select macrc_op (_ bv0 32) ) ) )
(get-value ( (select macrc_op (_ bv1 32) ) ) )
(get-value ( (select macrc_op (_ bv2 32) ) ) )
(get-value ( (select macrc_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.455950e-03
;   Solvable: true
;     macrc_op = [1,255,255,255]
