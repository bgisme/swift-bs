//
//  Offcanvas.swift
//  
//
//  Created by Brad Gourley on 3/17/22.
//

import SwiftHtml

public class Offcanvas: Component {
    
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
    
    /// contents ...
    /// OffcanvasHeader
    /// OffcanvasTitle
    /// OffcanvasBody
    public convenience init(id: String,
                            placement: Placement,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(id: id,
                  placement: placement,
                  div)
    }
    
    public init(id: String,
                placement: Placement,
                _ div: Div) {
        div
            .class(insert: .offcanvas)
            .class(insert: placement.class)
            .tabindex(-1)
            .id(id)
            .ariaLabelledBy("\(id)Label")
        
        super.init(div)
    }
    
    @discardableResult
    public func isBackgroundScrollable(if condition: Bool = true) -> Self {
        tag
            .dataBsScroll(true, condition)

        return self
    }
    
    /// @NOTE: Background is dimmed by default. Use this to turn off dimming.
    @discardableResult
    public func isBackgroundVisible(if condition: Bool = true) -> Self {
        tag
            .dataBsBackdrop(false, condition)
        return self
    }
}

/// contents ... anything (usually OffcanvasTitle + OffcanvasCloseButton)
public class OffcanvasHeader: Component {
        
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .offcanvasHeader)
        
        super.init(div)
    }
}

public class OffcanvasTitle: Component {
    
    public convenience init(_ text: String, offcanvasId id: String) {
        self.init(offcanvasId: id, H5(text))
    }
    
    public init(offcanvasId id: String, _ h5: H5) {
        _ = h5
            .class(insert: .offcanvasTitle)
            .id(id + "Label")
        
        super.init(h5)
    }
}

public class OffcanvasBody: Component {
    
    /// contents ... anything
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .offcanvasBody)

        super.init(div)
    }
}

public class OffcanvasCloseButton: Component {
    
    public init(_ button: Button = Button()) {
        button
            .type(.button)
            .class(insert: .btnClose, .textReset)
            .dataBsDismiss(.offcanvas)
            .ariaLabel("Close")

        super.init(button)
    }
}

public class OffcanvasButton: Component {
    
    public convenience init(offcanvasId id: String, a: () -> A) {
        let a = a()
            .href("#\(id)")
            .role(.button)
        self.init(a)
    }
    
    public convenience init(offcanvasId id: String, button: () -> Button) {
        let button = button()
            .type(.button)
            .dataBsTarget(id)
        self.init(button)
    }
    
    private override init(_ tag: Tag) {
        tag
            .class(insert: .btn)
            .dataBsToggle(.offcanvas)
        
        super.init(tag)
    }
}
