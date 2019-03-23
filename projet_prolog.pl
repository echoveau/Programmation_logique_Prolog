un_dico(dic('*', false, [
		dic('a', true, [
			dic('n', true, [])]),
		dic('b', false, [
			dic('a', false, [
				dic('c', true, []),
				dic('r', true, [])])])])).

%%%%%%%% QUESTION 1 %%%%%%%%%%%
% un_dico(Dico), cherche("an", Dico).

cherche(X,dic('*',false,[D|_])):-
	cherche(X,D).
cherche(X,dic('*',false,[_|Rd])):-
	cherche(X,dic('*',false,Rd)).
cherche(X,dic(C,true,_)):-
	string_chars(X,[C1]), C1=C. 
cherche(X,dic(C1,_,[D|_])):-
		string_chars(X,[C1|L]), string_chars(Mot,L), cherche(Mot,D), C1 \= '*'.
cherche(X,dic(C1,T,[_|Rd])):-
		cherche(X,dic(C1,T,Rd)), C1\= '*'.

%%%%%%%% QUESTION 2 %%%%%%%%%%%
% un_dico(D),tous_les_mots(D,D_).

% un_dico(Dico), tous_les_mots_mt(Dico, L).

tous_les_mots_mt(dic('*',false,Rd),R):-
	appliquer_tout_les_mots(Rd,Res),met_a_plat(Res,R).

tous_les_mots_mt(dic(X,true,[]),[X]).
tous_les_mots_mt(dic(X,true,D),[[X],[X|Res]]):-
	appliquer_tout_les_mots(D,Res),D\=[].

tous_les_mots_mt(dic(X,false,Rd),R):-
	appliquer_tout_les_mots(Rd,Res),insere_tete(X,Res,R), X\='*'.


appliquer_tout_les_mots([D],Res):-
	tous_les_mots_mt(D,Res).
appliquer_tout_les_mots([D|Rd],[Res,Res2]):-
	tous_les_mots_mt(D,Res),appliquer_tout_les_mots(Rd,Res2).

% un_dico(Dico), tous_les_mots(Dico, L).
tous_les_mots(D,Res):-
	tous_les_mots_mt(D,R),ll_to_lstring(R,Res).


% ll_to_lstring([[a], [a, n], [b, a, c], [b, a, r]],Res).
ll_to_lstring([L],[Mot]):-
	string_chars(Mot,L).
ll_to_lstring([L|Rl],[Mot|Res]):-
	string_chars(Mot,L),ll_to_lstring(Rl,Res).

/*
Description : tous_les_mots_mt va parcourir le dico(A,B,D) et va appliquer tous_les_mots_mt à tous les éléments de la liste de dico D par le biais de la fonction appliquer_tout_les_mots. 

Dans tous_les_mots, on fait appel à tous_les_mots_mt qui va retourner [[a], [a, n], [b, a, c], [b, a, r]]  et on va convertir cette liste de liste en liste de string avec la fonction ll_to_lstring.
*/


/*
			%%%%%%%%%%%%% VERSION 1: %%%%%%%%%%%%%%
Dans cette version initiale, tous les mots partant d'une même lettre étaient collés les uns aux autres 

tous_les_mots(dic('*', false, [D|[]]),L):-
	tous_les_mots(D,L).
tous_les_mots(dic('*', false, [D|RD]),[Res,Res2]):-
	tous_les_mots(D,L1),string_chars(Res,L1),tous_les_mots(dic('*', false,RD),L2),string_chars(Res2,L2).

tous_les_mots(dic(A, true, []), [A]).
tous_les_mots(dic(A, true, [D|RD]),L):-
	tous_les_mots(D,L1),tous_les_mots(dic(A, true, RD),L2),met_a_plat([[A|L1],L2],L).

tous_les_mots(dic(A, false, [D|[]]), [A|L1]):-
	A \= '*',tous_les_mots(D,L1).
tous_les_mots(dic(A, false, [D|RD]),Res):-
	A \= '*',tous_les_mots(D,L1),tous_les_mots(dic(A, false,RD),L2),append([A|L1],L2,Res).

*/


/*
			%%%%%%%%%%%%%% VERSION 2 : %%%%%%%%%%%%%%
affichait : L = [[a], [a, n]| (b| [[a, c], (a| [r])])]

tous_les_mots(dic(A, true, []), [A]).

tous_les_mots(dic('*', false, [D|Rd]), L):-
	tous_les_mots(D,L1),tous_les_mots(dic('*', false,Rd),L2),append(L1,L2,L).
tous_les_mots(dic('*', false, [D|[]]), L):-
	tous_les_mots(D,L).

tous_les_mots(dic(A, true, [D|Rd]), [[A],L]):-
	tous_les_mots(D,L1),tous_les_mots(dic(A,true,Rd),L2),append(L2,L1,L).

tous_les_mots(dic(A, false, [D|[]]), A|L):-
	A \= '*',tous_les_mots(D,L).

tous_les_mots(dic(A, false, [D|Rd]), [[A|L1] , L2]):-
	A \= '*',tous_les_mots(D,L1),tous_les_mots(dic(A,false,Rd),L2).

*/

/*	AUTRES FONCTIONS CREES QUI N'ONT PAS ETE UTILES FINALEMENT		*/

% insere_tete(5,[[1,2],[],[3]],R).
insere_tete(X,[L|[]],[[X|L]]).
insere_tete(X,[L|RL],Res):-
	insere_tete(X,RL,R),append([[X|L]],R,Res).



% met_a_plat([[1,2]],X).
met_a_plat([L|[]],L).
met_a_plat([L|RLL],Res):-
	met_a_plat(RLL,RL),append(L,RL,Res).




%%%%%%%% QUESTION 3 %%%%%%%%%%% inserer(String,Dico,Dico_)

% appartient('b',[dic('a',false,[]),dic('b',false,[]),dic('c',false,[])]).
appartient(L,[dic(L,_,_)|_]).
appartient(L,[dic(Y,_,_)|DL]):-
	L\=Y,appartient(L,DL).
% Retourne vrai si la liste appartient à la liste de dico

% dico_mot(['b','o','b'],D).
dico_mot([],[]).
dico_mot([M|[]],dic(M,true,[])).
dico_mot([M|RM],dic(M,false,[Res])):-
	RM\=[],dico_mot(RM,Res).
% Retourne vrai si la liste de lettre (ou mot) correspond à la suite du dico D.

% dico_find('b',[dic('a',false,[]),dic('b',false,[]),dic('c',false,[])],D).
dico_find(X,[dic(X,B,D)|_],dic(X,B,D)).
dico_find(X,[dic(Y,_,_)|DL],Res):-
	Y\=X,dico_find(X,DL,Res).
% Retourne vrai si la branche D correspond à la branche de la liste de l'arbre dont la première lettre est 'b'

% supprimer_dic('b',[dic('a',false,[]),dic('b',false,[]),dic('c',false,[])],D).
supprimer_dic(_,[],[]).
supprimer_dic(X,[dic(X,_,_)|L],L_) :-
   supprimer_dic(X,L,L_).
supprimer_dic(X,[dic(Y,B,DL)|L],[dic(Y,B,DL)|L_]) :-
   \+(X=Y),
   supprimer_dic(X,L,L_).
% Retourne vrai si D correspond au Dico privé de sa branche contenant la lettre 'b'.

inserer_mt([],D,D).

inserer_mt([X|L],dic(Y,B,DL),dic(Y,B,[D_|Reste])):-
	L\=[],appartient(X,DL),dico_find(X,DL,D),supprimer_dic(X,DL,Reste),inserer_mt(L,D,D_).

inserer_mt([X|L],dic(Y,B,DL),dic(Y,B,[dic(X,false,[D])|DL])):-
	X \= Y, \+appartient(X,DL), dico_mot(L,D).

inserer_mt([X],dic(Y,B,DL),dic(Y,B,[dic(X,true,[])|DL])):-
	X \= Y, \+appartient(X,DL).

inserer_mt([X],dic(Y,B,DL),dic(Y,B,[dic(Z,true,DLZ)|Dnew])):-
	appartient(X,DL),dico_find(X,DL,dic(Z,_,DLZ)),supprimer_dic(X,DL,Dnew).

%Transforme mot en tableau
inserer(Mot, Dico, Dico_):-
	string_chars(Mot,L),inserer_mt(L,Dico,Dico_).

/*
Description : Dans inserer_mt, on verifie si la lettre appartient à la liste de Dico.
	SI, elle appartient, on cherche à quelle dico elle appartient et on fait la recurence sur cette branche de l'arbre. On utilise supprimer_dic pour récuperer le reste du dico privée de cette branche qui sera modifiée.
	SINON, on crée une nouvelle branche à partir de cette lettre qui se remplira grace à dico_mot 

inserer convertit le Mot en tableau afin de l'inserer dans le dico par le biais de inserer_mt.

*/
	

/*
	Version stable mais il manque une partie du dico à partir de la lettre B

inserer_mt([],D,D).
inserer_mt([A|[]],dic(A,_,D),dic(A,true,D)).

inserer_mt([A|M],dic(A,B,[]),dic(A,B,Res)):-
	dico_mot(M,Res).

inserer_mt([M1,M2|RM],dic(M1,B1,[dic(M2,B2,R2)|RD]),dic(M1,B1,[Res|RD])):-
	inserer_mt([M2|RM],dic(M2,B2,R2),Res).

inserer_mt([M1,M2|RM],dic(M1,B,[dic(A,C,D)|RD]),Res):-
	A \= M2,inserer_mt([M1,M2|RM],dic(M1,B,RD),Res).	

		%Je n'ai pas réussi à récupérer dic(A,C,D).
*/



%%%%%%%% QUESTION 4 %%%%%%%%%%% supprimer_v1(String, Dico, Dico_)


supprimer_v1_mt([A],dic(Y,B,D),dic(Y,B,[dic(X,false,C)|Reste])):-
	appartient(A,D),dico_find(A,D,dic(X,_,C)),supprimer_dic(A,D,Reste).

supprimer_v1_mt([X|L],dic(Y,B,DL),dic(Y,B,[D_|Reste])):-
	appartient(X,DL),dico_find(X,DL,D),supprimer_dic(X,DL,Reste),supprimer_v1_mt(L,D,D_).


supprimer_v1(Mot, Dico, Dico_):-
	string_chars(Mot,L),supprimer_v1_mt(L,Dico,Dico_).


%un_dico(Dico), supprimer_v1("a", Dico, Dico_).

/*
	SOLUTION STABLE MAIS MEME SOUCIS QU'AVEC L'AUTRE VERSION D'INSERER

supprimer_v1([],D,D).

supprimer_v1([A],dic(A,_,D),dic(A,false,D)).

supprimer_v1([A1,A2|R],dic(A1,B,[dic(A2,B2,C)|RD]),dic(A1,B,[Res1|RD])):-
	supprimer_v1([A2|R],dic(A2,B2,C),Res1).

supprimer_v1([A1,A2|R],dic(A1,B,[dic(C,_,_)|RD]),Res1):-
	A2\= C,supprimer_v1([A1,A2|R],dic(A1,B,RD),Res1).

*/


%%%%%%%% QUESTION 5 %%%%%%%%%%% supprimer_v2(String, Dico, Dico_)

%Autant de lettre dans le mot que dans le Dico

nb_lettre_mot([_],1).
nb_lettre_mot([_|L],N):-
	nb_lettre_mot(L,Res),N is Res+1.

nb_lettre_dico(dic(_,_,[]),1).
nb_lettre_dico(dic(_,_,[D|RD]),N):-
	nb_lettre_dico(D,Res1),nb_lettre_dico(dic(_,_,RD),Res2),N is Res1+Res2.

autant_de_lettre(L,D):-
	nb_lettre_mot(L,Nb),nb_lettre_dico(D,Nb).



supprimer_v2_mt([A],dic(Y,B,D),dic(Y,B,[dic(X,false,C)|Reste])):-
	dico_find(A,D,dic(X,_,C)),supprimer_dic(A,D,Reste),C\=[].

supprimer_v2_mt([A],dic(Y,B,D),dic(Y,B,[Reste])):-
	dico_find(A,D,dic(A,_,C)),C=[],supprimer_dic(A,D,Reste).

/*Non fonctionnel*/
supprimer_v2_mt([X|L],dic(Y,B,DL),dic(Y,B,[Reste])):-
	dico_find(X,DL,D),autant_de_lettre(L,D),supprimer_dic(X,D,Reste),
	string_chars(Mot,[X|L]),cherche(Mot,D).

supprimer_v2_mt([X|L],dic(Y,B,DL),dic(Y,B,[D_|Reste])):-
	appartient(X,DL),dico_find(X,DL,D),supprimer_dic(X,DL,Reste),supprimer_v2_mt(L,D,D_).



supprimer_v2(Mot, Dico, Dico_):-
	string_chars(Mot,L),supprimer_v2_mt(L,Dico,Dico_).

% 	un_dico(D),supprimer_v2_mt(['b','a','r'],D,D_).

%	un_dico(D),inserer("baie",D,D_),supprimer_v2_mt(['b','a','i','e'],D_,Res).


/*

supprimer_v2_mt([A],dic(Y,B,D),dic(Y,B,[Reste])):-
	appartient(A,D),dico_find(A,D,dic(A,_,[Reste])),supprimer_dic(A,D,Reste).

*/






























	
