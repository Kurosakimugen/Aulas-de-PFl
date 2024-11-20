/*
1º
a)
r(X,Y),s(Y,Z).
r(X,Y)?r(a,b) s(b,Z)? s(b,c)
                      s(b,d)
       r(a,d) s(d,Z)? s(d,e)
Basicamente quando tem dois funcs de argumentos ele esgosta primeiro o ultimo que aparece e depois é que tenta esgostar a possibilidade do outro
b)
trace, r(X,Y),s(Y,Z) , notrace.
-> 0, apenas para o primeiro caso
trace, r(Y,Y),s(X,Y) , notrace.
-> 0, não existe resposta
trace, r(X,Y),s(Y,Y) , notrace.
-> 0, só existe uma resposta
4º
a)
%factorial(+N,-F) ?X + significa é necessário ter input, - significa que é um output, ? significa que vai ser ambos os casos
factorial(0,1)
factorial(N,F):-
    N -> 0,
    N1 is N-1,
    factorial(N1,F1),
    F is N * F1.
No caso de ser recursivo o prolog esgota primeiro o que foi antes definido na recursão e só então prossegue com as contas
*/

r(a, b).
r(a, d).
r(b, a).
r(a, c).
s(b, c).
s(b, d).
s(c, c).
s(d, e).

pairs(X, Y):- d(X), q(Y).
pairs(X, X):- u(X).
u(1).
d(2).
d(4).
q(4).
q(16).

%sum_rec(+N, -Sum) Soma de todos os numeros desde 1 até N

sum_rec(1,1).
sum_rec(N,Sum):-
    N > 1,
    N1 is N - 1,
    sum_rec(N1,Sum1),
    Sum is N+Sum1.

%pow_rec(+X, +Y, -P) Potência do valor X segundo Y

pow_rec(X,0,1).
pow_rec(X,Y,P):-
    Y1 is Y-1,
    pow_rec(X,Y1,P1),
    P is X*P1.

%square_rec(+N, -S) Determina o quadrado de um valor N sem usar multiplicações

square_rec(1,1).
square_rec(N,Res):-
    accum(N,N,Res).

accum(N,0,0).
accum(N,Y,Tres):-
    N1 is Y-1,
    accum(N,N1,Tres1),
    Tres is Tres1+N.