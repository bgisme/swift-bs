
public enum AlignItems: CaseIterable {
    case start
    case end
    case center
    case baseline
    case stretch
    case smStart
    case smEnd
    case smCenter
    case smBaseline
    case smStretch
    case mdStart
    case mdEnd
    case mdCenter
    case mdBaseline
    case mdStretch
    case lgStart
    case lgEnd
    case lgCenter
    case lgBaseline
    case lgStretch
    case xlStart
    case xlEnd
    case xlCenter
    case xlBaseline
    case xlStretch
    case xxlStart
    case xxlEnd
    case xxlCenter
    case xxlBaseline
    case xxlStretch
    
    var `class`: Utility {
        switch self {
        case .start: return .alignItemsStart
        case .end: return .alignItemsEnd
        case .center: return .alignItemsCenter
        case .baseline: return .alignItemsBaseline
        case .stretch: return .alignItemsStretch
        case .smStart: return .alignItemsSmStart
        case .smEnd: return .alignItemsSmEnd
        case .smCenter: return .alignItemsSmCenter
        case .smBaseline: return .alignItemsSmBaseline
        case .smStretch: return .alignItemsSmStretch
        case .mdStart: return .alignItemsMdStart
        case .mdEnd: return .alignItemsMdEnd
        case .mdCenter: return .alignItemsMdCenter
        case .mdBaseline: return .alignItemsMdBaseline
        case .mdStretch: return .alignItemsMdStretch
        case .lgStart: return .alignItemsLgStart
        case .lgEnd: return .alignItemsLgEnd
        case .lgCenter: return .alignItemsLgCenter
        case .lgBaseline: return .alignItemsLgBaseline
        case .lgStretch: return .alignItemsLgStretch
        case .xlStart: return .alignItemsXlStart
        case .xlEnd: return .alignItemsXlEnd
        case .xlCenter: return .alignItemsXlCenter
        case .xlBaseline: return .alignItemsXlBaseline
        case .xlStretch: return .alignItemsXlStretch
        case .xxlStart: return .alignItemsXxlStart
        case .xxlEnd: return .alignItemsXxlEnd
        case .xxlCenter: return .alignItemsXxlCenter
        case .xxlBaseline: return .alignItemsXxlBaseline
        case .xxlStretch: return .alignItemsXxlStretch
        }
    }
}
