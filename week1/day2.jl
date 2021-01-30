function check_policy1(line)
    line      = split(line,":")
    policy    = split(line[1],"-")
    minletter = parse(Int,policy[1])
    maxletter = parse(Int,split(policy[2])[1])
    letter    = split(policy[2])[2]
    password  = strip(line[2])
    if minletter <= count(letter,password) <= maxletter
        return true
    else
        return false 
    end
end

function check_policy2(line)
    line      = split(line,":")
    policy    = split(line[1],"-")
    ind1      = parse(Int,policy[1])
    ind2      = parse(Int,split(policy[2])[1])
    letter    = split(policy[2])[2]
    password  = strip(line[2])
    if letter == string(password[ind1]) != string(password[ind2]) || letter == string(password[ind2]) != string(password[ind1])
        return true
    else
        return false 
    end

end

f = open("password_policy.txt");
lines = readlines(f)
close(f)

proper_passwords = 0
improper_passwords = 0

for line in lines
    if check_policy2(line)
        proper_passwords += 1
    else
        improper_passwords += 1 
    end
end
println(proper_passwords)
println(improper_passwords)




