use "list_functions.sml";

val pair_list_1 = [(0,1)]
val pair_list_2 = [(0,1),(0,1)]
val pair_list_3 = [(0,1),(1,0),(3,2)]

val x = firsts(pair_list_1) = [0];
val y = firsts(pair_list_2) = [0, 0];
val z = firsts(pair_list_3) = [0, 1, 3];
