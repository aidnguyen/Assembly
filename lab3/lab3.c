#include <stdio.h>
#include <stdbool.h>
float ST0;
int EAX;
float square(float x) {ST0 = x * x;}
int odd(int x) { EAX = x % 2;} 
// return value 0 or 1 in EAX
void power(float r, int p)
{
  if(p!=0) goto first_else;
  ST0 = 1.0;
  goto end_if;
first_else:
  odd(p);
  if(EAX != 1) goto second_else;
  int t = p-1;
  power(r,t);
  ST0 = r * ST0; // ST0 *=r
  goto end_if;
second_else:
  t = p/2;
  power(r,t);
  square(ST0);
end_if:
  return;
} //result ST0
int main()
{
  power(5.0,3);
  printf("%.2f\n", ST0);
  power(2.0,8);
  printf("%.2f\n", ST0);
}
