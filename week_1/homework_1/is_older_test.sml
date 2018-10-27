(* use "homework_1/is_older_test.sml"; *)
use "homework_1/is_older.sml";

val older_1 = (2018, 2, 4);
val newer_1 = (2018, 2, 5);

val older_2 = (2017, 2, 4);
val newer_2 = (2018, 2, 5);

val test_1 = is_older(older_1, newer_1) = true
val test_2 = is_older(newer_1, newer_1) = false
val test_3 = is_older(newer_1, older_1) = false

val test_4 = is_older(older_2, newer_2) = true
val test_5 = is_older(newer_2, newer_2) = false
val test_6 = is_older(newer_2, older_2) = false
