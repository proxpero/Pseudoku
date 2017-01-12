Pseudoku Engine
===============
The pseudoku engine can solve sudoku puzzles. 
# Usage
```
  import Engine
  let puzzle = "...............9..97.3......1..6.5....47.8..2.....2..6.31..4......8..167.87......"
  let grid = solve(puzzle)!
  print(grid)
```
Result:
```
    a b c  d e f  g h i
 1  1 2 3| 9 4 6| 7 8 5
 2  8 4 6| 2 5 7| 9 3 1
 3  9 7 5| 3 8 1| 6 2 4
   ------+------+------
 4  3 1 2| 4 6 9| 5 7 8
 5  5 6 4| 7 1 8| 3 9 2
 6  7 9 8| 5 3 2| 4 1 6
   ------+------+------
 7  2 3 1| 6 7 4| 8 5 9
 8  4 5 9| 8 2 3| 1 6 7
 9  6 8 7| 1 9 5| 2 4 3
```
