% [numcasa,color,professio,animal,beguda,pais]
dades([[1,_,_,_,_,_],[2,_,_,_,_,_],[3,_,_,_,_,_],[4,_,_,_,_,_],[5,_,_,_,_,_]]).

condicions(D) :-
    dades(D),
    member([_,vermell,_,_,_,peru],D),
    member([_,_,_,gos,_,franca],D),
    member([_,_,pintor,_,_,japo],D),
    member([_,_,_,_,rom,xina],D),
    member([1,_,_,_,_,hungria],D),
    member([_,verd,_,_,cognac,_],D),
    member([L,blanc,_,_,_,_],D),
    L1 is L-1, 
    member([L1,verd,_,_,_,_],D),
    member([_,_,escultor,caragols,_,_],D),
    member([_,groc,actor,_,_,_],D),
    member([3,_,_,_,cava,_],D),
    member([N,_,actor,_,_,_],D),
    costat(N, N1), 
    member([N1,_,_,cavall,_,_],D),
    member([M,blau,_,_,_,_],D),
    costat(M, M1), 
    member([M1,_,_,_,_,hungria],D),
    member([_,_,notari,_,whisky,_],D),
    member([O,_,metge,_,_,_],D),
    costat(O, O1), 
    member([O1,_,_,esquirol,_,_],D).


costat(N, C) :- C is N+1.
costat(N, C) :- C is N-1.

solucio :-
    condicions(D),
    write(D), !.
