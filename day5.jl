function get_seat(seat_string)
    rows = 0:127
    row_string = seat_string[1:7]
    for c in row_string
        if c =='F'
            rows = rows[1:fld(length(rows),2)]
        elseif c == 'B'
            rows = rows[fld(length(rows),2)+1:end]
        else
            print(row_string)
            println("something is wrong")
        end
    end

    cols = 0:7
    col_string = seat_string[8:end]
    for c in col_string
        if c =='L'
            cols = cols[1:fld(length(cols),2)]
        elseif c == 'R'
            cols = cols[fld(length(cols),2)+1:end]
        else
            println("something is wrong")
        end
    end
    
    return rows[1]*8 + cols[1]
end

f     = open("seating_data.txt");
lines = readlines(f)
close(f)

ids = Array{Int}(undef, 1)
for line in lines
    line = strip(line)
    push!(ids,get_seat(line))    
end
println(maximum(ids))
ids = sort(ids)
d = diff(ids)

i = findlast(x->x==2, d)

# neighbour seats
println(ids[i])
println(ids[i+1])
