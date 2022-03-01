//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {

    let text: String?
    let isToggle: Bool
    let isPressed: Bool
    let isDisabled: Bool

    public init(_ text: String? = nil,
                isToggle: Bool = false,
                isPressed: Bool = false,
                isDisabled: Bool = false,
                @TagBuilder children: @escaping () -> [Tag]) {
        self.text = text
        self.isToggle = isToggle
        self.isPressed = isPressed
        self.isDisabled = isDisabled
        super.init() { children() }
    }
}

extension BsButton: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        Button {
            if let text = text {
                Text(text)
            }
            children()
        }
        .class(.btn)
        .type(.button)
        .dataToggle(.button, isToggle)
        .disabled(isDisabled)
        .ariaPressed(isPressed, isToggle && isPressed)
        .autoComplete(false, isToggle && isPressed)
        .add(classes, attributes, styles)
    }
}

public class BsButtonInput: Component {
    let text: String
    let `type`: Input.`Type`
    
    public init(_ text: String, type: Input.`Type`) {
        self.text = text
        self.type = type
        super.init() { }
    }
}

extension BsButtonInput: TagRepresentable {
    @TagBuilder
    public func build() -> Tag {
        Input()
        .class(.btn)
        .type(type)
        .value(text)
        .add(classes, attributes, styles)
    }
}

public class BsButtonLink: Component {
    let text: String
    let href: String
    let isDisabled: Bool
    let isActive: Bool

    public init(_ text: String, href: String = "#", isDisabled: Bool = false, isActive: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.text = text
        self.href = href
        self.isDisabled = isDisabled
        self.isActive = isActive
        super.init() { children() }
    }
}

extension BsButtonLink: TagRepresentable {

    @TagBuilder
    public func build() -> Tag {
        A {
            Text(text)
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
