
startnumbers = [0,1,4,13,15,12,16]
#startnumbers =[0,3,6]

d = Dict()
turn = 1
say = 0
for num in startnumbers
    d[turn] = num
    turn += 1
    say = num
end



@time for t in turn:2020
    spoken_keys = [k for (k,v) in d if say == v] 
    if length(spoken_keys) < 2
        say = 0 
    else
        #sort decending order 
        sort!(spoken_keys,rev = true)
        #say = t-1-maximum(spoken_keys) # take the latest (largest) index
        
        say = spoken_keys[1]-spoken_keys[2]
    end
    d[t] = say 
    #println("turn : $t say: $say ")     
end

println("Given the starting numbers $startnumbers, the 2020th number is $say")



startnumbers = [0,1,4,13,15,12,16]
#startnumbers =[0,3,6]

d = Dict()
turn = 1
say = 0
for num in startnumbers
    say = num
    d[say] = [turn]
    turn += 1
end



@time for t in turn:30_000_000
    if length(d[say]) < 2
        say = 0 
    else
        #sort decending order 
        #say = t-1-maximum(spoken_keys) # take the latest (largest) index
        say = d[say][1]-d[say][2]
    end
    if !haskey(d,say)
        d[say] = [t]
    else
        d[say] = [t,d[say][1]]
    end

    #println("turn : $t say: $say ")     
end

println("Given the starting numbers $startnumbers, the 2020th number is $say")





