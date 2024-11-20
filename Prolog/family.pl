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

