% sorte : Liste
% symboles de constante et fonction
%  [_|_] : E x Liste(E) -> Liste(E)
%  [] : Liste(E)
% symboles de predicat
%  'liste_?' : _
%  suppression : Liste(E) x E x Liste(E)
%  renverse : Liste(E) x Liste(E)
%  renverse_ : Liste(E) x Liste(E) x Liste(E)
%  conc : Liste(E) x Liste(E) x Liste(E)
%  supprime_element : E x Liste(E) x Liste(E)
%  membre : E x Liste(E)
%  ieme : Nat x Liste(E) x E.

% definition
'liste_?'([]).
'liste_?'([_X|L]) :- 
   'liste_?'(L).

suppression([X|L],X,L).
suppression([Y|L],X,[Y|L_]) :- 
   suppression(L,X,L_).

renverse(L,R) :- renverse_(L,[],R).

renverse_([],Acc,Acc).
renverse_([X|L],Acc,R) :-
   renverse_(L,[X|Acc],R).


conc([],L2,L2). 
conc([X|L1],L2,[X|L3]) :- 
   conc(L1,L2,L3).

supprime_element(_,[],[]).
supprime_element(X,[X|L],L_) :-
   supprime_element(X,L,L_).
supprime_element(X,[Y|L],[Y|L_]) :-
   \+(X=Y),
   supprime_element(X,L,L_).


membre(X,[X|_L]).
membre(X,[_Y|L]) :- 
   membre(X,L).

ieme(zero, [X | _], X).
ieme(s(N), [_ | L], X) :-
   ieme(N, L, X).

% sorte Matrice

% symboles de constante et fonction 
%  matrice_vide : Matrice(E)
%  matrice : Liste(Liste(E)) -> Matrice(E)

% symboles de predicat
%  premiere_ligne : Liste(E) x Matrice(E) x Matrice(E) 
%  listes_de_meme_longueur : Liste(E) x Liste(E_)
%  premiere_colonne : Liste(E) x Matrice(E) x Matrice(E)
%  premiere_colonne_ : Liste(E) x Liste(Liste(E)) x Liste(Liste(E))
%  en_liste : Liste(E) x Liste(Liste(E))
%  derniere_ligne : Matrice(E) x Liste(E) x Matrice(E)
%  derniere_ligne_ : Liste(Liste(E)) x Liste(E) x Liste(Liste(E))
%  derniere_colonne : Matrice(E) x Liste(E) x Matrice(E).
%  derniere_colonne_ : Liset(Liste(E)) x Liste(E) x Liste(Liste(E)).
%  ieme_ligne_jeme_colonne : Matrice(E) x Nat x Nat x E.

% definition
premiere_ligne([X|L],matrice_vide,matrice([[X|L]])).
premiere_ligne([X|L],matrice([L_|M]),matrice([[X|L],L_|M])) :-
	listes_de_meme_longueur([X|L],L_).

listes_de_meme_longueur([],[]).
listes_de_meme_longueur([_|L],[_|L_]) :-
   listes_de_meme_longueur(L,L_).


premiere_colonne([X|C],matrice_vide,matrice([[X]|MC])) :-
   en_liste([X|C],[[X]|MC]).

premiere_colonne([X|C],matrice([[Y|L]|LL]),matrice([[X,Y|L]|CLL])) :-
   premiere_colonne_(C,LL,CLL).

premiere_colonne_([],[],[]).
premiere_colonne_([X|C],[L|M],[[X|L]|CM]) :-
   L= [_|_],
   premiere_colonne_(C,M,CM).

en_liste([],[]).
en_liste([X|L],[[X]|LL]) :-
   en_liste(L,LL).


derniere_ligne(matrice_vide,[X|L],matrice([[X|L]])).
derniere_ligne(matrice(M),L,matrice(ML)) :-
   M = [_|_],
   derniere_ligne_(M,L,ML).
derniere_ligne_([],L,[L]).
derniere_ligne_([L_|M],L,[L_|ML]) :-
   derniere_ligne_(M,L,ML).


derniere_colonne(matrice_vide,C,MC) :-
   premiere_colonne(C,matrice_vide,MC).
derniere_colonne(matrice(M),C,matrice(MC)) :-
   derniere_colonne_(M,C,MC).
derniere_colonne_([],[],[]).
derniere_colonne_([L|M],[X|C],[L_X|C_M]) :-
   L = [_|_],
   conc(L,[X],L_X),
   derniere_colonne_(M,C,C_M).




matrice([[1,5,9,13],[2,6,10,14],[3,7,11,15],[4,8,12,16]]).	

%1
rotation_matrice(matrice_vide,matrice_vide).
rotation_matrice(PLM,Fin):-
	premiere_ligne(PL,M,PLM),renverse(PL,C),rotation_matrice(M,Res),premiere_colonne(C,Res,Fin).







				






















































