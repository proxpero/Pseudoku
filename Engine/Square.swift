////
////  Square.swift
////  Pseudoku
////
////  Created by Todd Olsen on 12/27/16.
////  Copyright © 2016 Todd Olsen. All rights reserved.
////
//
//public struct Square {
//
//    let location: Location
//    var possibilities: Set<Digit>
//
//
//    init(with location: Location, _ possibilities: Set<Digit> = Set(Digit.all)) {
//        self.location = location
//        self.possibilities = possibilities
//    }
//
//    func contains(_ digit: Digit) -> Bool {
//        return possibilities.contains(digit)
//    }
//
//    var solution: Digit? {
//        guard possibilities.count == 1, let solution = possibilities.first else {
//            return nil
//        }
//        return solution
//    }
//
//    mutating func assign(_ digit: Digit) {
//        for other in possibilities.subtracting([digit]) {
//            remove(other)
//        }
//    }
//
//    mutating func remove(_ digit: Digit) {
//        possibilities.remove(digit)
//        if let solution = solution {
////            delegate?.didSolve(self, with: solution)
//        }
//    }
//
//}
//
//extension Square: CustomStringConvertible {
//
//    public var description: String {
//        return "\(location)"
//    }
//    public var mark: String {
//        guard let solution = solution else { return "." }
//        return String(solution.rawValue)
//    }
//}
