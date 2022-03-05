//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component {
    
    public private(set) var bsClasses: [BsClass]?
    public private(set) var styles: [CssProperty : String]?
}

/// These functions mimic Tag so they read the same when mixed together
extension Component {
    
    // MARK: - Classes
    
    @discardableResult
    public func `class`(_ classes: BsClass..., if condition: Bool = true) -> Self {
        self.class(classes, condition)
    }
    
    @discardableResult
    public func `class`(_ classes: [BsClass]?, _ condition: Bool = true) -> Self {
        if condition, let classes = classes {
            self.bsClasses = classes
        }
        return self
    }

    @discardableResult
    public func `class`(add classes: BsClass..., if condition: Bool = true) -> Self {
        self.class(add: classes)
    }

    @discardableResult
    public func `class`(add classes: [BsClass]?, _ condition: Bool = true) -> Self {
        if condition, let classes = classes {
            self.bsClasses = (self.bsClasses != nil) ? self.bsClasses! + classes : classes
        }
        return self
    }
    
    // MARK: Styles
    
    @discardableResult
    public func style(_ styles: (CssProperty, String)..., if condition: Bool = true) -> Self {
        style(styles, condition)
    }
    
    @discardableResult
    public func style(_ styles: [(CssProperty, String)]?, _ condition: Bool = true) -> Self {
        guard condition, let styles = styles else { return self }
        if self.styles == nil { self.styles = [CssProperty : String]() }
        _ = styles.map{ self.styles![$0.0] = $0.1 }
        return self
    }
}
