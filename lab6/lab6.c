#include <stdio.h>
#include <math.h>
#define N 48 //Symbolic constant vs Creates memory location
char dataIn[] = "This is some test data for a RAID simulator";
char dataOut[N]; //Partial initialization of array
char disk1[N/3]; // expect to store "Tsso sdaoaA mar"
char disk2[N/3];
char disk3[N/3];
char disk4[N/3];
int main()
{
  printf("dataIn<%s>\n", dataIn);
  int i =0, j =0;
  for(i =0, j =0; i < N-2; i+=3, j++)
  {	disk1[j] = dataIn[i];
	disk2[j] = dataIn[i+1];
	disk3[j] = dataIn[i+2];
	disk4[j] = disk1[j] ^ disk2[j] ^ disk3[j];
  }
  printf("dataOut<%s>\n", dataOut);
  printf("disk1<%s>\n", disk1);
  printf("disk2<%s>\n", disk2);
  printf("disk3<%s>\n", disk3);
  printf("disk4<%s>\n", disk4);
for (i=0; i < N/3; i++)
{
  disk2[i] = '.';
}
for (i=0 , j =0; i < N - 2; i+=3, j++)
{
  dataOut[i] = disk1[j];
  dataOut[i+1] = disk2[j];
  dataOut[i+2] = disk3[j];
}
printf("dataOut<%s>\n", dataOut);
for (i =0; i < N/3; i++)
{
  disk2[i] = disk1[i] ^ disk3[i] ^ disk4[i];
}
for(i =0, j=0; j < N/3; i+=3, j++)
{
  dataOut[i] = disk1[j];
  dataOut[i+1] = disk2[j];
  dataOut[i+2] = disk3[j];
}
printf("dataOut<%s>\n",dataOut);
  return 0;
}
