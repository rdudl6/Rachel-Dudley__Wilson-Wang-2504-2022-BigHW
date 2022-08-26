using HTTP, JSON
#This line allows the web file to be obtained
strand_prac_B = HTTP.get("https://raw.githubusercontent.com/yoninazarathy/ProgrammingCourse-with-Julia-SimulationAnalysisAndLearningSystems/main/practicals_jupyter/practical_B_julia_essentials.ipynb")
#This parse the data to strings
strand_web_data = JSON.parse(String(strand_prac_B.body))
#This line prints number of cells there are in the JSON files
println(length(strand_web_data["cells"]))
#Using filter() whichtaskes the arguement when cell_type is markdawn in the cells show the length of the markdown
markdown_a = filter(x-> x["cell_type"]=="markdown", strand_web_data["cells"])
@show length(markdown_a)
@show typeof(markdown_a)
code_a = filter(x-> x["cell_type"]=="code", strand_web_data["cells"])
@show length(code_a)
breakdown_a = filter(x->length(x["outputs"])==0, code_a) 
#breakdown of output
@show length(breakdown_a)
#breakdown those that don't have output is the total number of code cells minus those with output
@show length(code_a)-length(breakdown_a)
#one thing that I found relevant
#number of source that is longer than 5
source_a = filter(x->length(x["source"])>5, strand_web_data["cells"])
@show length(source_a)

#problem with def of summary
summary = Dict{String, Any}()
summary = Any[Dict{String, Any}("Total number of cells" => 60, "Number of code cells" => 33, "Number of markdown" =>27, "cells with output"=> 21, "cells without output"=>12, "Number of sources that have more than 5 words"=>15)]
println(summary)

using DataFrames, CSV
CSV.write("markdown_summary.csv")
CSV.write("code_summary.csv")
hashtag_1 = Array{Int}(undef,0)
hashtag_2 = Array{Int}(undef,0)
hashtag_3 = Array{Int}(undef,0)
hashtag_4 = Array{Int}(undef,0)
for markdown in markdown_a
    x_1 = 0
    x_2 = 0 
    x_3 = 0
    x_4 = 0
    for s in markdown["source"]
        if occursin("####",s)
            x_4 += 1
            continue
        end
        if occursin("###",s)
            x_3 += 1
            continue
        end
        if occursin("##",s)
            x_2 += 1
            continue
        end
        if occursin("#",s)
            x_1 += 1
        end 
    end
    @show x_4
    @show x_3
    @show x_2
    @show x_1
end
# markdown_s = DataFrame(hash1  = sum(x_1),
#                         hash2 = sum(x_2),
#                         hash3 = sum(x_3),
#                         hash4 = sum(x_4))       
