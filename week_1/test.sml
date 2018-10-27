(* use "hw0provided.sml"; *)
(*
val test1 = double 17 = 34;
val test2 = double 0 = 0;
val test3 = triple ~4 = ~12;
val test4 = triple 0 = 0;
val test5 = f(12,27) = 324;
val test6 = triple ~1 = ~3; *)

fun pow(x:int, y:int) =
  if y = 0
  then 1
  else x * pow(x, y - 1)

fun cube(x:int) =
  pow(x, 3)

fun factorial(n:int) =
  if n = 0
  then 0
  else if n = 1
  then 1
  else n * factorial(n - 1)
