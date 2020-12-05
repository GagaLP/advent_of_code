import Foundation

func read_in_file(file: String) -> [String] {
    if let path = Bundle.main.path(forResource: file, ofType: "txt"){
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            return data.components(separatedBy: .whitespacesAndNewlines)
        } catch {
            print(error)
            return []
        }
    }
    return []
}

func parse_pasports(fields: [String]) -> [[String:String]] {
    var array : [[String:String]] = []
    var tmp_dic : [String:String] = [:]

    for element in fields {
        if element.count < 3 {
            array.append(tmp_dic)
            tmp_dic = [:]
            continue
        }

        let tokens = element.components(separatedBy: ":")

        tmp_dic[tokens[0]] = tokens[1]
    }

    array.append(tmp_dic)

    return array
}

// for every if {retrun true} return false I know this goes faster but like this it is more readable 
// and I know this is extremely inefficient but this was my first idea
func check_year(year_str: String, lower: Int, upper: Int) -> Bool {
    if let year = Int(year_str), year >= lower && year <= upper {
        return true
    } 

    return false 
}

func check_size(size: String) -> Bool {
    var number = ""
    var description = ""
    var digit_zone = true

    for char in size {
        if char.isNumber && digit_zone {
            number.append(char)
        } else {
            digit_zone = false
            description.append(char)
        }
    }

    if (description == "cm" && Int(number)! >= 150 && Int(number)! <= 193) || (description == "in" && Int(number)! >= 59 && Int(number)! <= 76) {
        return true
    }

    return false
}

func check_hex_color(color: String) -> Bool {
    if Array(color)[0] == "#" && color.count == 7 && color.filter(\.isHexDigit).count == 6{
        return true
    }

    return false
}

func check_eye_color(color: String) -> Bool {
    let colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    return colors.contains(color)
}

func check_passport_id(passport: String) -> Bool {
    if passport.count == 9, Int(passport) != nil {
        return true
    }

    return false
}

func count_valid_passports_part_a(passports: [[String:String]]) -> Int {
    var counter = 0

    for passport in passports {
        if passport.count == 8 || passport.count == 7 && passport["cid"] == nil {
            counter = counter + 1
        }
    }

    return counter
}


func count_valid_passports_part_b(passports: [[String:String]]) -> Int {
    var counter = 0

    for passport in passports {
        if let byr = passport["byr"], // check if every element exists
           let iyr = passport["iyr"],
           let eyr = passport["eyr"],
           let hgt = passport["hgt"],
           let hcl = passport["hcl"],
           let ecl = passport["ecl"],
           let pid = passport["pid"],
           check_year(year_str: byr, lower: 1920, upper: 2002) && // check if every element is valid
           check_year(year_str: iyr, lower: 2010, upper: 2020) &&
           check_year(year_str: eyr, lower: 2020, upper: 2030) &&
           check_size(size: hgt) &&
           check_hex_color(color: hcl) &&
           check_eye_color(color: ecl) &&
           check_passport_id(passport: pid)
        {
            counter = counter + 1
        }
    }

    return counter
}


let file = "input" 
let fields = read_in_file(file: file)

let passports = parse_pasports(fields: fields)

print(count_valid_passports_part_a(passports: passports))
print(count_valid_passports_part_b(passports: passports))

