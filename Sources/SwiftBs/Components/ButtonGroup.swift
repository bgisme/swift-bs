//
//  ButtonGroup.swift
//  
//
//  Created by Brad Gourley on 2/28/22.
//

import SwiftHtml

public class ButtonGroup: Component {
    
    let div: Div
    let isVertical: Bool
    
    public convenience init(isVertical: Bool = false,
                            ariaLabel: String,
                            @TagBuilder children: () -> [Tag]) {
        let div = Div { children() }.ariaLabelledBy(ariaLabel)
        self.init(div, isVertical: isVertical)
    }

    public init(_ div: Div, isVertical: Bool = false) {
        self.div = div
        self.isVertical = isVertical
    }
}

extension ButtonGroup: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: isVertical ? .btnGroupVertical : .btnGroup)
            .role(.group)
            .merge(attributes)
    }
}

public class ButtonGroupToolbar: Component {
    
    let div: Div

    public convenience init(ariaLabel: String, @TagBuilder children: @escaping () -> [Tag]) {
        let div = Div { children() }.ariaLabelledBy(ariaLabel)
        self.init(div)
    }
    
    public init(_ div: Div) {
        self.div = div
    }
}

extension ButtonGroupToolbar: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        div
            .class(add: .btnToolbar)
            .role(.toolbar)
            .merge(attributes)
    }
}
