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
    
//    public convenience init(tag: () -> Tag) {
//        self.init(tag())
//    }
//
//    public override init(_ tag: Tag) {
//        tag
//            .class(insert: Size.md.placeholderClass)
//
//        super.init(tag)
//    }
//
//    @discardableResult
//    public func width(_ value: Width, _ condition: Bool = true) -> Self {
//        tag
//            .class(insert: value.class, if: condition)
//        return self
//    }
//
//    @discardableResult
//    public func size(_ value: Size, _ condition: Bool = true) -> Self {
//        tag
//            .class(insert: value.placeholderClass, if: condition)
//        return self
//    }
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

extension Tag {
    
    @discardableResult
    public func isPlaceholder(width: Width,
                              size: Size? = nil,
                              if condition: Bool = true) -> Self {
        // the class tag 'placeholder' is only used when followed by width (unless width is specified in style attribute)
        self
            .class(insert: Size.md.placeholderClass, if: condition)
            .class(insert: size?.placeholderClass, if: condition)
        return self
    }
    
    @discardableResult
    public func isPlaceHolderAnimated(_ value: Placeholder.Animation, _ condition: Bool = true) -> Self {
        self.class(insert: value.class, if: condition)
        return self
    }
}
