
== Application: Memoization
Caching - Saving the result of a computation to avoid repeating it
Memoization - Maintaining a list or table of cached values

Consider: 
```rkt
(define (fib n)
  (cond
    [(<= n 1) 1]
    [else (+ (fib (- n 1) (fib - n 2)))]
    
  ))
```

inefficeint because the recursive calls are repeated.\

tree:\
(fib 100)\
(fib 99) (fib 98)\
(fib 98) (fib 97) (fib 97) (fib 98)

(fib 100) called 1x
(fib 99) called 1x
(fib 98) called 2x
(fib 97 called 3x)
(fib 96 called 5x)
(fib n) is propertion to (Fn) = (phi)^n (golden ratio)\


Avoid repetition 
- keep an asscociation list of pairs (n Fn)
```
(define fib-table empty)
(define (memo-fib n) 
(define result (assoc n fib-table))
(cond [result => second]
  [else (define (fib-n 
  (cond [(<= n 1) n]
        [else (+(memo-fib (- n 1)) (memo-fib (- n 2)))]))
  set! fib-table (cons (list n fib-n) fib-table))
  fib-n]))

```
Notes- assoc  - build-in function for asscociation list look up
              - (assoc x lst) returns the pair (x y ) from the list or false
              - any value can be used as. a test - false is false
                                                - anything else is true


```
- cond [x=> f] - if x is not false, produce (f x)

```



calls to (fib n ) now happen only once

fib-table-a global var. Can we hide it?



```
(define mem-fib
(local [(define (fible empty)
(define (memo-fib-aux n)...)...)]
)
memo-fib-aux
])

Note that the look up of the set is constant in this example because the last and second last fib numbers will be at the start of the set
```
Doesnt quite work for the adress book - two functions need access to the global var



```C
int main(){
  int x = 0;
  printf("%d\n", x);
  x= 4, prinf(%d \n". x)
}

```

Note:  = is an operator 

x = y is an expression : it ha a value as well as an effet
  - its value is the value assigned

x = 4 - sets x to 4 and has value 4



```
int x = 3;
prinf ("%d \n", x);
printf("%d\n", x=4);
}
```

Adcantages - almost donew
Disadvantages = many

eg. x = y= z = 7
value is 7
sets all of x, y, a to 7


```C
int main(){
    int x = 5;
    if (x=4){
        printf("x is 4\n");

    }
    x = 0;
    if (x=0){
        printf("x is 0\n");

    }
}
```
mistake: assings x to 4 instead of using == to check
x=4 evaluates to true because its non zero so regarless of the original value of 
x, it will alwasy print x is 4

same when you write (x=0)


actual code

```
int main(){
    int x = 5;
    if (x==4){
        printf("x is 4\n");

    }
    x = 0;
    if (x==0){
        printf("x is 0\n");

    }
}
```

Usually best to use assignment only as a statement. 
Can leave variables uninitialzed and assign them later

```C
int main(){
    int x; //x is unitiazed. this is also undefiend behavior
    //not a good ide - do so wiht a good reason only
    
    x = 4; 
    
    


}
```



```C
int main(){
    int x; //x is unitiazed. this is also undefiend behavior
    //not a good ide - do so wiht a good reason only
    
    if (x==0){
        ...
    }
    
}
}
```

will this run of not? 
Don't know - x's value is not known!
The value of an uninitialized variable is undefined
Typically,  it's whatever value was in the memory from before

== Global variables


```C
int c = 0; //Global varible
int f(){
    
    
    
    int d = c;
    c = c+1;
    return d;

    
}
//returns 0, then 1, then 2...
int main(){
    printf("%d\n", f());
    printf("%d\n", f());
    printf("%d\n", f());
    
}
//output
0
1
2
```

Careful:

```C
printf("%d\n%d\nd\n", f(), f(), f());
// Could produce 
// 0
// 1
// 2
// or 
// 2
// 1
// 0
// or other permutations of f() calls
  
```
In this expression the order of argument evaluation is *unspecified* - Don't do that
- avoid using expressions with side effects as function arguments specifically because you dont know the order of which the function are evaluated

As with Racket vars, can interfere with f by mutating C


Can we protect c from access by functions other than f?





```C

int f(){
    static int c = 0;
    int d = c;
    c = c+1;
    return d;
}
```
Scope is the part of the program where the variable is visible
extent/lifetime - how long does the variable exist

scope of d is this function and the lifetime of d ends when f is over

c's scope and lifetime is different
c is scoped within f so its viisble within f
but its lifetime is the entire program
a static variable is a global variable that only f can see




Repetition:
```C
void sayThisNTimes(int n){
    if (n>0){
        printf("Hi\n");
        sayThisNTimes(n-1);
    }    
}
```

- expressed more idiomatically as:

  
```C
void sayThisNTimes(int n){
    while (n>0){
        printf("Hi\n");
        n = n-1;
    }    
} 
```

- a loop - the body of the loop is executed repeatedly as long as the condition remains true


In general
```C
void f(int n){
    if (cont c()){ //continution condition
        body(c);
        f(update(c));
    }
}
```

becomes 
```C
void f (int c){
    while (cont(c)){
        body(c);
        c = update(c);
    }
}
```
- may not need to be in its own function anymore if used only once 