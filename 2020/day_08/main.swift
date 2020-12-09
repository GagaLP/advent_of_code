import Foundation

struct Instruction {
    var instruction_type: String
    let number: Int
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

func input_to_instructions(lines: [String]) -> [Instruction] {
    var instructions: [Instruction] = []

    lines.forEach {
        let instruction_array = $0.components(separatedBy: " ")

        instructions.append(Instruction(instruction_type: instruction_array[0], number: Int(instruction_array[1])!))
    }
    return instructions
}

func execute_programm_part_a(instructions: [Instruction]) -> Int {
    var acc = 0
    var prog_count = 0

    var instruction_set: Set<Int> = []

    repeat {
        if instruction_set.contains(prog_count) {
            break;
        } else if (instructions[prog_count].instruction_type == "acc") {
            instruction_set.insert(prog_count);
            acc += instructions[prog_count].number
            prog_count += 1
        } else if (instructions[prog_count].instruction_type == "jmp") {
            instruction_set.insert(prog_count);
            prog_count += instructions[prog_count].number
        } else {
            instruction_set.insert(prog_count);
            prog_count += 1
        }
    } while prog_count < instructions.count && prog_count >= 0 
        
    return acc
}

func check_for_full_execution(instructions: [Instruction]) -> Bool {
    var prog_count = 0

    var instruction_set: Set<Int> = []

    repeat {
        if instruction_set.contains(prog_count) || prog_count < 0 {
            return false
        } else if (instructions[prog_count].instruction_type == "acc") {
            instruction_set.insert(prog_count);
            prog_count += 1
        } else if (instructions[prog_count].instruction_type == "jmp") {
            instruction_set.insert(prog_count);
            prog_count += instructions[prog_count].number
        } else {
            instruction_set.insert(prog_count);
            prog_count += 1
        }
    } while prog_count < instructions.count  
        
    return true
}

// brute force ftw. NO but sereously not recomended
func execute_programm_part_b(instructions: [Instruction]) -> Int {
    var tmp_instructions = instructions
    for i in 0...instructions.count {
        if tmp_instructions[i].instruction_type == "jmp" || tmp_instructions[i].instruction_type == "nop" {
            tmp_instructions[i].instruction_type = tmp_instructions[i].instruction_type == "jmp" ? "nop" : "jmp"

            if check_for_full_execution(instructions: tmp_instructions) {
                break
            }

            tmp_instructions[i].instruction_type = tmp_instructions[i].instruction_type == "jmp" ? "nop" : "jmp"
        }
    }

    return execute_programm_part_a(instructions: tmp_instructions)
}

let file = "input" 

let lines = read_in_file(file: file)

let instructions = input_to_instructions(lines: lines)

print(execute_programm_part_a(instructions: instructions))
print(execute_programm_part_b(instructions: instructions))



