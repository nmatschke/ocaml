(* TEST
   expect;
*)

external ldexp
  :  (float[@unboxed])
  -> (int[@untagged])
  -> (float[@unboxed])
  = "caml_ldexp_float" "caml_ldexp_float_unboxed"
[@@noalloc]

[%%expect {|
external ldexp :
  (float [@unboxed]) -> (int [@untagged]) -> (float [@unboxed])
  = "caml_ldexp_float" "caml_ldexp_float_unboxed" [@@noalloc]
|}]

(* All relevant attributes are copied. *)
external foo = ldexp 

[%%expect {|
external foo : (float [@unboxed]) -> (int [@untagged]) -> (float [@unboxed])
  = "caml_ldexp_float" "caml_ldexp_float_unboxed" [@@noalloc]
|}]

(* Repeating attributes on type annotations is unnecessary. *)
external bar : float -> int -> float = foo

[%%expect {|
external bar : (float [@unboxed]) -> (int [@untagged]) -> (float [@unboxed])
  = "caml_ldexp_float" "caml_ldexp_float_unboxed" [@@noalloc]
|}]

(* It is fine to explicitly repeat the attributes. *)
external baz 
  :  (float[@unboxed])
  -> (int[@untagged])
  -> (float[@unboxed])
  = foo
[@@noalloc]

[%%expect {|
external baz : (float [@unboxed]) -> (int [@untagged]) -> (float [@unboxed])
  = "caml_ldexp_float" "caml_ldexp_float_unboxed" [@@noalloc]
|}]
