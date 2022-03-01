//
//  File.swift
//  
//
//  Created by Brad Gourley on 2/28/22.
//

import SwiftHtml

public class ButtonGroup: Component {

    let isVertical: Bool
    let ariaLabel: String
    
    init(isVertical: Bool = false, ariaLabel: String, @TagBuilder children: @escaping () -> [Tag]) {
        self.isVertical = isVertical
        self.ariaLabel = ariaLabel
        super.init() { children() }
    }
}

extension ButtonGroup: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            children()
        }
        .class(isVertical ? .btnGroupVertical : .btnGroup)
        .role(.group)
        .ariaLabelledBy(ariaLabel)
        .add(classes, attributes, styles)
    }
}

public class ButtonGroupToolbar: Component {
    
    let ariaLabel: String

    init(ariaLabel: String, @TagBuilder children: @escaping () -> [Tag]) {
        self.ariaLabel = ariaLabel
        super.init() { children() }
    }
}

extension ButtonGroupToolbar: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Div {
            children()
        }
        .class(.btnToolbar)
        .role(.toolbar)
        .ariaLabelledBy(ariaLabel)
        .add(classes, attributes, styles)
    }
}
