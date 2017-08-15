
type INIDRandomSequence{S<:ValueSupport,T<:UnivariateDistribution} <: MultivariateDistribution{S}
    distributions::Vector{T}
end
function INIDRandomSequence{T<:UnivariateDistribution}(distributions::Vector{T})
    S = supertype(T).parameters[2]
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

function mgf(X::INIDRandomSequence, t::AbstractVector)
  prod([mgf(d_i,t_i) for (d_i,t_i) in zip(X.distributions,t)])
end
function cf(X::INIDRandomSequence, t::AbstractVector)
  prod([cf(d_i,t_i) for (d_i,t_i) in zip(X.distributions,t)])
end
