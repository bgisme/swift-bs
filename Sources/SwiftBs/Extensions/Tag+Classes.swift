//
//  Tag+Bs.swift
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
    
    // MARK: - Class

    /// Replace value of class attribute with variadic Component.Class
    public func `class`(_ classes: BsClass..., if condition: Bool = true) -> Self {
        self.class(classes, condition)
    }

    /// Replace value of class attribute with array of Component.Class
    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
        if let classes = classes {
            return self.class(classes.map {$0.rawValue}, condition)
        }
        return self
    }
    
    /// Add variadics to value of class attribute
    @discardableResult
    public func `class`(add classes: BsClass?..., if condition: Bool = true) -> Self {
        self.class(add: classes.compactMap({$0}), condition)
    }
    
    /// Add to value of class attribute
    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        if let classes = classes {
            return self.class(add: classes.map{$0.rawValue}, condition)
        }
        return self
    }
    
 }
