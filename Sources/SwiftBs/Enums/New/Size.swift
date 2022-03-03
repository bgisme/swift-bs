//
//  Size.swift
//  
//
//  Created by Brad Gourley on 3/2/22.
//

public enum Size: String {
    case _0 = "0"
    case _1 = "1"
    case _2 = "2"
    case _3 = "3"
    case _4 = "4"
    case _5 = "5"
    case auto
}

extension Size: CustomStringConvertible {
    public var description: String { rawValue }
}
