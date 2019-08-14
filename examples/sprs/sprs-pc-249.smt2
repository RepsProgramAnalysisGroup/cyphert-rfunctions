; Query 248 -- Type: InitialValues, Instructions: 1387925
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun flag_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  flag_we (_ bv0 32) ) ) ) (and  (=  (_ bv0 8) ((_ extract 7  0)  ((_ zero_extend 24)  ?B1 ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) ) )
(check-sat)
(get-value ( (select flag_we (_ bv0 32) ) ) )
(get-value ( (select flag_we (_ bv1 32) ) ) )
(get-value ( (select flag_we (_ bv2 32) ) ) )
(get-value ( (select flag_we (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 3.004909e-03
;   Solvable: false
