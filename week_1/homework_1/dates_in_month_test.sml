(* use "homework_1/dates_in_month_test.sml"; *)
use "homework_1/dates_in_month.sml";

val test_1 = dates_in_month([date_1, date_2, date_3, date_4], target_month) = [date_1, date_4];

val test_2 = dates_in_month([date_2, date_3], target_month) = [];

val test_3 = dates_in_month([], target_month) = [];
