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
    
    public convenience init(ariaLabel: String,
                            @TagBuilder buttonGroups: () -> [Tag]) {
        let div = Div {
            buttonGroups()
        }
        self.init(ariaLabel: ariaLabel, div)
    }
    
    public init(ariaLabel: String, _ div: Div) {
        div
            .class(insert: .btnToolbar)
            .role(.toolbar)
            .ariaLabelledBy(ariaLabel)

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
        
        div
            .class(insert: isVertical ? .btnGroupVertical : .btnGroup)
            .class(insert: sizeClass)
            .role(.group)
            .ariaLabelledBy(ariaLabel)

        super.init(div)
    }
}
