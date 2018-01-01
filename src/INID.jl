type INIDRandomSequence{S<:ValueSupport,T<:UnivariateDistribution} <: AbstractIDSequence{S}
    distributions::Vector{T}
end
function INIDRandomSequence{T<:UnivariateDistribution}(distributions::Vector{T})
    S = supertype(T).parameters[2]
    return INIDRandomSequence{S,T}(distributions)
end

distributions(X::INIDRandomSequence) = X.distributions
