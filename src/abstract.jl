abstract type
    AbstractIDSequence{S<:ValueSupport} <: MultivariateDistribution{S}
end

length(X::AbstractIDSequence) = length(distributions(X))

function insupport(X::AbstractIDSequence,x::AbstractVector)
  length(x)==length(X) && all(dx->insupport(dx[1],dx[2]),zip(distributions(X),x))
end

function _rand!{T<:Real}(X::AbstractIDSequence, x::AbstractVector{T})
  for (i,d_i) in enumerate(distributions(X))
    x[i] = rand(d_i)
  end
  return x
end

function _logpdf{T<:Real}(X::AbstractIDSequence, x::AbstractVector{T})
  return sum(arg->logpdf(arg[1],arg[2]),zip(distributions(X),x))
end

mean(X::AbstractIDSequence) = Float64[mean(d_i) for d_i in distributions(X)]
var(X::AbstractIDSequence) = Float64[var(d_i) for d_i in distributions(X)]
cov(X::AbstractIDSequence) = Diagonal(var(X))
entropy(X::AbstractIDSequence) = sum(entropy,distributions(X))

function mgf(X::AbstractIDSequence, t::AbstractVector)
  prod([mgf(d_i,t_i) for (d_i,t_i) in zip(distributions(X),t)])
end
function cf(X::AbstractIDSequence, t::AbstractVector)
  prod([cf(d_i,t_i) for (d_i,t_i) in zip(distributions(X),t)])
end
