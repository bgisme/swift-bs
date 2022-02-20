//
//  DropDown.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class Dropdown: Component {
    
    public typealias Title = String
    public typealias Href = String
    
    let id: String
    let title: String?
    let isSplit: Bool
    
    public convenience init(id: String, title: String? = nil, isSplit: Bool = false, @TagBuilder _ ulItems: @escaping () -> [Tag]) {
        self.init(id: id, title: title, isSplit: isSplit, children: ulItems)
    }
    
    public init(id: String, title: String? = nil, isSplit: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.id = id
        self.title = title
        self.isSplit = isSplit
        super.init() { children() }
    }
}

extension Dropdown: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            Button(title)
                .class(.btn)
                .type(.button)
                .class(add: classes)
                .class(add: .dropdownToggle, if: !isSplit)
                .dataBsToggle(.dropdown, !isSplit)
                .ariaExpanded(String(false), !isSplit)
                .id(id)
            if isSplit {
                Button {
                    Span("Toggle Dropdown").class(.visuallyHidden)
                }
                .type(.button)
                .class(.btn, .dropdownToggle, .dropdownToggleSplit)
                .class(add: classes)
                .dataBsToggle(.dropdown)
                .ariaExpanded(String(false))
            }
            Ul {
                children()
            }
            .class(.dropdownMenu)
            .ariaLabelledBy(id, !isSplit)
        }
        .class(.btnGroup, if: isSplit)
        .class(.dropdown, if: !isSplit)
    }
}

public class DropdownItem: Component {
    
    let a: A
    let isActive: Bool
    let isDisabled: Bool
    
    public convenience init(_ title: String, href: String, isActive: Bool = false, isDisabled: Bool = false, @TagBuilder _ children: @escaping () -> [Tag]) {
        let a = A(title).href(href)
        self.init(a: a, isActive: isActive, isDisabled: isDisabled) {}
    }
    
    public convenience init(_ a: A, isActive: Bool = false, isDisabled: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.init(a: a, isActive: isActive, isDisabled: isDisabled, children)
    }
    
    public init(a: A, isActive: Bool = false, isDisabled: Bool = false, @TagBuilder _ children: @escaping () -> [Tag]) {
        self.a = a
        self.isActive = isActive
        self.isDisabled = isDisabled
        super.init() { children() }
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

public class DropdownDivider: Component {
    
    public init(@TagBuilder _ children: @escaping () -> [Tag]) {
        super.init() {}
    }
}

extension DropdownDivider: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Hr()
            .class(.dropdownDivider)
            .add(classes, attributes, styles)
    }
}
