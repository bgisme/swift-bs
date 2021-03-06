
import SwiftHtml

public class Navbar: Component {
    
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
    
    public convenience init(subcontainer type: TagType? = nil,
                            isFluid: Bool = false,
                            @TagBuilder contents: () -> [Tag]) {
        let nav = Nav {
            if let type = type {
                Container(type, isFluid: isFluid) {
                    contents()
                }
            }
            contents()
        }
        self.init(nav)
    }
    
    public init(_ nav: Nav) {
        nav
            .class(insert: .navbar)

        super.init(nav)
    }
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        guard condition else { return self }
        _ = self.tag.class(remove: Utility.navbarLight)
        tag
            .class(insert: .navbarDark)
        return self
    }
    
    @discardableResult
    public func isLight(if condition: Bool = true) -> Self {
        guard condition else { return self }
        _ = self.tag.class(remove: Utility.navbarDark)
        tag
            .class(insert: .navbarLight)
        return self
    }
    
    @discardableResult
    public func placement(_ value: Placement, _ condition: Bool = true) -> Self {
        tag
            .class(insert: value.class, if: condition)
        return self
    }
    
    @discardableResult
    public func collapse(_ value: Size, _ condition: Bool = true) -> Self {
        tag
            .class(insert: value.navbarExpand, if: condition)
        return self
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
    
    public convenience init(id: String) {
        let button = Button {
            Span().class(insert: .navbarTogglerIcon)
        }
        self.init(id: id, button)
    }
    
    public convenience init(id: String, button: () -> Button) {
        self.init(id: id, button())
    }
    
    public init(id: String, _ button: Button) {
        button
            .class(insert: .navbarToggler)
            .type(.button)
            .dataBsToggle(.collapse)
            .dataBsTarget(id)
            .ariaControls(id)
            .ariaExpanded(false)
        
        super.init(button)
    }
    
    @discardableResult
    public func isCollapseOffscreen(if condition: Bool = true) -> Self {
        tag
            .dataBsToggle(.offcanvas, condition)
        return self
    }
    
    @discardableResult
    public func isBorderless(if condition: Bool = true) -> Self {
        tag
            .style(set: .border("none"), if: condition)
        return self
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
    public convenience init(as type: TagType = .ul, @TagBuilder contents: () -> [Tag]) {
        let tag: Tag
        switch type {
        case .ol:
            tag = Ol { contents() }
        case .ul:
            tag = Ul { contents() }
        case .div:
            tag = Div { contents() }
        }
        self.init(tag)
    }
    
    private override init(_ tag: Tag) {
        tag
            .class(insert: .navbarNav)
        
        super.init(tag)
    }
    
    @discardableResult
    public func isScrollable(pixelHeight: Int, _ condition : Bool = true) -> Self {
        tag
            .class(insert: .navbarNavScroll, if: condition)
            .style(set: CssKeyValue("--bs-scroll-height", "\(pixelHeight)px"), if: condition)
        return self
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
