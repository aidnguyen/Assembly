#include<stdio.h>
int euclid(int m, int n){
  if(n > 0) return euclid(n, m % n);
  else return m;
}
int euclidasm(int m, int n){
  int r;
  if (n>0)
    r = euclid(n,m %n);
  else 
    r = m;
  return r;
}
int main()
{
  printf("%d\n", euclid(14,12));
  printf("%d\n", euclid(14,11));
  printf("%d\n", euclid(558,198));
  printf("The euclid-asm version of the previous line: %d\n", euclidasm(558,198));
}
