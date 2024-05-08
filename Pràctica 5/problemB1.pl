main :- EstatInicial = [0,0],    EstatFinal = [_, 4],
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

unPas(1, [_, Y], [5, Y]). 
unPas(1, [_, Y], [0, Y]). 
unPas(1, [X, _], [X, 8]). 
unPas(1, [X, _], [X, 0]). 

unPas(1, [X, Y], [I, J]) :- J is Y+X, I = 0, J =< 8.
unPas(1, [X, Y], [I, J]) :- J is 8, I is X-(J-Y), I >= 0.

unPas(1, [X, Y], [I, J]) :- I is X+Y, J is 0, I =< 5.
unPas(1, [X, Y], [I, J]) :- I is 5, J is Y-(I-X), J >= 0.
