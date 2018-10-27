(* use "homework_1/number_in_month_test.sml"; *)
(* a date is equivalent to y * m * d *)
(* only positive dates are used *)
use "homework_1/number_in_month.sml";

val target_month = 12;
val date_1 = (2018, 12, 1);
val date_2 = (2018, 6, 1);
val date_3 = (2018, 2, 1);
val date_4 = (2018, 12, 5);

val dates = [date_1, date_2, date_3, date_4];
val expected_count = 2;
val test_1 = number_in_month(dates, target_month) = expected_count;

val dates = [date_2, date_3];
val expected_count = 0;
val test_2 = number_in_month(dates, target_month) = expected_count;

val dates = [];
val expected_count = 0;
val test_3 = number_in_month(dates, target_month) = expected_count;
