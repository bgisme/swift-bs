
import SwiftHtml

public class NavTab: Component {
    
    public enum Align {
        case center
        case right
    }
    
    public enum Style: String, CaseIterable {
        case pills
        case tabs
        
        var `class`: Utility {
            switch self {
            case .tabs:
                return .navTabs
            case .pills:
                return .navPills
            }
        }
    }
    
    public enum Width {
        case equal
        case proportional
    }
    
    public enum TagType {
        case nav
        case ol
        case ul
        
        func tag(@TagBuilder _ contents: () -> [Tag]) -> Tag {
            switch self {
            case .nav:
                return Nav { contents() }
            case .ol:
                return Ol { contents() }
            case .ul:
                return Ul { contents() }
            }
        }
    }
    
    public var style: Style? {
        let firstStyleStr = Style.allCases.compactMap{ style in tag.value(.class)?.classes.first{ $0 == style.rawValue } }.first
        if let styleStr = firstStyleStr, let style = Style(rawValue: styleStr) {
            return style
        }
        return nil
    }
    
    /// @NOTE: type can not be default value ... compiler error ambiguous init
    public convenience init(as type: TagType, @TagBuilder contents: () -> [Tag]) {
        self.init(type.tag(contents))
    }
    
    public convenience init(nav: () -> Nav) {
        self.init(nav())
    }
    
    public convenience init(ol: () -> Ol) {
        self.init(ol())
    }

    public convenience init(ul: () -> Ul) {
        self.init(ul())
    }
    
    private override init(_ tag: Tag) {
        tag
            .class(insert: .nav)
        
        super.init(tag)
    }
    
    @discardableResult
    public func align(_ value: Align, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        let align: Utility
        switch value {
        case .right:
            align = .justifyContentEnd
        case .center:
            align = .justifyContentCenter
        }
        tag
            .class(insert: align)
        return self
    }
    
    @discardableResult
    public func breakpoints(_ values: Breakpoint..., if condition: Bool = true) -> Self {
        guard condition, !values.isEmpty else { return self }
        var breakpoints: Set<Utility> = [.flexColumn]
        _ = values.map {
            switch $0 {
            case .xs:
                break
            case .sm:
                breakpoints.insert(.flexSmRow)
            case .md:
                breakpoints.insert(.flexMdRow)
            case .lg:
                breakpoints.insert(.flexLgRow)
            case .xl:
                breakpoints.insert(.flexXlRow)
            case .xxl:
                breakpoints.insert(.flexXxlRow)
            }
        }
        tag
            .class(insert: Array(breakpoints))
        return self
    }
    
    @discardableResult
    public func style(_ value: Style, _ condition: Bool = true) -> Self {
        tag
            .class(insert: value.class, if: condition)
        return self
    }
    
    @discardableResult
    public func width(_ value: Width, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        let width: Utility
        switch value {
        case .proportional:
            width = .navFill
        case .equal:
            width = .navJustified
        }
        tag
            .class(insert: width)
        return self
    }
    
    @discardableResult
    public func isCardHeaderTabs(if condition: Bool = true) -> Self {
        tag
            .class(insert: .cardHeaderTabs, if: condition)
        return self
    }
}

public class NavItem: Component {
    
    public convenience init(navLink: () -> NavLink) {
        let li = Li {
            navLink()
        }
        self.init(li)
    }

    public convenience init(_ title: String, href: String) {
        self.init {
            NavLink(title, href: href)
        }
    }
    
    public convenience init(a: () -> A) {
        let li = Li {
            a()
        }
        self.init(li)
    }
        
    public init(_ li: Li) {
        li
            .class(insert: .navItem)
        
        super.init(li)
    }
}


public class NavLink: Component {
        
    public convenience init(_ title: String, href: String) {
        self.init {
            A(title).href(href)
        }
    }

    public convenience init(a: () -> A) {
        self.init(a())
    }
    
    public init(_ a: A) {
        a
            .class(insert: .navLink)
        
        super.init(a)
    }
    
    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        tag
            .class(insert: .active, if: condition)
            .ariaCurrent(condition)
        return self
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        tag
            .class(insert: .disabled, if: condition)
        return self
    }
    
    @discardableResult
    public func aligns( _ values: (Location, Breakpoint)..., if condition: Bool = true) -> Self {
        guard condition else { return self }
        var classes = Set<Utility>()
        for (location, bp) in values {
            switch location {
            case .start:
                switch bp {
                case .xs:
                    classes.insert(.textStart)
                case .sm:
                    classes.insert(.textSmStart)
                case .md:
                    classes.insert(.textMdStart)
                case .lg:
                    classes.insert(.textLgStart)
                case .xl:
                    classes.insert(.textXlStart)
                case .xxl:
                    classes.insert(.textXlStart)
                }
            case .end:
                switch bp {
                case .xs:
                    classes.insert(.textEnd)
                case .sm:
                    classes.insert(.textSmEnd)
                case .md:
                    classes.insert(.textMdEnd)
                case .lg:
                    classes.insert(.textLgEnd)
                case .xl:
                    classes.insert(.textXlEnd)
                case .xxl:
                    classes.insert(.textXlEnd)
                }
            case .center:
                switch bp {
                case .xs:
                    classes.insert(.textCenter)
                case .sm:
                    classes.insert(.textSmCenter)
                case .md:
                    classes.insert(.textMdCenter)
                case .lg:
                    classes.insert(.textLgCenter)
                case .xl:
                    classes.insert(.textXlCenter)
                case .xxl:
                    classes.insert(.textXlCenter)
                }
            }
        }
        tag
            .class(insert: Array(classes))
        return self
    }
    
    @discardableResult
    public func fills(_ values: Breakpoint..., if condition: Bool = true) -> Self {
        guard condition else { return self }
        var classes = Set<Utility>()
        for bp in values {
            switch bp {
            case .xs:
                classes.insert(.flexFill)
            case .sm:
                classes.insert(.flexSmFill)
            case .md:
                classes.insert(.flexMdFill)
            case .lg:
                classes.insert(.flexLgFill)
            case .xl:
                classes.insert(.flexXlFill)
            case .xxl:
                classes.insert(.flexXxlFill)
            }
        }
        tag
            .class(insert: Array(classes))
        return self
    }
    
    @discardableResult
    public func scrollspy(on id: String, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        tag.attribute("href", "#\(id)")
        return self
    }
}

public class NavItemDropdown: Component {
    
    public typealias Id = String
    
    public let button: NavDropdownButton
    public let menu: DropdownMenu
    
    /// For declaring just button and menu items
    public convenience init(id: String,
                            menuAs type: DropdownMenu.TagType = .ul,
                            navDropdownButton: () -> NavDropdownButton,
                            @TagBuilder dropdownItems: () -> [Tag]) {
        self.init(id: id,
                  navDropdownButton: navDropdownButton,
                  dropdownMenu: { id in
            DropdownMenu(dropdownId: id, as: type) {
                dropdownItems()
            }
        })
    }
    
    /// For declaring button and menu
    public convenience init(id: String,
                            navDropdownButton: () -> NavDropdownButton,
                            dropdownMenu: (Id) -> DropdownMenu) {
        let button = navDropdownButton()
        let menu = dropdownMenu(id)
        let li = Li {
            button
            menu
        }
        self.init(button: button, menu: menu, li)
    }
    
    public init(button: NavDropdownButton, menu: DropdownMenu, _ li: Li) {
        self.button = button
        self.menu = menu
        li
            .class(insert: .navItem, .dropdown)
        
        super.init(li)
    }
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        menu.isDark(if: condition)
        return self
    }
}

public class NavDropdownButton: Component {
    
    public convenience init(_ title: String, href: String) {
        self.init {
            A(title).href(href)
        }
    }
    
    public convenience init(_ a: () -> A) {
        self.init(a())
    }
    
    public init(_ a: A) {
        a
            .class(insert: .navLink)
            .class(insert: .dropdownToggle)
            .dataBsToggle(.dropdown)
            .ariaExpanded(false)
            .role(.button)
        
        super.init(a)
    }
}
