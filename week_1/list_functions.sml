(* int list -> int *)
fun sum_list(xs: int list) =
  if null xs
  then 0
  else hd xs + sum_list(tl xs)

(* int list -> int *)
fun list_product(xs: int list) =
  if null xs
  then 1
  else hd xs * list_product(tl xs)

(* int -> int list *)
fun countdown(x : int) =
  if x = 0
  then []
  else x :: countdown(x - 1)

(* int list * int list -> int list *)
fun append(xs : int list, ys : int list) =
  if null xs
  then ys
  else (hd xs) :: append((tl xs), ys)

(* (int * int) list -> int *)
fun sum_pair_list(xs : (int * int) list) =
  if null xs
  then 0
  else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs);

(* (int * int) list -> int list *)
fun firsts(xs : (int * int) list) =
  if null xs
  then []
  else #1 (hd xs) :: firsts(tl xs);

(* (int * int) list -> int list *)
fun seconds(xs : (int * int) list) =
  if null xs
  then []
  else #2 (hd xs) :: seconds(tl xs);

(* (int * int) list -> int *)
fun sum_pair_list_2(xs : (int * int) list) =
  (sum_list (firsts(xs))) + sum_list (seconds(xs));

(* int -> int *)
fun factorial(i : int) =
  list_product(countdown(i));
