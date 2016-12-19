//
//  Pseudoku.swift
//  Pseudoku
//
//  Created by Todd Olsen on 3/8/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import Foundation

public typealias Square  = String
public typealias Squares = Dictionary<Square,Set<Set<Square>>>
public typealias Digits  = Set<String>
public typealias Digit   = String
public typealias Grid    = Dictionary<Square, Digits>

public let nums = "123456789".characters.map { String($0) }
public let rows = "ABCDEFGHI".characters.map { String($0) }
public let cols = nums

public var puzzles: [String] = {
    let url = Bundle.main.url(forResource: "puzzles", withExtension: "txt")
    let puzzles = try! String(contentsOf: url!)
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: ", ")
    return puzzles
}()

public func cross(_ a: [String], _ b: [String]) -> [String] {
    
    var result: [String] = []
    for i in a {
        for j in b {
            result.append(i+j)
        }
    }
    return result
}

public let squares: [Square] = cross(rows, cols)

public let unitlist: [[String]] = {
    
    var result: [[String]] = []
    
    for c in cols {
        result.append(cross(rows, [c]))
    }
    
    for r in rows {
        result.append(cross([r], cols))
    }
    
    for r in stride(from: 0, to: 8, by: 3) {
        for c in stride(from: 0, to: 8, by: 3) {
            result.append(cross(Array(rows[r..<r+3]), Array(cols[c..<c+3])))
        }
    }
    
    return result
    
}()

// Units of a square are the groups of other squares with which the square may not share digits.
// Every square has 3 units, each containing 9 squares: horizontal, vertical and square.
public let units: Squares = {
    
    let unitlist: [[String]] = {
        var result: [[String]] = []
        for c in cols { result.append(cross(rows, [c])) }
        for r in rows { result.append(cross([r], cols)) }

        for r in stride(from: 0, to: 8, by: 3) {
            for c in stride(from: 0, to: 8, by: 3) {
                result.append(cross(Array(rows[r..<r+3]), Array(cols[c..<c+3])))
            }
        }
        
        return result        
    }()
    
    var units = Squares()
    for square in squares {
        units[square] = Set<Set<String>>(unitlist.filter { $0.contains(square) }.map { Set<String>($0) })
    }
    return units
}()

// Peers are all the the other squares with which a square may not share a digits.
// Every square has 20 peers.
public let peers: Dictionary<Square, Set<Square>> = {
    
    var dict = Dictionary<Square, Set<Square>>()
    for s in squares {
        var u = Set<Square>()
        for unit in units[s]! {
            u.formUnion(unit)
        }
        dict[s] = u.subtracting([s])
    }
    
    return dict
}()

public func solve(_ puzzle: String) -> Grid? {
    
    // Initialize new grid.
    var grid: Grid? = {
        var grid: Grid? = Grid(minimumCapacity: 81)
        for square in squares {
            grid![square] = Set<String>(nums)
        }
        return grid
    }()

    // Remove nonsense from the line of text.
    let refined = puzzle.characters.map { String($0) }.filter { nums.contains($0) || ["0", "."].contains($0) }
    
    // Make assignments given by the puzzle.
    for (index, candidate) in refined.enumerated() {
        if nums.contains(candidate) {
            grid = assign(candidate, toSquare: squares[index], inGrid: grid!)
        }
    }
    
    // Deduce the remaining digits.
    if let result = search(grid) {
        return result
    }
    
    return nil
}

public func search(_ searchStore: Grid?) -> Grid? {
    
    guard let grid = searchStore else { return nil }

    // If the sets for all squares each contain only one value return the grid.
    if (squares.map { grid[$0]!.count }.reduce(0) { $0 + $1 }) == 81 {
        return grid
    }
    
    // Search least ambiguous squares first. (Ones whose sets contain fewest values)
    let candidate = squares.map { (square:$0, digits:grid[$0]!) }.filter { $0.digits.count > 1 }.min(by: { (one, two) -> Bool in
        one.digits.count < two.digits.count
    })
    
    // Try the possible digits to see if there are any inconsistencies.
    if candidate != nil {
        for digit in candidate!.digits {
            if let newStore = search(assign(digit, toSquare: candidate!.square, inGrid: grid)) {
                return newStore
            } else {
                continue
            }
        }
    }
    
    return nil
}

public func assign(_ digit: Digit, toSquare square: Square, inGrid incoming: Grid) -> Grid? {
    
    var grid = incoming
    
    // When a digit is assigned, remove that digit from the square's possiblities.
    let others = grid[square]!.subtracting([digit])
    for other in others {
        if let newStore = eliminate(other, fromSquare: square, inStore: grid) {
            grid = newStore
        } else {
            return nil
        }
    }
    
    return grid
}

public func eliminate(_ digit: Digit, fromSquare square: Square, inStore incoming: Grid) -> Grid? {
    
    var grid = incoming
    
    // If it's already gone, return
    if !grid[square]!.contains(digit) {
        return grid
    }
    
    // Remove the digit from the squares possible values.
    grid[square]!.subtract([digit])
    
    // If there are no more possibilities, there is an inconsistency.
    if grid[square]!.count == 0 {
        return nil
    }
    
    // If the square now only has one possible digit, recursively elimintate that digit from the square's peers.
    if grid[square]!.count == 1 {
        
        let newDigit = grid[square]!.first!
        for sq in peers[square]! {
            if let newStore = eliminate(newDigit, fromSquare: sq, inStore: grid) {
                grid = newStore
            } else {
                return nil
            }
        }
    }
    
    // If any of the square's units now only have one place for the digit, assign the digit there.
    // go through each unit for the square...
    for unit in units[square]! {
        // count how many squares in the unit have this digit as a possible value.
        let places = unit.filter { grid[$0]!.contains(digit) }
        // if only one square in the unit is able to place the digit, assign the digit to that square.
        if places.count == 1 {
            if let newStore = assign(digit, toSquare: places.first!, inGrid: grid) {
                grid = newStore
            } else {
                return nil
            }
        }
    }
    
    return grid
}

public func display(_ solvedGrid: Grid) {
    
    let puzzle = squares.map { solvedGrid[$0]!.first! }
    
    var result = ""
    for i in 1...81 {
        
        result += puzzle[i-1] + " "
        
        if i == 81 { break }
        
        if (i > 1 && i < 80 && i % 27 == 0) {
            result += "\n------+------+------\n"
            continue
        }
        
        if (i % 9 == 0) {
            result += "\n"
        }
            
        else if (i % 3 == 0) {
            result += "|"
        }
        
    }
    print(result)
}

