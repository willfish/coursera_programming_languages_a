fun swap (pair : int * bool) =
  (#2pair, #1pair)

(*  (int * int) * (int * int) - int *)
fun sum_two_pairs (pair1 : int * int, pair2 : int * int) =
  (#1 pair1) + (#2 pair1) +
  (#1 pair2) + (#2 pair2)

(* int * int -> int *)
fun div_mod (x: int, y: int) =
  (x div y, x mod y)

(* (int * int) -> (int * int) *)
fun sort_pair (pair : int * int) =
  if (#1 pair) < (#2 pair)
  then pair
  else (#2 pair, #1 pair)

val x = (3, ( 4, (5, 6)));
val y = (#2 x, (#1 x, #2 (#2 x)));
val ans = (#2 y, 4);
(* (int * int) * int *)
(* ((5, 6), 4) *)
