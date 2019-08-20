; Query 136 -- Type: InitialValues, Instructions: 3523967
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op2 () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv3 8) (select  alu_op2 (_ bv0 32) ) ) )
(check-sat)
(get-value ( (select alu_op2 (_ bv0 32) ) ) )
(get-value ( (select alu_op2 (_ bv1 32) ) ) )
(get-value ( (select alu_op2 (_ bv2 32) ) ) )
(get-value ( (select alu_op2 (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 6.171942e-03
;   Solvable: true
;     alu_op2 = [3,255,255,255]
