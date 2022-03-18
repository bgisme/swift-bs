//
//  ButtonGroup.swift
//  
//
//  Created by Brad Gourley on 2/28/22.
//

import SwiftHtml

public class ButtonGroup: Component {
    
    let div: Div
    let ariaLabel: String
    let isVertical: Bool
    
    public init(ariaLabel: String, isVertical: Bool = false, div: () -> Div) {
        self.ariaLabel = ariaLabel
        self.isVertical = isVertical
        self.div = div()
    }
}

extension ButtonGroup: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: isVertical ? .btnGroupVertical : .btnGroup)
            .role(.group)
            .ariaLabelledBy(ariaLabel)
            .merge(attributes)
    }
}

public class ButtonGroupToolbar: Component {
    
    let div: Div
    let ariaLabel: String

    public init(ariaLabel: String, div: () -> Div) {
        self.ariaLabel = ariaLabel
        self.div = div()
    }
}

extension ButtonGroupToolbar: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .btnToolbar)
            .role(.toolbar)
            .ariaLabelledBy(ariaLabel)
            .merge(attributes)
    }
}
