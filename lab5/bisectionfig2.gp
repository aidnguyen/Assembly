set terminal latex size 5.0, 3.0
set title "Bisection - $x^2 - 2.0$ - Initial guesses, of range"
set xlabel "$x$ axis"
set ylabel "$y$ axis"
set output "bisectionfig2.tex"
set xzeroaxis
set yzeroaxis
set label "High" at 5,-1
set label "Low" at 1, -1
set arrow from 5,-1 to 5,4 nohead
set arrow from 1,-1 to 1,4 nohead
f(x) = x*x - 2.0
plot [-1:6][-3:6] f(x)
