import Foundation

extension Sequence where Element: Hashable {
    func histogram() -> [Element: Int] {
        return self.reduce(into: [:]) { 
            counts, elem in counts[elem, default: 0] += 1 
        }
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

func parse_number_list(list: [String]) -> [Int] {
    var new_list = list.map{Int($0)!}
    new_list.sort(by: {$0 < $1})
    return new_list
}

func adapter_array_part_a(list: [Int]) -> Int {
    let my_list = list + [list.last! + 3]
    var last = 0

    let difference_list: [Int:Int] = my_list.reduce(into: []) {
        $0 += [$1 - last]
        last = $1
    }.histogram()

    print(difference_list)

    return difference_list[1]! * difference_list[3]!
}

func adapter_array_part_b(list: [Int]) -> Int {
    let my_list = [0] + list + [list.last! + 3]

    var tmp_group = [Int]()
    var prev = -1

    // add everything up in groups where each group consists of adapters appart by 1
    var new_list = my_list.reduce(into: [[Int]]()) {
        if $1 != prev + 1 {
            $0 += [tmp_group]
            tmp_group = []
        }

        tmp_group += [$1]
        prev = $1
    } 

    new_list += [tmp_group]

    var count = 1
    new_list.forEach {
        let tmp: Int = ($0.count - 2) >= 0 ? ($0.count - 2) : 0
        count *= (((tmp * tmp) + (tmp) + 2) / 2)  // Lazy caterer's sequence (modified for $0.count 0 and 1 laterns sequence n = 0 otherwhise 2 -> n = 1 ...)
    }
    
    return count
}


let file = "input" 

let lines = read_in_file(file: file)

let numbers = parse_number_list(list: lines)

print(adapter_array_part_a(list: numbers))
print(adapter_array_part_b(list: numbers))





