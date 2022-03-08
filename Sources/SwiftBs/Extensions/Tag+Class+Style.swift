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
    
    /// Add Component classes and styles to <class> and <style>
    public func addClassesStyles(_ component: Component) -> Self {
        self.class(add: component.classes)
        if let styles = component.styles {
            let keyValueStr = styles.map { "\($0.0):\($0.1);"}.joined()
            return self.style(add: keyValueStr)
        }
        return self
    }
    
    // MARK: - <class>

    /// Replace value of <class> with variadic BsClass
    public func `class`(_ classes: BsClass?..., if condition: Bool = true) -> Self {
        let classes = classes.compactMap { $0 }
        guard !classes.isEmpty else { return self }
        return self.class(classes)
    }

    /// Replace value of <class> with array of BsClass
    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard let classes = classes, !classes.isEmpty else { return self }
        return self.class(classes.map {$0.rawValue})
    }
    
    /// Add variadics of BsClass to <class>
    @discardableResult
    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
        let classes = classes.compactMap { $0 }
        guard !classes.isEmpty else { return self }
        return self.class(add: classes)
    }
    
    /// Add array of BsClass to <class> value
    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        guard let classes = classes, !classes.isEmpty else { return self }
        return self.class(add: classes.map{$0.rawValue})
    }
    
    // MARK: - <style>
    
    /// Set value of <style> attribute with variadic (cleaner code)
    @discardableResult
    public func style(_ keyValues: CssKeyValue?..., if condition: Bool = true) -> Self {
        let keyValues = keyValues.compactMap { $0 }
        guard !keyValues.isEmpty else { return self }
        return style(keyValues, condition)
    }
    
    /// Set vale of <style> attribute with Array
    @discardableResult
    public func style(_ keyValues: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        guard let keyValues = keyValues, !keyValues.isEmpty else { return self }
        return style(keyValues.map{ String($0) }.joined(separator: ";"))
    }
    
    /// Add CssKeyValue variadic to <style> attribute
    @discardableResult
    public func style(add keyValues: CssKeyValue?..., if condition: Bool = true) -> Self {
        let keyValues = keyValues.compactMap { $0 }
        guard !keyValues.isEmpty else { return self }
        return style(add: keyValues, condition)
    }
    
    /// Add array of  CssKeyValue to <style> attribute
    @discardableResult
    public func style(add keyValues: [CssKeyValue]?, _ condition: Bool = true) -> Self {
        guard let keyValues = keyValues, !keyValues.isEmpty else { return self }
        let keyValueStr = keyValues.map{ String($0) }.joined()
        return self.style(add: keyValueStr)
    }
    
    /// Append string to value of <style> attribute
    @discardableResult
    public func style(add str: String?, _ condition: Bool = true) -> Self {
        guard let str = str, !str.isEmpty else { return self }
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
