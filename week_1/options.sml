(* We shouldn't recursively call to get a result more than once.
Cache a local value if we need to use it more than once *)
fun good_max (xs : int list) =
  if null xs
  then 0
  else if null (tl xs)
  then hd xs
  else
    let
      val tl_ans = good_max(tl xs)
      val hd_ans = hd xs
    in
      if hd_ans > tl_ans
      then hd_ans
      else tl_ans
    end

(* fn : int list -> int option *)
fun max_1 (xs : int list) =
  if null xs
  then NONE
  else
    let
      val tl_ans = good_max(tl xs)
    in
      if isSome tl_ans andalso valof tl_ans > hd xs
      then tl_ans
      else SOME (hd xs)
    end
