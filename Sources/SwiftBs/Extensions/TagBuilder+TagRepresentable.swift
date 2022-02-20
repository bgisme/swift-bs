//
//  File.swift
//  
//
//  Created by BG on 2/12/22.
//

import SwiftHtml

extension TagBuilder {
    
    public static func buildExpression(_ expression: TagRepresentable) -> [Tag] {
        [expression.build()]
    }
    
    static func buildExpression(_ expression: [TagRepresentable]) -> [Tag] {
        expression.map { $0.build() }
    }
    
    static func buildArray(_ components: [TagRepresentable]) -> [Tag] {
        components.compactMap{ $0 }.map{ $0.build() }
    }
}

public protocol TagRepresentable {
    func build() -> Tag
}

public protocol GenericTagRepresentable {
    func build(type: Tag.Type) -> Tag
}
