//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

public class BsButton: Component {
    
    public convenience init(isToggle: Bool = false,
                            isPressed: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        let button = button()
            .type(.button)
            .class(insert: .active, if: isToggle && isPressed)
            .dataBsToggle(.button, isToggle)
            .ariaPressed(isPressed, isToggle && isPressed)
            .autoComplete(false, isToggle && isPressed)

        self.init(button)
    }
    
    public convenience init(isActive: Bool = false,
                            a: () -> A) {
        let a = a()
            .role(.button)
            .class(insert: .active, if: isActive)
            .ariaPressed(true, isActive)

        self.init(a)
    }
    
    public convenience init(input: () -> Input) {
        self.init(input())
    }
    
    private override init(_ tag: Tag) {
        tag
            .class(insert: Size.md.buttonClass)

        super.init(tag)
    }
        
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        tag
            .class(insert: .disabled, if: condition)
            .ariaDisabled(condition)
        return self
    }
    
    @discardableResult
    public func isBlockLevel(if condition: Bool = true) -> Self {
        tag
            .class(insert: .btnBlock, if: condition)
        return self
    }
    
    @discardableResult
    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.buttonClass)
        } else {
            tag.class(remove: ColorTheme.allCases.map{$0.buttonClass})
        }
        return self
    }
    
    @discardableResult
    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.buttonOutlineClass)
        } else {
            tag.class(remove: ColorTheme.allCases.map{$0.buttonOutlineClass})
        }
        return self
    }    
}

extension BsButton: Sizable {
    
    @discardableResult
    public func size(_ value: Size?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.buttonClass)
        } else {
            tag.class(remove: Size.allCases.map{$0.buttonClass})
        }
        return self
    }
}

extension Size {
    
    var buttonClass: Utility {
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
    
    public var buttonClass: Utility {
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
        case .white:
            return .btnLight
        }
    }
    
    public var buttonOutlineClass: Utility {
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
        case .white:
            return .btnOutlineLight
        }
    }
}
