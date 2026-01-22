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
  int c = getchar() 
}
```