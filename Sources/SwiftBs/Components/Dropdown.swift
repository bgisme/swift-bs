//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import Darwin

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
    
    public typealias Id = String
    public typealias IsSplit = Bool
    public typealias IsDark = Bool
    
    let button: DropdownButton
    let arrowButton: DropdownButtonArrow?
    let menu: DropdownMenu
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            direction: Direction = .down,
                            menuAlign: DropdownMenu.Align? = nil,
                            menuAs type: DropdownMenu.TagType = .ul,
                            button: () -> Button,
                            @TagBuilder dropdownItems: () -> [Tag]) {
        self.init(id: id,
                  isSplit: isSplit,
                  direction: direction,
                  menuAlign: menuAlign) { id, isSplit, menuAlign  in
            DropdownButton(dropdownId: id,
                           isSplit: isSplit,
                           menuAlign: menuAlign,
                           button: button)
        } menu: { id, align in
            DropdownMenu(dropdownId: id,
                         align: align,
                         as: type) {
                dropdownItems()
            }
        }
    }
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            direction: Direction = .down,
                            menuAlign: DropdownMenu.Align? = nil,
                            menuAs type: DropdownMenu.TagType = .ul,
                            a: () -> A,
                            @TagBuilder dropdownItems: () -> [Tag]) {
        self.init(id: id,
                  isSplit: isSplit,
                  direction: direction,
                  menuAlign: menuAlign) { id, isSplit, menuAlign in
            DropdownButton(dropdownId: id,
                           isSplit: isSplit,
                           menuAlign: menuAlign,
                           a: a)
        } menu: { id, align in
            DropdownMenu(dropdownId: id,
                         align: align,
                         as: type) {
                dropdownItems()
            }
        }
    }
    
    public convenience init(id: String,
                            isSplit: Bool = false,
                            direction: Direction = .down,
                            menuAlign: DropdownMenu.Align? = nil,
                            button: (Id, IsSplit, DropdownMenu.Align?) -> DropdownButton,
                            menu: (Id, DropdownMenu.Align?) -> DropdownMenu) {
        let button = button(id, isSplit, menuAlign)
        let arrowButton = DropdownButtonArrow(id: id)
        if isSplit, let classes = button.tag.value(.class)?.bsClasses {
            // apply button classes to arrow button so they match
            arrowButton.class(insert: classes)
        }
        let menu = menu(id, menuAlign)
        let div: Div
        if isSplit {
            if direction != .start {
                div = Div {
                    button
                    arrowButton
                    menu
                }
                .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
            } else {
                div = Div {
                    Div {
                        /// split buttons direction .start are ordered differently and inside extra button group
                        arrowButton
                        menu
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
                menu
            }
            .class(insert: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
        }
        self.init(button: button, arrowButton: arrowButton, menu: menu, div)
    }
        
    public init(button: DropdownButton, arrowButton: DropdownButtonArrow?, menu: DropdownMenu, _ div: Div) {
        self.button = button
        self.arrowButton = arrowButton
        self.menu = menu

        div
            .class(insert: .btnGroup)
        
        super.init(div)
    }
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        button.background(value, condition)
        arrowButton?.background(value, condition)
        return self
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.button.border(value, condition)
        self.arrowButton?.background(value, condition)
        return self
    }
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        menu.isDark(if: condition)
        return self
    }
    
    @discardableResult
    public func menuAlign(_ value: DropdownMenu.Align?, _ condition: Bool = true) -> Self {
        guard let value = value else { return self }
        menu.align(value, condition)
        return self
    }
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        button.size(value, condition)
        return self
    }
}

public final class DropdownButton: Component {
        
    public convenience init(_ title: String,
                            href: String,
                            dropdownId id: String,
                            isSplit: Bool = false,
                            menuAlign: DropdownMenu.Align? = nil) {
        self.init(dropdownId: id, isSplit: isSplit, menuAlign: menuAlign) {
            A(title).href(href)
        }
    }
    
    public convenience init(dropdownId id: String,
                            isSplit: Bool = false,
                            menuAlign: DropdownMenu.Align? = nil,
                            a: () -> A) {
        self.init(dropdownId: id, isSplit: isSplit, menuAlign: menuAlign, tag: a())
    }
    
    public convenience init(dropdownId id: String,
                            isSplit: Bool = false,
                            menuAlign: DropdownMenu.Align? = nil,
                            button: () -> Button) {
        let button = button()
        if !isSplit {
            _ = button
                .class(insert: .dropdownToggle)
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
                .id(id)
        }
        self.init(dropdownId: id, isSplit: isSplit, menuAlign: menuAlign, tag: button)
    }
    
    internal init(dropdownId id: String,
                  isSplit: Bool,
                  menuAlign: DropdownMenu.Align?,
                  tag: Tag) {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        tag
            .class(insert: Size.md.buttonClass)
            .dataBsDisplay(.static, !isSplit && isMenuAlignResponsive)
        super.init(tag)
    }
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.buttonClass)
        } else {
            tag.class(remove: ColorTheme.allCases.map{$0.buttonClass})
        }
        return self
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.buttonOutlineClass)
        } else {
            tag.class(remove: ColorTheme.allCases.map{$0.buttonOutlineClass})
        }
        return self
    }
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .class(insert: value.buttonClass)
        return self
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
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.buttonClass)
        } else {
            tag.class(remove: ColorTheme.allCases.map{$0.buttonClass})
        }
        return self
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.buttonOutlineClass)
        } else {
            tag.class(remove: ColorTheme.allCases.map{$0.buttonOutlineClass})
        }
        return self
    }
}

public class DropdownMenu: Component {
    
    public typealias Title = String
    public typealias Href = String
    
    public enum Align {
        case end
        case responsive(_ bp: AlignBreakpoint)
        case endAndResponsive(_ bp: AlignBreakpoint)
        
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
    
    public enum AlignBreakpoint {
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
    
    /// contents ... DropdownItems or anything
    public convenience init(dropdownId: String,
                            align: Align? = nil,
                            as type: TagType = .ul,
                            @TagBuilder contents: () -> [Tag]) {
        let tag = type.tag { contents() }
        self.init(dropdownId: dropdownId, tag)
        self.align(align)
    }

    public init(dropdownId: String, _ tag: Tag) {
        tag
            .class(insert: .dropdownMenu)
            .ariaLabelledBy(dropdownId)

        super.init(tag)
    }
    
    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .class(insert: .dropdownMenuDark)
        return self
    }
    
    @discardableResult
    public func align(_ value: Align?, _ condition: Bool = false) -> Self {
        guard condition, let value = value else { return self }
        tag
            .class(insert: value.classes)
        return self
    }
}

public class DropdownItem: Component {
    
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
