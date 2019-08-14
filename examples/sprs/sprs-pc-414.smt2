; Query 413 -- Type: InitialValues, Instructions: 2186835
(set-option :produce-models true)
(set-logic QF_AUFBV )
(declare-fun addrbase () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun addrofs () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun dat_i () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun dsx () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_read () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun ex_spr_write () (Array (_ BitVec 32) (_ BitVec 8) ) )
(declare-fun except_started () (Array (_ BitVec 32) (_ BitVec 8) ) )
(assert (let ( (?B1 (select  except_started (_ bv0 32) ) ) (?B2 ((_ zero_extend 24)  (select  ex_spr_write (_ bv0 32) ) ) ) (?B3 ((_ zero_extend 24)  (select  ex_spr_read (_ bv0 32) ) ) ) (?B4 (bvor  (concat  (select  addrbase (_ bv3 32) ) (concat  (select  addrbase (_ bv2 32) ) (concat  (select  addrbase (_ bv1 32) ) (select  addrbase (_ bv0 32) ) ) ) ) ((_ zero_extend 16)  (concat  (select  addrofs (_ bv1 32) ) (select  addrofs (_ bv0 32) ) ) ) ) ) (?B5 (bvshl  ((_ zero_extend 24)  (select  dsx (_ bv0 32) ) ) (_ bv1 32) ) ) ) (let ( (?B8 ((_ zero_extend 31)  (ite (=  (_ bv17 32) (bvand  (bvlshr  ?B4 (_ bv0 32) ) (_ bv2047 32) ) ) (_ bv1 1) (_ bv0 1) ) ) ) (?B7 ((_ zero_extend 24)  ((_ extract 7  0)  ?B2 ) ) ) (?B6 ((_ zero_extend 24)  ?B1 ) ) (?B9 (bvand  (bvshl  (bvand  ?B5 (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) ) (let ( (?B10 (bvshl  (bvand  ?B6 (_ bv1 32) ) (_ bv16 32) ) ) (?B11 (bvshl  (bvand  (bvor  ?B6 (bvlshr  (concat  (select  dat_i (_ bv3 32) ) (concat  (select  dat_i (_ bv2 32) ) (concat  (select  dat_i (_ bv1 32) ) (select  dat_i (_ bv0 32) ) ) ) ) (_ bv16 32) ) ) (_ bv1 32) ) (_ bv16 32) ) ) ) (let ( (?B12 (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvand  (bvand  (bvand  (bvor  (bvand  (bvor  (bvand  ?B10 (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B9 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B9 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) (_ bv4294901759 32) ) ?B10 ) (_ bv4294966784 32) ) (_ bv1 32) ) (_ bv4294905855 32) ) ?B9 ) (_ bv4294965247 32) ) (_ bv4294966271 32) ) (_ bv4294966783 32) ) ) ) (let ( (?B13 (bvor  (bvshl  (bvand  (bvlshr  ?B12 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B12 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B12 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B14 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B15 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B13 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B16 (bvshl  (bvand  (bvlshr  ?B13 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) (?B17 (bvshl  (bvand  (bvlshr  ?B13 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B18 (bvshl  (bvand  (bvlshr  ?B13 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) ) (let ( (?B19 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B12 (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) ?B15 ) (_ bv4294905855 32) ) ?B14 ) (_ bv4294965247 32) ) ?B16 ) (_ bv4294966271 32) ) ?B18 ) (_ bv4294966783 32) ) ?B17 ) (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) ?B15 ) (_ bv4294905855 32) ) ?B14 ) (_ bv4294965247 32) ) ?B16 ) (_ bv4294966271 32) ) ?B18 ) (_ bv4294966783 32) ) ?B17 ) ) ) (let ( (?B20 (bvor  (bvshl  (bvand  (bvlshr  ?B19 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B19 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B19 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B21 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B22 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B20 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B23 (bvshl  (bvand  (bvlshr  ?B20 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B24 (bvshl  (bvand  (bvlshr  ?B20 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B25 (bvshl  (bvand  (bvlshr  ?B20 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B26 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B19 (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) ?B21 ) (_ bv4294905855 32) ) ?B22 ) (_ bv4294965247 32) ) ?B25 ) (_ bv4294966271 32) ) ?B24 ) (_ bv4294966783 32) ) ?B23 ) (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) ?B21 ) (_ bv4294905855 32) ) ?B22 ) (_ bv4294965247 32) ) ?B25 ) (_ bv4294966271 32) ) ?B24 ) (_ bv4294966783 32) ) ?B23 ) ) ) (let ( (?B27 (bvor  (bvshl  (bvand  (bvlshr  ?B26 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B26 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B26 (_ bv0 32) ) (_ bv16383 32) ) ) ) ) ) (let ( (?B28 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B27 (_ bv7 32) ) (_ bv3 32) ) (_ bv7 32) ) (bvor  (bvshl  (bvand  (bvlshr  ?B27 (_ bv3 32) ) (_ bv3 32) ) (_ bv3 32) ) (_ bv1 32) ) ) (_ bv511 32) ) (_ bv0 32) ) (_ bv511 32) ) ) (?B29 (bvand  (bvshl  (bvand  (bvor  (bvshl  (bvand  (bvlshr  ?B27 (_ bv14 32) ) (_ bv3 32) ) (_ bv2 32) ) ?B5 ) (_ bv15 32) ) (_ bv12 32) ) (_ bv61440 32) ) ) (?B30 (bvshl  (bvand  (bvlshr  ?B27 (_ bv10 32) ) (_ bv1 32) ) (_ bv10 32) ) ) (?B31 (bvshl  (bvand  (bvlshr  ?B27 (_ bv9 32) ) (_ bv1 32) ) (_ bv9 32) ) ) (?B32 (bvshl  (bvand  (bvlshr  ?B27 (_ bv11 32) ) (_ bv1 32) ) (_ bv11 32) ) ) ) (let ( (?B33 (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  (bvor  (bvand  ?B26 (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) ?B28 ) (_ bv4294905855 32) ) ?B29 ) (_ bv4294965247 32) ) ?B32 ) (_ bv4294966271 32) ) ?B30 ) (_ bv4294966783 32) ) ?B31 ) (_ bv4294901759 32) ) ?B11 ) (_ bv4294966784 32) ) ?B28 ) (_ bv4294905855 32) ) ?B29 ) (_ bv4294965247 32) ) ?B32 ) (_ bv4294966271 32) ) ?B30 ) (_ bv4294966783 32) ) ?B31 ) ) ) (and  (and  (and  (and  (=  (_ bv0 32) (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) (bvor  ?B3 (bvand  ?B2 (bvlshr  (bvor  (bvshl  (bvand  (bvlshr  ?B33 (_ bv15 32) ) (_ bv3 32) ) (_ bv15 32) ) (bvor  (bvshl  ((_ zero_extend 24)  ((_ extract 7  0)  ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  ?B33 (_ bv14 32) ) (_ bv1 32) ) ) ) ) ) (_ bv14 32) ) (bvand  (bvlshr  ?B33 (_ bv0 32) ) (_ bv16383 32) ) ) ) (_ bv0 32) ) ) ) ) (_ bv1 32) ) (_ bv0 32) ) ?B8 ) ) ) ) ) (=  (_ bv0 32) (bvand  (bvlshr  ?B4 (_ bv11 32) ) (_ bv31 32) ) ) ) (=  (_ bv0 32) (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) ?B3 ) (_ bv1 32) ) (_ bv0 32) ) ?B8 ) ) ) ) ) ) (=  false (=  (_ bv0 8) ?B1 ) ) ) (=  false (=  (_ bv0 32) (bvand  ?B7 ((_ zero_extend 24)  ((_ extract 7  0)  (bvand  (bvlshr  (bvand  (bvsub  (_ bv0 32) (bvor  ?B3 (bvand  ?B2 (bvlshr  ?B13 (_ bv0 32) ) ) ) ) (_ bv1 32) ) (_ bv0 32) ) ?B8 ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )
(check-sat)
(get-value ( (select ex_spr_write (_ bv0 32) ) ) )
(get-value ( (select ex_spr_write (_ bv1 32) ) ) )
(get-value ( (select ex_spr_write (_ bv2 32) ) ) )
(get-value ( (select ex_spr_write (_ bv3 32) ) ) )
(get-value ( (select ex_spr_read (_ bv0 32) ) ) )
(get-value ( (select ex_spr_read (_ bv1 32) ) ) )
(get-value ( (select ex_spr_read (_ bv2 32) ) ) )
(get-value ( (select ex_spr_read (_ bv3 32) ) ) )
(get-value ( (select except_started (_ bv0 32) ) ) )
(get-value ( (select except_started (_ bv1 32) ) ) )
(get-value ( (select except_started (_ bv2 32) ) ) )
(get-value ( (select except_started (_ bv3 32) ) ) )
(get-value ( (select dsx (_ bv0 32) ) ) )
(get-value ( (select dsx (_ bv1 32) ) ) )
(get-value ( (select dsx (_ bv2 32) ) ) )
(get-value ( (select dsx (_ bv3 32) ) ) )
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
(exit)
;   OK -- Elapsed: 1.005006e-02
;   Solvable: false
