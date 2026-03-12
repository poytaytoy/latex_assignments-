== Recall 


```rkt 
(define (fib-h n fn fnm1)
  (cond [(= n 0 ) fnm1]
        [(= n 1) fn]
        [else (fib-h (- n 1) (+ fn fnm1) fn)]
  )
)

(define (fib n) (fib-h n 1 0))
```

Translating to SIMPL - set n initially (n fns)

```
(vars [(n 10 ) (fi 1) (fjm1 0) (ans 0)]
  (if (= n 0)
    (set ans fjm1)
    (seq (whie (> n 1)
      (set fjm1 fj)
      (set fj (+ fj fjm1))
      (set n (- n 1))
      (set ans fi)    
    )
    )
  )
)

```

- wrong -fjm1 updated prematurely 

- swap (set fj (+ fj fjm1)) - still wrong 
- fj updated prematurely 


```
(vars [(n 10) (fj 1) (fjm1 0) (t 0 ) (ans 0)]
  (iif (= n 0)
    (set ans fjm1)
    (seq (while (> n 1)
      (set t fj)
      (set fj (+ fj fjm1))
      (set fjm1 t)
      (set n (- n 1))
    ))
    (set ans fj)
  )
  (print ans)
)

```

Can we prove that given n this program prints F_n. Equivalent -> prove that the feel value of ans is F_n. 

The stmt ans - F_n? ? true or false 
- depends on the state of the time 

The stmt is evaluated 

\

== Hoare Logic 

Prove triples of the form ${P}$ statement {Q} - "Hoare triples"

P - precondition - logical stmt about the state before statement runs \
Q - postcondition - the impact of the pre condition after the stmt 
\

=== Examples 

To conclude ${P}$  (vars [(x1 v1) ... (x_n v_n)] stmt){Q}. It suffices to show {P and x1 = v1 and ... and .. x_n = v_n} (seq stmt) {Q}

To conclude {P}(seq stmt1 stmt2){Q}, it suffices to find a statement R such that {P} stmt1 {R} and {R} stmt2 {Q}

Finding R can be tricky - may need to adjust P and Q to get an R that works. 

So to concllude {P} stmt {Q}. We can prove {p'}stmt{q'} where P => P', Q' => Q, then P => P' stmt Q' => Q


To conclude {P}(sex x exp ) {Q} \
- P + Q should be almost the same - only the value of x has changed 

Q can say nothing baout the old value of x. Whatever Q says about x must be true about exp before the statements. 

So {Q[exp/x]} (set x exp) {Q}
Q[exp/x] mean Q, with exp substituted for x \

To conclude {P} (iif B stmt1 stmt2){Q}
  suffices to show: \
  if true -> {P and B} stmt1 {Q} \ 
  if false -> {P and not B} stmt2 {Q}

```
(while B stmt) - trickiest 
```

The loop might not run.  {P} (while B stmt....) {P}
- But at the end of the loop, B must be false. 
- {P} (while B stmt ...) {P and not B}

If the loop body runs, it may repeat - whatever was true at the end istrue at the beginning and B is true. \ 

{P and B} (seq s1 ... sn) {P}

P - preservd by the body of the loop - called a *loop invariant* 
 - finding the right loop invariant can be tricky 
\
\

== Proof that the fib program (simplified) works 

Now - prove that the Fib program (simplified version)

```
(vars [(n 10) (fj 1) (fjm1 0) (1 0)]
  (while (not (= n 1))
    (set t fj)
    (set fj ( + fj fjm1))
    (set fjm1 t)
    (set n (- n 1))
  )
)

;fj = F(10) - goal

(vars [(n 10) (fj 1) (fjm1 0) (t 0)]
  ;n = 10, fj - 1, fjm = 0, t = 0
  (while (not (+ n 1))
    (set + fj)
    (set fj (+ fj fjm1))
    (set fj1m1 t)
    (set n (-n 1))
  )
)

;fj = F(10)
```

What is the right invariant 

fj = F(11 -n), fjm1 = F(10 - n)

