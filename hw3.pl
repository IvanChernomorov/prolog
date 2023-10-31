edge(a, b, 1).
edge(b, c, 2).
edge(c, d, 1).
edge(a, d, 3).
edge(b, e, 2).
edge(d, e, 4).
edge(e, f, 2).

all_paths([[End|Tail]], End, ReversedPath) :-
    reverse([End|Tail], ReversedPath).
all_paths([[End|Tail]|Rest], End, AllPaths):-
   all_paths(Rest, End, [Head|Last]),
   reverse([End|Tail], ReversedPath),
   (  is_list(Head)
   -> append([ReversedPath], [Head|Last], AllPaths)
   ;
    AllPaths = [ReversedPath, [Head|Last]]
   ).
all_paths([[Cur|Tail]|Rest], End, AllPaths):-
    findall([Node, Cur|Tail], (edge(Cur, Node, _), \+ member(Node, [Cur|Tail])), Next),
    append(Next, Rest, Stack),
    all_paths(Stack, End, AllPaths).


main(Start, End):-
    (   all_paths([[Start]], End, AllPaths)
    ->
    min_weight(AllPaths, Min, MinPath),
    writeln("Кротчайший по весу путь" : MinPath),
    writeln("Суммарный вес" = Min)
    ;
    writeln("Пути нет!")).

min_weight([Path], Min, [Path]):-
    sum_weight(Path, Min).
min_weight([Head|Tail], Min, Path):-
    min_weight(Tail, TailMin, TailPath),
    sum_weight(Head, Weight),
    (Weight < TailMin
    ->
    Min = Weight, Path = Head
    ;
    Min = TailMin, Path= TailPath).

sum_weight([_],0).
sum_weight([Node1, Node2|Tail], SumWeight):-
    sum_weight([Node2|Tail], RestWeight),
    edge(Node1, Node2, Weight),
    SumWeight is RestWeight + Weight.
