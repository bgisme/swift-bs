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
    
    public convenience init(color: Color? = nil,
                            isOutlined: Bool = false,
                            size: Size? = nil,
                            isBlockLevel: Bool = false,
                            isToggle: Bool = false,
                            isPressed: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            button: () -> Button) {
        self.init(color: color, isOutlined: isOutlined, size: size, isBlockLevel: isBlockLevel) {
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
                            isOutlined: Bool = false,
                            size: Size? = nil,
                            isBlockLevel: Bool = false,
                            isDisabled: Bool = false,
                            isActive: Bool = false,
                            a: () -> A) {
        self.init(color: color, isOutlined: isOutlined, size: size, isBlockLevel: isBlockLevel) {
            a()
                .class(insert: .disabled, if: isDisabled)
                .role(.button)
                .class(insert: .active, if: isActive)
                .ariaPressed(true, isActive)
                .ariaDisabled(isDisabled)
        }
    }
    
    public convenience init(color: Color? = nil,
                            isOutlined: Bool = false,
                            size: Size? = nil,
                            isBlockLevel: Bool = false,
                            input: () -> Input) {
        self.init(color: color, isOutlined: isOutlined, size: size, isBlockLevel: isBlockLevel, tag: input)
    }
    
    internal init(color: Color?,
                  isOutlined: Bool,
                  size: Size? = nil,
                  isBlockLevel: Bool = false,
                  tag: () -> Tag) {
        let colorClass: BsClass?
        if let color = color {
            switch color {
            case .primary:
                colorClass = isOutlined ? .btnOutlinePrimary : .btnPrimary
            case .secondary:
                colorClass = isOutlined ? .btnOutlineSecondary : .btnSecondary
            case .success:
                colorClass = isOutlined ? .btnOutlineSuccess : .btnSuccess
            case .danger:
                colorClass = isOutlined ? .btnOutlineDanger : .btnDanger
            case .warning:
                colorClass = isOutlined ? .btnOutlineWarning : .btnWarning
            case .info:
                colorClass = isOutlined ? .btnOutlineInfo : .btnInfo
            case .light:
                colorClass = isOutlined ? .btnOutlineLight : .btnLight
            case .dark:
                colorClass = isOutlined ? .btnOutlineDark : .btnDark
            }
        } else {
            colorClass = nil
        }
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
                .class(insert: colorClass)
                .class(insert: sizeClass)
                .class(insert: .btnBlock, if: isBlockLevel)
        }
    }
}
