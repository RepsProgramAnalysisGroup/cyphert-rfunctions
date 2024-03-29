; Query 2493 -- Type: InitialValues, Instructions: 8418816
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cy_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun cyforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ov_we () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ovforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  cy_we (_ bv0 32) ) ) (?B2 (select  ov_we (_ bv0 32) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  (bvand  ((_ zero_extend 24)  (select  ovforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B6 (bvshl  (bvand  ((_ zero_extend 24)  (select  cyforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B7 (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) (?B8 (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  ?B5 (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ) ) (let ( (?B10 (bvor  (bvshl  (bvand  (bvlshr  ?B8 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B8 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B8 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) (?B9 (=  (_ bv14 32) ?B7 ) ) ) (let ( (?B11 (bvand  (bvshl  (bvand  (bvlshr  ?B10 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B12 (bvand  (bvshl  (bvand  (bvlshr  ?B10 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B13 (bvshl  (bvand  (bvlshr  ?B10 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B14 (bvshl  (bvand  (bvlshr  ?B10 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B15 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B8 (_ bv4294901759 32) ) ?B14 ) (_ bv4294966784 32) ) ?B12 ) (_ bv4294905855 32) ) ?B11 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B13 ) (_ bv4294901759 32) ) ?B14 ) (_ bv4294966784 32) ) ?B12 ) (_ bv4294905855 32) ) ?B11 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B13 ) ) ) (let ( (?B16 (bvor  (bvshl  (bvand  (bvlshr  ?B15 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B15 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B15 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B17 (bvand  (bvshl  (bvand  (bvlshr  ?B16 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B18 (bvand  (bvshl  (bvand  (bvlshr  ?B16 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B19 (bvshl  (bvand  (bvlshr  ?B16 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B20 (bvshl  (bvand  (bvlshr  ?B16 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B21 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B15 (_ bv4294901759 32) ) ?B20 ) (_ bv4294966784 32) ) ?B17 ) (_ bv4294905855 32) ) ?B18 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B19 ) (_ bv4294901759 32) ) ?B20 ) (_ bv4294966784 32) ) ?B17 ) (_ bv4294905855 32) ) ?B18 ) (_ bv4294965247 32) ) ?B5 ) (_ bv4294966271 32) ) ?B6 ) (_ bv4294966783 32) ) ?B19 ) ) ) (and  (and  (and  (and  (and  (and  (and  (and  (and  (and  (=  (_ bv0 8) ((_ extract 7  0)  (bvor  (bvor  (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ?B3 ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (ite  ?B9 (_ bv16384 32) (_ bv32768 32) ) (bvsub  (_ bv0 32) (bvor  ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) (bvand  ?B3 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B21 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B21 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B21 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) ((_ zero_extend 24)  ?B1 ) ) ((_ zero_extend 24)  ?B2 ) ) ) ) (=  (_ bv0 32) (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  (bvor  ((_ zero_extend 31)  (ite (=  (_ bv0 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv1 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv2 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv3 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv4 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv5 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv6 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ((_ zero_extend 31)  (ite (=  (_ bv7 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) (=  false (=  (_ bv0 32) (bvor  ((_ zero_extend 31)  (ite ?B9 (_ bv1 1) (_ bv0 1) ) ) ((_ zero_extend 31)  (ite (=  (_ bv15 32) ?B7 ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) (=  false (=  (_ bv8 32) ?B7 ) ) ) (=  false (=  (_ bv9 32) ?B7 ) ) ) (=  false (=  (_ bv10 32) ?B7 ) ) ) (=  false (=  (_ bv11 32) ?B7 ) ) ) (=  false (=  (_ bv12 32) ?B7 ) ) ) (=  false (=  (_ bv13 32) ?B7 ) ) ) (=  false (=  (_ bv0 8) ?B2 ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) ) ) ) ) ) ) ) ) )
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
(get-value ( (select cyforw (_ bv0 32) ) ) )
(get-value ( (select cyforw (_ bv1 32) ) ) )
(get-value ( (select cyforw (_ bv2 32) ) ) )
(get-value ( (select cyforw (_ bv3 32) ) ) )
(get-value ( (select cy_we (_ bv0 32) ) ) )
(get-value ( (select cy_we (_ bv1 32) ) ) )
(get-value ( (select cy_we (_ bv2 32) ) ) )
(get-value ( (select cy_we (_ bv3 32) ) ) )
(get-value ( (select ov_we (_ bv0 32) ) ) )
(get-value ( (select ov_we (_ bv1 32) ) ) )
(get-value ( (select ov_we (_ bv2 32) ) ) )
(get-value ( (select ov_we (_ bv3 32) ) ) )
(exit)
;   OK -- Elapsed: 1.231503e-02
;   Solvable: false
