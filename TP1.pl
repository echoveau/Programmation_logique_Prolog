%1
vin1(100,'Chablis',1974,12).
vin1(110,'Mercurey',1978,13).
vin1(120,'Macon',1977,12).

vin2(100,'Chablis',1974,12).
vin2(200,'Sancerre',1979,11).
vin2(210,'Pouilly',1980,12).
vin2(230,'Pouilly',1981,12).

viticulteurs('Nicolas','Pouilly','Bourgogne').
viticulteurs('Martin','Bordeaux','Bordelais').

%2

%vin2(A,'Pouilly',B,C).
%vin2(A,B,C,12).

%3
vin3(X,Y,Z,T) :-
	vin1(X,Y,Z,T),vin2(X,Y,Z,T).

%4
vin4(X,Y,Z,T) :-
	vin1(X,Y,Z,T).
vin4(X,Y,Z,T) :-
	vin2(X,Y,Z,T).

%5
%not(vin2(A,B,1978,C)).
% \+vin2(A,B,1978,C).

%6
/*vin5(X,Y,Z,T) :-
	vin1(X,Y,Z,T),not(vin2(X,Y,Z,T)).
*/
vin5(X,Y,Z,T) :-
	vin1(X,Y,Z,T),\+(vin2(X,Y,Z,T)).

%7
vignoble(A,B,C,D,X,Y,Z) :-
	vin5(A,B,C,D),viticulteurs(X,Y,Z).

%8
vin6(B,C) :-
	vin5(_,B,C,_).

%9
vin7(A,B,C,D) :-
	vin4(A,B,C,D),C>1975,C<1980.

%10
vin8(A,B,C,D,X,Y,Z) :-
	vin4(A,B,C,D),viticulteurs(X,Y,Z),B=Y.

%11
vin9('Macon', 1977, 12).
vin9('Macon', 1979, 14).
vin9('Macon', 1980, 12).
vin9('Saumur', 1977,  12).
vin9('Saumur', 1979,  14).
vin9('Chablis', 1977,  12).

type(1977,12).
type(1979,14).



pcru(A) :- (vin9(A,_,_),type(_Y,_Z)),\+vin9(A,_B,_C).

cru(A) :- vin9(A,_,_),\+pcru(A).


/*
	vin9 / type =
		proj crue (vin9)			
		\
		(proj crue
			[(proj crue (vin9)
				x type)
			\
			vin 9 ]
		)



avec:
	proj crue (vin9)					-----> vin9(A,_,_)
	proj crue (vin9) x type(X,Y,Z)				-----> vin9(A,_,_),type(Y,Z)
	proj crue (vin9) x type(X,Y,Z)\vin9(C,M,D)		-----> (vin9(A,_,_),type(Y,Z)),\+vin9(A,B,C)
	proj crue proj crue (vin9) x type(X,Y,Z)\vin9(C,M,D)	-----> (vin9(A,_,_),type(Y,Z)),\+vin9(A,B,C))
	
	cru(c) :- vin9(A,_,_),\+(vin9(A,_,_),type(Y,Z)),\+vin9(A,B,C))





%proj
vin6(B,C) :-
	vin5(_,B,C,_).

%\
vin5(X,Y,Z,T) :-
	vin1(X,Y,Z,T),\+(vin2(X,Y,Z,T)).

%x
vignoble(A,B,C,D,X,Y,Z) :-
	vin5(A,B,C,D),viticulteurs(X,Y,Z).

*/























