####################
# only solved part 1
####################
function boot_up(lines, fix)
    i = 1
    visited = []
    acc = 1
    while i <= length(lines) && !(i in visited)
        push!(visited,i)
        line = lines[i]
        # println("i : $i   $line")
        type, operation = split(line)
        if type == "nop"
            i += 1
        elseif type == "acc"
            if operation[1]=='+'
                acc += parse(Int, operation[2:end]) 
            else
                acc -= parse(Int, operation[2:end])
            end
            i+=1
        elseif type == "jmp"
            if operation[1] == '+'
                i += parse(Int, operation[2:end])
            else
                i -= parse(Int, operation[2:end])
            end
        end
        if i in visited && fix
            fix = false
            terminal = false
            while !terminal
                temp = copy(visited)
                type, operation = split(lines[maximum(temp)])
                if type == "jmp"
                    terminal = true
                    type, operation = split(lines[maximum(temp)])
                    lines[maximum(temp)] = "nop $operation"
                else
                    # remove the largest index
                    deleteat!(temp, findall(x->x==maximum(temp),temp))
                end
            end
            i += 1
        end
    end
    return acc, lines
end

f     = open("day8_data.txt");
lines = readlines(f)
close(f)

acc, lines = boot_up(lines, true)
acc, lines = boot_up(lines, false)

print(acc)



