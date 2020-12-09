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

func parse_number_list(list: [String]) -> [Int] {
    return list.map{Int($0)!}
}

func find_wrong_part_a(list: [Int], preamble_length: Int) -> Int {
    var found = false
    var value_return = -1
    for item_index in preamble_length ... list.count {
        search_loop: for i in (item_index - preamble_length) ... item_index {
            for j in (item_index - preamble_length) ... item_index {
                if i != j {
                    if list[i] + list[j] == list[item_index] {
                        found = true
                        break search_loop
                    }
                }
            }
        }

        if !found {
            value_return = list[item_index]
            break
        }

        found = false
    }

    return value_return
}

func find_wrong_part_b(list: [Int], preamble_length: Int) -> Int {
    let number = find_wrong_part_a(list: list, preamble_length: preamble_length) 
    var index_first = 0
    var index_last = 0
    var sum = 0
    var return_val = -1

    for i in 0...list.count {
        sum += list[i]
        index_last = i


        while sum > number {
            sum -= list[index_first]
            index_first += 1
        }

        if sum == number {
            let new_list = list[index_first...index_last]
            
            return_val = new_list.min()! + new_list.max()!
            break
        }     
    }

    return return_val 
}

let file = "input" 

let lines = read_in_file(file: file)

let numbers = parse_number_list(list: lines)

print(find_wrong_part_a(list: numbers, preamble_length: 25))
print(find_wrong_part_b(list: numbers, preamble_length: 25))




