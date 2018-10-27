(* ####################### 1 ############################## *)

fun is_older(x : (int * int * int), y : (int * int * int)) =
  let
    val x_year = #1 x
    val x_month = #2 x
    val x_day = #3 x

    val y_year = #1 y
    val y_month = #2 y
    val y_day = #3 y
  in
    if x_year = y_year
    then
      if x_month = y_month
      then x_day < y_day
      else x_month < y_month
    else
      x_year < y_year
  end

(* ####################### 2 ############################## *)

fun number_in_month(all_dates : (int * int * int) list, target_month : int) =
  let
    fun dates_on_given_month(dates : (int * int * int) list) =
      if null dates
      then []
      else
        let
          val current_date = hd dates
          val current_month = #2 current_date
          val tl_ans = dates_on_given_month(tl dates)
        in
          if current_month = target_month
          then
            current_date :: tl_ans
          else
            tl_ans
        end

    val dates_on_target_month = dates_on_given_month(all_dates);
  in
    length dates_on_target_month
  end

(* ####################### 3 ############################## *)

fun number_in_months(dates : (int * int * int) list, months : int list) =
  if null months
  then 0
  else
    let
      val current_month = hd months
      val number_in_current_month = number_in_month(dates, current_month)
      val number_in_rest_of_months = number_in_months(dates, tl months);
    in
      number_in_current_month + number_in_rest_of_months
    end


(* ####################### 4 ############################## *)

fun dates_in_month(dates : (int * int * int) list, target_month : int) =
  if null dates
  then []
  else
    let
      val current_date = hd dates
      val current_month = #2 current_date
      val tl_ans = dates_in_month(tl dates, target_month)
    in
      if current_month = target_month
      then
        current_date :: tl_ans
      else
        tl_ans
    end

(* ####################### 5 ############################## *)

fun dates_in_months(dates : (int * int * int) list, target_months : int list) =
  if null target_months
  then []
  else
    let
      val current_month = hd target_months
      val dates_in_current_month = dates_in_month(dates, current_month)
      val dates_in_rest_of_months = dates_in_months(dates, tl target_months)
    in
      dates_in_current_month @ dates_in_rest_of_months
    end

(* ####################### 6 ############################## *)

fun get_nth(strings : string list, n : int) =
  if n <= 1
  then hd strings
  else
    get_nth(tl strings, n - 1)

(* ####################### 7 ############################## *)

val month_names = [
  "January", "February", "March", "April",
  "May", "June", "July", "August", "September",
  "October", "November", "December"
]

fun date_to_string(date : int * int * int) =
  let
    val year = Int.toString(#1 date)
    val month = get_nth(month_names, #2 date)
    val day = Int.toString(#3 date)
  in
    month ^ " " ^ day ^ ", " ^ year
  end

(* ####################### 8 ############################## *)

fun number_before_reaching_sum(sum: int, xs: int list) =
  let
    fun count_with_accumulator(xs: int list, accumulator: int, n: int) =
      if hd xs + accumulator >= sum
      then n
      else count_with_accumulator(tl xs, accumulator + hd xs, n + 1)
  in
    count_with_accumulator(xs, 0, 0)
  end

(* ####################### 9 ############################## *)

val num_days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

fun what_month(day : int) =
  number_before_reaching_sum(day, num_days_in_month) + 1;

(* ####################### 10 ############################## *)

fun month_range(day_1 : int, day_2 : int) =
  if day_1 > day_2 then []
  else what_month(day_1) :: month_range(day_1 + 1, day_2)

(* ####################### 10 ############################## *)

fun oldest(dates: (int * int * int) list) =
  if null dates
  then NONE
  else
    let
      val tl_ans = oldest(tl dates)
    in
      if isSome tl_ans andalso is_older(valOf tl_ans, hd dates)
      then tl_ans
      else SOME (hd dates)
    end
