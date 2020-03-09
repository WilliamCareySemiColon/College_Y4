as_in(Node) :- Node = [].

as_in(Node) :- Node = [Head|Tail], Head = 'a',as_in(Tail).

replace_a_b_c(InputList,OutputList) :- InputList = [],OutputList = [].

replace_a_b_c(InputList,OutputList) :- 
    InputList = [IN_Head|IN_Tail],
    OutputList = [Out_Head|Out_Tail],
    nl,
    write(InputList),
    (
        (IN_Head = 'a', Out_Head = 'b'); (IN_Head = 'b', Out_Head = 'c');(IN_Head = 'c', Out_Head = 'a')
    ),
    replace_a_b_c(IN_Tail,Out_Tail).