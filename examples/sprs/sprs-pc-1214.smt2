; Query 1213 -- Type: InitialValues, Instructions: 3694889
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cy_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cyforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  cy_we (_ bv0 32) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  (bvand  ((_ zero_extend 24)  (select  cyforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B7 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B6 ((_ zero_extend 24)  ((_ extract 7  0)  ?B2 ) ) ) (?B8 (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvand  ?B5 (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B5 ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B5 ) (_ bv4294966783 32) ) ) ) (let ( (?B9 (bvor  (bvshl  (bvand  (bvlshr  ?B8 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B8 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B8 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B10 (bvand  (bvshl  (bvand  (bvlshr  ?B9 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B11 (bvand  (bvshl  (bvand  (bvlshr  ?B9 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B12 (bvshl  (bvand  (bvlshr  ?B9 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B13 (bvshl  (bvand  (bvlshr  ?B9 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B14 (bvshl  (bvand  (bvlshr  ?B9 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) ) (let ( (?B15 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B8 (_ bv4294901759 32) ) ?B12 ) (_ bv4294966784 32) ) ?B11 ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) ?B13 ) (_ bv4294966271 32) ) ?B5 ) (_ bv4294966783 32) ) ?B14 ) (_ bv4294901759 32) ) ?B12 ) (_ bv4294966784 32) ) ?B11 ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) ?B13 ) (_ bv4294966271 32) ) ?B5 ) (_ bv4294966783 32) ) ?B14 ) ) ) (let ( (?B16 (bvor  (bvshl  (bvand  (bvlshr  ?B15 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B15 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B15 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B17 (bvand  (bvshl  (bvand  (bvlshr  ?B16 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B18 (bvand  (bvshl  (bvand  (bvlshr  ?B16 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B19 (bvshl  (bvand  (bvlshr  ?B16 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B20 (bvshl  (bvand  (bvlshr  ?B16 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B21 (bvshl  (bvand  (bvlshr  ?B16 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B22 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B15 (_ bv4294901759 32) ) ?B21 ) (_ bv4294966784 32) ) ?B18 ) (_ bv4294905855 32) ) ?B17 ) (_ bv4294965247 32) ) ?B20 ) (_ bv4294966271 32) ) ?B5 ) (_ bv4294966783 32) ) ?B19 ) (_ bv4294901759 32) ) ?B21 ) (_ bv4294966784 32) ) ?B18 ) (_ bv4294905855 32) ) ?B17 ) (_ bv4294965247 32) ) ?B20 ) (_ bv4294966271 32) ) ?B5 ) (_ bv4294966783 32) ) ?B19 ) ) ) (and  (and  (and  (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvand  ?B6 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) (bvor  ?B3 (bvand  ?B2 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B22 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B22 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B22 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) (_ bv1 32) ) (_ bv0 32) ) ?B7 ) ) ) ) ((_ zero_extend 24)  ?B1 ) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) ) (=  (_ bv0 32) (bvand  ?B6 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) ?B3 ) (_ bv1 32) ) (_ bv0 32) ) ?B7 ) ) ) ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) ) ) ) ) ) ) ) ) )
(check-sat)
(get-value ( (select addrbase (_ bv0 32) ) ) )
(get-value ( (select addrbase (_ bv1 32) ) ) )
(get-value ( (select addrbase (_ bv2 32) ) ) )
(get-value ( (select addrbase (_ bv3 32) ) ) )
(get-value ( (select addrofs (_ bv0 32) ) ) )
(get-value ( (select addrofs (_ bv1 32) ) ) )
(get-value ( (select addrofs (_ bv2 32) ) ) )
(get-value ( (select addrofs (_ bv3 32) ) ) )
(get-value ( (select ex_spr_write (_ bv0 32) ) ) )
(get-value ( (select ex_spr_write (_ bv1 32) ) ) )
(get-value ( (select ex_spr_write (_ bv2 32) ) ) )
(get-value ( (select ex_spr_write (_ bv3 32) ) ) )
(get-value ( (select ex_spr_read (_ bv0 32) ) ) )
(get-value ( (select ex_spr_read (_ bv1 32) ) ) )
(get-value ( (select ex_spr_read (_ bv2 32) ) ) )
(get-value ( (select ex_spr_read (_ bv3 32) ) ) )
(get-value ( (select cyforw (_ bv0 32) ) ) )
(get-value ( (select cyforw (_ bv1 32) ) ) )
(get-value ( (select cyforw (_ bv2 32) ) ) )
(get-value ( (select cyforw (_ bv3 32) ) ) )
(get-value ( (select cy_we (_ bv0 32) ) ) )
(get-value ( (select cy_we (_ bv1 32) ) ) )
(get-value ( (select cy_we (_ bv2 32) ) ) )
(get-value ( (select cy_we (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 7.047892e-03
;   Solvable: false
