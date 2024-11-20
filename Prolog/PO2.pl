/*
1º
a)
r(X,Y),s(Y,Z).
r(X,Y)?r(a,b) s(b,Z)? s(b,c)
                      s(b,d)
       r(a,d) s(d,Z)? s(d,e)
Basicamente quando tem dois funcs de argumentos ele esgosta primeiro o ultimo que aparece e depois é que tenta esgostar a possibilidade do outro

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