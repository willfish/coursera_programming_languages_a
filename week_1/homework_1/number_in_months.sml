(* use "homework_1/number_in_months.sml"; *)
(* a date is equivalent to y * m * d *)
(* only positive dates are used *)

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
(* Write a function number_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns the number of dates in the list of dates that are in any of the months in the list of months.
Assume the list of months has no number repeated. Hint: Use your answer to the previous problem. *)

(* (int * int * int) list * int list -> (int * int * int) list *)
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
