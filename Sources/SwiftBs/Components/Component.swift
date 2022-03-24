//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

/*
 
 Component is the base class for all other components.
 
 It is essentially a wrapper for Tag classes.
 
 It contains a Tag.
 
 It facilitates editing the class and style attributes.
 
 And it renders with TagBuilder.
 
 In simple components it just wraps a Tag, applying Bootstrap slugs to the class attribute.
 
 For example:
 
 BsButton { A("Title").href("#") }
 
 ...adds "btn" to the class and sets a few other attributes.
 
 In more complex components, where the component is always a Div or a Nav, for instance, the Tag is declared internally to save extra lines and indentations. And to avoid function name ambiguity.

 */

import SwiftHtml

public class Component: TagRepresentable {
    
    public let tag: Tag
    
    public init(_ tag: Tag) {
        self.tag = tag
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
