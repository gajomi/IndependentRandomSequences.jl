using Distributions
using IndependentRandomSequences
using Base.Test


#IID tests
W = Uniform(-1,1)
N = 2
Y = IIDRandomSequence(W,N)

@test insupport(Y,[0,0]) == true
@test insupport(Y,[-1,1]) == true
@test insupport(Y,[-2,0]) == false
@test insupport(Y,[0,0,0]) == false

@test pdf(Y,[0., 0.]) == 1/4
@test pdf(Y,[2., 0.]) == 0.
@test pdf(Y,[0. 0. ; 2. 0.]') == [1/4, 0.]

@test mean(Y) == [0., 0.]
@test var(Y) == [1/3, 1/3]

#INID tests, homogenous types
W,X = Uniform(-1,1),Uniform(0,1)
Y = INIDRandomSequence([W,X])

@test insupport(Y,[0,0]) == true
@test insupport(Y,[-1,1/2]) == true
@test insupport(Y,[-2,0]) == false
@test insupport(Y,[0,0,0]) == false

@test pdf(Y,[0., 1/2]) == 1/2
@test pdf(Y,[2., 1/2]) == 0.
@test pdf(Y,[0. 1/2;  2. 0.]') == [1/2, 0.]

@test mean(Y) == [0., 1/2]
@test var(Y) == [1/3, 1/12]

#INID test, hetergeneous types
W,X = Binomial(3,.5),Bernoulli(.5)
Y = INIDRandomSequence([W,X])

@test insupport(Y,[3,0]) == true
@test insupport(Y,[-2,0]) == false
@test insupport(Y,[0,0,0]) == false

@test cov(Y) == [3/4 0;0 1/4]
