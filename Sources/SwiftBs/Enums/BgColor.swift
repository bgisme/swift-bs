//
//  File.swift
//  
//
//  Created by Brad Gourley on 3/19/22.
//

public enum BgColor: String {
    case bgDanger = "bg-danger"
    case bgDark = "bg-dark"
    case bgBody = "bg-body"
    case bgInfo = "bg-info"
    case bgLight = "bg-light"
    case bgPrimary = "bg-primary"
    case bgSecondary = "bg-secondary"
    case bgSuccess = "bg-success"
    case bgTransparent = "bg-transparent"
    case bgWarning = "bg-warning"
    case bgWhite = "bg-white"
    
    public var `class`: BsClass? {
        return BsClass.init(rawValue: self.rawValue)
    }
}
