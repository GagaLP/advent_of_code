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

func awnsers_part_a(lines: [String]) -> Int {
    var awnsers: [Set<Character>] = []
    var awnser_set_tmp: Set<Character> = []

    for line in lines {
        if line.count > 0 {
            for char in line {
                awnser_set_tmp.insert(char)
            }
        } else {
            awnsers.append(awnser_set_tmp)
            awnser_set_tmp = []
        }
    }

    awnsers.append(awnser_set_tmp)


    var count = 0
    for awnser in awnsers {
        count = count + awnser.count
    }    

    return count
}

func awnsers_part_b(lines: [String]) -> Int {
    var awnsers: [Set<Character>] = []
    var awnsers_tmp: [Set<Character>] = []
    var awnser_set_tmp: Set<Character> = []

    for line in lines {
        if line.count > 0 {
            for char in line {
                awnser_set_tmp.insert(char)
            }
            awnsers_tmp.append(awnser_set_tmp)
            awnser_set_tmp = []
        } else {
            awnser_set_tmp = awnsers_tmp[0]
            for awnser in awnsers_tmp {
                awnser_set_tmp = awnser_set_tmp.intersection(awnser)
            }
            awnsers.append(awnser_set_tmp)
            awnser_set_tmp = []
            awnsers_tmp = []
        }
    }

    awnser_set_tmp = awnsers_tmp[0]
    for awnser in awnsers_tmp {
        awnser_set_tmp = awnser_set_tmp.intersection(awnser)
    }
    awnsers.append(awnser_set_tmp)

    var count = 0
    for awnser in awnsers {
        count = count + awnser.count
    }    

    return count
}



let file = "input" 

let lines = read_in_file(file: file)

print(awnsers_part_a(lines: lines))
print(awnsers_part_b(lines: lines))
