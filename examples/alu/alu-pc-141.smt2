; Query 140 -- Type: InitialValues, Instructions: 5940551
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  (_ bv13 8) (select  alu_op (_ bv0 32) ) ) )
(check-sat)
(get-value ( (select alu_op (_ bv0 32) ) ) )
(get-value ( (select alu_op (_ bv1 32) ) ) )
(get-value ( (select alu_op (_ bv2 32) ) ) )
(get-value ( (select alu_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 9.068966e-03
;   Solvable: true
;     alu_op = [13,255,255,255]
