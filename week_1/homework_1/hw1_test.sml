use "hw1.sml";

(* #################### GLOBAL VALS ####################### *)

val target_month = 12;
val target_months = [12, 6];
val date_1 = (2018, 12, 1);
val date_2 = (2018, 6, 1);
val date_3 = (2018, 2, 1);
val date_4 = (2018, 12, 5);

(* ####################### 1 ############################## *)

val older_test_1 = is_older((1987, 5, 4), (1987, 5, 4)) = false;

val older_test_2 = is_older((1987, 5, 4), (1987, 5, 3)) = false;
val older_test_3 = is_older((1987, 5, 4), (1987, 5, 5)) = true;

val older_test_5 = is_older((1987, 5, 4), (1987, 4, 4)) = false;
val older_test_4 = is_older((1987, 5, 4), (1987, 6, 4)) = true;

val older_test_7 = is_older((1987, 5, 4), (1986, 5, 4)) = false;
val older_test_6 = is_older((1987, 5, 4), (1988, 5, 4)) = true;

(* ######################## 2 ############################## *)

val number_in_month_test_1 = number_in_month([date_1, date_2, date_3, date_4], target_month) = 2;

val number_in_month_test_2 = number_in_month([date_2, date_3], target_month) = 0;

val number_in_month_test_3 = number_in_month([], target_month) = 0;

(* ######################## 3 ############################## *)

val number_in_months_test_1 = number_in_months([date_1, date_2, date_3, date_4], [12, 6]) = 3;

val number_in_months_test_2 = number_in_months([date_2, date_3], [12, 6]) = 1;

val number_in_months_test_3 = number_in_months([date_2, date_3], []) = 0;

val number_in_months_test_4 = number_in_months([], [12, 6]) = 0;


(* ######################## 4 ############################## *)

val dates_in_month_test_1 = dates_in_month([date_1, date_2, date_3, date_4], target_month) = [date_1, date_4];

val dates_in_month_test_2 = dates_in_month([date_2, date_3], target_month) = [];

val dates_in_month_test_3 = dates_in_month([], target_month) = [];

(* ######################## 5 ############################## *)

val dates_in_months_test_1 = dates_in_months([date_1, date_2, date_3, date_4], [12, 6]) = [date_1, date_4, date_2];

val dates_in_months_test_2 = dates_in_months([date_2, date_3], [12, 6]) = [date_2];

val dates_in_months_test_3 = dates_in_months([date_2, date_3], []) = [];

val dates_in_months_test_4 = dates_in_months([], [12, 6]) = [];

(* ######################## 6 ############################## *)

val get_nth_strings = ["hello", "world", "how", "are", "you"];

val get_nth_test_2 = get_nth(get_nth_strings, 1) = "hello";

val get_nth_test_3 = get_nth(get_nth_strings, 2) = "world";

val get_nth_test_4 = get_nth(get_nth_strings, 3) = "how";

(* ######################## 7 ############################## *)

val date_1 = (2018, 1, 1);
val date_2 = (2018, 2, 1);
val date_3 = (2018, 11, 1);
val date_4 = (2018, 12, 1);

val date_to_string_test_1 = date_to_string(date_1) = "January 1, 2018";
val date_to_string_test_2 = date_to_string(date_2) = "February 1, 2018";
val date_to_string_test_3 = date_to_string(date_3) = "November 1, 2018";
val date_to_string_test_4 = date_to_string(date_4) = "December 1, 2018";

(* ######################## 8 ############################## *)

val sum_numbers = [1, 2, 3, 4, 5]

val number_before_reaching_sum_test_1 = number_before_reaching_sum(1, sum_numbers) = 0;
val number_before_reaching_sum_test_2 = number_before_reaching_sum(2, sum_numbers) = 1;
val number_before_reaching_sum_test_3 = number_before_reaching_sum(6, sum_numbers) = 2;
val number_before_reaching_sum_test_4 = number_before_reaching_sum(15, sum_numbers) = 4;

(* ######################## 9 ############################## *)

val what_month_test_1 = what_month(1) = 1;
val what_month_test_1 = what_month(31) = 1;
val what_month_test_1 = what_month(32) = 2;
val what_month_test_1 = what_month(365) = 12;

(* ######################## 10 ############################## *)

val month_range_test_1 = month_range(31, 35) = [1, 2, 2, 2, 2];

(* ######################## 11 ############################## *)

val oldest_test_1 = oldest([date_1, date_2, date_3, date_4]) = SOME (2018, 1, 1);
