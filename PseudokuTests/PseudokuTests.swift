//
//  PseudokuTests.swift
//  PseudokuTests
//
//  Created by Todd Olsen on 3/8/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import XCTest
@testable import Pseudoku

class PseudokuTests: XCTestCase {
    
    func testCross() {
        let a = ["a", "b", "c", "d", "e"]
        let b = ["1", "2", "3", "4", "5"]
        let product = ["a1", "a2", "a3", "a4", "a5", "b1", "b2", "b3", "b4", "b5", "c1", "c2", "c3", "c4", "c5", "d1", "d2", "d3", "d4", "d5", "e1", "e2", "e3", "e4", "e5"]
        XCTAssertEqual(product, cross(a, b))
    }
    
    func testSquares() {
        XCTAssertEqual(squares.count, 81)
    }
    
    func testUnits() {
        
        for square in squares {
            XCTAssertEqual(units[square]!.count, 3)
        }
        
        let set = Set<Set<String>>([
            Set<String>(["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]),
            Set<String>(["A2", "B2", "C2", "D2", "E2", "F2", "G2", "H2", "I2"]),
            Set<String>(["C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9"])
            ])
        
        XCTAssertEqual(units["C2"], set)
    }
    
    func testPeers() {
        
        for s in squares {
            XCTAssertEqual(peers[s]!.count, 20)
        }
        
        let p = Set<Square>(["A2", "B2", "D2", "E2", "F2", "G2", "H2", "I2", "C1", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "A1", "A3", "B1", "B3"])
        XCTAssertEqual(peers["C2"], p)
        
    }
    
    func testAll() {
        
        let bundle = NSBundle(identifier: "proxpero.Pseudoku")!
        let url = bundle.URLForResource("puzzles", withExtension: "txt")
        let puzzles = try! String(contentsOfURL: url!).componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
        
        for (index, puzzle) in puzzles.enumerate() {
            let startTime = CFAbsoluteTimeGetCurrent()
            let grid = solve(puzzle)
            let endTime = CFAbsoluteTimeGetCurrent()
            XCTAssertNotNil(grid)
            display(grid!)
            print("puzzle at index \(index) solved in \(endTime - startTime) seconds")
        }
        print("finished")
        
    }
    
    
    func testPerformanceExample_NoSearch() {
        self.measureBlock {
            solve("003020600900305001001806400008102900700000008006708200002609500800203009005010300")
        }
    }
    
    func testPerformanceExample_Hard1() {
        self.measureBlock {
            solve("8 5 . |. . 2 |4 . . 7 2 . |. . . |. . 9 . . 4 |. . . |. . . ------+------+------. . . |1 . 7 |. . 2 3 . 5 |. . . |9 . . . 4 . |. . . |. . . ------+------+------. . . |. 8 . |. 7 . . 1 7 |. . . |. . . . . . |. 3 6 |. 4 .")
        }
    }
    
    func testPerformanceExample_Hard2() {
        self.measureBlock {
            solve(". . 5 |3 . . |. . . 8 . . |. . . |. 2 . . 7 . |. 1 . |5 . . ------+------+------4 . . |. . 5 |3 . . . 1 . |. 7 . |. . 6 . . 3 |2 . . |. 8 . ------+------+------. 6 . |5 . . |. . 9 . . 4 |. . . |. 3 . . . . |. . 9 |7 . .")
        }
    }
    
}
