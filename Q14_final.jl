#Method 1
#care that I - P is singular that means that there is no inverse to the matrix
using LinearAlgebra
#This function creates LxL dimension matrix P
function structured_P(L::Int; p::Float64 = 0.45, r::Float64 = 0.01)::Matrix{Float64}
    q = 1 - p - r
    P = diagm(fill(r,L)) + diagm(-1=>fill(q,L-1)) + diagm(1 => fill(p,L-1))
    P[1,1] = 1-p
    P[L,L] = 1-q
    return P
end
# creaats L vector pi that matches P
structured_π(L::Int; p::Float64 = 0.45, r::Float64 = 0.01)::Vector{Float64} = begin
    q = 1 - p - r
    [(p/q)^i  for i in 1:L] * (q-p) / p / (1-(p/q)^L) #Explicit expression (birth death)
end;

function Linear_op(L::Int; p::Float64 = 0.45, r::Float64 = 0.01)
    A = vcat(structured_P(L), ones(1,L)) #A is matrix added another row of ones to P
    b = vcat(structured_π(L), ones(1,1)) #b is the pi vector and add another 1 at the bottom
    π_origin = structured_π(L)
    #This allows a linear system to be determined
    #Let x be the solution to estimate pi 
    x = \(A, b) #This allow the estimation of pi from solving linear system 
    #finding the least square between the two
    # @show (π_origin .- x).^2
return x
# sum((π_origin .- x).^2)
end 
for L ∈ [2, 3, 5, 10, 20, 30, 40, 50, 100, 200, 300, 400, 500, 1000]
   @show Linear_op(L)
   @show norm(Linear_op(L) - structured_π(L))
end

#Method 2
function Limits_op(L::Int; p::Float64 = 0.45, r::Float64 = 0.01)
    n=10^10 #define a really large number 
    # π_leg = Array{Float64}(undef, L)
    π_est = Array{Float64}(undef, L)
    P_n = (structured_P(L)')^n #This line give the matrix to the power clsoe to infinity
    for i ∈ 1:L
        π_est[i] = P_n[i,1]
        # π_leg[i] = structured_π(L)[i] #since all the rows values will converge to the same thing
    end 
    return π_est
end 
for L ∈ [2, 3, 5, 10, 20, 30, 40, 50, 100, 200, 300, 400, 500, 1000]
    @show Limits_op(L)
    @show norm(Limits_op(L)-structured_π(L))
 end# @show Limits_op(5)
# @show sum(P_n, dims = 1) #sum of column

#method 3
function eigen_π(L::Int; p::Float64 = 0.45, r::Float64 = 0.01)
    e_vector = Array{Float64}(undef, L)
    cor_vector = Array{Vector{Float64}}(undef, L)
    d_repeat = repeat([1], L)
    for i ∈ 1:L
        e_vector[i] = eigvecs(structured_P(L))[i]
        @show e_vector
        if structured_P(L)*(e_vector[i]) == Diagonal(d_repeat)*(e_vector[i]) 
            cor_vector = push!(cor_vector, e_vector[j])
        end
    # @show Diagonal(d_repeat)*(e_vector[i])
   
    # @show eigvecs(structured_P(L)[1 , eigvals])
    end
    return cor_vector 
end
@show eigen_π(2)

