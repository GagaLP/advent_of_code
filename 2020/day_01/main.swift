import Foundation

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

func get_multiple_part_a(numbers: [Int]) -> Int {
    for num in ints {
        for num_two in ints {
            if num + num_two == 2020 {
                return num * num_two
            }
        }
    }

    return -1
}


func get_multiple_part_b(numbers: [Int]) -> Int {
    for num in ints {
        for num_two in ints {
            for num_three in ints {
                if num + num_two + num_three == 2020 {
                    return num * num_two * num_three
                }
            }
        }
    }

    return -1
}

let file = "input" 

let numbers = read_in_file(file: file)
let ints = numbers.map {Int($0)!} 

print(get_multiple_part_a(numbers: ints))
print(get_multiple_part_b(numbers: ints))



