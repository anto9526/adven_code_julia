using LinearAlgebra
function update_occuppancy1(occ,haschair)
    n,m = size(occ)
    occnext = copy(occ)
    #neighbour_free=[]
    for i = 1:n
        for j = 1:m
            n_neighb = sum(occ[within_bounds([i-1,i,i+1],n),within_bounds([j-1,j,j+1],m)])
            n_neighb -= occ[i,j] 
            if (haschair[i,j]==1 && occ[i,j] == 1 && n_neighb >= 4)
                occnext[i,j] = 0
            elseif haschair[i,j]==1 && occ[i,j] == 0 && n_neighb == 0
                occnext[i,j] = 1
            #elseif haschair[i,j]==1 && occ[i,j] == 1 && n_neighb == 0
            #    push!(neighbour_free,(i,j))
            end
        end
    end
    terminal = (occ == occnext) # break if terminal state is reached
    return occnext, terminal
end

function update_occuppancy2(occ,haschair)
    n,m = size(occ)
    occnext = copy(occ)
    #neighbour_free=[]
    for i = 1:n
        for j = 1:m
            n_neigh=0
            #n_neighb = sum(occ[within_bounds([i-1,i,i+1],n),within_bounds([j-1,j,j+1],m)])
            #n_neighb -= occ[i,j]
            if (occ[within_bounds(1:i-1,n),j])> 0
                n_neighb +=1
            end
            if sum(occ[within_bounds(i+1:n,n),j]) > 0
                n_neighb +=1
            end
            if sum(occ[i,within_bounds(1:j-1,m)]) > 0
                n_neighb +=1
            end
            if sum(occ[i,within_bounds(1:j-1,m)]) > 0
                n_neighb +=1
            end
            # tr is the function trace that summarize the matrix diagonal
            if tr(occ[i-1:-1:1+i-minimum([i;j]),j-1:-1:1+j-minimum([i; j])]) > 0 #upleft
                n_neighb +=1
            end
            if tr(occ[i-1:-1:1+i-minimum([i;m-j-1]),j+1:minimum([i; m])]) > 0 #upright
                n_neighb +=1
            end
            if tr(occ[1+i:i-1,j-1:-1:1+j-minimum([n; j])]) > 0 #downleft
                n_neighb +=1
            end
            if tr(occ[1+i-minimum([i,j]):i-1,1+j-minimum([i,j]):j-1]) > 0 #downright
                n_neighb +=1
            end



            for k in 1:maximum([n m])
                if occ[within_bounds([k,i,i+1],n)] > 0
                    n_neighb +=1
                end
            end
            
            if (haschair[i,j]==1 && occ[i,j] == 1 && n_neighb >= 5)
                occnext[i,j] = 0
            elseif haschair[i,j]==1 && occ[i,j] == 0 && n_neighb == 0
                occnext[i,j] = 1
            end
        end
    end
    terminal = (occ == occnext) # break if terminal state is reached
    return occnext, terminal
end

function within_bounds(indexes, upper_bound)
    # returns indexes which are within bounds, lower bound is 1 
    return [temp for temp in indexes if  (1 <= temp <=upper_bound )]
end



f     = open("day11_data.txt");
lines = readlines(f)
close(f)

# create two matrices one with which slots has chairs and one with ones and zeros indicating occupancy
#haschair = []
n = length(lines)
m = length(lines[1])
haschair = zeros(Int64,n,m)
for (i,line) in enumerate(lines)
    line = replace(line,"." => "0")
    line = replace(line,"L" => "1")
    haschair[i,:] = [parse(Int,c) for c in line]
end
occupied = copy(haschair) # all available chairs will be occupied to begin with
terminal = false
noneigh = []
while !terminal
    occupied, terminal = update_occuppancy1(occupied,haschair)
end
sum(occupied)

