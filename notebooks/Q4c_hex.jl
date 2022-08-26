hex_base = [0:15] #define array of hex number
dict_hex = Array{String}(undef,0) #create an empty array for the hex strings
dict_values = Array{Int64}(undef,0) #create an empty array for the hex number in int
array_base = [16^2, 16^1, 16^0] #the bases of the array for the calculation
A = Array{Int64}(undef,3)
function add_hex_values(dict_hex,dict_values,new_dict_hex,new_dict_values) #function that pair up the values of hex with the the strings
    push!(dict_hex, new_dict_hex)
    push!(dict_values, new_dict_values)
end
#pushing each values and strings into the arraies
add_hex_values(dict_hex,dict_values,"0",0)
add_hex_values(dict_hex,dict_values,"1",1)
add_hex_values(dict_hex,dict_values,"2",2)
add_hex_values(dict_hex,dict_values,"3",3)
add_hex_values(dict_hex,dict_values,"4",4)
add_hex_values(dict_hex,dict_values,"5",5)
add_hex_values(dict_hex,dict_values,"6",6)
add_hex_values(dict_hex,dict_values,"7",7)
add_hex_values(dict_hex,dict_values,"8",8)
add_hex_values(dict_hex,dict_values,"9",9)
add_hex_values(dict_hex,dict_values,"A",10)
add_hex_values(dict_hex,dict_values,"B",11)
add_hex_values(dict_hex,dict_values,"C",12)
add_hex_values(dict_hex,dict_values,"D",13)
add_hex_values(dict_hex,dict_values,"E",14)
add_hex_values(dict_hex,dict_values,"F",15)

function bind_hex_values(dict_hex, dict_values,x)
    for (i,k) in enumerate(dict_hex) #for ith and kth elements in the order of hex
    k == x && return dict_values[i]              #k values is equal to the ith values of dict_values            #dont really get this bit
    end
end

function convert_hex(x)
    y = split(x,"")
        for i ∈ 1:3
            A[i] = (bind_hex_values(dict_hex, dict_values,y[i])*(array_base[i])) #This is where the confusion occurs
        end 
    return sum(A)
end 
#code below find the sum of the hex
using Random
Random.seed!(0)
random_hex_string(n=3) = *([rand(union('0':'9','A':'F')) for _ in 1:n]...);
r_hex_strs = [random_hex_string() for _ in 1:10^3];
array_hex_4c= Array{Int64}(undef, length(r_hex_strs))
for i ∈ 1:length(r_hex_strs)
    array_hex_4c[i] = convert_hex(r_hex_strs[i])
end
println("The sum of the binary from our implementations is ", sum(array_hex_4c), " compare to our prediction of 2184000 is a pretty good estimate")    