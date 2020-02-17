female(helen).
female(ruth).
female(petunia).
female(lili).

male(paul).
male(albert).
male(vernon).
male(james).
male(dudley).
male(harry).

parent_of(paul,petunia).
parent_of(helen,petunia).
parent_of(paul,lili).
parent_of(helen,lili).
parent_of(albert,james).
parent_of(ruth,james).
parent_of(petunia,dudley).
parent_of(vernon,dudley).
parent_of(lili,harry).
parent_of(james,harry).

father_of(X,Y) :- male(X),
                  parent_of(X,Y).
mother_of(X,Y) :- female(X),
                  parent_of(X,Y).

grandfather_of(X,Y) :- father_of(X,Z),
                       parent(Z,Y).
grandmother_of(X,Y) :- mother_of(X,Z),
                       parent(Z,Y).

sister_of(X,Y) :- female(X),
                  parent_of(Z,X),
                  parent_of(Z,Y).
brother_of(X,Y) :- male(X),
                   parent_of(Z,X),
                   parent_of(Z,Y).

aunt_of(X,Y) :- sister_of(X,Z),
                parent_of(Z,Y).
uncle_of(X,Y) :- brother_of(X,Z),
                 parent_of(Z,Y).