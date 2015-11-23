fun square x: real = x * x;
square 2.0;
fun odd x = x mod 2 = 1;
odd 3;
odd 4;
fun power r p = if p = 0 then 1.0
		else if odd p then r * power r (p-1)
		else square (power r (p div 2));
power 5.0 3; (* 125 *)
power 2.0 8; (* 256 *)
