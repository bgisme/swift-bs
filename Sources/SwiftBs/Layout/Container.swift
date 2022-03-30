//
//  Container.swift
//  
//
//  Created by Brad Gourley on 3/23/22.
//

import SwiftHtml

public class Container: Component {
    
    public init(_ type: TagType = .div,
                isFluid: Bool = false,
                @TagBuilder contents: () -> [Tag]) {
        let tag = type
            .tag(contents)
            .class(insert: isFluid ? .containerFluid : Size.md.containerClass)
        super.init(tag)
    }    
}

extension Container: Sizable {
    
    @discardableResult
    public func size(_ value: Size?, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        if let value = value {
            tag.class(insert: value.containerClass)
        } else {
            tag.class(remove: Size.allCases.map{$0.containerClass})
        }
        return self
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
