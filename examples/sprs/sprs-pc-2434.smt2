; Query 2433 -- Type: InitialValues, Instructions: 8066870
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cyforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B2 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B3 (bvshl  (bvand  ((_ zero_extend 24)  (select  cyforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B4 (bvand  (bvlshr  ?B2 (_ bv11 32) ) (_ bv31 32) ) ) (?B5 (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvand  ?B3 (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B3 ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) ?B3 ) (_ bv4294966783 32) ) ) ) (let ( (?B7 (bvor  (bvshl  (bvand  (bvlshr  ?B5 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B5 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B5 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (?B6 (=  (_ bv22 32) ?B4 ) ) ) (let ( (?B8 (bvand  (bvshl  (bvand  (bvlshr  ?B7 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B9 (bvand  (bvshl  (bvand  (bvlshr  ?B7 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B10 (bvshl  (bvand  (bvlshr  ?B7 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B11 (bvshl  (bvand  (bvlshr  ?B7 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B12 (bvshl  (bvand  (bvlshr  ?B7 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) ) (let ( (?B13 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B5 (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B9 ) (_ bv4294905855 32) ) ?B8 ) (_ bv4294965247 32) ) ?B11 ) (_ bv4294966271 32) ) ?B3 ) (_ bv4294966783 32) ) ?B12 ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B9 ) (_ bv4294905855 32) ) ?B8 ) (_ bv4294965247 32) ) ?B11 ) (_ bv4294966271 32) ) ?B3 ) (_ bv4294966783 32) ) ?B12 ) ) ) (let ( (?B14 (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B13 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B13 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B15 (bvand  (bvshl  (bvand  (bvlshr  ?B14 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B16 (bvand  (bvshl  (bvand  (bvlshr  ?B14 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B17 (bvshl  (bvand  (bvlshr  ?B14 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B18 (bvshl  (bvand  (bvlshr  ?B14 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B19 (bvshl  (bvand  (bvlshr  ?B14 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B20 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B13 (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B16 ) (_ bv4294905855 32) ) ?B15 ) (_ bv4294965247 32) ) ?B18 ) (_ bv4294966271 32) ) ?B3 ) (_ bv4294966783 32) ) ?B17 ) (_ bv4294901759 32) ) ?B19 ) (_ bv4294966784 32) ) ?B16 ) (_ bv4294905855 32) ) ?B15 ) (_ bv4294965247 32) ) ?B18 ) (_ bv4294966271 32) ) ?B3 ) (_ bv4294966783 32) ) ?B17 ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  false (=  (_ bv0 32) (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ?B1 ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (ite  ?B6 (_ bv4194304 32) (_ bv8388608 32) ) (bvsub  (_ bv0 32) (bvor  ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) (bvand  ?B1 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B20 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B20 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B2 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv8 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv9 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv10 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv11 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv12 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv13 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv14 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite ?B6 (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv23 32) ?B4 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv16 32) ?B4 ) ) ) (=  false (=  (_ bv17 32) ?B4 ) ) ) (=  false (=  (_ bv18 32) ?B4 ) ) ) (=  false (=  (_ bv19 32) ?B4 ) ) ) (=  false (=  (_ bv20 32) ?B4 ) ) ) (=  false (=  (_ bv21 32) ?B4 ) ) ) ) ) ) ) ) ) ) ) )
(check-sat)
(get-value ( (select ex_spr_write (_ bv0 32) ) ) )
(get-value ( (select ex_spr_write (_ bv1 32) ) ) )
(get-value ( (select ex_spr_write (_ bv2 32) ) ) )
(get-value ( (select ex_spr_write (_ bv3 32) ) ) )
(get-value ( (select addrbase (_ bv0 32) ) ) )
(get-value ( (select addrbase (_ bv1 32) ) ) )
(get-value ( (select addrbase (_ bv2 32) ) ) )
(get-value ( (select addrbase (_ bv3 32) ) ) )
(get-value ( (select addrofs (_ bv0 32) ) ) )
(get-value ( (select addrofs (_ bv1 32) ) ) )
(get-value ( (select addrofs (_ bv2 32) ) ) )
(get-value ( (select addrofs (_ bv3 32) ) ) )
(get-value ( (select ex_spr_read (_ bv0 32) ) ) )
(get-value ( (select ex_spr_read (_ bv1 32) ) ) )
(get-value ( (select ex_spr_read (_ bv2 32) ) ) )
(get-value ( (select ex_spr_read (_ bv3 32) ) ) )
(get-value ( (select cyforw (_ bv0 32) ) ) )
(get-value ( (select cyforw (_ bv1 32) ) ) )
(get-value ( (select cyforw (_ bv2 32) ) ) )
(get-value ( (select cyforw (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.657891e-02
;   Solvable: false
