; Query 122 -- Type: InitialValues, Instructions: 460281
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op2 () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv1 8) (select  alu_op2 (_ bv0 32) ) ) )
(check-sat)
(get-value ( (select alu_op2 (_ bv0 32) ) ) )
(get-value ( (select alu_op2 (_ bv1 32) ) ) )
(get-value ( (select alu_op2 (_ bv2 32) ) ) )
(get-value ( (select alu_op2 (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.164960e-03
;   Solvable: true
;     alu_op2 = [1,255,255,255]
