module IndependentRandomSequences

using Distributions

import Base: length
import Distributions: _rand!,_logpdf,
                      insupport,
                      mean,var,cov,entropy,
                      mgf,cf

export IIDRandomSequence,INIDRandomSequence

include("IID.jl")
include("INID.jl")

end # module
