//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml
import Darwin

public class BsButton: Component {

    let text: String?
    let isToggle: Bool
    let isPressed: Bool

    public init(_ text: String? = nil, isToggle: Bool = false, isPressed: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.text = text
        self.isToggle = isToggle
        self.isPressed = isPressed
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
        .add(classes, attributes, styles)
        .dataToggle(.button, isToggle)
        .class(add: .disabled, if: isToggle && isPressed)
        .ariaPressed(isPressed, isToggle && isPressed)
        .autoComplete(false, isToggle && isPressed)
    }
}

public class BsButtonInput: Component {
    let text: String
    let `type`: Input.`Type`
    
    init(_ text: String, type: Input.`Type`) {
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
    }
}

public class BsButtonLink: Component {
    let text: String
    let href: String
    let isDisabled: Bool
    
    init(_ text: String, href: String = "#", isDisabled: Bool = false, @TagBuilder children: @escaping () -> [Tag]) {
        self.text = text
        self.href = href
        self.isDisabled = isDisabled
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
        .ariaDisabled(isDisabled)
        .add(classes, attributes, styles)
    }
}
