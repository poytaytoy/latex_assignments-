1. a) Starting matrix:

    $
    mat(
      3, 0, 1;
      1, 2, 1;
      1, 2, -1;
      2, 1, -1
    )
    arrow.r
    mat(
      3, 0, 1;
      0, 0, 2;
      1, 2, -1;
      2, 1, -1
    )
    arrow.r
    mat(
      1, 2, -1;
      0, 0, 2;
      3, 0, 1;
      2, 1, -1
    )
    $

    $
    arrow.r
    mat(
      1, 2, -1;
      0, 0, 2;
      0, -6, 4;
      0, -3, 1
    )
    arrow.r
    mat(
      1, 2, -1;
      0, 0, 2;
      0, -6, 4;
      0, -3, 1
    )
    arrow.b
    $

    $
    arrow.r
    mat(
      1, 2, -1;
      0, 0, 2;
      0, 0, 2;
      0, -3, 1
    )
    arrow.l
    mat(
      1, 2, -1;
      0, 0, 0;
      0, 0, 2;
      0, -3, 1
    )
    arrow.l
    mat(
      1, 2, -1;
      0, 0, 2;
      0, 0, 2;
      0, -3, 1
    )
    $

    $
    arrow.r
    mat(
      1, 2, -1;
      0, -3, 1;
      0, 0, 2;
      0, 0, 0
    )
    $


    It's echelon form shows that it has a pivot in every column, so it must be linearly independent. 


  b) It is not spanning because there is no pivot in every row, so it cannot be a basis 

 c) Simply include the vector $mat(0, 0, 0, 1)^T$. Since under the saame steps to get the echelon form of the S matrix, we get that: 

  $
    mat(
      1, 2, -1, 0;
      0, -3, 1, 0;
      0, 0, 2, 0;
      0, 0, 0, 1
    )
  $

  Which now has both pivots in every column and row. This implies that it is both spanning and linearly independent hence a basis. 

#pagebreak()

2. a) =>) If the set of vectors is linearly independent, then it must also be spanning since $dim V = n$ from a proposition in class. \ \
    <=) By contradiction, we assume the set of vectors span V, but is not linearly independent. From class, this implies that we can create a linearly independent with the same span, as clearly some $v_n$ for some $n$ is a linear combination of the other vectors in the set. However, if we repeat this enough times until we get a basis, the size of this basis must be less than $n = dim V$, which contradicts the size of all basis must be the same from class. 

  b) <=) if a set of $n$ vectors form a basis, then the $dim V = n$. \ \ 
    =>) From a), it implies that the linearly independent vectors are also spanning, which implies they are a basis 

#pagebreak()

3. a) If m > n, then it is possible for both S1 and S2 are calculated correctly. However, if m < n, then it is impossible because it is impossible for every column to have a pivot for S2.

  b) If m > n, then it is impossible for both S1 and S3 to be calculated correctly because every row cannot have a pivot for S3. However, if m < n, then S1 and S3 is possible to be both calculated correctly. 

  c) If m > n, it is impossible S2 and S3 to be calculated correct because every row cannot have a pivot for S3. If m < n, it is still impossible because  it is impossible for every column to have a pivot for S2. 

#pagebreak()

4. The condition is that the coefficients of the linear combination of the ${v_1, ..., v_n}$ for each $w_i$ forms a basis for $FF^n$. We prove that this condition implies that ${w_1, ..., w_n}$ is a basis for $V$. \

  Let us assume the condition. We first define the linear transformation from the vector to its coefficients from $FF^n$ from ${v_1, ..., v_n}$. From class, it is $T: V -> FF^n$ where $T(v_i) = e_i$ and $e_i$ is the standard basis of $FF^n$. From the condition, $T(w_1), ..., T(w_n)$ is a basis of $FF^n$. We note that $T$ is an isomorphism from class, so this implies that $T^(-1)(T(w_1)),..., T^(-1)(T(w_n))$ is a basis for $V$. 

#pagebreak()

5. a) We show this by recalling that all elementary matrices are invertible and their inverse are also elementary matrices. We first note that since A and B are invertible: 


  $
    E_(i_1) ... E_(i_k)A = I
  $

  and that

  $
    E_(j_1) ... E_(j_l)B &= I\
    &=  E_(j_l)^(-1) ... E_(j_1)^(-1)

  $

  Hence: 

  $
    (E_(j_l)^(-1) ... E_(j_1)^(-1)) E_(i_1) ... E_(i_k) A = B I = B
  $

  c) We are given:

  $
  A = mat(1, 1, -3, 4; 0, 2, -1, 1; 3, 5, -4, 1), quad
  B = mat(1/2, 1/2, -3/2, 2; 3, 5, -4, 1; 2, 4, -7, 9)
  $

  We find elementary matrices $E_1, E_2, E_3$ such that $E_1 E_2 E_3 A = B$.

  1. Apply $R_2 arrow.l.r R_3$ to $A$:

  $
  mat(1, 1, -3, 4; 0, 2, -1, 1; 3, 5, -4, 1)
  arrow.r^(R_2 arrow.l.r R_3)
  mat(1, 1, -3, 4; 3, 5, -4, 1; 0, 2, -1, 1)
  $

  The corresponding elementary matrix is:

  $
  E_3 = mat(1, 0, 0; 0, 0, 1; 0, 1, 0) 
  $

  2. Apply $R_2 arrow.l R_2 + 2R_1$:

  $
  mat(1, 1, -3, 4; 3, 5, -4, 1; 0, 2, -1, 1)
  arrow.r^(R_2 + 2R_1)
  mat(1, 1, -3, 4; 3, 5, -4, 1; 2, 4, -7, 9)
  $

  The corresponding elementary matrix is:

  $
  E_2 = mat(1, 0, 0; 0, 1, 0; 2, 0, 1) 
  $

  3. Apply $R_1 arrow.l frac(1,2) R_1$:

  $
  mat(1, 1, -3, 4; 3, 5, -4, 1; 2, 4, -7, 9)
  arrow.r^(frac(1,2) R_1)
  mat(1/2, 1/2, -3/2, 2; 3, 5, -4, 1; 2, 4, -7, 9)
  = B
  $

  The corresponding elementary matrix is:

  $
  E_1 = mat(1/2, 0, 0; 0, 1, 0; 0, 0, 1)
  $

  Thus, we have found elementary matrices $E_1, E_2, E_3$ such that:

  $
  E_1 E_2 E_3 A = B
  $

  where

  $
  E_3 = mat(1, 0, 0; 0, 0, 1; 0, 1, 0), quad
  E_2 = mat(1, 0, 0; 0, 1, 0; 2, 0, 1), quad
  E_1 = mat(1/2, 0, 0; 0, 1, 0; 0, 0, 1)
  $

