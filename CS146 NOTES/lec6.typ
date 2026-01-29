*Jan 22* 

#underline[Recall] characters - each characters needs a numeric code that represents it 

ASCII Code: 


$
  "\\n " &= 10 \
  "_" &= 32 \
  "0-9" &= "48-57" \ 
  "A - Z" &= "65-90" \ 
  "a - z" &= "97-122"
$

$65 = 0100001 - 0110 0101$

Convert a char 6 to its numeric value: c - '0' (c-48) \
Convert a number (0 - 9) to ASCII: n + '0'

\

A second look at getchar: 

```c
char c = getchar(); 
```

The header for getchar is actually an int -> why int if it produces a char? What if there are no chars? 

What if there are no chars? Ex, (EOF)

If there are no chars (EOF), getchar produces an int that can't possibily be a char (not in the range of 0..255) \ 

The constant EOF denotes the value getchar produces on EOF (often EOF = -1) \ 

#underline[Next Question]: getInt burns a character after reading an int - does C have a fn like Racket's peekchar? 

No, but it has a ungetc - stuffs a character back into the input section. 

```c
int peekchar() {
  int c = getchar(); 
  return c == EOF? EOF : ungetc(c, stdin); //return the char that was stuffed 
}
```

Improved getInt - doesn't burn a char 

```c
#include <stdio.h> 
#include <ctype.h> 

int getIntHelper(int acc){
  int c = peekchar(); 
  return isdigit(c) ? getIntHelper(10 * acc + getchar() - '0'.) : acc; 
}
```
Second version: 

```c
int getIntHelper(int acc){
  int c = getchar(); 
  return isdigit(c) ? getIntHelper(10 * acc + c - '0') : (ungetc(c, stdin), acc);
}

//new operator in c 

//a, b -> evaluate a, then evaluate b, and return the value of b
//essentially like (begin a b)
```
What if there is whitespace before we reach the int? 

```c
void skipws(){
  int c = getchar(); 
  if (isspace(c)){
    skipws();
  }
  else ungetc(c, stdin); 
} //a void function  -> a function that returns nothing -> therefor cannot be used in an expression (like there literally is no value) 
```

There are no void variables, so they are only useful for their side effects. 

- returning from void fns -> either: \
    -  reach the end 
    - or - return; (no expr)


```c
int getInt(){
  skipws(); 
  return getIntHelper(0); 
}
```
\

== Mutation

*Basic mutation* -> set! 

```rkt 
(define x 3)
(set! x 4) - produces (void) - changes 
x -> 4 -> Note: x must have been previously defined 
```

Example: 

```rkt 
(lookup `Brad)
;;false 
(add `Brad 36484)
(lookup `Brad)

>> 36484 
```

This is not possible in pure Racket 
    - same expression cannot produce the same result 

Implement in impure Racket 

```rkt
(define address-book empty)
(define (add name number)
  (set! address-book (cons (list name number)))
)
```

Global Data - good for defining constants to be used repeatedly 
    - But not good with mutation 
      - any part of the program could change a global var 
      - affects the entire program 
      - hidden dependencies between different parts of the program 
      - hard to reason about the program 

#underline[Application: Memoization]

#underline[Caching] - Savign the result of a computation to avoid repeating it \

#underline[Memoization] - maintaining a list of table of cached values 

Consider: 

```rkt 
(define (fib n)
  (cond [(<= n 1) 1]
        [eles (+ (fib (- n 1)) (fib (- n 2 )))]
  )
)
```

Really inefficient because they keep getting computed over and over again 

