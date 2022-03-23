//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import Darwin

public class Dropdown: Component {
    
    public enum TagType {
        case a
        case button
    }
    
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
    
    public typealias Id = String
    public typealias IsSplit = Bool
    public typealias IsDark = Bool
    
    let button: DropdownButton
    let arrowButton: DropdownButtonArrow?
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            direction: Direction = .down,
                            menuAlign: MenuAlign? = nil,
                            isDark: Bool = false,
                            size: Size = .md,
                            button: () -> Button,
                            @TagBuilder dropdownMenuItems: () -> [Tag]) {
        self.init(id: id,
                  isSplit: isSplit,
                  direction: direction,
                  menuAlign: menuAlign,
                  isDark: isDark,
                  size: size) { id, isSplit, direction, menuAlign, size in
            DropdownButton(dropdownId: id,
                           direction: direction,
                           isSplit: isSplit,
                           menuAlign: menuAlign,
                           size: size,
                           button: button)
        } menu: { id, isDark, align in
            DropdownMenu(dropdownId: id,
                         isDark: isDark,
                         align: align) {
                dropdownMenuItems()
            }
        }
    }
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            direction: Direction = .down,
                            menuAlign: MenuAlign? = nil,
                            isDark: Bool = false,
                            size: Size = .md,
                            a: () -> A,
                            @TagBuilder dropdownMenuItems: () -> [Tag]) {
        self.init(id: id,
                  isSplit: isSplit,
                  direction: direction,
                  menuAlign: menuAlign,
                  isDark: isDark,
                  size: size) { id, isSplit, direction, menuAlign, size in
            DropdownButton(dropdownId: id,
                           direction: direction,
                           isSplit: isSplit,
                           menuAlign: menuAlign,
                           size: size,
                           a: a)
        } menu: { id, isDark, align in
            DropdownMenu(dropdownId: id,
                         isDark: isDark,
                         align: align) {
                dropdownMenuItems()
            }
        }
    }
    
    public init(id: String,
                isSplit: Bool = false,
                direction: Direction = .down,
                menuAlign: MenuAlign? = nil,
                isDark: Bool = false,
                size: Size = .md,
                button: (Id, IsSplit, Dropdown.Direction, MenuAlign?, Size) -> DropdownButton,
                menu: (Id, IsDark, MenuAlign?) -> DropdownMenu) {
        let button = button(id, isSplit, direction, menuAlign, size)
        let arrowButton = DropdownButtonArrow(id: id)
        if isSplit, let classes = button.tag.value(.class)?.bsClasses {
            // apply button classes to arrow button so they match
            arrowButton.class(insert: classes)
        }
        self.button = button
        self.arrowButton = arrowButton
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
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.button.background(value, condition)
        self.arrowButton?.background(value, condition)
        return self
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.button.border(value, condition)
        self.arrowButton?.background(value, condition)
        return self
    }
}

public final class DropdownButton: Component {
        
    public convenience init(_ title: String,
                            href: String,
                            dropdownId id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil,
                            size: Size = .md) {
        self.init(dropdownId: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign, size: size) {
            A(title).href(href)
        }
    }
    
    public convenience init(dropdownId id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil,
                            size: Size = .md,
                            a: () -> A) {
        self.init(dropdownId: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign, size: size) {
            BsButton(a: a)
        }
    }
    
    public convenience init(dropdownId id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil,
                            size: Size = .md,
                            button: () -> Button) {
        self.init(dropdownId: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign, size: size) {
            BsButton(button: button)
        }
    }
    
    public convenience init(dropdownId id: String,
                            direction: Dropdown.Direction = .down,
                            isSplit: Bool = false,
                            menuAlign: Dropdown.MenuAlign? = nil,
                            size: Size = .md,
                            button: () -> BsButton) {
        let button = button().build()
        self.init(dropdownId: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign, size: size, tag: {
            guard !isSplit else { return button }
            return button
                .class(insert: .dropdownToggle)
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
                .id(id)
        })
    }
    
    internal init(dropdownId id: String,
                  direction: Dropdown.Direction,
                  isSplit: Bool,
                  menuAlign: Dropdown.MenuAlign?,
                  size: Size,
                  tag: () -> Tag) {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        super.init {
            tag()
                .dataBsDisplay(.static, !isSplit && isMenuAlignResponsive)
                .class(insert: size.buttonClass)
        }
    }
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonClass, if: condition)
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonOutlineClass, if: condition)
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
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonClass, if: condition)
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonOutlineClass, if: condition)
    }
}

public class DropdownMenu: Component {
    
    public typealias Title = String
    public typealias Href = String
    
    public init(dropdownId: String,
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
            .ariaLabelledBy(dropdownId)
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
    private init(isActive: Bool, isDisabled: Bool, tag: () -> Tag) {
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

public class DropdownMenuHeader: Component {
    
    public convenience init(h1: () -> H1) {
        self.init(tag: h1)
    }
    
    public convenience init(h2: () -> H2) {
        self.init(tag: h2)
    }

    public convenience init(h3: () -> H3) {
        self.init(tag: h3)
    }

    public convenience init(h4: () -> H4) {
        self.init(tag: h4)
    }

    public convenience init(h5: () -> H5) {
        self.init(tag: h5)
    }

    public convenience init(h6: () -> H6) {
        self.init(tag: h6)
    }

    private init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .dropdownHeader)
        }
    }
}
