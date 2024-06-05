:- use_module(library(clpfd)).

% Las palabras que queremos formar
word([b,a,k,e]).
word([o,n,y,x]).
word([e,c,h,o]).
word([o,v,a,l]).
word([g,i,r,d]).
word([s,m,u,g]).
word([j,u,m,p]).
word([t,o,r,n]).
word([l,u,c,k]).
word([v,i,n,y]).
word([l,u,s,h]).
word([w,r,a,p]).

% num(?X, ?N) "La lletra X és a la posició N de la llista"
num(X, N) :- nth1(N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X).

main :-
    % Variables y dominios
    length(D1, 6),
    length(D2, 6),
    length(D3, 6),
    length(D4, 6),
    D1 ins 1..24,
    D2 ins 1..24,
    D3 ins 1..24,
    D4 ins 1..24,
    append([D1, D2, D3, D4], Vars),
    all_different(Vars),

    % Restringimos las palabras formables
    findall(W, word(W), Wlist),
    maplist(formable(Vars), Wlist),

    % Etiquetado
    labeling([], Vars),

    % Escribir resultado
    writeN(D1), nl,
    writeN(D2), nl,
    writeN(D3), nl,
    writeN(D4), nl, halt.

writeN(D) :- findall(X, (member(N, D), num(X, N)), L), write(L), nl, !.

formable(Vars, Word) :-
    maplist(num_to_var(Vars), Word, VarsForWord),
    all_distinct(VarsForWord).

num_to_var(Vars, L, V) :-
    num(L, N),
    member(Dice, Vars),
    member(N, Dice),
    nth1(DiceIdx, Vars, Dice),
    V = DiceIdx-N.
