ancestor_of(X,Y) :- parent(X,Y).
%% X is an ancestor of Y, if X is a parent of Y.
%% (If I am the parent of somebody, I also belong to his ancestors.

ancestor_of(X,Y) :- parent(X,Z), ancestor_of(Z,Y).
%% X is an ancestor of Y, if X is a parent of Z and Z is a 
%% an ancestor of Y.
%% (If I am the parent of somebody and somebody is an ancestor 
%% of a third person, I am also an ancestor of this third person.
    
%%This predicate definition is recursive: the predicate is defined in terms of itself. Recursion is a very useful 
%%concept for Prolog programming and, in fact, programming in general.