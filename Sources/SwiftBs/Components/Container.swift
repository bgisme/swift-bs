
import SwiftHtml

open class Container: Tag {
    
    public init(_ kind: TagKind = .div,
                isFluid: Bool = false,
                @TagBuilder content: () -> Tag) {
        super.init(kind: .standard,
                   name: kind.rawValue,
                   [content()])
        self
            .class(insert: isFluid ? .containerFluid : Size.md.containerClass)
    }
}

extension Size {
    
    var containerClass: Utility {
        switch self {
        case .xs, .sm:
            return .containerSm
        case .md:
            return .container
        case .lg:
            return .containerLg
        case .xl:
            return .containerXl
        case .xxl:
            return .containerXxl
        }
    }
}

extension Container: Sizable {
    
    @discardableResult
    public func size(_ value: Size?, _ condition: Bool = true) -> Self {
        if let value = value {
            return self.class(insert: value.containerClass, if: condition)
        } else {
            return self.class(remove: Size.allCases.map{$0.containerClass}, condition)
        }
    }
}
