import Foundation

struct Bag: Hashable {
    let color: String
    let amount: Int
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

// first time in the aoc to use some swift magic
func parse_input_a(lines: [String]) -> [String:Set<String>] {
    return lines.filter{!$0.contains("no other bags")}
                .map{$0.components(separatedBy: " bags contain ")}
                .reduce(into: [String:Set<String>]()) { dict, array in 
                    array[1].components(separatedBy: ", ")
                            .map{$0.components(separatedBy: " ")} 
                            .forEach{dict[$0[1...2].joined(separator: " "), default: Set()].insert(array[0])}   
                }
}

func parse_input_b(lines: [String]) -> [String:Set<Bag>] {
    return lines.filter{!$0.contains("no other bags")}
                .map{$0.components(separatedBy: " bags contain ")}
                .reduce(into: [String:Set<Bag>]()) { dict, array in 
                    array[1].components(separatedBy: ", ")
                            .map{$0.components(separatedBy: " ")} 
                            .forEach{dict[array[0], default: Set()].insert(Bag(color: $0[1...2].joined(separator: " "), amount: Int($0[0])!))}   
                }
}

func get_all_collection_part_a(search: String, luggage_set: [String:Set<String>]) -> Set<String> {
    var result = Set<String>()

    if let tmp = luggage_set[search] {
        tmp.forEach { 
            result.insert($0) 
            result.formUnion(get_all_collection_part_a(search: $0, luggage_set: luggage_set))
        }
    }

    return result
}

func get_all_collection_part_b(search: String, luggage_set: [String:Set<Bag>]) -> Int {
    var result = 0
    if let tmp = luggage_set[search] {
        tmp.forEach {
            result += get_all_collection_part_b(search: $0.color, luggage_set: luggage_set) * $0.amount + $0.amount
        }
    }
    
    return result
}

func part_a(luggage_set: [String:Set<String>]) -> Int {
    return get_all_collection_part_a(search: "shiny gold", luggage_set: luggage_set).count
}

func part_b(luggage_set: [String:Set<Bag>]) -> Int {
    return get_all_collection_part_b(search: "shiny gold", luggage_set: luggage_set)
}

let file = "input" 

let lines = read_in_file(file: file)

let parsed_input_a = parse_input_a(lines: lines)
let parsed_input_b = parse_input_b(lines: lines)
print(part_a(luggage_set: parsed_input_a))
print(part_b(luggage_set: parsed_input_b))



