
public enum AlignText: CaseIterable {
    case start
    case startSm
    case startMd
    case startLg
    case startXl
    case center
    case centerSm
    case centerMd
    case centerLg
    case centerXl
    case end
    case endSm
    case endMd
    case endLg
    case endXl

    var `class`: Utility {
        switch self {
        case .start: return .textStart
        case .startSm: return .textSmStart
        case .startMd: return .textMdStart
        case .startLg: return .textLgStart
        case .startXl: return .textXlStart
        case .center: return .textCenter
        case .centerSm: return .textSmCenter
        case .centerMd: return .textMdCenter
        case .centerLg: return .textLgCenter
        case .centerXl: return .textXlCenter
        case .end: return .textEnd
        case .endSm: return .textSmEnd
        case .endMd: return .textMdEnd
        case .endLg: return .textLgEnd
        case .endXl: return .textXlEnd
        }
    }
}
