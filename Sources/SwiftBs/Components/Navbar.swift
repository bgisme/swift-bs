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
    
    public convenience init(placement: Placement? = nil,
                            collapseAt breakpoint: Size? = nil,
                            isFluid: Bool = true,
                            subcontainer type: TagType,
                            @TagBuilder contents: () -> [Tag]) {
        self.init(placement: placement, collapseAt: breakpoint) {
            Container(type, isFluid: isFluid) {
                contents()
            }
        }
    }
    
    /// use for access to Container for styling
    public convenience init(placement: Placement? = nil,
                            collapseAt breakpoint: Size? = nil,
                            container: () -> Container) {
        let nav = Nav { container() }
        self.init(placement: placement, collapseAt: breakpoint, nav)
    }
    
    public init(placement: Placement?,
                collapseAt breakpoint: Size?,
                _ nav: Nav) {
        nav
            .class(insert: .navbar)
            .class(insert: placement?.class)
            .class(insert: breakpoint?.navbarExpand)
        super.init(nav)
    }
    
    /// @NOTE Set isDark, isLight or neither
    @discardableResult
    public func brightness(_ value: Brightness?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        _ = self.tag.class(remove: Brightness.dark.navbarClass.rawValue)
        _ = self.tag.class(remove: Brightness.light.navbarClass.rawValue)
        self.tag.class(insert: value?.navbarClass)
        return self
    }
}

extension Brightness {
    
    var navbarClass: BsClass {
        switch self {
        case .light:
            return .navbarLight
        case .dark:
            return .navbarDark
        }
    }
}

extension Size {
    
    var navbarExpand: BsClass {
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

public class NavbarBrand: Component {
        
    public convenience init(_ title: String, href: String) {
        self.init(A(title).href(href))
    }
    
    public convenience init(_ title: String) {
        self.init(Span(title))
    }
    
    public convenience init(span: () -> Span) {
        self.init(span())
    }

    public convenience init(a: () -> A) {
        self.init(a())
    }
    
    private override init(_ tag: Tag) {
        tag
            .class(insert: .navbarBrand)
        
        super.init(tag)
    }
}

public class NavbarToggler: Component {
    
    public convenience init(id: String,
                            ariaLabel: String,
                            isCollapseOffcanvas: Bool = false,
                            isBordered: Bool = true) {
        let button = Button {
            Span().class(insert: .navbarTogglerIcon)
        }
        .style(set: .border("none"), if: !isBordered)
        self.init(id: id,
                  ariaLabel: ariaLabel,
                  isCollapseOffcanvas: isCollapseOffcanvas,
                  button)
    }
    
    public convenience init(id: String,
                ariaLabel: String,
                isCollapseOffcanvas: Bool = false,
                button: () -> Button) {
        self.init(id: id,
                  ariaLabel: ariaLabel,
                  isCollapseOffcanvas: isCollapseOffcanvas,
                  button())
    }
    
    public init(id: String,
                ariaLabel: String,
                isCollapseOffcanvas: Bool,
                _ button: Button) {
        button
            .class(insert: .navbarToggler)
            .type(.button)
            .dataBsToggle(isCollapseOffcanvas ? .offcanvas : .collapse)
            .dataBsTarget(id)
            .ariaControls(id)
            .ariaExpanded(false)
            .ariaLabel(ariaLabel)
        
        super.init(button)
    }
}

public class NavbarCollapse: Component {
    
    /// contents ...
    /// NavbarNav
    /// anything
    public convenience init(togglerId id: String, @TagBuilder contents: () -> [Tag]) {
        let div = Div { contents() }
        self.init(togglerId: id, div)
    }
    
    public init(togglerId id: String, _ div: Div) {
        _ = div
            .class(insert: .collapse, .navbarCollapse)
            .id(id)
        
        super.init(div)
    }
}

public class NavbarNav: Component {
    
    public enum TagType {
        case ol
        case ul
        case div
    }
    
    /// contents ... NavbarText, NavItemDropdown
    public convenience init(scrollHeight pixels: Int? = nil,
                            as type: TagType = .ul,
                            @TagBuilder contents: () -> [Tag]) {
        let tag: Tag
        switch type {
        case .ol:
            tag = Ol { contents() }
        case .ul:
            tag = Ul { contents() }
        case .div:
            tag = Div { contents() }
        }
        let isScrollable: Bool
        let scrollHeight: CssKeyValue?
        if let pixels = pixels, pixels < Int.max {
            isScrollable = true
            scrollHeight = CssKeyValue("--bs-scroll-height", "\(pixels)px")
        } else {
            isScrollable = false
            scrollHeight = nil
        }
        self.init(isScrollable: isScrollable, scrollHeight: scrollHeight, tag)
    }
    
    public init(isScrollable: Bool,
                scrollHeight: CssKeyValue?,
                _ tag: Tag) {
        tag
            .class(insert: .navbarNav)
            .class(insert: .navbarNavScroll, if: isScrollable)
            .style(set: scrollHeight)
        
        super.init(tag)
    }
}

public class NavbarText: Component {
    
    public convenience init(_ text: String) {
        self.init(Span(text))
    }
    
    public init(_ span: Span) {
        span
            .class(insert: .navbarText)
        
        super.init(span)
    }
}
