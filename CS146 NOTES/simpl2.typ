data stmt - ....
| IPrint Aexp | SPrint String

interp:: stmt -> state -> String -> (state, String)
interp Skip st om = (st, om)
interp (set x ae) om = ((M insert x \$!(aeval aest))st, om)
interp (Iif be tx Fs) st om = if (beval be st) then interp ts st om 
else interp fs st om
interp loope (While bt body) st om = 
    interp (Iif bt (seq body loop) skip) st om

Sequencing:
interp (Seq s2 s2) st om = 
    let (st', om') = interp s1 st om
    in intrep s2 st' om'

interp (IPrint ae) st om = (st om ++ show (aeval ae st))
interp (SPrint s) st om = (st, om++ s)


```hs
interp:: Stmt -> State -> String -> (State, String)

-- "Stirng transformer", Factor this out of the type 

type Mio a = String -> (a, Strng)
interp::: Stmt -> States -> Mio State 

-- Helper fucntions 

inject :: a -> Mio a
inject x = \om -> (x, om)
miprint :: String -> Mio ()
miprint s = \om -> (().omtts)

miprint::String -> Mio()
miprint s = \om -> ((), omtts)
```

Abstract the behaviour of seq 

```hs
interp (seq s1 s2) st om = 
  let (st', om') = interp s1 st om in interp s2 st' om'
  = (\t1 -> let (st', om') = t1 om in interp s2 st' om') (interp s1 st)
```

```hs 
- transformer dependent n the first transformer 
  "dependent string transformer"

  = (\t1 f -> loom -> let (st', om')) - t1 om in f st' om' (interp s1 st) (interp s2) om 

  -- New operator "bind"

  (>>> =) :: Mio a -> (a -> Mio b) -> Mio b 
  m >>>= f = lom -> let (x, om') = om in f x om' 

```


Takes a string transformer and a dependent string transformer combines them into one transformer that performs both transformations 

But what if we want to combine two independnt stirng transformers? 

Create another operator: 

```hs
(>>>) :: Mio a -> Mio b -> Mio b 
m1 >>> m2 = m1 >>>= (\_ -> m2 )
```

```hs 

interp :: Stmt -> State -> Mio State 
interp Skip St = inject st 
interp (Set x ae) st = injet((Minsert x $!(aeval ae st ) st))
interp (Iif bt ts fs ) st - if (beval be st) then interp ts st else itnerp fs st 
interp (seq s1 s2) st = interp s1 st >>>= intepr s2 
interp loop@(while bt body st) = interp (Iif bt (seq body loop) Skip) st 
interp (IPrint ae) st = miprint (show (aeval ae st))

```

Native Haskell approach: 

```hs 
Mio a -> Io a
miprint -> put Str 
>>>= -> >>= 
>>> -> >
```

Cleaner Haskell: "do" notation 

```hs 
e1 >> e2 -> do e1; e2 
e1 >>= p -> e2 -> do p <- e1; e2 

interp (seq s1 s2) st = do st' <= interp s1 s2; interp s2 st' 
interp (IPrint ae) st = do putstr(show  (aeval st)); return st; 
interp (SPrint s) st = do putStr s; return st 
```

IO - example of a monad 
  - any datatype with return, >>= operators 

== Proofs for Imperative Programs 

Recall: Fib \#'s : $F_0 = 0, F_1 = 1, F_n = F_n = F_(n-1) + F_(n-2) (n > 1)$

Racket: 

```rkt 

(define (fib n)
  (if (<= n 1 ) n 
    (+ (fib (- n 1)) (fib (- n 2)))
  )
)

```

Proving (fib n) = F_n - easy induction 

But fib is inefficinet 

Better: use 2 accumulators 

```rkt 
(define (fib-h n fn fnm1)
  (cond [(zero? n) fnm1]
        [(= n 1) fn]
        [else (fib-h (- n 1) (+ f_n f_nm))]
  )
)

(define (fib n) (fib-h n 1 0))
```

To prove (fib n) = F_n -> Prove (fib-h n 1 0)

But consdier the inductive step: (fib-h n 1 0)

Assuming (n > 1) -> (fib-h (- n 1) 1 1)

  - not the same as the inductive hypothesis 

Neet to state and prove a more general hypothesis 

```rkt 
(fib-h 5 1 0) => (fib-h 4 1 1) => (fib-h 3 2 1)
=> (fib-h 2 3 2) => (fib-h 1 5 3) => 5

```

So prove: $forall k, forall i > I "if" "fjp1 is"  F_(j+1 ) "and" f_j "is" F$
then (fib-h i "fjp1" f_j) == F_(i+j)

- straightforward induction 



