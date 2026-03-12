*Recall*
```c
for (struct Node *cur=lst; cur; cur=cur->next){
    free(curr);

}
cur = cur-?next happens after free(cur)
- cur is dangling
```

```c

struct Node *temp = cur;
for (struct Node *cur=lst; cur;){
    cur = curr->next;
    free(tmp);
}

or 

void freeList(struct Node *lst){
    if (lst){
        freeList(lst->next);
        free(lst);
    }
}




```

Practice problems:
You have a list, say 1 2 4
how would you change that to the list 1 4 or the list 1 2 3 4



== ADTs in C
C doesn't have modules - C has files

Implement ADT sequence in C
Operations:  
- empty sequence
- insert (s, i , e) - insert integer e at index i in S. \ *Pre*: 0<=i<=size(s)
- size(s) - \# elements in s
- remove (s, i) remove item from index i in s
Pre: 0<=i<=size (s)- 1

-index (s, i) returns the ith element of s
            \ Pre: 0<=i<=size(s) - 1

Want: no limits on size - sequence can grow as needed

*Implementation options*
\
*linked lists* - easy to grow and easy to shrink
- slow to index 

*Array*
- fast indexing
- but hard to grow

*Approach*
Partially filled heap array (making a large array more than i need)

```C
struct Sequence {
    int *theArray;
    int size;
    int cap;
};

How to structure this:
make the file sequence.h
struct Sequence {
    int *theArray;
    int size;
    int cap;
};

struct Sequence emptySeq();
int seqSize(struct Sequence s);
void insert(struct Sequence *s, int i, int e);
void remove(struct Sequence *s, int i);

int index(struct Sequence s, int i);
void freeSeq(struct Sequence *s);


Sequence.C

#include "sequence.h"

struct Sequence emptySeq(){
    struct Sequence res;
    res.size = 0;
    res.theArray = malloc(10*sizeof(int));
    res.cap = 10;
    return res;
}


int seqSize(struct Sequence s){
    return s.size;
}

void insert(struct Sequence *s, int i, int e){
    
    for (int n = s->size; n>i; --n){
        s->theArray[n] = s->theArray[n-1];


    }
    ++s->size;
    s->theArray[i] = e;

}

remove //excercise

index //excercise
free sequence //excercise



//main file
include "sequence.h"
int main(){
    struct Sequence s = emptySeq();
    insert(&s, 0, 4);
    insert(&s, 1, 7);
}
```

What happens when the array is full

```C
void insert(struct Sequence *s, int i, int e){
    if (s->size == size->cap){
        //make the array bigger
        int *newArray = realloc(s->theArray, sizeof(int));
        //so realloc makes a new array with the new size then copies over the contents of the old array and frees the old array and returns a pointer to the new array
        
        //this is in case realloc cannot allocate any more memory on the heap and just returns null
        if (newArray) s->theArray = newArray;
        ++s->cap;
    }
    else{
        //do what we had before
    }


}
```

*realloc *
- increases block of memory to a new size
  - if necessary, allocates a new, larger block and frees the old block (data copies over)

*How big should we make the new array?*
- one larger? - Must assume each call to realloc causes a copy and therefore is O(N)
- if we have a sequence of inserts (at the end), no shuffling costs
\# of steps is n+ n + 1 + n+2 ... 
this is roughly O(N^2) cost, O(N) per add 

What if we double the size?
- insert still takes O(N) worst case


But ...
Amortized analysis
This places a bound on a sequence of operations, even if an *individual* operation is expensive

If an array has a cap of *K* and is empty..
- K inserts cost 1 each (k steps) 
- Now we have to expand the array
- 1 insert costs k+1 operations due to realloc - cap now 2 k (k+1 steps taken)
- k-1 inserts cost 1 each (k-1 steps) 
- next insert costs 2k+1 - cap now 4k (2k+1 steps)
- 2k - 1 inserts 
- 1 insert costs 4k + 1 operations due to realloc - cap now 8k (4k+1 steps)
- 4k-1 inserts 

\
\
- $2^(j-1) k-1$ inserts cost 1 each ($2^(j-1) k-1$)
 steps
- 1 insert costs $2^(j) k+1$ - cap now $2^(j+1)k$ ($2^(j) k+1$ steps)

Total number of steps taken
#underline[K + k+1 + k-1] + #underline[2k +1 + 2k - 1] + .... 2^(j-1)k - 1 + 2^jk+1
pairs up nicely



\= 
k+ 2k + 4k + 8k + 2^j*k + 2^j*k + 1 
\= k(1 + 2 + 4 + 8 + ... 2^j) + 2^j*k + 1
\= k(2^j+1 - 1) + 2^j*k + 1 
\= 2^(j+1)\*k - k + 2^j*k
\= 2*2^j \* k - k + 2^j\*k + 1 



Total number of insertions. = \# of items currentsly in the sequence = 2^k\*k + 1
S0 \#of steps per insertion. = (2*2^j*k - k + 1)/(2^j*k + 1) the lim of this is 3


This is not constant time but constatn amortized time



New insert

```c


void increaseCap(struct Sequence *s){
    if (s->size == s->cap){
        s->theArray = realloc(s->theArray, 2*s->cap*sizeof(int));
        s->cap *= 2;
    }
}


void insert(struct Sequence *s){
    increaseCap(s);
    //same as before
}


main.c file

int main(){
    struct Sequence  = emptySeq();
    insert(&s, 0, 4);
    insert(&s, 1, 7);
    ...
    s.size() = 8; //tampering this is forgery and we want to avoid it

}
```

Can we prevent this?
- keep the details of struct Sequence hidden
- declare, but not define, the struct?

```c


Sequence.h file:

struct Sequence;
struct Sequence emptySeq();



Sequence.C file

#include "sequence.h"
struct Sequence{
    int *theArray, size, cap;

};
struct Sequence emptySeq(){
    blah lah
}
// imagine all other functions are implemented


main.C file
#include "sequence.h"
int main(){
    struct Sequence s;
    this doesnt work
    the compiler needs to know how big the sequence structure is to allocate 
    adequate space on the stack
    ...

}
```

== The fix
```c

Sequence.C file

#include "sequence.h"
struct Sequence{
    int *theArray, size, cap;

};
struct Sequence emptySeq(){
    blah lah
}
// imagine all other functions are implemented


main.C file
#include "sequence.h"
int main(){
    struct Sequence s;
    this doesnt work
    the compiler needs to know how big the sequence structure is to allocate 
    adequate space on the stack
    ...

}



seqeunce.h

struct SeqImpl;
typedef SeqImpl *Sequence;
//Sequence is a pointer to SeqImpl
//In other words Sequeuence is now an alias to mean the type which is a pointer to a SeqImpl
Sequence emptySeq(); //impl: seqImpl structure will need to be heap alloated (excercise) 
void insert(Seqeunce s, int i, int e);




main:

#include "sequence.h"
int main(){
    Sequence s; //ptr so ok

}


sequence.C
...
...
void increaseCap(Sequence s){
    ...
}

- increase cap is a Helper functions - main should not be calling it
- How do we prevent this?
Just leave the functiond declaration outside of the header file

But main.c
#include "sequence.h"
//technically I could add the functiond definition here
void increaseCap(Sequence s);// What if main declared its own header?


Sequence.c
static void increaseCap(Sequene S) {
    ...
    this function is only accessible in this file

}

prevents other files from having access - even if they write their own header

```


== Application of Vectors
ADT Map/Dictionary

- make-map: Precondition: true - produces an empty map
- add: map M, key K, value v. Precondition: true
  - Post: if there exists v such that (k v') belongs to M, then remove the old value and insert the new value
remove: map M, key K Pre: true 
  Post: if there exists a v such that (k, v) belongs to M, then remove (k, v) from M

search: map M, key K Pre: true
produces v such that (k, v) belong sto M, otherwise something outside the value of domain
  
*Implementation *
Assume the keys are integers (for simplicity - omit values)
If we use an association list - accessing an item takes O(N) time

If we use a BSt - same worst -case runnign time because of you could have a long tree. This happens when you insert items in a sorted order
If we use a abalnced BST (eg AVL tree) - worse case O(log N), difficult implementation

If we use vectors instead - O(1) access to items, but fixed size; ie how big should hte vector be?
  - Size of vector = max key? but this will waste space


Combine the two - vector of association lists - called a hash table

```

#lang racket
(define (create-hashtable size) (make-vector size empty))

To which assoc. lists should we add (k, v)?
- mapping called a hash function
- for simplicity, use the remainder of by the length of the vector
- for this idea to work well, the hash function must distribute keys evenly over the indeces

```
