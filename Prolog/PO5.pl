:- use_module(library(lists)).

% Lista de homens
male('Frank').
male('Phil').
male('Jay').
male('Javier').
male('Mitchell').
male('Joe').
male('Manny').
male('Cameron').
male('Dylan').
male('Luke').
male('George').
male('Merle').
male('Bo').
male('Rexford').
male('Calhoun').
% Lista de mulheres
female('Grace').
female('Gloria').
female('Claire').
female('Haley').
female('Lily').
female('Poppy').
female('Alex').
female('DeDe').
female('Barb').
female('Pameron').
% Lista de geração mais cota
parent('Grace','Phil').
parent('Frank','Phil').
parent('DeDe','Claire').
parent('DeDe','Mitchell').
parent('Jay','Claire').
parent('Jay','Mitchell').
parent('Jay','Joe').
parent('Gloria','Joe').
parent('Gloria','Manny').
parent('Javier','Manny').
parent('Barb','Cameron').
parent('Barb','Pameron').
parent('Merle','Cameron').
parent('Merle','Pameron').
% Lista de geração média
parent('Phil','Haley').
parent('Phil','Alex').
parent('Phil','Luke').
parent('Claire','Haley').
parent('Claire','Alex').
parent('Claire','Luke').
parent('Mitchell','Lily').
parent('Mitchell','Rexford').
parent('Cameron','Lily').
parent('Cameron','Rexford').
parent('Pameron','Calhoun').
% Lista de geração 2ª mais nova
parent('Dylan','George').
parent('Dylan','Poppy').
parent('Haley','George').
parent('Haley','Poppy').

grandparent(Gp,Gc):-
    parent(Gp,P),
    parent(P,Gc).

siblings(Sib,Sib2):-
    parent(P1,Sib),
    parent(P2,Sib),
    parent(P1,Sib2),
    parent(P2,Sib2),
    P1 \= P2,
    Sib \= Sib2.

halfSiblings(Sib,Sib2):-
    parent(P1,Sib),
    parent(P2,Sib),
    parent(P1,Sib2),
    parent(P3,Sib2),
    P2 \= P3,
    P1 \= P2,
    P1 \= P3,
    Sib \= Sib2.
/*
1. Family Relations Reloaded
a) Implement children(+Person, -Children), which returns in the second argument a list with the children of Person.
*/

children(Person,Children) :-
    findall(Child,parent(Person,Child),Children).

/*
c) Implement family(-F), which returns a list with all the people in the family.
*/
%Versão menos correta para fazer o family segundo genero
family(F):-
    findall(Person,(male(X);female(X)),F).
%Versão mais correta para fazer o family segundo o parent
family(F):-
    setof(Person,C^(parent(P,C);parent(C,P)),F).

/*
d) Implement couple(?C), which unifies C with a couple of people (in the format X-Y) who have at least one child in common. Example:
| ?- couple(phil-claire).
yes
| ?- couple(C).
C = dede-jay ?
*/

couple(X-Y):-
    parent(X,V),
    parent(Y,V),
    X \= Y.

/*
e) Implement couples(-List), which returns a list of all couples with children, avoiding
duplicate results.
*/

couples(List):-
    setof(X-Y,couple(X-Y),List).


% 3. Schedules
%class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '2 Tue', 15, 2).
class(pfl, tp, '2 Tue', 10.5, 2).
class(lbaw, t, '3 Wed', 10.5, 2).
class(lbaw, tp, '3 Wed', 8.5, 2).
class(ipc, t, '4 Thu', 14.5, 1.5).
class(ipc, tp, '4 Thu', 16, 1.5).
class(fsi, t, '1 Mon', 10.5, 2).
class(fsi, tp, '5 Fri', 8.5, 2).
class(rc, t, '5 Fri', 10.5, 2).
class(rc, tp, '1 Mon', 8.5, 2).

% b) Implement daily_courses(+Day, -Courses), which receives a day of the week and returns a list with all the courses taking place on that day.

daily_courses(Day,Courses):-
    findall(Course,class(Course,_,Day,_,_),Courses).

% c) Implement short_classes(-L), which returns in L a list of all classes with a duration of less than 2 hours (list of terms in the format UC-Day/Time).

short_classes(List):-
    setof(UC-Day/Time,(Duration^class(UC,_,Day,Time,Duration),Duration<2),List).

% d) Implement course_classes(+Course, -Classes), which receives a course and returns a list of all the classes from that course (list of terms in the format Day/Time-Type).

course_classes(Course,Classes):-
    bagof(Day/Time-Type,Duration^class(Course,Type,Day,Time,Duration),Classes).

/*
4. Flights
flight(origin, destination, company, code, hour, duration)
*/
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

/*
c) Implement find_flights(+Origin, +Destination, -Flights), which returns in Flights a list
with one or more flights (their codes) connecting Origin to Destination. Use depth-first
search, avoiding cycles.
*/

find_flights(Origin,Destination,Flights):- find_flights(Origin,Destination,[Origin],[],Flights).
find_flights(Origin,Origin,_,A_,A):-
    reverse(A_,A).
find_flights(O,D,Vis,P_,P):-
    flight(O,S,_,C,_,_),
    \+ member(S,Vis),
    find_flights(S,D,[S|Vis],[C|P_],P).

/*
d) Implement find_flights_bfs(+Origin, +Destination, -Flights), with the same meaning as
before, but now using breadth-first search.
*/

find_flights_bfs(Origin,Destination,Flights):-
    findall(Code,flight(Origin,Destination,_,Code,_,_),Flights).

/*
e) Implement find_all_flights (+Origin, +Destination, -ListOfFlights), which returns in
ListOfFlights a list of all the possible ways to connect Origin to Destination (each
represented as a list of flight codes).
*/
/*
f) Implement find_flights_least_stops(+Origin, +Destination, -ListOfFlights), which returns
in ListOfFlights a list of all possible ways to connect Origin to Destination (each
represented as a list of flight codes) with a minimum number of stops, i.e. a list of the
shortest paths between Origin and Destination.
*/