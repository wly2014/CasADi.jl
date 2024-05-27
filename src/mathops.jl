## Unary operations
-(x::C) where C <: CasadiSymbolicObject = pycall(casadi.minus, C, 0, x)

Base.:-(xs::AbstractVector{C}) where C <: CasadiSymbolicObject = 
        length(xs) == 0 ? SX[] : map(xs) do x pycall(casadi.minus, C, 0, x) end

## Binary operations
+(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.plus, C, x, y)
-(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.minus, C, x, y)
/(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.mrdivide, C, x, y)
^(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.power, C, x, y)
^(x::C, y::Integer) where C <: CasadiSymbolicObject = pycall(casadi.power, C, x, y)
\(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.solve, C, x, y)

function *(x::C, y::Real) where C <: CasadiSymbolicObject
    if size(x,2) == size(y,1)
        pycall(casadi.mtimes, C, x, y)
    else 
        pycall(casadi.times, C, x, y)
    end
end

## Comparisons
>=(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.ge, C, x, y)
>(x::C, y::Real)  where C <: CasadiSymbolicObject = pycall(casadi.gt, C, x, y)
<=(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.le, C, x, y)
<(x::C, y::Real)  where C <: CasadiSymbolicObject = pycall(casadi.lt, C, x, y)
==(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.eq, C, x, y)

## Linear algebra
×(x::C, y::Real) where C <: CasadiSymbolicObject = pycall(casadi.cross, C, x, y)


# TODO: 修改为transpose
# Base.inv(r::RotMatrix{N,T,L}) where {N,T,L} = RotMatrix(SMatrix{N, N, T, L}(r.mat[1],r.mat[4],r.mat[7],r.mat[2],r.mat[5],r.mat[8],r.mat[3],r.mat[6],r.mat[9]))
