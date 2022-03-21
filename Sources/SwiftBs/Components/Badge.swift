//
//  Badge.swift
//  
//
//  Created by BG on 2/11/22.
//

import SwiftHtml

public class Badge: Component {
    
    public convenience init(_ text: String,
                            color: Color,
                            isPositioned: Bool = false,
                            isRounded: Bool = false) {
        self.init(color: color, isPositioned: isPositioned, isRounded: isRounded) {
            Span(text)
        }
    }
    
    public init(color: Color,
                isPositioned: Bool = false,
                isRounded: Bool = false,
                span: () -> Span) {
        let colorClass: BsClass
        switch color {
        case .primary:
            colorClass = .bgPrimary
        case .secondary:
            colorClass = .bgSecondary
        case .success:
            colorClass = .bgSuccess
        case .danger:
            colorClass = .bgDanger
        case .warning:
            colorClass = .bgWarning
        case .info:
            colorClass = .bgInfo
        case .light:
            colorClass = .bgLight
        case .dark:
            colorClass = .bgDark
        }
        super.init {
            span()
                .class(insert: .badge)
                .class(insert: colorClass)
                .class(insert: .positionAbsolute, .top0, .start100, .translateMiddle, .roundedPill, if: isPositioned)
                .class(insert: .roundedPill, if: isRounded)
        }
    }    
}
