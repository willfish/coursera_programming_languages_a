(* use "homework_1/number_in_months_test.sml"; *)
(* a date is equivalent to y * m * d *)
(* only positive dates are used *)
use "homework_1/number_in_months.sml";

val date_1 = (2018, 12, 1);
val date_2 = (2018, 6, 1);
val date_3 = (2018, 2, 1);
val date_4 = (2018, 12, 5);

fun test_number_in_months(dates : (int * int * int) list, months : int list, expected_count : int) =
  number_in_months(dates, months) = expected_count;

val test_1 = test_number_in_months([date_1, date_2, date_3, date_4], [12, 6], 3)

val test_2 = test_number_in_months([date_2, date_3], [12, 6], 1)

val test_3 = test_number_in_months([date_2, date_3], [], 0)

val test_4 = test_number_in_months([], [12, 6], 0)
