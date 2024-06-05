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
word( [w,r,a,p] ).

% num(?X, ?N)   "La lletra X és a la posició N de la llista"
num(X, N) :- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).


main :-
%1: Variables i dominis:
    length(D1, 6),
    length(D2, 6),
    length(D3, 6),
    length(D4, 6),
    append([D1, D2, D3, D4], Vars), 
    Vars ins 1..24,

    
%2: Constraints:
    all_different(Vars), 
    sorted(D1), % si D1 = [A,B,C,D,E,F], afegeix els constraints que diuen que han d'estar ordenats. 
    sorted(D2),
    sorted(D3),
    sorted(D4),
    incompatible_letters(L), 
    make_constraints(L, D1), 
    make_constraints(L, D2), 
    make_constraints(L, D3), 
    make_constraints(L, D4),


    
%3: Labeling:
    labeling([],Vars),
%4: Escrivim el resultat:
    writeN(D1), nl,
    writeN(D2), nl,
    writeN(D3), nl,
    writeN(D4), nl, halt.
    
writeN(D) :- findall(X, (member(N,D),num(X,N)), L), write(L), nl, !.

sorted([]).
sorted([X, Y | L]) :- 
    X #< Y, 
    sorted([X, Y | L]). 


incompatible_letters(L) :- 
    findall(N-M, (word(W), member(X, W), member(Y, W), num(X, N), num(Y, M), X < Y), L1), sort(L1, L).

make_constraints([], _).
make_constraints([N-M|L], [A, B, C, D, E, F]) :-
    A #\= N #\/ B #\= M, A #\= N #\/ C #\= M, A #\= N #\/ D #\= M, A #\= N #\/ E #\= M, A #\= N #\/ F #\= M, 
                         B #\= N #\/ C #\= M, B #\= N #\/ D #\= M, B #\= N #\/ E #\= M, B #\= N #\/ F #\= M, 
                                              C #\= N #\/ D #\= M, C #\= N #\/ E #\= M, C #\= N #\/ F #\= M, 
                                                                   D #\= N #\/ E #\= M, D #\= N #\/ F #\= M, 
                                                                                        E #\= N #\/ F #\= M,
make_constraints(L, [A, B, C, D, E, F]).