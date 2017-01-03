//
//  EngineTests.swift
//  EngineTests
//
//  Created by Todd Olsen on 12/21/16.
//
//

import XCTest
@testable import Engine

class SquareTests: XCTestCase {

}

class GridTests: XCTestCase {

    func testAssignment() {
        var grid: Grid? = Grid()
        grid = grid!.assigning(.a, to: .a1)
        XCTAssertNotNil(grid)
        XCTAssertEqual(grid![.a1].count, 1)
        XCTAssertEqual(grid![.a1].first!, .a)
    }

    func testSolution() {
        var grid: Grid? = Grid()
        XCTAssertNil(grid?.solution(at: .a1))
        grid = grid?.assigning(.a, to: .a1)
        XCTAssertNotNil(grid?.solution(at: .a1))
        XCTAssertEqual(grid?.solution(at: .a1)!, Digit.a)
    }

    func testAssignmentRemovesDigitFromPeer() {

        var grid: Grid? = Grid()
        grid = grid?.assigning(.a, to: .a1)

        XCTAssertNotNil(grid)

        print(grid![.a2].count)
        print(grid![.a2])

        // Same column
        XCTAssertEqual(grid![.a2].count, 8)
        XCTAssertFalse(grid![.a2].contains(.a))

        // Same row
        XCTAssertEqual(grid![.f1].count, 8)
        XCTAssertFalse(grid![.f1].contains(.a))

        // Same box
        XCTAssertEqual(grid![.c3].count, 8)
        XCTAssertFalse(grid![.c3].contains(.a))

    }

    func testLeastAmbiguousSquare() {

        var grid: Grid? = Grid()
        grid = grid?
            .assigning(.a, to: .a1)?
            .assigning(.b, to: .b2)?
            .assigning(.c, to: .c3)

        let expectations: Set<Location> = [.a2, .a3, .b1, .b3, .c1, .c2]
        let min = grid?.leastAmbiguousSquare()
        XCTAssertNotNil(min)
        print(min!)
        XCTAssertTrue(expectations.contains(min!))

    }

    func testSolving() {
        var grid: Grid? = Grid()
        grid = solve("...............9..97.3......1..6.5....47.8..2.....2..6.31..4......8..167.87......")
        XCTAssertNotNil(grid)
        print(grid!)
        
    }

    func testAll() {

        let url = Bundle(for: GridTests.self).url(forResource: "puzzles", withExtension: "txt")!
        let puzzles = try! String(contentsOf: url).components(separatedBy: .newlines)

        for (index, puzzle) in puzzles.enumerated() {
            let startTime = CFAbsoluteTimeGetCurrent()
            let grid = solve(puzzle)
            let endTime = CFAbsoluteTimeGetCurrent()
            XCTAssertNotNil(grid)
            print("puzzle at index \(index) solved in \(endTime - startTime) seconds")
        }



    }



}
