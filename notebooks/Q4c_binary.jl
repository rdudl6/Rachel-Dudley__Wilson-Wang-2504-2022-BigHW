import Base: parse

function convert_bin(x::String)
    
y = parse(Int, x)
binary_as_num = 0
base = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048]
    
    for i in base
        
        remainder = y % 10                   #for calculating the value of the last digit
        binary_as_num += (remainder * i)
        y = floor(y/10)                      #gets rid of the last digit so now the next one can be valued
              

    end
    
return binary_as_num
    
end

using Random
Random.seed!(0)
random_binary_string(n = 12) = *([rand(['0','1']) for _ in 1:n]...)
r_bin_strs = [random_binary_string() for _ in 1:10^3]

array_bin_4c= Array{Int64}(undef, length(r_bin_strs))
for i ∈ 1:length(r_bin_strs)
    array_bin_4c[i] = convert_bin(r_bin_strs[i])
end
println("The sum of the binary from our implementations is ", sum(array_bin_4c), " compare to our prediction of 2047500 is a pretty good estimate") 