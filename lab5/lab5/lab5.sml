val epsilon = 0.00000001;
val delta = 0.000000001;
fun bisection f low high =
	let
		val mid = (low + high) / 2.0;
		val image = f mid 
	in 
		if abs image < epsilon then mid
		else if abs (high - low) < delta then mid
		else if image < 0.0 then bisection f mid high
				    else bisection f low mid  	
	end;
fun parabola x = x*x -2.0;
bisection parabola ~1.0 5.0;
