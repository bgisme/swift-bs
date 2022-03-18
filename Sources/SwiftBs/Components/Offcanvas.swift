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
    let placement: BsClass?
    let isBackgroundScrollable: Bool
    let isBackdropVisible: Bool
    
    public init(id: String,
                placement: Placement = .start,
                isBackgroundScrollable: Bool = false,   // background not scrollable by default
                isBackdropVisible: Bool = true,         // backdrop visible by default
                div: () -> Div) {
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
        self.isBackgroundScrollable = isBackgroundScrollable
        self.isBackdropVisible = isBackdropVisible
        self.div = div()
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
            .dataBsScroll(isBackgroundScrollable, isBackgroundScrollable)
            .dataBsBackdrop(!isBackdropVisible, !isBackdropVisible)
            .merge(attributes)
    }
}

public class OffcanvasHeader: Component {
    
    let div: Div
    
    public init(div: () -> Div) {
        self.div = div()
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
    
    public convenience init(_ text: String, offcanvasId id: String) {
        self.init(offcanvasId: id) { H5(text) }
    }
    
    public init(offcanvasId id: String, h5: () -> H5) {
        self.id = id + "Label"
        self.h5 = h5()
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
    
    public init(div: () -> Div) {
        self.div = div()
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
    
    public convenience init(offcanvasId id: String, ariaControls: String, a: () -> A) {
        self.init(ariaControls: ariaControls) {
            a()
                .href("#\(id)")
                .role(.button)
        }
    }
    
    public convenience init(offcanvasId id: String, ariaControls: String, button: () -> Button) {
        self.init(ariaControls: ariaControls) {
            button()
                .type(.button)
                .dataBsTarget(id)
        }
    }
    
    internal init(ariaControls: String, tag: () -> Tag) {
        self.ariaControls = ariaControls
        self.tag = tag()
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
