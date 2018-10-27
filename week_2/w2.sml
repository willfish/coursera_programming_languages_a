(* ##################### types ###################### *)

(* ##################### records ###################### *)

val x = { bar=(1 + 2, true andalso true), foo= 3 + 4, baz= (false, 9) };
val partner = { name = "Celine", age = "29", fiancee = true };

(* ##################### datatypes ###################### *)

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza;

val a = Str("hi");
val b = Str;
val c = Pizza;
val d = TwoInts(1+2, 3+4);
val e = a;

(* ##################### case ###################### *)

(* int -> int *)
fun f(x) =
  case x of
       Pizza => 3
     | Str(s) => 8
     | TwoInts(i1, i2) => i1 + i2;

(* ##################### datatypes uses ###################### *)
(* Enumerations *)
datatype suit = Club | Diamond | Heart | Spade
datatype rank = King | Queen | Jack | Ace | Num of int

(* Way of identifying real-world things/people *)

datatype id = StudentNum of int
            | Name of string * (string option) * string

            (* Expression trees *)

datatype exp = Constant of int
             | Negate   of exp
             | Add      of exp * exp
             | Multiply of exp * exp

fun eval(e) =
  case e of
       Constant(i)      => i
     | Negate(e1)       => ~(eval e1)
     | Add(e1, e2)      => (eval e1) + (eval e2)
     | Multiply(e1, e2) => (eval e1) * (eval e2);

     (* ##################### Another expression example ###################### *)

fun max_constant(expression) =
  case expression of
       Constant(i)      => i
     | Negate(e1)       => max_constant e1
     | Add(e1, e2)      => Int.max(max_constant e1, max_constant e2)
     | Multiply(e1, e2) => Int.max(max_constant e1, max_constant e2)

val test_expression_1 = Add(
Constant(19), Negate(Constant(21))
);
val result_1 = max_constant(test_expression_1) = 21;

val test_expression_2 = Add(
Multiply(
Constant(21), Negate(Constant(19))
),
Multiply(Constant(1), Constant(2))
);
val result_2 = max_constant(test_expression_2) = 21;

val test_expression_3 = Add(
Constant(19), Multiply(Constant(76), Negate(Constant(21)))
);
val result_3 = max_constant(test_expression_3) = 76;

(* ##################### Type synonyms ###################### *)

type card = suit * rank;

fun is_queen_of_spades(c : card) =
  #1 c = Spade andalso #2 c = Queen

val card_1 : card = (Spade, Queen);
val card_2 : suit * rank = (Heart, Ace)
val card_3 = (Spade, Ace)
val result_1 = is_queen_of_spades(card_1) = true
val result_2 = is_queen_of_spades(card_2) = false
val result_3 = is_queen_of_spades(card_3) = false

fun is_queen_of_spades_2(c : card) =
  case c of
       (Spade,Queen) => true
     | _ => false

val result_1 = is_queen_of_spades_2(card_1) = true
val result_2 = is_queen_of_spades_2(card_2) = false
val result_3 = is_queen_of_spades_2(card_3) = false

(* ##################### List and Options are datatypes ###################### *)

datatype my_int_list = Empty
                     | Cons of int * my_int_list;

fun append_my_list(xs, ys) =
  case xs of
       Empty => ys
     | Cons(x, xs) => Cons(x, append_my_list(xs, ys))

val x = Cons(4, Cons(23, Cons(2008, Empty)));
val y = Cons(4, Cons(23, Cons(2008, Empty)));

val expected = Cons(4, Cons(23, Cons(2008, Cons(4, Cons(23, Cons(2008, Empty))))))
val append_my_list_result = append_my_list(x, y)
val matches = expected = append_my_list_result

(* options *)
fun inc_or_zero (opt : int option) =
  case opt of
       NONE => 0
     | SOME i => i + 1

val int_option = SOME 1
val result_1 = inc_or_zero(int_option)
val result_2 = inc_or_zero(NONE)

(* lists *)

fun sum_list(xs) =
  case xs of
      [] => 0
     (* This is equivalent to ::(head, tail) *)
     | head::xs' => sum_list(xs') + head 

val list = [1,2,3,4,5]
val summed = sum_list(list)

fun append(xs : 'a list, ys : 'a list) =
  case xs of
      [] => ys
     | x::xs' => x :: append(xs', ys)

val xs = [1, 2, 3, 4, 5]
val ys = [5, 4, 3, 2, 1]
val append_result = append(xs, ys)

(* ##################### Polymorphic datatypes ###################### *)

(* a fancier example for binary trees where internal nodes have data of any 1
type and leaves have data of another possibly different type *)
datatype  ('a, 'b) tree = Node of 'a * ('a, 'b) tree * ('a , 'b) tree
                        | Leaf of 'b

(* (int, int) tree -> int *)
fun sum_tree(tr : (int, int) tree) =
  case tr of
       Leaf i => i
     | Node(i, left, right) => i + sum_tree(left) + sum_tree(right)

(* ('a, int) tree -> int *)
fun sum_leaves(tr : (int, int) tree) =
  case tr of
       Leaf i => i
     | Node(i, left, right) => sum_leaves(left) + sum_leaves(right)

(* ('a, 'b) tree -> int *)
fun num_leaves(tr : (int, int) tree) =
  case tr of
       Leaf i => 1
     | Node(i, left, right) => num_leaves(left) + num_leaves(right)

(* Each of pattern matching / truth about functions *)
(* Pattern matches for each of types *)

fun sum_triple_1(triple) =
  case triple of
       (x, y, z) => x + y + z

fun full_name_1(record) =
  case record of
       { first = x, middle = y, last = z } => x ^ " " ^ y " " ^ z

fun sum_triple_2(triple) =
let val (x, y, z) = triple
in x + y + z
end

fun full_name_2(record) =
let val { first = x, middle = y, last = z } = record
in x ^ " " ^ y " " ^ z
end

fun sum_triple_3(x, y, z) =
  x + y + z

fun full_name_3 { first = x, middle = y, last = z } =
  x ^ " " ^ y " " ^ z

val name_record = { first = "William", middle = "Michael", last = "Fish" }
val triple = (1, 2, 3)

val triple_result_1 = sum_triple_1(triple)
val triple_result_2 = sum_triple_2(triple)
val triple_result_3 = sum_triple_3(triple)
(* val name_result_1 = full_name_1(name_record) *)
(* val name_result_2 = full_name_2(name_record) *)
(* val name_result_3 = full_name_3(name_record) *)

fun rotate_left(x, y, z) = (y, z, x)
fun rotate_right(r) = rotate_left(rotate_left(r))

val rotated_left = rotate_left(1, 2, 3)
val rotated_right = rotate_right(1, 2, 3)

(* A little type inference *)
val (a, b, c) = (1, 2, 3);
fun mystery x = case x of (1, b, c) => #2 x + 10 | (a,b,c) => a * c

fun partial_sum(x, y, z) =
  x + z

fun partial_name { first = x, middle = y, last = z } =
  x ^ " " ^ z

(* ##################### Polymorphic and equality types  ###################### *)

(* ##################### Nested patterns ###################### *)
exception ListLengthMismatch

fun old_zip3(x, y, z) =
  if null x andalso null y andalso null z
  then []
  else if null x orelse null y orelse null z
  then raise ListLengthMismatch
  else (hd x, hd y, hd z) :: old_zip3(tl x, tl y, tl z)

(* fun shallow_zip3 (l1, l2, l3) = *)
(*   case l1 of *)
(*        [] => *)
(*        (case l2 of *)
(*              [] => (case l3 of *)
(*                          [] => [] *)
(*                        | _ => raise ListLengthMismatch) *)
(*                      | _ => raise ListLengthMismatch) *)
(*                      | hd1::tl1 => *)
(*                          (case *)
                         
fun zip3 list_triple =
  case list_triple of
       ([], [], []) => []
     | (hd1::tl1, hd2::tl2, hd3::tl3) => (hd1, hd2, hd3)::zip3(tl1, tl2, tl3)
     | _                              => raise ListLengthMismatch

fun unzip3 lst =
  case lst of
       [] => ([], [], [])
     | (a, b, c)::tl_ans => let val (l1, l2, l3) = unzip3 tl_ans
                            in
                              (a::l1, b::l2, c::l3)
                            end
(* int list -> bool *)
fun nondecreasing xs =
  case xs of
       [] => true
     | _::[] => true
     | head::(neck::rest) => head <= neck andalso nondecreasing (neck::rest)

datatype sgn = P | N | Z     

fun multsign(x1, x2) = 
let fun sign x = if x = 0 then Z else if x > 0 then P else N
in
  case (sign x1, sign x2) of
       (Z,_) => Z
     | (_,Z) => Z
     | (P,P) => P
     | (N,N) => P
     | _ => N
end

fun len xs = 
  case xs of
       [] => 0
     | _::xs' => 1 + len xs'

(* ##################### Function patterns ###################### *)

(* fun f(a::b::c) = 2 + f(c) *)
(*   |f [] = 0; *)

fun f1 xs =
  case xs of
       [] => []
     | _ => 1::xs;

fun f2 [] = []
  | f2 _ = 1::xs


(* ##################### Exceptions ###################### *)

exception MyException of int

fun f(n) =
  if n = 0
  then raise List.Empty
  else if n = 1
  then raise (MyException 4)
  else n * n

val x = f(1) handle MyException n => f n
  | List.Empty => 42

(* ##################### Tail Recursion ###################### *)

fun fact n = if n = 0 then 1 else n * fact(n - 1)

val x = fact 3

fun fact_tail_recursive n =
let
  fun aux(n, acc) =
    if n = 0
    then acc
    else aux(n -1, acc * n)
in
  aux(n, 1)
end

val y = fact_tail_recursive 3 

(* Methodology: *)
(* - Create a helper function that takes an acc *)
(* - Old base case becomes initial accumulator *)
(* - New base case becomes final accumulator *)

fun sum xs =
  case xs of 
       [] => 0
     | x::xs' => x + sum xs'

fun sum_tail_recursive xs =
let
  fun aux(xs, acc) =
    case xs of
         [] => acc
       | x::xs' => aux(xs', x + acc)
in
  aux(xs, 0)
end

(* @ is incredibly inefficient compared to :: as we copy the entire list *)
fun rev xs =
  case xs of
       [] => []
     | x::xs' => (rev xs') @ [x]

val xs = [1,2,3]

fun rev_tail_recursive xs =
let
  fun aux(xs, acc) =
    case xs of
         [] => acc
     | x::xs' => aux(xs', x::acc)
in
  aux(xs, [])
end
datatype mytype = A | B | C | D | E

fun doIt q =
  case q of
       [] => A
     | x::xs => if true 
                then C
                else
                  let val res = D;
                  in
                    E
                  end	
