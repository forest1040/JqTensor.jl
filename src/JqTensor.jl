module JqTensor

using ITensors, LinearAlgebra, Random

import Base: length,
			 copy,
			 push!,
			 isless,
			 delete!,
			 getindex,
			 setindex,
			 findfirst,
			 deleteat!,
			 print,
			 show,
			 replace!,
			 reverse,
			 size,
			 +,
			 -,
			 *,
			 /,
			 ==,
			 isapprox,
			 pop!,
			 range,
			 clamp
import LinearAlgebra: norm,
					  normalize!
import ITensors:getindex,
				 noprime,
				 noprime!,
				 prime,
				 svd,
				 qr,
				 position!,
				 setindex!,
				 commonindex,
				 iterate,
				 ITensor,
				 Index,
				 norm,
				 order,
				 *,
				 dag

# functions from Base, ITensors
export linkindex,
	   getindex,
	   noprime,
	   noprime!,
	   prime,
	   svd,
	   position!,
	   setindex!,
	   svd,
	   commonindex,
	   leftLim,
	   rightLim,
	   iterate,
	   ITensor,
	   Index,
	   randomITensor,
	   qr,
	   IndexSet,
	   order,
	   norm

end
