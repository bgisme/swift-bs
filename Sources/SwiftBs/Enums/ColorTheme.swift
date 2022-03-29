//
//  ColorTheme.swift
//  
//
//  Created by Brad Gourley on 3/21/22.
//

public enum ColorTheme: String, CaseIterable {
    case primary
    case secondary
    case success
    case danger
    case warning
    case info
    case light
    case dark
    case white
}

extension ColorTheme {
        
    public var backgroundClass: BsClass {
        switch self {
        case .primary:
            return .bgPrimary
        case .secondary:
            return .bgSecondary
        case .success:
            return .bgSuccess
        case .danger:
            return .bgDanger
        case .warning:
            return .bgWarning
        case .info:
            return .bgInfo
        case .light:
            return .bgLight
        case .dark:
            return .bgDark
        case .white:
            return .bgWhite
        }
    }
    
    public var borderClass: BsClass {
        switch self {
        case .primary:
            return .borderPrimary
        case .secondary:
            return .borderSecondary
        case .success:
            return .borderSuccess
        case .danger:
            return .borderDanger
        case .warning:
            return .borderWarning
        case .info:
            return .borderInfo
        case .light:
            return .borderLight
        case .dark:
            return .borderDark
        case .white:
            return .borderWhite
        }
    }
}
