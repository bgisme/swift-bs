
import SwiftHtml

/// Placeholder is a collection of class settings, not a Tag
open class Placeholder {
    
    /// declare placeholder
    class func make(width: Width,
                    size: Size? = nil,
                    color: ColorTheme? = nil,
                    if condition: Bool = true,
                    tag: () -> Tag) -> Tag {
        tag().isPlaceholder(width: width,
                            size: size,
                            color: color,
                            if: condition)
    }
}

extension Size {
    
    var placeholderClass: Utility {
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

extension Placeholder {
    
    public enum Animation {
        case glow
        case wave
        
        var `class`: Utility {
            switch self {
            case .glow:
                return .placeholderGlow
            case .wave:
                return .placeholderWave
            }
        }
    }
}

extension Tag {
    
    @discardableResult
    public func isPlaceholder(width: Width,
                              size: Size? = nil,
                              color: ColorTheme? = nil,
                              if condition: Bool = true) -> Self {
        // the class tag 'placeholder' is only used when followed by width (unless width is specified in style attribute)
        self
            .class(insert: Size.md.placeholderClass, if: condition)
            .class(insert: width.class, if: condition)
            .class(insert: size?.placeholderClass, if: condition)
            .class(insert: color?.backgroundClass, if: condition)
    }
    
    @discardableResult
    public func isPlaceholderAnimated(_ value: Placeholder.Animation, _ condition: Bool = true) -> Self {
        self.class(insert: value.class, if: condition)
    }
}
