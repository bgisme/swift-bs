//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    public enum Size {
        case sm
        case lg
    }
    
    public convenience init(theme: Theme? = nil,
                            isOutlined: Bool = false,
                            size: Size? = nil,
                            isBlockLevel: Bool = false,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        self.init(theme: theme, isOutlined: isOutlined, size: size, isBlockLevel: isBlockLevel) {
            button()
                .type(.button)
                .class(insert: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .disabled(isDisabled)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
        }
    }
    
    public convenience init(theme: Theme? = nil,
                            isOutlined: Bool = false,
                            size: Size? = nil,
                            isBlockLevel: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            a: () -> A) {
        self.init(theme: theme, isOutlined: isOutlined, size: size, isBlockLevel: isBlockLevel) {
            a()
                .class(insert: .disabled, if: isDisabled)
                .role(.button)
                .class(insert: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(isDisabled)
        }
    }
    
    public convenience init(theme: Theme? = nil,
                            isOutlined: Bool = false,
                            size: Size? = nil,
                            isBlockLevel: Bool = false,
                            input: () -> Input) {
        self.init(theme: theme, isOutlined: isOutlined, size: size, isBlockLevel: isBlockLevel, tag: input)
    }
    
    private init(theme: Theme?,
                 isOutlined: Bool,
                 size: Size? = nil,
                 isBlockLevel: Bool = false,
                 tag: () -> Tag) {
        let sizeClass: BsClass?
        if let size = size {
            switch size {
            case .sm:
                sizeClass = .btnSm
            case .lg:
                sizeClass = .btnLg
            }
        } else {
            sizeClass = nil
        }
        super.init {
            tag()
                .class(insert: .btn)
                .class(insert: isOutlined ? theme?.buttonOutlineClass : theme?.buttonClass)
                .class(insert: sizeClass)
                .class(insert: .btnBlock, if: isBlockLevel)
        }
    }
}
