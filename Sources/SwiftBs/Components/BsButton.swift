//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    enum `Type` {
        case button(title: String?)
        case input(type: Input.`Type`, value: String?)
        case link(href: String, title: String?)
    }
    
    private var type: `Type` = .button(title: nil)
    private var isToggle: Bool = false
    private var isPressed: Bool = false
    private var isDisabled: Bool = false
    private var isActive: Bool = false
    
    internal required init(_ type: Type) {
        self.type = type
        super.init {}
    }
    
    public static func button(title: String? = nil, @TagBuilder _ children: @escaping () -> [Tag]) -> Self {
        let button = Self.init(.button(title: title))
        button.children(children)
        return button
    }
    
    public static func input(_ type: Input.`Type`, value: String? = nil) -> Self {
        Self.init(.input(type: type, value: value))
    }
    
    public static func link(_ href: String, title: String? = nil) -> Self {
        Self.init(.link(href: href, title: title))
    }
    
    @discardableResult
    public func toggles(isPressed: Bool = false) -> Self {
        self.isToggle = true
        self.isPressed = isPressed
        return self
    }
    
    @discardableResult
    public func isDisabled(_ value: Bool, if condition: Bool = true) -> Self {
        guard condition else { return self }
        self.isDisabled = value
        return self
    }
}

extension BsButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        switch type {
        case .button(let title):
            Button {
                if let title = title {
                    Text(title)
                }
                children()
            }
            .class(.btn)
            .type(.button)
            .class(add: .active, if: isToggle && isPressed)
            .dataBsToggle(.button, isToggle)
            .disabled(isDisabled)
            .ariaPressed(isPressed, isToggle && isPressed)
            .autoComplete(false, isToggle && isPressed)
            .add(classes, attributes, styles)
        case .input(let type, let value):
            Input()
            .class(.btn)
            .type(type)
            .value(value ?? "")
            .add(classes, attributes, styles)
        case .link(let href, let title):
            A {
                if let title = title {
                    Text(title)
                }
                children()
            }
            .class(isDisabled ? [.btn, .disabled] : [.btn])
            .role(.button)
            .href(href)
            .class(add: .active, if: isActive)
            .ariaPressed(true, isActive)
            .ariaDisabled(true, isDisabled)
            .add(classes, attributes, styles)
        }
    }
}
