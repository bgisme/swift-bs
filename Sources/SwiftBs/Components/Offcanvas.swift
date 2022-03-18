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
    }
    
    let div: Div
    let id: String
    public private(set) var placement: BsClass?
    public private(set) var isBackgroundScrollable: Bool
    public private(set) var isBackdropHidden: Bool
    
    public init(_ div: Div, id: String, placement: Placement = .start) {
        self.div = div
        self.id = id
        switch placement {
        case .start:
            self.placement = .offcanvasTop
        case .end:
            self.placement = .offcanvasEnd
        case .top:
            self.placement = .offcanvasTop
        case .bottom:
            self.placement = .offcanvasBottom
        }
        self.isBackgroundScrollable = false // background not scrollable by default
        self.isBackdropHidden = false   // backdrop visible by default
    }
    
    @discardableResult
    public func isBackgroundScrollable(_ value: Bool, _ condition: Bool = true) -> Self {
        self.isBackgroundScrollable = value
        return self
    }
    
    @discardableResult
    public func isBackdropHidden(_ value: Bool, _ condition: Bool = true) -> Self {
        self.isBackdropHidden = value
        return self
    }
}

extension Offcanvas: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .offcanvas)
            .class(add: placement)
            .tabindex(-1)
            .id(id)
            .ariaLabelledBy("\(id)Label")
            .dataBsScroll(true, isBackgroundScrollable)  // enable scrolling
            .dataBsBackdrop(false, isBackdropHidden)     // hide backdrop
            .merge(attributes)
    }
}

public class OffcanvasHeader: Component {
    
    let div: Div
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension OffcanvasHeader: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .offcanvasHeader)
            .merge(attributes)
    }
}

public class OffcanvasTitle: Component {
    
    let h5: H5
    let id: String
    
    public init(_ h5: H5, offcanvas id: String) {
        self.h5 = h5
        self.id = id + "Label"
    }
}

extension OffcanvasTitle: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        h5
            .class(add: .offcanvasTitle)
            .id(id)
            .merge(attributes)
    }
}

public class OffcanvasBody: Component {
    
    let div: Div
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension OffcanvasBody: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .offcanvasBody)
            .merge(attributes)
    }
}

public class OffcanvasCloseButton: Component { }

extension OffcanvasCloseButton: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        Button()
            .type(.button)
            .class(add: .btnClose, .textReset)
            .dataBsDismiss(.offcanvas)
            .ariaLabel("Close")
            .merge(attributes)
    }
}

public class OffcanvasButton: Component {
    
    let tag: Tag
    let ariaControls: String
    
    public convenience init(_ a: A, offcanvas id: String, ariaControls: String) {
        _ = a
            .href("#\(id)")
            .role(.button)
        self.init(tag: a, ariaControls: ariaControls)
    }
    
    public convenience init(_ button: Button, offcanvas id: String, ariaControls: String) {
        _ = button
            .type(.button)
            .dataBsTarget(id)
        self.init(tag: button, ariaControls: ariaControls)
    }
    
    internal init(tag: Tag, ariaControls: String) {
        self.tag = tag
        self.ariaControls = ariaControls
    }
}

extension OffcanvasButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .btn)
            .dataBsToggle(.offcanvas)
            .ariaControls(ariaControls)
            .merge(attributes)
    }
}
