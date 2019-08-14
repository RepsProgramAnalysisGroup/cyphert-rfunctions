; Query 132 -- Type: InitialValues, Instructions: 1791647
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op2 () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv2 8) (select  alu_op2 (_ bv0 32) ) ) )
(check-sat)
(get-value ( (select alu_op2 (_ bv0 32) ) ) )
(get-value ( (select alu_op2 (_ bv1 32) ) ) )
(get-value ( (select alu_op2 (_ bv2 32) ) ) )
(get-value ( (select alu_op2 (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 4.703999e-03
;   Solvable: true
;     alu_op2 = [2,255,255,255]
