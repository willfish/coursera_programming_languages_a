(* use "homework_1/is_older.sml"; *)
(* a date is equivalent to y * m * d *)
(* only positive dates are used *)

(* Write a function is_older that takes two dates and evaluates to true or false. It evaluates to true if
the first argument is a date that comes before the second argument. (If the two dates are the same,
the result is false.) *)

fun is_older(x : int * int * int, y : int * int * int) =
  let
    val x_year = #1 x
    val x_month = #2 x
    val x_day = #3 x

    val y_year = #1 y
    val y_month = #2 y
    val y_day = #3 y
  in
    if x = y
    then false
    else if x_year < y_year then true
    else if x_year > y_year then false
    else if x_month < y_month then true
    else if x_month > y_month then false
    else if x_day < y_day then true
    else false
  end
