//
//  BsButton.swift
//  
//
//  Created by BG on 2/16/22.
//

import SwiftHtml

open class BsButton: Tag {
        
    public enum Kind {
        case a(isActive: Bool)
        case button(isToggle: Bool, isPressed: Bool)
        case input
        
        var name: String {
            switch self {
            case .a: return A.name
            case .button: return Button.name
            case .input: return Input.name
            }
        }
    }
    
    public init(_ kind: Kind,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.name,
                   [content()])
        self
            .class(insert: Size.md.buttonClass)
        switch kind {
        case .a (let isActive):
            self
                .role(.button)
                .class(insert: .active, if: isActive)
                .ariaPressed(true, isActive)
        case .button (let isToggle, let isPressed):
            self
                .type(.button)
                .class(insert: .active, if: isToggle && isPressed)
                .dataBsToggle(.button, isToggle)
                .ariaPressed(isPressed, isToggle && isPressed)
                .autoComplete(false, isToggle && isPressed)
        case .input:
            break
        }
    }
    
//    // MARK: - Can not be overriden from extension
//    @discardableResult
//    public override func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        if let value = value {
//            return self.class(insert: value.buttonClass, if: condition)
//        } else {
//            return self.class(remove: ColorTheme.allCases.map{$0.buttonClass}, condition)
//        }
//    }
//    
//    @discardableResult
//    public override func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
//        if let value = value {
//            return self.class(insert: value.buttonOutlineClass, if: condition)
//        } else {
//            return self.class(remove: ColorTheme.allCases.map{$0.buttonOutlineClass}, condition)
//        }
//    }
}

extension BsButton {
        
    @discardableResult
    public func isDisabled(if condition: Bool = true) -> Self {
        self
            .class(insert: .disabled, if: condition)
            .ariaDisabled(condition)
    }
    
    @discardableResult
    public func isBlockLevel(if condition: Bool = true) -> Self {
        self
            .class(insert: .btnBlock, if: condition)
    }
}

extension BsButton: Sizable {
    
    @discardableResult
    public func size(_ value: Size?, _ condition: Bool = true) -> Self {
        if let value = value {
            return self.class(insert: value.buttonClass, if: condition)
        } else {
            return self.class(remove: Size.allCases.map{$0.buttonClass}, condition)
        }
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
