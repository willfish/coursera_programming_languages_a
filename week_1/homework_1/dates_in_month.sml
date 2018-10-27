(* use "homework_1/dates_in_month.sml"; *)

(* Write a function dates_in_month that takes a list of dates and a month (i.e., an int) and returns a
list holding the dates from the argument list of dates that are in the month. The returned list should
contain dates in the order they were originally given. *)

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
