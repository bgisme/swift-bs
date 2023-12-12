//
//  DropDown.swift
//
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

open class Dropdown: Div {

    public enum Direction {
        case down
        case up
        case start
        case end

        var `class`: Utility {
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
    let arrowButton: DropdownButtonArrow
    let menu: DropdownMenu

    public init(id: String,
                isSplit: Bool = false,
                direction: Direction = .down,
                menuAlign: DropdownMenu.Align? = nil,
                button: (Id, IsSplit, DropdownMenu.Align?) -> DropdownButton,
                menu: (Id, DropdownMenu.Align?) -> DropdownMenu) {
        // create and store
        let button = button(id, isSplit, menuAlign)
        self.button = button
        let menu = menu(id, menuAlign)
        self.menu = menu
        let arrowButton = DropdownButtonArrow(id: id)
        self.arrowButton = DropdownButtonArrow(id: id)
        if isSplit, let classes = button.value(.class)?.classes {
            // apply button classes to arrow button so they match
            arrowButton.class(insert: classes)
        }
        if isSplit {
            if direction != .start {
                super.init(Tag {
                    button
                    arrowButton
                    menu
                }.children)
                self
                    .class(insert: .btnGroup)
                    .class(insert: direction.class, if: direction != .down)  // down is default direction, not necessary
            } else {
                super.init(Div {
                    Div {
                        /// split buttons direction .start are ordered differently and inside extra button group
                        arrowButton
                        menu
                    }
                    .class(insert: .btnGroup, .dropstart)
                    .role(.group)
                    button
                }.children)
                self
                    .class(insert: .btnGroup)
            }
        } else {
            /// non-split
            super.init(Tag {
                button
                menu
            }.children)
            self
                .class(insert: .btnGroup)
                .class(insert: direction.class, if: direction != .down)  // down is default direction, not necessary
        }
    }

//    // MARK: - Can not override in extension
//    @discardableResult
//    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        button.background(value, condition)
//        arrowButton?.background(value, condition)
//        return self
//    }
//
//    @discardableResult
//    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        self.button.border(value, condition)
//        self.arrowButton?.background(value, condition)
//        return self
//    }
}

extension Dropdown {

    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        menu.isDark(if: condition)
        return self
    }

    @discardableResult
    public func menuAlign(_ value: DropdownMenu.Align?, _ condition: Bool = true) -> Self {
        menu.align(value, condition)
        return self
    }

    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        button.size(value, condition)
        return self
    }
}

public final class DropdownButton: Tag {

    public enum Kind: String {
        case a
        case button
    }

    private static func isStatic(_ isSplit: Bool,
                                 _ menuAlign: DropdownMenu.Align? = nil) -> Bool {
        let isMenuAlignResponsive = menuAlign != nil ? menuAlign!.isMenuAlignResponsive : false
        return !isSplit && isMenuAlignResponsive
    }

    public convenience init(_ title: String,
                            href: String,
                            dropdownId id: String,
                            isSplit: Bool = false,
                            menuAlign: DropdownMenu.Align? = nil) {
        self.init(.a,
                  dropdownId: id,
                  isSplit: isSplit,
                  menuAlign: menuAlign) {
            Text(title)
        }
        self.attribute("href", href)
    }

    public init(_ kind: Kind,
                dropdownId id: String,
                isSplit: Bool = false,
                menuAlign: DropdownMenu.Align? = nil,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: Size.md.buttonClass)
            .isStatic(Self.isStatic(isSplit, menuAlign))
    }

    ///@NOTE: set isStatic to false to disable dynamic positioning and use responsive variation classes
    @discardableResult
    public func isStatic(_ value: Bool, _ condition: Bool = true) -> Self {
        if value {
            return self.dataBsDisplay(.static)
        } else {
            return self.deleteAttribute(.dataBsDisplay)
        }
    }

//    @discardableResult
//    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        if let value = value {
//            return self.class(insert: value.buttonClass, if: condition)
//        } else {
//            return self.class(remove: ColorTheme.allCases.map{$0.buttonClass}, condition)
//        }
//    }
//
//    @discardableResult
//    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        if let value = value {
//            return self.class(insert: value.buttonOutlineClass, if: condition)
//        } else {
//            return self.class(remove: ColorTheme.allCases.map{$0.buttonOutlineClass}, condition)
//        }
//    }

    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        self.class(insert: value.buttonClass, if: condition)
    }
}

open class DropdownButtonArrow: Button {

    public convenience init(id: String) {
        self.init(id: id) {
            Span {
                Text("Toggle Dropdown")
            }
            .class(insert: .visuallyHidden)
        }
    }

    public init(id: String,
                @TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .type(.button)
            .class(insert: .btn, .dropdownToggle, .dropdownToggleSplit)
            .id(id) // not required for button groups
            .dataBsToggle(.dropdown)
            .ariaExpanded(false)
    }

//    @discardableResult
//    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        if let value = value {
//            return self.class(insert: value.buttonClass, if: condition)
//        } else {
//            return self.class(remove: ColorTheme.allCases.map{$0.buttonClass}, condition)
//        }
//    }
//
//    @discardableResult
//    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        if let value = value {
//            return self.class(insert: value.buttonOutlineClass, if: condition)
//        } else {
//            return self.class(remove: ColorTheme.allCases.map{$0.buttonOutlineClass}, condition)
//        }
//    }
}

open class DropdownMenu: Tag {

    public enum Kind: String {
        case div
        case ol
        case ul
    }

    public init(_ kind: Kind,
                dropdownId: String,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: .dropdownMenu)
            .ariaLabelledBy(dropdownId)
    }

    @discardableResult
    public func isDark(if condition: Bool = true) -> Self {
        self.class(insert: .dropdownMenuDark, if: condition)
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

        var `class`: Utility {
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

    public enum Align {
        case end
        case responsive(_ bp: AlignBreakpoint)
        case endAndResponsive(_ bp: AlignBreakpoint)

        var classes: [Utility] {
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

    @discardableResult
    public func align(_ value: Align?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.classes, condition)
    }
}

open class DropdownItem: Tag {

    public enum Kind: String {
        case a
        case button
        case span
    }

    public convenience init(_ title: String, href: String) {
        self.init(.a) { Text(title) }
        self.attribute("href", href)
    }

    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        switch kind {
        case .a, .button:
            self.class(insert: .dropdownItem)
        case .span:
            self.class(insert: .dropdownItemText)
        }
    }

    @discardableResult
    public func isActive(if condition: Bool = true) -> Self {
        self
            .class(insert: .active, if: condition)
            .ariaCurrent(condition)
    }

    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        self.class(insert: .disabled, if: condition)
    }
}

open class DropdownDivider: Hr {

    public init() {
        super.init()
        self.class(insert: .dropdownDivider)
    }
}

open class DropdownHeader: Li {

    public init(_ text: String) {
        let child = Tag {
            H6(text)
                .class(insert: .dropdownHeader)
        }
        super.init([child])
    }
}
