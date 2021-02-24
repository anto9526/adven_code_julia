f     = open("day16_data.txt");
lines = readlines(f)
close(f)


range_lines = lines[1:20] 
tick_lines = lines[26:end]
range_bins = []
valid = Set()
fields = Dict()
#=
zone: 41-567 or 578-959

your ticket:
149,73,71,107,113,151,223,67,163,53,173,167,109,79,191,233,83,227,229,157
=#
for (i,line) in enumerate(range_lines)
    field,tmp=split(line,":")
    fields[i] = field
    tmp = split(tmp,"or")
    bin = []
    for t in tmp
        s,e = split(t,"-")
        append!(bin,[j for j in parse(Int,s):parse(Int,e)]) 
    end
    #println(bin)
    #println("Is 583 in the bin? :$(583 in bin)")
    union!(valid,bin)
    push!(range_bins,bin)
end


outrange = []
ticket=[149,73,71,107,113,151,223,67,163,53,173,167,109,79,191,233,83,227,229,157]
mat = Array{Int}(undef,0,20)
mat = vcat(mat, ticket')
for (i,line) in enumerate(tick_lines)
    valid_line = true
    nums = split(line,",")
    nums = [parse(Int,t) for t in nums]
    for j in 1:length(nums)
        if !(nums[j] in valid)
            push!(outrange,nums[j])
            valid_line = false
        end
    end
    if valid_line
        mat = vcat(mat,nums')
    end
end

println("Sum of out of range numbers for question 1 are $(sum(outrange))")


# Determine which column correspond to which bin.
# My logic is to go through all valid lines and check if a column value is 
# within the rangebin and in that way deduce that mentionen column do not 
# correspond to that bin
binc = []
for i in 1:length(range_bins)
    rb = []
    #println("$(fields[i]) could be the following column:")
    for j in 1:20
        if all([x in range_bins[i] for x in mat[:,j]])
    #        print("$j, ")
            push!(rb, j)
        end
    end
    push!(binc, rb)
    #println()
end

terminal = false
taken = []
while length(taken)<20
    for i in 1:length(binc)
        deleteat!(binc[i],findall(x->x in taken,binc[i]))
        if length(binc[i]) == 1
            println("$(fields[i]) could be the following column: $(binc[i][1])")
            push!(taken,binc[i][1])
        end
    end
end

p = prod([ticket[x] for x in [7 19 20 11 8 18]])

println("Question 2 = $p")

