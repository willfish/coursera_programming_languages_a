(* int -> int *)
fun silly1 (z : int) =
  let
    val x = if z > 0 then z else 34
  in
    x + 4
  end

(* unit -> int *)
fun silly2 () =
  let
    val x = 1
  in
    (let val x = 2 in x + 1 end) + ( let val y = 4 in x + 1 end)
  end

(* fun silly3 () =
  let
    val x = (let val x = 5 in x + 10 end)
  in
    (x, let val x = 2 in x end) *)

fun countup_from1(x : int) =
  let
    fun count (from : int) =
      if from = x
      then x :: []
      else from :: count(from + 1)
  in
    count(1)
  end
