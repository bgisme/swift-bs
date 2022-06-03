
import SwiftHtml
import Darwin

public class Spinner: Component {
    
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
    public convenience init(_ text: String? = nil, style: Style, isSmall: Bool = false) {
        let div = Div {
            if let text = text {
                Span(text)
                    .class(insert: .visuallyHidden)
            }
        }
        self.init(style: style, isSmall: isSmall, div)
    }
    
    private init(style: Style, isSmall: Bool, _ div: Div) {
        div
            .class(insert: style.class)
            .class(insert: style.smallClass, if: isSmall)
            .role(.status)
        
        super.init(div)
    }
        
    @discardableResult
    public func theme(_ value: ColorTheme, _ condition: Bool = true) -> Self {
        tag
            .class(insert: value.textClass, if: condition)
        return self
    }
}

public class ButtonSpinner: Component {
    
    public convenience init(style: Spinner.Style) {
        let span = Span()
        self.init(style: style, span)
    }
    
    public init(style: Spinner.Style, _ span: Span) {
        span
            .class(insert: style.class)
            .class(insert: style.smallClass)
            .role(.status)
            .ariaHidden(true)
        
        super.init(span)
    }
}
