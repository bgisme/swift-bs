//
//  Container.swift
//  
//
//  Created by Brad Gourley on 3/23/22.
//

import SwiftHtml

public class Container: Component {
    
    public init(type: TagType = .div,
                isFluid: Bool = false,
                @TagBuilder contents: () -> [Tag]) {
        super.init {
            type.tag(contents)
                .class(insert: isFluid ? .containerFluid : Size.md.containerClass)
        }
    }
}

extension Container: Sizable {
    
    @discardableResult
    public func size(_ value: Size?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.containerClass, if: condition)
    }
}

extension Size {
    
    var containerClass: BsClass {
        switch self {
        case .xsm, .sm:
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
