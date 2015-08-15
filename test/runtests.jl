using Distributions
using IndependentRandomSequences
using Base.Test


#IID tests
W = Uniform(-1,1)
N = 2
Y = IIDRandomSequence(W,N)

@test pdf(Y,[0., 0.]) == 1/4
@test pdf(Y,[2., 0.]) == 0.
@test pdf(Y,[0. 0. ; 2. 0.]') == [1/4, 0.]

@test mean(Y) == [0., 0.]
@test var(Y) == [1/3, 1/3]

#INID tests
W,X = Uniform(-1,1),Uniform(0,1)
Y = INIDRandomSequence([W,X])

@test pdf(Y,[0., 1/2]) == 1/2
@test pdf(Y,[2., 1/2]) == 0.
@test pdf(Y,[0. 1/2;  2. 0.]') == [1/2, 0.]

@test mean(Y) == [0., 1/2]
@test var(Y) == [1/3, 1/12]
