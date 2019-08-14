; Query 5 -- Type: InitialValues, Instructions: 12092
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op2 () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  alu_op2 (_ bv0 32) ) ) ) (and  (and  (and  (=  false (=  (_ bv3 8) ?B1 ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) (=  false (=  (_ bv1 8) ?B1 ) ) ) (=  false (=  (_ bv2 8) ?B1 ) ) ) ) )
(check-sat)
(get-value ( (select alu_op2 (_ bv0 32) ) ) )
(get-value ( (select alu_op2 (_ bv1 32) ) ) )
(get-value ( (select alu_op2 (_ bv2 32) ) ) )
(get-value ( (select alu_op2 (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.234496e-02
;   Solvable: true
;     alu_op2 = [4,255,255,255]
