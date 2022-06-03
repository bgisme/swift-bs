
public enum Column {
    case col
    case col2
    case col3
    case col4
    case col5
    case col6
    case col7
    case col8
    case col9
    case col10
    case col11
    case col12
    
    public var `class`: Utility {
        switch self {
        case .col:
            return .col
        case .col2:
            return .col2
        case .col3:
            return .col3
        case .col4:
            return .col4
        case .col5:
            return .col5
        case .col6:
            return .col6
        case .col7:
            return .col7
        case .col8:
            return .col8
        case .col9:
            return .col9
        case .col10:
            return .col10
        case .col11:
            return .col11
        case .col12:
            return .col12
        }
    }
}
