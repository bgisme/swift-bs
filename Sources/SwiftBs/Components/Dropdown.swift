//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml
import SwiftSgml

public class Dropdown: Component {
    
    public typealias Title = String
    public typealias Href = String
    public typealias Id = String
    public typealias IsSplit = Bool
    public typealias IsButtonGroup = Bool
    
    private let id: String
    private let isSplit: Bool
    private let isButtonGroup: Bool
    private var button: (Id, IsSplit, IsButtonGroup) -> [Tag]
    
    public init(id: String,
                isSplit: Bool = false,
                isButtonGroup: Bool = false,
                @TagBuilder button: @escaping (Id, IsSplit, IsButtonGroup) -> [Tag],
                @TagBuilder children: @escaping () -> [Tag]) {
        self.id = id
        self.isSplit = isSplit
        self.isButtonGroup = isButtonGroup
        self.button = button
        super.init(children)
    }
}

extension Dropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            button(id, isSplit, isButtonGroup)
            Ul {
                children()
            }
            .class(.dropdownMenu)
            .ariaLabelledBy(id, !isSplit)
        }
        .class(isButtonGroup ? .btnGroup : .dropdown)
        .add(classes, attributes, styles)
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
    private let isInButtonGroup: Bool
    
    public static func `default`(_ title: String?, id: String, isSplit: Bool = false, isInButtonGroup: Bool = false) -> Self {
        self.init(type: .button(title), id: id, isSplit: isSplit, isInButtonGroup: isInButtonGroup)
    }
    
    public static func link(_ title: String?, href: String, id: String, isSplit: Bool = false, isInButtonGroup: Bool = false) -> Self {
        self.init(type: .link(title, href: href), id: id, isSplit: isSplit, isInButtonGroup: isInButtonGroup)
    }
    
    internal required init(type: `Type`,
                  id: String,
                  isSplit: Bool = false,
                  isInButtonGroup: Bool = false) {
        self.type = type
        self.id = id
        self.isSplit = isSplit
        self.isInButtonGroup = isInButtonGroup
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
                .add(classes, attributes, styles)
                
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
                .add(classes, attributes, styles)
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
                .add(classes, attributes, styles)
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
                .add(classes, attributes, styles)
                
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
                .add(classes, attributes, styles)
            } else {
                A {
                    if let title = title {
                        Text(title)
                    }
                }
                .role(.button)
                .class(.btn, .dropdownToggle)
                .id(id)
                .dataBsToggle(.dropdown)
                .ariaExpanded(false)
                .add(classes, attributes, styles)
            }
        }
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
        .add(classes, attributes, styles)
    }
}

public class DropdownDivider: Component { }

extension DropdownDivider: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Hr()
            .class(.dropdownDivider)
            .add(classes, attributes, styles)
    }
}
