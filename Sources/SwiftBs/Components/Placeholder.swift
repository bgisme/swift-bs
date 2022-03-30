//
//  Placeholder.swift
//  
//
//  Created by Brad Gourley on 3/30/22.
//

import SwiftHtml

public class Placeholder: Component {
    
    public enum Animation {
        case glow
        case wave
        
        var `class`: BsClass {
            switch self {
            case .glow:
                return .placeholderGlow
            case .wave:
                return .placeholderWave
            }
        }
    }
    
    public convenience init() {
        let span = Span()
        self.init(span)
    }
    
    public init(_ span: Span) {
        span
            .class(insert: Size.md.placeholderClass)
        
        super.init(span)
    }
    
    @discardableResult
    public func width(_ value: Width, _ condition: Bool = true) -> Self {
        tag
            .class(insert: value.class, if: condition)
        return self
    }
    
    @discardableResult
    public func size(_ value: Size, _ condition: Bool = true) -> Self {
        tag
            .class(insert: value.placeholderClass, if: condition)
        return self
    }    
}

extension Size {
    
    var placeholderClass: BsClass {
        switch self {
        case .xs:
            return .placeholderXs
        case .sm:
            return .placeholderSm
        case .md:
            return .placeholder
        case .lg, .xl, .xxl:
            return .placeholderLg
        }
    }
}
