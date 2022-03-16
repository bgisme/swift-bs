//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    private let tag: Tag
        
    public convenience init(_ title: String? = nil,
                            onClick: String? = nil,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        let button = Button(title)
        if let onClick = onClick {
            _ = button.onClick(onClick)
        }
        self.init(button, isToggle: isToggle, isPressed: isPressed, isDisabled: isDisabled, isActive: isActive)
    }

    public convenience init(_ button: Button,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        button
            .type(.button)
            .class(add: .active, if: isToggle && isPressed)
            .dataBsToggle(.button, isToggle)
            .disabled(isDisabled)
            .ariaPressed(isPressed, isToggle && isPressed)
            .autoComplete(false, isToggle && isPressed)
        self.init(tag: button)
    }
    
    public convenience init(_ link: A,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        link
            .class(add: .disabled, if: isDisabled)
            .role(.button)
            .class(add: .active, if: isActive)
            .ariaPressed(true, isActive)
            .ariaDisabled(isDisabled)
        self.init(tag: link)
    }
    
    public convenience init(_ input: Input) {
        self.init(tag: input)
    }
    
    internal required init(tag: Tag) {
        self.tag = tag
    }
}

extension BsButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .btn)
            .merge(self.attributes)
    }
}
