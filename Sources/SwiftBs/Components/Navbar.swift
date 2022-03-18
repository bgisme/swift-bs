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
    
    let nav: Tag
    let placement: BsClass?
    let expand: BsClass?
    
    public convenience init(placement: Placement? = nil,
                            collapseAt breakpoint: Breakpoint? = nil,
                            @TagBuilder navBarContainer: () -> [Tag]) {
        let nav = Nav {
            navBarContainer()
        }
        self.init(nav, placement: placement, collapseAt: breakpoint)
    }
    
    /// collapseBelow = nil ... auto-collapses behind toggler button
    public init(_ nav: Tag,
                placement: Placement? = nil,
                collapseAt breakpoint: Breakpoint? = nil) {
        self.nav = nav
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
    
    /// next use NavbarBrand or NavbarToggler
    public convenience init(isFluid: Bool = true,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
        }
        self.init(div, isFluid: isFluid)
    }
    
    /// isFluid: false if NavbarBrand is just an image and no text
    public init(_ div: Div, isFluid: Bool = true) {
        self.div = div
        self.isFluid = isFluid
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
        let tag: Tag
        if let href = href {
            tag = A(title)
                .href(href)
        } else {
            tag = Span(title)
                .class(add: .mb0, .h1)
        }
        self.init(tag: tag)
    }
    
    public convenience init(_ span: Span) {
        self.init(tag: span)
    }

    public convenience init(_ a: A) {
        self.init(tag: a)
    }
    
    internal init(tag: Tag) {
        self.tag = tag
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
        NavbarToggler("navbar-toggler-icon",
                      id: id,
                      ariaLabel: "site navigation",
                      isOffCanvas: isOffcanvas)
        .style(add: .border("none"), if: !isBordered)
    }
    
    public convenience init(_ iconClass: String,
                            id: String,
                            ariaLabel: String,
                            isOffCanvas: Bool = false) {
        let button = Button {
            Span().class(add: iconClass)
        }
        self.init(button, id: id, isOffCanvas: isOffCanvas, ariaLabel: ariaLabel)
    }
    
    public init(_ button: Button,
                id: String,
                isOffCanvas: Bool = false,
                ariaLabel: String) {
        self.button = button
        self.id = id
        self.isCollapseOffCanvas = isOffCanvas
        self.ariaLabel = ariaLabel
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
    
    public convenience init(togglerId id: String,
                            @TagBuilder contents: () -> [Tag]) {
        let div = Div {
            contents()
        }
        self.init(div, togglerId: id)
    }
    
    public init(_ div: Div, togglerId id: String) {
        self.div = div
        self.id = id
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
    
    public enum `Type` {
        case ol     // contents should be <li> or NavItem
        case ul     // contents should be <li> or NavItem
        case div    // contents should be <a> or NavLink
    }
    
    let tag: Tag
    let isScrollable: Bool
    let scrollHeight: CssKeyValue?

    public convenience init(type: `Type` = .div,
                            scrollHeight pixels: Int? = nil,
                            @TagBuilder contents: () -> [Tag]) {
        let tag: Tag
        switch `type` {
        case .ol:
            tag = Ol { contents() }
        case .ul:
            tag = Ul { contents() }
        case .div:
            tag = Div { contents() }
        }
        self.init(tag: tag, scrollHeight: pixels)
    }
    
    public convenience init(_ ol: Ol, scrollHeight pixels: Int? = nil) {
        self.init(tag: ol, scrollHeight: pixels)
    }

    public convenience init(_ ul: Ul, scrollHeight pixels: Int? = nil) {
        self.init(tag: ul, scrollHeight: pixels)
    }
    
    public convenience init(_ div: Div, scrollHeight pixels: Int? = nil) {
        self.init(tag: div, scrollHeight: pixels)
    }
    
    /// for default scroll height ... use Int.max
    internal init(tag: Tag, scrollHeight pixels: Int?) {
        self.tag = tag
        if let pixels = pixels, pixels < Int.max {
            self.isScrollable = true
            self.scrollHeight = CssKeyValue("--bs-scroll-height", "\(pixels)px")
        } else {
            self.isScrollable = true
            self.scrollHeight = nil
        }
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
        let span = Span(text)
        self.init(span)
    }
    
    public init(_ span: Span) {
        self.span = span
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
