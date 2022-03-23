//
//  Navbar.swift
//  
//
//  Created by Brad Gourley on 3/17/22.
//

import SwiftHtml

public class Navbar: Component {
    
    public enum Placement {
        case fixedBottom
        case fixedTop
        case stickyTop  // May not be supported by every browser
        
        var `class`: BsClass {
            switch self {
            case .fixedBottom:
                return .fixedBottom
            case .fixedTop:
                return .fixedTop
            case .stickyTop:
                return .stickyTop
            }
        }
    }
    
    /// collapseBelow = nil ... auto-collapses behind toggler button
    public convenience init(placement: Placement? = nil,
                            collapseAt breakpoint: Size? = nil,
                            isFluid: Bool = true,
                            container type: TagType,              // required to disambiguate from init() without any parameters
                            @TagBuilder contents: () -> [Tag]) {
        self.init(placement: placement, collapseAt: breakpoint) {
            Container(type: type, isFluid: isFluid) {
                contents()
            }
        }
    }
    
    /// use for access to Container for styling
    public init(placement: Placement? = nil,
                collapseAt breakpoint: Size? = nil,
                container: () -> Container) {
        super.init {
            Nav {
                container()
            }
            .class(insert: .navbar)
            .class(insert: placement?.class)
            .class(insert: breakpoint?.navbarExpand)
        }
    }
}

extension Size {
    
    var navbarExpand: BsClass {
        switch self {
        case .xsm, .sm:
            return .navbarExpandSm
        case .md:
            return .navbarExpandMd
        case .lg:
            return .navbarExpandLg
        case .xl:
            return .navbarExpandXl
        case .xxl:
            return .navbarExpandXxl
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
