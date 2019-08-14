; Query 42 -- Type: InitialValues, Instructions: 69089
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun branch_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv6 8) (select  branch_op (_ bv0 32) ) ) )
(check-sat)
(get-value ( (select branch_op (_ bv0 32) ) ) )
(get-value ( (select branch_op (_ bv1 32) ) ) )
(get-value ( (select branch_op (_ bv2 32) ) ) )
(get-value ( (select branch_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.264023e-03
;   Solvable: true
;     branch_op = [6,255,255,255]
