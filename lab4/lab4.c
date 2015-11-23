#include <stdio.h>
#include <stdlib.h>
typedef struct list_struct
{
  int list_head;
  struct list_struct * list_tail;
} * int_list;

int_list cons(int, int_list);
int_list cons2(int, int_list);
void print_list(int_list);
int_list append(int_list, int_list);
int_list append2(int_list, int_list);
int_list dec_to_bin(int n);
int_list dec_to_bin2(int n);
int_list EAX;
int main()
{
 /*
  int_list intLst1 = cons(4,cons(3,cons(2,cons(1,NULL))));
  int_list intLst2 = cons(8,cons(6,cons(7,cons(5,NULL))));
  print_list(append(intLst1,intLst2)); 

  append2(intLst1, intLst2);
  print_list(EAX);
  print_list(dec_to_bin(95));
  */
  dec_to_bin2(95); //assumes EAX global variable has result
  print_list(EAX);

  dec_to_bin2(10); //assumes EAX global variable has result
  print_list(EAX);

  dec_to_bin2(4096); //assumes EAX global variable has result
  print_list(EAX);
}

int_list dec_to_bin(int n)
{
  if(n ==0) return NULL;//empty list
  else return append(dec_to_bin(n/2), cons(n%2,NULL));
}
int_list dec_to_bin2(int n){
  int_list EBX;
  int quotient, remainder;
  if(n ==0) EAX = NULL;//empty list
  else 
  { //quotient = n/2; //or shift right one bit
    quotient = n >> 1;
    dec_to_bin2(quotient);
    EBX = EAX;
    remainder = n%2; // or shift right and check carry flag
    cons2(remainder, NULL); //returns result in EAX
    append2(EBX, EAX);     //returns result in EAX
  }
}
int_list cons(int i, int_list p)
{
  int_list lst = malloc( sizeof(struct list_struct));
  lst->list_head = i;
  lst->list_tail = p;
  return lst;
}
int_list cons2(int i, int_list p)
{
  int_list lst = malloc (sizeof(struct list_struct));
  lst->list_head = i;
  lst->list_tail = p;
  EAX = lst;
}
void print_list(int_list lst)
{
  if(lst != NULL)
  {
    printf("%i",lst->list_head);
    print_list(lst->list_tail);
  }
  else
    printf("\n");
}
int_list append(int_list lst1, int_list lst2)
{
  if (lst1 != NULL) 
  {
     return cons(lst1->list_head,append(lst1->list_tail, lst2));
  }
  else
    return lst2;
}
int_list append2(int_list lst1, int_list lst2)
{
  if (lst1 != NULL)
  {
    append2(lst1->list_tail, lst2);
    EAX = cons(lst1->list_head,EAX);
  }
  else 
    EAX = lst2;
}
