//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    public convenience init(isBlockLevel: Bool = false,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        self.init(isBlockLevel: isBlockLevel) {
            button()
                .type(.button)
                .class(insert: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .disabled(isDisabled)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
        }
    }
    
    public convenience init(isBlockLevel: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            a: () -> A) {
        self.init(isBlockLevel: isBlockLevel) {
            a()
                .class(insert: .disabled, if: isDisabled)
                .role(.button)
                .class(insert: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(isDisabled)
        }
    }
    
    public convenience init(isBlockLevel: Bool = false,
                            input: () -> Input) {
        self.init(isBlockLevel: isBlockLevel, tag: input)
    }
    
    private init(isBlockLevel: Bool = false,
                 tag: () -> Tag) {
        super.init {
            tag()
                .class(insert: Size.md.buttonClass)
                .class(insert: .btnBlock, if: isBlockLevel)
        }
    }
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonClass, if: condition)
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonOutlineClass, if: condition)
    }
}

extension BsButton: Sizable {
    
    @discardableResult
    public func size(_ value: Size?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.buttonClass, if: condition)
    }
}

extension Size {
    
    var buttonClass: BsClass {
        switch self {
        case .xsm, .sm:
            return .btnSm
        case .md:
            return .btn
        case .lg, .xl, .xxl:
            return .btnLg
        }
    }
}
