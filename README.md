# IndependentRandomSequences

This package implements distribution types (in the vein of the [Distributions](https://github.com/JuliaStats/Distributions.jl) package) for independent random sequences.  These sequences can have elements which are identically distributed (IID) or with elements with non necessarily identically distributed (INID) elements.

##Types
The distributions are vector valued random variables (``MultivariateDistribution`` in the parlance of ``Distributions``). Currently the functionality is limited to sequences of univariate random variables.

* ``IIDRandomSequence{S<:ValueSupport,T<:UnivariateDistribution} <: MultivariateDistribution{S}``
* ``INIDRandomSequence{S<:ValueSupport,T<:UnivariateDistribution} <: MultivariateDistribution{S}``

## Basic Usage

To create an iid random sequence and compute some quantities of interest

```julia
>>> W,N = Uniform(-1,1),3
>>> Y = IIDRandomSequence(W,N)
    IIDRandomSequence{Continuous,Uniform}(
    d: Uniform(a=-1.0, b=1.0)
    length: 3)
>>> rand(Y)  
    IIDRandomSequence{Continuous,Uniform}(
    d: Uniform(a=-1.0, b=1.0)
    length: 3)
>>> entropy(Y)
    1.0008048470763757
```

Similar deal for inid random sequence
```julia
>>> W,X = Bernoulli(.3),Bernoulli(.8)
>>> Y = INIDRandomSequence([W,X])
    IIDRandomSequence{Continuous,Uniform}(
    d: Uniform(a=-1.0, b=1.0)
    length: 3)
>>> rand(Y,10)  
    2x10 Array{Int64,2}:
      1  1  0  0  0  0  1  0  0  0
      1  1  1  1  1  1  0  1  1  1
>>> cov(Y)
    2x2 Diagonal{Float64}:
      0.21  0.0
      0.0   0.16
```

##Why would anyone need this package?

By itself, this package may allow us to save just a bit of type when sampling from and computing quantities of interest for independent random sequences. More importantly, however, it provides a specification of IID/INID types to be used in other packages, which may implement non-trivial functionality. Actual and possible examples include:
- [order statistics of independent random variables (OrderStatistics.jl)](https://github.com/gajomi/OrderStatistics.jl)
- Basic arithmetic for independent random variables (coming soon)
- As containers for affine transformed INID sequence in the sense of [independent component analysis](https://en.wikipedia.org/wiki/Independent_component_analysis)

##Installation

This package isn't registered yet, but can be installed by the [``Pkg.clone(url)``](http://julia.readthedocs.org/en/latest/manual/packages/#installing-unregistered-packages) mechanism.

[![Build Status](https://travis-ci.org/gajomi/IndependentRandomSequences.jl.svg?branch=master)](https://travis-ci.org/gajomi/IndependentRandomSequences.jl)
