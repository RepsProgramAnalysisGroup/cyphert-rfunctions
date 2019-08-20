; Query 45 -- Type: InitialValues, Instructions: 69807
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun except_started () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (=  false (=  (_ bv0 8) (select  except_started (_ bv0 32) ) ) ) )
(check-sat)
(get-value ( (select except_started (_ bv0 32) ) ) )
(get-value ( (select except_started (_ bv1 32) ) ) )
(get-value ( (select except_started (_ bv2 32) ) ) )
(get-value ( (select except_started (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 2.210975e-03
;   Solvable: true
;     except_started = [1,255,255,255]
