
import SwiftHtml

open class NavTab: Tag {
    
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
    
    public enum Kind: String {
        case nav
        case ol
        case ul
    }
    
    public var style: Style? {
        let firstStyleStr = Style.allCases.compactMap{ style in value(.class)?.classes.first{ $0 == style.rawValue } }.first
        if let styleStr = firstStyleStr, let style = Style(rawValue: styleStr) {
            return style
        }
        return nil
    }
    
    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .nav)
    }
}

extension NavTab {
    
    @discardableResult
    public func align(_ value: Align, _ condition: Bool = true) -> Self {
        switch value {
        case .right:
            return self.class(insert: .justifyContentEnd, if: condition)
        case .center:
            return self.class(insert: .justifyContentCenter, if: condition)
        }
    }
    
    @discardableResult
    public func breakpoints(_ values: Breakpoint..., if condition: Bool = true) -> Self {
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
        return self
            .class(insert: Array(breakpoints), condition)
    }
    
    @discardableResult
    public func style(_ value: Style, _ condition: Bool = true) -> Self {
        self
            .class(insert: value.class, if: condition)
    }
    
    @discardableResult
    public func width(_ value: Width, _ condition: Bool = true) -> Self {
        switch value {
        case .proportional:
            return self.class(insert: .navFill, if: condition)
        case .equal:
            return self.class(insert: .navJustified, if: condition)
        }
    }
    
    @discardableResult
    public func isCardHeaderTabs(if condition: Bool = true) -> Self {
        self
            .class(insert: .cardHeaderTabs, if: condition)
    }
}

open class NavItem: Li {
    
    public let link: NavLink
    
    public convenience init(_ title: String, href: String) {
        self.init(link: NavLink(title, href: href))
    }
    
    public init(link: NavLink) {
        self.link = link
        super.init([link])
        self
            .class(insert: .navItem)
    }
}


open class NavLink: A {
    
    public convenience init(_ title: String, href: String) {
        self.init(contents: title)
        self
            .href(href)
    }
    
    public init(contents: String,
                _ children: [Tag]? = nil) {
        super.init(contents: contents,
                   children)
        self
            .class(insert: .navLink)
    }
}

extension NavLink {
    
    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        self
            .class(insert: .active, if: condition)
            .ariaCurrent(condition)
    }
    
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        self
            .class(insert: .disabled, if: condition)
    }
    
    @discardableResult
    public func aligns( _ values: (Location, Breakpoint)..., if condition: Bool = true) -> Self {
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
        return self
            .class(insert: Array(classes), condition)
    }
    
    @discardableResult
    public func fills(_ values: Breakpoint..., if condition: Bool = true) -> Self {
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
        return self
            .class(insert: Array(classes), condition)
    }
    
    @discardableResult
    public func scrollspy(on id: String, _ condition: Bool = true) -> Self {
        self.attribute("href", "#\(id)", condition)
    }
}

open class NavItemDropdown: Li {
        
    public let button: NavDropdownButton
    public let menu: DropdownMenu
        
    public init(id: String,
                button: () -> NavDropdownButton,
                menu: () -> DropdownMenu) {
        // create and capture
        let button = button()
        self.button = button
        let menu = menu()
        self.menu = menu
        // initialize
        super.init([button, menu])
    }    
}

extension NavItemDropdown {
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        menu.isDark(if: condition)
        return self
    }
}

open class NavDropdownButton: A {
    
    public convenience init(_ title: String, href: String) {
        self.init { Text(title) }
        self
            .href(href)
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .navLink)
            .class(insert: .dropdownToggle)
            .dataBsToggle(.dropdown)
            .ariaExpanded(false)
            .role(.button)
    }
}

/// Tabs created in yousnite... had to add class utilities .tabContent and .tabPane
/// So maybe this structure is more current to the version of Bootstrap?
/// Didn't want to throw it away
///
///
///
//class Tabs: Tag {
//
//    init(items: [(buttonTitle: String, paneContent: String)]) {
//        let id = "memberships"
//        let buttonID = id + "-tab"
//        let paneID = id + "-pane"
//        let buttons = items.enumerated().map { index, item in
//            TabButton(id: buttonID,
//                      paneID: paneID,
//                      index: index,
//                      isSelected: index == 0) {
//                P(item.buttonTitle)
//            }
//        }
//        let panes = items.enumerated().map { index, item in
//            TabPane(id: paneID,
//                    buttonID: buttonID,
//                    index: index,
//                    isVisible: index == 0) {
//                P(item.paneContent)
//            }
//        }
//        super.init(Tag {
//            TabsUl(id, buttons)
//            TabContent(id, panes)
//        }.children)
//    }
//
//    private static func indexString(_ index: Int) -> String {
//        "-\(index)"
//    }
//
//    class TabsUl: Ul {
//
//        init(_ id: String,
//             _ buttons: [TabButton]) {
//            super.init(Tag {
//                for button in buttons {
//                    TabContentLi(button)
//                }
//            }.children)
//            self
//                .class(insert: .nav, .navPills, .mb4)
//                .id(id + "-tabs")
//                .role(.tablist)
//        }
//    }
//
//    class TabContentLi: Li {
//
//        init(_ button: TabButton) {
//            super.init(Tag {
//                button
//            }.children)
//            self
//                .class(insert: .navItem)
//                .role(.presentation)
//        }
//    }
//
//    class TabButton: Button {
//
//        init(id: String,
//             paneID: String,
//             index: Int,
//             isSelected: Bool,
//             @TagBuilder contents: () -> Tag) {
//            let indexString = Tabs.indexString(index)
//            let indexedID = id + indexString
//            let indexedPaneID = paneID + indexString
//            super.init(Tag {
//                contents()
//            }.children)
//            self
//                .class(insert: .navLink)
//                .class(insert: .active, if: isSelected)
//                .id(indexedID)
//                .dataBsToggle(.pill)
//                .dataBsTarget(indexedPaneID)
//                .type(.button)
//                .role(.tab)
//                .ariaControls(indexedPaneID)
//                .ariaSelected(isSelected)
//        }
//    }
//
//    class TabContent: Div {
//
//        init(_ id: String,
//             _ panes: [TabPane]) {
//            super.init(Tag {
//                for pane in panes {
//                    pane
//                }
//            }.children)
//            self
//                .class(insert: .tabContent)
//                .id(id + "-content")
//        }
//    }
//
//    class TabPane: Div {
//
//        init(id: String,
//             buttonID: String,
//             index: Int,
//             isVisible: Bool,
//             @TagBuilder contents: () -> Tag) {
//            let indexString = Tabs.indexString(index)
//            let indexedID = id + indexString
//            let indexedButtonID = buttonID + indexString
//            super.init(Tag {
//                contents()
//            }.children)
//            self
//                .class(insert: .tabPane, .fade)
//                .class(insert: .show, .active, if: isVisible)
//                .id(indexedID)
//                .role(.tabpanel)
//                .ariaLabelledBy(indexedButtonID)
//                .tabindex(0)
//        }
//    }
//}
//
