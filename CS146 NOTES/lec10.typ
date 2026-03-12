Can be subtle 

```c
void f(int *x, int *y){
  *y = *x + 1; 
  if (*y == *x){
    printf("How could this ever happen? \n");
  }
}

int main(){
  int z = 1; 
  f(&z, &z); 
}

//Makes program harder to understand 
```
== Memory 

Recall: Memory - set of numbered "slots"
Each box: 8 bits (one byte)
- usually treated in groups of 4-bytes words 

== Array 

Primitive date strucutre: the array 
- a "slice" of memory 
- a sequence of consequence memory locations 
- will discuss at length when we return to C 

Racket(Scheme): the *vector*
- used much llike a traditional array 
- unlke arrays can bold integers 

Vectors in Racket: 

```rkt 
(define x (vector 1blue #t "you"))
(define y (make-vector 10))
(define y (make-vector 10 5))
(define z (make-vector 10 sqr))
```

```rkt 
(define y (make-vector 10 5))
>>>(5 5 5 5 5 5 5 5 5 5 55 5)
(define z (build-vector 10 sqr))
>>>(0 1 4 9...)
(vector-set! z 7 50)
;;8th item replaced to 50 
```

```rkt 
(vector-ref y 7) => 49 
(vector-set! y 7 50)
(vector-ref y 7)
```
Main advantage of vectors over lists:
- vector-set! + vector-ref run in O(1) time 

Disadvantages: 
- size is fixed 
- difficult to add or rename elements 
- tends to force an imperative style

```rkt 
(define (my-build-vector n f)
  (define (res (make-vector n)))
  (define (mbv-h c)
    (cond [(= c n) res]
          [else (vector-set! res i (f i))
                (mbv-h (i c 1))
          ]
    )
    (mbv-h 0)
  )
)

;;No idea what this gpt if you reading this try make sense of this 
```

Vectors works well with imperative style algorithmsn for, for/vector in Racket help with this 

```rkt 
(define (my-build-vctor n f)
  (define res (make-vector n))
  (for [i n])
      (vector-set! res i (f i))
  res)
)


(define (my-build-vector n f)
  (for/vector ([i n]) (f i))
)
```

Eg - sum the elements in a vector 

```rkt 
(define (sum-vector vec) 
  (define (sum-vector vec)
    (define sv-h i acc)
    (cond [(= i (vector-length acc)) acc]
          [else (sv-h (+ i 1) (+ acc (vector-ref vec i)))]
    )

    (sv-h 0 0)
  )
)


(define (sum-vector vec)
  (define sum 0)
  (for ([i (vector-length vec)])
    (set! sum (+ sum (vector-ref vec i)))
  )
)

```

Not purely functional, but looks purely functional because it doesn't mutate anything outside of it 
- use of mutation confiend to the intervals of sum-vector 
- can't be detected outside the fn 
- so outsiders call consider if functional 

Provides a strategy for keeping problems with mutataion under control 
- hide it behind a pure functional interface 


```rkt 
(define (mutate-posn p)
  (set-posn0a! p (+ 1 (posn-x p)))
  (define p (posn 3 5))
  (mutate-posn p)
  (posn-x p) ;;4 
)
```

v.s. 

```c 
void mutate (struct posn p){
  p.x += 1; 
}

int main(){
  struct posn p = {3, 5}; 
  mutate(p); 
  printf("%d\n", p.x)
}

```

Racket structs aren't liek C structs, 
- the struct is copied in Racket, but changees to the fields still persist. 
- the felds of a structs are boxed - they're pointers 

Similarly, the items in a Racket vector are addresses that point to the actual contents (which can then be of any size)

```rkt 
(cons 1 (cons `blue (cons #t empty)))
```

Box + pointer diagram: 
 _ _      _ _      _ _
| | | -> | | | -> | |/|
 1        blue     true


Also, since Racket is dynamically typed, the values 1, 'blue, true must include type information more later. 

== *Vector* in C: Arrays 

array: sequence of consequtive memory locations 
e.g

```c 
int main(){
  int grades[10]; 
  for (int i = 0; i < 10; ++i){
    scanf("%d", &grade[i]);
  }

  int acc  = 0; 

  for (int i = 0; i < 10; ++i){
    acc += grade[i];
  }
  printf("%d\n", acc/10); 
}
```

a[i] - access the ith item of array a

What happens if you go out of bounds -> Undefined behaviour (like ex, you leave the 10th entry?)
Will it stop you? Nope 

It dpeends if the out of bounds accesses out of program memory then you get segmentation fault 
However, if the program is accessing memory simply used by another varibale, ggs - free ball 

That said, you can give the bound implicitly 

```c 
int main(){
  int grade[] = {0,0,0,0,0}
}

printf("%zd\n", sizeof(grades/sizeof(int)));

//20 bytes from size of grades 
//4 bytes from size of int 
```

