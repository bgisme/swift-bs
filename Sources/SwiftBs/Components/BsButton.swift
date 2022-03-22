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
        case md
        case lg
        
        var `class`: BsClass {
            switch self {
            case .sm:
                return .btnSm
            case .md:
                return .btn
            case .lg:
                return .btnLg
            }
        }
    }
    
    public convenience init(size: Size = .md,
                            isBlockLevel: Bool = false,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        self.init(size: size, isBlockLevel: isBlockLevel) {
            button()
                .type(.button)
                .class(insert: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .disabled(isDisabled)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
        }
    }
    
    public convenience init(size: Size = .md,
                            isBlockLevel: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            a: () -> A) {
        self.init(size: size, isBlockLevel: isBlockLevel) {
            a()
                .class(insert: .disabled, if: isDisabled)
                .role(.button)
                .class(insert: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(isDisabled)
        }
    }
    
    public convenience init(size: Size = .md,
                            isBlockLevel: Bool = false,
                            input: () -> Input) {
        self.init(size: size, isBlockLevel: isBlockLevel, tag: input)
    }
    
    private init(size: Size = .md,
                 isBlockLevel: Bool = false,
                 tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: size.class)
                .class(insert: .btnBlock, if: isBlockLevel)
        }
    }
    
    @discardableResult
    public func background(_ value: Theme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonClass, if: condition)
    }
    
    @discardableResult
    public func border(_ value: Theme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonOutlineClass, if: condition)
    }
}
