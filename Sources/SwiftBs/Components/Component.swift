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
    public func build() -> Tag {
        tag
    }

    @discardableResult
    public func background(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.backgroundClass, if: condition)
        return self
    }
    
    @discardableResult
    public func border(_ value: ColorTheme?, _ condition: Bool = true) -> Self {
        self.class(insert: value?.borderClass, if: condition)
    }
}

extension Component: Bootstrapable {
    
    @discardableResult
    public func `class`(insert classes: BsClass?..., if condition: Bool = true) -> Self {
        self.class(insert: classes.compactMap{ $0 }, condition)
    }
    
    @discardableResult
    public func `class`(insert classes: [BsClass]?, _ condition: Bool = true) -> Self {
        tag.class(insert: classes, condition)
        return self
    }
    
    @discardableResult
    public func style(set styles: CssKeyValue?..., if condition: Bool = true) -> Self {
        self.style(set: styles.compactMap{ $0 }, condition)
    }
    
    @discardableResult
    public func style(set styles: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        tag.style(set: styles, condition)
        return self
    }
}
