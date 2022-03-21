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
                return [bp.class]
            case .endAndResponsive(let bp):
                return [.dropdownMenuEnd, bp.class]
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
        
        var `class`: BsClass {
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
    
    public init(id: String,
                isSplit: Bool = false,
                direction: Direction = .down,
                menuAlign: MenuAlign? = nil,
                isDark: Bool = false,
                button: (Id, IsSplit, Dropdown.Direction, MenuAlign?) -> DropdownButton,
                menu: (Id, IsDark, MenuAlign?) -> DropdownMenu) {
        let button = button(id, isSplit, direction, menuAlign)
        let arrowButton = DropdownButtonArrow(id: id)
        if isSplit, let classes = button.tag.value(.class)?.bsClasses {
            // apply button classes to arrow button so they match
            arrowButton.class(insert: classes)
        }
        super.init {
            if isSplit {
                if direction != .start {
                    Div {
                        button
                        arrowButton
                        menu(id, isDark, menuAlign)
                    }
                    .class(insert: .btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
                    .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
                } else {
                    Div {
                        Div {
                            /// split buttons direction .start are ordered differently and inside extra button group
                            arrowButton
                            menu(id, isDark, menuAlign)
                        }
                        .class(insert: .btnGroup, .dropstart)
                        .role(.group)
                        button
                    }
                    .class(insert: .btnGroup)
                }
            } else {
                /// non-split
                Div {
                    button
                    menu(id, isDark, menuAlign)
                }
                .class(insert: .btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
                .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
            }
        }
    }
    
//    public init(direction: Direction = .down,
//                menuAlign: MenuAlign?,
//                button: DropdownButton,
//                arrowButton: DropdownButtonArrow? = nil,
//                menu: DropdownMenu) {
//        super.init {
//            if let arrowButton = arrowButton {
//                if direction != .start {
//                    Div {
//                        button
//                        arrowButton
//                        menu
//                    }
//                    .class(insert: .btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
//                    .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
//                } else {
//                    Div {
//                        Div {
//                            /// split buttons direction .start are ordered differently and inside extra button group
//                            arrowButton
//                            menu
//                        }
//                        .class(insert: .btnGroup, .dropstart)
//                        .role(.group)
//                        button
//                    }
//                    .class(insert: .btnGroup)
//                }
//            } else {
//                /// non-split
//                Div {
//                    button
//                    menu
//                }
//                .class(insert: .btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
//                .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
//            }
//        }
//    }
}

public class DropdownButton: Component {
        
    public convenience init(_ title: String,
                            href: String,
                            id: String,
                            color: ThemeColor? = nil,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        let a = A(title).href(href)
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        self.init(id: id, color: color, direction: direction, isSplit: isSplit, isMenuAlignResponsive: isMenuAlignResponsive) { a }
    }
    
    public convenience init(_ a: A,
                            id: String,
                            color: ThemeColor? = nil,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        self.init(id: id, color: color, direction: direction, isSplit: isSplit, isMenuAlignResponsive: isMenuAlignResponsive) { a }
    }
    
    public convenience init(_ button: Button,
                            id: String,
                            color: ThemeColor? = nil,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil) {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        self.init(id: id, color: color, direction: direction, isSplit: isSplit, isMenuAlignResponsive: isMenuAlignResponsive) { button }
    }
    
    // Only tags in convenience init()s allowed
    internal required init(id: String,
                           color: ThemeColor? = nil,
                           direction: Dropdown.Direction,
                           isSplit: Bool,
                           isMenuAlignResponsive: Bool,
                           tag: () -> Tag) {
        let tag = tag()
        let colorClass = color != nil ? color!.buttonClass : nil
        tag.class(insert: colorClass)
        super.init {
            /// split dropdowns have two buttons, non-split just one button
            /// if isSplit will create a simple button or link without special properties
            /// DropdownArrowButton has all the special properties
            /// if NOT isSplit will create button or link with special properties
            if let link = tag as? A {
                if isSplit {
                    link
                        .role(.button)
        
                } else {
                    link
                        .role(.button)
                        .class(insert: .btn, .dropdownToggle)
                        .id(id)
                        .dataBsToggle(.dropdown)
                        .ariaExpanded(false)
                        .dataBsDisplay(.static, isMenuAlignResponsive)
        
                }
            } else if let button = tag as? Button {
                if isSplit {
                    button
                        .type(.button)
                        .class(insert: .btn)
                } else {
                    button
                        .type(.button)
                        .class(insert: .btn, .dropdownToggle)
                        .id(id) // not required for button groups
                        .dataBsToggle(.dropdown)
                        .ariaExpanded(false)
                        .dataBsDisplay(.static, isMenuAlignResponsive)
                }
            }
        }
    }
}

public class DropdownButtonArrow: Component {
        
    public init(id: String) {
        super.init {
            Button {
                Span {
                    Text("Toggle Dropdown")
                }
                .class(insert: .visuallyHidden)
            }
            .type(.button)
            .class(insert: .btn, .dropdownToggle, .dropdownToggleSplit)
            .id(id) // not required for button groups
            .dataBsToggle(.dropdown)
            .ariaExpanded(false)
        }
    }
}

public class DropdownMenu: Component {
    
    public typealias Title = String
    public typealias Href = String
    
    public init(buttonId: String,
                isDark: Bool = false,
                align: Dropdown.MenuAlign? = nil,
                @TagBuilder dropdownMenuItems: () -> [Tag]) {
        super.init {
            Ul {
                dropdownMenuItems()
            }
            .class(insert: .dropdownMenu)
            .class(insert: .dropdownMenuDark, if: isDark)
            .class(insert: align?.classes)
            .ariaLabelledBy(buttonId)
        }
    }
}

public class DropdownMenuItem: Component {
    
    public convenience init(nonInteractive span: () -> Span) {
        self.init(isActive: false, isDisabled: false, tag: span)
    }
    
    /// <A> menu item
    public convenience init(_ title: String,
                            href: String,
                            isActive: Bool = false,
                            isDisabled: Bool = false) {
        self.init(isActive: isActive, isDisabled: isDisabled, a: {
            A(title).href(href)
        })
    }
    
    /// <A> menu item
    public convenience init(isActive: Bool = false, isDisabled: Bool = false, a: () -> A) {
        self.init(isActive: isActive, isDisabled: isDisabled, tag: a)
    }
    
    /// <Button> menu item
    public convenience init(isActive: Bool = false, isDisabled: Bool = false, button: () -> Button) {
        self.init(isActive: isActive, isDisabled: isDisabled, tag: button)
    }
    
    /// Only allow certain Tag
    internal required init(isActive: Bool, isDisabled: Bool, tag: () -> Tag) {
        let tag = tag()
        super.init {
            Li {
                if let span = tag as? Span {
                    span
                        .class(insert: .dropdownItemText)
                } else {
                    tag
                        .class(insert: .dropdownItem)
                        .class(insert: .active, if: isActive)
                        .ariaCurrent(isActive)
                        .class(insert: .disabled, if: isDisabled)
                }
            }
        }
    }
}

public class DropdownMenuDivider: Component {
    
    public init() {
        super.init { Hr().class(insert: .dropdownDivider) }
    }
}
