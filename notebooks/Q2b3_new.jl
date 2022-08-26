function real_roots_of_quadratic(a, b, c) # what if there is no ::number

    #Start by initializing an empty array
    roots::Array{Float64} = []

    #Compute the discriminant 
    Δ = b^2 - 4a*c #\Delta + [TAB]

    #Based on the sign of the discriminant return 0, 1, or 2 roots.
    if Δ < 0 
        roots = []
    elseif Δ == 0
        roots = [-b/(2a)]
    else
        roots = [-b + √Δ, -b - √Δ] / (2a) #\sqrt + [TAB]
    end
    return roots 
end

examples = [[1,-5,6],[1,2,3],[1,7,0],[2,-9,-11],[3,3,3]]

function print_quadratic_roots(example, roots)
    length(roots) == 0 ? println("has no real roots.") :
    length(roots) == 1 ? println("has the single (real) root $(roots[1])") : println("has the real roots $(roots[1]) and $(roots[2])")
        #***
    return nothing 
end



for example ∈ examples
    roots = real_roots_of_quadratic(example[1], example[2], example[3])
    example[1] == 1 ? print("The equation x² + $(example[2])x + $(example[3]) = 0 ") :
    example[1] == -1 ? print("The equation $(-)x² + $(example[2])x + $(example[3]) = 0 ") :
    print("The equation $(example[1])x² + $(example[2])x + $(example[3]) = 0 ") #\^2 + [TAB] #***
    print_quadratic_roots(example, roots)
end