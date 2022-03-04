//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSgml
import IOKit

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
        
        var bsClass: BsClass {
            switch self {
            case .end:
                return .dropdownMenuEnd
            case .responsive(let bp):
                switch bp {
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
        
        var isMenuAlignResponsive: Bool {
            switch self {
            case .end:
                return false
            case .responsive:
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
    }
    
    public typealias Id = String
    public typealias IsSplit = Bool
    public typealias IsMenuAlignResponsive = Bool
    
    let id: String
    let direction: Direction
    let isSplit: Bool
    let menuAlign: MenuAlign?
    private var button: (Id, IsSplit, Dropdown.Direction, MenuAlign?) -> [Tag]
    private var splitButton: (Id) -> [Tag]
    private var menu: (Id, MenuAlign?) -> [Tag]
    
    /// non-split buttons
    public convenience init(id: String,
                            direction: Direction = .down,
                            menuAlign: MenuAlign? = nil,
                            @TagBuilder button: @escaping (Id, IsSplit, Dropdown.Direction, MenuAlign?) -> [Tag],
                            @TagBuilder menu: @escaping (Id, MenuAlign?) -> [Tag]) {
        self.init(id: id,
                  direction: direction,
                  isSplit: false,
                  menuAlign: menuAlign,
                  button: button,
                  splitButton: {_ in },
                  menu: menu)
    }
    
    /// split buttons
    public init(id: String,
                direction: Direction = .down,
                isSplit: Bool = false,
                menuAlign: MenuAlign? = nil,
                @TagBuilder button: @escaping (Id, IsSplit, Dropdown.Direction, MenuAlign?) -> [Tag],
                @TagBuilder splitButton: @escaping(Id) -> [Tag],
                @TagBuilder menu: @escaping (Id, MenuAlign?) -> [Tag]) {
        self.id = id
        self.direction = direction
        self.isSplit = isSplit
        self.menuAlign = menuAlign
        self.button = button
        self.splitButton = splitButton
        self.menu = menu
        super.init({})
    }
}

extension Dropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        if !isSplit || (isSplit && direction != .start) {
            Div {
                if isSplit {
                    button(id, isSplit, direction, nil) // no menu align for split-dropdowns
                    splitButton(id)
                    menu(id, nil)
                } else {
                    button(id, isSplit, direction, menuAlign)   // only menus on non-split dropdowns align responsively
                    menu(id, menuAlign)
                }
            }
            .class(.btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
            .class(add: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
            .class(add: bsClasses)
        } else {
            Div {
                Div {
                    /// split buttons direction .start are ordered differently and inside extra button group
                    splitButton(id)
                    menu(id, nil)
                }
                .class(.btnGroup, .dropstart)
                .role(.group)
                button(id, isSplit, direction, nil)
            }
            .class(.btnGroup)
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
        self.init(tag: tag, id: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign)
    }
    
    public convenience init(_ link: A,
                            id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        self.init(tag: link, id: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign)
    }
    
    public convenience init(_ button: Button,
                            id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        self.init(tag: button, id: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign)
    }
    
    // Convert optional MenuAlign parameter supplied by Dropdown to required Bool value isMenuAlignResponsive
    internal convenience init(tag: Tag, id: String, direction: Dropdown.Direction, isSplit: Bool, menuAlign: Dropdown.MenuAlign?) {
        self.init(tag: tag,
                  id: id,
                  direction: direction,
                  isSplit: isSplit,
                  isMenuAlignResponsive: menuAlign?.isMenuAlignResponsive ?? false)
    }
    
    // Only certain tags allowed
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
        super.init({})
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
                    .class(add: bsClasses)
            } else {
                link
                    .role(.button)
                    .class(.btn, .dropdownToggle)
                    .id(id)
                    .dataBsToggle(.dropdown)
                    .ariaExpanded(false)
                    .class(add: bsClasses)
                    .dataBsDisplay(.static, isMenuAlignResponsive)
            }
        } else if let button = tag as? Button {
            if isSplit {
                button
                    .type(.button)
                    .class(.btn)
                    .class(add: bsClasses)
            } else {
                button
                    .type(.button)
                    .class(.btn, .dropdownToggle)
                    .id(id) // not required for button groups
                    .dataBsToggle(.dropdown)
                    .ariaExpanded(false)
                    .class(add: bsClasses)
                    .dataBsDisplay(.static, isMenuAlignResponsive)
            }
        }
    }
}

public class DropdownButtonArrow: Component {
    
    let id: String
    
    public init(id: String) {
        self.id = id
        super.init({})
    }
}

extension DropdownButtonArrow: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Button {
            Span {
                Text("Toggle Dropdown")
            }
            .class(.visuallyHidden)
        }
        .type(.button)
        .class(.btn, .dropdownToggle, .dropdownToggleSplit)
        .id(id) // not required for button groups
        .dataBsToggle(.dropdown)
        .ariaExpanded(false)
        .class(add: bsClasses)
    }
}

public class DropdownMenu: Component {
        
    let id: String
    let isDark: Bool
    let align: Dropdown.MenuAlign?
    
    public init(id: String,
                isDark: Bool = false,
                align: Dropdown.MenuAlign? = nil,
                @TagBuilder children: @escaping () -> [Tag]) {
        self.id = id
        self.isDark = isDark
        self.align = align
        super.init(children)
    }
}

extension DropdownMenu: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Ul {
            children()
        }
        .class(.dropdownMenu)
        .class(add: .dropdownMenuDark, if: isDark)
        .class(add: align?.bsClass)
        .ariaLabelledBy(id)
        .class(add: bsClasses)
    }
}

public class DropdownItem: Component {
    
    let tag: Tag?
    let isActive: Bool
    let isDisabled: Bool
    
    public static func divider() -> Self {
        Self.init(tag: nil) {}
    }
    
    public convenience init(nonInteractive tag: Span) {
        self.init(tag: tag) {}
    }
    
    /// <A> or <Button> menu item
    public convenience init(_ title: String, href: String? = nil, isActive: Bool = false, isDisabled: Bool = false) {
        let tag: Tag
        if let href = href {
            tag = A(title).href(href)
        } else {
            tag = Button(title)
        }
        self.init(tag: tag, isActive: isActive, isDisabled: isDisabled) {}
    }
    
    /// <A> menu item
    public convenience init(_ a: A, isActive: Bool = false, isDisabled: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.init(tag: a, isActive: isActive, isDisabled: isDisabled, children: children)
    }
    
    /// <Button> menu item
    public convenience init(_ button: Button,
                            isActive: Bool = false,
                            isDisabled: Bool = false,
                            @TagBuilder children: @escaping () -> [Tag]) {
        self.init(tag: button, isActive: isActive, isDisabled: isDisabled, children: children)
    }
    
    /// Only allow certain Tag
    internal required init(tag: Tag?,
                           isActive: Bool = false,
                           isDisabled: Bool = false,
                           @TagBuilder children: @escaping () -> [Tag]) {
        self.tag = tag
        self.isActive = isActive
        self.isDisabled = isDisabled
        super.init(children)
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
                        .class(.dropdownItem)
                        .class(add: .active, if: isActive)
                        .ariaCurrent(isActive)
                        .class(add: .disabled, if: isDisabled)
                }
            }
            .class(add: bsClasses)
        } else {
            // divider
            Hr()
                .class(.dropdownDivider)
                .class(add: bsClasses)
        }
    }
}
