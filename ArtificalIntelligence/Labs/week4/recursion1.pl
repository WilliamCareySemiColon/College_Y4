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

father_of(X,Y) :- parent(X,Y) , male(X), different(X,Y).
mother_of(X,Y) :- parent(X,Y), female(X), different(X,Y).

grandfather_of(X,Y) :- father_of(X,Z),father_of(Z,Y),different(X,Y).

grandmother_of(X,Y) :- mother_of(X,Z),mother_of(Z,Y),different(X,Y).

sister_of(X,Y) :- (
	(father_of(Z,X), father_of(Z,Y)) ; (mother_of(Z,X), mother_of(Z,Y))
	), different(X,Y), female(X).
	
brother_of(X,Y) :- (
	(father_of(Z,X), father_of(Z,Y)) ; (mother_of(Z,X), mother_of(Z,Y))
	), different(X,Y), male(X).
	
aunt_of(X,Y) :- sister_of(X,Z), (father_of(Z,Y) ; mother_of(Z,Y)),different(X,Y).

uncle_of(X,Y) :- brother_of(X,Z), (father_of(Z,Y) ; mother_of(Z,Y)),different(X,Y).