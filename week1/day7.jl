#=
wavy green bags contain 1 posh black bag, 1 faded green bag, 4 wavy red bags.
dotted chartreuse bags contain 1 light beige bag.
dark white bags contain 2 dotted white bags.
clear aqua bags contain 4 posh orange bags, 4 pale blue bags.
=#
#using DataStructures
function part1()
    f     = open("day7_data.txt");
    lines = readlines(f)
    close(f)
    #bag_dict = DefaultDict{String,Set}(Set())
    bag_dict = Dict()
    for line in lines
        container, contained  = split(line,"contain")
        for con in split(contained,",")
            key =  "$(split(con)[2]) $(split(con)[3])"
            if !haskey(bag_dict,key)
                bag_dict[key]=Set()
            end
            union!(bag_dict[key],["$(split(container)[1]) $(split(container)[2])"])
        end
    end
    println(bag_dict["shiny gold"])
    # check which bags that can contain 
    gset = bag_dict["shiny gold"]
    bag_count = 0
    while bag_count != length(gset)
        # checks which bags our bags can be contained i untill it converges
        bag_count = length(gset)
        for key in gset
            if haskey(bag_dict, key)
                union!(gset, bag_dict[key])
            end
        end    
    end
    return bag_count
end

function part2()
    f     = open("day7_data.txt");
    lines = readlines(f)
    close(f)
    bag_dict = Dict()
    for line in lines
        container, contained  = split(line,"contain")
        if contained ==" no other bags."
            continue
        end
        key = "$(split(container)[1]) $(split(container)[2])"
        if !haskey(bag_dict, key)
            bag_dict[key] = Set()
        end
        union!(bag_dict[key],["$(split(con)[1]) $(split(con)[2]) $(split(con)[3])" for con in split(contained,",")])
    end
    return bags_contained(bag_dict,"shiny gold",1)-1 # dont want to include the shiny gold bag
end

function bags_contained(bagdict,bagname,amount)
    #recursive function
    if amount == 0 || !haskey(bagdict,bagname)
        return amount
    end
    tot_bags = amount
    for bag in bagdict[bagname]
        amount_next, adjective, col = split(bag) 
        tot_bags += amount*bags_contained(bagdict,"$adjective $col",parse(Int,amount_next))  
    end
    return tot_bags
end


a=part2()


