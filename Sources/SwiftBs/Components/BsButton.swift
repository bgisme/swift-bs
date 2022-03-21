//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    public convenience init(color: Color? = nil,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        self.init(color: color) {
            button()
                .type(.button)
                .class(insert: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .disabled(isDisabled)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
        }
    }
    
    public convenience init(color: Color? = nil,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            a: () -> A) {
        self.init(color: color) {
            a()
                .class(insert: .disabled, if: isDisabled)
                .role(.button)
                .class(insert: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(isDisabled)
        }
    }
    
    public convenience init(color: Color? = nil, input: () -> Input) {
        self.init(color: color, tag: input)
    }
    
    internal init(color: Color?, tag: () -> Tag) {
        let colorClass: BsClass?
        if let color = color {
            switch color {
            case .primary:
                colorClass = .btnPrimary
            case .secondary:
                colorClass = .btnSecondary
            case .success:
                colorClass = .btnSuccess
            case .danger:
                colorClass = .btnDanger
            case .warning:
                colorClass = .btnWarning
            case .info:
                colorClass = .btnInfo
            case .light:
                colorClass = .btnLight
            case .dark:
                colorClass = .btnDark
            }
        } else {
            colorClass = nil
        }
        super.init {
            tag()
                .class(insert: .btn)
                .class(insert: colorClass)
        }
    }
}
