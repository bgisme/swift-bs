//
//  TextAlign.swift
//  
//
//  Created by Brad Gourley on 3/22/22.
//

public enum TextAlign {
    case textStart
    case textSmStart
    case textMdStart
    case textLgStart
    case textXlStart
    case textCenter
    case textSmCenter
    case textMdCenter
    case textLgCenter
    case textXlCenter
    case textEnd
    case textSmEnd
    case textMdEnd
    case textLgEnd
    case textXlEnd

    var `class`: BsClass {
        switch self {
        case .textStart: return .textStart
        case .textSmStart: return .textSmStart
        case .textMdStart: return .textMdStart
        case .textLgStart: return .textLgStart
        case .textXlStart: return .textXlStart
        case .textCenter: return .textCenter
        case .textSmCenter: return .textSmCenter
        case .textMdCenter: return .textMdCenter
        case .textLgCenter: return .textLgCenter
        case .textXlCenter: return .textXlCenter
        case .textEnd: return .textEnd
        case .textSmEnd: return .textSmEnd
        case .textMdEnd: return .textMdEnd
        case .textLgEnd: return .textLgEnd
        case .textXlEnd: return .textXlEnd
        }
    }
}
