main :- EstatInicial = [3, 3, izq],    EstatFinal = [0, 0, der],
        between(1, 1000, CostMax),                  % Busquem solució de cost 0; si no, de 1, etc.
        cami(CostMax, EstatInicial, EstatFinal, [EstatInicial], Cami),
        reverse(Cami, Cami1), write(Cami1), write(' amb cost '), write(CostMax), nl, halt.

cami(0, E, E, C, C).                                % Cas base: quan l'estat actual és l'estat final.
cami(CostMax, EstatActual, EstatFinal, CamiFinsAra, CamiTotal) :-
        CostMax > 0, 
        unPas(CostPas, EstatActual, EstatSeguent),  % En B.1 i B.2, CostPas és 1.
        \+ member(EstatSeguent, CamiFinsAra),
        CostMax1 is CostMax-CostPas,
        cami(CostMax1, EstatSeguent, EstatFinal, [EstatSeguent|CamiFinsAra], CamiTotal).

unPas(1, [X, Y, izq], [X, J, der]) :- Y >= 1, J is Y-1, mayoria([X, J]). 
unPas(1, [X, Y, izq], [I, Y, der]) :- X >= 1, I is X-1, mayoria([I, Y]).

unPas(1, [X, Y, izq], [X, J, der]) :- Y >= 2, J is Y-2, mayoria([X, J]). 
unPas(1, [X, Y, izq], [I, Y, der]) :- X >= 2, I is X-2, mayoria([I, Y]).

unPas(1, [X, Y, izq], [I, J, der]) :- X >= 1, Y >= 1, I is X-1, J is Y-1, mayoria([I, J]).

unPas(1, [X, Y, der], [X, J, izq]) :- Y =< 3, J is Y+1, mayoria([X, J]). 
unPas(1, [X, Y, der], [I, Y, izq]) :- X =< 3, I is X+1, mayoria([I, Y]).

unPas(1, [X, Y, der], [X, J, izq]) :- Y =< 1, J is Y+2, mayoria([X, J]). 
unPas(1, [X, Y, der], [I, Y, izq]) :- X =< 1, I is X+2, mayoria([I, Y]).

unPas(1, [X, Y, der], [I, J, izq]) :- X =< 3, Y =< 3, I is X+1, J is Y+1, mayoria([I, J]).

mayoria([X, Y]) :-  X == Y.
mayoria([X, _]) :- X == 0.
mayoria([X, _]) :- X == 3.



