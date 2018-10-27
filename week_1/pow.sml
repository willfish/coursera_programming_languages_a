fun pow(x: int, y: int) =
  if y = 1
  then x
  else x * pow(x, y - 1)

pow 2,3;
