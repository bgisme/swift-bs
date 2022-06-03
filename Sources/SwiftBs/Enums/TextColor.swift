
public enum TextColor {
    case primary
    case secondary
    case success
    case danger
    case warning
    case info
    case light
    case dark
    case white
    case white50
    case black50
    case body
    case muted
    
    var `class`: Utility {
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
        case .white:
            return .textWhite
        case .white50:
            return .textWhite50
        case .black50:
            return .textBlack50
        case .body:
            return .textBody
        case .muted:
            return .textMuted
        }
    }
}
