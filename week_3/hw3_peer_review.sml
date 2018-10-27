(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (
fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(*val g = *)
(* fn : (unit -> int) -> (string -> int) -> pattern -> int *)
(*Char.isUpper (String.sub(s,0))*)
val only_capitals = List.filter (fn s => Char.isUpper(String.sub(s,0)))
(*  fn : string list -> string list *)

val longest_string1 = foldl (fn (x,y) => if size x > size y then x else y) ""

val longest_string2 = foldl (fn (x,y) => if size x >= size y then x else y) ""

fun longest_string_helper f strs = foldl (fn (x,y) => if f(size x,size y) then x else y) "" strs

val longest_string3 = longest_string_helper (fn (x,y) => x > y)

val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = implode o rev o explode

fun first_answer f args =
    case args of
	[] => raise NoAnswer
      | a::args' => case f(a) of NONE => first_answer f args'
			       | SOME a' => a'

fun all_answers f args =
    let fun aux f xs accum =
	    case xs of
		[] => SOME accum
	      | x::xs' => case f(x) of
			      NONE => NONE
			    | SOME x' => aux f xs' (accum @ x')
    in
	aux f args []
    end

val count_wildcards = g (fn _ => 1) (fn _ => 0)

val count_wild_and_variable_lengths = g (fn _ => 1) (fn x => size x)

fun count_some_var (str, p) = g (fn _ => 0) (fn x => if x = str then 1 else 0) p

fun check_pat p =
    let
	fun get_strs ps =
	    case ps of
		Variable v => [v]
	      | TupleP x => foldl (fn (x',rest) => rest @ get_strs x') [] x
	      | ConstructorP (_,ps') => get_strs ps'
	      | _ => []
	fun check_uniq lst =
	    case lst of
		[] => true
	      | x::xs => if List.exists (fn s => s = x) xs then false else check_uniq xs
    in
	(check_uniq o get_strs) p
    end

fun match (v,p) =
	case (v,p) of
		(_, Wildcard) => SOME []
		| (v', Variable s) => SOME [(s,v')]
		| (Unit, UnitP) => SOME []
		| (Const i, ConstP i') => if i = i' then SOME [] else NONE
		| (Tuple vs, TupleP ps) => all_answers match (ListPair.zip(vs, ps))
		| (Constructor(s2,vs), ConstructorP(s1,ps)) =>
		  if s1 = s2 then match(vs,ps) else NONE
		| _ => NONE

fun first_match v ps = SOME (first_answer (fn p' => match (v,p')) ps) handle NoAnswer => NONE
