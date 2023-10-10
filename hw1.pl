% Произведение чисел
product_of_digits(0, 1).
product_of_digits(N, P) :- N1 is N mod 10, N2 is N div 10, product_of_digits(N2, N3), P is N3 * N1.

% Проверка простоты числа
is_prime(2) :- !.
is_prime(N) :- N > 2, N1 is N - 1, \+ has_divisor(N, 2, N1).

% Перебор делителей числа
has_divisor(N, D, Max) :-
    D =< Max,
    (N mod D =:= 0 ; NextD is D + 1, has_divisor(N, NextD, Max)).

% вычисление НОД

nod(X, Y, NOD) :- X = Y, NOD is X.
nod(X, Y, NOD) :- X < Y, Y1 is Y - X, nod(X, Y1, NOD).
nod(X, Y, NOD) :- X > Y, nod(Y, X, NOD).

% НОД максимального нечетного непростого делителя числа
find_nod(N, NOD) :-
    product_of_digits(N, Product),
    writeln(Product),
    max_odd_prime_divisor(N, MaxOddNotPrimeDivisor),
    writeln(MaxOddNotPrimeDivisor),
    nod(Product, MaxOddNotPrimeDivisor, NOD).

% нахождение максимального нечетного непростого делителя числа
max_odd_prime_divisor(N, MaxDivisor) :-
    N > 1,
    max_odd_prime_divisor(N, N, MaxDivisor).

max_odd_prime_divisor(N, 1, 1) :- !.

max_odd_prime_divisor(N, D, MaxDivisor) :-
    D > 1,
    N mod D =:= 0,
    \+ is_prime(D),
    D mod 2 =\= 0,
    MaxDivisor is D;
    D1 is D - 1,
    max_odd_prime_divisor(N, D1, MaxDivisor).

