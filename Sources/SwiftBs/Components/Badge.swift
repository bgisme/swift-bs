//
//  File.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class Badge: Component {
    
    let span: Span
    let isPositioned: Bool
    let isRounded: Bool
    
    public convenience init(_ text: String, isPositioned: Bool = false, isRounded: Bool = false) {
        self.init(Span(text), isPositioned: isPositioned, isRounded: isRounded)
    }
        
    public init(_ span: Span, isPositioned: Bool = false, isRounded: Bool = false) {
        self.span = span
        self.isPositioned = isPositioned
        self.isRounded = isRounded
    }
}

extension Badge: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        span
            .class(.badge)
            .class(add: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill, if: isPositioned)
            .class(add: .roundedPill, if: isRounded)
            .addClassesStyles(self)
    }
}
