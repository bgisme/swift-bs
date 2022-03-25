//
//  NavTab.swift
//  
//
//  Created by Brad Gourley on 3/16/22.
//

import SwiftHtml

public class NavTab: Component {
    
    public enum Align {
        case center
        case right
    }
    
    public enum Style {
        case pills
        case tabs
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
    
    let style: Style?
    
    public convenience init(align: Align? = nil,
                            breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            as type: TagType,
                            @TagBuilder contents: () -> [Tag]) {
        self.init(align: align, breakpoints: breakpoints, style: style, width: width, type.tag(contents))
    }
    
    public convenience init(align: Align? = nil,
                            breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            nav: () -> Nav) {
        self.init(align: align, breakpoints: breakpoints, style: style, width: width, nav())
    }
    
    public convenience init(align: Align? = nil,
                            breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            ol: () -> Ol) {
        self.init(align: align, breakpoints: breakpoints, style: style, width: width, ol())
    }

    public convenience init(align: Align? = nil,
                            breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            ul: () -> Ul) {
        self.init(align: align, breakpoints: breakpoints, style: style, width: width, ul())
    }
    
    private init(align: Align?,
                 breakpoints: [Breakpoint],
                 style: Style?,
                 width: Width?,
                 _ tag: Tag) {
        self.style = style
        let alignment: BsClass?
        switch align {
        case .right:
            alignment = .justifyContentEnd
        case .center:
            alignment = .justifyContentCenter
        default:
            alignment = nil
        }
        let verticals: [BsClass]?
        if !breakpoints.isEmpty {
            var classes: Set<BsClass> = [.flexColumn]
            _ = breakpoints.map {
                switch $0 {
                case .xs:
                    break
                case .sm:
                    classes.insert(.flexSmRow)
                case .md:
                    classes.insert(.flexMdRow)
                case .lg:
                    classes.insert(.flexLgRow)
                case .xl:
                    classes.insert(.flexXlRow)
                case .xxl:
                    classes.insert(.flexXxlRow)
                }
            }
            verticals = Array(classes)
        } else {
            verticals = nil
        }
        let navStyle: BsClass?
        switch style {
        case .tabs:
            navStyle = .navTabs
        case .pills:
            navStyle = .navPills
        default:
            navStyle = nil
        }
        let spacing: BsClass?
        switch width {
        case .proportional:
            spacing = .navFill
        case .equal:
            spacing = .navJustified
        default:
            spacing = nil
        }
        tag
            .class(insert: .nav)
            .class(insert: alignment)
            .class(insert: verticals)
            .class(insert: navStyle)
            .class(insert: spacing)
        
        super.init(tag)
    }
}

public class NavItem: Component {
        
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false,
                            isDropdown: Bool = false,
                            aligns: [(Location, Breakpoint)]? = nil,
                            fills: Set<Breakpoint>? = nil) {
        self.init(isActive: isActive,
                  isDisabled: isDisabled,
                  isDropdown: isDropdown,
                  aligns: aligns,
                  fills: fills) { A(title).href(href) }
    }
    
    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            isDropdown: Bool = false,
                            aligns: [(Location, Breakpoint)]? = nil,
                            fills: Set<Breakpoint>? = nil,
                            _ a: () -> A) {
        self.init(contents: {
            NavLink(isActive: isActive,
                    isDisabled: isDisabled,
                    isDropdown: isDropdown,
                    aligns: aligns,
                    fills: fills,
                    a)
        })
    }
    
    /// contents ... anything (usually <a>)
    public convenience init(@TagBuilder contents: () -> [Tag]) {
        let li = Li { contents() }
        self.init(li)
    }
    
    public init(_ li: Li) {
        li
            .class(insert: .navItem)
        
        super.init(li)
    }
}


public class NavLink: Component {
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false,
                            isDropdown: Bool = false,
                            aligns: [(Location, Breakpoint)]? = nil,
                            fills: Set<Breakpoint>? = nil) {
        let a = A(title).href(href)
        self.init(isActive: isActive,
                  isDisabled: isDisabled,
                  isDropdown: isDropdown,
                  aligns: aligns,
                  fills: fills,
                  a)
    }

    public convenience init(isActive: Bool = false,
                            isDisabled: Bool = false,
                            isDropdown: Bool = false,
                            aligns: [(Location, Breakpoint)]? = nil,
                            fills: Set<Breakpoint>? = nil,
                            _ a: () -> A) {
        self.init(isActive: isActive, isDisabled: isDisabled, isDropdown: isDropdown, aligns: aligns, fills: fills, a())
    }
    
    public init(isActive: Bool,
                isDisabled: Bool,
                isDropdown: Bool,
                aligns: [(Location, Breakpoint)]?,
                fills: Set<Breakpoint>?,
                _ a: A) {
        var classes = Set<BsClass>()
        if let aligns = aligns {
            for (location, bp) in aligns {
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
        }
        if let fills = fills {
            for bp in fills {
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
        }
        a
            .class(insert: .navLink)
            .class(insert: .active, if: isActive)
            .ariaCurrent(isActive)
            .class(insert: .disabled, if: isDisabled)
            .class(insert: .dropdownToggle, if: isDropdown)
            .dataBsToggle(.dropdown, isDropdown)
            .ariaExpanded(false, isDropdown)
            .class(insert: Array(classes))
        
        super.init(a)
    }
}

public class NavItemDropdown: Component {
    
    public typealias Id = String
    public typealias IsDark = Bool
    
    public convenience init(id: String,
                            isDark: Bool = false,
                            menuAs type: DropdownMenu.TagType = .ul,
                            a: () -> A,
                            @TagBuilder dropdownItems: () -> [Tag]) {
        self.init(id: id,
                  isDark: isDark,
                  a: a,
                  dropdownMenu: { id, isDark in
            DropdownMenu(dropdownId: id, isDark: isDark, as: type) {
                dropdownItems()
            }
        })
    }
    
    public convenience init(id: String,
                            isDark: Bool = false,
                            a: () -> A,
                            dropdownMenu: (Id, IsDark) -> DropdownMenu) {
        let a = a().id(id)
        let li = Li {
            NavLink(isActive: false, isDisabled: false, isDropdown: true, aligns: nil, fills: nil, a)
            dropdownMenu(id, isDark)
        }
        self.init(li)
    }
    
    public init(_ li: Li) {
        li
            .class(insert: .navItem, .dropdown)
        
        super.init(li)
    }
}
