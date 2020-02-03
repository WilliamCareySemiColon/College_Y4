wizard(harry).
scare(hagrid,dudley).
magical(X) :- wizard(X).
hate(uncle_vernon,X) :- magical(X).
hate(aunt_petunia,X) :- magical(X).
hate(aunt_petunia,X) :- scare(X,dudley).