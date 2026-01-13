Jan 8 \
Lecture 2 

= Modelling Side Effects, Ouputs 


== Impure Racket Stuff 

```rkt 
(begin exp1 ... expn)

```

- Evaluate exp1 ... expn in left-to-right order 
- Final result is expn evaluated
- In a pure functional context, begin is kind of useless, but it is useful for evaluating the side effects of exp1 ... $exp_(n-1)$ 
  - Implicit begin in lambdas for fns, lambdas, locals, and answers of cond/match 

```rkt
(define (f x)
  (begin ....... answer)
  )

```

is equivalent to 

```rkt 
(define (f x)
  ... answer
)
```

== Reasoning about side effects

- Adapt substitution model -> as the term goes on, it becomes more complex 
- Substitution model will now recieve as an input, and produce as an output - "state of the world"\


=== What will our world model be? 

- Simple model - list of definitions that may change 

*What our model is going to be*

- More complexly -> need a memory model (RAM
 or Random Access Machine)
- Memory is a sequence of boxes 
- The boxes in memory-indexed by natural numbers 
- Each boxed may be accessed in O(1) time, 
- Each box can store 32 bits (binary 0 or 1) - fixed width 

== Memory Address 
\

```
Addres      Contents 
4           011101 ....
8           011101 ....
12          011101 ....
.           .
.           .
.           .
256         .
260         .

```

- Gonna use this more in C (it increments by 4 cuz for some reason thts what the hardware does)

== Memory Output 
\

- Simplest side effect 
  - As we compute, we may print to the screen
- We will maintain, as the program runs, a list of all charactesr printed to the screen 


Substitution model, previousely $pi_0 -> pi_1 -> pi_n$ 
Each $pi_i$ is obtained from $pi_(i - 1)$, by applying one steepping rule reduction. (Can you ask for some clarification in what does the $pi$ means?) 

\

Now, also have the sequence: 

$omega_0 -> omega_1 -> ... -> omega_n $
- Each omega $omega_i$ represents the list of characters printed (it literally is not limited to one char and just means the sequence of things that are being printed)
- Each $omega_(i)$ is a prefix of $omega_(i + 1)$
\

Our model: 

$(pi_0, omega_0) -> (pi_1, omega_1) -> ... (pi_n, omega_n)$

We know, eventually, definitions may change. 

\

Sequence of definitions: 

$S_0 -> S_1 -> ... -> S_n$

For now, we'll just add definitions (won't change them), so for our model: 

$(pi_0, S_0, omega_0) -> (pi_1, S_1, omega_1) -> ... (pi_n, S_n, omega_n)$

\ 

How does this change stepping? 

$pi_i = "(define exp)"$
- Simplify expression to a value using the 1A rules. 
- Note that simplifying this expression into a val, may change $omega$ 
- Once simplified, remove $"(define id w )"$ and add this to $S$

\ 

If $pi_i = exp$
- Simplify expressions to a value using the 1A rules #text(fill: red)[(what is a 1A rule)]
- This may affect $omega$ if things are printed 
- Once simplified to a value , remove the value from $pi$ and add the characters representing the value to $omega$. 

#text(fill: red)[So essentially expression values are added to print?]

\

Once the $pi_i$ is emplty $->$ done
- $S, omega$ - called the state 
- $S, w$ are simply added to over time(for now), not too many complications for now 
- How to add to $omega$ in Racket? 

```rkt 
(display "hello")" ;;prints content to the screen, no line break  Note that this outputs Hello instead of "Hello" (useful for)
(newline) ;; makes a line break 
(printf "the value is ~a \n" 5) ;; Substitute 5 for ~a (Formaatted print) also \n is the newline character

```

In Racket, $"#/newline"$ is the Racket representation of the newline character


```rkt
(display "Hello")
;;Hello 
"Hello"
;;"Hello"
(define x (begin (display "Hello") 5))
;;Hello 
x
;;5 
(begin 6 7) ;;any expression in begin does not get printed unless it is final exp 
;;7 

(define z (display "Hello"))
;;Hello 
z
;; completely nothing -> Essentially display does not output anything

(list z)
;;`(#<void>) -> Is essentially a data type in Racket 
;; fun fact but void? exists! 

```
\

== Void Function

\

```rkt 
(display)
(newline)
(printf)

;; all of which returns #<void> 
```
- Indicates no return value from the fn 
- Also the return value of (void)
- Fns that return nothing - Statements/Commands 
  - Where imperative programming gets its name (things that output nothing but changes the state of the world, we evaluate it just for side effects)
\

Recall the map function 
- What if f inputted is just used for its side effects 
  - Then the result is just a list of voids over its content 
  - Kind of useless to store a list full of voids 

Instead, if f is a command, more idiomatically is to use 

```rkt
(for-each f (list l1 ln))
;; Evaluates (f l1) ... (f ln) and returns a singular void
```

== Simple example of for-each 

```rkt
(define (print-with-spaces lst)
  (for-each (lambda (x) (printf "~a ", x))) lst)
) ;; return value of this is only 1 void


;; How it would be defined 

(define (for-each f lst)
  (cond [(empty? lst) (void)]
        [else (f (first lst))
              (for-each f (rest lst)) ;; assume begin here is used
      ]
  )
)
```

- Returning (void) in a case is common enough that there are dedicated functions for it 

```rkt
(define (for-each f lst)
  (unless (empty? lst)
    (begin 
      (f (first lst))
      (for-each f (rest lst))
    )
  )
)

```
- Unless evaluates the condition 
  - If true, return void 
  - If false, evaluate the expressions in the body, return the last value
- When -> esseentially the opposite of unless. If false, we get void, and if true, we evaluate expressions in the body. 





