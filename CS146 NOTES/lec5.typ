Jan 20 

= Lecture 5


\


*Recall: * 

Program 
- sequence of fn's 
- starting point: function main 

E.g. (Doesn't compile why?)

```c
int main(){
  f(4, 3)
  return 0; 
}

int f (int x, int y) {...}
```


Anyhow, this is because 

C requires declaration before use 
- can't use a fn / var / etc until you tell C about it 
- This is because the C-compiler only has one pass so this is the case. 

\

*Solution 1* Put f first 

```c

int f (int x, int y) {...}

int main(){
  f(4, 3)
  return 0; 
}

```

This was more than was necessary. 

```c
int f(int x, int y){
  ...
}
```

This is both declaration (tells C about the function) and definition (completely constructs the function)

C requires *declaration* before use. 

So you can write 

```c
int f(int x, int y); 
//function prototype or header - decl only (You can declare it as many time as you want)
int main(){
  f(4, 3)
  return 0;
}
//That ok as loong as we you know define it 
int f (int x, int y){
  printf("hello");
  return 0; 
}
```

- Still doesn't compile 
  - What is printf? 
    - no declaration to printf
  
  We need to add it 
  ```c
  int printf(-----);
  int f (int x, int y);

  int main (){
    ...
  }
  int f(int x, int y){  
    ...
  }
  ```



  Rather than declare every standard library fn header before you use it, C provides "header files",

  ```c
  #include <studio.h> 

  int f(int x, int y);
  int main(){
    ...
  }

  int f(int x, int y){
    ...
  }

  ```

  The include is not part of the C language but rather it is a direction to the C pre-processor (which runs before the compiler) like a macro expression in Racket. 

  ```c
  #include<file.h> -> "drop the contents of the file.h right here"
  ```

stdio.h 
- contains declarations for printf/other I/O functions. 
- located in a "standard place"
- e.g /usr/include directory 

Now the compiler is satisfied. That said, the program is still technically incomplete because where is the code that implements printf coming from? 

-> printf was written once, compiled once, and the binary was put in a standard place (the difference one from the header), e.g /usr/lib 

-> Code for printf must be combined with out code - linking
- a linker takes care of this 
- linker runs automatically - "knows" to link the code for printf
- If you write your own modules, have to tell the linker about them. 
  ```c
  int main(){ 
    return 0; //(it is to whom? (the OS) (echo $?)
  }
  ```
- Variables 
  ```c
  int f(int x, int y){
    int z = x + y; 
    int w =2; 

    return z/w; 
  }
  ```

  Input: 
  ```c
  #include <stdio.h> 

  int main(){
    char c = getchar(); 
    return c; 
  }
  ```

  - Read in a number 
  ```c
  #include<stdio.h> 

  int getIntHelper (int acc){
    char c = getchar(); 

    if (c >= '0' && c <= '9'){
      return getIntHelper(acc * 10 + c);
    } else {
      return acc; 
    }
  }
  ```

  - we note that: 

  ```c
  int getInt(){
    return getIntHelper(0); 
  }
  ```

  OR 

  ```c
  int getIntHelper(int acc){
    char c = getchar(); 
    return (c >= '0 && c <= '9') ? getIntHelper(acc * 10 + c) : acc; 
  }
  ```

  Notes: boolean conditions: 
  - && - "and"
  - || - "or"
  - ! - "not"

  if (test) stmt else stmt 

  Typically stmt will be a block


  Consider:

  ```c
  if (test_1){
    if (test_2){
      stmts_1
    }
  } else {
    stmt_2
  }

  ```

  - dangling else problem 
    - which if does the else actually go with since indentation doesn't mean anything in C
  - else goes with the nears unmatched if so its the test_2 one 

  Conditional Operator ?: (Also called the ternary operator)
  \ 
  - if else is a statement 
  - ?: creates an expression 
    a ? b : c has value b if a is true and has value c if a is true 

  Booleans - 0 means false (non-zero means the true (often 1))
  
  e.g. if (0) {...} - false condition 
  bool types, consant, true, false: std bool.h 

  Characters - restrictured form of integers. 

  int - varies, but typically a 32 bits number (~ 4 x 10^9) distinct values

  char - 8 bits exactly (256 distinct values)

  the character 0 is numerically 48 \
  the character 9 is numerically 57

  Everything in memory is numbers so each char must have a numeric code that represents it.
  - ASCII Code -

  

