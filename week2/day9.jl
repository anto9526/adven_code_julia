
function no_sol(vec)
    len = length(vec)
    for n in len-25:len-2
        for m in n+1:len-1
            if vec[n] + vec[m] == vec[end]
                return false
            end
        end
    end
    return true
end
function find_error(lines)
    vec = []
    i = 0 
    for line in lines 
        i += 1
        push!(vec,parse(Int,line))
        if i <= 25
            continue
        end
        if no_sol(vec)
            return vec
        end
    end
    return vec
end

function find_cons(vec)
    val = vec[end]
    for i in 1:length(vec)-1
        for j in i+1:length(vec)-1
            if sum(vec[i:j]) == val
                return vec[i:j]
            elseif sum(vec[i:j]) > val
                break
            end
        end
    end
end

f     = open("day9_data.txt");
lines = readlines(f)
close(f)

@time vec = find_error(lines)
@time cons = find_cons(vec)

minimum(cons)+maximum(cons)


