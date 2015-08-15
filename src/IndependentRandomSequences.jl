module IndependentRandomSequences

using Distributions

import Base: length
import Distributions: _rand!,_logpdf,
                      mean,var,cov,entropy

export IIDRandomSequence,INIDRandomSequence

#abstract AbstractINIDRandomSequence

type IIDRandomSequence{T<:ContinuousUnivariateDistribution} <: ContinuousMultivariateDistribution
  d::T
  length::Int64
end

length(X::IIDRandomSequence) = X.length

_rand!{T<:Real}(X::IIDRandomSequence, x::AbstractVector{T}) = rand!(X.d,x)

function _logpdf{T<:Real}(X::IIDRandomSequence, x::AbstractVector{T})
  return sum(x_i->logpdf(X.d,x_i),x)
end

mean(X::IIDRandomSequence) = mean(X.d)*ones(length(X))
var(X::IIDRandomSequence) = var(X.d)*ones(length(X))
cov(X::IIDRandomSequence) = Diagonal(var(X))
entropy(X::IIDRandomSequence) = entropy(X.d)*length(X)



type INIDRandomSequence <: ContinuousMultivariateDistribution
    distributions::Vector
end

length(X::INIDRandomSequence) = length(X.distributions)

function _rand!{T<:Real}(X::INIDRandomSequence, x::AbstractVector{T})
  for (i,d_i) in enumerate(X.distributions)
    x[i] = rand(d_i)
  end
  return x
end

function _logpdf{T<:Real}(X::INIDRandomSequence, x::AbstractVector{T})
  return sum(arg->logpdf(arg[1],arg[2]),zip(X.distributions,x))
end

mean(X::INIDRandomSequence) = [mean(d_i) for d_i in X.distributions]
var(X::INIDRandomSequence) = [var(d_i) for d_i in X.distributions]
cov(X::INIDRandomSequence) = Diagonal(var(X))
entropy(X::INIDRandomSequence) = sum(entropy,X.distributions)


end # module
