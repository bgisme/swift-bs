//
//  Badge.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

open class Badge: Span {
        
    public convenience init(_ text: String,
                            isPositioned: Bool = false,
                            isRounded: Bool = false) {
        self.init { Text(text) }
        self.isPositioned(if: isPositioned)
        self.isRounded(if: isRounded)
    }
    
    public init(@TagBuilder content: () -> Tag) {
        super.init([content()])
        self
            .class(insert: .badge)
    }
    
    @discardableResult
    public func isPositioned(if condition: Bool = true) -> Self {
        self.class(insert: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill, if: condition)
    }
    
    @discardableResult
    public func isRounded(if condition: Bool = true) -> Self {
        self.class(insert: .roundedPill, if: condition)
    }
}
