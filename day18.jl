#=
3 + 8
7 * (7 * 6 + 7 * 5 + (9 + 2 * 2 * 4)) + 7 * 3 * 5
3 * 4 + 2 + 7 + (4 * (9 + 9 + 2 + 3 * 8) + 9 + (6 + 4) + 7) + 3
=#
f     = open("day18_data.txt");
lines = readlines(f)
close(f)

function evaluate_paranthesis(el)
    #el[1]= el[1][2] # removes the start paranthesis
    arg_left = 0
    operation = "+" # sets to plus so that first number is added to temp 
    while length(el) > 0 #for i in 1:length(el)
        #println("argleft : $arg_left element : $(el[1])")
        if el[1] == "+"
            #println("operation changed to +")
            operation = "+"
            popat!(el,1)
        elseif el[1] == "*"
            #println("operation changed to *")
            operation = "*" 
            popat!(el,1)
        elseif occursin('(',el[1]) 
            el[1]= el[1][2:end] #might be multiple paranthesis
            arg, el = evaluate_paranthesis(el) #recursion
            if operation == "+"
                arg_left += arg
            elseif operation == "*"
                arg_left = arg_left*arg
            end 
        
        elseif occursin(')', el[1])
            if length(el[1])== 1
                #only contains end paranthesis
                popat!(el,1)
                return arg_left, el
            end
            if operation == "+"
                arg_left += parse(Int,el[1][1])
            elseif operation == "*"
                arg_left = arg_left*parse(Int,el[1][1])
            end
            if length(el[1]) > 2
                #incase of multiple end paranthesis
                el[1]= el[1][3:end]
            else
                popat!(el,1)
            end
            return arg_left, el 
        else
            if operation == "+"
                arg_left += parse(Int,el[1][1])
            elseif operation == "*"
                arg_left = arg_left*parse(Int,el[1][1])
            end 
            popat!(el,1)
        end
    end
    return arg_left, el
end

sum = 0
for line in lines
    #operators and numbers are spaced paranthesis is not
    line = split(line)   
    t, empty_list = evaluate_paranthesis(line)
    sum += t
end
println("Question 1 = $sum")
