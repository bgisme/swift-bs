//
//  File.swift
//  
//
//  Created by Brad Gourley on 3/2/22.
//

public enum Background: String {
    case danger = "bg-danger"
    case dark = "bg-dark"
    case body = "bg-body"
    case info = "bg-info"
    case light = "bg-light"
    case primary = "bg-primary"
    case secondary = "bg-secondary"
    case success = "bg-success"
    case transparent = "bg-transparent"
    case warning = "bg-warning"
    case white = "bg-white"
}

extension Background: CustomStringConvertible {
    public var description: String { rawValue }
}
