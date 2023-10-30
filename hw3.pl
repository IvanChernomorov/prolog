edge(a, b, 1).
edge(b, c, 2).
edge(c, d, 1).
edge(a, d, 3).
edge(b, e, 2).
edge(d, e, 4).
edge(e, f, 2).

bfs([[End|Tail]|_], End, _, ReversedPath) :-
    reverse([End|Tail], ReversedPath).
bfs([[Cur|Tail]|Rest], End, Visited, ShortestPath):-
    append([Cur], Visited, NewVisited),
    findall([Node, Cur|Tail], (edge(Cur, Node, _), \+ member(Node, NewVisited)), Next),
    append(Rest, Next, Queue),
    bfs(Queue, End, NewVisited, ShortestPath).

main(Start, End):-
    (   bfs([[Start]], End, [], Path)
    ->
        length(Path, Length),
        sum_weight(Path, SumWeight),
        writeln("Кратчайший путь" - Path),
        writeln("Длина пути" : Length),
        writeln("Суммарный вес пути" = SumWeight)
    ;
        writeln("Пути нет!")).

sum_weight([_],0).
sum_weight([Node1, Node2|Tail], SumWeight):-
    sum_weight([Node2|Tail], RestWeight),
    edge(Node1, Node2, Weight),
    SumWeight is RestWeight + Weight.
