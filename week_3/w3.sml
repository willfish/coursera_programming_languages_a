(* Introduction to First-Class Functions *)

(* Avoiding mutation in most/all cases *)
(* Using functions as values *)

(* Functional language is one where functional programming is convenient *)

fun double x = 2 * x
fun incr x = x + 1
val a_tuple = (double, incr, double(incr 7))
val eighteen = (#1 a_tuple) 9


(* Functions as arguments *)

(* fun increment_n_times_lame(n, x) = *)
(*   if n=0 *)
(*   then x *)
(*   else 1 + increment_n_times_lame(n-1, x) *)

(* fun double_n_times_lame(n, x) = *)
(*   if n=0 *)
(*   then x *)
(*   else 2 * double_n_times_lame(n-1, x) *)

(* fun nth_tail_lame(n, xs) = *)
(*   if n=0 *)
(*   then xs *)
(*   else tl(nth_tail_lame(n-1, xs)) *)

fun n_times(f, n, x) =
  if n=0
  then x
  else f(n_times(f, n-1, x))

fun increment x = x + 1
fun double x = x * 2
fun triple x = x * 3

val x1 =  n_times(double, 4, 7)
val x2 =  n_times(increment, 4, 7)
val x3 =  n_times(tl, 2, [4, 8, 12, 16])

fun addition(n, x) = n_times(increment, n, x)
fun double_n_times(n, x) = n_times(double, n, x) 
fun nth_tail(n, x) = n_times(tl, n, x) 
fun triple_n_times(n, x) = n_times(triple, n, x) 

fun times_until_zero(f, x) =
  if x=0 then 0 else 1 + times_until_zero(f, f x)
 
fun len xs =
  case xs of
       [] => 0
     | x::xs' => 1 + len xs'

(* Anonymous functions *)

fun triple x = x * 3
fun triple_n_times(n, x) = n_times(triple, n, x) 
fun triple_n_times(n, x) = n_times(let fun triple x = x * 3 in triple end, n, x) 
fun triple_n_times(n, x) = n_times(fn x => x * 3, n, x) 
val triple_n_times = fn (n, x) => n_times(fn y => 3 * y, n, x)

(* Unnecessary Function Wrapping *)


(* Map and filter *)

fun map (f, xs) =
  case xs of
       [] => []
     | x::xs' => f(x)::map(f, xs')


val x1 = map(fn x => x + 1, [4,8,12,16])
val x2 = map(hd, [[4,8],[12,16]])

fun filter(f, xs) =
  case xs of
       [] => []
     | x::xs' =>
         if f x
         then x::(filter (f, xs'))
         else filter(f, xs')

(* Generalizing Prior topics *)

datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp

fun true_of_all_constants(f,e) =
  case e of
       Constant i => f i
     | Negate e1 => true_of_all_constants(f, e1)
     | Add(e1, e2) => true_of_all_constants(f, e1) andalso true_of_all_constants(f, e2)
     | Multiply(e1, e2) => true_of_all_constants(f, e1) andalso true_of_all_constants(f, e2)

fun all_even e = true_of_all_constants(fn i => i mod 2 = 0, e)

(* Lexical Scope *)

val x = 1
fun f y = x + y
val x = 2
val y = 3
val z = f(x + y)


(* Lexical Scope and Higher-Order Functions *)

val x = 1

fun f y =
let val x = y + 1
in
  fn z => x + y + z
end
val x = 3
val g = f(4)
val y = 5
val z = g 6

fun f g =
let
  val x = 3
in
  g 2
end
val x = 4
fun h y = x + y
val z = f h

(* Why lexical scope *)

(* Lexical scope looks in the environment where the variables are defined to look *)
(* up the bindings for the function body. *)

fun filter(f, xs) =
  case xs of
       [] => []
     | x::xs' => if f x then x::(filter(f, xs')) else filter(f, xs')

fun all_shorter_than_1(xs, s) =
  filter(fn x => String.size(x) < String.size(s), xs)

fun all_shorter_than_2(xs, s) =
let
  val i = String.size(s)
in
  filter(fn x => String.size(x) < i, xs)
end

(* print "\nall_shorter_than_1 =\n" *)
(* all_shorter_than_1(["a","b","c","de"], "de") *)
(* print "\nall_shorter_than_2 =\n" *)
(* all_shorter_than_2(["a","b","c"], "de") *)

(* Fold and more closures *)
(* fold == reduce *)
(* Traverse a datastructure and produce a single answer *)

fun fold(f, acc, xs) =
  case xs of
       [] => acc
     | x::xs => fold(f, f(acc, x), xs)

fun all?(g, xs) = fold(fn(x, y) => x andalso(g(y)), true, xs)

(* Closure Idiom: Combining Functions *)

fun compose(f, g) = fn x => f(g(x))

fun sqrt_of_abs i = Math.sqrt(Real.fromInt(abs i))

fun sqrt_of_abs i = (Math.sqrt o Real.fromInt o abs) i

infix !>
 
fun x !> f = f x

fun sqrt_of_abs i = i !> abs !> Real.fromInt !> Math.sqrt

fun backup1 (f, g) = fn x => case f x of
                                  NONE => g x
                                | SOME y => y
fun backup2 (f, g) = fn x => f x handle _ => g x

(* Closure Idiom: Currying *)

fun sorted3_tupled (x, y, z) = z >= y andalso y >= x

val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

val t2 = (((sorted3 7) 9) 11)
val t3 = sorted3 7 9 11

fun sorted3_nicer x y z = z >= y andalso y >= x

val t4 = sorted3_nicer 7 9 11
val t5 = (((sorted3_nicer 7) 9) 11)


fun fold f acc xs =
  case xs of [] => acc | x::xs' => fold f (f(acc, x)) xs'

fun sum xs = fold (fn (x, y) => x + y) 0 xs

fun sorted3 x y z = z >= y andalso y >= x
val t1 = sorted3 7 9 11

(* Closure Idiom: Partial Application *)

val is_nonnegative = sorted3 0 0

val sum = fold (fn (x, y) => x + y) 0

val a = sum [1,2,3,4]
val b = sum [1,2,3,4,5]

fun range i j = if i > j then [] else i :: range (i + 1) j

val countup = range 1

val c = countup 10

fun countup_inferior x = range 1 x

fun exists predicate xs =
  case xs of
       [] => false
     | x::xs' => predicate x orelse exists predicate xs'

val no = exists (fn x => x = 7) [4,11,23]
val has_zero = exists (fn x => x = 0)
val increment_all = List.map (fn x => x + 1)
val remove_zeros = List.filter (fn x => x <> 0)

(* val pair_with_one = List.map (fn x => (x,1)) *)

fun curry f x y = f (x, y)
fun other_curry f x y = f (y, x)
fun uncurry f (x, y) = f x y

fun range (i, j) = if i > j then [] else i :: range(i + 1, j)

val countup = curry range 1

val xs = countup 8

(* Mutable References *)

val x = ref 42
val y = ref 42
val z = x
val _ = x := 43
val w = (!y) + (!z)

(* Closure Idioms: Callbacks *)
val callbacks : (int -> unit) list ref = ref []

fun on_key_event f =
  callbacks := f :: (!callbacks)

fun on_event i =
let
  fun loop fs =
    case fs of
         [] => ()
       | f::fs' => (f i; loop fs')
in
  loop (!callbacks)
end

val times_pressed = ref 0
val _ = on_key_event (fn _ => times_pressed := (!times_pressed) + 1)

fun print_if_pressed i =
  on_key_event (
      fn j =>
        if i = j
        then print ("You pressed: " ^ Int.toString(i) ^ "\n")
        else ()
    )

val _ = print_if_pressed 4
val _ = print_if_pressed 11
val _ = print_if_pressed 23
val _ = print_if_pressed 4

(* Standard-Library Documentation *)


