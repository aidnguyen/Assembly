PolyML.print_depth 100;
(* fun dec_to_bin 0 = []
    |dec_to_bin n = dec_to_bin(n div 2) @ [n mod 2]; *)
fun cons (x,lst) = (op ::)(x,lst);
(* fun dec_to_bin 0 = []
   |dec_to_bin n = dec_to_bin(op div)(n,2) @ cons(op mod)(n,2), []); *)
fun append (lst1, lst2) = (op @)(lst1, lst2);
fun dec_to_bin 0 = []
   |dec_to_bin n = 
      append(dec_to_bin( (op div)(n,2) ), cons((op mod)(n,2), []));
fun lst_to_str (0::xs) = "0" ^ lst_to_str xs
   |lst_to_str (1::xs) = "1" ^ lst_to_str xs
   |lst_to_str _ = "";
lst_to_str(dec_to_bin 95); (* expect "1011111" *)
dec_to_bin 10;
dec_to_bin 4096;
lst_to_str(dec_to_bin 5000000000); 
