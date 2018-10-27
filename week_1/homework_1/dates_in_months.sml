(* use "homework_1/dates_in_months.sml"; *)

(* Write a function dates_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns a list holding the dates from the argument list of dates that are in any of the months in
the list of months. Assume the list of months has no number repeated. Hint: Use your answer to the
previous problem and SML’s list-append operator (@). *)

(* (int * int * int) list * int -> (int * int * int) list *)
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

(* (int * int * int) list * int list -> (int * int * int) list *)
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
