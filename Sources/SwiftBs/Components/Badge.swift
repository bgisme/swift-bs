//
//  Badge.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class Badge: Component {
    
    public convenience init(_ text: String,
                            isPositioned: Bool = false,
                            isRounded: Bool = false) {
        self.init(Span(text))
        self.isPositioned(if: isPositioned)
        self.isRounded(if: isRounded)
    }
    
    public init(_ span: Span) {
        span
            .class(insert: .badge)
        
        super.init(span)
    }
    
    @discardableResult
    public func isPositioned(if condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .class(insert: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill)
        return self
    }
    
    @discardableResult
    public func isRounded(if condition: Bool = true) -> Self {
        guard condition else { return self }
        tag
            .class(insert: .roundedPill)
        return self
    }
}
