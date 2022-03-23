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
    
    public static func make(ariaLabel: String,
                            @TagBuilder buttonGroups: () -> [Tag]) -> ButtonGroupToolbar {
        ButtonGroupToolbar(ariaLabel: ariaLabel) {
            Div {
                buttonGroups()
            }
        }
    }
    
    public init(ariaLabel: String, div: () -> Div) {
        super.init {
            div()
                .class(insert: .btnToolbar)
                .role(.toolbar)
                .ariaLabelledBy(ariaLabel)
        }
    }
}

public class ButtonGroup: Component {
    
    // localized limited subset of Size
    public enum Size {
        case sm
        case lg
        case xl
        case xxl
    }
    
    public static func make(ariaLabel: String,
                            size: Size? = nil,
                            isVertical: Bool = false,
                            @TagBuilder buttons: () -> [Tag]) -> ButtonGroup {
        ButtonGroup(ariaLabel: ariaLabel,
                    size: size,
                    isVertical: isVertical) {
            Div {
                buttons()
            }
        }
    }
    
    public init(ariaLabel: String,
                size: Size? = nil,
                isVertical: Bool = false,
                div: () -> Div) {
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
        super.init {
            div()
                .class(insert: isVertical ? .btnGroupVertical : .btnGroup)
                .class(insert: sizeClass)
                .role(.group)
                .ariaLabelledBy(ariaLabel)
        }
    }
}
