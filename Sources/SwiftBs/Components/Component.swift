//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component: TagRepresentable {
    
    let tag: Tag
    
    public init(@TagBuilder _ tag: () -> Tag) {
        self.tag = tag()
    }

    @TagBuilder
    @discardableResult
    public func build() -> Tag {
        tag
    }
}

extension Component: Bootstrapable {
    
    @discardableResult
    public func `class`(insert classes: BsClass..., if condition: Bool = true) -> Self {
        self.class(insert: classes, condition)
    }
    
    @discardableResult
    public func `class`(insert classes: [BsClass], _ condition: Bool = true) -> Self {
        tag.class(insert: classes, condition)
        return self
    }
    
    @discardableResult
    public func style(set styles: CssKeyValue..., if condition: Bool = true) -> Self {
        self.style(set: styles, condition)
    }
    
    @discardableResult
    public func style(set styles: [CssKeyValue], _ condition: Bool = true) -> Self {
        tag.style(set: styles, condition)
        return self
    }
}
