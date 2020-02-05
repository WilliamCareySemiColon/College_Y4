father(albert,james).
father(james,harry).
mother(ruth,james).
mother(lili,harry).

wizard(lili).
wizard(ruth).
wizard(albert).

%% X is a wizard if both X's mother or father are wizards
wizard(X) :- 
	(father(Y,X), wizard(Y));
	(mother(Z,X), wizard(Z)).