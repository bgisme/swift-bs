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
    
    private let id: String
    private let isSplit: Bool
    private let isButtonGroup: Bool
    private var button: Tag
    
    public init(id: String,
                isSplit: Bool = false,
                isButtonGroup: Bool = false,
                button: BsButton,
                @TagBuilder children: @escaping () -> [Tag]) {
        self.id = id
        self.isSplit = isSplit
        self.isButtonGroup = isButtonGroup
        self.button = button.build()
        super.init(children)
    }
}

extension Dropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            button
                .id(id)
                .class(add: .dropdownToggle)
                .ariaExpanded(false)
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
