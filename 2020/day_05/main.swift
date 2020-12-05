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

func get_seat_id(row: String) -> Int {
    var row_int = 0
    var column_int = 0

    for char in row {
        if char == "F" {
            row_int = row_int << 1
        } else if  char == "B" {
            row_int = (row_int << 1) + 1
        } else if char == "L" {
            column_int = column_int << 1
        } else if  char == "R" {
            column_int = (column_int << 1) + 1
        }  
    }

    return row_int * 8 + column_int
}

func get_highest_seat_part_a(rows: [String]) -> Int {
    var highest = 0

    for row in rows {
        highest = max(highest, get_seat_id(row: row))
    }

    return highest
}

func get_my_seat_number_part_b(rows: [String]) -> Int {
    var seats: Set<Int> = []

    for row in rows {
        seats.insert(get_seat_id(row: row))
    }

    let seats_sorted = seats.sorted()

    var previouse = -2
    var my_seat = -1

    for seat in seats_sorted {
        if seat - previouse == 2 {
            my_seat = seat - 1
            break
        } else {
            previouse = seat
        }
    }

    return my_seat
}

let file = "input" 

let rows = read_in_file(file: file)

print(get_highest_seat_part_a(rows: rows))
print(get_my_seat_number_part_b(rows: rows))

