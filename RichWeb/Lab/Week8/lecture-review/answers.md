###Lecture review Questions

**Question 1 Solution**
Stream Abstraction is the process of getting data from a sources and destinations that are abstract. This means either are not known completely nor have to come from a specific concrete areas.

The relationship between the Stream and the observable pattern is the stream is a facilator of the data connected from the producer to
subscriber. The data in question is maintained by the obserable pattern. In short, the stream is an implementation of the observer pattern when the data is realised. 

Streams are useful for modelling when you are unsure of the data require for application but at the same time understand the possibility of the file being initally file is too large to process so we process in bits instead. You would mainly use them in the application when
an image or video record is being processed into the application, as to allow the application to continously run smooth while the file is
being imported.

**Question 2 Solution**
I would use the RxJS library to redirect its async calls to the interface rather then to the API, as this would be better practise for the software due to better maintainablility and decoupling of the application. This way, I know all the information can come from the one area that deals with the Api rather then finding out why the RxJs are not working with the numerous API requests. 

I think the postive would be streams are better then promises at processing larger files better without reducing the proformance of the application itself combined with the reduced need to know exactly where the information is coming from as the RxJS handles that for us.

The negative would be the information may not be exactly what we are looking for with Streams but we are ganrunteed to get the information needed from a Promise.

**Question 3 Solution**
The consquence of sharing global state is the mix between the information which would be confusing to the reader and harder for the developer in maintence purpose. Another major situation would be if one aspect fails or modifies key information, the others are impacted by that effect, which would ake them redundant or broken.

A good practise to alleviate any of these would be to remove the global aspect into the respective areas which async task A,B and C relate to and decouply them. This would ensure if one fails, the others are not impacted. At worst case, if it is necessary to separate the concerns of A, B and C, duplicate the information across all three and ensure the three fields are up to date with each other to optimise the async tasks. 