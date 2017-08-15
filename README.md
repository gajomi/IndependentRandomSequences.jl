# IndependentRandomSequences

[![Build Status](https://travis-ci.org/gajomi/IndependentRandomSequences.jl.svg?branch=master)](https://travis-ci.org/gajomi/IndependentRandomSequences.jl)

This package implements distribution types (in the vein of the [Distributions](https://github.com/JuliaStats/Distributions.jl) package) for independent random sequences.  These sequences can have elements which are identically distributed (IID) or with elements with non necessarily identically distributed (INID) elements.

## Types
The distributions types (``IIDRandomSequence`` and ``INIDRandomSequence``)are vector valued random variables (``MultivariateDistribution`` in the parlance of ``Distributions``). 

## Basic Usage

To create an IID random sequence and compute some quantities of interest:

```julia
julia> using Distributions
julia> using IndependentRandomSequences

julia> srand(163)
julia> W,N = Uniform(-1,1),3
julia> Y = IIDRandomSequence(W,N)

julia> show(rand(Y))  
[-0.404987, 0.633975, 0.308448]

julia> entropy(Y)
2.0794415416798357
```

The approach is similar for INID random sequences:
```julia
julia> using Distributions
julia> using IndependentRandomSequences
julia> srand(163)
julia> W,X = Bernoulli(.3),Bernoulli(.8)
julia> Y = INIDRandomSequence([W,X])

julia> rand(Y,10)  
 2×10 Array{Int64,2}:
  1  0  0  0  0  0  0  0  0  0
  0  1  1  0  1  1  1  1  1  1

julia> cov(Y)
 2×2 Diagonal{Float64}:
  0.21   ⋅  
   ⋅    0.16
```

However, it should be noted that INID random sequence can be composed of heterogenous univariate distribution types
```julia
julia> using Distributions
julia> using IndependentRandomSequences

julia> srand(163)
julia> W,X = Binomial(3,.5),Bernoulli(.5)
julia> Y = INIDRandomSequence([W,X])

julia> rand(Y,10)
 2×10 Array{Int64,2}:
  3  1  1  2  1  2  0  3  2  1
  1  0  0  0  0  1  0  0  0  1
```

## Why would anyone need this package?

By itself, this package allows one to save just a bit of typing when sampling from and computing quantities of interest for independent random sequences. More importantly, however, it provides a specification of IID/INID types to be used in other packages, which may implement non-trivial functionality. Actual and possible examples include:
- [order statistics of independent random variables (OrderStatistics.jl)](https://github.com/gajomi/OrderStatistics.jl)
- Basic arithmetic for independent random variables (coming soon)
- As containers for affine transformed INID sequence in the sense of [independent component analysis](https://en.wikipedia.org/wiki/Independent_component_analysis)
