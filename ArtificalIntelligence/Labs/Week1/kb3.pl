father(albert,james).
father(james,harry).
mother(ruth,james).
mother(lili,harry).

wizard(lili).
wizard(ruth).
wizard(albert).

%% X is a wizard if both X's mother and father are wizzards
wizard(X) :- 
	father(Y,X),
	wizard(Y),
	mother(Z,X),
	wizard(Z).
