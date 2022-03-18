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
    
    let nav: Nav
    let placement: BsClass?
    let expand: BsClass?
    
    /// collapseBelow = nil ... auto-collapses behind toggler button
    public init(placement: Placement? = nil,
                collapseAt breakpoint: Breakpoint? = nil,
                nav: () -> Nav) {
        switch placement {
        case .fixedTop:
            self.placement = .fixedTop
        case .fixedBottom:
            self.placement = .fixedBottom
        case .stickyTop:
            self.placement = .stickyTop
        default:
            self.placement = nil
        }
        switch breakpoint {
        case .sm:
            self.expand = .navbarExpandSm
        case .md:
            self.expand = .navbarExpandMd
        case .lg:
            self.expand = .navbarExpandLg
        case .xl:
            self.expand = .navbarExpandXl
        case .xxl:
            self.expand = .navbarExpandXxl
        default:
            self.expand = nil
        }
        self.nav = nav()
    }
}

extension Navbar: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        nav
            .class(add: .navbar)
            .class(add: placement)
            .class(add: expand)
            .merge(attributes)
    }
}

public class NavbarContainer: Component {
    
    let div: Div
    let isFluid: Bool
    
    /// isFluid: false if NavbarBrand is just an image and no text
    public init(isFluid: Bool = true, div: () -> Div) {
        self.isFluid = isFluid
        self.div = div()
    }
}

extension NavbarContainer: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: isFluid ? .containerFluid : .container)
            .merge(attributes)
    }
}

public class NavbarBrand: Component {
    
    let tag: Tag
    
    public convenience init(_ title: String, href: String? = nil) {
        self.init(tag: {
            if let href = href {
                return A(title).href(href)
            } else {
                return Span(title).class(add: .mb0, .h1)
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
        self.tag = tag()
    }
}

extension NavbarBrand: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .navbarBrand)
            .merge(attributes)
    }
}

public class NavbarToggler: Component {
    
    let button: Button
    let id: String
    let isCollapseOffCanvas: Bool
    let ariaLabel: String
    
    public static func standard(id: String,
                                ariaLabel: String,
                                isOffcanvas: Bool = false,
                                isBordered: Bool = true) -> NavbarToggler {
        NavbarToggler(id: id, ariaLabel: ariaLabel, isOffcanvas: isOffcanvas) {
            Button {
                Span().class(add: "navbar-toggler-icon")
            }.style(add: .border("none"), if: !isBordered)
        }
    }
    
    public init(id: String,
                ariaLabel: String,
                isOffcanvas: Bool = false,
                button: () -> Button) {
        self.id = id
        self.ariaLabel = ariaLabel
        self.isCollapseOffCanvas = isOffcanvas
        self.button = button()
    }
}

extension NavbarToggler: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        button
            .class(add: .navbarToggler)
            .type(.button)
            .dataBsToggle(isCollapseOffCanvas ? .offcanvas : .collapse)
            .dataBsTarget(id)
            .ariaControls(id)
            .ariaExpanded(false)
            .ariaLabel(ariaLabel)
            .merge(attributes)
    }
}

public class NavbarCollapse: Component {
    
    let div: Div
    let id: String
    
    public init(togglerId id: String, div: () -> Div) {
        self.id = id
        self.div = div()
    }
}

extension NavbarCollapse: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .collapse, .navbarCollapse)
            .id(id)
            .merge(attributes)
    }
}

public class NavbarNav: Component {
    
    let tag: Tag
    let isScrollable: Bool
    let scrollHeight: CssKeyValue?

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
        if let pixels = pixels, pixels < Int.max {
            self.isScrollable = true
            self.scrollHeight = CssKeyValue("--bs-scroll-height", "\(pixels)px")
        } else {
            self.isScrollable = true
            self.scrollHeight = nil
        }
        self.tag = tag()
    }
}

extension NavbarNav: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .navbarNav)
            .class(add: .navbarNavScroll, if: isScrollable)
            .style(add: scrollHeight)
            .merge(attributes)
    }
}

public class NavbarText: Component {
    
    let span: Span
    
    public convenience init(_ text: String) {
        self.init { Span(text) }
    }
    
    public init(_ span: () -> Span) {
        self.span = span()
    }
}

extension NavbarText: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        span
            .class(add: .navbarText)
            .merge(attributes)
    }
}
