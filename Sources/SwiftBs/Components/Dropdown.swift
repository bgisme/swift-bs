//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class Dropdown: Component {
    
    public enum Direction {
        case down
        case up
        case start
        case end
        
        var bsClass: BsClass {
            switch self {
            case .down:
                return .dropdown
            case .up:
                return .dropup
            case .start:
                return .dropstart
            case .end:
                return .dropend
            }
        }
    }
    
    // Menus align to left of dropdown by default
    // To align right, add .dropdown-menu-end to menu

    // To align responsively to size of screen
    // Add data-bs-display="static" to single button or split-button
    // Add to menu
    // .dropdown-menu{-sm|-md|-lg|-xl|-xxl}-end
    // or
    // .dropdown-menu{-sm|-md|-lg|-xl|-xxl}-start
    
    // For example, to align the dropdown menu right, and on large screens to left
    // .dropdown-menu-end and .dropdown-menu{-sm|-md|-lg|-xl|-xxl}-start.
    
    public enum MenuAlign {
        case end
        case responsive(_ bp: MenuAlignBreakpoint)
        case endAndResponsive(_ bp: MenuAlignBreakpoint)
        
        var classes: [BsClass] {
            switch self {
            case .end:
                return [.dropdownMenuEnd]
            case .responsive(let bp):
                return [bp.bsClass]
            case .endAndResponsive(let bp):
                return [.dropdownMenuEnd, bp.bsClass]
            }
        }
        
        var isMenuAlignResponsive: Bool {
            switch self {
            case .end:
                return false
            case .responsive, .endAndResponsive:
                return true
            }
        }
    }
    
    public enum MenuAlignBreakpoint {
        case smStart
        case mdStart
        case lgStart
        case xlStart
        case xxlStart
        case smEnd
        case mdEnd
        case lgEnd
        case xlEnd
        case xxlEnd
        
        var bsClass: BsClass {
            switch self {
            case .smStart:
                return .dropdownMenuSmStart
            case .mdStart:
                return .dropdownMenuMdStart
            case .lgStart:
                return .dropdownMenuLgStart
            case .xlStart:
                return .dropdownMenuXlStart
            case .xxlStart:
                return .dropdownMenuXxlStart
            case .smEnd:
                return .dropdownMenuSmEnd
            case .mdEnd:
                return .dropdownMenuMdEnd
            case .lgEnd:
                return .dropdownMenuLgEnd
            case .xlEnd:
                return .dropdownMenuXlEnd
            case .xxlEnd:
                return .dropdownMenuXxlEnd
            }
        }
    }
    
    public typealias Title = String
    public typealias Id = String
    public typealias IsSplit = Bool
    public typealias IsMenuAlignResponsive = Bool
    public typealias IsDark = Bool
    
    let direction: Direction
    let menuAlign: MenuAlign?
    let button: DropdownButton
    let arrowButton: DropdownButtonArrow?
    let menu: DropdownMenu
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            direction: Direction = .down,
                            menuAlign: MenuAlign? = nil,
                            isDark: Bool = false,
                            button: (Id, IsSplit, Dropdown.Direction, MenuAlign?) -> DropdownButton,
                            menu: (Id, IsDark, MenuAlign?) -> DropdownMenu) {
        let button = button(id, isSplit, direction, menuAlign)
        let arrowButton = isSplit ? DropdownButtonArrow(id: id) : nil
        if let classes = button.value(.class)?.bsClasses {
            // so main button and arrow button match
            arrowButton?.class(add: classes)
        }
        self.init(direction: direction,
                  menuAlign: menuAlign,
                  button: button,
                  arrowButton: arrowButton,
                  menu: menu(id, isDark, menuAlign))
    }
    
    public init(direction: Direction = .down,
                menuAlign: MenuAlign?,
                button: DropdownButton,
                arrowButton: DropdownButtonArrow? = nil,
                menu: DropdownMenu) {
        self.direction = direction
        self.menuAlign = menuAlign
        self.button = button
        self.arrowButton = arrowButton
        self.menu = menu
    }
}

extension Dropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        if let arrowButton = arrowButton {
            if direction != .start {
                Div {
                    button
                    arrowButton
                    menu
                }
                .class(add: .btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
                .class(add: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
                .merge(attributes)
            } else {
                Div {
                    Div {
                        /// split buttons direction .start are ordered differently and inside extra button group
                        arrowButton
                        menu
                    }
                    .class(add: .btnGroup, .dropstart)
                    .role(.group)
                    button
                }
                .class(add: .btnGroup)
                .merge(attributes)
            }
        } else {
            /// non-split
            Div {
                button
                menu
            }
            .class(add: .btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
            .class(add: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
            .merge(attributes)
        }
    }
}

public class DropdownButton: Component {
    
    private let tag: Tag
    let id: String
    let direction: Dropdown.Direction
    let isSplit: Bool
    let isMenuAlignResponsive: Bool
    
    public convenience init(_ title: String,
                            href: String? = nil,
                            id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        let tag: Tag
        if let href = href {
            tag = A(title).href(href)
        } else {
            tag = Button(title)
        }
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        self.init(tag: tag, id: id, direction: direction, isSplit: isSplit, isMenuAlignResponsive: isMenuAlignResponsive)
    }
    
    public convenience init(_ link: A,
                            id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        self.init(tag: link, id: id, direction: direction, isSplit: isSplit, isMenuAlignResponsive: isMenuAlignResponsive)
    }
    
    public convenience init(_ button: Button,
                            id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        self.init(tag: button, id: id, direction: direction, isSplit: isSplit, isMenuAlignResponsive: isMenuAlignResponsive)
    }
    
    // Only tags in convenience init()s allowed
    internal required init(tag: Tag,
                           id: String,
                           direction: Dropdown.Direction,
                           isSplit: Bool,
                           isMenuAlignResponsive: Bool) {
        self.tag = tag
        self.id = id
        self.direction = direction
        self.isSplit = isSplit
        self.isMenuAlignResponsive = isMenuAlignResponsive
    }
}

extension DropdownButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        /// split dropdowns have two buttons, non-split just one button
        /// if isSplit will create a simple button or link without special properties
        /// DropdownArrowButton has all the special properties
        /// if NOT isSplit will create button or link with special properties
        if let link = tag as? A {
            if isSplit {
                link
                    .role(.button)
                    .merge(attributes)
            } else {
                link
                    .role(.button)
                    .class(add: .btn, .dropdownToggle)
                    .id(id)
                    .dataBsToggle(.dropdown)
                    .ariaExpanded(false)
                    .dataBsDisplay(.static, isMenuAlignResponsive)
                    .merge(attributes)
            }
        } else if let button = tag as? Button {
            if isSplit {
                button
                    .type(.button)
                    .class(add: .btn)
                    .merge(attributes)
            } else {
                button
                    .type(.button)
                    .class(add: .btn, .dropdownToggle)
                    .id(id) // not required for button groups
                    .dataBsToggle(.dropdown)
                    .ariaExpanded(false)
                    .dataBsDisplay(.static, isMenuAlignResponsive)
                    .merge(attributes)
            }
        }
    }
}

public class DropdownButtonArrow: Component {
    
    let id: String
    
    public init(id: String) {
        self.id = id
    }
}

extension DropdownButtonArrow: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Button {
            Span {
                Text("Toggle Dropdown")
            }
            .class(add: .visuallyHidden)
        }
        .type(.button)
        .class(add: .btn, .dropdownToggle, .dropdownToggleSplit)
        .id(id) // not required for button groups
        .dataBsToggle(.dropdown)
        .ariaExpanded(false)
        .merge(attributes)
    }
}

public class DropdownMenu: Component {
    
    public typealias Title = String
    public typealias Href = String
        
    let ul: Ul
    let id: String
    let isDark: Bool
    let align: Dropdown.MenuAlign?
    
    public convenience init(id: String,
                            isDark: Bool = false,
                            align: Dropdown.MenuAlign? = nil,
                            links: [(Title, Href)?]) {
        self.init(id: id, isDark:isDark, align: align) {
            for link in links {
                if let (title, href) = link {
                    DropdownItem(title, href: href)
                } else {
                    DropdownItem.divider()
                }
            }
        }
    }
    
    public convenience init(id: String,
                            isDark: Bool = false,
                            align: Dropdown.MenuAlign? = nil,
                            @TagBuilder items: () -> [Tag]) {
        let ul = Ul { items() }
        self.init(ul, id: id, isDark: isDark, align: align)
    }
    
    public init(_ ul: Ul,
                id: String,
                isDark: Bool = false,
                align: Dropdown.MenuAlign? = nil) {
        self.ul = ul
        self.id = id
        self.isDark = isDark
        self.align = align
    }
}

extension DropdownMenu: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        ul
            .class(add: .dropdownMenu)
            .class(add: .dropdownMenuDark, if: isDark)
            .class(add: align?.classes)
            .ariaLabelledBy(id)
            .merge(attributes)
    }
}

public class DropdownItem: Component {
    
    let tag: Tag?
    let isActive: Bool
    let isDisabled: Bool
    
    public static func divider() -> Self {
        Self.init(tag: nil, isActive: false, isDisabled: false)
    }
    
    public convenience init(nonInteractive tag: Span) {
        self.init(tag: tag, isActive: false, isDisabled: false)
    }
    
    /// <A> or <Button> menu item
    public convenience init(_ title: String,
                            href: String? = nil,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        let tag: Tag
        if let href = href {
            tag = A(title).href(href)
        } else {
            tag = Button(title)
        }
        self.init(tag: tag, isActive: isActive, isDisabled: isDisabled)
    }
    
    /// <A> menu item
    public convenience init(_ a: A, isActive: Bool = false, isDisabled: Bool = false) {
        self.init(tag: a, isActive: isActive, isDisabled: isDisabled)
    }
    
    /// <Button> menu item
    public convenience init(_ button: Button, isActive: Bool = false, isDisabled: Bool = false) {
        self.init(tag: button, isActive: isActive, isDisabled: isDisabled)
    }
    
    /// Only allow certain Tag
    internal required init(tag: Tag?, isActive: Bool, isDisabled: Bool) {
        self.tag = tag
        self.isActive = isActive
        self.isDisabled = isDisabled
    }
}

extension DropdownItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        if let tag = tag {
            Li {
                if let span = tag as? Span {
                    span
                        .class(add: .dropdownItemText)
                } else {
                    tag
                        .class(add: .dropdownItem)
                        .class(add: .active, if: isActive)
                        .ariaCurrent(isActive)
                        .class(add: .disabled, if: isDisabled)
                }
            }
            .merge(attributes)
        } else {
            // divider
            Hr()
                .class(add: .dropdownDivider)
                .merge(attributes)
        }
    }
}
