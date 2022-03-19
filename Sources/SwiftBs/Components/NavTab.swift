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
            
    public convenience init(align: Align? = nil,
                            breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            nav: () -> Nav) {
        self.init(align: align, breakpoints: breakpoints, style: style, width: width, tag: { nav() })
    }
    
    public convenience init(align: Align? = nil,
                            breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            ol: () -> Ol) {
        self.init(align: align, breakpoints: breakpoints, style: style, width: width, tag: { ol() })
    }
    
    public convenience init(align: Align? = nil,
                            breakpoints: Breakpoint...,
                            style: Style? = nil,
                            width: Width? = nil,
                            ul: () -> Ul) {
        self.init(align: align, breakpoints: breakpoints, style: style, width: width, tag: { ul() })
    }
    
    internal init(align: Align?,
                  breakpoints: [Breakpoint],
                  style: Style?,
                  width: Width?,
                  tag: () -> Tag) {
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
        super.init {
            tag()
                .class(insert: .nav)
                .class(insert: alignment)
                .class(insert: verticals)
                .class(insert: navStyle)
                .class(insert: spacing)
        }
    }
}

public class NavItem: Component {
        
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
        super.init {
            li()
                .class(insert: .navItem)
        }
    }
}

public class NavItemDropdown: Component {
    
    public typealias Id = String
        
    public init(id: String, a: () -> A, menu: (Id) -> DropdownMenu) {
        super.init {
            Li {
                NavLink(isDropdownToggle: true) { a().id(id) }
                menu(id)
            }
            .class(insert: .navItem, .dropdown)
        }
    }
}

public class NavLink: Component {
    
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
        super.init {
            a()
                .class(insert: .navLink)
                .class(insert: .active, if: isActive)
                .ariaCurrent(isActive)
                .class(insert: .disabled, if: isDisabled)
                .class(insert: .dropdownToggle, if: isDropdownToggle)
                .dataBsToggle(.dropdown, isDropdownToggle)
                .ariaExpanded(false, isDropdownToggle)
                .class(insert: Array(classes))
        }
    }
}
