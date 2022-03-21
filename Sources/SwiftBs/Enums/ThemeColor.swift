//
//  ThemeColor.swift
//  
//
//  Created by Brad Gourley on 3/21/22.
//

public enum ThemeColor {
    case primary
    case secondary
    case success
    case danger
    case warning
    case info
    case light
    case dark
}

extension ThemeColor {
    
    var color: Color {
        switch self {
        case .primary:
            return .primary
        case .secondary:
            return .secondary
        case .success:
            return .success
        case .danger:
            return .danger
        case .warning:
            return .warning
        case .info:
            return .info
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var buttonClass: BsClass {
        switch self {
        case .primary:
            return .btnPrimary
        case .secondary:
            return .btnSecondary
        case .success:
            return .btnSuccess
        case .danger:
            return .btnDanger
        case .warning:
            return .btnWarning
        case .info:
            return .btnInfo
        case .light:
            return .btnLight
        case .dark:
            return .btnDark
        }
    }
    
    var buttonOutlineClass: BsClass {
        switch self {
        case .primary:
            return .btnOutlinePrimary
        case .secondary:
            return .btnOutlineSecondary
        case .success:
            return .btnOutlineSuccess
        case .danger:
            return .btnOutlineDanger
        case .warning:
            return .btnOutlineWarning
        case .info:
            return .btnOutlineInfo
        case .light:
            return .btnOutlineLight
        case .dark:
            return .btnOutlineDark
        }
    }
}

extension ThemeColor {
    
    var backgroundClass: BsClass {
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
        }
    }
}
