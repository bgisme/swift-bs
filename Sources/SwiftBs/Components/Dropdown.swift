//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import Darwin

public class Dropdown: Component {
    
//    public enum TagType {
//        case a
//        case button
//    }
    
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
                            size: Size = .md,
                            isDark: Bool = false,
                            direction: Direction = .down,
                            menuAlign: MenuAlign? = nil,
                            menuAs type: DropdownMenu.TagType = .ul,
                            button: () -> Button,
                            @TagBuilder dropdownMenuItems: () -> [Tag]) {
        self.init(id: id,
                  isSplit: isSplit,
                  isDark: isDark,
                  size: size,
                  direction: direction,
                  menuAlign: menuAlign) { id, isSplit, direction, menuAlign, size in
            DropdownButton(dropdownId: id,
                           direction: direction,
                           isSplit: isSplit,
                           menuAlign: menuAlign,
                           size: size,
                           button: button)
        } menu: { id, isDark, align in
            DropdownMenu(dropdownId: id,
                         isDark: isDark,
                         align: align,
                         as: type) {
                dropdownMenuItems()
            }
        }
    }
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            isDark: Bool = false,
                            size: Size = .md,
                            direction: Direction = .down,
                            menuAlign: MenuAlign? = nil,
                            menuAs type: DropdownMenu.TagType = .ul,
                            a: () -> A,
                            @TagBuilder dropdownMenuItems: () -> [Tag]) {
        self.init(id: id,
                  isSplit: isSplit,
                  isDark: isDark,
                  size: size,
                  direction: direction,
                  menuAlign: menuAlign) { id, isSplit, direction, menuAlign, size in
            DropdownButton(dropdownId: id,
                           direction: direction,
                           isSplit: isSplit,
                           menuAlign: menuAlign,
                           size: size,
                           a: a)
        } menu: { id, isDark, align in
            DropdownMenu(dropdownId: id,
                         isDark: isDark,
                         align: align,
                         as: type) {
                dropdownMenuItems()
            }
        }
    }
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            isDark: Bool = false,
                            size: Size = .md,
                            direction: Direction = .down,
                            menuAlign: MenuAlign? = nil,
                            button: (Id, IsSplit, Dropdown.Direction, MenuAlign?, Size) -> DropdownButton,
                            menu: (Id, IsDark, MenuAlign?) -> DropdownMenu) {
        let button = button(id, isSplit, direction, menuAlign, size)
        let arrowButton = DropdownButtonArrow(id: id)
        if isSplit, let classes = button.tag.value(.class)?.bsClasses {
            // apply button classes to arrow button so they match
            arrowButton.class(insert: classes)
        }
        let div: Div
        if isSplit {
            if direction != .start {
                div = Div {
                    button
                    arrowButton
                    menu(id, isDark, menuAlign)
                }
                .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
            } else {
                div = Div {
                    Div {
                        /// split buttons direction .start are ordered differently and inside extra button group
                        arrowButton
                        menu(id, isDark, menuAlign)
                    }
                    .class(insert: .dropstart)
                    .role(.group)
                    button
                }
                .class(insert: .btnGroup)
            }
        } else {
            /// non-split
            div = Div {
                button
                menu(id, isDark, menuAlign)
            }
            .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
        }
        self.init(button: button, arrowButton: arrowButton, div)
    }
        
    public init(button: DropdownButton, arrowButton: DropdownButtonArrow?, _ div: Div) {
        self.button = button
        self.arrowButton = arrowButton

        div
            .class(insert: .btnGroup)
        
        super.init(div)
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
        if !isSplit {
            _ = button
                .class(insert: .dropdownToggle)
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
                .id(id)
        }
        self.init(dropdownId: id, direction: direction, isSplit: isSplit, menuAlign: menuAlign, size: size, button)
    }
    
    internal init(dropdownId id: String,
                  direction: Dropdown.Direction,
                  isSplit: Bool,
                  menuAlign: Dropdown.MenuAlign?,
                  size: Size,
                  _ tag: Tag) {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        tag
            .dataBsDisplay(.static, !isSplit && isMenuAlignResponsive)
            .class(insert: size.buttonClass)
        super.init(tag)
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
        
    public convenience init(id: String) {
        let button = Button {
            Span {
                Text("Toggle Dropdown")
            }
            .class(insert: .visuallyHidden)
        }
        self.init(id: id, button)
    }
    
    public init(id: String, _ button: Button) {
        button
            .type(.button)
            .class(insert: .btn, .dropdownToggle, .dropdownToggleSplit)
            .id(id) // not required for button groups
            .dataBsToggle(.dropdown)
            .ariaExpanded(false)
        
        super.init(button)
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
    
    public enum TagType {
        case ol
        case ul
        case div
        
        public func tag(@TagBuilder _ contents: () -> [Tag]) -> Tag {
            switch self {
            case .ol:
                return Ol { contents() }
            case .ul:
                return Ul { contents() }
            case .div:
                return Div { contents() }
            }
        }
    }
    
    /// contents ... DropdownMenuItems or anything
    public convenience init(dropdownId: String,
                            isDark: Bool = false,
                            align: Dropdown.MenuAlign? = nil,
                            as type: TagType = .ul,
                            @TagBuilder contents: () -> [Tag]) {
        let tag = type.tag { contents() }
        self.init(dropdownId: dropdownId, isDark: isDark, align: align, tag)
    }

    // base init needs Tag so it is accessible for styling at declaration
    public init(dropdownId: String,
                isDark: Bool,
                align: Dropdown.MenuAlign?,
                _ tag: Tag) {
        tag
            .class(insert: .dropdownMenu)
            .class(insert: .dropdownMenuDark, if: isDark)
            .class(insert: align?.classes)
            .ariaLabelledBy(dropdownId)

        super.init(tag)
    }
}

public class DropdownMenuItem: Component {
    
    public convenience init(nonInteractive span: () -> Span) {
        self.init(isActive: false, isDisabled: false, isInteractive: false, span())
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
        self.init(isActive: isActive, isDisabled: isDisabled, isInteractive: true, a())
    }
    
    /// <Button> menu item
    public convenience init(isActive: Bool = false, isDisabled: Bool = false, button: () -> Button) {
        self.init(isActive: isActive, isDisabled: isDisabled, isInteractive: true, button())
    }
    
    /// Only allow certain Tag
    private init(isActive: Bool,
                 isDisabled: Bool,
                 isInteractive: Bool,
                 _ tag: Tag) {
        if isInteractive {
            tag
                .class(insert: .dropdownItem)
                .class(insert: .active, if: isActive)
                .ariaCurrent(isActive)
                .class(insert: .disabled, if: isDisabled)
        } else {
            tag
                .class(insert: .dropdownItemText)
        }
        let tag = Li { tag }
        
        super.init(tag)
    }
}

public class DropdownMenuDivider: Component {
    
    public init() {
        let hr = Hr()
            .class(insert: .dropdownDivider)
        super.init(hr)
    }
}

public class DropdownMenuHeader: Component {
   
    public convenience init(_ text: String) {
        let h6 = H6(text)

        self.init(h6)
    }
    
    public init(_ h6: H6) {
        h6
            .class(insert: .dropdownHeader)
        let tag = Li { h6 }
        
        super.init(tag)
    }
}
