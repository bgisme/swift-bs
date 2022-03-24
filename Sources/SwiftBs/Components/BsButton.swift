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
        let button = button()
            .type(.button)
            .class(insert: .active, if: isToggle && isPressed)
            .dataBsToggle(.button, isToggle)
            .disabled(isDisabled)
            .ariaPressed(isPressed, isToggle && isPressed)
            .autoComplete(false, isToggle && isPressed)

        self.init(isBlockLevel: isBlockLevel, button)
    }
    
    public convenience init(isBlockLevel: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            a: () -> A) {
        let a = a()
            .class(insert: .disabled, if: isDisabled)
            .role(.button)
            .class(insert: .active, if: isActive)
            .ariaPressed(true, isActive)
            .ariaDisabled(isDisabled)

        self.init(isBlockLevel: isBlockLevel, a)
    }
    
    public convenience init(isBlockLevel: Bool = false,
                            input: () -> Input) {
        self.init(isBlockLevel: isBlockLevel, input())
    }
    
    private init(isBlockLevel: Bool, _ tag: Tag) {
        tag
            .class(insert: Size.md.buttonClass)
            .class(insert: .btnBlock, if: isBlockLevel)

        super.init(tag)
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
        case .xs, .sm:
            return .btnSm
        case .md:
            return .btn
        case .lg, .xl, .xxl:
            return .btnLg
        }
    }
}

extension ColorTheme {
    
    public var buttonClass: BsClass {
        switch self {
        case .primary:
            return .btnPrimary
        case .secondary:
            return .btnSecondary
        case .success:
            return .btnSuccess
        case .danger:
            return .btnDanger
        case .warning:
            return .btnWarning
        case .info:
            return .btnInfo
        case .light:
            return .btnLight
        case .dark:
            return .btnDark
        }
    }
    
    public var buttonOutlineClass: BsClass {
        switch self {
        case .primary:
            return .btnOutlinePrimary
        case .secondary:
            return .btnOutlineSecondary
        case .success:
            return .btnOutlineSuccess
        case .danger:
            return .btnOutlineDanger
        case .warning:
            return .btnOutlineWarning
        case .info:
            return .btnOutlineInfo
        case .light:
            return .btnOutlineLight
        case .dark:
            return .btnOutlineDark
        }
    }
}
