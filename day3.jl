function count_trees(right,down)
f     = open("map_of_trees.txt");
lines = readlines(f)
close(f)

ind        = 0
tree_count = 0 
down_count = 0
for line in lines
    # create a grid of boolean
    if down_count % down != 0
        down_count += 1
        continue
    end
    l   = strip(line)
    l   = replace(l,"." => "0")
    l   = replace(l,"#" => "1")
    vec = [parse(Int,string(c) ) for c in l]

    if vec[ind % length(vec) + 1 ] == 1
        tree_count += 1
    end
    down_count += 1
    ind += right
end 

return tree_count
end

a = [count_trees(1,1)]
push!(a,count_trees(3,1))
push!(a,count_trees(5,1))
push!(a,count_trees(7,1))
push!(a,count_trees(1,2))
prod(a)


# convert 