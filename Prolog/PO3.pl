/*
uma lista é decomposta usando | exemplo [a | [ b | [ c | []]]]
Maneira mais simples
1.
a) | ?- [a | [b, c, d] ] = [a, b, c, d] Verdadeiro
b) | ?- [a | b, c, d ] = [a, b, c, d] Falso dá erro
c) | ?- [a | [b | [c, d] ] ] = [a, b, c, d] Verdadeiro
d) | ?- [H|T] = [pfl, lbaw, fsi, ipc] Verdadeiro [pfl | [lbaw,fsi,ipc]]
e) | ?- [H|T] = [lbaw, ltw] Verdadeiro [lbaw | [ltw]]
f) | ?- [H|T] = [leic] Verdadeiro [leic | []]
g) | ?- [H|T] = [] Falso porque espera pelo menos um argumento
h) | ?- [H|T] = [leic, [pfl, ipc, lbaw, fsi] ] Verdadeiro [leic | [[pfl,ipc,lbaw,fsi]]]
i) | ?- [H|T] = [leic, Two] Verdadeiro
j) | ?- [Inst, feup] = [gram, LEIC] Verdadeiro
k) | ?- [One, Two | Tail] = [1, 2, 3, 4]  Verdadeiro
l) | ?- [One, Two | Tail] = [leic | Rest] Verdadeiro, porque assume uma nova lista onde tem garantido um elemento
*/
% 2.
% b) Implement list_sum(+List, ?Sum), which sums the values contained in List (assumed to be a proper list of numbers).

list_sum(L,S) :- list_sum(List,0,Sum).
list_sum([],Acc,Acc).
list_sum([H|T],Acc,S) :-
    Acc_ is Acc + H,
    list_sum(T,Acc_,S).

% d) Implement inner_product (+List1, +List2, ?Result), which determines the inner product of two vectors (represented as lists of integers, of the same size).

inner_product(L1,L2,R) :- inner_product(L1,L2,0,R).
inner_product([],[],Acc,Acc).
inner_product([Head|Tail],[H|T],Acc,Rest) :-
    Acc_ is Acc + Head * H,
    inner_product(Tail,T,Acc_,Rest).

% e) Implement count(+Elem, +List, ?N), which counts the number of occurrences (N) of Elem within List.

count(E,L,N):- count(E,L,Acc,N).
count(Elem,[],Acc,Acc).
count(Elem,[Head|Tail],Acc,N) :-
    Elem = Head, 
    Acc_ is Acc + 1,
    count(Elem,Tail,Acc_,N).
count(Elem,[Head|Tail],Acc,N) :-
    Elem \= Head, 
    count(Elem,Tail,Acc_,N).

/*
Representar o switch usando no prolog 
count(Elem,[Head|Tail],Acc,N) :-
    (Elem = Head, 
    Acc_ is Acc + 1
    ; Elem \= Head,
    Acc_ is Acc),
    count(Elem,Tail,Acc_,N).
*/

/*
3.
g) Implement replicate(+Amount, +Elem, ?List) which generates a list with Amount repetitions of Elem.
*/

replicate(0,_,[]).
replicate(N,E,[E|R]):-
    N > 0,
    N1 is N - 1,
    replicate(N1, E, R).

% i) Implement insert_elem(+Index, +List1, +Elem, ?List2), which inserts Elem into List1 at position Index, resulting in List2.

insert_elem(Index,[],Elem,[]).
insert_elem(0,[Head|Tail],Elem,[Elem|Tail]).
insert_elem(Index,[Head|Tail],Elem,[Head | Rest]) :-
    Index > 0,
    Index_ is Index - 1,
    insert_elem(Index_,Tail,Elem,Rest).

% j) Implement delete_elem(+Index, +List1, ?Elem, ?List2), which removes the element at position Index from List1 (which is unified with Elem), resulting in List2.

delete_elem(Index, [], Elem, []).
delete_elem(0, [Head|Tail], Elem, Tail).
delete_elem(Index, [Head|Tail], Elem, [Head | Rest]) :-
    Index > 0,
    Index_ is Index - 1,
    delete_elem(Index_, Tail,Elem, Rest).

/*
4.
b) Implement list_member(?Elem, ?List), which verifies if Elem is a member of List, using solely the append predicate exactly once.
*/

list_member(E,L):-
    append(_, [E | _], L).

% d) Implement list_nth(?N, ?List, ?Elem), which unifies Elem with the Nth element of List, using only the append and length predicates.
% f) Implement list_del(+List, +Elem, ?Res), which eliminates an occurrence of Elem from List, unifying the result with Res, using only the append predicate twice.


