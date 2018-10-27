(* ############################################# *)
(* ################# helper functions ########## *)
(* ############################################# *)

(* Check two strings (s1 and s2) match. *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* ############################################# *)
(* ################# problem 1a ################ *)
(* ############################################# *)

(* (a) Write a function all_except_option, which takes a string and a string list. Return NONE if the *)
(* string is not in the list, else return SOME lst where lst is identical to the argument list except the string *)
(* is not in it. You may assume the string is in the list at most once. Use same_string, provided to you, *)
(* to compare strings. Sample solution is around 8 lines. *)
(* fun find(target, xs) *)

fun all_except_option(x, xs) =
let
  fun all_except(x, xs) =
    case xs of
         [] => []
       | head::rest' =>
           let val tl_ans = all_except(x, rest')
           in if same_string(x, head) then tl_ans else head::tl_ans
           end
  val everything_else = all_except(x, xs)
in
  if everything_else <> xs then SOME(all_except(x, xs)) else NONE
end

(* ############################################# *)
(* ################# problem 1b ################ *)
(* ############################################# *)

(* (b) Write a function get_substitutions1, which takes a string list list (a list of list of strings, the *)
(* substitutions) and a string s and returns a string list. The result has all the strings that are in *)
(* some list in substitutions that also has s, but s itself should not be in the result. *)

fun get_substitutions1 (ss, s) =
  case ss of
       [] => []
     | head::tail' =>
         let val tl_ans = get_substitutions1(tail', s)
         in
           case all_except_option(s, head) of
                SOME subs => subs @ tl_ans
              | NONE => tl_ans
         end

(* ############################################# *)
(* ################# problem 1c ################ *)
(* ############################################# *)

(* (c) Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursive *)
(* local helper function. *)

fun get_substitutions2 (ss, s) =
let
  fun aux(ss, acc) =
    case ss of
         [] => acc
       | head::tail' => 
           case all_except_option(s, head) of
                SOME subs => aux(tail', acc @ subs)
              | NONE => aux(tail', acc)
in
  aux(ss, [])
end

(* ############################################# *)
(* ################# problem 1d ################ *)
(* ############################################# *)

(* (d) Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and *)
(* (c)) and a full name of type {first:string,middle:string,last:string} and returns a list of full *)
(* names (type {first:string,middle:string,last:string} list). The result is all the full names you *)
(* can produce by substituting for the first name (and only the first name) using substitutions and parts (b) *)
(* or (c). The answer should begin with the original name (then have 0 or more other names). Example: *)
(* answer: [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", * last="Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"}] *)
(* {first="F", last="Smith", middle="W"}] *1) *)
(* Do not eliminate duplicates from the answer. Hint: Use a local helper function. Sample solution is *)
(* around 10 lines. *)

fun similar_names(names, name) =
let
  val { first=first, middle=middle, last=last } = name
  val all_substitutions = get_substitutions2(names, first)

  fun construct_and_substitute_names(substitutions, acc) =
    case substitutions of
         [] => acc
       | substitution::tail' => { first=substitution, middle=middle, last=last }  :: construct_and_substitute_names(tail', acc)
in
  name :: construct_and_substitute_names(all_substitutions, [])
end

(* ############################################# *)
(* ################# helpers ################### *)
(* ############################################# *)

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun same_card(card1 : card, card2 : card) = card1 = card2

(* ############################################# *)
(* ################# problem 2a ################ *)
(* ############################################# *)

(* (a) Write a function card_color, which takes a card and returns its color (spades and clubs are black, *)
(* diamonds and hearts are red). Note: One case-expression is enough. *)

fun card_color(suit, _) =
  case suit of Clubs => Black | Spades => Black | _ => Red

(* ############################################# *)
(* ################# problem 2b ################ *)
(* ############################################# *)

(* (b) Write a function card_value, which takes a card and returns its value (numbered cards have their *)
(* number as the value, aces are 11, everything else is 10). Note: One case-expression is enough. *)

fun card_value(_, rank) =
  case rank of Num number => number | Ace => 11 | _ => 10

(* ############################################# *)
(* ################# problem 2c ################ *)
(* ############################################# *)

(* (c) Write a function remove_card, which takes a list of cards cs, a card c, and an exception e. It returns a *)
(* list that has all the elements of cs except c. If c is in the list more than once, remove only the first one. *)
(* If c is not in the list, raise the exception e. You can compare cards with =. *)

fun remove_card(cs, c, e) =
let
  fun aux(cs, acc, found) =
    case cs of
         [] => if not found then raise e else acc
       | head::tail' => if same_card(head, c) andalso not found
                        then
                          aux(tail', acc, true)
                        else
                          head :: aux(tail', acc, found)
in
  aux(cs, [], false)
end

(* ############################################# *)
(* ################# problem 2d ################ *)
(* ############################################# *)

(* (d) Write a function all_same_color, which takes a list of cards and returns true if all the cards in the *)
(* list are the same color. Hint: An elegant solution is very similar to one of the functions using nested *)
(* pattern-matching in the lectures. *)

fun all_same_color(cs) =
let
  fun same_color(card1 : card, card2 : card) = card_color(card1) = card_color(card2)
in
  case cs of
       [] => true
     | _::[] => true
     | head::(neck::tail') => same_color(head, neck) andalso all_same_color(neck::tail')
end

(* ############################################# *)
(* ################# problem 2e ################ *)
(* ############################################# *)

(* (e) Write a function sum_cards, which takes a list of cards and returns the sum of their values. Use a locally *)
(* defined helper function that is tail recursive. (Take “calls use a constant amount of stack space” as a *)
(* requirement for this problem.) *)

fun sum_cards(cards) =
let
  fun aux(cards, acc) =
    case cards of [] => acc | head::tail' => aux(tail', card_value(head) + acc)
in
  aux(cards, 0)
end


(* ############################################# *)
(* ################# problem 2f ################ *)
(* ############################################# *)

(* (f) Write a function score, which takes a card list (the held-cards) and an int (the goal) and computes *)
(* the score as described above. *)

(* The objective is to end the game with a low score (0 is best). Scoring works as follows: Let sum be the sum *)
(* of the values of the held-cards. If sum is greater than goal, the preliminary score is three times (sum−goal), *)
(* else the preliminary score is (goal − sum). The score is the preliminary score unless all the held-cards are *)
(* the same color, in which case the score is the preliminary score divided by 2 (and rounded down as usual *)
(* with integer division; use ML’s div operator). *)
(* val goal = 26 *)
(* val sum = 25 *)
(* val preliminary_score = 1 *)

fun score(held_cards, goal) =
let
  val sum = sum_cards(held_cards)
  val preliminary_score = if sum > goal then 3 * (sum - goal) else goal - sum
  val final_score = if all_same_color(held_cards) then preliminary_score div 2 else preliminary_score
in
  final_score
end


(* ############################################# *)
(* ################# problem 2g ################ *)
(* ############################################# *)

(* (g) Write a function officiate, which “runs a game.” It takes a card list (the card-list) a move list *)
(* (what the player “does” at each point), and an int (the goal) and returns the score at the end of the *)
(* game after processing (some or all of) the moves in the move list in order. Use a locally defined recursive *)
(* helper function that takes several arguments that together represent the current state of the game. *)
(* • The game starts with the held-cards being the empty list. *)
(* • The game ends if there are no more moves. (The player chose to stop since the move list is empty.) *)
(* • If the player discards some card c, play continues (i.e., make a recursive call) with the held-cards *)
(* not having c and the card-list unchanged. If c is not in the held-cards, raise the IllegalMove *)
(* exception. *)
(* • If the player draws and the card-list is (already) empty, the game is over. Else if drawing causes *)
(* the sum of the held-cards to exceed the goal, the game is over (after drawing). Else play continues *)
(* with a larger held-cards and a smaller card-list. *)

fun officiate(card_list, move_list, goal) =
let
  fun move(card_list, held_cards, move_list) =
    case move_list of
         [] => score(held_cards, goal)
       | (Discard card)::rest_of_moves' =>
           let
             val held_cards = remove_card(held_cards, card, IllegalMove)
           in
             move(card_list, held_cards, rest_of_moves')
           end
       | Draw::rest_of_moves' =>
           case card_list of 
                [] => score(held_cards, goal)
              | head::rest_of_cards' =>
                  let
                    val held_cards = head :: held_cards
                    val exceeds_goal = sum_cards(held_cards) > goal
                  in
                    if exceeds_goal
                    then score(held_cards, goal)
                    else move(rest_of_cards', held_cards, rest_of_moves')
                  end
in
  move(card_list, [], move_list)
end
