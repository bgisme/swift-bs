//
//  Component.swift
//
//
//  Created by BG on 2/15/22.
//

import SwiftHtml

public class Component {
    
    public private(set) var children: () -> [Tag]
    public private(set) var bsClasses: [BsClass]?
    
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
}
