fun euclid (m, n) = if n > 0 then euclid (n, (m mod n))
		else m;
euclid(14,12);
euclid(14,11);
euclid(558,198);
