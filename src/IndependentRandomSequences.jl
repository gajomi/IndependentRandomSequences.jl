module IndependentRandomSequences

using Distributions

import Base: length
import Distributions: _rand!,_logpdf,
                      insupport,
                      mean,var,cov,entropy,
                      mgf,cf

export IIDRandomSequence,INIDRandomSequence

type IIDRandomSequence{S<:ValueSupport,T<:UnivariateDistribution} <: MultivariateDistribution{S}
  d::T
  length::Int64
end
function IIDRandomSequence{T<:UnivariateDistribution}(d::T,length::Int64)
    S = super(T).parameters[2]
    return IIDRandomSequence{S,T}(d,length)
end

length(X::IIDRandomSequence) = X.length

function insupport(X::IIDRandomSequence,x::AbstractVector)
  length(x)==length(X) && all(insupport(X.d,x))
end

_rand!{T<:Real}(X::IIDRandomSequence, x::AbstractVector{T}) = rand!(X.d,x)

function _logpdf{T<:Real}(X::IIDRandomSequence, x::AbstractVector{T})
  return sum(x_i->logpdf(X.d,x_i),x)
end

mean(X::IIDRandomSequence) = mean(X.d)*ones(length(X))
var(X::IIDRandomSequence) = var(X.d)*ones(length(X))
cov(X::IIDRandomSequence) = Diagonal(var(X))
entropy(X::IIDRandomSequence) = entropy(X.d)*length(X)

function mgf(X::IIDRandomSequence, t::AbstractVector)
  prod([mgf(X.d,t_i) for t_i in t])
end
function cf(X::IIDRandomSequence, t::AbstractVector)
  prod([cf(X.d,t_i) for t_i in t])
end


type INIDRandomSequence{S<:ValueSupport,T<:UnivariateDistribution} <: MultivariateDistribution{S}
    distributions::Vector{T}
end
function INIDRandomSequence{T<:UnivariateDistribution}(distributions::Vector{T})
    S = super(T).parameters[2]
    return INIDRandomSequence{S,T}(distributions)
end

length(X::INIDRandomSequence) = length(X.distributions)

function insupport(X::INIDRandomSequence,x::AbstractVector)
  length(x)==length(X) && all(dx->insupport(dx[1],dx[2]),zip(X.distributions,x))
end

function _rand!{T<:Real}(X::INIDRandomSequence, x::AbstractVector{T})
  for (i,d_i) in enumerate(X.distributions)
    x[i] = rand(d_i)
  end
  return x
end

function _logpdf{T<:Real}(X::INIDRandomSequence, x::AbstractVector{T})
  return sum(arg->logpdf(arg[1],arg[2]),zip(X.distributions,x))
end

mean(X::INIDRandomSequence) = Float64[mean(d_i) for d_i in X.distributions]
var(X::INIDRandomSequence) = Float64[var(d_i) for d_i in X.distributions]
cov(X::INIDRandomSequence) = Diagonal(var(X))
entropy(X::INIDRandomSequence) = sum(entropy,X.distributions)

function mgf(X::IIDRandomSequence, t::AbstractVector)
  prod([mgf(d_i,t_i) for (d_i,t_i) in zip(X.distributions,t)])
end
function cf(X::IIDRandomSequence, t::AbstractVector)
  prod([cf(d_i,t_i) for (d_i,t_i) in zip(X.distributions,t)])
end

end # module
