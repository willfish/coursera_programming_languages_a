fun bad_max (xs : int list) =
  if null xs
  then 0
  else if null (tl xs)
  then hd xs
  else if hd xs > bad_max(tl xs)
  then hd xs
  else bad_max(tl xs)

fun countup(from : int, to: int) =
  if from = to
  then to :: []
  else from :: countup(from + 1, to)

fun countdown(from : int, to : int) =
  if from = to
  then to :: []
  else from :: countdown(from - 1, to)

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
