; Query 60 -- Type: InitialValues, Instructions: 79162
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun ov_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  false (=  (_ bv0 8) (select  ov_we (_ bv0 32) ) ) ) )
(check-sat)
(get-value ( (select ov_we (_ bv0 32) ) ) )
(get-value ( (select ov_we (_ bv1 32) ) ) )
(get-value ( (select ov_we (_ bv2 32) ) ) )
(get-value ( (select ov_we (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.152085e-03
;   Solvable: true
;     ov_we = [1,255,255,255]
