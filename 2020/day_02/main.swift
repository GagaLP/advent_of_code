import Foundation

struct Password_policy {
    let least : Int
    let most : Int
    let char : Character
    let password : String

    var description: String {
        return "\(least)-\(most) \(char): \(password)"
    }
}

func read_in_file(file: String) -> [String] {
    if let path = Bundle.main.path(forResource: file, ofType: "txt"){
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            return data.components(separatedBy: .newlines)
        } catch {
            print(error)
            return []
        }
    }
    return []
}

func parse_input(lines: [String]) -> [Password_policy] {
    var password_policy_array: [Password_policy] = []

    // split lines to the right tokens
    // eg 1-3 a: aabbcc
    // will be least = 1, most = 3, char = a, password = aabbcc
    for line in lines {
        if line.count > 1 {
            let tokens = line.components(separatedBy: " ")
            // parse tokens
            let numbers_concat = tokens[0]
            let char_token = tokens[1]
            let password = tokens[2]

            // split into numbers
            let numbers_array = numbers_concat.components(separatedBy: "-").map{Int($0)!} 

            // get char at pos 0 
            let char = Array(char_token)[0]
            password_policy_array.append(Password_policy(least: numbers_array[0], most: numbers_array[1], char: char, password: password))
        }
    }
    return password_policy_array
}

func validate_passwords_part_a(password_policies: [Password_policy]) -> Int {
    var valid_passwords = 0
    for password_policy in password_policies {
        let number_of_occurences = password_policy.password.filter{$0 == password_policy.char}.count
        if number_of_occurences >= password_policy.least && number_of_occurences <= password_policy.most {
            valid_passwords = valid_passwords + 1
        }
    }
    return valid_passwords
}


func validate_passwords_part_b(password_policies: [Password_policy]) -> Int {
    var valid_passwords = 0
    for password_policy in password_policies {
        let char_one = Array(password_policy.password)[password_policy.least - 1]
        let char_two = Array(password_policy.password)[password_policy.most - 1]
        if char_one == password_policy.char && char_two != password_policy.char || char_one != password_policy.char && char_two == password_policy.char{ 
            valid_passwords = valid_passwords + 1
        }
    }
    return valid_passwords
}

let file = "input" 

let lines = read_in_file(file: file)
let paresed_input = parse_input(lines: lines)

print(validate_passwords_part_a(password_policies: paresed_input))
print(validate_passwords_part_b(password_policies: paresed_input))




