#include <stdio.h>
#include <math.h>
const double epsilon = 0.00000001, delta = 0.00000001;
double parabola(double x) {return x*x -2.0;}
double bisection(double f(double),double low, double high)
{
	double r;
	double mid = (low+high)/2.0;
	double image = f(mid);
	if(fabsl(image) < epsilon) return mid;
	else if( fabsl(high - low) < delta) return mid;
	else if (image < 0.0) r = bisection(f,mid,high);
	else r = bisection(f,low,mid);
	return r;
}
int main()
{
	printf("%f\n", bisection(parabola,-1.0,15.0));
}
