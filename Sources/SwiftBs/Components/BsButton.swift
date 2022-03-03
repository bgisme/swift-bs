//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    private let tag: Tag
    public let isToggle: Bool
    public let isPressed: Bool
    public let isDisabled: Bool
    public let isActive: Bool
    
    public convenience init(_ title: String,
                            href: String? = nil,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        let tag: Tag
        if let href = href {
            tag = A(title).href(href)
        } else {
            tag = Button(title)
        }
        self.init(tag: tag, isToggle: isToggle, isPressed: isPressed, isDisabled: isDisabled, isActive: isActive)
    }
    
    public convenience init(_ button: Button,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        self.init(tag: button, isToggle: isToggle, isPressed: isPressed, isDisabled: isDisabled, isActive: isActive)
    }
    
    public convenience init(_ link: A,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        self.init(tag: link, isToggle: isToggle, isPressed: isPressed, isDisabled: isDisabled, isActive: isActive)
    }
    
    public convenience init(_ input: Input,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        self.init(tag: input, isToggle: isToggle, isPressed: isPressed, isDisabled: isDisabled, isActive: isActive)
    }
    
    private init(tag: Tag, isToggle: Bool, isPressed: Bool, isDisabled: Bool, isActive: Bool) {
        self.tag = tag
        self.isToggle = isToggle
        self.isPressed = isPressed
        self.isDisabled = isDisabled
        self.isActive = isActive
        super.init({})
    }
}

extension BsButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        if let tag = tag as? A {
            tag
                .class(isDisabled ? [.btn, .disabled] : [.btn])
                .role(.button)
                .class(add: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(true, isDisabled)
                .class(add: bsClasses)
        } else if let tag = tag as? Button {
            tag
                .class(.btn)
                .type(.button)
                .class(add: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .disabled(isDisabled)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
                .class(add: bsClasses)
        } else if let tag = tag as? Input {
            tag
                .class(.btn)
                .class(add: bsClasses)
        }
    }
}
