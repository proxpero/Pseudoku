//
//  main.swift
//  tool
//
//  Created by Todd Olsen on 12/19/16.
//  Copyright © 2016 proxpero. All rights reserved.
//

import Foundation
import Pseudoku

testCross()
print(units)

print(puzzles)

for (index, puzzle) in puzzles.enumerated() {
    let startTime = CFAbsoluteTimeGetCurrent()
//    let grid = solve(puzzle)
    print(puzzle)
    let endTime = CFAbsoluteTimeGetCurrent()
    //        assert(grid != nil)
    //        display(grid!)
    //        print("puzzle at index \(index) solved in \(endTime - startTime) seconds\n")
}
print("finished")

