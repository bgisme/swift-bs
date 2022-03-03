//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSgml

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
    
    private let id: String
    private let direction: Direction
    private let isSplit: Bool
    private var button: (Id, IsSplit, Dropdown.Direction) -> [Tag]
    private var splitButton: (Id) -> [Tag]
    private var menu: (Id) -> [Tag]
    
    /// non-split buttons
    public convenience init(id: String,
                direction: Direction = .down,
                @TagBuilder button: @escaping (Id, IsSplit, Dropdown.Direction) -> [Tag],
                @TagBuilder menu: @escaping (Id) -> [Tag]) {
        self.init(id: id,
                  direction: direction,
                  isSplit: false,
                  button: button,
                  splitButton: {_ in },
                  menu: menu)
    }
    
    /// split buttons
    public init(id: String,
                direction: Direction = .down,
                isSplit: Bool = false,
                @TagBuilder button: @escaping (Id, IsSplit, Dropdown.Direction) -> [Tag],
                @TagBuilder splitButton: @escaping(Id) -> [Tag],
                @TagBuilder menu: @escaping (Id) -> [Tag]) {
        self.id = id
        self.direction = direction
        self.isSplit = isSplit
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
                    button(id, isSplit, direction)
                    splitButton(id)
                    menu(id)
                } else {
                    button(id, isSplit, direction)
                    menu(id)
                }
            }
            .class(.btnGroup)   // make all dropdowns button groups... <div class="dropdown"> does not work for split buttons
            .class(add: direction.bsClass, if: direction != .down)  // down is default direction, not necessary
            .class(add: bsClasses)
        } else {
            Div {
                Div {
                    /// split buttons direction .start are ordered differently
                    splitButton(id)
                    menu(id)
                }
                .class(.btnGroup, .dropstart)
                .role(.group)
                button(id, isSplit, direction)
            }
            .class(.btnGroup)
        }
    }
}

public class DropdownButton: Component {
    
    public enum `Type` {
        case button(_ title: String?)
        case link(_ title: String?, href: String)
    }
    
    private let type: `Type`
    private let id: String
    private let direction: Dropdown.Direction
    private let isSplit: Bool
    
    public init(type: `Type`,
                id: String,
                direction: Dropdown.Direction,
                isSplit: Bool = false) {
        self.type = type
        self.id = id
        self.direction = direction
        self.isSplit = isSplit
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
        switch type {
        case .button(let title):
            if isSplit {
                Button {
                    if let title = title {
                        Text(title)
                    }
                }
                .type(.button)
                .class(.btn)
                .class(add: bsClasses)
            } else {
                Button {
                    if let title = title {
                        Text(title)
                    }
                }
                .type(.button)
                .class(.btn, .dropdownToggle)
                .id(id) // not required for button groups
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
                .class(add: bsClasses)
            }
        case .link(let title, let href):
            if isSplit {
                A {
                    if let title = title {
                        Text(title)
                    }
                }
                .href(href)
                .role(.button)
                .class(add: bsClasses)
            } else {
                A {
                    if let title = title {
                        Text(title)
                    }
                }
                .href(href)
                .role(.button)
                .class(.btn, .dropdownToggle)
                .id(id)
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
                .class(add: bsClasses)
            }
        }
    }
}

public class DropdownButtonArrow: Component {
    
    private let id: String
    
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
    
    public init(id: String, isDark: Bool = false, @TagBuilder _ children: @escaping () -> [Tag]) {
        self.id = id
        self.isDark = isDark
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
        .ariaLabelledBy(id)
        .class(add: bsClasses)
    }
}

public class DropdownItem: Component {
    
    let a: A
    let isActive: Bool
    let isDisabled: Bool
    
    public convenience init(_ title: String, href: String, isActive: Bool = false, isDisabled: Bool = false) {
        let a = A(title).href(href)
        self.init(a: a, isActive: isActive, isDisabled: isDisabled) {}
    }
    
    public init(a: A, isActive: Bool = false, isDisabled: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.a = a
        self.isActive = isActive
        self.isDisabled = isDisabled
        super.init(children)
    }
}

extension DropdownItem: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Li {
            a
                .class(.dropdownItem)
                .class(add: .active, if: isActive)
                .class(add: .disabled, if: isDisabled)
        }
        .class(add: bsClasses)
    }
}

public class DropdownDivider: Component { }

extension DropdownDivider: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Hr()
            .class(.dropdownDivider)
            .class(add: bsClasses)
    }
}
