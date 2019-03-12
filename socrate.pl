animal(X) :- homme(X).
mortel(X) :- animal(X).
meurt(X) :-
mortel(X), empoisonne(X).
empoisonne(X) :-
boit(X,Y), poison(Y).
homme(socrate).
homme(platon).
ami(socrate, platon).
ami(platon, socrate).
boit(socrate, cigue).
poison(cigue).
