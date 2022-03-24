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
    
    /// contents ...
    /// OffcanvasHeader
    /// OffcanvasTitle
    /// OffcanvasBody
    public convenience init(id: String,
                            placement: Placement = .start,
                            isBackgroundScrollable: Bool = false,   // background not scrollable by default
                            isBackdropVisible: Bool = true,         // backdrop visible by default
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(id: id,
                  placement: placement,
                  isBackgroundScrollable: isBackgroundScrollable,
                  isBackdropVisible: isBackdropVisible,
                  div)
    }
    
    public init(id: String,
                placement: Placement = .start,
                isBackgroundScrollable: Bool = false,
                isBackdropVisible: Bool = true,
                _ div: Div) {
        let place: BsClass
        switch placement {
        case .start:
            place = .offcanvasTop
        case .end:
            place = .offcanvasEnd
        case .top:
            place = .offcanvasTop
        case .bottom:
            place = .offcanvasBottom
        }
        div
            .class(insert: .offcanvas)
            .class(insert: place)
            .tabindex(-1)
            .id(id)
            .ariaLabelledBy("\(id)Label")
            .dataBsScroll(isBackgroundScrollable, isBackgroundScrollable)
            .dataBsBackdrop(!isBackdropVisible, !isBackdropVisible)
        
        super.init(div)
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
    
    public convenience init(offcanvasId id: String,
                            ariaControls: String,
                            a: () -> A) {
        let a = a()
            .href("#\(id)")
            .role(.button)
        self.init(ariaControls: ariaControls, a)
    }
    
    public convenience init(offcanvasId id: String,
                            ariaControls: String,
                            button: () -> Button) {
        let button = button()
            .type(.button)
            .dataBsTarget(id)
        self.init(ariaControls: ariaControls, button)
    }
    
    private init(ariaControls: String, _ tag: Tag) {
        tag
            .class(insert: .btn)
            .dataBsToggle(.offcanvas)
            .ariaControls(ariaControls)
        
        super.init(tag)
    }
}
