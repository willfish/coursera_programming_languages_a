use "hw3.sml";

val only_capitals_test_1 = only_capitals(["hello", "World"]) = ["World"]
val only_capitals_test_2 = only_capitals(["Hello", "world"]) = ["Hello"]
val only_capitals_test_3 = only_capitals(["hello", "world"]) = []
val only_capitals_test_4 = only_capitals([]) = []

val longest_string1_test_0a = longest_string1([]) = ""
val longest_string1_test_0b = longest_string1(["abc"]) = "abc"
val longest_string1_test_1 = longest_string1(["a", "ab", "abc"]) = "abc"
val longest_string1_test_2 = longest_string1(["abc", "ab", "a"]) = "abc"
val longest_string1_test_3 = longest_string1(["ab", "abc", "a"]) = "abc"
val longest_string1_test_4 = longest_string1(["a", "abc", "ab"]) = "abc"
val longest_string1_test_5 = longest_string1(["a", "b", "c"]) = "a"

val longest_string2_test_0a = longest_string2([]) = ""
val longest_string2_test_0b = longest_string2(["abc"]) = "abc"
val longest_string2_test_1 = longest_string2(["a", "ab", "abc"]) = "abc"
val longest_string2_test_2 = longest_string2(["abc", "ab", "a"]) = "abc"
val longest_string2_test_3 = longest_string2(["ab", "abc", "a"]) = "abc"
val longest_string2_test_4 = longest_string2(["a", "abc", "ab"]) = "abc"
val longest_string2_test_5 = longest_string2(["a", "b", "c"]) = "c"

val longest_string3_test_0a = longest_string3 [] = ""
val longest_string3_test_0b = longest_string3 ["abc"] = "abc"
val longest_string3_test_1 = longest_string3 ["a", "ab", "abc"] = "abc"
val longest_string3_test_2 = longest_string3 ["abc", "ab", "a"] = "abc"
val longest_string3_test_3 = longest_string3 ["ab", "abc", "a"] = "abc"
val longest_string3_test_4 = longest_string3 ["a", "abc", "ab"] = "abc"
val longest_string3_test_5 = longest_string3 ["a", "b", "c"] = "a"

val longest_string4_test_0a = longest_string4 [] = ""
val longest_string4_test_0b = longest_string4 ["abc"] = "abc"
val longest_string4_test_1 = longest_string4 ["a", "ab", "abc"] = "abc"
val longest_string4_test_2 = longest_string4 ["abc", "ab", "a"] = "abc"
val longest_string4_test_3 = longest_string4 ["ab", "abc", "a"] = "abc"
val longest_string4_test_4 = longest_string4 ["a", "abc", "ab"] = "abc"
val longest_string4_test_5 = longest_string4 ["a", "b", "c"] = "c"

val longest_capitalized_test_0a = longest_capitalized [] = ""
val longest_capitalized_test_0b = longest_capitalized ["abc"] = ""
val longest_capitalized_test_1 = longest_capitalized ["A", "ab", "abc"] = "A"
val longest_capitalized_test_2 = longest_capitalized ["Abc", "Ab", "A"] = "Abc"
val longest_capitalized_test_3 = longest_capitalized ["Ab", "Abc", "A"] = "Abc"
val longest_capitalized_test_4 = longest_capitalized ["A", "Abc", "Ab"] = "Abc"
val longest_capitalized_test_5 = longest_capitalized ["A", "B", "C"] = "A"

val rev_string_test_0 = rev_string "" = ""
val rev_string_test_1 = rev_string "Hello" = "olleH"
val rev_string_test_2 = rev_string "olleH" = "Hello"

val first_answer_test0a = (first_answer (fn x => if x > 1 then SOME x else NONE) [] handle NoAnswer => 1) = 1
val first_answer_test0b = (first_answer (fn x => if x > 5 then SOME x else NONE) [1,2,3,4,5] handle NoAnswer => 1) = 1
val first_answer_test1 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val first_answer_test2 = first_answer (fn x => if x > 0 then SOME x else NONE) [1,2,3,4,5] = 1

val check_all_equal_one = all_answers (fn x => if x = 1 then SOME [x] else NONE)
val all_answers_test1 = check_all_equal_one [] = SOME []
val all_answers_test2 = check_all_equal_one [2,3,4,5,6,7] = NONE
val all_answers_test3 = check_all_equal_one [7] = NONE
val all_answers_test4 = check_all_equal_one [1, 2] = NONE
val all_answers_test5 = check_all_equal_one [1] = SOME [1]
val all_answers_test6 = check_all_equal_one [1, 1, 1] = SOME [1, 1, 1]

val count_wildcards_test1 = count_wildcards Wildcard = 1
val count_wildcards_test2 = count_wildcards (TupleP([])) = 0
val count_wildcards_test3 = count_wildcards (TupleP([TupleP([Wildcard, Wildcard, TupleP([Wildcard])])])) = 3
val count_wildcards_test4 = count_wildcards (ConstructorP("foo", Wildcard)) = 1
val count_wildcards_test5 = count_wildcards (Variable("foo")) = 0
val count_wildcards_test6 = count_wildcards UnitP = 0
val count_wildcards_test7 = count_wildcards (ConstP(1)) = 0

val count_wild_and_variable_lengths_test1 = count_wild_and_variable_lengths Wildcard = 1
val count_wild_and_variable_lengths_test2 = count_wild_and_variable_lengths (TupleP([])) = 0
val count_wild_and_variable_lengths_test3 = count_wild_and_variable_lengths (TupleP([TupleP([Wildcard, Wildcard, TupleP([Wildcard, Variable("foo")])])])) = 6
val count_wild_and_variable_lengths_test4 = count_wild_and_variable_lengths (ConstructorP("foo", Wildcard)) = 1
val count_wild_and_variable_lengths_test5 = count_wild_and_variable_lengths (Variable("foo")) = 3
val count_wild_and_variable_lengths_test6 = count_wild_and_variable_lengths UnitP = 0
val count_wild_and_variable_lengths_test7 = count_wild_and_variable_lengths (ConstP(1)) = 0

val count_some_var_test1 = count_some_var ("foo", Wildcard) = 0
val count_some_var_test2 = count_some_var ("foo", TupleP([])) = 0
val count_some_var_test3 = count_some_var ("foo", TupleP([TupleP([Wildcard, Wildcard, TupleP([Wildcard, Variable("foo"),Variable("bar")])])])) = 1
val count_some_var_test4 = count_some_var ("foo", ConstructorP("foo", Wildcard)) = 0
val count_some_var_test5 = count_some_var ("foo", Variable("foo")) = 1
val count_some_var_test6 = count_some_var ("foo", Variable("bar")) = 0
val count_some_var_test7 = count_some_var ("foo", UnitP) = 0
val count_some_var_test8 = count_some_var ("foo", ConstP(1)) = 0

val check_pat_test_1 = check_pat UnitP = true
val check_pat_test_2 = check_pat (Variable("x")) = true
val check_pat_test_3 = check_pat ((TupleP([TupleP([Wildcard, Variable("foo"), TupleP([Wildcard, Variable("foo"),Variable("bar")])])]))) = false
val check_pat_test_4 = check_pat ((TupleP([TupleP([Wildcard, Variable("foo"), TupleP([Wildcard, Variable("bar"),Variable("baz")])])]))) = true

val match_test_1 = match (Const(1), UnitP) = NONE
val match_test_2 = match (Const(1), Wildcard) = SOME []
val match_test_3 = match (Unit, UnitP) = SOME []
val match_test_4 = match (Const(1), ConstP(2)) = NONE
val match_test_5 = match (Const(1), ConstP(1)) = SOME []

val test1 = only_capitals ["A","B","C"] = ["A","B","C"]

val test2 = longest_string1 ["A","bc","C"] = "bc"

val test3 = longest_string2 ["A","bc","C"] = "bc"

val test4a = longest_string3 ["A","bc","C"] = "bc"

val test4b = longest_string4 ["A","B","C"] = "C"

val test5 = longest_capitalized ["A","bc","C"] = "A"

val test6 = rev_string "abc" = "cba"

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1

val test10 = check_pat (Variable("x")) = true

val test11 = match (Const(1), UnitP) = NONE

val test12 = first_match Unit [UnitP] = SOME []
