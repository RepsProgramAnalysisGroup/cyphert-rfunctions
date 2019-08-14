; Query 2515 -- Type: InitialValues, Instructions: 8482611
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ovforw () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B2 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B3 (bvshl  (bvand  ((_ zero_extend 24)  (select  ovforw (_ bv0 32) ) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B4 (bvand  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvand  (bvand  ?B3 (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) (_ bv4294966784 32) ) (_ bv4294905855 32) ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ) ) (let ( (?B5 (bvor  (bvshl  (bvand  (bvlshr  ?B4 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B4 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B6 (bvand  (bvshl  (bvand  (bvlshr  ?B5 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B7 (bvand  (bvshl  (bvand  (bvlshr  ?B5 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B8 (bvshl  (bvand  (bvlshr  ?B5 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B9 (bvshl  (bvand  (bvlshr  ?B5 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B10 (bvshl  (bvand  (bvlshr  ?B5 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B11 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B4 (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B7 ) (_ bv4294905855 32) ) ?B6 ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) ?B8 ) (_ bv4294966783 32) ) ?B9 ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) ?B7 ) (_ bv4294905855 32) ) ?B6 ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) ?B8 ) (_ bv4294966783 32) ) ?B9 ) ) ) (let ( (?B12 (bvor  (bvshl  (bvand  (bvlshr  ?B11 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B11 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B11 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B13 (bvand  (bvshl  (bvand  (bvlshr  ?B12 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B14 (bvand  (bvshl  (bvand  (bvlshr  ?B12 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B15 (bvshl  (bvand  (bvlshr  ?B12 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) (?B16 (bvshl  (bvand  (bvlshr  ?B12 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B17 (bvshl  (bvand  (bvlshr  ?B12 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B18 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B11 (_ bv4294901759 32) ) ?B15 ) (_ bv4294966784 32) ) ?B13 ) (_ bv4294905855 32) ) ?B14 ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) ?B17 ) (_ bv4294966783 32) ) ?B16 ) (_ bv4294901759 32) ) ?B15 ) (_ bv4294966784 32) ) ?B13 ) (_ bv4294905855 32) ) ?B14 ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) ?B17 ) (_ bv4294966783 32) ) ?B16 ) ) ) (let ( (?B19 (bvor  (bvshl  (bvand  (bvlshr  ?B18 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B18 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B18 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B20 (bvand  (bvshl  (bvand  (bvlshr  ?B19 (_ bv12 32) ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B21 (bvand  (bvshl  (bvand  (bvlshr  ?B19 (_ bv0 32) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B22 (bvshl  (bvand  (bvlshr  ?B19 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B23 (bvshl  (bvand  (bvlshr  ?B19 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B24 (bvshl  (bvand  (bvlshr  ?B19 (_ bv16 32) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B25 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B18 (_ bv4294901759 32) ) ?B24 ) (_ bv4294966784 32) ) ?B21 ) (_ bv4294905855 32) ) ?B20 ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) ?B22 ) (_ bv4294966783 32) ) ?B23 ) (_ bv4294901759 32) ) ?B24 ) (_ bv4294966784 32) ) ?B21 ) (_ bv4294905855 32) ) ?B20 ) (_ bv4294965247 32) ) ?B3 ) (_ bv4294966271 32) ) ?B22 ) (_ bv4294966783 32) ) ?B23 ) ) ) (and  (=  false (=  (_ bv0 32) (bvand  ((_ zero_extend 24)  ((_ extract 7  0)  ?B1 ) ) ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) (bvor  ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) (bvand  ?B1 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B25 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B25 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B25 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) (_ bv8192 32) ) (_ bv0 32) ) ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B2 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) ) ) ) ) ) (=  (_ bv13 32) (bvand  (bvlshr  ?B2 (_ bv11 32) ) (_ bv31 32) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )
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
(exit)
;   OK -- Elapsed: 1.189506e-02
;   Solvable: false
