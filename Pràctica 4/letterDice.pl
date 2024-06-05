:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

% Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
%word( [w,r,a,p] ).
%word( [f,a,m,e] ).

% num(?X, ?N)   "La lletra X és a la posició N de la llista"
num(X, N) :- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).


main :-
%1: Variables i dominis:
    length(D1, 6),
    length(D2, 6),
    length(D3, 6),
    length(D4, 6),
    D1 ins 1..24,
    D2 ins 1..24,
    D3 ins 1..24,
    D4 ins 1..24,
    Vars = [D1, D2, D3, D4],


%2: Constraints:
    findall(W, word(W), Wlist),
    check(Wlist, Vars),

%3: Labeling:
    labeling([], D1),
    labeling([], D2),
    labeling([], D3),
    labeling([], D4),

%4: Escrivim el resultat:
    writeN(D1), nl,
    writeN(D2), nl,
    writeN(D3), nl,
    writeN(D4), nl.
    
writeN(D) :- findall(X, (member(N,D),num(X,N)), L), write(L), nl, !.


check([], _).
check([W|WS], Vars) :- formable(W, Vars), check(WS, Vars).

formable([], _).
formable([L|LS], Vars) :- num(L, N), member(D, Vars), member(N, D), select(D, Vars, Vars1), formable(LS, Vars1).
