use "hw2.sml";

(* ################# problem 1a ################### *)

(* (a) Write a function all_except_option, which takes a string and a string list. Return NONE if the *)
(* string is not in the list, else return SOME lst where lst is identical to the argument list except the string *)
(* is not in it. You may assume the string is in the list at most once. Use same_string, provided to you, *)
(* to compare strings. Sample solution is around 8 lines. *)
(* fun find(target, xs) *)

val result_1 = SOME ["baz"]
val all_except_option_a = all_except_option("foo", ["foo", "baz"]) = result_1
val result_2 = NONE
val all_except_option_b = all_except_option("foo", ["baz"]) = result_2
val result_3 = NONE
val all_except_option_c = all_except_option("foo", []) = result_3
val result_4 = SOME ["baz", "klux", "bees", "birds", "badgers"]
val all_except_option_d = all_except_option("foo", ["baz", "klux", "bees", "birds", "badgers", "foo"]) = result_4

(* ################# problem 1b ################### *)

(* (b) Write a function get_substitutions1, which takes a string list list (a list of list of strings, the *)
(* substitutions) and a string s and returns a string list. The result has all the strings that are in *)
(* some list in substitutions that also has s, but s itself should not be in the result. Example: *)
(* get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") *)

(* answer: ["Fredrick","Freddie","F"] *)
(* Assume each list in substitutions has no repeats. The result will have repeats if s and another string are *)
(* both in more than one list in substitutions. Example: *)
(* get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], *)
(* "Jeff") *)
(* answer: ["Jeffrey","Geoff","Jeffrey"] *)
(* Use part (a) and ML’s list-append (@) but no other helper functions. Sample solution is around 6 lines. *)

val get_substitutions1_a_input = ([[],[],[]], "Bill")
val get_substitutions1_a_result = get_substitutions1(get_substitutions1_a_input) 
val get_substitutions1_a = get_substitutions1_a_result = []

val get_substitutions1_b_input = ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred")
val get_substitutions1_b = get_substitutions1(get_substitutions1_b_input);
val get_substitutions1_b_test = ["Fredrick","Freddie","F"] = get_substitutions1_b

val get_substitutions1_c_input = ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")
val get_substitutions1_c = get_substitutions1(get_substitutions1_c_input)
val get_substitutions1_c_result = ["Jeffrey","Geoff","Jeffrey"] = get_substitutions1_c

(* ################# problem 1c ################### *)

(* (c) Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursive *)
(* local helper function. *)

val get_substitutions2_a_input = ([[],[],[]], "Bill")
val get_substitutions2_a_result = get_substitutions2(get_substitutions2_a_input) 
val get_substitutions2_a = get_substitutions2_a_result = []

val get_substitutions2_b_input = ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred")
val get_substitutions2_b = get_substitutions2(get_substitutions2_b_input);
val get_substitutions2_b_test = ["Fredrick","Freddie","F"] = get_substitutions2_b

val get_substitutions2_c_input = ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff")
val get_substitutions2_c = get_substitutions2(get_substitutions2_c_input)
val get_substitutions2_c_result = ["Jeffrey","Geoff","Jeffrey"] = get_substitutions2_c

(* ################# problem 1d ################### *)

(* (d) Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and *)
(* (c)) and a full name of type {first:string,middle:string,last:string} and returns a list of full *)
(* names (type {first:string,middle:string,last:string} list). The result is all the full names you *)
(* can produce by substituting for the first name (and only the first name) using substitutions and parts (b) *)
(* or (c). The answer should begin with the original name (then have 0 or more other names). *)

val names_list = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"})

val similar_names_a_input = ([[],[],[]], { first="Bill", middle="Me", last="Later" })
val similar_names_a_result = similar_names(similar_names_a_input) 
val similar_names_a_test = [{first="Bill",middle="Me",last="Later"}] = similar_names_a_result 

val similar_names_b_input = (
    [["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
    {first="Fred",middle="W",last="Smith"}
  )
val similar_names_b_result = similar_names(similar_names_b_input);
val similar_names_b_expected = [
    {first="Fred",last="Smith",middle="W"},
    {first="Fredrick",last="Smith",middle="W"},
    {first="Freddie",last="Smith",middle="W"},
    {first="F",last="Smith",middle="W"}
  ]
val similar_names_b_test = similar_names_b_expected = similar_names_b_result

(* ################# problem 2a ################### *)

(* (a) Write a function card_color, which takes a card and returns its color (spades and clubs are black, *)
(* diamonds and hearts are red). Note: One case-expression is enough. *)

val card_color_card_1 = (Clubs, Jack)
val card_color_card_2 = (Spades, Jack)
val card_color_card_3 = (Hearts, Jack)
val card_color_card_4 = (Diamonds, Jack)
(* val card_color_card_5 = ("foo", Jack) *)

val card_color_test_1 = card_color(card_color_card_1) = Black
val card_color_test_2 = card_color(card_color_card_2) = Black
val card_color_test_3 = card_color(card_color_card_3) = Red
val card_color_test_4 = card_color(card_color_card_4) = Red
(* val card_color_test_5 = card_color(card_color_card_5) = Red *)

(* ################# problem 2b ################### *)

(* (b) Write a function card_value, which takes a card and returns its value (numbered cards have their *)
(* number as the value, aces are 11, everything else is 10). Note: One case-expression is enough. *)

val card_value_card_1 = (Clubs, Jack)
val card_value_card_2 = (Spades, Queen)
val card_value_card_3 = (Hearts, King)
val card_value_card_4 = (Diamonds, Ace)
val card_value_card_5 = (Clubs, Num 5)

val card_value_test_1 = card_value(card_value_card_1) = 10
val card_value_test_2 = card_value(card_value_card_2) = 10
val card_value_test_3 = card_value(card_value_card_3) = 10
val card_value_test_4 = card_value(card_value_card_4) = 11
val card_value_test_5 = card_value(card_value_card_5) = 5

(* ################# problem 2c ################### *)

(* (c) Write a function remove_card, which takes a list of cards cs, a card c, and an exception e. It returns a *)
(* list that has all the elements of cs except c. If c is in the list more than once, remove only the first one. *)
(* If c is not in the list, raise the exception e. You can compare cards with =. *)

val remove_card_card_1 = (Clubs, Jack)
val remove_card_card_2 = (Spades, Queen)
val remove_card_card_3 = (Hearts, King)
val remove_card_card_4 = (Diamonds, Ace)
val remove_card_card_5 = (Clubs, Num 5)
val remove_card_not_exist = (Clubs, Num 8)

(* All cards *)
val remove_card_cards_1 = [
    remove_card_card_1,
    remove_card_card_2,
    remove_card_card_3,
    remove_card_card_4,
    remove_card_card_5
  ]
(* All cards with a repeated card *)
val remove_card_cards_2 = [
    remove_card_card_1,
    remove_card_card_2,
    remove_card_card_3,
    remove_card_card_4,
    remove_card_card_5,
    remove_card_card_5
  ]

(* All cards deleted start *)
val remove_card_expected_1 = [
    remove_card_card_2,
    remove_card_card_3,
    remove_card_card_4,
    remove_card_card_5
  ]
(* All cards deleted middle *)
val remove_card_expected_2 = [
    remove_card_card_1,
    remove_card_card_3,
    remove_card_card_4,
    remove_card_card_5
  ]
(* All cards deleted end *)
val remove_card_expected_3 = [
    remove_card_card_1,
    remove_card_card_2,
    remove_card_card_3,
    remove_card_card_4
  ]
(* All cards with a repeated card one is deleted *)
val remove_card_expected_4 = [
    remove_card_card_1,
    remove_card_card_2,
    remove_card_card_3,
    remove_card_card_4,
    remove_card_card_5
  ]
(* All cards with a repeated card middle is deleted *)
val remove_card_expected_5 = [
    remove_card_card_1,
    remove_card_card_2,
    remove_card_card_3,
    remove_card_card_5,
    remove_card_card_5
  ]

exception TestException

val remove_card_test_1 = remove_card(
    remove_card_cards_1, remove_card_card_1, TestException
  ) = remove_card_expected_1

val remove_card_test_2 = remove_card(
    remove_card_cards_1, remove_card_card_2, TestException
  ) = remove_card_expected_2

val remove_card_test_3 = remove_card(
    remove_card_cards_1, remove_card_card_5, TestException
  ) = remove_card_expected_3

val remove_card_test_4 = remove_card(
    remove_card_cards_2, remove_card_card_5, TestException
  ) = remove_card_expected_4

val remove_card_test_5 = remove_card(
    remove_card_cards_2, remove_card_card_4, TestException
  ) = remove_card_expected_5

val remove_card_test_6_result = remove_card(
    remove_card_cards_1, remove_card_not_exist, TestException
  ) handle TestException => []

val remove_card_test_6 = remove_card_test_6_result = []


(* ################# problem 2d ################### *)

(* (d) Write a function all_same_color, which takes a list of cards and returns true if all the cards in the *)
(* list are the same color. Hint: An elegant solution is very similar to one of the functions using nested *)
(* pattern-matching in the lectures. *)

val all_same_color_card_1 = (Clubs, Jack)
val all_same_color_card_2 = (Hearts, Jack)

(* All the same *)
val all_same_color_cards_1 = [
    all_same_color_card_1,
    all_same_color_card_1,
    all_same_color_card_1
  ]
(* Some the same *)
val all_same_color_cards_2a = [ all_same_color_card_1,
    all_same_color_card_2,
    all_same_color_card_2,
    all_same_color_card_1,
    all_same_color_card_1
  ]
(* Some the same *)
val all_same_color_cards_2b = [
    all_same_color_card_1,
    all_same_color_card_1,
    all_same_color_card_2,
    all_same_color_card_2,
    all_same_color_card_1
  ]
(* None the same *)
val all_same_color_cards_3 = [
    all_same_color_card_1,
    all_same_color_card_2
  ]
(* Empty *)
val all_same_color_cards_4 = []

val all_same_color_test_1 = all_same_color(all_same_color_cards_1) = true
val all_same_color_test_2a = all_same_color(all_same_color_cards_2a) = false
val all_same_color_test_2b = all_same_color(all_same_color_cards_2b) = false
val all_same_color_test_3 = all_same_color(all_same_color_cards_3) = false
val all_same_color_test_4 = all_same_color(all_same_color_cards_4) = true

(* ################# problem 2e ################### *)

(* (e) Write a function sum_cards, which takes a list of cards and returns the sum of their values. Use a locally *)
(* defined helper function that is tail recursive. (Take “calls use a constant amount of stack space” as a *)
(* requirement for this problem.) *)

val sum_cards_card_1 = (Clubs, Jack)
val sum_cards_card_2 = (Diamonds, Ace)
val sum_cards_card_3 = (Clubs, Num 5)

val sum_cards_cards_1 = [sum_cards_card_1, sum_cards_card_2, sum_cards_card_3]
val sum_cards_cards_2 = [sum_cards_card_1]
val sum_cards_cards_3 = []

val sum_cards_test_1 = sum_cards(sum_cards_cards_1) = 26
val sum_cards_test_2 = sum_cards(sum_cards_cards_2) = 10
val sum_cards_test_3 = sum_cards(sum_cards_cards_3) = 0

(* ################# problem 2f ################### *)

(* (f) Write a function score, which takes a card list (the held-cards) and an int (the goal) and computes *)
(* the score as described above. *)

(* The objective is to end the game with a low score (0 is best). Scoring works as follows: Let sum be the sum *)
(* of the values of the held-cards. If sum is greater than goal, the preliminary score is three times (sum−goal), *)
(* else the preliminary score is (goal − sum). The score is the preliminary score unless all the held-cards are *)
(* the same color, in which case the score is the preliminary score divided by 2 (and rounded down as usual *)
(* with integer division; use ML’s div operator). *)

val score_card_1 = (Clubs, Jack)
val score_card_2 = (Spades, Queen)
val score_card_3 = (Hearts, King)
val score_card_4 = (Diamonds, Ace)
val score_card_5 = (Clubs, Num 5)

(* Different color *)
val score_cards_1 = [score_card_1,score_card_2,score_card_3,score_card_4,score_card_5]

val score_cards_2 = [score_card_1,score_card_2,score_card_5]

(* Same color and sum < goal *)
val score_test_1 = score(score_cards_1, 47)
(* Same color and sum = goal *)
val score_test_2 = score(score_cards_1, 46)
(* Same color and sum > goal *)
val score_test_3 = score(score_cards_1, 45)

(* Different color and sum < goal *)
val score_test_4 = score(score_cards_2, 26)
(* Different color and sum = goal *)
val score_test_5 = score(score_cards_2, 25)
(* Different color and sum > goal *)
val score_test_6 = score(score_cards_2, 24)

(* ########################################################################################## *)
(* ################################ provided tests ########################################## *)
(* ########################################################################################## *)

val test1 = all_except_option ("string", ["string"]) = SOME []

val test2 = get_substitutions1 ([["foo"],["there"]], "foo") = []

val test3 = get_substitutions2 ([["foo"],["there"]], "foo") = []

val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test5 = card_color (Clubs, Num 2) = Black

val test6 = card_value (Clubs, Num 2) = 2

val test7 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test8 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true

val test9 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4

val test10 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
