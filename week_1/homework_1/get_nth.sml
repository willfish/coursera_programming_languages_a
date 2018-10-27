(* use "homework_1/get_nth.sml"; *)

(* Write a function get_nth that takes a list of strings and an int n and returns the nth element of the
list where the head of the list is 1st. Do not worry about the case where the list has too few elements:
your function may apply hd or tl to the empty list in this case, which is okay. *)

(* string list * int -> string *)
fun get_nth(strings : string list, n : int) =
  if n <= 1
  then hd strings
  else
    get_nth(tl strings, n - 1)
