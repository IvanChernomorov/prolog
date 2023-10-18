% число вхождений в список
count_in([],_,0):-!.
count_in([Elem|Tail], Elem, Count):-
    count_in(Tail, Elem, TailCount),
    Count is TailCount+1.
count_in([Head|Tail], Elem, Count):-
    Elem =\= Head,
    count_in(Tail, Elem, Count).

% самый часто встречаемый элемент и его число вхождений
max_count_in([], _, 0).
max_count_in([Head|Tail], Elem, MaxCount):-
    count_in([Head|Tail], Head, Count),
    max_count_in(Tail, MaxTail, MaxCountTail),
   (Count =:= MaxCountTail -> MaxCount = Count, (Head >= MaxTail -> Elem = Head; Elem = MaxTail);
   (Count > MaxCountTail -> Elem = Head, MaxCount = Count;
    Elem = MaxTail, MaxCount = MaxCountTail)).

% добавить элемент Count раз в начало списка
append_some(List, Elem, 0, List).
append_some(List, Elem, Count, NewList):-
    Count > 0,
    TempList = [Elem| List],
    NewCount is Count-1,
    append_some(TempList, Elem, NewCount, NewList).

% сортировка
sort_freq([], []).
sort_freq(List, Sorted):-
   max_count_in(List, Elem, MaxCount),
   delete(List, Elem, NewList),
   sort_freq(NewList, SortedTail),
   append_some(SortedTail, Elem, MaxCount, Sorted).

% основная функция
main(List):-
    sort_freq(List, Sorted),
    write(Sorted).



