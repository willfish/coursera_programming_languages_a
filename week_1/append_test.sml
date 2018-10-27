use "list_functions.sml";

val x = append([], []) = [];
val y = append([1], []) = [1];
val z = append([], [1]) = [1];
val z = append([1], [1]) = [1,1];
val z = append([1,2,3,4,5], [4,4,4,4,4,4,4]) = [1,2,3,4,5,4,4,4,4,4,4,4];
