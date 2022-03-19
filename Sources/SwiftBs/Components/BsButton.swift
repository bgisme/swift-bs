//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    public convenience init(_ title: String,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false) {
        self.init(isToggle: isToggle,
                  isPressed: isPressed,
                  isDisabled: isDisabled,
                  isActive: isActive) {
            Button(title)
        }
    }
    
    public convenience init(isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        self.init {
            button()
                .type(.button)
                .class(insert: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .disabled(isDisabled)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
        }
    }
    
    public convenience init(isDisabled: Bool = false,
                            isActive: Bool = false,
                            a: () -> A) {
        self.init {
            a()
                .class(insert: .disabled, if: isDisabled)
                .role(.button)
                .class(insert: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(isDisabled)
        }
    }
    
    public convenience init(input: () -> Input) {
        self.init(tag: input)
    }
    
    internal init(tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: .btn)
        }
    }
}
