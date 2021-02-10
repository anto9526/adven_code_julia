struct State
    x::Number
    y::Number
    theta::Number #degrees
end

struct State2
    x::Number
    y::Number
    wpn::Number
    wpe::Number #degrees
end

function move1(s::State,instruct,value::Int)
    if instruct == 'F'
        ns = State(s.x +value*cosd(s.theta),s.y+value*sind(s.theta),s.theta)

    elseif instruct == 'L'
        ns = State(s.x ,s.y,s.theta + value)
    elseif instruct == 'R'
        ns = State(s.x ,s.y,s.theta - value)
    elseif instruct == 'N'
        ns = State(s.x ,s.y + value,s.theta)

    elseif instruct == 'E'
        ns = State(s.x + value ,s.y,s.theta)

    elseif instruct == 'S'
        ns = State(s.x ,s.y - value,s.theta)

    elseif instruct == 'W'
        ns = State(s.x - value,s.y,s.theta)
    else
        print("Instruction $instruct did not match any case")
    end
    return ns

end
function move2(s::State2,instruct,value::Int)
    if instruct == 'F'
        ns = State2(s.x +value*s.wpe,s.y+value*s.wpn,s.wpn,s.wpe)

    elseif instruct == 'L'
        hypo = hypot(s.wpe,s.wpn)
        ang = atand(s.wpn,s.wpe)
        ns = State2(s.x ,s.y,hypo*sind(ang+value),hypo*cosd(ang+value))
    elseif instruct == 'R'
        hypo = hypot(s.wpe,s.wpn)
        ang = atand(s.wpn,s.wpe)
        ns = State2(s.x ,s.y,hypo*sind(ang-value),hypo*cosd(ang-value))
    elseif instruct == 'N'
        ns = State2(s.x ,s.y ,s.wpn+value ,s.wpe)
    elseif instruct == 'E'
        ns = State2(s.x,s.y,s.wpn,s.wpe + value)

    elseif instruct == 'S'
        ns = State2(s.x ,s.y ,s.wpn-value,s.wpe)

    elseif instruct == 'W'
        ns = State2(s.x,s.y, s.wpn,s.wpe-value)
    else
        print("Instruction $instruct did not match any case")
    end
    return ns

end

function manhattan(s::State)
    return abs(s.x)+abs(s.y)
end
function manhattan(s::State2)
    return abs(s.x)+abs(s.y)
end

f     = open("day12_data.txt");
lines = readlines(f)
close(f)
state = State(0,0,0)

for line in lines
    instruction = line[1]
    val = parse(Int,line[2:end])
    state = move1(state,instruction,val)
end
manhattan(state)

state = State2(0,0,1,10)

for line in lines
    instruction = line[1]
    val = parse(Int,line[2:end])
    state = move2(state,instruction,val)
end
manhattan(state)