# 3d game of life infinity size 

struct Cell
    x::Int
    y::Int
    z::Int
end

function affected_cells(d::Dict)
    # Will return a set of cells that are either a living cell or adjacent to one
    aff_cells =  Set()
    for key in keys(d)
        (x,y,z) = key
        for i in x-1:x+1
            for j in y-1:y+1
                for k in z-1:z+1
                    push!(aff_cells,(i,j,k))
                end    
            end
        end
    end
    return aff_cells
end
function affected_cells2(d::Dict)
    # Will return a set of cells that are either a living cell or adjacent to one
    aff_cells =  Set()
    for key in keys(d)
        (x,y,z,w) = key
        for i in x-1:x+1
            for j in y-1:y+1
                for k in z-1:z+1
                    for m in w-1:w+1
                        push!(aff_cells,(i,j,k,m))
                    end
                end    
            end
        end
    end
    return aff_cells
end
function nextlife(d::Dict, aff_cells)
    new_d = Dict()
    for cell in aff_cells
        (x,y,z) = cell
        count = 0
        if haskey(d,cell)
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        if (i,j,k) != (x,y,z) && haskey(d,(i,j,k))
                            count +=1
                        end 
                    end    
                end
            end
            if 2<=count<=3
                new_d[cell] = true
            end
        else
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        if (i,j,k) != (x,y,z) && haskey(d,(i,j,k))
                            count +=1
                        end 
                    end    
                end
            end
            if count==3
                new_d[cell] = true
            end
        end       
    end
    return new_d
end

function nextlife2(d::Dict, aff_cells)
    new_d = Dict()
    for cell in aff_cells
        (x,y,z,w) = cell
        count = 0
        if haskey(d,cell)
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        for m in w-1:w+1
                            if (i,j,k,m) != (x,y,z,w) && haskey(d,(i,j,k,m))
                                count +=1
                            end
                        end 
                    end    
                end
            end
            if 2<=count<=3
                new_d[cell] = true
            end
        else
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        for m in w-1:w+1
                            if (i,j,k,m) != (x,y,z,w) && haskey(d,(i,j,k,m))
                                count +=1
                            end
                        end 
                    end    
                end
            end
            if count==3
                new_d[cell] = true
            end
        end       
    end
    return new_d
end

f     = open("day17_data.txt");
lines = readlines(f)
close(f)
mat = Dict()
for (i,line) in enumerate(lines)
    for (j,c) in enumerate(line)
        if c == '#'
            mat[(j,-i,0)] = true
        end    
    end
end


for i in 1:6
    cells = affected_cells(mat)
    mat = nextlife(mat, cells)
end
println("Question 1 living cells are $(length(keys(mat)))")



mat = Dict()
for (i,line) in enumerate(lines)
    for (j,c) in enumerate(line)
        if c == '#'
            mat[(j,-i,0,0)] = true
        end    
    end
end

for i in 1:6
    cells = affected_cells2(mat)
    mat = nextlife2(mat, cells)
end
println("Question 2 living cells are $(length(keys(mat)))")