//
//  Tag+Class+Style.swift
//  
//
//  Created by BG on 2/17/22.
//

/*
 
    Everything in this extension just makes declaring Bootstrap with SwiftHtml more expressive.
 
    Use these functions with the BsClass and BsAttribute enums.
 
    And writing html for Bootstrap should be more readable. See package README.md for examples.
 
    Many of the 'class' functions may look redundant, taking a variadic parameter followed by an Array. The variadics make the code look cleaner, without having to use '[]' everywhere. But until Swift supports splatting, combining variadics and arrays constantly requires extra lines to combine. So that is handled by the variations.

 */

import SwiftHtml

extension Tag {
    
    // MARK: - <class> and <style>
    
    public func addClassesStyles(_ component: Component) -> Self {
        self.class(add: component.classes)
        return self.style(add: component.styles)
    }
    
    // MARK: - <class>

    /// Replace value of class attribute with variadic Component.Class
    public func `class`(_ classes: BsClass?..., if condition: Bool = true) -> Self {
        guard condition else { return self }
        return self.class(classes.compactMap({$0}))
    }

    /// Replace value of class attribute with array of Component.Class
    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard let classes = classes, condition else { return self }
        return self.class(classes.map {$0.rawValue})
    }
    
    /// Add variadics to value of class attribute
    @discardableResult
    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
        guard condition else { return self }
        return self.class(add: classes.compactMap({$0}))
    }
    
    /// Add to value of class attribute
    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard let classes = classes, condition else { return self }
        return self.class(add: classes.map{$0.rawValue})
    }
    
    // MARK: - <style>
    
    /// Set value of <style> attribute with variadic (cleaner code)
    @discardableResult
    public func style(_ keyValues: CssKeyValue..., if condition: Bool = true) -> Self {
        style(keyValues, condition)
    }
    
    /// Set vale of <style> attribute with Array
    @discardableResult
    public func style(_ keyValues: [CssKeyValue], _ condition: Bool = true) -> Self {
        return style(keyValues.map{ String($0) }.joined(separator: ";"))
    }
    
    /// Add optional to value of <style> attribute
    @discardableResult
    public func style(add keyValue: CssKeyValue?, _ condition: Bool = true) -> Self {
        guard condition, let keyValue = keyValue else { return self }
        return style(add: [keyValue], condition)
    }
    
    /// Add variadic to value of <style> attribute (cleaner code)
    @discardableResult
    public func style(add keyValues: CssKeyValue..., if condition: Bool = true) -> Self {
        return style(add: keyValues, condition)
    }
    
    /// Add array to value of <style> attribute
    @discardableResult
    public func style(add keyValues: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        guard condition, let keyValues = keyValues else { return self }
        let keyValueStr = keyValues.map{ String($0) }.joined()
        return self.style(add: keyValueStr)
    }
    
    @discardableResult
    public func style(add dict: [String : String]?, _ condition: Bool = true) -> Self {
        guard condition, let dict = dict else { return self }
        let keyValueStr = dict.map { "\($0.0):\($0.1);"}.joined()
        return self.style(keyValueStr)
    }
    
    /// Append string to value of <style> attribute
    @discardableResult
    public func style(add str: String?, _ condition: Bool = true) -> Self {
        guard condition, let str = str else { return self }
        let updated = self.styleAttributeValue() != nil ? self.styleAttributeValue()! + str : str
        return self.style(updated)
    }
    
    /// Remove key:value pair from value of <style> attribute using CssProperty
    @discardableResult
    public func style(remove key: CssProperty, _ condition: Bool = true) -> Self {
        style(remove: key.rawValue, condition)
    }
    
    /// Remove key:value pair from value of <style> attribute using String
    @discardableResult
    public func style(remove key: String, _ condition: Bool = true) -> Self {
        guard condition, !key.isEmpty else { return self }
        if let styleValue = styleAttributeValue() {
            let keyValues = styleValue.split(separator: ";")
            let newKeyValues = keyValues.filter {
                // component key is everything up to first colon
                // do not return if it's less than whole string and matches supplied key
                if let colonIndex = $0.firstIndex(of: ":"),
                   colonIndex != $0.endIndex {
                     return $0[..<colonIndex] != key
                }
                return true
            }.joined(separator: ";")
            if !newKeyValues.isEmpty {
                _ = style(newKeyValues)
            } else {
                deleteAttribute("style")
            }
        }
        return self
    }

    // MARK - Private Utilities
    
    /// Retrieve the <style> attribute if it exists
    private func styleAttributeValue() -> String? {
        node.attributes.first(where: { $0.key == "style" })?.value
    }

 }
