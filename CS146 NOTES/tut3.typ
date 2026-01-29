= CS146 Tutorial 4 
\
Code -> Program -> Macihne Code 

Code -> Parser -> AST -> Intermediate representation -> Machine Code   

Lexer 
- Creates a list of tokens 

\

```rkt 
(lambda (x) expr)
```
z
Essentially about ASTs. 

\ 

Faux Racket 
- Integers, addition, multiplication
- expr = int | op expr expr 
  1, (+ 1 2)
- 

```hs 
(Bin (Add (list 1) (Bin Mult (list 2) (list 3))))
```

With the AST we can, 
1. evaluate it to an integer result 
2. write a machine language program (write a machine language prorgam)

