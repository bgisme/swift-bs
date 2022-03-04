//
//  File.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class Badge: Component {
    
    let text: String?
    let isPositioned: Bool
    let isRounded: Bool
        
    public init(_ text: String? = nil,
                isPositioned: Bool = false,
                isRounded: Bool = false,
                @TagBuilder children: @escaping () -> [Tag]) {
        self.text = text
        self.isPositioned = isPositioned
        self.isRounded = isRounded
        super.init() { children() }
    }
}

extension Badge: TagRepresentable {
    
    @TagBuilder
    public func build() -> Tag {
        Span {
            if let text = text {
                Text(text)
            }
            children()
        }
        .class(.badge)
        .class(add: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill, if: isPositioned)
        .class(add: .roundedPill, if: isRounded)
        .class(add: bsClasses)
    }
}
