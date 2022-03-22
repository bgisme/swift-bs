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
        self.init(isPositioned: isPositioned, isRounded: isRounded) {
            Span(text)
        }
    }
    
    public init(isPositioned: Bool = false,
                isRounded: Bool = false,
                span: () -> Span) {
        super.init {
            span()
                .class(insert: .badge)
                .class(insert: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill, if: isPositioned)
                .class(insert: .roundedPill, if: isRounded)
        }
    }
    
    @discardableResult
    public func background(_ value: Theme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.backgroundClass, if: condition)
    }
}
