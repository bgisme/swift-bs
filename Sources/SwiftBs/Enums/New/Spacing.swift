//
//  Spacing.swift
//  
//
//  Created by Brad Gourley on 3/2/22.
//

public enum Spacing {
    case p(_ side: Side, _ size: Size)
    case m(_ side: Side, _ size: Size)
    case g(_ size: Size)
    case gx(_ size: Size)
    case gy(_ size: Size)
}

extension Spacing: CustomStringConvertible {
    public var description: String {
        switch self {
        case .p(let side, let size):
            return "p\(side)-\(size)"
        case .m(let side, let size):
            return "m\(side)-\(size)"
        case .g(let size):
            return "g-\(size)"
        case .gx(let size):
            return "gx-\(size)"
        case .gy(let size):
            return "gy-\(size)"
        }
    }
}
