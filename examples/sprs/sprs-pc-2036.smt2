; Query 2035 -- Type: InitialValues, Instructions: 6496621
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cyforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flagforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B2 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B3 (bvshl  (bvand  ((_ zero_extend 24)  (select  flagforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B4 (bvshl  (bvand  ((_ zero_extend 24)  (select  cyforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B5 (bvand  (bvlshr  ?B2 (_ bv11 32) ) (_ bv31 32) ) ) (?B6 (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  ?B4 (_ bv4294966783 32) ) ?B3 ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B4 ) (_ bv4294966783 32) ) ?B3 ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B4 ) (_ bv4294966783 32) ) ?B3 ) ) ) (let ( (?B8 (bvor  (bvshl  (bvand  (bvlshr  ?B6 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B6 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B6 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (?B7 (=  (_ bv6 32) ?B5 ) ) ) (let ( (?B9 (bvand  (bvshl  (bvand  (bvlshr  ?B8 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B10 (bvand  (bvshl  (bvand  (bvlshr  ?B8 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B11 (bvshl  (bvand  (bvlshr  ?B8 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B12 (bvshl  (bvand  (bvlshr  ?B8 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B13 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B6 (_ bv4294901759 32) ) ?B12 ) (_ bv4294966784 32) ) ?B9 ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) ?B11 ) (_ bv4294966271 32) ) ?B4 ) (_ bv4294966783 32) ) ?B3 ) (_ bv4294901759 32) ) ?B12 ) (_ bv4294966784 32) ) ?B9 ) (_ bv4294905855 32) ) ?B10 ) (_ bv4294965247 32) ) ?B11 ) (_ bv4294966271 32) ) ?B4 ) (_ bv4294966783 32) ) ?B3 ) ) ) (let ( (?B14 (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B13 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B13 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B15 (bvand  (bvshl  (bvand  (bvlshr  ?B14 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B16 (bvand  (bvshl  (bvand  (bvlshr  ?B14 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B17 (bvshl  (bvand  (bvlshr  ?B14 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B18 (bvshl  (bvand  (bvlshr  ?B14 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B19 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B13 (_ bv4294901759 32) ) ?B17 ) (_ bv4294966784 32) ) ?B15 ) (_ bv4294905855 32) ) ?B16 ) (_ bv4294965247 32) ) ?B18 ) (_ bv4294966271 32) ) ?B4 ) (_ bv4294966783 32) ) ?B3 ) (_ bv4294901759 32) ) ?B17 ) (_ bv4294966784 32) ) ?B15 ) (_ bv4294905855 32) ) ?B16 ) (_ bv4294965247 32) ) ?B18 ) (_ bv4294966271 32) ) ?B4 ) (_ bv4294966783 32) ) ?B3 ) ) ) (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ?B1 ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (ite  ?B7 (_ bv64 32) (_ bv128 32) ) (bvsub  (_ bv0 32) (bvor  ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) (bvand  ?B1 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B19 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B19 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B19 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B2 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite ?B7 (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B5 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv0 32) ?B5 ) ) ) (=  false (=  (_ bv1 32) ?B5 ) ) ) (=  false (=  (_ bv2 32) ?B5 ) ) ) (=  false (=  (_ bv3 32) ?B5 ) ) ) (=  false (=  (_ bv4 32) ?B5 ) ) ) (=  false (=  (_ bv5 32) ?B5 ) ) ) ) ) ) ) ) ) ) ) )
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
(get-value ( (select flagforw (_ bv0 32) ) ) )
(get-value ( (select flagforw (_ bv1 32) ) ) )
(get-value ( (select flagforw (_ bv2 32) ) ) )
(get-value ( (select flagforw (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 9.948015e-03
;   Solvable: false
