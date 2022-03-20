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
    public init(ariaLabel: String, @TagBuilder buttonGroups: () -> [Tag]) {
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
    
    /// contents ... Buttons
    public init(ariaLabel: String, isVertical: Bool = false, @TagBuilder buttons: () -> [Tag]) {
        super.init {
            Div {
                buttons()
            }
            .class(insert: isVertical ? .btnGroupVertical : .btnGroup)
            .role(.group)
            .ariaLabelledBy(ariaLabel)
        }
    }
}
