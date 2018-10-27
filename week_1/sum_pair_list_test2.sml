use "list_functions.sml";

val pair_list_1 = [(0,0),(0,0)];
val pair_list_2 = [(1,1)];
val pair_list_3 = [(1,1),(2,2)];

val x = sum_pair_list_2(pair_list_1) = 0;
val y = sum_pair_list_2(pair_list_2) = 2;
val z = sum_pair_list_2(pair_list_3) = 6;
