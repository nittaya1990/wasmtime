;;! target = "x86_64"
;;! test = "clif"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation=false -O static-memory-maximum-size=0 -O static-memory-guard-size=0 -O dynamic-memory-guard-size=0"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store offset=0)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load offset=0))

;; function u0:0(i64 vmctx, i64, i32, i32) tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned gv3+104
;;     gv5 = load.i64 notrap aligned checked gv3+96
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32, v3: i32):
;; @0040                               v4 = uextend.i64 v2
;; @0040                               v5 = global_value.i64 gv4
;; @0040                               v6 = iconst.i64 4
;; @0040                               v7 = isub v5, v6  ; v6 = 4
;; @0040                               v8 = icmp ugt v4, v7
;; @0040                               trapnz v8, heap_oob
;; @0040                               v9 = global_value.i64 gv5
;; @0040                               v10 = iadd v9, v4
;; @0040                               store little heap v3, v10
;; @0043                               jump block1
;;
;;                                 block1:
;; @0043                               return
;; }
;;
;; function u0:1(i64 vmctx, i64, i32) -> i32 tail {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned gv1+16
;;     gv3 = vmctx
;;     gv4 = load.i64 notrap aligned gv3+104
;;     gv5 = load.i64 notrap aligned checked gv3+96
;;     stack_limit = gv2
;;
;;                                 block0(v0: i64, v1: i64, v2: i32):
;; @0048                               v4 = uextend.i64 v2
;; @0048                               v5 = global_value.i64 gv4
;; @0048                               v6 = iconst.i64 4
;; @0048                               v7 = isub v5, v6  ; v6 = 4
;; @0048                               v8 = icmp ugt v4, v7
;; @0048                               trapnz v8, heap_oob
;; @0048                               v9 = global_value.i64 gv5
;; @0048                               v10 = iadd v9, v4
;; @0048                               v11 = load.i32 little heap v10
;; @004b                               jump block1(v11)
;;
;;                                 block1(v3: i32):
;; @004b                               return v3
;; }
