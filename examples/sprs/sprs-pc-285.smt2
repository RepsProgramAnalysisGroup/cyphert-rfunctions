; Query 284 -- Type: InitialValues, Instructions: 1670709
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cyforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun dat_i () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ovforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (concat  (select  dat_i (_ bv3 32) ) (concat  (select  dat_i (_ bv2 32) ) (concat  (select  dat_i (_ bv1 32) ) (select  dat_i (_ bv0 32) ) ) ) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  (bvand  ((_ zero_extend 24)  (select  ovforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B6 (bvshl  (bvand  ((_ zero_extend 24)  (select  cyforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B12 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B11 ((_ zero_extend 24)  ((_ extract 7  0)  ?B2 ) ) ) (?B7 (bvand  (bvshl  (bvand  (bvor  (bvand  (bvlshr  ?B1 (_ bv12 32) ) (_ bv7 32) ) (_ bv8 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B8 (bvand  (bvshl  (bvand  (bvlshr  ?B1 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B9 (bvshl  (bvand  (bvlshr  ?B1 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B10 (bvshl  (bvand  (bvlshr  ?B1 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B13 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B10 (_ bv4294966784 32) ) ?B8 ) (_ bv4294905855 32) ) ?B7 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B9 ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B8 ) (_ bv4294905855 32) ) ?B7 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B9 ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B8 ) (_ bv4294905855 32) ) ?B7 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B9 ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B8 ) (_ bv4294905855 32) ) ?B7 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B9 ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B8 ) (_ bv4294905855 32) ) ?B7 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B9 ) ) ) (and  (and  (=  (_ bv0 32) (bvand  ?B11 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) (bvor  ?B3 (bvand  ?B2 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B13 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B13 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) (_ bv1 32) ) (_ bv0 32) ) ?B12 ) ) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) ) (=  false (=  (_ bv0 32) (bvand  ?B11 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) ?B3 ) (_ bv1 32) ) (_ bv0 32) ) ?B12 ) ) ) ) ) ) ) ) ) ) )
(check-sat)
(get-value ( (select ex_spr_write (_ bv0 32) ) ) )
(get-value ( (select ex_spr_write (_ bv1 32) ) ) )
(get-value ( (select ex_spr_write (_ bv2 32) ) ) )
(get-value ( (select ex_spr_write (_ bv3 32) ) ) )
(get-value ( (select ex_spr_read (_ bv0 32) ) ) )
(get-value ( (select ex_spr_read (_ bv1 32) ) ) )
(get-value ( (select ex_spr_read (_ bv2 32) ) ) )
(get-value ( (select ex_spr_read (_ bv3 32) ) ) )
(get-value ( (select addrbase (_ bv0 32) ) ) )
(get-value ( (select addrbase (_ bv1 32) ) ) )
(get-value ( (select addrbase (_ bv2 32) ) ) )
(get-value ( (select addrbase (_ bv3 32) ) ) )
(get-value ( (select addrofs (_ bv0 32) ) ) )
(get-value ( (select addrofs (_ bv1 32) ) ) )
(get-value ( (select addrofs (_ bv2 32) ) ) )
(get-value ( (select addrofs (_ bv3 32) ) ) )
(get-value ( (select dat_i (_ bv0 32) ) ) )
(get-value ( (select dat_i (_ bv1 32) ) ) )
(get-value ( (select dat_i (_ bv2 32) ) ) )
(get-value ( (select dat_i (_ bv3 32) ) ) )
(get-value ( (select ovforw (_ bv0 32) ) ) )
(get-value ( (select ovforw (_ bv1 32) ) ) )
(get-value ( (select ovforw (_ bv2 32) ) ) )
(get-value ( (select ovforw (_ bv3 32) ) ) )
(get-value ( (select cyforw (_ bv0 32) ) ) )
(get-value ( (select cyforw (_ bv1 32) ) ) )
(get-value ( (select cyforw (_ bv2 32) ) ) )
(get-value ( (select cyforw (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.170802e-02
;   Solvable: false
