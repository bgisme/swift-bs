//
//  Badge.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class Badge: Component {
    
    public convenience init(_ text: String,
                            color: ThemeColor,
                            isPositioned: Bool = false,
                            isRounded: Bool = false) {
        self.init(color: color, isPositioned: isPositioned, isRounded: isRounded) {
            Span(text)
        }
    }
    
    public init(color: ThemeColor,
                isPositioned: Bool = false,
                isRounded: Bool = false,
                span: () -> Span) {
        super.init {
            span()
                .class(insert: .badge)
                .class(insert: color.backgroundClass)
                .class(insert: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill, if: isPositioned)
                .class(insert: .roundedPill, if: isRounded)
        }
    }    
}
