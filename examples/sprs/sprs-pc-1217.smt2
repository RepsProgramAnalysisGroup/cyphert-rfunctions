; Query 1216 -- Type: InitialValues, Instructions: 3703469
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flagforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ovforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B3 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B4 (bvshl  (bvand  ((_ zero_extend 24)  (select  flagforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B5 (bvshl  (bvand  ((_ zero_extend 24)  (select  ovforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B7 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B3 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B6 ((_ zero_extend 24)  ((_ extract 7  0)  ?B1 ) ) ) (?B8 (bvor  (bvand  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvand  ?B5 (_ bv4294966271 32) ) (_ bv4294966783 32) ) ?B4 ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ?B4 ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ?B4 ) ) ) (let ( (?B9 (bvor  (bvshl  (bvand  (bvlshr  ?B8 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B8 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B8 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B10 (bvand  (bvshl  (bvand  (bvlshr  ?B9 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B11 (bvand  (bvshl  (bvand  (bvlshr  ?B9 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B12 (bvshl  (bvand  (bvlshr  ?B9 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B13 (bvshl  (bvand  (bvlshr  ?B9 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B14 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B8 (_ bv4294901759 32) ) ?B13 ) (_ bv4294966784 32) ) ?B11 ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B12 ) (_ bv4294966783 32) ) ?B4 ) (_ bv4294901759 32) ) ?B13 ) (_ bv4294966784 32) ) ?B11 ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B12 ) (_ bv4294966783 32) ) ?B4 ) ) ) (let ( (?B15 (bvor  (bvshl  (bvand  (bvlshr  ?B14 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B14 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B14 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B16 (bvand  (bvshl  (bvand  (bvlshr  ?B15 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B17 (bvand  (bvshl  (bvand  (bvlshr  ?B15 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B18 (bvshl  (bvand  (bvlshr  ?B15 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B19 (bvshl  (bvand  (bvlshr  ?B15 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B20 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B14 (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B17 ) (_ bv4294905855 32) ) ?B16 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B18 ) (_ bv4294966783 32) ) ?B4 ) (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B17 ) (_ bv4294905855 32) ) ?B16 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B18 ) (_ bv4294966783 32) ) ?B4 ) ) ) (let ( (?B21 (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B20 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B20 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B22 (bvand  (bvshl  (bvand  (bvlshr  ?B21 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B23 (bvand  (bvshl  (bvand  (bvlshr  ?B21 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B24 (bvshl  (bvand  (bvlshr  ?B21 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B25 (bvshl  (bvand  (bvlshr  ?B21 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B26 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B20 (_ bv4294901759 32) ) ?B24 ) (_ bv4294966784 32) ) ?B23 ) (_ bv4294905855 32) ) ?B22 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B25 ) (_ bv4294966783 32) ) ?B4 ) (_ bv4294901759 32) ) ?B24 ) (_ bv4294966784 32) ) ?B23 ) (_ bv4294905855 32) ) ?B22 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B25 ) (_ bv4294966783 32) ) ?B4 ) ) ) (and  (and  (=  false (=  (_ bv0 32) (bvand  ?B6 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) (bvor  ?B2 (bvand  ?B1 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B26 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B26 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B26 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) (_ bv1 32) ) (_ bv0 32) ) ?B7 ) ) ) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B3 (_ bv11 32) ) (_ bv31 32) ) ) ) (=  (_ bv0 32) (bvand  ?B6 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) ?B2 ) (_ bv1 32) ) (_ bv0 32) ) ?B7 ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )
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
(get-value ( (select ovforw (_ bv0 32) ) ) )
(get-value ( (select ovforw (_ bv1 32) ) ) )
(get-value ( (select ovforw (_ bv2 32) ) ) )
(get-value ( (select ovforw (_ bv3 32) ) ) )
(get-value ( (select flagforw (_ bv0 32) ) ) )
(get-value ( (select flagforw (_ bv1 32) ) ) )
(get-value ( (select flagforw (_ bv2 32) ) ) )
(get-value ( (select flagforw (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 6.847978e-03
;   Solvable: false
