//
//  Digit.swift
//  Engine
//
//  Created by Todd Olsen on 12/21/16.
//
//

public enum Digit: Int {
    case a = 1
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    case i

    public init?(_ character: Character) {
        guard
            let raw = Int(String(character)),
            let result = Digit(rawValue: raw)
            else { return nil }
        self = result
    }

    static var all: [Digit] {
        return [.a, .b, .c, .d, .e, .f, .g, .h, .i]
    }
}
