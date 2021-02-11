earliest = 1000303
s = "41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,541,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,983,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19"
s = split(s,",")
buslines = [parse(Int,line) for line in s if line != "x"] 
println(buslines)
for line in buslines
    departs_in = line-mod(earliest,line)
    #println("Buss $line departs in $departs_in minutes")
end
println("Asnwer to question 1 is $(541*6)")

s = "41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,541,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,983,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19"
#s = "7,13,x,x,59,x,31,19"
s = split(s,",")
gap = Int[]
buslines = Int[]
count = 0
for (count,line) in enumerate(s) 
    if line != "x"
        push!(gap,count-1)#should start at 0 
        push!(buslines,parse(Int,line))
    end
end
println(buslines)
println(gap)
t = 0
increment = buslines[1]
for i in 2:length(buslines)
    koef = ceil(Int,gap[i]/buslines[i]) #to allow for gaps greater than time cycle
    terminal = false
    while(!terminal) 
        t += increment
        if koef*buslines[i]-t%buslines[i] == gap[i]
            increment = lcm(increment,buslines[i])
            terminal = true 
        end
    end 
    println("found one step increment is now $increment") 
end
print(t)

