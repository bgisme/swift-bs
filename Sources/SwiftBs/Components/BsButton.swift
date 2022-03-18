//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    private let tag: Tag
    
    public convenience init(isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        self.init {
            button()
                .type(.button)
                .class(add: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .disabled(isDisabled)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
        }
    }
    
    public convenience init(isDisabled: Bool = false,
                            isActive: Bool = false,
                            link: () -> A) {
        self.init {
            link()
                .class(add: .disabled, if: isDisabled)
                .role(.button)
                .class(add: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(isDisabled)
        }
    }
    
    public convenience init(input: () -> Input) {
        self.init(tag: input)
    }
    
    internal required init(tag: () -> Tag) {
        self.tag = tag()
    }
}

extension BsButton: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        tag
            .class(add: .btn)
            .merge(attributes)
    }
}
