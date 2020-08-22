-module(demo).
-export([bump/1, average/1, sum/1, len/1, member/2]).

bump([]) -> [];
bump([Head | Tail]) -> [Head + 1 | bump(Tail)].

average(List) -> sum(List) / len(List).

sum([]) -> 0;
sum([Head | Tail]) -> Head + sum(Tail).

len([]) -> 0;
len([_ | Tail]) -> 1 + len(Tail).

member(_, []) -> false;
member(H, [H | _]) -> true;
member(H, [_ | T]) -> member(H, T).
