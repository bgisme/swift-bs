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
    
    public typealias Title = String
    public typealias Href = String
    public typealias Id = String
    public typealias IsSplit = Bool
    
    private let id: String
    private let direction: Direction
    private let isSplit: Bool
    private let isButtonGroup: Bool
    private var button: (Id, IsSplit) -> [Tag]
    private var menu: (Id, IsSplit) -> [Tag]
    
    public init(id: String,
                direction: Direction = .down,
                isSplit: Bool = false,
                isButtonGroup: Bool = true,
                @TagBuilder button: @escaping (Id, IsSplit) -> [Tag],
                @TagBuilder menu: @escaping (Id, IsSplit) -> [Tag]) {
        self.id = id
        self.direction = direction
        self.isSplit = isSplit
        self.isButtonGroup = isButtonGroup
        self.button = button
        self.menu = menu
        super.init({})
    }
}

extension Dropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            button(id, isSplit)
            menu(id, isSplit)
        }
        .class(isButtonGroup || isSplit ? .btnGroup : .dropdown)    // split buttons only work as button group
        .class(add: direction.bsClass, if: direction != .down)
        .class(add: bsClasses)
    }
}

public class DropdownButton: Component {
    
    enum `Type` {
        case button(_ title: String?)
        case link(_ title: String?, href: String)
    }

    private let type: `Type`
    private let id: String
    private let isSplit: Bool
    
    public static func `default`(_ title: String?, id: String, isSplit: Bool = false) -> Self {
        self.init(type: .button(title), id: id, isSplit: isSplit)
    }
    
    public static func link(_ title: String?, href: String, id: String, isSplit: Bool = false) -> Self {
        self.init(type: .link(title, href: href), id: id, isSplit: isSplit)
    }
    
    internal required init(type: `Type`,
                  id: String,
                  isSplit: Bool = false) {
        self.type = type
        self.id = id
        self.isSplit = isSplit
        super.init({})
    }
}

extension DropdownButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        switch type {
        case .button(let title):
            if isSplit {
                /// split dropdowns are two buttons and all the special properties go on the later
                Button {
                    if let title = title {
                        Text(title)
                    }
                }
                .type(.button)
                .class(.btn)
                .class(add: bsClasses)
                
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
            } else {
                /// non-split dropdowns have only one button with special properties
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
                
                A {
                    Span {
                        Text("Toggle Dropdown")
                    }
                    .class(.visuallyHidden)
                }
                .role(.button)
                .class(.btn, .dropdownToggle, .dropdownToggleSplit)
                .id(id) // not required for button groups
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
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

public class DropdownMenu: Component {
    
    let id: String
    let isSplit: Bool
    
    public init(id: String, isSplit: Bool = false, @TagBuilder _ children: @escaping () -> [Tag]) {
        self.id = id
        self.isSplit = isSplit
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
        .ariaLabelledBy(id, isSplit)
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
