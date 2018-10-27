
(* Problem 1 - is_older *)
fun is_older(date1 : int*int*int, date2 : int*int*int) =
let fun calcDays (date : int*int*int) =
	((#1 date) * 1000)+ ((#2 date) * 10) + (#3 date);
in
	calcDays(date1) < calcDays(date2)
end;

(* Problem 2 - number_in_month *)
fun is_equal_month(date : int * int * int, month : int) =
		if #2 date = month
		then 1
		else 0;

fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then 0
    else is_equal_month(hd(dates), month) + number_in_month(tl(dates), month);

(* Problem 3 - number_in_months *)
fun number_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then 0
    else number_in_month(dates, hd(months)) + number_in_months(dates, tl(months));


(* Problem 4 - dates_in_month *)
fun append (xs : (int * int * int) list, ys : (int * int * int) list) =
    if null xs
    then ys
    else hd(xs) :: append(tl(xs), ys)

fun is_equal_month_date(date : int * int * int, month : int) =
		if #2 date = month
		then [date]
		else [];

fun dates_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then []
    else append(is_equal_month_date(hd(dates), month), dates_in_month(tl(dates), month));


(* Problem 5 - dates_in_months *)
fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then []
    else append(dates_in_month(dates, hd(months)), dates_in_months(dates, tl(months)));

(* Problem 6 - get_nth *)
fun get_nth (elements : string list, index : int) =
    if index = 1
    then hd(elements)
    else get_nth(tl(elements), index -1);

(* Problem 7 - date_to_string *)
fun date_to_string (date : (int * int * int)) =
	let
		val months = ["January", "February", "March", "April","May", "June", "July", "August", "September", "October", "November", "December"];
	in
		get_nth(months ,#2 date) ^" "^ Int.toString(#3 date) ^", "^Int.toString( #1 date)
	end;
val test7 = date_to_string (2013, 6, 1) = "June 1, 2013";

(* Problem 8 - number_before_reaching_sum *)
fun number_before_reaching_sum (sum : int, numbers : int list)=
		if sum < hd(numbers)
		then 0
		else
				let
					fun add_elements(index : int, current_sum : int, nums : int list) =
						if current_sum <= 0
						then index -1
						else add_elements(index + 1, current_sum - hd(nums), tl(nums))
				in
					add_elements(1, sum - hd(numbers), tl(numbers))
				end;

(* Problem 9 - what_month *)
fun what_month( day_of_year : int) =
	let
		val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	in
		number_before_reaching_sum(day_of_year, days_in_months) + 1
	end;

(* Problem 10 - month_range *)
fun month_range( day1 : int, day2 : int) =
	if day1 > day2
	then []
	else
			let
				fun create_month_array(day2 : int, result : int list) =
					if day2 < day1
					then result
					else create_month_array(day2 - 1, what_month(day2) :: result)
			in
				create_month_array(day2, [])
			end;

(* Problem 11 - oldest *)
fun oldest (xs : (int * int * int) list) =
    if null xs
    then \NONE
    else
    	let (* fine to assume argument nonempty because it is local *)
				fun max_nonempty (xs : (int * int * int) list) =
					if null (tl xs) (* xs better not be [] *)
					then hd xs
					else
						let val tl_ans = max_nonempty(tl xs)
					  in
							if is_older(hd xs,tl_ans)
						 	then hd xs
						 	else tl_ans
					  end
			in
			    SOME (max_nonempty xs)
			end
