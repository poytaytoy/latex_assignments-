*Recall*
```C
int *p = malloc()
...
...
free (p)

failing to free all allocated memory - called a memory leak
```


```c
int *p = malloc(___)
free(p);

*p = 7; //will this crash?
- probably not crash - free(p) does not change p
 - p sitll points to that memory, so storing there unlikely to crash
 - but the location can be given out to another malloc call ... data crruption
 - called a dangling pointer. This is bad

 Better: after free(p), assign p to a guranteed-invalid location

 int *p = malloc(____)

 free(p);
 p = NULL; //null ptr - points to nothing
 

 NULL - not really part of the C language
      - defined as a constant equal to 0
      - could equally well say p = 0;


note: NULL is imported from stdlib or stdin not part of standard C


```
Deferencing NULL - undefined behavior
                 - *program may crash*

                 


ex:
```C
#include <stdlib.h>

int main(){
    *NULL
}

```
this doesn't crash


if malloc fails to allocate memory - it returns null

Consider again: 
```
int* f(){
    int x = 4;
    return &x;

}

int g(){
    int y = 5;
    return y;

}


int main(){
    int *p = f();
    g();
    printf("%d\n", *p);

}

check diagram on one note about the stack diagram
basically after x's memory is freed, the same memory is allocated to y because f's stack is reused by g
according to this we should print 5

this gives a seg fault in gcc
but this prints 5 using clang
```


Never return a ptr to a local variable

If you want to return a pointer, it should point to static, heap, non local stack data. 

valid ways to return pointers:
```C

int *pickOne(int *x , int *y){
    return ( ...) ? x:y;

}

struct Posn *getMeAPtr(){
    struct Posn *p = malloc(sizeof(struct Posn));
    return p;
}

int z = 5;
int *f(){
    return &z;
}
```
When should we use the heap? \
1) for data that should outlive the function that creates it\
2) For data where size is not known at compile time\

3) for large local arrays

1) As above

2) int \*p = malloc(sizeof(int)) 
- Not that useful
- Why not just int n?

What if we ask for more memory?
```C
int numSlotsNeeded;
scanf("%d", &numSlotsNedded),
int *p = malloc(numSlotsNeeded*sizeof(int))
- We can access p[0], ...., p[numSlotsNeeded -1]
- called a dynamic array (heap-allocated)

... free(p);
```

Alternatively, 
```C
int a[numSlotsneeded];
size of the array needs to be compile time value not a variable dependant on input
usually the compiler will determine the stack size during compilation not during runtime


```


3) programs typically have more heap memory available than stack memory
```c
int recursiveFn(int n){
    int tempArray[1000];//this eats up stack space for each recurisve call
    ....
    recursiveFn(n-1)    

    
}


```
So in this case use a heap


Can we get behavior of a Racket list in C?
(cons x y) produces a pair 
(ONE NOTE)

RECALL: Racket in dynamically tuped - list items can have different types

C is statically typed -> list items would need to have the same type (if not - headaches)


We needed cons to have pointers to have any type in racket


- so there is no real needs for ptrs to data fields. 


```C

struct Node{
    int data;
    struct Node *next;
}

struct Node *cons(int data, struct Node *next){
    struct Node *result = malloc(sizeof(struct Node));
    result->data = data;
    result->next = next;
    return result;  
}



int main(){
    struct Node *lst = cons(1, (cons(2, cons(3, NULL))));
}
```
this is a linked list



*Processing a linked list*\
```c
int length(struct Node *lst){
    if (!lst) return 0;
    return 1 + length(lst->next);
}


int length(struct Node *lst){
    int res = 0;
    for(struct Node* curr = lst; curr; curr=curr->next){
        ++res;
    }
    return res;
}




```


*Passing functions as pointers into other funcitons*
```c
struct Node *map(int *f(int), struct Node *lst);
//this is wrong becausof postfix before prefix, basically sayin the functionr returns a  pointer to an int
// this doest imply were taking in a ptr to a function

struct Node *map(int (*f)(int), struct Node *lst){
    if (!lst) return 0;
    return cons(f(lst->data), map(f, lst->next));
}
```


*freeing lists*
