//
//  Grid.swift
//  Engine
//
//  Created by Todd Olsen on 12/21/16.
//
//

public typealias Possibilities = Set<Digit>

public func solve(_ puzzle: String) -> Grid? {

    // Remove nonsense from the line of text.
    let cols = "123456789.".characters
    let refined = puzzle.characters.filter { cols.contains($0) }

    guard refined.count == 81 else { return nil }

    var grid = Grid()

    for (index, char) in refined.enumerated() {
        guard
            char != ".",
            let digit = Digit(char),
            let location = Location(rawValue: index)
            else { continue }
        guard let newGrid = grid.assigning(digit, to: location) else {
            return nil
        }
        grid = newGrid
    }

    return grid.searching(grid)
    
}

public struct Grid {

    var squares: Dictionary<Location, Possibilities>

    public init() {
        var result: Dictionary<Location, Possibilities> = [:]
        for location in Location.all {
            result[location] = Set(Digit.all)
        }
        squares = result
    }

    func searching(_ grid: Grid?) -> Grid? {

        guard let grid = grid else { return nil }

        if grid.allSolved {
            return grid
        }

        guard let candidate = grid.leastAmbiguousSquare() else {
            return nil
        }

        for digit in self[candidate] {
            guard
                let assignment = grid.assigning(digit, to: candidate),
                let newGrid = searching(assignment)
                else { continue }
            return newGrid
        }

        return nil
    }

    func assigning(_ digit: Digit, to location: Location) -> Grid? {

        var grid = self
        for other in self[location].subtracting([digit]) {
            guard let newGrid = grid.eliminating(other, from: location) else {
                return nil
            }
            grid = newGrid
        }
        return grid

    }

    func eliminating(_ digit: Digit, from location: Location) -> Grid? {

        var grid = self

        if !grid[location].contains(digit) {
            return grid
        }

        grid[location] = grid[location].subtracting([digit])

        guard grid[location].count > 0 else {
            return nil
        }

        if let solution = grid.solution(at: location) {
            for peer in location.peers {
                guard let newGrid = grid.eliminating(solution, from: peer) else {
                    return nil
                }
                grid = newGrid
            }
        }

        for unit in location.units {

            let places = unit.filter { grid[$0].contains(digit) }
            guard places.count == 1, let place = places.first else { return grid }
            if let newGrid = grid.assigning(digit, to: place) {
                grid = newGrid
            } else {
                return nil
            }

        }

        return grid

    }


    subscript (_ location: Location) -> Possibilities {
        get {
            return squares[location]!
        }
        set {
            squares[location] = newValue
        }
    }

    public func leastAmbiguousSquare() -> Location? {
        let min = squares
            .filter { $0.value.count > 1 }
            .min(by: { $0.0.value.count < $0.1.value.count })
        guard let m = min else { return nil }
        return m.key
    }

    var allSolved: Bool {
        return squares.flatMap { solution(at: $0.key) }.count == 81
    }

//    func search() -> Grid? {
//
//        if allSolved {
//            return self
//        }
//
//        guard let min = leastAmbiguousSquare() else {
//            fatalError()
//        }
//
//        for digit in self[min] {
//            print("trying \(digit.rawValue) at \(min)")
//            do {
//                var temp = self
//                try temp.assign(digit, to: min)
//                print("\tassignment succeeded")
//                if let g = temp.search() {
//                    print("**search succeeded\n\(temp)\n**")
//                    return g
//                } else {
//                    print("**search failed\n\(temp)\n**")
//                    continue
//                }
//            } catch {
//                print("\t**found discrepancy \(error)")
//                return nil
//            }
//        }
//        print("returning failure for \n\(self)")
//        return nil
//    }

    public func solution(at location: Location) -> Digit? {
        guard self[location].count == 1 else { return nil }
        return self[location].first!
    }

    func square(at location: Location, contains digit: Digit) -> Bool {
        guard let possibilities = squares[location] else { return false }
        return possibilities.contains(digit)
    }

//    mutating func assign(_ digit: Digit, to location: Location) throws {
//        print("(assign) Assigning \(digit.rawValue) to \(location)")
//        for other in self[location].subtracting([digit]) {
//            try remove(other, from: location)
//        }
//        print("(assign) ***** result of assignment:")
//        print(self)
//    }

    // if the operation is allowed it is carried out.
//    mutating func remove(_ digit: Digit, from location: Location) throws {
//        self[location] = self[location].subtracting([digit])
//        guard !self[location].isEmpty else { throw GridError.zeroPossibilities }
//        if let solution = solution(at: location) {
//            print("\t\t(remove)Did solve \(location) with \(solution.rawValue)")
//            didSolve(location, with: solution)
//            print("\t\t(remove) Result of solution:")
//            print(self)
//        }
//
//        for unit in location.units {
//            let places = unit.filter { self[$0].contains(digit) }
//            guard places.count == 1, let place = places.first else { return }
//            print("caught some:")
//            try self.assign(digit, to: place)
//            print("result")
//            print(self)
//        }
//    }

//    mutating func didSolve(_ square: Location, with digit: Digit) {
//        for peer in square.peers.filter({ solution(at: $0) == nil }) {
//            self[peer] = self[peer].subtracting([digit])
//        }
//    }

}

extension Grid: CustomStringConvertible {

    public var description: String {

        var result = "\n    a b c  d e f  g h i\n"

        for (index, string) in squares
            .map({ ($0.key.rawValue, $0.value.count == 1 ? "\($0.value.first!.rawValue)" : " ") })
            .sorted(by: { $0.0.0 < $0.1.0 })
        {
            if (index % 9 == 0) {
                result += " \((index / 9) + 1) "
            }
            
            result += " " + string
            if (index > 0 && index < 80 && index % 27 == 26) {
                result += "\n   ------+------+------\n"
                continue
            }
            if (index % 9 == 8) {
                result += "\n"
            }

            else if (index % 3 == 2) {
                result += "|"
            }
        }
        return result
    }


}
