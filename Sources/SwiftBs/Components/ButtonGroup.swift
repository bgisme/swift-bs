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
    
    public convenience init(@TagBuilder buttonGroups: () -> [Tag]) {
        let div = Div {
            buttonGroups()
        }
        self.init(div)
    }
    
    public init(_ div: Div) {
        div
            .class(insert: .btnToolbar)
            .role(.toolbar)

        super.init(div)
    }
}

public class ButtonGroup: Component {
    
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
    
    public convenience init(ariaLabel: String,
                            size: Size? = nil,
                            isVertical: Bool = false,
                            @TagBuilder buttons: () -> [Tag]) {
        let div = Div { buttons() }
        self.init(ariaLabel: ariaLabel, size: size, isVertical: isVertical, div)
    }
    
    public init(ariaLabel: String,
                size: Size?,
                isVertical: Bool,
                _ div: Div) {
        div
            .class(insert: isVertical ? .btnGroupVertical : .btnGroup)
            .class(insert: size?.buttonGroupClass)
            .role(.group)
            .ariaLabelledBy(ariaLabel)

        super.init(div)
    }
}
