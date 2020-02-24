is_in(jane,ella).
is_in(ella,dora).
is_in(dora,cathy).
is_in(cathy,bella).
is_in(bella,anna).

contains(X,Y) :- is_in(Y,X).

contains(X,Y) :- is_in(A,X), contains(A,Y).