
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



function question_1(lines)
    sum = 0
    for line in lines
        #operators and numbers are spaced paranthesis is not
        line = split(line)   
        t, empty_list = evaluate_paranthesis(line)
        sum += t
    end
    println("Question 1 = $sum")
end
#=
3 + 8
7 * (7 * 6 + 7 * 5 + (9 + 2 * 2 * 4)) + 7 * 3 * 5
3 * 4 + 2 + 7 + (4 * (9 + 9 + 2 + 3 * 8) + 9 + (6 + 4) + 7) + 3
=#

function evaluate_line(elements)
    #Par sweep
    while '(' in elements 
        firstrpar = findfirst(i->(i==')'),elements)
        lpars = findall(i->(i=='('),elements)

        # find the closest left paranthesis that corresponds with the first right paranthesis
        corrlpar = maximum(lpars[lpars.<firstrpar])
        if corrlpar == 1 && firstrpar == length(elements)
            elements =  evaluate_line(elements[corrlpar+1:firstrpar-1])
        elseif corrlpar == 1
            elements =  [evaluate_line(elements[corrlpar+1:firstrpar-1]);elements[firstrpar+1:end] ]
        elseif firstrpar == length(elements)
            elements = [elements[1:corrlpar-1]; evaluate_line(elements[corrlpar+1:firstrpar-1])]
        else
            elements = [elements[1:corrlpar-1];evaluate_line(elements[corrlpar+1:firstrpar-1]); elements[firstrpar+1:end] ]
        end

    end

    #Plus sweep
    plus_index = findall(i->(i=='+'),elements)
    sort!(plus_index,rev = true) 
    for i in plus_index
        elements[i-1] = elements[i-1]+elements[i+1]
        deleteat!(elements,(i,i+1))
    end

    #Mult sweep
    mult_index = findall(i->(i=='*'),elements)
    sort!(mult_index,rev = true) 
    for i in mult_index
        elements[i-1] = elements[i-1]*elements[i+1]
        deleteat!(elements,(i,i+1))
    end
    return elements[1]
end
function question_2(lines)
    sum = 0
    for line in lines
        #operators and numbers are spaced paranthesis is not
        line = Any[c for c in line if c != ' ' ]    
        for i in 1:length(line) 
            if isnumeric(line[i])
                line[i] = parse(Int,line[i])
            end
        end
        t = evaluate_line(line) #returns lis
        sum += t
    end
    println("Question 2 = $sum")
end
question_2(lines)