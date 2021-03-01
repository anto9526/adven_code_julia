# 3d game of life infinity size 

function affected_cells(living::Set)
    # Will return a set of cells that are either a living cell or adjacent to one
    aff_cells =  Set()
    for cell in living
        (x,y,z) = cell
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
function affected_cells2(living::Set)
    # Will return a set of cells that are either a living cell or adjacent to one
    aff_cells =  Set()
    for cell in living
        (x,y,z,w) = cell
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
function nextlife(living::Set, aff_cells)
    new_life = Set()
    for cell in aff_cells
        (x,y,z) = cell
        count = 0
        if cell in living
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        if (i,j,k) != (x,y,z) && (i,j,k) in living
                            count +=1
                        end 
                    end    
                end
            end
            if 2<=count<=3
                push!(new_life,cell)
            end
        else
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        if (i,j,k) != (x,y,z) && (i,j,k) in living
                            count +=1
                        end 
                    end    
                end
            end
            if count==3
                push!(new_life,cell)
            end
        end       
    end
    return new_life
end

function nextlife2(living::Set, aff_cells)
    new_life = Set()
    for cell in aff_cells
        (x,y,z,w) = cell
        count = 0
        if cell in living
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        for m in w-1:w+1
                            if (i,j,k,m) != (x,y,z,w) && (i,j,k,m) in living
                                count +=1
                            end
                        end 
                    end    
                end
            end
            if 2<=count<=3
                push!(new_life, cell)
            end
        else
            for i in x-1:x+1
                for j in y-1:y+1
                    for k in z-1:z+1
                        for m in w-1:w+1
                            if (i,j,k,m) != (x,y,z,w) && (i,j,k,m) in living
                                count +=1
                            end
                        end 
                    end    
                end
            end
            if count==3
                push!(new_life, cell)
            end
        end       
    end
    return new_life
end

f     = open("day17_data.txt");
lines = readlines(f)
close(f)
mat = Set()
for (i,line) in enumerate(lines)
    for (j,c) in enumerate(line)
        if c == '#'
            push!(mat,(j,-i,0))
        end    
    end
end


for i in 1:6
    cells = affected_cells(mat)
    mat = nextlife(mat, cells)
end
println("Question 1 living cells are $(length(mat))")



mat = Set()
for (i,line) in enumerate(lines)
    for (j,c) in enumerate(line)
        if c == '#'
            push!(mat,(j,-i,0,0))
        end    
    end
end

for i in 1:6
    cells = affected_cells2(mat)
    mat = nextlife2(mat, cells)
end
println("Question 2 living cells are $(length(mat))")