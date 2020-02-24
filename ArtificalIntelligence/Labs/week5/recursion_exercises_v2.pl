path(a,b).
path(b,c).
path(c,d).
path(a,d).
path(d,e).

has_service(c,pub).
has_service(e,hospital).

can_get(X,Y) :- path(X,Y).

can_get(X,Y) :- path(X,A),can_get(A,Y).

access_service(X,Y) :- has_service(X,Y).

access_service(X,Y) :- can_get(X,A),has_service(A,Y).