## promote up to symbolic so that mathops work
promote_rule(::Type{T}, ::Type{S}) where {T <: CasadiSymbolicObject, S <: Real} = T
convert(::Type{PyObject}, s::CasadiSymbolicObject) = s.__pyobject__

convert(::Type{T}, o::Number) where {T <: CasadiSymbolicObject} = casadi.SX(o)

Base.promote_op(::O,::Type{C}) where {O, C <: CasadiSymbolicObject} = SX   # 用于Transpose中的操作
# for test: CasADi.SX[1 2;3 4] * CasADi.SX[1 2;3 4]
Base.promote_op(::O, ::Type{S}, ::Type{C}) where {O,C <: CasadiSymbolicObject, S <: Number} = CasADi.SX
Base.promote_op(::O, ::Type{C}, ::Type{S}) where {O,C <: CasadiSymbolicObject, S <: Number} = CasADi.SX
Base.promote_op(::O, ::Type{C}, ::Type{C}) where {O,C <: CasadiSymbolicObject} = CasADi.SX # This helps out linear alg

"""

Convert a numeric CasADi value to a numeric Julia value.

"""
function to_julia(x::CasadiSymbolicObject)
    if size(x,1) == 1 && size(x,2) == 1
        return casadi.evalf(x).toarray()[1]
    end
    if size(x,2) == 1
        return casadi.evalf(x).toarray()[:]
    end

    return reshape( casadi.evalf(x).toarray(), size(x) )
end
