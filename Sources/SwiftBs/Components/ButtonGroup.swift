//
//  ButtonGroup.swift
//  
//
//  Created by Brad Gourley on 2/28/22.
//

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

public class ButtonGroupToolbar: Component {
    
    /// contents ... ButtonGroups
    public init(ariaLabel: String,
                @TagBuilder buttonGroups: () -> [Tag]) {
        super.init {
            Div {
                buttonGroups()
            }
            .class(insert: .btnToolbar)
            .role(.toolbar)
            .ariaLabelledBy(ariaLabel)
        }
    }
}

public class ButtonGroup: Component {
    
    public enum Size {
        case sm
        case lg
        case xl
        case xxl
    }
    
    /// contents ... Buttons
    public init(ariaLabel: String,
                size: Size? = nil,
                isVertical: Bool = false,
                color: ThemeColor? = nil,
                @TagBuilder buttons: () -> [Tag]) {
        let sizeClass: BsClass?
        if let size = size {
            switch size {
            case .sm:
                sizeClass = .btnGroupSm
            case .lg:
                sizeClass = .btnGroupLg
            case .xl:
                sizeClass = .btnGroupXl
            case .xxl:
                sizeClass = .btnGroupXxl
            }
        } else {
            sizeClass = nil
        }
        let buttons = buttons()
        _ = buttons.map{ $0.class(insert: color?.buttonClass) }
        super.init {
            Div {
                buttons
            }
            .class(insert: isVertical ? .btnGroupVertical : .btnGroup)
            .class(insert: sizeClass)
            .role(.group)
            .ariaLabelledBy(ariaLabel)
        }
    }
}
