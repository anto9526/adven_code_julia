#=
mask = X011X00011011110001X01010011X0X0X010
mem[35176] = 9976167
mem[39031] = 108553
mem[59131] = 6439623
mem[63499] = 293387351
mem[53936] = 331755
mem[56389] = 2017477
=#
f     = open("day14_data.txt");
lines = readlines(f)
close(f)
memory = Dict()
mask = "X011X00011011110001X01010011X0X0X010"
for line in lines
    if(occursin("mask",line))
        mask = strip(split(line,"=")[2])
    else
        mem, value = split(line,"=")
        mem = strip(mem,['m','e','[',']',' '])
        value = digits(parse(Int,value), base=2, pad=length(mask)) |> reverse
        result = copy(value)
        for (i,c) in enumerate(mask)
            if c != 'X'
                result[i] = parse(Int,c)
            end
        end
        memory[mem] = sum([result[i]*2^(36-i) for i in 1:36])
        #print(memory[mem])
    end
end
println("Answer to question 1 is $(sum(values(memory)))")


memory = Dict()
mask = "X011X00011011110001X01010011X0X0X010"
for line in lines
    if(occursin("mask",line))
        mask = strip(split(line,"=")[2])
    else
        adress, value = split(line,"=")
        adress = strip(adress,['m','e','[',']',' '])
        value = parse(Int,value)
        adress = digits(parse(Int,adress), base=2, pad=length(mask)) |> reverse
        adresses = [adress]
        for (i,c) in enumerate(mask)
            if c == '1'
                for ad in adresses
                    ad[i] = parse(Int,c)
                end
            elseif  c== 'X'
                temp = []
                for ad in adresses
                    ad[i] = 1
                    new_ad = copy(ad)
                    new_ad[i] = 0
                    temp = push!(temp,new_ad)
                end
                adresses = append!(adresses,temp)
            end
        end
        for ad in adresses
            ad = sum([ad[i]*2^(36-i) for i in 1:36])
            memory[ad] = value
        end
    end
end
println("Answer to question 2 is $(sum(values(memory)))")
