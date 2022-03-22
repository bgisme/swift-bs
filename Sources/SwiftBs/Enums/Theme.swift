//
//  Theme.swift
//  
//
//  Created by Brad Gourley on 3/21/22.
//

public enum Theme: String, CaseIterable {
    case primary
    case secondary
    case success
    case danger
    case warning
    case info
    case light
    case dark
}

extension Theme {
    
    public var buttonClass: BsClass {
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
    
    public var buttonOutlineClass: BsClass {
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
        }
    }
    
    public var textClass: BsClass {
        switch self {
        case .primary:
            return .textPrimary
        case .secondary:
            return .textSecondary
        case .success:
            return .textSuccess
        case .danger:
            return .textDanger
        case .warning:
            return .textWarning
        case .info:
            return .textInfo
        case .light:
            return .textLight
        case .dark:
            return .textDark
        }
    }
}
