(* use "homework_1/dates_in_months_test.sml"; *)
use "homework_1/dates_in_months.sml";

val target_months = [12, 6];
val date_1 = (2018, 12, 1);
val date_2 = (2018, 6, 1);
val date_3 = (2018, 2, 1);
val date_4 = (2018, 12, 5);

fun test_dates_in_months(dates : (int * int * int) list, months : int list, expected_dates : (int * int * int) list) =
  dates_in_months(dates, months) = expected_dates;

val dates = dates_in_months([date_1, date_2, date_3, date_4], [12, 6])
val test_1 = test_dates_in_months(
  [date_1, date_2, date_3, date_4],
  [12, 6],
  [date_1, date_4, date_2]
)

val test_2 = test_dates_in_months(
  [date_2, date_3],
  [12, 6],
  [date_2]
)

val test_3 = test_dates_in_months(
  [date_2, date_3],
  [],
  []
)

val test_4 = test_dates_in_months(
  [],
  [12, 6],
  []
)
