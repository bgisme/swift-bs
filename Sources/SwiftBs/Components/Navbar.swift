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
        case stickyTop  // May not be supported by every browser
    }
    
    /// collapseBelow = nil ... auto-collapses behind toggler button
    /// contents ... NavbarContainer
    public init(placement place: Placement? = nil,
                collapseAt breakpoint: Breakpoint? = nil,
                @TagBuilder contents: () -> [Tag]) {
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
            Nav {
                contents()
            }
            .class(insert: .navbar)
            .class(insert: placement)
            .class(insert: expand)
        }
    }
}

public class NavbarContainer: Component {
    
    /// isFluid: false if NavbarBrand is just an image and no text
    /// contents ...
    /// NavbarBrand
    /// NavbarToggler
    public init(isFluid: Bool = true, @TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: isFluid ? .containerFluid : .container)
        }
    }
}

public class NavbarBrand: Component {
        
    public convenience init(_ title: String, href: String) {
        self.init { A(title).href(href) }
    }
    
    public convenience init(_ title: String) {
        self.init { Span(title) }
    }
    
    public convenience init(span: () -> Span) {
        self.init(tag: span())
    }

    public convenience init(a: () -> A) {
        self.init(tag: a())
    }
    
    private init(tag: Tag) {
        super.init {
            tag
                .class(insert: .navbarBrand)
        }
    }
}

public class NavbarToggler: Component {
    
    public static func standard(id: String,
                                ariaLabel: String,
                                isCollapseOffcanvas: Bool = false,
                                isBordered: Bool = true) -> NavbarToggler {
        return NavbarToggler(id: id,
                             ariaLabel: ariaLabel,
                             isCollapseOffcanvas: isCollapseOffcanvas) {
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
    
    /// contents ...
    /// NavbarNav
    /// anything
    public init(togglerId id: String,
                @TagBuilder contents: () -> [Tag]) {
        super.init {
            Div {
                contents()
            }
            .class(insert: .collapse, .navbarCollapse)
            .id(id)
        }
    }
}

public class NavbarNav: Component {
    
    public enum TagType {
        case ol
        case ul
        case div
    }
    
    public init(scrollHeight pixels: Int? = nil,
                type: TagType,
                @TagBuilder navbarTexts: () -> [Tag]) {
        let tag: Tag
        switch type {
        case .ol:
            tag = Ol { navbarTexts() }
        case .ul:
            tag = Ul { navbarTexts() }
        case .div:
            tag = Div { navbarTexts() }
        }
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
            tag
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
    
    public init(span: () -> Span) {
        super.init {
            span()
                .class(insert: .navbarText)
        }
    }
}
