function check_validity(pdict,keys)
    # check if it has all keys
    for key in keys
        if !haskey(pdict, key)
            return false
        end
    end
    #check years
    if !(1920 <= parse(Int,pdict["byr"]) <= 2002)
        return false
    end
    if !(2010 <= parse(Int,pdict["iyr"]) <= 2020)
        return false
    end
    if !(2020 <= parse(Int,pdict["eyr"]) <= 2030)
        return false
    end
    #check height
    if 'c' in pdict["hgt"]
        height = parse(Int,split(pdict["hgt"],"c")[1])
        if !(150 <= height <=193)
            return false
        end
    elseif 'i' in pdict["hgt"]
        height = parse(Int,split(pdict["hgt"],"i")[1])
        if !(59 <= height <= 76)
            return false
        end
    else
        return false
    end 

    #check haircolor
    if length(strip(pdict["hcl"],['#'])) != 6
        return false
    end
    #eyecolor
    if ! (pdict["ecl"] in ["amb"; "blu"; "brn"; "gry"; "grn" ;"hzl"; "oth"])
        return false
    end
    #pid
    if length(pdict["pid"]) != 9
        return false
    end

    return true
end


f     = open("passport_data.txt");
lines = readlines(f)
close(f)

req_keys = ["byr","iyr","eyr","hgt","hcl","ecl","pid"]
valid = 0
person_key = 1
per_dict = Dict()
per_dict[person_key] = Dict() 

# make sure to end text file with emty line for loop to work
for line in lines
    if line != ""
        words = split(line) 
        for temp in words 
            temp = split(temp,":")
            per_dict[person_key][temp[1]]=temp[2]
        end
    else
        if check_validity(per_dict[person_key],req_keys)
            valid += 1
        end
        person_key += 1
        per_dict[person_key] = Dict()    
    end
end
println(valid)




