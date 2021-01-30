f     = open("day6_data.txt");
lines = readlines(f)
close(f)

group_set = Set()
tot_count = 0 
for line in lines
    if line == ""
        tot_count += length(group_set)
        group_set = Set() 
    else
        group_set = union(group_set,[c for c in line])    
    end
end
tot_count += length(group_set)


println("First question: $tot_count")

group_set = Set()
tot_count = 0
new_group = true 
for line in lines
    if line == ""
        tot_count += length(group_set)
        new_group = true
    else
        if new_group
            new_group = false
            group_set = Set([c for c in line])
        else
            group_set = intersect(group_set,[c for c in line]) 
        end
    end
end
tot_count += length(group_set)

println("Second question: $tot_count")