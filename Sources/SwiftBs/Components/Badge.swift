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
        self.init(isPositioned: isPositioned, isRounded: isRounded, Span(text))
    }
    
    public init(isPositioned: Bool = false,
                isRounded: Bool = false,
                _ span: Span) {
        span
            .class(insert: .badge)
            .class(insert: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill, if: isPositioned)
            .class(insert: .roundedPill, if: isRounded)
        
        super.init(span)
    }
}
