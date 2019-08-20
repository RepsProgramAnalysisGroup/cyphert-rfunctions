; Query 8 -- Type: InitialValues, Instructions: 12319
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  alu_op (_ bv0 32) ) ) ) (and  (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite (=  (_ bv2 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv16 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv1 8) ?B1 ) ) ) ) )
(check-sat)
(get-value ( (select alu_op (_ bv0 32) ) ) )
(get-value ( (select alu_op (_ bv1 32) ) ) )
(get-value ( (select alu_op (_ bv2 32) ) ) )
(get-value ( (select alu_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.381505e-02
;   Solvable: true
;     alu_op = [2,255,255,255]
