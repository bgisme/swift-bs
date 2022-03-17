//
//  NavTab.swift
//  
//
//  Created by Brad Gourley on 3/16/22.
//

import SwiftHtml

public class NavTab: Component {
    
    public enum `Type` {
        case nav    // contains <a> or NavLink
        case ol     // contains <li> or NavItem
        case ul     // contains <li> or NavItem
    }
    
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
    
    public convenience init(type: `Type` = .nav,
                            align: Align? = nil,
                            vertical breakpoints: Set<Breakpoint>? = nil,
                            style: Style? = nil,
                            width: Width? = nil,
                            @TagBuilder contents: () -> [Tag]) {
        let tag: Tag
        switch type {
        case .nav:
            tag = Nav { contents() }
        case .ol:
            tag = Ol { contents() }
        case .ul:
            tag = Ul { contents() }
        }
        self.init(tag: tag, align: align, vertical: breakpoints, style: style, width: width)
    }
    
    public convenience init(_ nav: Nav,
                            align: Align? = nil,
                            vertical breakpoints: Set<Breakpoint>? = nil,
                            style: Style? = nil,
                            width: Width? = nil) {
        self.init(tag: nav, align: align, vertical: breakpoints, style: style, width: width)
    }
    
    public convenience init(_ ol: Ol,
                            align: Align? = nil,
                            vertical breakpoints: Set<Breakpoint>? = nil,
                            style: Style? = nil,
                            width: Width? = nil) {
        self.init(tag: ol, align: align, vertical: breakpoints, style: style, width: width)
    }
    
    public convenience init(_ ul: Ul,
                            align: Align? = nil,
                            vertical breakpoints: Set<Breakpoint>? = nil,
                            style: Style? = nil,
                            width: Width? = nil) {
        self.init(tag: ul, align: align, vertical: breakpoints, style: style, width: width)
    }
    
    internal init(tag: Tag,
                  align: Align?,
                  vertical breakpoints: Set<Breakpoint>?,
                  style: Style?,
                  width: Width?) {
        self.tag = tag
        switch align {
        case .right:
            self.align = .justifyContentEnd
        case .center:
            self.align = .justifyContentCenter
        default:
            self.align = nil
        }
        if let bp = breakpoints {
            var classes: Set<BsClass> = [.flexColumn]
            _ = bp.map {
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
            self.verticals = Array(classes)
        } else {
            self.verticals = nil
        }
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
    let isDropdown: Bool
    
    public static func dropdown(_ a: A, @TagBuilder contents: () -> [Tag]) -> NavItem {
        let li = Li {
            NavLink(a, isDropdownToggle: true)
            Ul {
                contents()
            }.class(add: .dropdownMenu)
        }
        return NavItem(li, isDropdown: true)
    }
    
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        let li = Li {
            NavLink(title, href: href, isActive: isActive, isDisabled: isDisabled)
        }
        self.init(li, isDropdown: false)
    }
    
    public init(_ li: Li, isDropdown: Bool = false) {
        self.li = li
        self.isDropdown = isDropdown
    }
}

extension NavItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        li
            .class(add: .navItem)
            .class(add: .dropdown, if: isDropdown)
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
        let a = A(title).href(href)
        self.init(a, isActive: isActive, isDisabled: isDisabled)
    }
    
    public init(_ a: A,
                isActive: Bool = false,
                isDisabled: Bool = false,
                isDropdownToggle: Bool = false,
                aligns: [(Location, Breakpoint)]? = nil,
                fills: [Breakpoint]? = nil) {
        self.a = a
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
