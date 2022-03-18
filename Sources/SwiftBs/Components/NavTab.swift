//
//  NavTab.swift
//  
//
//  Created by Brad Gourley on 3/16/22.
//

import SwiftHtml

public class NavTab: Component {
    
    public enum Align {
        case right
        case center
    }
    
    public enum Style {
        case tabs
        case pills
    }
    
    public enum Width {
        case proportional
        case equal
    }
    
    let tag: Tag
    let align: BsClass?
    let verticals: [BsClass]?
    let style: BsClass?
    let width: BsClass?
        
    public convenience init(align: Align? = nil,
                            vertical breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            nav: () -> Nav) {
        self.init(align: align, vertical: breakpoints, style: style, width: width, tag: { nav() })
    }
    
    public convenience init(align: Align? = nil,
                            vertical breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            ol: () -> Ol) {
        self.init(align: align, vertical: breakpoints, style: style, width: width, tag: { ol() })
    }
    
    public convenience init(align: Align? = nil,
                            vertical breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            ul: () -> Ul) {
        self.init(align: align, vertical: breakpoints, style: style, width: width, tag: { ul() })
    }
    
    internal init(align: Align?,
                  vertical breakpoints: [Breakpoint],
                  style: Style?,
                  width: Width?,
                  tag: () -> Tag) {
        switch align {
        case .right:
            self.align = .justifyContentEnd
        case .center:
            self.align = .justifyContentCenter
        default:
            self.align = nil
        }
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
        self.verticals = !classes.isEmpty ? Array(classes) : nil
        switch style {
        case .tabs:
            self.style = .navTabs
        case .pills:
            self.style = .navPills
        default:
            self.style = nil
        }
        switch width {
        case .proportional:
            self.width = .navFill
        case .equal:
            self.width = .navJustified
        default:
            self.width = nil
        }
        self.tag = tag()
    }
}

extension NavTab: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .nav)
            .class(add: align)
            .class(add: verticals)
            .class(add: style)
            .class(add: width)
            .merge(attributes)
    }
}

public class NavItem: Component {
    
    let li: Li
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init {
            Li {
                NavLink(title, href: href, isActive: isActive, isDisabled: isDisabled)
            }
        }
    }
    
    public init(li: () -> Li) {
        self.li = li()
    }
}

extension NavItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        li
            .class(add: .navItem)
            .merge(attributes)
    }
}

public class NavItemDropdown: Component {
    
    public typealias Id = String
    
    let li: Li
    
    public init(id: String, a: () -> A, menu: (Id) -> DropdownMenu) {
        let li = Li {
            NavLink(isDropdownToggle: true) { a().id(id) }
            menu(id)
        }
        self.li = li
    }
}

extension NavItemDropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        li
            .class(add: .navItem, .dropdown)
            .merge(attributes)
    }
}

public class NavLink: Component {
    
    let a: A
    let isActive: Bool
    let isDisabled: Bool
    let isDropdownToggle: Bool
    let alignFillClasses: [BsClass]?
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false,
                            isDropdownToggle: Bool = false,
                            aligns: [(Location, Breakpoint)]? = nil,
                            fills: Set<Breakpoint>? = nil) {
        self.init(isActive: isActive, isDisabled: isDisabled) {
            A(title).href(href)
        }
    }
    
    public init(isActive: Bool = false,
                isDisabled: Bool = false,
                isDropdownToggle: Bool = false,
                aligns: [(Location, Breakpoint)]? = nil,
                fills: [Breakpoint]? = nil,
                a: () -> A) {
        self.isActive = isActive
        self.isDisabled = isDisabled
        self.isDropdownToggle = isDropdownToggle
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
        self.alignFillClasses = Array(classes)
        self.a = a()
    }
}

extension NavLink: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        a
            .class(add: .navLink)
            .class(add: .active, if: isActive)
            .ariaCurrent(isActive)
            .class(add: .disabled, if: isDisabled)
            .class(add: .dropdownToggle, if: isDropdownToggle)
            .dataBsToggle(.dropdown, isDropdownToggle)
            .ariaExpanded(false, isDropdownToggle)
            .class(add: alignFillClasses)
            .merge(attributes)
    }
}
