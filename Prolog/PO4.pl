/*
1. How the Cut works
s(1).
s(2):- !.
s(3).
Without using the interpreter, state the result of each of the following queries:
a) | ?- s(X).               1 2 
b) | ?- s(X), s(Y).         1/1 1/2 2/1 2/2 
c) | ?- s(X), !, s(Y).      1/1 1/2

2. The effect of a Cut
data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a(‘five’).
cut_test_b(X):- data(X), !.
cut_test_b(‘five’).
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c(‘five’, ‘five’).
Without using the interpreter, state the result of each of the following queries:
a) | ?- cut_test_a(X), write(X), nl, fail.              one two three five
b) | ?- cut_test_b(X), write(X), nl, fail.              one
c) | ?- cut_test_c(X, Y), write(X-Y), nl, fail.         one/one one/two one/three

3. Red and Green Cuts
State, justifying, whether each of the cuts in the code is red or green.
immature(X):- adult(X), !, fail.                red
immature(_X).
adult(X):- person(X), !, age(X, N), N >=18.     green
adult(X):- turtle(X), !, age(X, N), N >=50.     green
adult(X):- spider(X), !, age(X, N), N>=1.       green
adult(X):- bat(X), !, age(X, N), N >=5.         green

4. Maximum Value
Implement max(+A, +B, +C, ?Max), which determines the maximum value between three
numbers. Note: avoid behaviors such as shown below:
| ?- max(2,3,3,X).
X = 3 ? ;
X = 3 ? ;
no
*/

max(A,B,C,A) :-
    A >= B ,
    A >= C, 
    !.
max(A,B,C,B) :-
    B >= A ,
    B >= C, 
    !.
max(A,B,C,C) :-
    C >= B ,
    C >= A, 
    !.

/*
5.
a) Implement print_n(+N, +S) which prints symbol S to the terminal N times.
*/

print_n(Number,Symbol) :-
    Number > 0,
    Number_ is Number - 1,
    write(Symbol),
    print_n(Number_,Symbol).
print_n(0,_).

/*
b) Implement print_text(+Text, +Symbol, +Padding) which prints the text received in the
first argument (using double quotes) with the padding received in the third argument
(number of spaces before and after the text), and surrounded by Symbol. Example:
| ?- print_text("Hello!", '* ', 4).
* Hello! *
*/

print_text(Text, Symbol, Padding) :-
    write(Symbol),
    print_n(Padding, ' '),
    atom_codes(A,Text),
    write(A),
    print_n(Padding, ' '),
    write(Symbol).

/*
d) Implement read_number(-X), which reads a number from the standard input, digit by digit
(i.e., without using read), returning that number (as an integer). Suggestion: use peek_code
to determine when to terminate the reading cycle (the ASCCI code for Line Feed is 10).
*/
read_number(X) :- read_number(X,0).
read_number(X,Ac) :-
    peek_code(T), 
    T \= 10,
    get_code(Y),
    Ac_ is Ac*10 + Y - 48,
    read_number(X,Ac_).
read_number(X,Ac) :-
    peek_code(T),
    T == 10,
    get_code(_),
    X = Ac.

/*
e) Implement read_until_between(+Min, +Max, -Value), which asks the user to insert an
integer number between Min and Max, and succeeds only when the value inserted is within
those limits. Hint: ensure that the read_number/1 predicate is determinate.
*/

read_until_between(Min,Max,Value) :-
    repeat,
    read_number(Value),
    Value >= Min,
    Value =< Max.