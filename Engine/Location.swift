//
//  Location.swift
//  Engine
//
//  Created by Todd Olsen on 12/21/16.
//
//

public enum Location: Int {

    case a1
    case b1
    case c1
    case d1
    case e1
    case f1
    case g1
    case h1
    case i1
    case a2
    case b2
    case c2
    case d2
    case e2
    case f2
    case g2
    case h2
    case i2
    case a3
    case b3
    case c3
    case d3
    case e3
    case f3
    case g3
    case h3
    case i3
    case a4
    case b4
    case c4
    case d4
    case e4
    case f4
    case g4
    case h4
    case i4
    case a5
    case b5
    case c5
    case d5
    case e5
    case f5
    case g5
    case h5
    case i5
    case a6
    case b6
    case c6
    case d6
    case e6
    case f6
    case g6
    case h6
    case i6
    case a7
    case b7
    case c7
    case d7
    case e7
    case f7
    case g7
    case h7
    case i7
    case a8
    case b8
    case c8
    case d8
    case e8
    case f8
    case g8
    case h8
    case i8
    case a9
    case b9
    case c9
    case d9
    case e9
    case f9
    case g9
    case h9
    case i9

    public static var all: [Location] {
        return [
            .a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1, .i1,
            .a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2, .i2,
            .a3, .b3, .c3, .d3, .e3, .f3, .g3, .h3, .i3,
            .a4, .b4, .c4, .d4, .e4, .f4, .g4, .h4, .i4,
            .a5, .b5, .c5, .d5, .e5, .f5, .g5, .h5, .i5,
            .a6, .b6, .c6, .d6, .e6, .f6, .g6, .h6, .i6,
            .a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7, .i7,
            .a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8, .i8,
            .a9, .b9, .c9, .d9, .e9, .f9, .g9, .h9, .i9
        ]
    }

    public static var rows: [[Location]] {
        return [
            [.a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1, .i1],
            [.a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2, .i2],
            [.a3, .b3, .c3, .d3, .e3, .f3, .g3, .h3, .i3],
            [.a4, .b4, .c4, .d4, .e4, .f4, .g4, .h4, .i4],
            [.a5, .b5, .c5, .d5, .e5, .f5, .g5, .h5, .i5],
            [.a6, .b6, .c6, .d6, .e6, .f6, .g6, .h6, .i6],
            [.a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7, .i7],
            [.a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8, .i8],
            [.a9, .b9, .c9, .d9, .e9, .f9, .g9, .h9, .i9]
        ]
    }

    public static var columns: [[Location]] {
        return [
            [.a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9],
            [.b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9],
            [.c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9],
            [.d1, .d2, .d3, .d4, .d5, .d6, .d7, .d8, .d9],
            [.e1, .e2, .e3, .e4, .e5, .e6, .e7, .e8, .e9],
            [.f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8, .f9],
            [.g1, .g2, .g3, .g4, .g5, .g6, .g7, .g8, .g9],
            [.h1, .h2, .h3, .h4, .h5, .h6, .h7, .h8, .h9],
            [.i1, .i2, .i3, .i4, .i5, .i6, .i7, .i8, .i9]
        ]
    }

    public static var boxes: [[Location]] {
        return [
            [.a1, .b1, .c1, .a2, .b2, .c2, .a3, .b3, .c3],
            [.d1, .e1, .f1, .d2, .e2, .f2, .d3, .e3, .f3],
            [.g1, .h1, .i1, .g2, .h2, .i2, .g3, .h3, .i3],
            [.a4, .b4, .c4, .a5, .b5, .c5, .a6, .b6, .c6],
            [.d4, .e4, .f4, .d5, .e5, .f5, .d6, .e6, .f6],
            [.g4, .h4, .i4, .g5, .h5, .i5, .g6, .h6, .i6],
            [.a7, .b7, .c7, .a8, .b8, .c8, .a9, .b9, .c9],
            [.d7, .e7, .f7, .d8, .e8, .f8, .d9, .e9, .f9],
            [.g7, .h7, .i7, .g8, .h8, .i8, .g9, .h9, .i9]
        ]
    }

    public var row: Int {
        return rawValue/9
    }

    public var column: Int {
        return rawValue % 9
    }

    public var box: Int {
        for (index, locations) in Location.boxes.enumerated() {
            if locations.contains(self) { return index }
        }
        fatalError()
    }

    public var peers: Set<Location> {
        return Set(Location.rows[self.row])
            .union(Set(Location.columns[self.column]))
            .union(Set(Location.boxes[self.box]))
            .subtracting([self])
    }

    public var units: [[Location]] {
        return [
            Location.rows[row],
            Location.columns[column],
            Location.boxes[box]
        ]
    }
    
}

