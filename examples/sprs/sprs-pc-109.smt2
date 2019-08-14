; Query 108 -- Type: InitialValues, Instructions: 307524
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (bvand  (bvlshr  (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) (_ bv11 32) ) (_ bv31 32) ) ) ) (let ( (?B2 ((_ zero_extend 31)  (ite (=  (_ bv9 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B3 ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B4 ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B5 ((_ zero_extend 31)  (ite (=  (_ bv10 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B6 ((_ zero_extend 31)  (ite (=  (_ bv8 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B7 ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B8 ((_ zero_extend 31)  (ite (=  (_ bv11 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B9 ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ?B4 ?B5 ) ?B2 ) ?B6 ) ?B3 ) ?B9 ) ?B7 ) ?B8 ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ?B4 ?B3 ) ?B9 ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ?B7 ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ?B6 ?B2 ) ?B5 ) ?B8 ) ((_ zero_extend 31)  (ite (=  (_ bv12 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv13 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv14 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite (=  (_ bv22 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv23 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv16 32) ?B1 ) ) ) (=  false (=  (_ bv17 32) ?B1 ) ) ) (=  false (=  (_ bv18 32) ?B1 ) ) ) (=  false (=  (_ bv19 32) ?B1 ) ) ) (=  false (=  (_ bv20 32) ?B1 ) ) ) (=  false (=  (_ bv21 32) ?B1 ) ) ) ) ) )
(check-sat)
(get-value ( (select addrbase (_ bv0 32) ) ) )
(get-value ( (select addrbase (_ bv1 32) ) ) )
(get-value ( (select addrbase (_ bv2 32) ) ) )
(get-value ( (select addrbase (_ bv3 32) ) ) )
(get-value ( (select addrofs (_ bv0 32) ) ) )
(get-value ( (select addrofs (_ bv1 32) ) ) )
(get-value ( (select addrofs (_ bv2 32) ) ) )
(get-value ( (select addrofs (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 3.996968e-03
;   Solvable: false
