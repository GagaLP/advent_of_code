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


func get_ammount_of_trees(lines: [String], left: Int, down: Int) -> Int {
    var index_left = 0
    var index_down = -1
    var count = 0
    for line in lines {
        index_down = index_down + 1
        if index_down % down > 0  {
            continue;
        }

        if Array(line)[index_left] == "#" {
            count = count + 1
        }

        index_left = (index_left + left) % line.count
    }

    return count
}

func get_ammount_of_trees_part_a(lines: [String]) -> Int {
    let count = get_ammount_of_trees(lines: lines, left: 3, down: 1)
    return count
}

func get_ammount_of_trees_part_b(lines: [String]) -> Int {
    let count_first = get_ammount_of_trees(lines: lines, left: 1, down: 1)
    let count_second = get_ammount_of_trees(lines: lines, left: 3, down: 1)
    let count_third = get_ammount_of_trees(lines: lines, left: 5, down: 1)
    let count_fourth = get_ammount_of_trees(lines: lines, left: 7, down: 1)
    let count_fift = get_ammount_of_trees(lines: lines, left: 1, down: 2)

    return count_first * count_second * count_third * count_fourth * count_fift
}

let file = "input" 

let lines = read_in_file(file: file)

print(get_ammount_of_trees_part_a(lines: lines))
print(get_ammount_of_trees_part_b(lines: lines))




