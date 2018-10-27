(* use "homework_1/date_to_string_test.sml"; *)
use "homework_1/date_to_string.sml";

val date_1 = (2018, 1, 1);
val date_2 = (2018, 2, 1);
val date_3 = (2018, 11, 1);
val date_4 = (2018, 12, 1);

val test_1 = date_to_string(date_1) = "January 1, 2018"
val test_2 = date_to_string(date_2) = "February 1, 2018"
val test_3 = date_to_string(date_3) = "November 1, 2018"
val test_4 = date_to_string(date_4) = "December 1, 2018"
