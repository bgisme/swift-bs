//
//  Navbar.swift
//  
//
//  Created by Brad Gourley on 3/17/22.
//

import SwiftHtml

public class Navbar: Component {
    
    public enum Placement {
        case fixedTop
        case fixedBottom
        case stickyTop  //! May not be supported by every browser
    }
    
    /// collapseBelow = nil ... auto-collapses behind toggler button
    public init(placement place: Placement? = nil,
                collapseAt breakpoint: Breakpoint? = nil,
                nav: () -> Nav) {
        let placement: BsClass?
        switch place {
        case .fixedTop:
            placement = .fixedTop
        case .fixedBottom:
            placement = .fixedBottom
        case .stickyTop:
            placement = .stickyTop
        default:
            placement = nil
        }
        let expand: BsClass?
        switch breakpoint {
        case .sm:
            expand = .navbarExpandSm
        case .md:
            expand = .navbarExpandMd
        case .lg:
            expand = .navbarExpandLg
        case .xl:
            expand = .navbarExpandXl
        case .xxl:
            expand = .navbarExpandXxl
        default:
            expand = nil
        }
        super.init {
            nav()
                .class(insert: .navbar)
                .class(insert: placement)
                .class(insert: expand)
        }
    }
}

public class NavbarContainer: Component {
    
    /// isFluid: false if NavbarBrand is just an image and no text
    public init(isFluid: Bool = true, div: () -> Div) {
        super.init {
            div()
                .class(insert: isFluid ? .containerFluid : .container)
        }
    }
}

public class NavbarBrand: Component {
        
    public convenience init(_ title: String, href: String? = nil) {
        self.init(tag: {
            if let href = href {
                return A(title).href(href)
            } else {
                return Span(title).class(insert: .mb0, .h1)
            }
        })
    }
    
    public convenience init(span: () -> Span) {
        self.init(tag: span)
    }

    public convenience init(a: () -> A) {
        self.init(tag: a)
    }
    
    internal init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .navbarBrand)
        }
    }
}

public class NavbarToggler: Component {
    
    public static func standard(id: String,
                                ariaLabel: String,
                                isCollapseOffcanvas: Bool = false,
                                isBordered: Bool = true) -> NavbarToggler {
        NavbarToggler(id: id, ariaLabel: ariaLabel, isCollapseOffcanvas: isCollapseOffcanvas) {
            Button {
                Span().class(insert: .navbarTogglerIcon)
            }
            .style(set: .border("none"), if: !isBordered)
        }
    }
    
    public init(id: String,
                ariaLabel: String,
                isCollapseOffcanvas: Bool = false,
                button: () -> Button) {
        super.init {
            button()
                .class(insert: .navbarToggler)
                .type(.button)
                .dataBsToggle(isCollapseOffcanvas ? .offcanvas : .collapse)
                .dataBsTarget(id)
                .ariaControls(id)
                .ariaExpanded(false)
                .ariaLabel(ariaLabel)
        }
    }
}

public class NavbarCollapse: Component {
    
    public init(togglerId id: String, div: () -> Div) {
        super.init {
            div()
                .class(insert: .collapse, .navbarCollapse)
                .id(id)
        }
    }
}

public class NavbarNav: Component {
    
    public convenience init(scrollHeight pixels: Int? = nil, ol: () -> Ol) {
        self.init(scrollHeight: pixels, tag: ol)
    }

    public convenience init(scrollHeight pixels: Int? = nil, ul: () -> Ul) {
        self.init(scrollHeight: pixels, tag: ul)
    }
    
    public convenience init(scrollHeight pixels: Int? = nil, div: () -> Div) {
        self.init(scrollHeight: pixels, tag: div)
    }
    
    /// for default scroll height ... use Int.max
    internal init(scrollHeight pixels: Int?, tag: () -> Tag) {
        let isScrollable: Bool
        let scrollHeight: CssKeyValue?
        if let pixels = pixels, pixels < Int.max {
            isScrollable = true
            scrollHeight = CssKeyValue("--bs-scroll-height", "\(pixels)px")
        } else {
            isScrollable = true
            scrollHeight = nil
        }
        super.init {
            tag()
                .class(insert: .navbarNav)
                .class(insert: .navbarNavScroll, if: isScrollable)
                .style(set: scrollHeight)
        }
    }
}

public class NavbarText: Component {
    
    public convenience init(_ text: String) {
        self.init { Span(text) }
    }
    
    public init(_ span: () -> Span) {
        super.init {
            span()
                .class(insert: .navbarText)
        }
    }
}
