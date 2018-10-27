(* use "homework_1/date_to_string.sml"; *)

(* Write a function date_to_string that takes a date and returns a string of the form January 20, 2013
(for example). Use the operator ^ for concatenating strings and the library function Int.toString
for converting an int to a string. For producing the month part, do not use a bunch of conditionals.
Instead, use a list holding 12 strings and your answer to the previous problem. For consistency, put a
comma following the day and use capitalized English month names: January, February, March, April,
May, June, July, August, September, October, November, December. *)
val month_names = [
  "January", "February", "March", "April",
  "May", "June", "July", "August", "September",
  "October", "November", "December"
]

fun get_nth(strings : string list, n : int) =
  if n <= 1
  then hd strings
  else
    get_nth(tl strings, n - 1)

(* (int * int * int) -> string *)
fun date_to_string(date : int * int * int) =
  let
    val year = Int.toString(#1 date)
    val month = get_nth(month_names, #2 date)
    val day = Int.toString(#3 date)
  in
    month ^ " " ^ day ^ ", " ^ year
  end
