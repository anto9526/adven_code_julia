function adapter_diffs(adapters)
    sort!(adapters)
    diff1 = count(i->(i==1), diff(adapters))
    diff3 = count(i->(i==3), diff(adapters))+1
    return diff1*diff3
end
function adapter_setups(adapters)
    # all 3 diffs needs to b present
    connections = [count(i->(ad<i<ad+3))]
    return diff1*diff3
end

f     = open("day10_data.txt");
lines = readlines(f)
close(f)
adapters = [parse(Int,line) for line in lines]
push!(adapters,0)
prod = adapter_diffs(adapters)


