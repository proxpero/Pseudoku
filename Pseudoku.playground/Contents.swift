
import Pseudoku

let bundle = NSBundle.mainBundle()
let url = bundle.URLForResource("puzzles", withExtension: "txt")
let puzzles = try! String(contentsOfURL: url!).componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())

func run() {
    for (index, puzzle) in puzzles.enumerate() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let grid = solve(puzzle)
        let endTime = CFAbsoluteTimeGetCurrent()
        assert(grid != nil)
        display(grid!)
        print("puzzle at index \(index) solved in \(endTime - startTime) seconds\n")
    }
    print("finished")
}

//run()
