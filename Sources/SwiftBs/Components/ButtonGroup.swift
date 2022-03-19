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
    
    /// children ... ButtonGroup
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
    
    /// children ... BsButton
    public init(ariaLabel: String, isVertical: Bool = false, div: () -> Div) {
        super.init {
            div()
                .class(insert: isVertical ? .btnGroupVertical : .btnGroup)
                .role(.group)
                .ariaLabelledBy(ariaLabel)
        }
    }
}
