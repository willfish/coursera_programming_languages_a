fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(s : string, xs : string list) =
	let
		fun f(ys) =
			case ys of
				[] => []
				| y::ys' => if same_string(s, y)
							then ys'
							else y::f(ys')
		val res = f(xs)
	in
		if xs <> res
		then SOME res
		else NONE
	end

fun get_substitutions1(xs : string list list, s : string) =
	case xs of
		[] => []
		| x::xs' => case all_except_option(s, x) of
						NONE => get_substitutions1(xs', s)
						| SOME ys => ys@get_substitutions1(xs', s)

fun get_substitutions2(xs : string list list, s : string) =
	let fun f (xs, acc) =
		case xs of
			[] => acc
			| x::xs' => case all_except_option(s, x) of
							NONE => f(xs', acc)
							| SOME ys => f(xs', acc@ys)
	in
		f(xs, [])
	end

fun similar_names(xs, {first=first, middle=middle, last=last}) =
	let fun f(ys, acc) =
			case ys of
				[] => acc
				| y::ys' => f(ys', acc@[{first=y, middle=middle, last=last}])
	in
		f(get_substitutions2(xs, first), [{first=first, middle=middle, last=last}])
	end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

fun card_color(input) =
	case input of
		(Clubs, _) => Black
		| (Spades, _) => Black
		| (_, _) => Red

fun card_value(input) =
	case input of (_, Num x) => x | (_, Ace) => 11 | (_, _) => 10

fun remove_card (cs, c, e) =
	case cs of
		[] => raise e
		| x::[] => if c = x
					then []
					else raise e
		| x::xs' => if c = x
					then xs'
					else x::remove_card(xs', c, e)

fun all_same_color (cs) =
	case cs of
		[] => true
		| _::[] => true
		| x::(x1::xs') => (card_color(x) = card_color(x1)) andalso all_same_color(x1::xs')

fun sum_cards (cs) =
	let fun f (cs, acc) =
		case cs of
			[] => acc
			| x::xs' => f(xs', card_value(x) + acc)
	in
		f(cs, 0)
	end

fun score (cs, goal) =
	let val sum = sum_cards(cs)
    val preliminary_score =
			if sum > goal
			then 3 * (sum - goal)
			else goal - sum
	in
		if all_same_color(cs)
		then preliminary_score div 2
		else preliminary_score
	end

fun officiate (cs, ms, goal) =
	let fun f (hs, cs_new, ms_new) =
			case ms_new of
				[] => score(hs, goal)
				| y::ys' => case y of
								Discard c => f(remove_card(hs, c, IllegalMove), cs_new, ys')
								| Draw => case cs_new of
											[] => score(hs, goal)
											| x::xs' => if sum_cards(x::hs) > goal
														then score(x::hs, goal)
														else f(x::hs, xs', ys')
	in
		f([], cs, ms)
	end
