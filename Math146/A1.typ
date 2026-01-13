+ Let $V$ be a vector space over a field $FF$. Let $b, c in V$ and $a$ be their additive inverse. Clearly, \ $a + b = 0$ and $a + c = 0$, so inversely, $b, c$ are the additive inverses of $a$. With $1 in FF$, we note that $(1 + (-1))a = a + (-1 dot a) = 0$. We now consider $a + b  + (-1 dot a) = (-1 dot a)$ and \ $a + c + (-1 dot a) = (-1 dot a)$. By the communative property of vector space, we get \ $a + (-1 dot a) + b = b = (-1 dot a)$ and $a + (-1 dot a) + c = c = (-1 dot a)$. Thus, we get that \ $b = (-1 dot a) = c$, so $b = c$. Hence, additive inverses are unique.  

#pagebreak()
#set enum(start: 2)
+  We first prove that ${w_1, w_2, ..., w_n}$ provides a scalar representation of any $b in V$ over $FF$. By the definition of basis, there exists scalars $b_1, ... , b_n$ where: 

  $ sum^(n)_(i = 1) b_i v_i = b $

  Hence, it follows that 

  $ sum^(n)_(i = 1) b_i (sum^n_(j = 1) a^i_j w_j) &= b \
    sum^(n)_(j = 1) (sum^n_(i = 1) a^i_j b_i)  w_j &= b
  $

  We now prove that this repsentation is unique for $b$. We denote the current representation as $beta_1, ..., beta_n$. We then denote another scalar representation of $b$ from ${w_1, w_2, ..., w_n}$ as $delta_1, ..., delta_n$. Suppose there exist an i where $delta_i != beta_i$. It then follows that:

  $ sum^(n)_(i = 1) (beta_i - delta_i) w_i= b - b = 0 $

  We created a scalar representation of $0 in V$ from ${w_1, w_2, ..., w_n}$. Note that there exist a \ $(beta_i - delta_i) != 0$. Let us select $v_1$ and notice that: 

  $ sum^(n)_(i = 1) (a^1_i + (beta_i - delta_i)) w_i= v_1 + 0 = v_1 $ 

  There exist an $i$ where $a^1_i + (beta_i - delta_i) != a_i$ as $(beta_i - delta_i) != 0$. We created another scalar representation for $v_1$ from ${w_1, w_2, ..., w_n}$. This contradicts that their scalar representation is unique. Hence, it must be that there does not exist an i where $delta_i != beta_i$. In other words, it must be that $beta_i = delta_i$ and scalar representation of $b$ from ${w_1, w_2, ..., w_n}$ is unique. Thus, it is a basis of $V$ over $FF$

#pagebreak()
#set enum(start: 3)

+ 

  #set enum(numbering: "(a)", start: 1)
  + No. For example, for $P^1$, a basis would be ${x + 1, x}$. We note that the transformed set ${x, x} = {x}$ is not a basis because no linear combination can create $1 in P^1$. 

    \

  + For any $f, g$ in $P^(n, 0)$, we note that $(f + g)(0) = 0 + 0 = 0$, so $f + g in P^(n, 0)$ and is closed under addition. Furthermore, for any scalar $c in CC$, $(c dot f)(0) = c dot 0 = 0$. Hence, $c dot f in P^(n, 0)$ and is closed under scalar multiplication. Lastly, it contains $0$ from $ P^n$. Since $P^(n, 0) subset.eq P^n $, by the subspace test, it is a vector space. 

    \

  + We denote the set of the derivatives from $B$ as $B'$. We first prove that $B'$ is spanning system for $P^(n-1)$. Let $f in P^(n-1)$ and define it as $f = sum^(n-1)_(i = 0) a_i x^i$ with $a_i in CC$. We then denote $hat(f) = sum^(n-1)_(i = 0) frac(a_i, i + 1) x^(i + 1)$. It should be noted that $hat(f)(0) = 0$ and $hat(f)' = f$. Since $hat(f)' in P^(n, 0)$, there exist a linear combination with scalars $alpha_i$ where:

    $ hat(f) = alpha_1 f_1 + ... + alpha_n f_n $
  
    From the additive property of derivatives, we note that: 
    
    $ hat(f)' = f = alpha_1 f'_1 + ... + alpha_n f'_n $

    Hence, $B'$  is a spanning system for $P^(n - 1)$. We now prove that $B'$ is also linearly independent. Let us assume it is not. Then there exists a set of scalars $beta_i$ where: 

    $ 0  = beta_1 f'_1 + ... + beta_n f'_n " where " exists i "that " beta_i != 0 $

    In this case, let us denote $g = beta_1 f_1 + ... + beta_n f_n $. By the additive property of derivatives, we note that $g' = beta_1 f'_1 + ... + beta_n f'_n = 0$. This implies that $g(x)= c$ for $c in CC$. If $c = 0$, $B$ has a non-trival representation of $0$ thus not a basis, a contradiction. If $c != 0$, then $g(0) != 0$, which implies that $P^(n, 0)$ is not closed under addition, another contradiction. Hence, it implies that our earlier assumption is incorrect, so there does not exist a $beta_i != 0$. 

    \
    We proved $B'$ to be a spanning system and linearly independent for $P^(n-1)$. By a proposition in class, this implies it is a basis for $P^(n -1)$
    


