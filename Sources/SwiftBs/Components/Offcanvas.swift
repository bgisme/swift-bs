
import SwiftHtml

open class Offcanvas: Div {
        
    public enum Placement {
        case start
        case end
        case top
        case bottom
        
        var `class`: Utility {
            switch self {
            case .start:
                return .offcanvasTop
            case .end:
                return .offcanvasEnd
            case .top:
                return .offcanvasTop
            case .bottom:
                return .offcanvasBottom
            }
        }
    }
    
    /// contents ... OffcanvasHeader, OffcanvasTitle, OffcanvasBody
    public init(id: String,
                placement: Placement,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .offcanvas)
            .class(insert: placement.class)
            .tabindex(-1)
            .id(id)
            .ariaLabelledBy("\(id)Label")
    }
}

extension Offcanvas {
        
    @discardableResult
    public func isBackgroundScrollable(if condition: Bool = true) -> Self {
        self
            .dataBsScroll(true, condition)
    }
    
    /// @NOTE: Background is dimmed by default. Use this to turn off dimming.
    @discardableResult
    public func isBackgroundVisible(if condition: Bool = true) -> Self {
        self
            .dataBsBackdrop(false, condition)
    }
}

/// contents ... anything (usually OffcanvasTitle + OffcanvasCloseButton)
open class OffcanvasHeader: Div {
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .offcanvasHeader)
    }
}

open class OffcanvasTitle: H5 {
    
    public convenience init(_ text: String, offcanvasId id: String) {
        self.init(id: id) { Text(text) }
    }
    
    public init(id: String,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .offcanvasTitle)
            .id(id + "Label")
    }
}

open class OffcanvasBody: Div {
        
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .offcanvasBody)
    }
}

open class OffcanvasCloseButton: Button {
    
    public convenience init() {
        self.init {}
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .type(.button)
            .class(insert: .btnClose, .textReset)
            .dataBsDismiss(.offcanvas)
            .ariaLabel("Close")
    }
}

open class OffcanvasButton: Tag {
    
    public enum Kind: String {
        case a
        case button
    }
    
    public init(_ kind: Kind,
                offcanvasId id: String,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .btn)
            .dataBsToggle(.offcanvas)
        switch kind {
        case .a:
            self
                .attribute("href", "#\(id)")
                .attribute("role", Attribute.Role.button.rawValue)
        case .button:
            self
                .type(.button)
                .dataBsTarget(id)
        }
    }
}
