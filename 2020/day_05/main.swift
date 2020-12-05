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


// see the fb and lr as binary numbers. 
// eg fbbfbbf = 0110110 
// the easiest way to get this is by shifting
func get_seat_id(seat: String) -> Int {
    var row = 0
    var column = 0

    for char in seat {
        if char == "F" {
            row = row << 1
        } else if  char == "B" {
            row = (row << 1) + 1
        } else if char == "L" {
            column = column << 1
        } else if  char == "R" {
            column = (column << 1) + 1
        }  
    }

    return row * 8 + column
}

func get_highest_seat_part_a(seats: [String]) -> Int {
    var highest = 0

    for seat in seats {
        highest = max(highest, get_seat_id(seat: seat))
    }

    return highest
}

func get_my_seat_number_part_b(seats: [String]) -> Int {
    var occupied_seats: Set<Int> = []

    for seat in seats {
        occupied_seats.insert(get_seat_id(seat: seat))
    }

    let sorted_occupied_seats = occupied_seats.sorted()

    var previouse_seat = -2
    var my_seat = -1

    for current_seat in sorted_occupied_seats {
        if current_seat - previouse_seat == 2 {
            my_seat = current_seat - 1
            break
        } else {
            previouse_seat = current_seat
        }
    }

    return my_seat
}

let file = "input" 

let seats = read_in_file(file: file)

print(get_highest_seat_part_a(seats: seats))
print(get_my_seat_number_part_b(seats: seats))

