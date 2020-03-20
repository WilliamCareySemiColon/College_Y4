isa(sam,seal).
isa(bob,penguin).
isa(opus,penguin).
isa(twenty,canary).
isa(ken,canary).
isa(seal,seacreature).
isa(penguin,seacreature).
isa(penguin,bird).
isa(canary,bird).

hasfeature(penguin,walks).
hasfeature(seacreature,swims).
hasfeature(canary,flys).
hasfeature(bird,feathers).
hasfeature(bird,wings).

species(X,Y) :- isa(X,Z),isa(Y,Z).

hasproperty(X,Y) :- hasfeature(X,Y).

hasproperty(X,Y) :- isa(X,Z), hasproperty(Z,Y).