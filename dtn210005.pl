
%1
list_prod([], 1).
list_prod([H|T], Product) :-
    list_prod(T, Temp),
    Product is H * Temp.
%2
dvd(X,Y) :-
    0 is X mod Y, !.

dvd(X,Y) :-
    X > Y+1, dvd(X, Y+1).

is_prime(2) :-
    true, !.

is_prime(X) :-
    X < 2,!,false.

is_prime(Num) :- 
    not(dvd(Num, 2)).
%3
findSecondMin([], _, Second, Second).

findSecondMin([H|_], _, _, _) :-
     \+ integer(H),
    format("ERROR: ~w is not a number.~n", [H]),
    !, fail.

findSecondMin([H|T], Min, Second, SecondMin) :-
    (H < Min ->
        NewMin = H,
        NewSecond = Min
    ; H < Second, H \= Min ->
        NewMin = Min,
        NewSecond = H
    ;
        NewMin = Min,
        NewSecond = Second
    ),
    findSecondMin(T, NewMin, NewSecond, SecondMin).

secondMin(List, _) :-
    length(List, Length),
    Length < 2,
    format("ERROR: List has fewer than two unique elements. ~n"), !, fail.

secondMin([X, Y | T], SecondMin) :-
    (X < Y -> Min = X, Second = Y ; Min = Y, Second = X),
    findSecondMin(T, Min, Second, SecondMin).

even(X) :- 0 is X mod 2.

string(X) :- atom(X).

classify(Pred, List, List1, List2) :-
    classify_helper(Pred, List, [], [], List1Rev, List2Rev),
    reverse(List1Rev, List1),
    reverse(List2Rev, List2).

classify_helper(_, [], TrueAcc, FalseAcc, TrueAcc, FalseAcc).

classify_helper(Pred, [H | T], TrueAcc, FalseAcc, List1, List2) :-
    ( call(Pred, H) ->
        classify_helper(Pred, T, [H | TrueAcc], FalseAcc, List1, List2)
    ;
        classify_helper(Pred, T, TrueAcc, [H | FalseAcc], List1, List2)
    ).

%5
bookends(Prefix, Suffix,List) :-
    append(Prefix, Temp, List),
    append(_, Suffix, Temp).

%6
subslice(Sub, List) :-
    append(_, Sub, List).
%7
rotate(InputList, Integer, RotatedList) :-
    length(Back, Integer),
    append(Front, Back, InputList),
    append(Back, Front, RotatedList).
%8
luhn_check([], _, Sum, Sum).
luhn_check([C|Cs], Pos, Acc, Sum) :-
    char_type(C, digit(Digit)),
    (Pos mod 2 =:= 0 ->
        (Digit * 2 < 10 -> NewDigit is Digit * 2 ; NewDigit is Digit * 2 - 9)
    ;
        NewDigit is Digit
    ),
    NewAcc is Acc + NewDigit,
    NewPos is Pos + 1,
    luhn_check(Cs, NewPos, NewAcc, Sum).    

luhn(Integer) :-
    number_chars(Integer, Chars),
    reverse(Chars, Reversed), 
    luhn_check(Reversed, 1,0, Sum),
    Sum mod 10 =:= 0.

%9
select([A|As], S) :- select(A, S, S1), select(As, S1).
select([], _).

next_to(A, B, C) :- left_of(A, B, C) ; left_of(B, A, C).
left_of(A, B, C) :- append(_, [A, B | _], C).

black(Solution, Pos) :- nth1(Pos, Solution, h(_, _, _, _, black)).
denmark(Solution, Pos) :- nth1(Pos, Solution, h(_, _, denmark, _, _)).
austria(Solution, Pos) :- nth1(Pos, Solution, h(_, _, austria, _, _)).
slovakia(Solution, Pos) :- nth1(Pos, Solution, h(_, _, slovakia, _, _)).
ireland(Solution, Pos) :- nth1(Pos, Solution, h(_, _, ireland, _, _)).
croatia(Solution, Pos) :- nth1(Pos, Solution, h(_, _, croatia, _, _)).
heavy_metal(Solution, Pos) :- nth1(Pos, Solution, h(_, _, _, heavy_metal, _)).
gothic(Solution, Pos) :- nth1(Pos, Solution, h(_, _, _, gothic, _)).
psychedelic(Solution, Pos) :- nth1(Pos, Solution, h(_, _, _, psychedelic, _)).

yellow(Solution, Pos) :- nth1(Pos, Solution, h(_, _, _, _, yellow)).
blue(Solution, Pos) :- nth1(Pos, Solution, h(_, _, _, _, blue)).
green(Solution, Pos) :- nth1(Pos, Solution, h(_, _, _, _, green)).

followers(Solution, Number, Pos) :- nth1(Pos, Solution, h(_, Number, _, _, _)).
start_year(Solution, Year, Pos) :- nth1(Pos, Solution, h(Year, _, _, _, _)).

bands(Solution) :-
    Solution = [_, _, _, _, _], 
    Solution = [h(_, _, _, progressive_rock, _) | _],
    nth1(4, Solution, h(2009, _, _, _, _)),
    followers(Solution, 150000, P150),
    austria(Solution, PAus),
    next_to_pos(P150, PAus),
    austria(Solution, PAus2),
    denmark(Solution, PDen),
    PAus2 is PDen - 1,
    slovakia(Solution, PSlo),
    ireland(Solution, PIre),
    PSlo is PIre - 1,
    gothic(Solution, PGoth),
    PGoth is PSlo + 1,
    start_year(Solution, 2008, P2008),
    black(Solution, PBlack),
    start_year(Solution, 2000, P2000),
    P2008 < PBlack, PBlack < P2000,
    start_year(Solution, 2000, P2000b),
    green(Solution, PGreen),
    next_to_pos(P2000b, PGreen),
    black(Solution, PBlack2),
    heavy_metal(Solution, PHeavy),
    PBlack2 < PHeavy,
    start_year(Solution, 2008, P2008b),
    followers(Solution, 300000, P300k),
    followers(Solution, 250000, P250k),
    P2008b < P300k, P300k < P250k,
    yellow(Solution, PYellow),
    followers(Solution, 50000, P50k),
    followers(Solution, 300000, P300k2),
    PYellow < P50k, P50k < P300k2,
    start_year(Solution, 2015, P2015),
    start_year(Solution, 2000, P2000c),
    start_year(Solution, 2009, P2009),
    P2015 < P2000c, P2000c < P2009,
    yellow(Solution, PYellow2),
    start_year(Solution, 2009, P2009b),
    start_year(Solution, 2005, P2005),
    PYellow2 < P2009b, P2009b < P2005,
    croatia(Solution, PCro),
    blue(Solution, PBlue),
    PCro < PBlue,
    blue(Solution, PBlue2),
    psychedelic(Solution, PPsy),
    PBlue2 < PPsy,
    black(Solution, PBlack3),
    followers(Solution, 50000, P50k2),
    PBlack3 < P50k2.

next_to_pos(X, Y) :- abs(X - Y) =:= 1.
