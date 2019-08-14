; Query 59 -- Type: InitialValues, Instructions: 24324
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun a () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (concat  (select  a (_ bv3 32) ) (concat  (select  a (_ bv2 32) ) (concat  (select  a (_ bv1 32) ) (select  a (_ bv0 32) ) ) ) ) ) ) (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv7 32) ) (_ bv1 32) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv0 32) ) (_ bv1 32) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv1 32) ) (_ bv1 32) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv2 32) ) (_ bv1 32) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv3 32) ) (_ bv1 32) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv4 32) ) (_ bv1 32) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv5 32) ) (_ bv1 32) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B1 (_ bv6 32) ) (_ bv1 32) ) ) ) ) )
(check-sat)
(get-value ( (select a (_ bv0 32) ) ) )
(get-value ( (select a (_ bv1 32) ) ) )
(get-value ( (select a (_ bv2 32) ) ) )
(get-value ( (select a (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 3.398061e-03
;   Solvable: true
;     a = [128,255,255,255]
