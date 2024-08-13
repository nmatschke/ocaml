(* TEST
   expect;
*)

external identity : 'a -> 'a = "%identity"

[%%expect {|
external identity : 'a -> 'a = "%identity"
|}]

(* Cannot define a self-referential primitive. *)
module rec A : sig
  external p = A.p
end = struct
  external p = A.p
end

[%%expect {|
Line 2, characters 2-18:
2 |   external p = A.p
      ^^^^^^^^^^^^^^^^
Error: Unbound value "A.p"
|}]

(* Cannot define mutually-recursive primitives. *)
module rec B : sig
  external p = C.p
end = struct
  external p = C.p
end

and C : sig
  external p = B.p
end = struct
  external p = B.p
end

[%%expect {|
Line 2, characters 2-18:
2 |   external p = C.p
      ^^^^^^^^^^^^^^^^
Error: Unbound value "C.p"
|}]

(* Can refer to primitives from other mutually-recursive modules. *)
module rec D : sig
  external p = E.p
end = struct
  external p = identity
end

and E : sig
  external p = identity
end = struct
  external p = D.p
end

[%%expect {|
module rec D : sig external p : 'a -> 'a = "%identity" end
and E : sig external p : 'a -> 'a = "%identity" end
|}]
