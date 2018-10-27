(* Emre Motan, 2018-01-30, Coursera PL-A, HW1 Solution Code *)

(* *****************************************************************************
1. IS_OLDER

Write a function is_older that takes two dates and evaluates to true or
false. It evaluates to true if the first argument is a date that comes before
the second argument. (If the two dates are the same, the result is false.)

INPUT:
  d1 int*int*int
  d2 int*int*int

OUPUT:
  bool
***************************************************************************** *)
fun is_older(d1:int*int*int, d2:int*int*int) =
  (*
  When would this case be true - d1 < d2?
    1. Year d1 < Year d2, true
    2. Year d1 = Year d2 andalso Month d1 < Month d2, true
    3. Year d1 = Year d2 andalso Month d1 = Month d2, true andalso Day d1 < Day d2, true
    4. Else false
  *)
  if (#1 d1) < (#1 d2)
    then true
  else if (#1 d1) = (#1 d2) andalso (#2 d1) < (#2 d2)
    then true
  else if (#1 d1) = (#1 d2) andalso (#2 d1) = (#2 d2) andalso (#3 d1) < (#3 d2)
    then true
  else false


(* *****************************************************************************
2. NUMBER_IN_MONTH

Write a function number_in_month that takes a list of dates and a month (i.e.,
an int) and returns how many dates in the list are in the given month.

INPUT:
  dates:(int * int * int) list
  m:int

OUPUT:
  int
***************************************************************************** *)
fun number_in_month (dates:(int * int * int) list, m:int) =
  (* I want to recurse down the list of dates, bubbling up 1 if the
  month matches m. *)

  if null dates
    then 0
  else if (#2 (hd(dates))) = m
    then 1 + number_in_month(tl(dates), m)
  else
    number_in_month(tl(dates), m)


(* *****************************************************************************
3. NUMBER_IN_MONTHS

Write a function number_in_months that takes a list of dates and a list of
months (i.e., an int list) and returns the number of dates in the list of
dates that are in any of the months in the list of months. Assume the list of
months has no number repeated. Hint: Use your answer to the previous problem.

INPUT:
  dates:(int * int * int) list
  m:int list

OUPUT:
  int
***************************************************************************** *)
fun number_in_months (dates:(int * int * int) list, m:int list) =
  (* This time I want to recurse down the list of m, bubbling up the return
  values of the number_in_month function. *)

  if null m
    then 0
  else
    (number_in_month(dates, (hd(m)))) + number_in_months(dates, tl(m))


(* *****************************************************************************
4. DATES_IN_MONTH

Write a function dates_in_month that takes a list of dates and a month
(i.e., an int) and returns a list holding the dates from the argument list of
dates that are in the month. The returned list should contain dates in the
order they were originally given.

INPUT:
  dates:(int * int * int) list
  m:int

OUPUT:
  (int * int * int) list
***************************************************************************** *)
fun dates_in_month (dates:(int * int * int) list, m:int) =
  (* We want to perform a function similar to number_in_month but this time
  bubble up the dates that match m and append recursively. *)

  if null dates
    then []
  else
    let val tl_ans = dates_in_month((tl dates), m)
    in
      if (#2 (hd dates)) = m
      then [(hd dates)] @ tl_ans
      else tl_ans
    end


(* *****************************************************************************
5. DATES_IN_MONTHS

Write a function dates_in_months that takes a list of dates and a list of
months (i.e., an int list) and returns a list holding the dates from the
argument list of dates that are in any of the months in the list of months.
Assume the list of months has no number repeated. Hint: Use your answer to
the previous problem and SMLâ€™s list-append operator (@).

INPUT:
  dates:(int * int * int) list
  m:int list

OUPUT:
  (int * int * int) list
***************************************************************************** *)
fun dates_in_months (dates:(int * int * int) list, m:int list) =
  if null m
    then []
  else
    (dates_in_month(dates, (hd(m)))) @ dates_in_months(dates, tl(m))


(* *****************************************************************************
6. GET_NTH

Write a function get_nth that takes a list of strings and an int n and returns
the nth element of the list where the head of the list is 1st. Do not worry
about the case where the list has too few elements: your function may apply
hd or tl to the empty list in this case, which is okay.

INPUT:
  strings:string list
  n:int

OUPUT:
  string
***************************************************************************** *)
fun get_nth (strings:string list, n:int) =
  if n = 1 then (hd strings)
  else get_nth(tl strings, n-1)


(* *****************************************************************************
7. DATE_TO_STRING

Write a function date_to_string that takes a date and returns a string of the
form January 20, 2013 (for example). Use the operator ^ for concatening strings
and the library function Int.toString for converting an int to a string. For
producing the month part, do not use a bunch of conditionals. Instead use a
list holding 12 strings and your answer to the previous problem. For
consistency, put a comma following the day and use capitalized English month
names: January, February, March, April, May, June, July, August, September,
October, November, December.

INPUT:
  date:(int*int*int)

OUPUT:
  string
***************************************************************************** *)
fun date_to_string (date:int*int*int) =
  let
    val month_dict = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  in
    get_nth(month_dict, (#2 date)) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end

(* *****************************************************************************
8. NUMBER_BEFORE_REACHING_SUM

Write a function number_before_reaching_sum that takes an int called sum,
which you can assume is positive, and an int list, which you can assume
contains all positive numbers, and returns an int. You should return an int n
such that the first n elements of the list add to less than sum, but the first
n + 1 elements of the list add to sum or more. Assume the entire list sums to
more than the passed in value; it is okay for an exception to occur if this is
not the case.

INPUT:
  sum:int
  int_list:int list

OUPUT:
  int
***************************************************************************** *)
fun number_before_reaching_sum(sum:int, int_list:int list) =
  if (hd int_list) > sum orelse (hd int_list) = sum
  then 0
  else 1 + number_before_reaching_sum(sum - (hd int_list), (tl int_list))


(* *****************************************************************************
9. WHAT_MONTH

Write a function what_month that takes a day of year (i.e., an int between 1
and 365) and returns what month that day is in (1 for January, 2 for February,
etc.). Use a list holding 12 integers and your answer to the previous problem.

INPUT:
  day_of_year:int

OUPUT:
  int
***************************************************************************** *)
fun what_month(day_of_year:int) =
  let
    val month_starts = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
    number_before_reaching_sum (day_of_year, month_starts)
  end


(* *****************************************************************************
10. MONTH_RANGE

Write a function month_range that takes two days of the year day1 and day2 and
returns an int list [m1,m2,...,mn] where m1 is the month of day1, m2 is the
month of day1+1, ..., and mn is the month of day day2. Note the result will
have length day2 - day1 + 1 or length 0 if day1>day2.

INPUT:
  day1:int
  day2:int

OUPUT:
  int list
***************************************************************************** *)
fun month_range(day1:int, day2:int) =
  if day1 > day2
  then []
  else [what_month(day1)] @ month_range(day1+1, day2)


(* *****************************************************************************
11. OLDEST

Write a function oldest that takes a list of dates and evaluates to an
(int*int*int) option. It evaluates to NONE if the list has no dates and SOME d
if the date d is the oldest date in the list.

INPUT:
  dates:(int*int*int) list

OUPUT:
  (int*int*int) option
***************************************************************************** *)
fun oldest(dates:(int*int*int) list) =
  if null dates
  then NONE
  else (* fine to assume argument nonempty because it is local *)
    let
      fun oldest_nonempty (dates:(int*int*int) list) =
        if null (tl dates) (* dates must not be [] *)
        then hd dates
        else let val tl_ans = oldest_nonempty(tl dates)
          in
            if is_older(hd dates, tl_ans)
            then hd dates
            else tl_ans
          end
     in
       SOME (oldest_nonempty dates)
     end
