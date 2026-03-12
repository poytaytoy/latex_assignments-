== 1.2 
- Generative, Structural, and Accunmalative Recursion 

== 1.3 
- Begin Function 

== 1.4 
- Tuple Model ($pi$ for program, $delta$ for definitions store, and $omega$ for output sequence)
- display, newline, printf ((printf "Hello ~a ~a" 1 2) outputs Hello 1 2)
- #<void> special useless value 
- for-each (map but outputs void so run for the sake of running) and unless (unless t f) -> if t false output f (f is assumed to be a begin expression)

== 1.5 


- $iota$, part of the thing and it indicates the input sequence 
- lost of referential transparency means that similar expressions may output different things due to the undeterminism of user inputs  


Task: May be useful to try implement these read functions in Racket to get familiar with the them p.s try building a parser + tokenizer 

== 1.6 

- static typing -> C cehcks for all the type of every expression before running 
- statement is when you include a ; and xpression evalautes to a value 
- {} is essentially a block in C programming 
- Declaration before use. You must tell the C compiler what to do before it you knows. 
- C has no booleans built in. 0 is false and everything else is true 
- Dangling else -> else will always evaluate to the nearest if 
- characters are numbers
- getchar() -> same as readchar in Racket 
- ungetc(c, stdin) -> puts the char c back in (preferably should only do it once)

== 1.7 
- set! 

```rkt 
(define x 3)
(set! x 4)
x
```
Task: Please work on understanding the Tuple Model 

== 1.8 

Essentially just boils down to this Racket code. Take note of the use of assoc -> memoization -> saving several results in a list of table 

```rkt 
#lang racket

(define fib-table empty)

(define (fib n)
  (define result (assoc n fib-table))
  (cond
    [result (second result)]
    [else (cond
            [(= n 0) 0]
            [(= n 1) 1]
            [else (+ (fib (- n 1)) (fib (- n 2)))]
            )
          ]
    )
)

(fib 10)
(fib 1) 
```

== 1.9 

- reading an uninitialized variable will simply read whatever was there before it. This is undefined behaviour 
- printf("%d\n%d\n%d\n", f(), f(), f()); does not guarantee the order of which will be executed for the f(). 
- static variables (please look into them but they're basically modifiable variable limited to the scope of the thingy )
- comma operator -> essentially a, b means evaluate a then evaluable b and the value of expression is b 
- By including assert.h, assert(("Argument cannot be negative", x >= 0));

== 1.10 
- boxes in Racket 
  - unbox to get the value of a box 
  - set-box! to a certain value and outputs null 

Task: Pls be familiar with how the pointer shit works for box and set box 

== 1.11

- Doing  &x to a variable creates a memory address 
- \*x dereferences the variabel and obtain the value from the memory location 
- Do not that \*x++ -> this increments the address location not add to the location  =
- Do not do \*p.x but rather cause its actually \*(p.x) instead do (\*p).x
- scanf 

Task: scanf practice pls pls 

== 1.2 

Tasks: God at this point it's some atrocious shit in making mutable structs in Racket Idk just focus on this on the exercising this part of stepping nayways 

== 1.3 
- Alias in C essentially just 

```c  
int main() {

  int x = 1;

  int *y = &x;

  int *z = y;

  *y = 2;

  *z = 3;

  printf("%d %d %d\n", x, *y, *z);
  //Will output all 3 
}
```

== 1.4 

- useless 


== 1.5 

- vectors in racket -> behaves like a mutable list 
  - vector-set!
  - make-vector
  - vector-ref 
  - build-vector 
- for loops 

== 1.6 

- 