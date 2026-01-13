Jan 13 (Lec 3)

- Having output in programs, now means non-terminating programs can serve an effect 
- Non-terminating programs could print digits of $e, pi$ or web browsers, file exploerers -> all non-terminating 
- One more reason for needing output -> consider the environment the program runs in


\

== Execution cycles 
- Racket program provides you with a *REPL* (stands read, evaluate, print loop)
- Many programming languages do not use REPLs. 
  - instead they have a compile, link, execute cycle 
  - *Compile* -> program is translated by another program ("a compiler"), into machine instructions running directly onto your CPU. 
  - *Link* -> combines these machine instructions with other external packages to supply with other functionalities - print, etc 
  - *Execute* -> Run your program. 
- If you want printing, you have to explicitly ask for it. 

  E.g C with 

  ```c
  int main (void) {

    printf("Hello world \n");
    return 0;  //You must ask it explicitly to print 

  }
  ```

  Output can also help us trace our programs 

  ```rkt 

  (define (fact n)
    (printf "applied to arg ~a" n)
    (* n (fact (sub1 n)))
  )

  ```

== Modelling Input

- We can consider another sequence $iota$
- Sequence of characters consisting of what the user may press, reading characters would mean removing them from the sequence $iota$ (Model would be $(pi, delta, omega, iota)$)
  - This model where all of the user's input is fixed for the programming starts running is not really realitistic 
  - In real programs, input provided may change depending on what was outputted to the screen 
  - More realistic: Not all input if available from the start 

Alternatively, consider a translation of the program where requests for input, replaced with fns, where user characters are substituted.

(read-line) => $lambda$(line) line => user types "abc" => "abc"

- After translation, program is scattered with these input-recieving lambdas. Upon encountering one of these lambdas in reduction, substitution user-input. 
- Performing rest of computatoin yieldds a final result. (Essentialy we're not using the $iota$)
  - Essentially a read-line function that looks for the current user input and reads it and output it into a string. #emph(text(red)[
  Please look into this further
  ])


\
How to actually accept input in Racket  
- 3 ways we'll discuss 
  - (read-line) - accepts one line of user input, ending with a newline character .
  - returns a string consisting of the typed characters - does not include \#`\`newline

  ```rkt 

  (read-line) ;; Then types read my input 
  ;;"read my input"

  (string->list (read-line))
  ;; input abc 
  ;; (#\a #\b #\c)

  eof 
  ;;#<eof> End of file value 
  ```

  - We can also recieve a value eof from (read-line)
    - This states there is no more input to consume 

  Simple example: continue reading lines until reaching eof

  ```rkt 
  (define (read-lines)
    (define line (read-line))
    (cond [(eof-object? line) empty 
          [else (cons line (readlines))]
          )
    )
  )
  ```

  What if we want to work on a more primitive level? 

  - read-char: consumes a single characer from user input, and returns it 

  - peek-char: peeks at the next character in the user input sequence, returns it, but doesn't modify the sequence (How the hell does )


  ```rkt 
  (read-char)
  ;; input abcdef 
  ;; #\a_i
  (read-char)
  ;; #\c
  (peek-char)
  ;;#\d (but doesn't modify the sequence in any way)
  (read-char)
  ;;#\d 
  .
  .
  .
  ;; you can keep read charring until you finally finish the sequence where you will need to re-input another sequence if called 
  ```

#pagebreak()

  Example: Building read-line from read-char 
  ```rkt

  (define (my-real-line)
    (define (mrl-h acc)
      (define ch (read-char))
      (cond 
        [(or (eof-object? ch) (char=? ch #\newline))
          (reverse accum)
        ]
        [else 
          (mrl-h (cons ch acc))
        ]
      )
    )
    (list->string (mrl-h empty))
  )
  ```

  3rd input processing functions is (read)
  - (consumes an s-exp as input from the user - no matter how many lines it bridges over) (highest level of complexiy)

    *S-exp* -> Basic Racket Data - number, symbol, string, etc or list of s-exps 

    ```rkt
    (read)
    (a b c 1 2 3)
    `(a b c 1 2 3) ;; converts the appropriate shit to the racket data type to a list containg it 
    ```

  - Let's see now, given read, how we could implement Dr Racket REPL 
  
  ```rkt 
  (define (repl) ;; this in pseudo-code 
    (define exp (read))
    (cond [(eof-object? exp) (void)]
          [else (display (evaluate (parse exp)))
                (newline)
                (repl)
          ]
    
    )
  )

  ```

How to build (read) from (read-char) and (peek-char)
- occurs in 2 steps 
  1. tokenization: Take our input characters and process them into meaningful units - left-paren, right-paren, symbols, and numbers 
  2. parsing: ensure the list of tokens resembles a valid s-exp and return the corresponding data according to the characters for the user's input. 