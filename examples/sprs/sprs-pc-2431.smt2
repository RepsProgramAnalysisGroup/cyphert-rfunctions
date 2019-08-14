; Query 2430 -- Type: InitialValues, Instructions: 8060812
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cy_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cyforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flag_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun flagforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  flag_we (_ bv0 32) ) ) (?B2 (select  cy_we (_ bv0 32) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  (bvand  ((_ zero_extend 24)  (select  flagforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B6 (bvshl  (bvand  ((_ zero_extend 24)  (select  cyforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B7 (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) (?B8 (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  ?B6 (_ bv4294966783 32) ) ?B5 ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B5 ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B5 ) ) ) (let ( (?B9 (bvor  (bvshl  (bvand  (bvlshr  ?B8 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B8 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B8 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B10 (bvand  (bvshl  (bvand  (bvlshr  ?B9 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B11 (bvand  (bvshl  (bvand  (bvlshr  ?B9 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B12 (bvshl  (bvand  (bvlshr  ?B9 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B13 (bvshl  (bvand  (bvlshr  ?B9 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B14 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B8 (_ bv4294901759 32) ) ?B13 ) (_ bv4294966784 32) ) ?B10 ) (_ bv4294905855 32) ) ?B11 ) (_ bv4294965247 32) ) ?B12 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B5 ) (_ bv4294901759 32) ) ?B13 ) (_ bv4294966784 32) ) ?B10 ) (_ bv4294905855 32) ) ?B11 ) (_ bv4294965247 32) ) ?B12 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B5 ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ?B3 ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (ite  (=  (_ bv30 32) ?B7 ) (_ bv1073741824 32) (_ bv2147483648 32) ) (bvsub  (_ bv0 32) (bvor  ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) (bvand  ?B3 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B14 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B14 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B14 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) ((_ zero_extend 24)  ?B1 ) ) ((_ zero_extend 24)  ?B2 ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv8 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv9 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv10 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv11 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv12 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv13 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv14 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv16 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv18 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv19 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv20 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv21 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv22 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv23 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv24 32) ?B7 ) ) ) (=  false (=  (_ bv25 32) ?B7 ) ) ) (=  false (=  (_ bv26 32) ?B7 ) ) ) (=  false (=  (_ bv27 32) ?B7 ) ) ) (=  false (=  (_ bv28 32) ?B7 ) ) ) (=  false (=  (_ bv29 32) ?B7 ) ) ) (=  false (=  (_ bv0 8) ?B2 ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) ) ) ) ) ) )
(check-sat)
(get-value ( (select addrbase (_ bv0 32) ) ) )
(get-value ( (select addrbase (_ bv1 32) ) ) )
(get-value ( (select addrbase (_ bv2 32) ) ) )
(get-value ( (select addrbase (_ bv3 32) ) ) )
(get-value ( (select addrofs (_ bv0 32) ) ) )
(get-value ( (select addrofs (_ bv1 32) ) ) )
(get-value ( (select addrofs (_ bv2 32) ) ) )
(get-value ( (select addrofs (_ bv3 32) ) ) )
(get-value ( (select flag_we (_ bv0 32) ) ) )
(get-value ( (select flag_we (_ bv1 32) ) ) )
(get-value ( (select flag_we (_ bv2 32) ) ) )
(get-value ( (select flag_we (_ bv3 32) ) ) )
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
(get-value ( (select cy_we (_ bv0 32) ) ) )
(get-value ( (select cy_we (_ bv1 32) ) ) )
(get-value ( (select cy_we (_ bv2 32) ) ) )
(get-value ( (select cy_we (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 8.897066e-03
;   Solvable: false
