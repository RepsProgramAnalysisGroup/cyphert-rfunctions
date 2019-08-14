; Query 76 -- Type: InitialValues, Instructions: 40832
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun alu_op () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  alu_op (_ bv0 32) ) ) ) (let ( (?B2 (=  (_ bv2 8) ?B1 ) ) ) (let ( (?B3 ((_ zero_extend 31)  (ite ?B2 (_ bv1 1) (_ bv0 1) ) ) ) ) (and  (and  (and  (and  (and  ?B2 (=  false (=  (_ bv1 8) ?B1 ) ) ) (=  (_ bv0 32) (bvor  ?B3 ((_ zero_extend 31)  (ite (=  (_ bv16 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv15 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv8 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (bvor  ?B3 ((_ zero_extend 31)  (ite (=  (_ bv0 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv12 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv13 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv17 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv9 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv10 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv11 8) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv14 8) ?B1 ) ) ) ) ) ) )
(check-sat)
(get-value ( (select alu_op (_ bv0 32) ) ) )
(get-value ( (select alu_op (_ bv1 32) ) ) )
(get-value ( (select alu_op (_ bv2 32) ) ) )
(get-value ( (select alu_op (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.692057e-03
;   Solvable: false
