Recall 

```c 
void inc(int* x){
  *x++; //wrong 
}
```

\*x++ - which happens first - \* or ++. In C, postfix, precedence over prefix, so \x++ means \*(x++)

Address is incremented, a value is fetched from the unincremented adddr and thrown away. No change to the original var. 

Correct: 

```c
int inc (int x){
  (* x)++; //correct
}
```
\
Now consider: 

```c
void swap(struct posn *p){
  int temp = *p.x; 
  *p.x = *p.y; //wrong - postfix before prefix 
  *p.y = temp;
} //Still wrong 
```

Need parens : 

```c 
void swap (struct posn *p ){
  int temp = (*p).x; 
  (*p).x = (*p).y; 
  (*p).y = temp; 
}
```

\ 

It turns out that field ac cess through ptr happens a lot. There exists a shortcut. We can write instead p -> x (it means (\*p).x)
\
\
More sophisticated user input: scanf 
```c
scanf("%d", x); // read x as a decimal integer - skips leading white spaces
```
- scanf is a function (can't modify x)
- instead:: scanf ("%d %d", &x, &y); By the way this skips any indefinite amount of white space between possible x and y. 
- scanf returns the number of args actuall read. 
\


== Advanced Mutation 

- Mutating structures and lists. 
- In scheme, you can mutate parts of a cons with set-car! and set-cdr! (essentially the first and rest respectively of scheme) 
- In racket, cons fields are immutable - cannot be changed 

For multiple pairs, Rackets provides mcons (mutable cons)
  - mutating fields - mset-car! and mset-cdr! 
\
For structs: provide the option \#immutable

```rkt 
#lang racket 
(struct Posn (x y) #:mutable)
(set-Posn-x! 5)
(set-Posn-y! 6)

;;Bruh just figure this shit up 
```

*Semantics*:

1A - (posn v1 v2) is a value 
Now - (posn v1 v2) cannot be a simple value if it is mutable
- has to behave like a box 

\ 
How? -- is a struct automatically boxed? or is the struct a box 
Essentially they are not boxes when they are subbed in. That said, the field they are in are boxes. 
\

A struct is not automatically boxed, but it does box its contents 

so we can rewrite (posn v1 v2) as: 

```rkt 
(define _val1 v1)
(define _val2 v2)
(posn _val1 _val2)
```

(posn-x p) where p is (posn \_val1 \_val2) 
- find the definition for \_val1, fetch the value p 

(set-posn-x! p v) where p is (posn \_val1 \_val1) 
- find (define \_val1)

Replace with (define \_val1 v)

```rkt 
(define p1 (posn 3 4))
(set-posn-x! p1 5)

;;=>
(define _v1 3)
(define _v2 4)
(define p1 (posn _v1 _v2))
(set-posn-x! p1 5)

;;=> 
(define _v1 3)
(deifne _v2 4)
(define p1 (posn _v1 _v2))
(set-posn-x! (posn _v1 _v2))


;;=> 
(define _v1 5)
(define _v2 4)
(define p1 (posn _v1 _v2))
(void)

;;=> 
(define _v1 5)
(define _v2 4)
(define p1 (posn _v1 _v2))
(void)
```

- generalize to any mutable struct including mcons. 


Consider: 

```rkt 
(define lst1 (cons (box 1) empty))
(define lst2 (cons 2 lst1))
(define lst3 (cons 3 lst2))
(set-box! (first (rest lst2)) 4)
(unbox (first (rest (lst3))))
```

without \_ vars, this produces 1. But in fact the answer is 4

```
lst2 = (cons 2 (cons (box 1) empty))
lst3 = (cons 3 (cons (box 1) empty))
;;Due to direct substitution 
```

The two (box 1)'s are the same box can't observe this without \_vars. 
- Under our new rules

```rkt 
(define _val 1)
;;it now 

lst2 = (cons 2 (cons _val1 empty))
lst3 = (cons 3 (cons _val1 empty))
;;The shared item is now reflected 
```

But it's not just the box that is shared. Note that: 

```rkt 
(define lst2 (cons 2 lst1))
(define lst3 (cons 3 lst1))
;; the entire tail of lst1 is shared. 
```
- Both occurences of lst1 refer to the same lst1, so we need to rethink define 

```rkt 
(define x 3)
(set! x 7) 
x 

;;=> 

(define x 7)
(void)
x 

;;=> 
7
```

So x is not just a value. It is something that we can mutate and an entity we can access 

x must denote a location and the location contains the value.

So we don't have just one lookups: 
- var -> locatoin 
- location -> value 

set! changes the location -> value map, but not the var->location map (nothing changes that)

(define ...) creates a location, fills it with a value 

In C: Consider 

```c
int main(){
  int x = 1; 
  int *y = &x;
  int *z = y; 
  *y = z; 
  *z = 3; 
  printf("%d %d %d \n", x, *y, *z); 
}

//Output: 3 3 3 
```

Why?: y initialized to x's address 
- y points to the location where x resides 
- z initialized equal to y 
- z also equal to x's address 
- z stores z at x's location x == \* y === \* z == z 
- z = 3 stores 3 at x's location x == \* y == \* z == 3


y -> x(3) \<- z
Hence, x, \*y, \*z - three different names for the same data 
- called aliasing - accessing the same data by different names 

To make variables both pointers:

```c 
//that said 
int *z; 
//and 
int* z; 
//mean the same thing 
int *x, *y; 
```