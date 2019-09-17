foo = [25,68, "bar", 89.45,789,"spam",0,"last item"]

print(foo[0])

print(foo[len(foo) - 1])

print(foo[:3])

print(foo[2:])

print(foo[1:-1])

arr = foo

print(arr)

#Comment - Lab work here

foo[0] = 12

foo[0] = foo[0] * 2

"ham" in foo

len(foo)

foo.append(24)

foo.insert(3,"twenty")

print(foo.index("spam"))

anT = list.pop(foo)

print(foo)

print(anT)
