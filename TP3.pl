%1
estvide(A):-
	A=abvide.		% ou estvide(abvide).

%2
racine(ab(R,_,_),R).
gauche(ab(_,G,_),G).
droit(ab(_,_,D),D).

%3
ajout(X,abvide,ab(X,abvide,abvide)).
ajout(X,A,A):-racine(A,X).				% ajout(X,ab(V,AG,AD),ab(V,AG,AD)):-X=V.
ajout(X,ab(V,AG,AD),ab(V,Res,AD)):-
		X<V,ajout(X,AG,Res).
ajout(X,ab(V,AG,AD),ab(V,AG,Res)):-
		X>V,ajout(X,AD,Res).		% ajout(5,ab(10,ab(4,abvide,abvide),abvide),Res).


%4
ajoutliste([],A,A).
ajoutliste([X|L],A,Fin):-
	ajout(X,A,Res),
	ajoutliste(L,Res,Fin).			% ajoutliste([6,2,8,1,7],abvide,Res).


arbre(A):- 
	ajoutliste([6,2,8,1,7,3,4,5],abvide,A).	%Créer une variable
						%S'utilise arbre(A),ajout(10,A,Res).

%5
appartient(X,ab(X,_,_)).
appartient(X,ab(R,G,_)):-
	X<R, appartient(X,G).
appartient(X,ab(R,_,D)):-
	X>R, appartient(X,D).

%6
nbnoeuds(abvide,0).
nbnoeuds(ab(_,G,D),N):-
	nbnoeuds(G,NG),nbnoeuds(D,ND), N is NG+ND+1.

%7
hauteur(abvide,0).
hauteur(ab(_,G,D),H):-
	hauteur(G,HG),hauteur(D,HD),H is max(HG,HD)+1.

%8
profondeur(ab(X,_,_),X,0).
profondeur(ab(N,G,_),X,P):-
	X<N, profondeur(G,X,PG),P is PG+1.
profondeur(ab(N,_,D),X,P):-
	X>N, profondeur(D,X,PD), P is PD+1.

%9
parcours_prefixe(abvide,[]).
parcours_prefixe(ab(X,G,D),L):-
	parcours_prefixe(G,LG),parcours_prefixe(D,LD),append([X|LG],LD,L).

%10
parcours_infixe(abvide,[]).
parcours_infixe(ab(X,G,D),L):-
	parcours_infixe(G,LG),parcours_infixe(D,LD),append(LG,[X|LD],L).

%11
parcours_postfixe(abvide,[]).
parcours_postfixe(ab(X,G,D),L):-
	parcours_postfixe(G,LG),parcours_postfixe(D,LD),append(LG,LD,LGD),append(LGD,[X],L).

%12
plus_grand(ab(X,_,abvide),X).
plus_grand(ab(_,_,D),N):-
	plus_grand(D,N).

%13
supprimer(ab(X,abvide,D),X,D).
supprimer(ab(X,G,D),X,ab(Y,G_,D)):-
	plus_grand(G,Y),supprimer(G,Y,G_).
supprimer(ab(Y,G,D),X,ab(Y,G_,D)):-
	X<Y,supprimer(G,X,G_).
supprimer(ab(Y,G,D),X,ab(Y,G,D_)):-
	X>Y,supprimer(D,X,D_).




























