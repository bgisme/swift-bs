//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component {
    
//    public internal(set) var classes: [BsClass]?
//    public internal(set) var styles: [CssKeyValue]?
    public internal(set) var attributes: [Attribute]?
}

/// These functions mimic Tag so they read the same when mixed together
//extension Component {
    
//    // MARK: - Classes
//
//    @discardableResult
//    public func `class`(_ classes: BsClass?..., if condition: Bool = true) -> Self {
//        let classes = classes.compactMap { $0 }
//        guard condition, !classes.isEmpty else { return self }
//        return self.class(classes, condition)
//    }
//
//    @discardableResult
//    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
//        guard condition, let classes = classes else { return self }
//        self.classes = classes
//        return self
//    }
//
//    @discardableResult
//    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
//        let classes = classes.compactMap {$0}
//        guard condition, !classes.isEmpty else { return self }
//        return self.class(add: classes)
//    }
//
//    @discardableResult
//    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
//        guard condition, let classes = classes else { return self }
//        self.classes = (self.classes != nil) ? self.classes! + classes : classes
//        return self
//    }
//
//    // MARK: Styles
//
//    @discardableResult
//    public func style(_ styles: CssKeyValue?..., if condition: Bool = true) -> Self {
//        let styles = styles.compactMap { $0 }
//        guard condition, !styles.isEmpty else { return self }
//        return self.style(styles, condition)
//    }
//
//    @discardableResult
//    public func style(_ styles: [CssKeyValue]?, _ condition: Bool = true) -> Self {
//        guard condition, let styles = styles, !styles.isEmpty else { return self }
//        if self.styles == nil { self.styles = [:] }
//        _ = styles.map { self.styles?[$0.key] = $0.value }
//        return self
//    }
//}

extension Component: Attributable {
    
    public func value(_ key: AttributeKey) -> String? {
        attributes?.first(where: { $0.key == key.rawValue })?.value
    }
    
    @discardableResult
    public func attribute(_ key: AttributeKey, _ value: String?) -> Self {
        self.delete(key)
        let attribute = Attribute(key: key.rawValue, value: value)
        self.attributes = self.attributes != nil ? self.attributes! + [attribute] : [attribute]
        return self
    }
        
    @discardableResult
    public func delete(_ key: AttributeKey) -> Self {
        guard let attributes = self.attributes else { return self }
        self.attributes = attributes.filter{ $0.key != key.rawValue }
        return self
    }
}

extension Component: AttributeValuable {
    
    @discardableResult
    public func attr(_ key: AttributeKey, _ value: String?, _ condition: Bool = true) -> Self {
        guard condition, let value = value else { return self }
        return attribute(key, value)
    }

    @discardableResult
    public func attr(_ key: AttributeKey, _ value: Bool?, _ condition: Bool = true) -> Self {
        guard condition, let value = value else { return self }
        return attribute(key, String(value))
    }

    @discardableResult
    public func attrFlag(_ key: AttributeKey, _ condition: Bool = true) -> Self {
        guard condition else { return self }
        return attribute(key, nil)
    }

    @discardableResult
    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
        self.class(add: classes.compactMap{ $0 }, condition)
    }

    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard condition, let classes = classes, !classes.isEmpty else { return self }
        let value: String
        if let existing = self.value(.class) {
            value = existing.add(classes)
        } else {
            value = String.classValue(classes)
        }
        return attribute(.class, value)
    }

    @discardableResult
    public func style(add styles: CssKeyValue?..., if condition: Bool = true) -> Self {
        self.style(add: styles.compactMap{ $0 }, condition)
    }

    @discardableResult
    public func style(add styles: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        style(add: styles?.map{ ($0.key, $0.value) }, condition)
    }
    
    @discardableResult
    public func style(add styles: [(Key, Value)]?, _ condition: Bool = true) -> Self {
        guard condition, let styles = styles, !styles.isEmpty else { return self }
        let new: String
        if let value = value(.style) {
            new = value.add(styles)
        } else {
            new = String.styleValue(styles)
        }
        return attribute(.style, new)
    }
}
