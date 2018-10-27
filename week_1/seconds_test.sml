use "list_functions.sml";

val pair_list_1 = [(0,1)]
val pair_list_2 = [(0,1),(0,1)]
val pair_list_3 = [(0,1),(1,0),(3,2)]

val x = seconds(pair_list_1) = [1];
val y = seconds(pair_list_2) = [1, 1];
val z = seconds(pair_list_3) = [1, 0, 2];
