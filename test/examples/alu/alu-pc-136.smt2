; Query 135 -- Type: InitialValues, Instructions: 2586263
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv14 8) (select  alu_op (_ bv0 32) ) ) )
(check-sat)
(get-value ( (select alu_op (_ bv0 32) ) ) )
(get-value ( (select alu_op (_ bv1 32) ) ) )
(get-value ( (select alu_op (_ bv2 32) ) ) )
(get-value ( (select alu_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 7.400990e-03
;   Solvable: true
;     alu_op = [14,255,255,255]
