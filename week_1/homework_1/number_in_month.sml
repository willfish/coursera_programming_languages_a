(* use "homework_1/number_in_month.sml"; *)
(* a date is equivalent to y * m * d *)
(* only positive dates are used *)

(* Write a function number_in_month that takes a list of dates and a month (i.e., an int) and returns
how many dates in the list are in the given month. *)
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
