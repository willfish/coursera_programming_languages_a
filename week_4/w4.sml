(* Section Introduction *)

(* What is Type Inference *)

(* ML Type Inference *)

(* Do type inference in order *)

(* Type Inference Examples *)

(* Collect all the facts needed for type-checking *)
(* These facts constrain the type of the function *)
(* This gement: *)
(* - Two examples without type variables *)
(* - And one example that does not type-check *)

(* f : T1 -> T2 *)
(* x : T1 *)
(* y : T3 *)
(* z : T4 *)
(* T1 = T3 * T4 [pattern match in let forces a tuple] *)
(* T3 = int [abs has type int -> int] *)
(* T4 = int [T3 + T4] *)
(* T1 = int * int [because both T3 and T4 have types int] *)
(* T2 = int *)

(* f : int -> int *)
fun f x =
let
  val (y, z) = x
in
  (abs y) + z
end

(* sum : T1 -> T2 *)
(* T1 : 'a list [pattern match on empty and non-empty list] *)
(* x : T3 *)
(* x' : T3 list *)
(* T1 = T3 list *)
(* T2 = int [0 in function body] *)
(* T3 = int [x + (sum xs' )] *)

(* sum : int list -> int *)
fun sum xs =
  case xs of
       [] => 0
     | x::xs' => x + (sum xs')

(* w4.sml|52 col 18 error| operator and operand don't agree [overload conflict] operator domain: [+ ty] * [+ ty] operand: int list * int in expression: x + sum x *)
(* fun sum_wrong xs = *)
(*   case xs of *)
(*        [] => 0 *)
(*      | x::xs' => x + (sum x) *)

(* Polymorphic Examples *)

(* length : T1 -> T2 *)
(* T1 = 'a list [pattern match of empty and non-empty] *)
(* T2 = int [constraint added for return type of the first branch] *)
(* T2 = int [matching constraint of second branch] *)
(* length : 'a list -> int *)
fun length xs =
  case xs of
       [] => 0
     | x::xs' => 1 + (length xs')

(* f : 'a * 'a * 'b -> 'a * 'a * 'b *)
fun f(x,y,z) =
  if true
  then (x,y,z)
  else (y,x,z)

(* T1 * T2 -> T3 *)
(* f = T1 *)
(* g = T2 *)
(* x = T4 *)
(* g = T4 -> T5 *)
(* f = T5 -> T6 *)
(* T3 = T4 -> T6 *)
(*               f             g           anonymous *)
(* compose : ('a -> 'b) * ('c -> 'a) -> ('c -> 'b) *)
fun compose (f, g) = fn x => f(g(x))

(* Mutual Recursion *)

fun f1 p1 = ""
and f2 p2 = ""
and f3 p3 = ""

datatype t1 = And
and t2 = Or
and t3 = Are

(* Finite state machine *)
(* [1,2,1,2,1,2,1,2] *)
fun match xs =
let
  fun s_need_one [] = true
    | s_need_one (1::xs') = s_need_two xs'
    | s_need_one _ = false
  and s_need_two [] = true
    | s_need_two (2::xs') = s_need_one xs'
    | s_need_two _ = false
in
  s_need_one xs
end
val xs = [1,2,1,2,1,2,1,2]
val result = match xs

datatype t1 = Foo of int | Bar of t2
and t2 = Baz of string | Quux of t1

fun no_zeros_or_empty_strings_t1 (Foo i) = i <> 0
  | no_zeros_or_empty_strings_t1 (Bar y) = no_zeros_or_empty_strings_t2 y
and no_zeros_or_empty_strings_t2 (Baz s) = size s > 0
  | no_zeros_or_empty_strings_t2 (Quux y) = no_zeros_or_empty_strings_t1 y

fun no_zeros_or_empty_string_t1_alternate (_, Foo i) = i <> 0
  | no_zeros_or_empty_string_t1_alternate (f, Bar y) = f y
fun no_zeros_or_empty_string_t2_alternate (Baz s) = size s > 0
  | no_zeros_or_empty_string_t2_alternate (Quux y) =
      no_zeros_or_empty_string_t1_alternate(no_zeros_or_empty_string_t2_alternate, y)

(* Modules for Namespace Management *)

(* structure MyModule = struct bindings end *)

structure MyMathLib =
struct
  fun fact x =
    if x = 0
    then 1
    else x * fact (x - 1)
end

(* Signatures and Hiding Things *)

signature MATHLIB =
sig
  val fact : int -> int
  val half_pi : real
end

structure MyMathLib :> MATHLIB =
struct
  fun fact x =
    if x = 0
    then 1
    else x * fact (x - 1)

  val half_pi = Math.pi / 2.0
end

(* A Module Example *)
signature RATIONAL_1 =
sig
  type rational
  exception BadFrac
  val Whole : int -> rational
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

structure Rational1 :> RATIONAL_1=
struct
  (* Invariant 1: all denominators > 0 *)
  (* Invariant 2: rationals kept in reduced form *)
  datatype rational = Whole of int | Frac of int * int
  exception BadFrac

  fun gcd (x,y) =
    if x=y
    then x
    else if x < y
    then gcd(x, y - x)
    else gcd(y, x)

  fun reduce r =
    case r of
         Whole _ => r
       | Frac(x, y) =>
           if x=0
           then Whole 0
           else
             let
               val greatest_common_divisor = gcd(abs x, y)
             in
               if greatest_common_divisor = y
               then Whole(x div greatest_common_divisor)
               else Frac(x div greatest_common_divisor, y div greatest_common_divisor)
             end

  fun make_frac (x, y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce(Frac(~x, ~y))
    else reduce(Frac(x,y))

  fun add (r1, r2) =
    case (r1, r2) of
         (Whole(i), Whole(j)) => Whole(i + j)
       | (Whole(i), Frac(j, k)) => Frac(j + k * i, k)
       | (Frac(j, k), Whole(i)) => Frac(j + k * i, k)
       | (Frac(h, i), Frac(j, k)) => Frac(h * k + j * i, i * k)

  fun toString r =
    case r of
         Whole i => Int.toString i
       | Frac(a, b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end

(* Signatures for our Example *)

(* signature RATIONAL_1 = *)
(* sig *)
(*   type rational *)
(*   exception BadFrac *)
(*   val Whole : int -> rational *)
(*   val make_frac : int * int -> rational *)
(*   val add : rational * rational -> rational *)
(*   val toString : rational -> string *)
(* end *)

(* Signature Matching *)

