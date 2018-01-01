module IndependentRandomSequences

using Distributions

import Base: length
import Distributions: _rand!,_logpdf,
                      insupport,
                      mean,var,cov,entropy,
                      mgf,cf

export IIDRandomSequence,INIDRandomSequence,AbstractIDSequence,distributions

include("abstract.jl")
include("IID.jl")
include("INID.jl")

end
