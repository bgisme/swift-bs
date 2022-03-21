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
    public init(id: String,
                placement: Placement = .start,
                isBackgroundScrollable: Bool = false,   // background not scrollable by default
                isBackdropVisible: Bool = true,         // backdrop visible by default
                @TagBuilder contents: () -> [Tag]) {
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
        super.init {
            Div {
                contents()
            }
            .class(insert: .offcanvas)
            .class(insert: place)
            .tabindex(-1)
            .id(id)
            .ariaLabelledBy("\(id)Label")
            .dataBsScroll(isBackgroundScrollable, isBackgroundScrollable)
            .dataBsBackdrop(!isBackdropVisible, !isBackdropVisible)
        }
    }
}

/// contents ... anything (usually OffcanvasTitle + OffcanvasCloseButton)
public class OffcanvasHeader: Component {
        
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .offcanvasHeader)
        }
    }
}

public class OffcanvasTitle: Component {
    
    public convenience init(_ text: String,
                            offcanvasId id: String) {
        self.init(offcanvasId: id) { H5(text) }
    }
    
    public init(offcanvasId id: String,
                h5: () -> H5) {
        super.init {
            h5()
                .class(insert: .offcanvasTitle)
                .id(id + "Label")
        }
    }
}

public class OffcanvasBody: Component {
    
    /// contents ... anything
    public init(@TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .offcanvasBody)
        }
    }
}

public class OffcanvasCloseButton: Component {
    
    public init() {
        super.init {
            Button()
                .type(.button)
                .class(insert: .btnClose, .textReset)
                .dataBsDismiss(.offcanvas)
                .ariaLabel("Close")
        }
    }
}

public class OffcanvasButton: Component {
    
    public convenience init(offcanvasId id: String,
                            ariaControls: String,
                            a: () -> A) {
        self.init(ariaControls: ariaControls) {
            a()
                .href("#\(id)")
                .role(.button)
        }
    }
    
    public convenience init(offcanvasId id: String,
                            ariaControls: String,
                            button: () -> Button) {
        self.init(ariaControls: ariaControls) {
            button()
                .type(.button)
                .dataBsTarget(id)
        }
    }
    
    private init(ariaControls: String,
                 tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .btn)
                .dataBsToggle(.offcanvas)
                .ariaControls(ariaControls)
        }
    }
}
