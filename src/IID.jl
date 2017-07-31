type IIDRandomSequence{S<:ValueSupport,T<:UnivariateDistribution} <: MultivariateDistribution{S}
  d::T
  length::Int64
end
function IIDRandomSequence{T<:UnivariateDistribution}(d::T,length::Int64)
    S = supertype(T).parameters[2]
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
