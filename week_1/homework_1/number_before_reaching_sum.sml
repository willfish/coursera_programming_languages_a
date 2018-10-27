(* use "homework_1/number_before_reaching_sum.sml"; *)

(* Write a function number_before_reaching_sum that takes an int called sum, which you can assume
is positive, and an int list, which you can assume contains all positive numbers, and returns an int.
You should return an int n such that the first n elements of the list add to less than sum, but the first
n + 1 elements of the list add to sum or more. Assume the entire list sums to more than the passed in
value; it is okay for an exception to occur if this is not the case. *)

(* int list * int -> int *)
fun number_before_reaching_sum(sum: int, numbers: int list) =
  let
    fun helper_count(numbers: int list, acc: int, n: int) =
      if hd numbers + acc >= sum then n
      else count(tl numbers, acc + hd numbers, n + 1)
  in
    count(numbers, 0, 0)
  end

(* exception EmptyList
fun number_before_reaching_sum (sum : int, l : int list) : int =
  if null l then raise EmptyList else
    if hd l >= sum then 0 else
      1 + number_before_reaching_sum (sum - hd l, tl l) *)
