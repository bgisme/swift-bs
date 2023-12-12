/*
 
 ButtonGroupToolbar
 ButtonGroup
 BsButton
 BsButton
 ButtonGroup
 BsButton
 BsButton
 */

import SwiftHtml

open class ButtonGroupToolbar: Div {
    
    public init(@TagBuilder groups: () -> [ButtonGroup]) {
        super.init(groups())
        self
            .class(insert: .btnToolbar)
            .role(.toolbar)
    }
}

open class ButtonGroup: Div {
    
    public init(ariaLabel: String = "Button Group",
                isVertical: Bool = false,
                @TagBuilder buttons: () -> [BsButton]) {
        super.init(buttons())
        self
            .class(insert: isVertical ? .btnGroupVertical : .btnGroup)
            .role(.group)
            .ariaLabelledBy(ariaLabel)
    }
}

extension ButtonGroup {
    
    // localized limited subset of Size
    public enum Size {
        case sm
        case lg
        case xl
        case xxl
        
        var buttonGroupClass: Utility {
            switch self {
            case .sm:
                return .btnGroupSm
            case .lg:
                return .btnGroupLg
            case .xl:
                return .btnGroupXl
            case .xxl:
                return .btnGroupXxl
            }
        }
    }
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        self
            .class(insert: value.buttonGroupClass, if: condition)
    }
}
