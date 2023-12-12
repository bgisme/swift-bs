
import SwiftHtml

open class Spinner: Div {
    
    public enum Style {
        case border
        case grow
        
        public var `class`: Utility {
            switch self {
            case .border:
                return .spinnerBorder
            case .grow:
                return .spinnerGrow
            }
        }
        
        public var smallClass: Utility {
            switch self {
            case .border:
                return .spinnerBorderSm
            case .grow:
                return .spinnerGrowSm
            }
        }
    }
        
    /// @Note: Supply text and <span> will be inserted into <div>
    public convenience init(_ text: String? = nil,
                            style: Style,
                            isSmall: Bool = false) {
        self.init(style: style, isSmall: isSmall) {
            if let text = text {
                Span {
                    Text(text)
                }.class(insert: .visuallyHidden)
            }
        }
    }
    
    public init(style: Style,
                isSmall: Bool,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: style.class)
            .class(insert: style.smallClass, if: isSmall)
            .role(.status)
    }
}

extension Spinner {
        
    @discardableResult
    public func theme(_ value: ColorTheme, _ condition: Bool = true) -> Self {
        self
            .class(insert: value.textClass, if: condition)
    }
}

open class ButtonSpinner: Span {
    
    public convenience init(style: Spinner.Style) {
        self.init(style: style) {}
    }
    
    public init(style: Spinner.Style,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: style.class)
            .class(insert: style.smallClass)
            .role(.status)
            .ariaHidden(true)
    }
}
