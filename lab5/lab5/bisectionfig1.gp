set terminal latex size 5.0, 3.0
set title "Bisection - $x^2 - 2.0$ - parabola"
set xlabel "$x$ axis"
set ylabel "$y$ axis"
set output "bisectionfig1.tex"
set xzeroaxis
set yzeroaxis
set label "Positive root = $\sqrt{2}$" at 2,-2
set arrow from 2,-2 to 1.4,0
f(x) = x*x -2
plot [-1:6][-3:6] f(x)
