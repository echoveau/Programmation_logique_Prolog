homme('Francois Ier').
homme('Henri II').
homme('Francois II').
homme('Charles IX').
homme('Henri III').
homme('Charles Emmanuel').
homme('Victor-Amedee').
femme('Madeleine').
femme('Marguerite').
femme('Margot').
femme('Elisabeth').
	parent('Francois Ier','Henri II').
	parent('Francois Ier','Madeleine').
	parent('Francois Ier','Marguerite').
	parent('Henri II','Francois II').
	parent('Henri II','Charles IX').
	parent('Henri II','Henri III').
	parent('Henri II','Margot').
	parent('Marguerite','Charles Emmanuel').
	parent('Charles IX','Elisabeth').
	parent('Charles Emmanuel','Victor-Amedee').

%Question 2:
pere(X,Y):-
	parent(X,Y),homme(X).

mere(X,Y):-
	parent(X,Y),femme(X).

%Question 3:
fille(X,Y):-
	parent(Y,X),femme(X).

%Question 4:
gdparent(X,Y):-
	parent(X,Z),parent(Z,Y).

%Question 5:
gdpere(X,Y):-
	gdparent(X,Y),homme(X).
gdmere(X,Y):-
	gdparent(X,Y),femme(X).

%Question 6:
ancetre(X,Y):- parent(X,Y).
ancetre(X,Y):- parent(Z,Y),ancetre(X,Z).

%Question 7:
frere(X,Y):-
	homme(X),parent(Z,X),parent(Z,Y),\+(X=Y).
soeur(X,Y):-
	femme(X),parent(Z,X),parent(Z,Y),\+(X=Y).

%Question 8:
oncle(X,Y):-
	homme(X),parent(Z,Y),frere(X,Z).
tante(X,Y):-
	femme(X),parent(Z,Y),frere(X,Z).

%Question 9:
cousins_1(X,Y):-
	parent(GP,PX),parent(PX,X),parent(GP,PY),parent(PY,Y), PX \= PY.

cousins_2(X,Y):-
	cousins_1(X,Y).
cousins_2(X,Y):-
	parent(PX,X),parent(PY,Y),cousins_2(PX,PY).
































	
