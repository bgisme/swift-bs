//
//  Tag+Style.swift
//  
//
//  Created by BG on 2/19/22.
//

import SwiftHtml

extension Tag {
    
    /// Set value of <style> attribute with variadic (cleaner code)
    @discardableResult
    public func style(_ keyValues: CssKeyValue..., if condition: Bool = true) -> Self {
        style(keyValues, condition)
    }
    
    /// Set vale of <style> attribute with Array
    @discardableResult
    public func style(_ keyValues: [CssKeyValue], _ condition: Bool = true) -> Self {
        return style(keyValues.map{ String($0) }.joined())
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
        if let styleValue = styleAttributeValue() {
            attribute("style", styleValue + keyValueStr)
            return self
        }
        return attribute("style", keyValueStr)
    }
    
    /// Remove key:value pair from value of <style> attribute using CssProperty
    @discardableResult
    public func style(remove key: CssProperty, _ condition: Bool = true) -> Self {
        style(remove: key.rawValue, condition)
    }
    
    /// Remove key:value pair from value of <style> attribute using String
    @discardableResult
    public func style(remove key: String, _ condition: Bool = true) -> Self {
        guard condition else { return self }
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
