//
//  Navbar.swift
//  
//
//  Created by Brad Gourley on 12/26/22.
//

import SwiftHtml

open class Navbar: Nav {
    
    public init(container: (kind: TagKind, isFluid: Bool)? = (.div, true),
                @TagBuilder content: () -> Tag) {
        let child: Tag
        if let (kind, isFluid) = container {
            child = Container(kind, isFluid: isFluid) {
                content()
            }.class(insert: .p0) // remove padding... instead control with classes on Navbar
        } else {
            child = content()
        }
        super.init([child])
        self
            .class(insert: .navbar)
    }
}

extension Navbar {
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        self
            .class(remove: Utility.navbarLight, condition)
            .class(insert: .navbarDark, if: condition)
    }
    
    @discardableResult
    public func isLight(if condition: Bool = true) -> Self {
        self
            .class(remove: Utility.navbarDark, condition)
            .class(insert: .navbarLight, if: condition)
    }
    
    public enum Placement {
        case fixedBottom
        case fixedTop
        case stickyTop  // May not be supported by every browser
        
        var `class`: Utility {
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
    
    @discardableResult
    public func placement(_ value: Placement, _ condition: Bool = true) -> Self {
        self.class(insert: value.class, if: condition)
    }
}

extension Size {
    
    var navbarExpand: Utility {
        switch self {
        case .xs, .sm:
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

extension Navbar {
    
    @discardableResult
    public func collapse(_ value: Size, _ condition: Bool = true) -> Self {
        self.class(insert: value.navbarExpand, if: condition)
    }
}

open class NavbarBrand: StandardTag {
    
    public init(tag name: String,
                @TagBuilder contents: () -> Tag) {
        super.init(name: name, [contents()])
        self.class(insert: .navbarBrand)
    }
}

open class NavbarToggler: Button {
    
    public static func `default`(id: String) -> NavbarToggler {
        NavbarToggler(id: id) {
            Span().class(insert: .navbarTogglerIcon)
        }
    }
    
    public init(id: String, @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .navbarToggler)
            .type(.button)
            .dataBsToggle(.collapse)
            .dataBsTarget(id)
            .ariaControls(id)
            .ariaExpanded(false)
    }
}

extension NavbarToggler {
    
    @discardableResult
    public func isCollapseOffscreen(if condition: Bool = true) -> Self {
        self.dataBsToggle(.offcanvas, condition)
    }
    
    @discardableResult
    public func isBorderless(if condition: Bool = true) -> Self {
        self.style(set: .border("none"), if: condition)
    }
}

open class NavbarCollapse: Div {
    
    public init(togglerID id: String, @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .collapse, .navbarCollapse)
            .id(id)
    }
}

open class NavbarNav: Tag {
    
    public enum Kind: String {
        case div
        case ol
        case ul
    }
    
    public init(_ kind: Kind, @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .navbarNav)
    }
    
    @discardableResult
    public func isScrollable(pixelHeight: Int, _ condition : Bool = true) -> Self {
        self
            .class(insert: .navbarNavScroll, if: condition)
            .style(set: CssKeyValue("--bs-scroll-height", "\(pixelHeight)px"), if: condition)
    }
}

open class NavbarText: Span {
    
    public convenience init(_ text: String) {
        self.init { Text(text) }
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .navbarText)
    }
}
