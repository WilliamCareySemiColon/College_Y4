path(a,b).
path(b,c).
path(c,d).
path(d,e).

can_get(X,Y) :- path(X,Y).

can_get(X,Y) :- path(X,A),can_get(A,Y).