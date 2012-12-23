a = 3.5 ; b = -6.4;
vec = [ a a^2 a/b a*b sqrt(a)]

vec =

    3.5000   12.2500   -0.5469  -22.4000    1.8708

%2.10
vec = [ a a^2 a/b a*b sqrt(a)]

vec =

    3.5000   12.2500   -0.5469  -22.4000    1.8708

vec = linspace(-21,12,15)

vec =

  Columns 1 through 7

  -21.0000  -18.6429  -16.2857  -13.9286  -11.5714   -9.2143   -6.8571

  Columns 8 through 14

   -4.5000   -2.1429    0.2143    2.5714    4.9286    7.2857    9.6429

  Column 15

   12.0000

vec'

ans =

  -21.0000
  -18.6429
  -16.2857
  -13.9286
  -11.5714
   -9.2143
   -6.8571
   -4.5000
   -2.1429
    0.2143
    2.5714
    4.9286
    7.2857
    9.6429
   12.0000

vec = vec,

vec =

  Columns 1 through 7

  -21.0000  -18.6429  -16.2857  -13.9286  -11.5714   -9.2143   -6.8571

  Columns 8 through 14

   -4.5000   -2.1429    0.2143    2.5714    4.9286    7.2857    9.6429

  Column 15

   12.0000

vec

vec =

  Columns 1 through 7

  -21.0000  -18.6429  -16.2857  -13.9286  -11.5714   -9.2143   -6.8571

  Columns 8 through 14

   -4.5000   -2.1429    0.2143    2.5714    4.9286    7.2857    9.6429

  Column 15

   12.0000

%2.16
vec = [linspace(0,30,7),linspace(600,0,7),linspace(0,5,7)]

vec =

  Columns 1 through 7

         0    5.0000   10.0000   15.0000   20.0000   25.0000   30.0000

  Columns 8 through 14

  600.0000  500.0000  400.0000  300.0000  200.0000  100.0000         0

  Columns 15 through 21

         0    0.8333    1.6667    2.5000    3.3333    4.1667    5.0000

vec = [linspace(0,30,7);linspace(600,0,7);linspace(0,5,7)]

vec =

         0    5.0000   10.0000   15.0000   20.0000   25.0000   30.0000
  600.0000  500.0000  400.0000  300.0000  200.0000  100.0000         0
         0    0.8333    1.6667    2.5000    3.3333    4.1667    5.0000

%2.22
vec = [ zeros(:,1:2) ]
{Undefined variable zeros.
} 
vec = [ zeros(1:4,1:2) ]
{Warning: Input arguments must be scalar.} 
{Warning: Input arguments must be scalar.} 

vec =

     0

vec = [ zeros(1,7) ]

vec =

     0     0     0     0     0     0     0

vec = [ zeros(1,7:1,2) ]

vec =

   Empty array: 1-by-0-by-2

vec = [ zeros(1,7) ]

vec =

     0     0     0     0     0     0     0

vec = [ linspace(1,3,3) ; linspace(10,6,3) ; linspace(20,32,3)]

vec =

     1     2     3
    10     8     6
    20    26    32

vec '
 vec '
    |
{Error: A MATLAB string constant is not terminated properly.
} 
vec'

ans =

     1    10    20
     2     8    26
     3     6    32

vec2 = [zeros(4,5)]

vec2 =

     0     0     0     0     0
     0     0     0     0     0
     0     0     0     0     0
     0     0     0     0     0

vec2(2 3 4, 3 4 5) = vec'
 vec2(2 3 4, 3 4 5) = vec'
       |
{Error: Unexpected MATLAB expression.
} 
vec2(2 3 4, 3 4 5) = [vec']
 vec2(2 3 4, 3 4 5) = [vec']
       |
{Error: Unexpected MATLAB expression.
} 
vec2(2:4, 3:5) = [vec']

vec2 =

     0     0     0     0     0
     0     0     1    10    20
     0     0     2     8    26
     0     0     3     6    32

vec(2:4,3:5) = [ linspace(1,3,3) ; linspace(10,6,3) ; linspace(20,32,3)]'

vec =

     1     2     3     0     0
    10     8     1    10    20
    20    26     2     8    26
     0     0     3     6    32

vec(2:4,3:5) = [ linspace(1,3,3) ; linspace(10,6,3) ; linspace(20,32,3)]

vec =

     1     2     3     0     0
    10     8     1     2     3
    20    26    10     8     6
     0     0    20    26    32

vec(2:4,3:5) = [ 1]

vec =

     1     2     3     0     0
    10     8     1     1     1
    20    26     1     1     1
     0     0     1     1     1

clc
clear
vec(2:4,3:5) = [ linspace(1,3,3) ; linspace(10,6,3) ; linspace(20,32,3)]

vec =

     0     0     0     0     0
     0     0     1     2     3
     0     0    10     8     6
     0     0    20    26    32

vec(2:4,3:5) = [ linspace(1,3,3) ; linspace(10,6,3) ; linspace(20,32,3)]'

vec =

     0     0     0     0     0
     0     0     1    10    20
     0     0     2     8    26
     0     0     3     6    32

%2.22 ans above
%2.24
a = [ 7 2 -3 1 0]

a =

     7     2    -3     1     0

a = [ 7 2 -3 1 0];b = -3 10 0 7 -2];c = 1 0 4 -6 5];
 a = [ 7 2 -3 1 0];b = -3 10 0 7 -2];c = 1 0 4 -6 5];
                         |
{Error: Unexpected MATLAB expression.
} 
a = [ 7 2 -3 1 0];b = [-3 10 0 7 -2];c = 1 0 4 -6 5];
 a = [ 7 2 -3 1 0];b = [-3 10 0 7 -2];c = 1 0 4 -6 5];
                                           |
{Error: Unexpected MATLAB expression.
} 
a = [ 7 2 -3 1 0];b = [-3 10 0 7 -2];c = [1 0 4 -6 5];
who

Your variables are:

a    b    c    vec  

hows
{Undefined function or variable 'hows'.
} 
whos
  Name      Size            Bytes  Class     Attributes

  a         1x5                40  double              
  b         1x5                40  double              
  c         1x5                40  double              
  vec       4x5               160  double              

clear vec
vec(3,5) = [a,b,c]
{Subscripted assignment dimension mismatch.
} 
vec = [a,b,c]

vec =

  Columns 1 through 12

     7     2    -3     1     0    -3    10     0     7    -2     1     0

  Columns 13 through 15

     4    -6     5

vec(3,5) = [a;b;c]
{Subscripted assignment dimension mismatch.
} 
vec = [a;b;c]

vec =

     7     2    -3     1     0
    -3    10     0     7    -2
     1     0     4    -6     5

vec = [a(1:3);b(3);c(3)]
{Error using <a href="matlab:helpUtils.errorDocCallback('vertcat')" style="font-weight:bold">vertcat</a>
CAT arguments dimensions are not consistent.
} 
vec = [a(1:3);b(1:3);c(1:3)]

vec =

     7     2    -3
    -3    10     0
     1     0     4

%2.24 a ans above
%b
vec = [a(3:5);b(3:5);c(3:5)]

vec =

    -3     1     0
     0     7    -2
     4    -6     5

vec = [a(3:5)';b(3:5)';c(3:5)']

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

vec = [a(3:5) b(3:5) c(3:5)]

vec =

    -3     1     0     0     7    -2     4    -6     5

vec = [a(3:5)' b(3:5)' c(3:5)']

vec =

    -3     0     4
     1     7    -6
     0    -2     5

%2.29
A = [ 1,6 ]

A =

     1     6

A = [ 1:6 ]

A =

     1     2     3     4     5     6

A = [ 1:6 ; 7:12 ; 13 :18]

A =

     1     2     3     4     5     6
     7     8     9    10    11    12
    13    14    15    16    17    18

A = [ 1:6 ; 7:12 ; 13:18]

A =

     1     2     3     4     5     6
     7     8     9    10    11    12
    13    14    15    16    17    18

ha = A(:,10
 ha = A(:,10
           |
{Error: Expression or statement is incorrect--possibly unbalanced (, {, or [.
} 
ha = A(:,10)
{Attempted to access A(:,10); index out of bounds because size(A)=[3,6].
} 
ha = A(1:,10)
 ha = A(1:,10)
         |
{Error: Expression or statement is incorrect--possibly unbalanced (, {, or [.
} 
ha = A(1,10)
{Attempted to access A(1,10); index out of bounds because size(A)=[3,6].
} 
ha = A(1,6)

ha =

     6

ha = A(:,6)

ha =

     6
    12
    18

ha = A(6,:)
{Attempted to access A(6,:); index out of bounds because size(A)=[3,6].
} 
ha = A(6)

ha =

    14

ha = A(6,1)
{Attempted to access A(6,1); index out of bounds because size(A)=[3,6].
} 
ha = A(1,6)

ha =

     6

ha = A(1,:)

ha =

     1     2     3     4     5     6

hb = A(:, 6)

hb =

     6
    12
    18

hc = [ A(2, 1:3)
]

hc =

     7     8     9

hc = [ A(2, 1:3) , A(3, 4:6)]

hc =

     7     8     9    16    17    18

%32
E [ zeros(4) 2*ones(3)]
{Undefined function 'E' for input arguments of type 'char'.
} 
E [ zeros(4) ]
{Undefined function 'E' for input arguments of type 'char'.
} 
E [ 0 0 0 0 2 2 2 2; 0.7:0.1:7] ]
 E [ 0 0 0 0 2 2 2 2; 0.7:0.1:7] ]
                              |
{Error: Unbalanced or unexpected parenthesis or bracket.
} 
E = [ 0 0 0 0 2 2 2 2; 0.7:0.1:7] 
{Error using <a href="matlab:helpUtils.errorDocCallback('vertcat')" style="font-weight:bold">vertcat</a>
CAT arguments dimensions are not consistent.
} 
E = [ 0 0 0 0 2 2 2 ; 0.7:0.1:7]
{Error using <a href="matlab:helpUtils.errorDocCallback('vertcat')" style="font-weight:bold">vertcat</a>
CAT arguments dimensions are not consistent.
} 
E = [ 0 0 0 0 2 2 2 ; 0.7:0.1]

E =

     0     0     0     0     2     2     2

E = [ 0 0 0 0 2 2 2 ; linspace(0.7,0.1,7)]

E =

         0         0         0         0    2.0000    2.0000    2.0000
