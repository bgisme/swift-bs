//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component {
    
    public typealias Class = BsClass
    public typealias Classes = [Class]
    public typealias Attributes = [Attribute]
    public typealias Style = CssKeyValue
    public typealias Styles = [Style]
    public typealias Condition = Bool

    public private(set) var classes: Classes?
    public private(set) var attributes: Attributes?
    public private(set) var styles: Styles?
    public private(set) var children: () -> [Tag]
    
    public convenience init() {
        self.init {}
    }
    
    public init(@TagBuilder _ children: @escaping () -> [Tag]) {
        self.children = children
    }
    
    /// for declaring children after a series of function calls
    @discardableResult
    public func children(@TagBuilder _ children: @escaping () -> [Tag]) -> Self {
        self.children = children
        return self
    }
}

/// These functions mimic Tag so they read the same when mixed together
extension Component {
    
    // MARK: - Classes
    
    @discardableResult
    public func `class`(_ classes: Class..., if condition: Bool = true) -> Self {
        self.class(classes, condition)
    }
    
    @discardableResult
    public func `class`(_ classes: [Class]?, _ condition: Bool = true) -> Self {
        if condition, let classes = classes {
            self.classes = classes
        }
        return self
    }

    @discardableResult
    public func `class`(add classes: Class..., if condition: Bool = true) -> Self {
        self.class(add: classes)
    }

    @discardableResult
    public func `class`(add classes: Classes?, _ condition: Bool = true) -> Self {
        if condition, let classes = classes {
            self.classes = (self.classes != nil) ? self.classes! + classes : classes
        }
        return self
    }
    
    // MARK: - Attributes
    
    /// set attributes
    @discardableResult
    public func setAttributes(_ attributes: [Attribute], _ condition: Bool = true) -> Self {
        if condition {
            self.attributes = attributes
        }
        return self
    }
    
    /// delete an attribute by a given key
    @discardableResult
    public func deleteAttribute(_ key: String, _ condition: Bool = true) -> Self {
        if condition {
            self.attributes = self.attributes?.filter { $0.key != key }
        }
        return self
    }
    
    /// add a new attribute with a given value if the condition is true
    @discardableResult
    public func attribute(_ key: String, _ value: String?, _ condition: Bool = true) -> Self {
        if condition, let value = value, condition {
            if var existing = attributes?.first(where: {$0.key == key} ) {
                existing.value = value
            }
        }
        return self
    }
    
    @discardableResult
    public func `id`(_ value: String) -> Self {
        attribute("id", value)
    }
    
    // MARK: - Styles
    
    @discardableResult
    public func setStyles(_ styles: Component.Styles?, _ condition: Bool = true) -> Self {
        if condition, let styles = styles {
            self.styles = styles
        }
        return self
    }
    
    @discardableResult
    public func style(add style: Component.Style?, _ condition: Bool = true) -> Self {
        guard condition, let style = style else { return self }
        self.styles = (self.styles != nil) ? self.styles! + [style] : [style]
        return self
    }
    
    // MARK: - Children
    
    @discardableResult
    public func setChildren(@TagBuilder _ children: @escaping () -> [Tag]) -> Self {
        self.children = children
        return self
    }
}

extension Tag {
    
    /// For quickly applying all the Bootstrap values to the class, style and other attributes
    @discardableResult
    public func add(_ classes: Component.Classes?,
                    _ attributes: Component.Attributes?,
                    _ styles: Component.Styles?) -> Self {
        _ = self.class(add: classes)
        _ = attributes?.map{ self.attribute($0.key, $0.value) }
        _ = styles?.map{ self.style(add: $0) }
        return self
    }
}
