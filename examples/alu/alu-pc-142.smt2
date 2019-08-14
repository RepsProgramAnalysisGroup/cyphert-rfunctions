; Query 141 -- Type: InitialValues, Instructions: 6561479
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  alu_op (_ bv0 32) ) ) ) (and  (and  (and  (and  (and  (and  (and  (=  (_ bv17 8) ?B1 ) (=  false (=  (_ bv15 8) ?B1 ) ) ) (=  false (=  (_ bv8 8) ?B1 ) ) ) (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite (=  (_ bv2 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv0 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv5 8) ?B1 ) ) ) (=  false (=  (_ bv4 8) ?B1 ) ) ) (=  false (=  (_ bv12 8) ?B1 ) ) ) (=  false (=  (_ bv13 8) ?B1 ) ) ) ) )
(check-sat)
(get-value ( (select alu_op (_ bv0 32) ) ) )
(get-value ( (select alu_op (_ bv1 32) ) ) )
(get-value ( (select alu_op (_ bv2 32) ) ) )
(get-value ( (select alu_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.027000e-02
;   Solvable: true
;     alu_op = [17,255,255,255]
