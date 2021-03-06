# Test of reduction on scalar backend

# Unit testing for element-wise expressions on scalar backend

import Devectorize
import Devectorize.@devec
import Devectorize.@inspect_devec
import Devectorize.dump_devec
import Devectorize.sqr

using Base.Test


# data

a = [3., 4., 5., 6., 8., 7., 6., 5.]
b = [9., 8., 7., 6., 4., 2., 3., 1.]
c = [1., 2., 4., 3., 5., 7., 6., 8.]
abc = [a b c]

#################################################
#
#   full reduction
#
#################################################

r = zeros(1)
@devec r = sum(a)
@test isequal(r, sum(a))

@devec r = sum(a[:,:])
@test isequal(r, sum(a))

@devec r = sum(abc[:,:])
@test isequal(r, sum(abc))

@devec r = maximum(a)
@test isequal(r, maximum(a))

@devec r = maximum(c)
@test isequal(r, maximum(c))

@devec r = minimum(a)
@test isequal(r, minimum(a))

@devec r = minimum(c)
@test isequal(r, minimum(c))

@devec r = mean(a)
@test isequal(r, mean(a))

@devec r = mean(abc[:,:])
@test isequal(r, mean(abc))

@devec r = dot(a, b)
@test isequal(r, dot(a, b))

@devec r = dot(a[:,:], b[:,:])
@test isequal(r, dot(a, b))

@devec r = dot(abc[:,:], abc)
@test isequal(r, dot(abc[:], abc[:]))


#################################################
#
#   partial reduction
#
#################################################

@devec r = sum(abc, 1)
@test isequal(r, sum(abc, 1))

@devec r = sum(abc, 2)
@test isequal(r, sum(abc, 2))

r = zeros(size(abc, 2))
r0 = r
@devec r[:] = sum(abc, 1)
@test r === r0
@test isequal(r, vec(sum(abc, 1)))

r = zeros(size(abc, 1))
r0 = r
@devec r[:] = sum(abc, 2)
@test r === r0
@test isequal(r, vec(sum(abc, 2)))

@devec r = mean(abc, 1)
@test isequal(r, sum(abc, 1) / size(abc, 1))

@devec r = mean(abc, 2)
@test isequal(r, sum(abc, 2) / size(abc, 2))

@devec r = maximum(abc, 1)
@test isequal(r, maximum(abc, 1))

@devec r = maximum(abc, 2)
@test isequal(r, maximum(abc, 2))

@devec r = minimum(abc, 1)
@test isequal(r, minimum(abc, 1))

@devec r = minimum(abc, 2)
@test isequal(r, minimum(abc, 2))

@devec r = sum(sqr(abc), 1)
@test isequal(r, sum(abc .* abc, 1))

@devec r = sum(sqr(abc), 2)
@test isequal(r, sum(abc .* abc, 2))



