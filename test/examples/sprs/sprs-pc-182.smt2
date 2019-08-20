; Query 181 -- Type: InitialValues, Instructions: 1004537
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun cy_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flag_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (and  (=  false (=  (_ bv0 8) (select  cy_we (_ bv0 32) ) ) ) (=  false (=  (_ bv0 8) (select  flag_we (_ bv0 32) ) ) ) ) )
(check-sat)
(get-value ( (select flag_we (_ bv0 32) ) ) )
(get-value ( (select flag_we (_ bv1 32) ) ) )
(get-value ( (select flag_we (_ bv2 32) ) ) )
(get-value ( (select flag_we (_ bv3 32) ) ) )
(get-value ( (select cy_we (_ bv0 32) ) ) )
(get-value ( (select cy_we (_ bv1 32) ) ) )
(get-value ( (select cy_we (_ bv2 32) ) ) )
(get-value ( (select cy_we (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 4.474044e-03
;   Solvable: true
;     flag_we = [1,255,255,255]
;     cy_we = [1,255,255,255]
