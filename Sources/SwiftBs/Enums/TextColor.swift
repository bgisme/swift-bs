
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
    case body
    case muted
    case opacity25
    case opacity50
    case opacity75
    
    var `class`: Utility {
        switch self {
        case .primary: return .textPrimary
        case .secondary: return .textSecondary
        case .success: return .textSuccess
        case .danger: return .textDanger
        case .warning: return .textWarning
        case .info: return .textInfo
        case .light: return .textLight
        case .dark: return .textDark
        case .white: return .textWhite
        case .body: return .textBody
        case .muted: return .textMuted
        case .opacity25: return .textOpacity25
        case .opacity50: return .textOpacity50
        case .opacity75: return .textOpacity75
        }
    }
}
