; Query 107 -- Type: InitialValues, Instructions: 302768
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (bvand  (bvlshr  (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) (_ bv11 32) ) (_ bv31 32) ) ) ) (let ( (?B2 ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) (?B3 (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvor  ?B3 ?B2 ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  ?B3 ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ?B2 ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite (=  (_ bv14 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B1 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv8 32) ?B1 ) ) ) (=  false (=  (_ bv9 32) ?B1 ) ) ) (=  false (=  (_ bv10 32) ?B1 ) ) ) (=  false (=  (_ bv11 32) ?B1 ) ) ) (=  false (=  (_ bv12 32) ?B1 ) ) ) (=  false (=  (_ bv13 32) ?B1 ) ) ) ) ) )
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
;   OK -- Elapsed: 3.664017e-03
;   Solvable: false