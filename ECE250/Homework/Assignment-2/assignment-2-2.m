>> clear
>> vec(2:4,3:5) = [ linspace(1,3,3) ; linspace(10,6,3) ; linspace(20,32,3)]

vec =

     0     0     0     0     0
     0     0     1     2     3
     0     0    10     8     6
     0     0    20    26    32

>> vec(2:4,3:5) = [ linspace(1,3,3) ; linspace(10,6,3) ; linspace(20,32,3)]'

vec =

     0     0     0     0     0
     0     0     1    10    20
     0     0     2     8    26
     0     0     3     6    32

>> %2.22 ans above
>> %2.24
>> a = [ 7 2 -3 1 0]

a =

     7     2    -3     1     0

>> a = [ 7 2 -3 1 0];b = -3 10 0 7 -2];c = 1 0 4 -6 5];
 a = [ 7 2 -3 1 0];b = -3 10 0 7 -2];c = 1 0 4 -6 5];
                         |
Error: Unexpected MATLAB expression.
 
>> a = [ 7 2 -3 1 0];b = [-3 10 0 7 -2];c = 1 0 4 -6 5];
 a = [ 7 2 -3 1 0];b = [-3 10 0 7 -2];c = 1 0 4 -6 5];
                                           |
Error: Unexpected MATLAB expression.
 
>> a = [ 7 2 -3 1 0];b = [-3 10 0 7 -2];c = [1 0 4 -6 5];
>> who

Your variables are:

a    b    c    vec  

>> hows
Undefined function or variable 'hows'.
 
>> whos
  Name      Size            Bytes  Class     Attributes

  a         1x5                40  double              
  b         1x5                40  double              
  c         1x5                40  double              
  vec       4x5               160  double              

>> clear vec
>> vec(3,5) = [a,b,c]
Subscripted assignment dimension mismatch.
 
>> vec = [a,b,c]

vec =

  Columns 1 through 12

     7     2    -3     1     0    -3    10     0     7    -2     1     0

  Columns 13 through 15

     4    -6     5

>> vec(3,5) = [a;b;c]
Subscripted assignment dimension mismatch.
 
>> vec = [a;b;c]

vec =

     7     2    -3     1     0
    -3    10     0     7    -2
     1     0     4    -6     5

>> vec = [a(1:3);b(3);c(3)]
Error using vertcat
CAT arguments dimensions are not consistent.
 
>> vec = [a(1:3);b(1:3);c(1:3)]

vec =

     7     2    -3
    -3    10     0
     1     0     4

>> %2.24 a ans above
>> %b
>> vec = [a(3:5);b(3:5);c(3:5)]

vec =

    -3     1     0
     0     7    -2
     4    -6     5

>> vec = [a(3:5)';b(3:5)';c(3:5)']

vec =

    -3
     1
     0
     0
     7
    -2
     4
    -6
     5

>> vec = [a(3:5) b(3:5) c(3:5)]

vec =

    -3     1     0     0     7    -2     4    -6     5

>> vec = [a(3:5)' b(3:5)' c(3:5)']

vec =

    -3     0     4
     1     7    -6
     0    -2     5

>> %2.29
>> A = [ 1,6 ]

A =

     1     6

>> A = [ 1:6 ]

A =

     1     2     3     4     5     6

>> A = [ 1:6 ; 7:12 ; 13 :18]

A =

     1     2     3     4     5     6
     7     8     9    10    11    12
    13    14    15    16    17    18

>> A = [ 1:6 ; 7:12 ; 13:18]

A =

     1     2     3     4     5     6
     7     8     9    10    11    12
    13    14    15    16    17    18

>> ha = A(:,10
 ha = A(:,10
           |
Error: Expression or statement is incorrect--possibly unbalanced (, {, or [.
 
>> ha = A(:,10)
Attempted to access A(:,10); index out of bounds because size(A)=[3,6].
 
>> ha = A(1:,10)
 ha = A(1:,10)
         |
Error: Expression or statement is incorrect--possibly unbalanced (, {, or [.
 
>> ha = A(1,10)
Attempted to access A(1,10); index out of bounds because size(A)=[3,6].
 
>> ha = A(1,6)

ha =

     6

>> ha = A(:,6)

ha =

     6
    12
    18

>> ha = A(6,:)
Attempted to access A(6,:); index out of bounds because size(A)=[3,6].
 
>> ha = A(6)

ha =

    14

>> ha = A(6,1)
Attempted to access A(6,1); index out of bounds because size(A)=[3,6].
 
>> ha = A(1,6)

ha =

     6

>> ha = A(1,:)

ha =

     1     2     3     4     5     6

>> hb = A(:, 6)

hb =

     6
    12
    18

>> hc = [ A(2, 1:3)
]

hc =

     7     8     9

>> hc = [ A(2, 1:3) , A(3, 4:6)]

hc =

     7     8     9    16    17    18

>> %32
>> E [ zeros(4) 2*ones(3)]
Undefined function 'E' for input arguments of type 'char'.
 
>> E [ zeros(4) ]
Undefined function 'E' for input arguments of type 'char'.
 
>> E [ 0 0 0 0 2 2 2 2; 0.7:0.1:7] ]
 E [ 0 0 0 0 2 2 2 2; 0.7:0.1:7] ]
                              |
Error: Unbalanced or unexpected parenthesis or bracket.
 
>> E = [ 0 0 0 0 2 2 2 2; 0.7:0.1:7] 
Error using vertcat
CAT arguments dimensions are not consistent.
 
>> E = [ 0 0 0 0 2 2 2 ; 0.7:0.1:7]
Error using vertcat
CAT arguments dimensions are not consistent.
 
>> E = [ 0 0 0 0 2 2 2 ; 0.7:0.1]

E =

     0     0     0     0     2     2     2

>> E = [ 0 0 0 0 2 2 2 ; linspace(0.7,0.1,7)]

E =

         0         0         0         0    2.0000    2.0000    2.0000
    0.7000    0.6000    0.5000    0.4000    0.3000    0.2000    0.1000

>> format short
>> E = [ 0 0 0 0 2 2 2 ; linspace(0.7,0.1,7)]\
 E = [ 0 0 0 0 2 2 2 ; linspace(0.7,0.1,7)]\
                                           |
Error: Expression or statement is incomplete or incorrect.
 
>> E = [ 0 0 0 0 2 2 2 ; linspace(0.7,0.1,7)]

E =

         0         0         0         0    2.0000    2.0000    2.0000
    0.7000    0.6000    0.5000    0.4000    0.3000    0.2000    0.1000

>> E = [ 0 0 0 0 2 2 2 ; 0.1,0.1,0.1]
Error using vertcat
CAT arguments dimensions are not consistent.
 
>> E = [ 0 0 0 0 2 2 2 ; 0.7,0.1,0.1]
Error using vertcat
CAT arguments dimensions are not consistent.
 
>> E = [ 0 0 0 0 2 2 2 ; 0.7,-0.1,0.1]
Error using vertcat
CAT arguments dimensions are not consistent.
 
>> E = [ 0 0 0 0 2 2 2 ; 0.7:-0.1:0.1]

E =

         0         0         0         0    2.0000    2.0000    2.0000
    0.7000    0.6000    0.5000    0.4000    0.3000    0.2000    0.1000

>> E = [ 0 0 0 0 2 2 2 ; 0.7:-0.1:0.1 ; 22:-3:4]

E =

         0         0         0         0    2.0000    2.0000    2.0000
    0.7000    0.6000    0.5000    0.4000    0.3000    0.2000    0.1000
   22.0000   19.0000   16.0000   13.0000   10.0000    7.0000    4.0000

>> F = E([2,4] , [ 3:7])
Index exceeds matrix dimensions.
 
>> F = E([2:4] , [ 3:7])
Index exceeds matrix dimensions.
 
>> F = E([2,4] , [ 3,7])
Index exceeds matrix dimensions.
 
>> F = E([2,4] , [ 3:7])
Index exceeds matrix dimensions.
 
>> E = [ 0 0 0 0 2 2 2 ; 0.7:-0.1:0.1 ; 2:2:14 ; 22:-3:4]

E =

         0         0         0         0    2.0000    2.0000    2.0000
    0.7000    0.6000    0.5000    0.4000    0.3000    0.2000    0.1000
    2.0000    4.0000    6.0000    8.0000   10.0000   12.0000   14.0000
   22.0000   19.0000   16.0000   13.0000   10.0000    7.0000    4.0000

>> F = E([2,4] , [ 3:7])

F =

    0.5000    0.4000    0.3000    0.2000    0.1000
   16.0000   13.0000   10.0000    7.0000    4.0000

>> G = E(:, [3:5])

G =

         0         0    2.0000
    0.5000    0.4000    0.3000
    6.0000    8.0000   10.0000
   16.0000   13.0000   10.0000

>> %ans above
>> clear
>> %2.40
>> one= ones(2,2);
>> one

one =

     1     1
     1     1

>> A = one

A =

     1     1
     1     1

>> A(1:2,1:2) = one

A =

     1     1
     1     1

>> A(3:4,3:4) = one

A =

     1     1     0     0
     1     1     0     0
     0     0     1     1
     0     0     1     1

>> A(1:4,5:8) = one
Subscripted assignment dimension mismatch.
 
>> A(1:4,5:8) = A

A =

     1     1     0     0     1     1     0     0
     1     1     0     0     1     1     0     0
     0     0     1     1     0     0     1     1
     0     0     1     1     0     0     1     1

>> 