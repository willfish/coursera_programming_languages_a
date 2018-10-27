(* use "homework_1/number_before_reaching_sum_test.sml"; *)

use "homework_1/number_before_reaching_sum.sml";

val xs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

val test_1 = number_before_reaching_sum(1, xs) = 0
val test_2 = number_before_reaching_sum(15, xs) = 4
val test_3 = number_before_reaching_sum(55, xs) = 9

(* val xs = [1,2,3]; *)

(* val test_1 = number_before_reaching_sum(3, xs)
val test_2 = number_before_reaching_sum(2, xs) *)
