
import SwiftHtml

open class ToastContainer: Div {
    
    public init(@TagBuilder toasts: () -> [Toast]) {
        super.init(toasts())
        self
            .class(insert: .toastContainer)
    }
}

extension ToastContainer {
    
    public enum Placement {
        case topLeft
        case topCenter
        case topRight
        case middleLeft
        case middleCenter
        case middleRight
        case bottomLeft
        case bottomCenter
        case bottomRight
        
        var classes: [Utility] {
            switch self {
            case .topLeft:
                return [.top0, .start0]
            case .topCenter:
                return [.top0, .start50, .translateMiddleX]
            case .topRight:
                return [.top0, .end0]
            case .middleLeft:
                return [.top50, .start0, .translateMiddleY]
            case .middleCenter:
                return [.top50, .start50, .translateMiddle]
            case .middleRight:
                return [.top50, .end0, .translateMiddleY]
            case .bottomLeft:
                return [.bottom0, .start0]
            case .bottomCenter:
                return [.bottom0, .start50, .translateMiddleX]
            case .bottomRight:
                return [.bottom0, .end0]
            }
        }
    }
    
    @discardableResult
    public func placement(_ value: Placement, _ condition: Bool = true) -> Self {
        self
            .class(insert: value.classes, condition)
            .style(set: .position("fixed"), if: condition)
            .style(set: .zIndex("11"), if: condition)
    }
}

open class Toast: Div {
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .toast)
            .role(.status)
            .ariaLive(.polite)
            .ariaAtomic(true)
    }
        
    @discardableResult
    public func isImportant(if condition: Bool = true) -> Self {
        self
            .role(.alert, condition)
            .ariaLive(.assertive, condition)
    }
    
    @discardableResult
    public func placement(_ value: ToastContainer.Placement, _ condition: Bool = true) -> Self {
        self
            .class(insert: value.classes, condition)
            .style(set: .position("fixed"), if: condition)
            .style(set: .zIndex("11"), if: condition)
    }
    
    @discardableResult
    public func text(_ value: TextColor, _ condition: Bool = true) -> Self {
        self
            .class(insert: value.class, if: condition)
    }
    
    @discardableResult
    public func autoHideDelay(_ milliseconds: Int, _ condition: Bool = true) -> Self {
        self
            .dataBsDelay(milliseconds, condition)
    }
    
    @discardableResult
    public func isManualClose(if condition: Bool = true) -> Self {
        self
            .dataBsAutohide(false, condition)
    }
}

open class ToastHeader: Div {
    
    public convenience init(_ closeButton: CloseButton,
                            @TagBuilder content: () -> Tag) {
        self.init {
            content()
            closeButton.dismiss(.toast)
        }
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .toastHeader)
    }
}

open class ToastBody: Div {
    
    public convenience init(_ text: String) {
        self.init(content: { Text(text) })
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .toastBody)
    }
}
