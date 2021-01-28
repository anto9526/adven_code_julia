function has_required_keys(pdict,keys)
    for key in keys
        if !haskey(pdict, key)
            return false
        end
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

for line in lines
    if line != ""
        words = split(line) 
        for temp in words 
            temp = split(temp,":")
            per_dict[person_key][temp[1]]=temp[2]
        end
    else
        if has_required_keys(per_dict[person_key],req_keys)
            valid += 1
        end
        person_key += 1
        per_dict[person_key] = Dict()    
    end
end
# the last person is not checked in the loop
if has_required_keys(per_dict[person_key],req_keys)
    valid += 1
end

print(valid)




